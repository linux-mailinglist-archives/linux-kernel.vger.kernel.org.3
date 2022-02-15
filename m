Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE24B79AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbiBOVOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:14:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiBOVOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:14:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2498771C9F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=AW3+kFqBCuVeSlOqKbaIKUl7wEnUfx5xLlZmgik9f+o=; b=kqfxqqiILWOBSOqG0xYG7VV/HD
        LPrseCDCa5kITdRF7VCF7MUWyuJfRHmIZ+51LBxfX0qJ7UlwFuCqYvkmgvUXyuRPkUav6dqyto0IT
        qukcqSZGiJx0Mt5WeAZ6ooBlFopIYUdKY6evzrOBMYV1diWbG0WPgBWOuvp0OTD/nbdmZCOTFLEpJ
        n9clzwTFd96tVWpxyRhNyLHua6ikc36tC+/q5YfF4AtI8ChTWxxqatcHwtCJb4q1IXDg44FStY42b
        WlFYpVez5XE/9f45fS5GH0U6mNM4yNaUjEOo6CpkzeySF0n46KrR8xEn8IjKgke/3+YYzWUm48hvu
        wjFiHQMg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK595-00ABL8-2D; Tue, 15 Feb 2022 21:13:59 +0000
Message-ID: <6f4af4c2-3ac0-a4d0-96c7-7164417cb8d7@infradead.org>
Date:   Tue, 15 Feb 2022 13:13:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: Build regressions/improvements in v5.17-rc4
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <20220214093704.1773948-1-geert@linux-m68k.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220214093704.1773948-1-geert@linux-m68k.org>
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

Hi Geert,

On 2/14/22 01:37, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.17-rc4[1] compared to v5.16[2].
> 
> Summarized:
>   - build errors: +14/-2
>   - build warnings: +23/-25
> 
> JFYI, when comparing v5.17-rc4[1] to v5.17-rc3[3], the summaries are:
>   - build errors: +1/-0
>   - build warnings: +0/-0
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/754e0b0e35608ed5206d6a67a791563c631cec07/ (all 99 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/df0cc57e057f18e44dac8e6c18aba47ab53202f9/ (98 out of 99 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/dfd42facf1e4ada021b939b4e19c935dcdd55566/ (all 99 configs)
> 
> 
> *** ERRORS ***
> 


> *** WARNINGS ***
> 
> 23 warning regressions:
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14410): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14428): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14440): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14458): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14470): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14488): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144a0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x144f0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14508): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14520): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14538): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14550): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14568): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14580): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x14598): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4790): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47a8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47c0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47d8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x47f0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4808): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4820): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
>   + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x4540): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names:  => N/A

This is a little confusing. Was there a problem with qed and qede network drivers?
Is it still a problem?
Many of the lines above and below are very similar.

If there is still a problem, what $ARCH and config(s) cause it?
I can't reproduce it on 11 $ARCH tries.
Or maybe it is compiler-specific also.

> 25 warning improvements:
>   - arch/m68k/configs/multi_defconfig: warning: symbol value 'm' invalid for MCTP: 322 => 
>   - arch/m68k/configs/sun3_defconfig: warning: symbol value 'm' invalid for MCTP: 295 => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x136d0): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x136e8): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13700): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13718): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13730): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13748): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13760): Section mismatch in reference from the variable qed_mfw_legacy_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137b0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137c8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137e0): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x137f8): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13810): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13828): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13840): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qed/qed.o(.data+0x13858): Section mismatch in reference from the variable qed_mfw_ext_maps to the variable .init.rodata:qed_mfw_legacy_bb_100g: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4610): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4628): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4640): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4658): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4670): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x4688): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x46a0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
>   - modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x45e4): Section mismatch in reference from the function __trace_event_discard_commit() to the variable .init.data:initcall_level_names: N/A => 

thanks.
-- 
~Randy
