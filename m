Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2552A6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350167AbiEQPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347265AbiEQPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:34:48 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94205004D;
        Tue, 17 May 2022 08:34:46 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-edeb6c3642so24654091fac.3;
        Tue, 17 May 2022 08:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PTVbwF3S9Tbu51YtKoS67xXtieQ0lMn2T7P3U2Mtxxs=;
        b=T3Hd6I6iLptwIzwoo/kt7TUZoWEgPo7G/Zij0z9kYooyS0TSgEyIp7OJ8rov0fT7LS
         wzy4zzlfZVhwdu2nQLlE/M6PdjRCst1X4A+JNWfiegUnuu4E5+G9YPKbDplL0CNvkA5n
         ihEJoSz6mVPTlII4jYUkbgcpA2b7rP/LisaBWlPWFgBSRNHmcu7sOgKcSoIKNvroCdVo
         uPUNM8lt/hRX6fcjXXvISDvNgHwObmt5jCXvD2mIF4Bw2d+IoepoVLIi8hx1HgXNaGTt
         26hnsoBJ2EE3fYoL8JNUON3M6419PK2CTzzSTp0O99shVm4/FngkPhUrLDWZgKIEh2cX
         G7Iw==
X-Gm-Message-State: AOAM533m2dcKUy0XaH4cYby1ga91Ilk6Bpp9EnAGU+p7TwWm/A+wtrL/
        TiO6fMN6IghuRsiLGIxtTg==
X-Google-Smtp-Source: ABdhPJzNzlBgcWyB4ZGLCHs+MDDXfQkSsqKXnlx93WBTwFdRaNJE12q6suyko6oDDUk2JvZ8XpGFIQ==
X-Received: by 2002:a05:6870:602a:b0:f1:42cf:8296 with SMTP id t42-20020a056870602a00b000f142cf8296mr12042106oaa.111.1652801685681;
        Tue, 17 May 2022 08:34:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g81-20020a9d12d7000000b006060322124csm12500otg.28.2022.05.17.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 08:34:45 -0700 (PDT)
Received: (nullmailer pid 1081626 invoked by uid 1000);
        Tue, 17 May 2022 15:34:44 -0000
Date:   Tue, 17 May 2022 10:34:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ross Burton <ross.burton@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH] of/fdt: Ignore disabled memory nodes
Message-ID: <20220517153444.GA1057027-robh@kernel.org>
References: <20220517101410.3493781-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517101410.3493781-1-andre.przywara@arm.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 11:14:10AM +0100, Andre Przywara wrote:
> When we boot a machine using a devicetree, the generic DT code goes
> through all nodes with a 'device_type = "memory"' property, and collects
> all memory banks mentioned there. However it does not check for the
> status property, so any nodes which are explicitly "disabled" will still
> be added as a memblock.
> This ends up badly for QEMU, when booting with secure firmware on
> arm/arm64 machines, because QEMU adds a node describing secure-only
> memory:
> ===================
> 	secram@e000000 {

BTW, 'memory' is the correct node name.

> 		secure-status = "okay";
> 		status = "disabled";
> 		reg = <0x00 0xe000000 0x00 0x1000000>;
> 		device_type = "memory";
> 	};
> ===================
> 
> The kernel will eventually use that memory block (which is located below
> the main DRAM bank), but accesses to that will be answered with an
> SError:
> ===================
> [    0.000000] Internal error: synchronous external abort: 96000050 [#1] PREEMPT SMP
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc6-00014-g10c8acb8b679 #524
> [    0.000000] Hardware name: linux,dummy-virt (DT)
> [    0.000000] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.000000] pc : new_slab+0x190/0x340
> [    0.000000] lr : new_slab+0x184/0x340
> [    0.000000] sp : ffff80000a4b3d10
> ....
> ==================
> The actual crash location and call stack will be somewhat random, and
> depend on the specific allocation of that physical memory range.
> 
> As the DT spec[1] explicitly mentions standard properties, add a simple
> check to skip over disabled memory nodes, so that we only use memory
> that is meant for non-secure code to use.
> 
> That fixes booting a QEMU arm64 VM with EL3 enabled ("secure=on"), when
> not using UEFI. In this case the QEMU generated DT will be handed on
> to the kernel, which will see the secram node.
> This issue is reproducible when using TF-A together with U-Boot as
> firmware, then booting with the "booti" command.
> 
> When using U-Boot as an UEFI provider, the code there [2] explicitly
> filters for disabled nodes when generating the UEFI memory map, so we
> are safe.
> EDK/2 only reads the first bank of the first DT memory node [3] to learn
> about memory, so we got lucky there.
> 
> [1] https://github.com/devicetree-org/devicetree-specification/blob/main/source/chapter3-devicenodes.rst#memory-node (after the table)
> [2] https://source.denx.de/u-boot/u-boot/-/blob/master/lib/fdtdec.c#L1061-1063
> [3] https://github.com/tianocore/edk2/blob/master/ArmVirtPkg/PrePi/FdtParser.c
> 
> Reported-by: Ross Burton <ross.burton@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/of/fdt.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks!
