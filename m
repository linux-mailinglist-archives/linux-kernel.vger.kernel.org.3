Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9798E4ACD76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiBHBG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbiBHAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:00:59 -0500
X-Greylist: delayed 406 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 16:00:55 PST
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FCC0612A4;
        Mon,  7 Feb 2022 16:00:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 5FB362B001F4;
        Mon,  7 Feb 2022 18:54:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 07 Feb 2022 18:54:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; bh=7T1gb9q/dG3+e+
        HVYc4URRtl0zI51K/MI/cYy1EcerM=; b=SDYv224gBZ5TT66LpyAI9ivK3tYsVZ
        GBDiKxzdAELBE+LHIad5qxjwoVvgShjRZqvs1T+iE1ug4DfXaHnPXWqu3w3dW6iS
        VWYhOUl/EqRiKCBjT+8acRD/NDUoFmg5rDbRyxEem25KtRpeEtsIn3OmVvQ1o06O
        /uqL4Hxvu1eOldEvKivAb8tYgEdUAQSxU1Mkq6qXmntsEwnrRGo26NV31u68KB62
        pUUkKRlaMcTRtlWJ21rw2p46tK/w0LVXTHjN6vY6X7GLaePGA86U3dyc2+cE58bi
        p4llC4FgLAdhQXgDDIqSD7J/XMQiPkeJqz7AKEjiOTDKs39DBr95K10g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=7T1gb9q/dG3+e+HVYc4URRtl0zI51K/MI/cYy1Ece
        rM=; b=dLl3ZpuPFU64fHFzudMdRGhNEh23o8k+blqkqXrk485ZDHglhYjDWyueC
        5REvXvS1FtUvdEeK4if4sRQffIpOKH7TEaO+zUNr+oqz4k5vHKGcV3VWNNpmM1mx
        NX5EkDA1FyaHWQTEKowbGpsbqvyhCJM9q55+c3e1dOLBzDS4VXQQM2f0ZrUZ3vnL
        m4BPwW+hlb7MdHrWwZc6R/Pq7jca+ihKDFWK59yYtCMUr5CdDixJsYXdhTX9L/es
        yqH0pAQTvLaBul6yAU/SIpiJLEYxfAGmIw6zcqG7DMHNGiLMp1yDaSbNwN/o/Gmz
        H2HlSD5bqBi3RplwL/SnkD0wD0KUQ==
X-ME-Sender: <xms:HLEBYg6jw33gP6tAXBkbbBPNm4gGLbfE98ysR-hGoL_Ozu60Rylstw>
    <xme:HLEBYh4dqQ3adV6Qd1t2gCrgiDnlBoAzzy10EMDTx_34cils8jIJ2dFvr7LpOjpgw
    OkkCQNwtrwns3djTA>
X-ME-Received: <xmr:HLEBYvexMpT1Ym7Mbdz_UUlt-gJcQg9yRVtICaIGsb8uWm1ySPLnl9dFPKc6UB_tgm8zQRI_kif1DqEn5HzNmLdboZvH6x0-qMysB0BXYv2pXglTTIPAfvhT_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeigddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HLEBYlIcESxYubPnsfJoYBFrpQV7Eca9oPiwAtrBPV0poWN-8a0Tew>
    <xmx:HLEBYkJ_lpYGg0JrkD8SfUuIEutebjO3VnO7aYSFpLvmu_rCRQzf0w>
    <xmx:HLEBYmwXKGJNpft6ZS79msn9_tfLg7HwdqRIBM_EBdjbuyZTxtrRXg>
    <xmx:HbEBYnZPQRdSjNs7ec0qiolHyDVZ8LMFS3OghivBTbNnBGrprWFMS9OcNV8>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 18:54:03 -0500 (EST)
Subject: Re: (subset) [PATCH v3 5/6] clk: sunxi-ng: Add support for the sun6i
 RTC clocks
To:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi@lists.linux.dev, Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
References: <20220203021736.13434-1-samuel@sholland.org>
 <20220203021736.13434-6-samuel@sholland.org>
 <164422443570.21572.13511859513410998733.b4-ty@cerno.tech>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <bb05bc64-2a9e-fe21-5a69-0ea31134e978@sholland.org>
Date:   Mon, 7 Feb 2022 17:54:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <164422443570.21572.13511859513410998733.b4-ty@cerno.tech>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 2/7/22 3:00 AM, Maxime Ripard wrote:
> On Wed, 2 Feb 2022 20:17:35 -0600, Samuel Holland wrote:
>> The RTC power domain in sun6i and newer SoCs manages the 16 MHz RC
>> oscillator (called "IOSC" or "osc16M") and the optional 32 kHz crystal
>> oscillator (called "LOSC" or "osc32k"). Starting with the H6, this power
>> domain also handles the 24 MHz DCXO (called variously "HOSC", "dcxo24M",
>> or "osc24M") as well. The H6 also adds a calibration circuit for IOSC.
>>
>> Later SoCs introduce further variations on the design:
>>  - H616 adds an additional mux for the 32 kHz fanout source.
>>  - R329 adds an additional mux for the RTC timekeeping clock, a clock
>>    for the SPI bus between power domains inside the RTC, and removes the
>>    IOSC calibration functionality.
>>
>> [...]
> 
> Applied to local tree (sunxi/clk-for-5.18).

Part of the build failures were because this patch depends on patch 3. Is that
okay, or should I update this patch to be independent?

Regards,
Samuel
