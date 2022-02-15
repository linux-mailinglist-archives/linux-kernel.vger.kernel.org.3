Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6306A4B730B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiBOQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:05:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiBOQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:05:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A965BA;
        Tue, 15 Feb 2022 08:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9B50B81AF1;
        Tue, 15 Feb 2022 16:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8326EC340EB;
        Tue, 15 Feb 2022 16:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644941089;
        bh=4Fn2tQZHYMpisfGny9s7PMSOteToJFxy1fpDT9qsL/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyqJauKIRL7zzFOxSSzuV4sPvHKSMks6LI3MMs8fyKao/BGBPT0csBYTLJQeTW/JD
         ps+YGpJ5YBqPHliptwQ/eEcJ275mryrK2t2bGi62nvnUp6UWafLdCEbzz079z6ucVd
         Dgb69zOS6zpYfDdiUVv33JTYt0LEOCCjhyULPgUGwhI52lDB4T6ix82Fmjv230cqCd
         XRqyoV+TClHwmZvAiic80eERxMH09CdM3xcQgxP3Pt0zBu8KeFI9q4ymsXYWSbj66/
         OYnLtWQ34FueotGYUpxbz1zXQKuJ8XIOJXWE/ZBq/FrjFM2V65wBZJcXWSfDmzFkt1
         DY7YI5Qr7mL9g==
Date:   Tue, 15 Feb 2022 23:56:57 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 0/6] Provide a fraemework for RISC-V ISA extensions
Message-ID: <YgvNSeUekqEVS1yE@xhacker>
References: <20220215090211.911366-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220215090211.911366-1-atishp@rivosinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 01:02:05AM -0800, Atish Patra wrote:
> This series implements a generic framework to parse multi-letter ISA
> extensions. This series is based on Tsukasa's v3 isa extension improvement
> series[1]. I have fixed few bugs and improved comments from that series
> (PATCH1-3). I have not used PATCH 4 from that series as we are not using
> ISA extension versioning as of now. We can add that later if required.
> 
> PATCH 4 allows the probing of multi-letter extensions via a macro.
> It continues to use the common isa extensions between all the harts.
> Thus hetergenous hart systems will only see the common ISA extensions.
> 
> PATCH 6 improves the /proc/cpuinfo interface for the available ISA extensions
> via /proc/cpuinfo.
> 
> Here is the example output of /proc/cpuinfo:
> (with debug patches in Qemu and Linux kernel)
> 
> / # cat /proc/cpuinfo
> processor	: 0
> hart		: 0
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
> 
> processor	: 1
> hart		: 1
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
> 
> processor	: 2
> hart		: 2
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
> 
> processor	: 3
> hart		: 3
> isa		: rv64imafdcsu
> isa-ext		: sstc,sscofpmf
> mmu		: sv48
> 
> Anybody adding support for any new multi-letter extensions should add an
> entry to the riscv_isa_ext_id and the isa extension array. 
> E.g. The patch[2] adds the support for various ISA extensions.

Hi Atish,

Thanks for this series. I'm thinking cpu features VS ISA extenstions.
I'm converting the sv48 to static key:
https://lore.kernel.org/linux-riscv/20220125165036.987-1-jszhang@kernel.org/

Previously, I thought the SV48 as a cpu feature, and there will be
more and more cpu features, so I implemented an unified static key
mechanism for CPU features. But after reading this series, I think
I may need to rebase(even reimplement) the above patch to your series.
But I'm a bit confused by CPU features VS ISA extenstions now:

1. Is cpu feature  == ISA extension?

2. Is SV48 considered as ISA extension?
If yes, now SV48 or not is determined during runtime, but current ISA
extensions seem parsed from DT. So how to support those ISA extensions
which can be determined during runtime?

Could you please share your thought?

Thanks
