Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD205425ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442490AbiFHAyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382038AbiFGVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:46:10 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B9B235B03;
        Tue,  7 Jun 2022 12:07:44 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id i201so10914649ioa.6;
        Tue, 07 Jun 2022 12:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfDC8OCE89M5DmQOiwz11rqXI91cPiUhxnizP3Vecs4=;
        b=KtkDR78AVoln2T3KHs1nW/C5BlGGhNxb2vdT9H3jjsMOjvRHT/hsUGovoOz9nAhqIo
         NznUDv7XY5VUhTH7/yXDhq+9iUGfnLWiK70mZLA3GeHjAuBKUuhbm5Lvi/ZV/NKqnF2o
         UBlv2S7U9TTMH2MYXK0oBT83zADuBc8P4xwK+6PI0BEC3IVYt+C6Bjzy9HXomhHrEF1T
         D16dp3UAdkmdXKZX/UrczVCRi4rVCT62MzTjmJCibDaA/VmzcSEbab1zcmSB1Myw3bK6
         gElauK/zHLMU89daVerhSSf+d/qdZHh56+3EGmnXJtVknVasaa8GnO9fF0lYeG30A9gX
         O+bw==
X-Gm-Message-State: AOAM531rTDHbxc3PIFCHHXNAGVFNdZ/UKlaYW62Rv5jZRdtJ/Csduu84
        dHzipIOdahEnoF9YiUmAM0VDTHYuMw==
X-Google-Smtp-Source: ABdhPJyXN4BjBm3eZUFDX9fHMePl6YzIdSCERXPSC3Ydq6geCntnC7mEUdXSSQ2BbAKOjP5dYeuqbQ==
X-Received: by 2002:a05:6638:160a:b0:330:f07b:7c5d with SMTP id x10-20020a056638160a00b00330f07b7c5dmr17052629jas.222.1654628863838;
        Tue, 07 Jun 2022 12:07:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k4-20020a926f04000000b002d52f2f5a97sm3143012ilc.35.2022.06.07.12.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 12:07:43 -0700 (PDT)
Received: (nullmailer pid 3646440 invoked by uid 1000);
        Tue, 07 Jun 2022 19:07:41 -0000
Date:   Tue, 7 Jun 2022 13:07:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v3] of: check previous kernel's ima-kexec-buffer against
 memory bounds
Message-ID: <20220607190741.GA3644258-robh@kernel.org>
References: <20220531041446.3334259-1-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531041446.3334259-1-vaibhav@linux.ibm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 09:44:46 +0530, Vaibhav Jain wrote:
> Presently ima_get_kexec_buffer() doesn't check if the previous kernel's
> ima-kexec-buffer lies outside the addressable memory range. This can result
> in a kernel panic if the new kernel is booted with 'mem=X' arg and the
> ima-kexec-buffer was allocated beyond that range by the previous kernel.
> The panic is usually of the form below:
> 
> $ sudo kexec --initrd initrd vmlinux --append='mem=16G'
> 
> <snip>
>  BUG: Unable to handle kernel data access on read at 0xc000c01fff7f0000
>  Faulting instruction address: 0xc000000000837974
>  Oops: Kernel access of bad area, sig: 11 [#1]
> <snip>
>  NIP [c000000000837974] ima_restore_measurement_list+0x94/0x6c0
>  LR [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
>  Call Trace:
>  [c00000000371fa80] [c00000000083b55c] ima_load_kexec_buffer+0xac/0x160
>  [c00000000371fb00] [c0000000020512c4] ima_init+0x80/0x108
>  [c00000000371fb70] [c0000000020514dc] init_ima+0x4c/0x120
>  [c00000000371fbf0] [c000000000012240] do_one_initcall+0x60/0x2c0
>  [c00000000371fcc0] [c000000002004ad0] kernel_init_freeable+0x344/0x3ec
>  [c00000000371fda0] [c0000000000128a4] kernel_init+0x34/0x1b0
>  [c00000000371fe10] [c00000000000ce64] ret_from_kernel_thread+0x5c/0x64
>  Instruction dump:
>  f92100b8 f92100c0 90e10090 910100a0 4182050c 282a0017 3bc00000 40810330
>  7c0802a6 fb610198 7c9b2378 f80101d0 <a1240000> 2c090001 40820614 e9240010
>  ---[ end trace 0000000000000000 ]---
> 
> Fix this issue by checking returned PFN range of previous kernel's
> ima-kexec-buffer with page_is_ram() to ensure correct memory bounds.
> 
> Fixes: 467d27824920 ("powerpc: ima: get the kexec buffer passed by the previous kernel")
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Cc: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ritesh Harjani <ritesh.list@gmail.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog
> ==========
> v3:
> * change the type for {start,end}_pfn to unsigned long [ Ritesh ]
> * Switched to page_is_ram() from pfn_vaild() [ Rob ]
> 
> v2:
> * Instead of using memblock to determine the valid bounds use pfn_valid() to do
> so since memblock may not be available late after the kernel init. [ Mpe ]
> * Changed the patch prefix from 'powerpc' to 'of' [ Mpe ]
> * Updated the 'Fixes' tag to point to correct commit that introduced this
> function. [ Rob ]
> * Fixed some whitespace/tab issues in the patch description [ Rob ]
> * Added another check for checking ig 'tmp_size' for ima-kexec-buffer is > 0
> ---
>  drivers/of/kexec.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Applied, thanks!
