Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0EE527D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbiEPGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiEPGHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:07:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04D820F50
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54025B80E3D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B9BC385AA;
        Mon, 16 May 2022 06:06:56 +0000 (UTC)
Message-ID: <551618d4-f384-47a9-39c4-9ec3c636a06d@linux-m68k.org>
Date:   Mon, 16 May 2022 16:06:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] m68k: math-emu: Fix dependencies of math emulation
 support
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
References: <18c34695b7c95107f60ccca82a4ff252f3edf477.1652446117.git.geert@linux-m68k.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <18c34695b7c95107f60ccca82a4ff252f3edf477.1652446117.git.geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 13/5/22 22:50, Geert Uytterhoeven wrote:
> If CONFIG_M54xx=y, CONFIG_MMU=y, and CONFIG_M68KFPU_EMU=y:
> 
>      {standard input}:272: Error: invalid instruction for this architecture; needs 68000 or higher (68000 [68ec000, 68hc000, 68hc001, 68008, 68302, 68306, 68307, 68322, 68356], 68010, 68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060], cpu32 [68330, 68331, 68332, 68333, 68334, 68336, 68340, 68341, 68349, 68360], fidoa [fido]) -- statement `sub.b %d1,%d3' ignored
>      {standard input}:609: Error: invalid instruction for this architecture; needs 68020 or higher (68020 [68k, 68ec020], 68030 [68ec030], 68040 [68ec040], 68060 [68ec060]) -- statement `bfextu 4(%a1){%d0,#8},%d0' ignored
>      {standard input}:752: Error: operands mismatch -- statement `mulu.l 4(%a0),%d3:%d0' ignored
>      {standard input}:1155: Error: operands mismatch -- statement `divu.l %d0,%d3:%d7' ignored
> 
> The math emulation support code is intended for 68020 and higher, and
> uses several instructions or instruction modes not available on coldfire
> or 68000.
> 
> Originally, the dependency of M68KFPU_EMU on MMU was fine, as MMU
> support was only available on 68020 or higher.  But this assumption
> was broken by the introduction of MMU support for M547x and M548x.
> 
> Drop the dependency on MMU, as the code should work fine on 68020 and up
> without MMU (which are not yet supported by Linux, though).
> Add dependencies on M68KCLASSIC (to rule out Coldfire) and FPU (kernel
> has some type of floating-point support --- be it hardware or software
> emulated, to rule out anything below 68020).
> 
> Fixes: 1f7034b9616e6f14 ("m68k: allow ColdFire 547x and 548x CPUs to be built with MMU enabled")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
> To be queued in the m68k for-v5.19 branch.
> 
> v2:
>    - Fix typo in M68KCLASSIC,
>    - Improve rationale behind FPU dependency.
> ---
>   arch/m68k/Kconfig.cpu | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index 16ea9a67723c09dc..3d5da25c73b5af8a 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -327,7 +327,7 @@ comment "Processor Specific Options"
>   
>   config M68KFPU_EMU
>   	bool "Math emulation support"
> -	depends on MMU
> +	depends on M68KCLASSIC && FPU
>   	help
>   	  At some point in the future, this will cause floating-point math
>   	  instructions to be emulated by the kernel on machines that lack a
