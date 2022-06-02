Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45153B542
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiFBIku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiFBIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:40:49 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251A29DC2F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:40:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 804A73200995;
        Thu,  2 Jun 2022 04:40:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 Jun 2022 04:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1654159242; x=1654245642; bh=5Iah++U4Rg
        kaeCKrTIS0QOwPoyesmmVEuWNhFXScqIY=; b=uwLqkt2TixP4D3iAWvYAJAeOLd
        Bj+G72iLXKBX3XcqjgYJ3ayVxj83q9c0yIR5QCyNpzA+fvmh247Q1xVI/KBjX+f7
        Pq87+kfAmBxGfqvNUd8+RfjyjgF6kD2z+eb/HhbufCvb00kPZSGVgZe/Ar++P5J8
        BMpKz0UDqEhaB9CNhVowhEDr50s6vh+OrDnvgvzCTchctPOZDnlOoWsiz2Fp0a3W
        alUCWWvheiHSzkDKFhMmkM3dgCek9/TXjA1w7OKAKjEM246JO/nZPd9gpg3fbj6D
        T9gG2D2Ex44FJVypMFGAUy/xOvqsuUymeGWPiWzZAO3h98Ez7F2UIfKYuBmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1654159242; x=1654245642; bh=5Iah++U4RgkaeCKrTIS0QOwPoyes
        mmVEuWNhFXScqIY=; b=BoTe/q8q5MVKensZ7my1hpU9kFFaFlH6JMm2WLtqJPrV
        Vy8a/1bLYD/krp60noqYB/YoctS+i5asWUPYUddyAHR/s15qWEuVVWeOKMUJJSyp
        i8PoTVoGENI9TA3dDs5zOpd+5bVIsZFrSe3rbueyefCDSrSm+DD9iy/LwaxNA7h/
        B0rYd7DgP13kspZpxDGIPyeegMbNfJDSuS7exucBpgDuleZsJfqGHpzgtDZ832Jy
        m5jObHtb1wIt7XE1TKlB77SYxHYNFIDC1YPHVN/gCu0Napa+sfAOMonWcqnHRvqZ
        IrC2Shcg9pyqmR22Pgwj5MqLD43qhiimDLNdud5Ipg==
X-ME-Sender: <xms:iHeYYsQzEK9U1qYiYt0aawOSI2ZPpTE_gdfrJwNQMRGknntQ2Olotw>
    <xme:iHeYYpw-DhHZXAQUhhOGS8fwlozZnhfw8gtrZaH8XrcNgthLbGIXGSmh7Ud7DllH4
    p9qfCvDU7v3r-tMjLc>
X-ME-Received: <xmr:iHeYYp0ogQbjJ8iFAUhwDnuK4fSbmvm4dNkEZJQd7AnKQRMdqtMuWBNyyes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledvgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepfedtueevteeggfeivdffjeejledvveduudetteekvdeiueehvdegkedvleet
    ffeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmh
    grgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:iHeYYgDFGqt0QLLlkWuLKogFZCCUmUbHQOcTnvh4_3dxFqZjRL0EMQ>
    <xmx:iHeYYlilp7_Ycpqxr0t5_QCE4RrvBZLPf6h2t4CbRvUtHiHQyrm_yQ>
    <xmx:iHeYYsoS9XZF2K42UxD7qWJl3DIYLhoG8_f5YXBBbBaGuJGcsI4wFA>
    <xmx:ineYYl5V4RiP5tN5p55k37oSTh7HSxf4PEpcwKmEDDWlDB8WcVQGwg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jun 2022 04:40:39 -0400 (EDT)
Date:   Thu, 2 Jun 2022 10:40:37 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, robert.foss@linaro.org, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, alsi@bang-olufsen.dk, jagan@amarulasolutions.com,
        biju.das.jz@bp.renesas.com, l.stach@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: adv7511: Add check for
 mipi_dsi_driver_register
Message-ID: <20220602084037.c2pslwra4dyhnh3d@penduick>
References: <20220601111255.2911012-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601111255.2911012-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 07:12:55PM +0800, Jiasheng Jiang wrote:
> On Wed, Jun 01, 2022 at 05:15:37PM +0800, Laurent Pinchart wrote:
> >> Well, as far as I am concerned, the adv7511_exit() in the same file has already dealt with the issue.
> >> Therefore, it might not be necessary to add another mipi_dsi_driver_unregister().
> > 
> > The issue is that adv7511_exit() is not called if adv7511_init() fails.
> 
> Sorry, I can not find the caller of adv7511_init().
> Please give me more detail.

It's called by the kernel when the module is unloaded (module_exit).
It's not what Laurent is saying though.

His point is that in adv7511, if i2c_add_driver fails, you'll still need
to call mipi_dsi_driver_unregister to clean things up.

Maxime
