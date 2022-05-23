Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63662531CB9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiEWUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiEWUuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:50:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551B7093A;
        Mon, 23 May 2022 13:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=MWvG6nn3a+gK5OQ89UpHcVMgSWbGiApDZs43xBQyuAQ=; b=jZ5RgpQGKwUBBbA0ZdHQ3ge2qv
        JhwcNDKoPemRk3s77IzW6EO20sjiH1DhUcQ13atArXRcjCq0UM02GOejd3Q5xBsgEugT/I+hhy26g
        4Kp9xy0YpjBsbEAuJddwANSqj37eNk6MehElmYHZpY+r2ZMG1vaI7/wkpjX3+xH/NYxJmJIondBxy
        +L7c2izCVNz9zitq/KvvNVVHICfXgJqfGbyRzpjzJ7bubMHZhDrfYYFQCgURue0HEBat23MdvOREc
        3z+1BAGrSOmTcM4wcSbOnvWlt1BKGcar/IW/Rcxxp0HY1QQwDxgmUoJQtCuEiZZ0jCSqL0x6HUy2v
        oOGiBiMw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntEzs-00GXI2-R3; Mon, 23 May 2022 20:49:49 +0000
Message-ID: <f99153be-2636-60a3-2630-c592cc230b53@infradead.org>
Date:   Mon, 23 May 2022 13:49:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC 2/6] PM: Hibernate: Add option to disable disk offset
 randomization
Content-Language: en-US
To:     Vivek Kumar <quic_vivekuma@quicinc.com>, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        maz@kernel.org, axboe@kernel.dk, rafael@kernel.org,
        akpm@linux-foundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     len.brown@intel.com, pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        damien.lemoal@opensource.wdc.com, pasha.tatashin@soleen.com,
        tabba@google.com, ardb@kernel.org, tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_svaddagi@quicinc.com,
        Prasanna Kumar <quic_kprasan@quicinc.com>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
 <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1652860121-24092-3-git-send-email-quic_vivekuma@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/22 00:48, Vivek Kumar wrote:
> Add a kernel parameter to disable the disk offset randomization
> for SSD devices in which such feature is available at the
> firmware level. This is helpful in improving hibernation
> resume time.
> 
> Signed-off-by: Vivek Kumar <quic_vivekuma@quicinc.com>
> Signed-off-by: Prasanna Kumar <quic_kprasan@quicinc.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
>  kernel/power/swap.c                             |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 666ade9..06b4f10 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5192,6 +5192,17 @@
>  			Useful for devices that are detected asynchronously
>  			(e.g. USB and MMC devices).
>  
> +	noswap_randomize
> +			Kernel uses random disk offsets to help with wear-levelling

			                                             wear-leveling

> +			of SSD devices, while saving the hibernation snapshot image to
> +			disk. Use this parameter to disable this feature for SSD
> +			devices in scenarios when, such randomization is addressed at

			               no comma  ^

> +			the firmware level and hibenration image is not re-generated

			                       hibernation

> +			frequently.
> +			(Useful for improving hibernation resume time as snapshot pages
> +			are available in disk serially and can be read in bigger chunks
> +			without seeking)
> +
>  	retain_initrd	[RAM] Keep initrd memory after extraction
>  
>  	rfkill.default_state=


-- 
~Randy
