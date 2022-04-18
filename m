Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DA504F54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiDRLYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiDRLX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:23:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BA91A397;
        Mon, 18 Apr 2022 04:21:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E62C60ACF;
        Mon, 18 Apr 2022 11:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC65C385A1;
        Mon, 18 Apr 2022 11:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650280879;
        bh=JtbuCbrZbi3dPFYVVkBHNhS7wJ87kP5Yh2cP76lFqDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iRreG9ldmKxo4O/bDI2DATJ5fXcEBD5AcronFDUmy399cld5aXrndE3vasr4q+FTL
         XjAMdMr3q+Y2sd8xcERorbyBAWSNFLiLrHvaDLry2x3h2XeJm/bHyH4uwGSOwgqIqB
         /93jK4SXYdiTHQDn+Ijj2KOJv2pUtfbVIiKbk5z2fA+uTdbQ7ujExUaSPr/S+So1Pa
         Uv/amKFBMb7UMKynsLQx+enwEEu2YMKlfyyEsJV4bnmWNzRA8PDzMoEAKd1B6angot
         Wj1SUQS0villydBBCU/5YWd5fUQk5uFkpvZiRFUpJaL8WPaVfNr6KqO6LhPAdFem1Y
         6tzkJByFsapGA==
Message-ID: <d3cb233a-1962-af6b-2663-c057e7823a2b@kernel.org>
Date:   Mon, 18 Apr 2022 13:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add Hardkernel ODROID-M1 board
Content-Language: en-US
To:     Heiko Stuebner <heiko@sntech.de>, Peter Geis <pgwipeout@gmail.com>
Cc:     Dongjin Kim <tobetter@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220329094446.415219-1-tobetter@gmail.com>
 <CAMdYzYrCZtfDiB6O20Jtp56YQhHj3jMVhCt9aCYNLbD_xwFc3g@mail.gmail.com>
 <ff0135dc-da30-18b5-f5f4-cefdb0455c6b@kernel.org> <12089439.O9o76ZdvQC@phil>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <12089439.O9o76ZdvQC@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2022 22:55, Heiko Stuebner wrote:
>> Usually adding - in subsequent DTS files - means increasing the numbers
>> so if you have regulator-[012] then just use regulator-[345] in other
>> files. I see potential mess when you combine several DTSI files, each
>> defining regulators, so in such case "some-name-regulator" (or reversed)
>> is also popular approach.
> 
> so going with
> 
> 	dc_12v: dc-12v-regulator {
> 	};
> 
> i.e. doing a some-name-regulator would be an in-spec way to go?
> 
> In this case I would definitely prefer this over doing a numbered thing.
> 
> I.e. regulator-0 can create really hard to debug issues, when you have
> another accidential regulator-0 for a different regulator in there, which
> then would create some sort of merged node.

I don't think such case happens frequently, because all regulators are
usually used by something (as a phandle) thus they should have a label.
This label should be descriptive, so if one can assign same label to
entirely different regulators, then the same chances are that same
descriptive node will be used.

IOW, if you think such mistake with regulator names can happen, then the
same can happen with the label...

Anyway, answering the question - "dc-12v-regulator" is still not
matching exactly the Devicetree spec recommendation, but it's okay for
me. :)


Best regards,
Krzysztof
