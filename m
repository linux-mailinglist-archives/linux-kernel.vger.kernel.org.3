Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AEA5A91E6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiIAIRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiIAIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:16:59 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF7CC9E8D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:16:54 -0700 (PDT)
Received: from [192.168.210.80] (unknown [182.2.39.249])
        by gnuweeb.org (Postfix) with ESMTPSA id E4CB880866;
        Thu,  1 Sep 2022 08:16:48 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1662020213;
        bh=lq7B7oslVdIFiKkrtZ+qbc4fMNOk/JK8jrKwVYgHXPA=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=JNpAuVJ5a6I0m+tL/+XHuHKTzItsLB+ceDJbHSItVsXP9EsqQmDwuJYhOvdaVswvB
         w0CT9IqSEsd8UB92uuaWDVJmV9vAV2CzDGSSgrdftCyysK0yqBrVhLtkK+u+WruiXS
         q1jzDD20kX1K7oxyYPIouYw9X/J1o6Y2PHtWlhOaWZnOgYB7hGLH3vXiW/HepViXx3
         W4cCpoXMWUoWCTsEODYNb9fraO6elr7AIJON+RGJK3NZYNbnEvFRGuIJxzMIz/WUt7
         Gh2Dpo4l0xmv8b7KkP8gwwAmdsb5b56iWv13mBPxfe+iq8nbbctsM9OHoSYSx8dmsz
         GEhU22TS/WgRw==
Message-ID: <9f2ef1ac-c0a1-eb77-8e68-e9a60bc8efd2@gnuweeb.org>
Date:   Thu, 1 Sep 2022 15:16:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ammar Faizi <ammarfaizi2@gmail.com>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-3-osalvador@suse.de>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH 2/3] mm, page_owner: Add page_owner_stacks file to print
 out only stacks and their counter
In-Reply-To: <20220901044249.4624-3-osalvador@suse.de>
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

On 9/1/22 11:42 AM, Oscar Salvador wrote:
> +static unsigned long last_stack = 0;

This @last_stack can just be a static local variable in the new
function you wrote, read_page_owner_stacks(), since no other
functions use it.

> +static ssize_t read_page_owner_stacks(struct file *file, char __user *buf,
> +				      size_t count, loff_t *pos)
> +{
> +	char *kbuf;
> +	int ret = 0;
> +
> +	count = min_t(size_t, count, PAGE_SIZE);
> +	kbuf = kmalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return ENOMEM;

Missing a negative sign, return -ENOMEM;

> +	ret += stack_depot_print_stacks_threshold(kbuf, count, pos, &last_stack);
> +	if (copy_to_user(buf, kbuf, ret))
> +		ret = -EFAULT;
> +
> +	if (!ret)
> +		last_stack = 0;
> +
> +	kfree(kbuf);
> +	return ret;
> +}

-- 
Ammar Faizi
