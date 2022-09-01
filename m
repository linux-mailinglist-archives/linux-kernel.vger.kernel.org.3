Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287725A921E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbiIAIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiIAIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:32:03 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844B612AE1D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:32:01 -0700 (PDT)
Received: from [192.168.210.80] (unknown [182.2.39.249])
        by gnuweeb.org (Postfix) with ESMTPSA id 961C180866;
        Thu,  1 Sep 2022 08:31:55 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662021120;
        bh=LXF7eI1yQrVMaWbZtpBHxTo7k3XXXY6ySsuxRufruxM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ew1QCZi4NfHMRE9AnbMQwpAvstecLGWlhjLF1hrJSpUchJiYL8rzkOaW8smMlbTzG
         JRTBh9QsO1i0RmCJfpF/dvTm0EFohIDngpNRRISHO+0+cezcpMsHoaSOaItBX3EM38
         vT8juBXaJcsX10uN+vISwVCMnUpYNBcC/o3XoyD1pTZQym2P+Zft1FvxKFvcAGO//4
         EKgYgOXz42liZ34IIMOeI+hg3WrqU1wX5WSP+ziP8JAt+lE234SM5SE1B9E8taYmQv
         BUZytEOuH/EDPdoVZ/pqI3h1XcUDI+q8iGJZzeXMXNrzz6sO+KhClCdMlFmtt3HVWy
         DSyT/lCnI9FWA==
Message-ID: <3c69f09e-1e34-73f9-b38b-733971ef38cb@gnuweeb.org>
Date:   Thu, 1 Sep 2022 15:31:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] mm,page_owner: Filter out stacks by a threshold
 counter
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-4-osalvador@suse.de>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <20220901044249.4624-4-osalvador@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 11:42 AM, Oscar Salvador wrote:> +static ssize_t read_page_owner_threshold(struct file *file, char __user *buf,
> +					 size_t count, loff_t *pos)
> +{
> +	char *kbuf;
> +	int ret = 0;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +
> +	if (*pos >= count)
> +		return 0;
> +
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return ENOMEM;

Missing a negative sign, return -ENOMEM.

> +	ret = scnprintf(kbuf, count, "%lu\n", threshold_count);
> +	if (copy_to_user(buf, kbuf, ret))
> +		ret = -EFAULT;
> +
> +	*pos += count;
> +	kfree(kbuf);
> +
> +	return ret;
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

This looks overestimating to me. For unsigned long, on a 64-bit system
has max val 18446744073709551615 (20 chars).

You can use stack a allocated local variable with length 21. No need
to use kmalloc(). The same way with the read() op.

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
> +	ret = kstrtoul(kbuf, 10, &threshold_count);
> +
> +out:
> +	kfree(kbuf);
> +	return ret ? ret : count;
> +}
> +
> +static const struct file_operations proc_page_owner_threshold = {
> +	.read = read_page_owner_threshold,
> +	.write = write_page_owner_threshold,
> +};

-- 
Ammar Faizi
