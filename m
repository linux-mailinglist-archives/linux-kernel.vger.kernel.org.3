Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435D850497C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiDQU7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 16:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbiDQU6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 16:58:20 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFB7DD3;
        Sun, 17 Apr 2022 13:55:41 -0700 (PDT)
Received: from [185.156.123.69] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ngBvh-0003OQ-Bj; Sun, 17 Apr 2022 22:55:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dongjin Kim <tobetter@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
Date:   Sun, 17 Apr 2022 22:55:25 +0200
Message-ID: <12089439.O9o76ZdvQC@phil>
In-Reply-To: <ff0135dc-da30-18b5-f5f4-cefdb0455c6b@kernel.org>
References: <20220329094446.415219-1-tobetter@gmail.com> <CAMdYzYrCZtfDiB6O20Jtp56YQhHj3jMVhCt9aCYNLbD_xwFc3g@mail.gmail.com> <ff0135dc-da30-18b5-f5f4-cefdb0455c6b@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 17. April 2022, 19:45:52 CEST schrieb Krzysztof Kozlowski:
> On 16/04/2022 14:07, Peter Geis wrote:
> 
> >>> +     dc_12v: dc-12v {
> >>
> >> Generic node name, so "regulator" or "regulator-0"
> > 
> > Unfortunately, this advice breaks the regulator-fixed driver, which it
> > seems cannot cope with a bunch of nodes all named "regulator".
> 
> What exactly cannot cope? You cannot have different device nodes with
> the same name but this is not a limitation of regulator but devicetree spec.
> 
> > Setting the regulators as regulator-0 -1 -2 leads to fun issues where
> > the regulator numbering in the kernel doesn't match the node numbers.
> 
> There are no "node numbers"... maybe you mean unit addresses? But there
> are none here.
> 
> > It also makes it more fun when additional regulators need to be added
> > and everything gets shuffled around.
> 
> Usually adding - in subsequent DTS files - means increasing the numbers
> so if you have regulator-[012] then just use regulator-[345] in other
> files. I see potential mess when you combine several DTSI files, each
> defining regulators, so in such case "some-name-regulator" (or reversed)
> is also popular approach.

so going with

	dc_12v: dc-12v-regulator {
	};

i.e. doing a some-name-regulator would be an in-spec way to go?

In this case I would definitely prefer this over doing a numbered thing.

I.e. regulator-0 can create really hard to debug issues, when you have
another accidential regulator-0 for a different regulator in there, which
then would create some sort of merged node.


Heiko

> 
> > If naming these uniquely to avoid confusion and collisions is such an
> > issue, why is it not caught by make W=1 dtbs_check?
> 
> Patches are welcome. :)
> 
> Best regards,
> Krzysztof
> 




