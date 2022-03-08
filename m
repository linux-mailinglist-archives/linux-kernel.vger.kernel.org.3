Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD64D161F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346466AbiCHLWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346442AbiCHLWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:22:30 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42407457A1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:21:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E8A7E3201F1A;
        Tue,  8 Mar 2022 06:21:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 08 Mar 2022 06:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=z0dgs/nLCUEaUJ
        97BFyT/rCTk7+HqMDGbw7diAaTdns=; b=GN7F0izHr81GDr5frIi6xPLCzYz+jt
        ukmpT5nyALjeSmeruURmsrsvap6CE1EVyh3rsvET76J5HKfMEqH/idj3eFZX7B32
        AbCGRfF72vDYNNrzw+xPRAHar4PAkglACh2sfWR3Lh5RuT9+dnBudylszFFHNlYh
        wdsZqHJUcCIU3rHN4R/UGAyIqwfWXNtM8wRuiMbatDQyxAPc3kovgRaWOJzLDwWc
        7ty6ogW5fTPREkMEOGZu0EWhXA1f3gUGwwDI5pusMeSKHUHQwUUaTXOWIZk8wWf5
        s70jPeU+Dx4fgnJGVNtjrULbQhMDtOnMUSgBL8V/fGCBgYhTYkMpQlcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=z0dgs/nLCUEaUJ97BFyT/rCTk7+HqMDGbw7diAaTd
        ns=; b=GQZbptD/6VPdyd4eIBaHYSVetin3f36RFf/9M5p6PmqB8UkZDzYIxZNPy
        ifzwE97AHi9c+D5ZUJEHaX7g/7WTRW9Wncz8RnEkouvEWfZpz+D258lBFg7xBGC/
        UgfICrRXVazPUf8tWymQxkjkgaigGAGVi6+Cj66xKfGcTMWmj8vX1/5LcKv5aZoh
        x3FUMlmKbf9h9DrF52J8mD5HmZ3BjQrgqWmKnrg5AaR3CLoqlXWf1PcyMMNoa+8E
        6uKz1MBV8KlkSe6pmDZfGj3T7B1GMiFq5pWXolsOyOqYWMWh/juXmqHxigPCbkvN
        IDNChSVrp2h+qlm5p+2s+C6UWam0g==
X-ME-Sender: <xms:ODwnYpxJ8Mo_K4WILGV5QX1Pg2cm2q7I7wAagjmW9XcwkKbyEAtHYg>
    <xme:ODwnYpSbN7Y6i9QO55WKZqOVd17arPog10sXFbuJnjQMqKmRgIc9IS5iRTeFk6SSq
    WcK1zQqe7clFz2wOMQ>
X-ME-Received: <xmr:ODwnYjWOREdAI8DiBIGvdldQj7XygAU5mYO7ipevdeSbW-1TnQ8xxN962B22hUjSUnUzcL41E6NK9URhe1OvJojEbPvwdRF4DABisIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduiedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeejuefggeekfffgueevtddvudffhfejffejjedvvdduudethefhfefhfeeg
    ieekkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:ODwnYriWs0PlaAC1vqbU8kMHXximACFoTnHrypbRezQvUVIUGCQuZQ>
    <xmx:ODwnYrBAxOoTY_0oGhAf5ZUn47DQAO5Yh7fuXYCdKAcaUB59iAT2IA>
    <xmx:ODwnYkJH1AqMpTkIgw88UrPzoFTyARbaeMACGgMcIxZBQkm3Dpdbcw>
    <xmx:ODwnYv5efASGlGa3B0UcwTCkO2sfZ3rjbOHF7fWnFza2nRRWit9gCA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Mar 2022 06:21:27 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        jonas@kwiboo.se, narmstrong@baylibre.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        robert.foss@linaro.org
Subject: Re: (subset) [PATCH] drm/bridge: ti-sn65dsi83: switch to devm_drm_of_get_bridge
Date:   Tue,  8 Mar 2022 12:21:06 +0100
Message-Id: <164673846305.2436174.3713832532943884361.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228183724.25030-1-jose.exposito89@gmail.com>
References: <20220228183724.25030-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022 19:37:24 +0100, José Expósito wrote:
> The function "drm_of_find_panel_or_bridge" has been deprecated in
> favor of "devm_drm_of_get_bridge".
> 
> Switch to the new function and reduce boilerplate.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
