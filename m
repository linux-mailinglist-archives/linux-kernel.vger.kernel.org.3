Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5674F56B5E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiGHJr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237803AbiGHJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:47:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33CF17E03B;
        Fri,  8 Jul 2022 02:47:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32615D6E;
        Fri,  8 Jul 2022 02:47:52 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 863B93F66F;
        Fri,  8 Jul 2022 02:47:50 -0700 (PDT)
Date:   Fri, 8 Jul 2022 10:47:46 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi
 file
Message-ID: <20220708104746.6623e239@donnerap.cambridge.arm.com>
In-Reply-To: <39537f95-2ed4-f526-5912-364c1c1ed512@sholland.org>
References: <20220428230933.15262-1-andre.przywara@arm.com>
        <22699277.6Emhk5qWAg@kista>
        <20220704225534.3e1a901a@slackpad.lan>
        <5278570.Sb9uPGUboI@kista>
        <20220706141655.15d2dd0e@donnerap.cambridge.arm.com>
        <39537f95-2ed4-f526-5912-364c1c1ed512@sholland.org>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2022 01:30:32 -0500
Samuel Holland <samuel@sholland.org> wrote:

Hi Samuel,

> Hi Andre, Jernej,
> 
> On 7/6/22 8:16 AM, Andre Przywara wrote:
> > so after seemingly having finished writing this email, I realised that
> > this won't really help, as I think this diverts the discussion. And the
> > problem has been around for a while, and won't probably be solved easily
> > or quickly. I think we agree to disagree here, or we should admit that
> > there are different approaches ("bundled firmware" vs. "UEFI"), so in the
> > interest of not blocking the H616 series:
> > 
> > Shall I just keep the firmware node? This would work both ways, whereas
> > dropping the node would impede the "bundled firmware" approach?  
> 
> Let me try to sum up the relevant portion of my thoughts (and save the rest for
> elsewhere):
> 
> The only reason to add the reserved-memory node is to support externally-loaded
> DTBs. By adding the node, we are committing to support externally-loaded DTBs on
> this SoC.
> 
> Upgrading the kernel is not allowed to break boot. If we support
> externally-loaded DTBs, that rule extends to DTBs shipped with the kernel.
> 
> If we remove the reserved-memory node, the combination of old U-Boot + new
> externally-loaded DTB will stop booting (the kernel version is irrelevant).
> Therefore, if we add the node, we can never remove it, full stop.

Well, this all depends on the initial commitment to support
externally-loaded DTBs. I don't think we need to make this promise, I'd
rather see this as a concession to people doing so *right now*, and for
the sheer practicality of using this DT until we merge it into U-Boot.

> I will (begrudgingly) accept that, as long as the node matches what TF-A
> actually generates today. That means, please:
>  - Drop the label and update the node name

I will drop the label. For the node name: the binding does not enforce it,
but asks that "node names should reflect the purpose", so I went with
"secmon", as used by other platforms. I will send a patch to TF-A to fix
it there instead.
If you disagree, feel free to fix this up before committing.

>  - Reduce the size to 256 KiB, matching (BL31_LIMIT - BL31_BASE)

Verified in TF-A and changed.
I also added a short comment explaining the situation. Feel free to amend
this if needed.


Many thanks for the discussion and for resolving this. I much appreciate
your flexibility and pragmatism in this matter!

Cheers,
Andre
