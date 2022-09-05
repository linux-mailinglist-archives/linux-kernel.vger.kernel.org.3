Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E05AD1F1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiIELzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbiIELzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:55:21 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A1427170
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:55:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [182.2.42.181])
        by gnuweeb.org (Postfix) with ESMTPSA id 74AE6804FD;
        Mon,  5 Sep 2022 11:55:14 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662378919;
        bh=Ax3MC0XcIkDxhT39fYMzcJEvWVrtUjw9z/eRM8QtIpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqGZ4l+n16P9GGgKdRmQ+7QjZtwOHRXaFmjP6vP56fRD5aQ5OIxt+/xJhYLW3/Eb0
         ilhOBVxCX+Sm4+ovQR7UKqg8+bMEQlw50dw3JSAfBJSsdvyiSuXJdsJ49moyTWqBl3
         RHaE8u5fyGbUOM4aFwzj1BdQ5wg35RpuwDNwG3Cf5wBEDl58CzEWKUbyKNjdJs4xmb
         pAzxAd9tRDMrkFpd/rCoWsK0DFQq+dxxAdIdfNn9t+72ZIa8AEJaaPNHG7hV0RWpyV
         2+Dk97CrgJBIghgfjlv/KK5B5mOT2gPbDmq5L6jT5yJnBnZ7iiZienFCBFSsPgK8Ra
         WqCk6vXoTCzRQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management Mailing List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 3/3] mm,page_owner: Filter out stacks by a threshold counter
Date:   Mon,  5 Sep 2022 18:54:59 +0700
Message-Id: <20220905115459.567583-1-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YxXd9qXnIutFOQZY@dhcp22.suse.cz>
References: <20220905031012.4450-1-osalvador@suse.de> <20220905031012.4450-4-osalvador@suse.de> <573c4049045a5ff342ff9998c69dfae7-ammarfaizi2@gnuweeb.org> <YxXd9qXnIutFOQZY@dhcp22.suse.cz>
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

On Mon, 5 Sep 2022 13:31:02 +0200, Michal Hocko wrote:
> On Mon 05-09-22 17:51:37, Ammar Faizi wrote:
> > On Mon, 5 Sep 2022 05:10:12 +0200, Oscar Salvador wrote:
> > > +static int page_owner_threshold_show(struct seq_file *p, void *v)
> > > +{
> > > +	 seq_printf(p, "%lu\n", threshold);
> > 
> > Remove a slipped leading 0x20 space here (before seq_printf()).
> > 
> > > +	return 0;
> > > +}
> > > +
> > > +static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> > > +					  size_t count, loff_t *pos)
> > > +{
> > > +	char *kbuf;
> > > +	int ret = 0;
> > > +
> > > +	count = min_t(size_t, count, PAGE_SIZE);
> > > +	kbuf = kmalloc(count, GFP_KERNEL);
> > > +	if (!kbuf)
> > > +		return -ENOMEM;
> > > +
> > > +	if (copy_from_user(kbuf, buf, count)) {
> > > +		ret = -EFAULT;
> > > +		goto out;
> > > +	}
> > > +
> > > +	kbuf[count - 1] = '\0';
> > > +
> > > +	ret = kstrtoul(kbuf, 10, &threshold);
> > > +
> > > +out:
> > > +	kfree(kbuf);
> > > +	return ret ? ret : count;
> > > +}
> > 
> > Still the same comment on this, kmalloc() is not really needed here.
> > Capping the size to PAGE_SIZE (usually 4K) is too big. `unsinged long`
> > is 64-bit at most, this means the max val is 18446744073709551615
> > (20 chars). The lifetime of @kbuf is very short as well, using a stack
> > allocated array of chars is fine?
> > 
> > Untested:
> > 
> > static ssize_t write_page_owner_threshold(struct file *file, const char __user *buf,
> > 					  size_t count, loff_t *pos)
> > {
> > 	char kbuf[21];
> > 	int ret;
> > 
> > 	count = min_t(size_t, count, sizeof(kbuf));
> > 	if (copy_from_user(kbuf, buf, count))
> > 		return -EFAULT;
> > 
> > 	kbuf[count - 1] = '\0';
> > 	ret = kstrtoul(kbuf, 10, &threshold);
> > 	return ret ? ret : count;
> > }
> 
> Isn't there a proc_dointvec counterpart for debugfs?

Ah, well. If that's much simpler, we should go with that. I am not
familiar proc_dointvec() interface, so I couldn't say about it.

Thanks for the comment. TIL.

-- 
Ammar Faizi

