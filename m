Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F28A35AD0D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiIEKwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIEKvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:51:54 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC14E625
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 03:51:52 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.42.181])
        by gnuweeb.org (Postfix) with ESMTPSA id 4D71C804D1;
        Mon,  5 Sep 2022 10:51:47 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662375111;
        bh=c9zeHPFx76P0oLkPbZmlW5hML9U+k3vaPD6cjMJ/lpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCir+0wH/YIfJUt8VqCmGvtKYo5+Mny+OxFeEHP3YszeSd5OgbwXTfyJ7HwbI5ouc
         RsX0MXSkY1w0ZdwQXdPwc0HMKg4+J4UWYeRcZjR7qk5x87WQUNmdGjM/lqLCfsJ9Rd
         AO0RUOGOfNmM8felbyyR+n7g7n4nTfK/Fyx98GpBK5GcD6Xma1Ak2r7VDtrzpu1s/j
         VI6mI+p7U+wAVsXJtIVWIiaEldFWqaoBlHM/P2ZHeKiyXjQZzXS/FEXJjlCS7QwALV
         WHUqHMcZS5vK/fAy0kpph/95q45xWJwXKxlKzMuUOi7ELUP2a2dICM5wwnkZb4e3+i
         scDzCTRRT6uhg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management Mailing List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Mon,  5 Sep 2022 17:51:37 +0700
Message-Id: <573c4049045a5ff342ff9998c69dfae7-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905031012.4450-4-osalvador@suse.de>
References: <20220905031012.4450-1-osalvador@suse.de>, <20220905031012.4450-4-osalvador@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SORBS_WEB,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 05:10:12 +0200, Oscar Salvador wrote:
> +static int page_owner_threshold_show(struct seq_file *p, void *v)
> +{
> +	 seq_printf(p, "%lu\n", threshold);

Remove a slipped leading 0x20 space here (before seq_printf()).

> +	return 0;
> +}
> +
> +static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> +					  size_t count, loff_t *pos)
> +{
> +	char *kbuf;
> +	int ret = 0;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(kbuf, buf, count)) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +	kbuf[count - 1] = '\0';
> +
> +	ret = kstrtoul(kbuf, 10, &threshold);
> +
> +out:
> +	kfree(kbuf);
> +	return ret ? ret : count;
> +}

Still the same comment on this, kmalloc() is not really needed here.
Capping the size to PAGE_SIZE (usually 4K) is too big. `unsinged long`
is 64-bit at most, this means the max val is 18446744073709551615
(20 chars). The lifetime of @kbuf is very short as well, using a stack
allocated array of chars is fine?

Untested:

static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
					  size_t count, loff_t *pos)
{
	char kbuf[21];
	int ret;

	count = min_t(size_t, count, sizeof(kbuf));
	if (copy_from_user(kbuf, buf, count))
		return -EFAULT;

	kbuf[count - 1] = '\0';
	ret = kstrtoul(kbuf, 10, &threshold);
	return ret ? ret : count;
}

-- 
Ammar Faizi

