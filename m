Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F548E37B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 06:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiANFMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 00:12:08 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42966 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbiANFMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 00:12:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V1nM0GD_1642137124;
Received: from 30.240.98.235(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0V1nM0GD_1642137124)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 13:12:05 +0800
Message-ID: <a934394d-8363-6c40-57a0-413b236d32e4@linux.alibaba.com>
Date:   Fri, 14 Jan 2022 13:12:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: linux-next: build failure after merge of the ftrace tree
To:     Steven Rostedt <rostedt@goodmis.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220112113103.7e03448f@canb.auug.org.au>
 <20220114120240.4b592480@canb.auug.org.au>
 <20220113211633.4f9bea57@gandalf.local.home>
 <20220114135808.391398d0@canb.auug.org.au>
 <20220114140258.2fe2f076@canb.auug.org.au>
 <20220113222539.30202e01@rorschach.local.home>
 <20220114143418.06035a75@canb.auug.org.au>
 <20220113225048.17d4d9b7@rorschach.local.home>
From:   Yinan Liu <yinan@linux.alibaba.com>
In-Reply-To: <20220113225048.17d4d9b7@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, steven

When sorttable is executed, system.map is queried, so the creation
of system.map is moved forward. Did that make a difference?

在 2022/1/14 上午11:50, Steven Rostedt 写道:
> On Fri, 14 Jan 2022 14:34:18 +1100
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>>> Does it fail on anything else?
>>
>> This is the first build I do after merging each tree, so I don't know
>> about others.  I may be able to do some testing later today (after
>> linux-next is released).
> 
> Could you see if this fixes it? This is a revert of part of the patch.
> Yinan, was there a reason you moved this code?
> 
> -- Steve
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index dd9955f45774..5cdd9bc5c385 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -400,9 +400,6 @@ if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
>   	${RESOLVE_BTFIDS} vmlinux
>   fi
>   
> -info SYSMAP System.map
> -mksysmap vmlinux System.map
> -
>   if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>   	info SORTTAB vmlinux
>   	if ! sorttable vmlinux; then
> @@ -411,6 +408,9 @@ if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
>   	fi
>   fi
>   
> +info SYSMAP System.map
> +mksysmap vmlinux System.map
> +
>   # step a (see comment above)
>   if [ -n "${CONFIG_KALLSYMS}" ]; then
>   	mksysmap ${kallsyms_vmlinux} .tmp_System.map
