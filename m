Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE757D8BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbiGVCqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiGVCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:46:13 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7D1A04E;
        Thu, 21 Jul 2022 19:46:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 266683200A1F;
        Thu, 21 Jul 2022 22:46:11 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 21 Jul 2022 22:46:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1658457970; x=1658544370; bh=5AT+tgOaPJ
        apVfmh9DJlx7xLkwqvGnfIqciFEcsi7i8=; b=ThZybTAW4USY4pIzxpihLCuwO0
        yoYRRWFVxtBWjoUOwqg8z+Ji1ylrV347VdtkRUywBWHjkbUuSv+jMuTzBpg67xpn
        zac4c9Ym2ukCsqup7poYZzUgNJEPNq9honmhPmf6DUrRcZgqKsjLNSCGYB3GRJGI
        /vpbQ5PtdV/d7bBo7WtZL/jNHQW5uuJwm7aJ5RR/WrkWBy5AiB7fXqAU/x2PxRYu
        KpF5bHjD9u8r7v8Lr688ESeLjNdCFdg+MxUeFQNKpIGTKuCe3fi/3Mg9qwlITQWM
        fxjKPYojIJp3XiLMrMvSmFvjdPB7J7nstC6X8RGMwQKkAM1+VlH3jpEsH0Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658457970; x=1658544370; bh=5AT+tgOaPJapVfmh9DJlx7xLkwqv
        GnfIqciFEcsi7i8=; b=VDfl5yEoDV+wPCsks5EAoXFdIXA+nb0SBlTq3PJA2y1p
        OJnuvmIso6sN1kp63QZMCLsaWhtiwCHkvMNyFbmqFe1DWRjYBzbzASWJ1I/7CUsr
        F081gUoyikr6xrOi3itW8uXer41Uib5WIidJa5Iv64pQOfpLkGLKoTnNLnWO001g
        JeG7j1NlrFKuAUB2KJejZxiWU6iV05/CXdrL0iQOQXdmnGh96HFH2whpDBlUhy10
        wRnTyfp4JD7NYQ4m0Mgy3Js6Gp/s4Iyfw0oftFQoS8kaPrJNW1n0q39NQJbAQyQm
        4oxv7zCt1O/DB9/XCN05S7ZgYFYOrIYlFILdCeTBMg==
X-ME-Sender: <xms:cg_aYgyqWk9DNXLcaLxvZAOkGS0XmXr7yoeM-qxOEQ_2h4kR-1BwCg>
    <xme:cg_aYkRLZ7FuKK9VjiQeqjYe9ecQVDB5vl9HZw8G76SUH-TpZ2ypup2QNgNh_EVT-
    YzyZB_l9M7SRmua5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtuddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhephefhfeekgfekudevheffheeihedujeefjeevjeefudfgfeeutdeuvdeh
    hfevueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:cg_aYiV8qqjva40lI0CF3iqPtF-dxmPKKrSMwttt7wZRMnlBMWvbaA>
    <xmx:cg_aYuiFH8lnez9M_kJ8NPKiQtrmvuJsUOKb45roCgeKv2dUeJz-mw>
    <xmx:cg_aYiA43tJltIfjlGxAYa4TmpQhy1v3tK1y4CmmixibgGZU-e8gyw>
    <xmx:cg_aYp6SLCAtvqAe7itjw1zsAkhUWSCP-ydjOePnJPQiePbHT0TZ-A>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F1FC170007E; Thu, 21 Jul 2022 22:46:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-755-g3e1da8b93f-fm-20220708.002-g3e1da8b9
Mime-Version: 1.0
Message-Id: <b5772fef-607c-46cb-9b27-8259c250648e@www.fastmail.com>
In-Reply-To: <20220529111442.182722-1-krzysztof.kozlowski@linaro.org>
References: <20220529111442.182722-1-krzysztof.kozlowski@linaro.org>
Date:   Fri, 22 Jul 2022 12:15:48 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Joel Stanley" <joel@jms.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: aspeed: vegman: drop unused fttmr010,pwm-outputs
 property
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 May 2022, at 20:44, Krzysztof Kozlowski wrote:
> The "fttmr010,pwm-outputs" property is neither documented, nor used in
> Linux kernel driver, so remove it.  This also fixes warning like:
>
>   aspeed-bmc-vegman-n110.dtb: timer@1e782000: 'fttmr010,pwm-outputs' 
> does not match any of the regexes:
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Andrew Jeffery <andrew@aj.id.au>
