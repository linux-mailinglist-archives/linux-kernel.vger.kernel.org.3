Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16904CD7ED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240376AbiCDPfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbiCDPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:35:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C547E1C60D1;
        Fri,  4 Mar 2022 07:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ubLlEfmdj3+lValUSSewOjSLCKn7kcAuaUUkJai8gxc=; b=Zk/phiCwCX9G3kDNmxco1uesZd
        TvJDDNOl920cxwrzer0hKvEe2Ydls/uVorr5Ivsj1CgM7/leWb/aSoR3RFRx5ih8LTcRa6DifQMJh
        ywxZknnLh9j2FqFJPbO6SPakFRow4DUnH/fffwsfGcb4Ftv1pdpVdNHcvL3Muo9hwKkM7T6KsXdEZ
        PSeI+JKPtKNwHvIITvBN4fL5B8EZNWGCMk9JMXtgAV4HYRyHlbJrr7SRyL0cH76FzytoRvNmsEWQx
        Vev0D3Xeh9WOtQcHn2YLqNrR/3dYjuvKRbUkdhvFhd5dtrdUGOQuL5Tf2gxiX8eb1bd5eAHl9D5zA
        34WnwBHA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ9x9-00CkLw-Jd; Fri, 04 Mar 2022 15:34:47 +0000
Message-ID: <05328af0-9b08-8de3-e88a-06f67758c197@infradead.org>
Date:   Fri, 4 Mar 2022 07:34:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
References: <20220304011328.27459-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2203040857500.47558@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2203040857500.47558@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/22 01:07, Maciej W. Rozycki wrote:
> On Thu, 3 Mar 2022, Randy Dunlap wrote:
> 
>> Include the DECstation interrupt handler in opting out of
>> FPU support.
>>
>> Fixes a linker error:
>>
>> mips-linux-ld: arch/mips/dec/int-handler.o: in function `fpu':
>> (.text+0x148): undefined reference to `handle_fpe_int'
>>
>> Fixes: 183b40f992c8 ("MIPS: Allow FP support to be disabled")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Paul Burton <paulburton@kernel.org>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
>> Cc: linux-mips@vger.kernel.org
>> ---
>> This builds OK. Is it enough for runtime interrupt handling?
> 
>  There's:
> 
> #ifdef CONFIG_32BIT
> 	lw	t2,cpu_fpu_mask
> #endif
> 
> earlier on that needs to go too, and code in arch/mips/dec/setup.c below:
> 
> 	/* Register board interrupts: FPU and cascade. */
> 
> (we don't want an unhandled interrupt unmasked).  Are you happy to do such 
> an update or shall I?
> 
>  I cannot verify that change at run time, because any program that does FP 
> will then crash.  Maybe init(8) and sulogin(8) won't.  I can check that.
> 
>  Thanks for doing this stuff!

I'll update the patch and send v2.

thanks.

-- 
~Randy
