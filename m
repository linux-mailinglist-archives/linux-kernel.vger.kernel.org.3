Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933995AFF24
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiIGIg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiIGIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:36:20 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46192F7B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:35:56 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 6320A2B059B3;
        Wed,  7 Sep 2022 04:35:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Sep 2022 04:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662539752; x=
        1662546952; bh=ajJh2Wx8MXMMsyiQmD1r2lPMNWPyf1jGQwAZU1Xo/Vo=; b=l
        8go6mCkyswA9oBEMhyKItgLKUQof0p7NCMe3c4BY24qhihmcXOnPXOOCGA+JoENf
        r8LSrx6plFt3eRT6f+iRm13X+Ge7H5w/X8nYFD8uuCi/NNl1ka4pjepEzYGO2UD5
        jTxKdJ1NueGRqmPAZQU+8gTpKR3kgBz5IJYJxRUbHeh30VL5QZgIaLwF7Me7yFPF
        z90h5LYxXSLekU6PvQtCGOcfT065udK15EJNrD3wsdread9k9wI/swpy4eL5h1be
        NhX1Zlm1Zjycd6bXijWv9ZLbAMX26+6I/rmrNJa+xWqiG+0x8U41v3AbLBcb64aN
        AoRVH5RrvTBKGC3N3jBSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662539752; x=
        1662546952; bh=ajJh2Wx8MXMMsyiQmD1r2lPMNWPyf1jGQwAZU1Xo/Vo=; b=E
        1cdASYEoVOrm0rC7xl467NtgJFSmEsw2hoTDcwC4BZFf1KmKqd09nO0DQvfYgja9
        zP/eEmvicvF5Wp11vuZ/vACkRYYnlwIzFON4NmUET4K1pAj6szj+FIJqy7KAQxzu
        1qBkAXPa6CtajrCRxYwCobjWWEp0OqBu78kMjL0Mk8P3zLQLGVvwfFFBbmOKvyZ+
        A2OMSCle1irJJX7IUDglinlSYVgsSdYiFOT9nx5UOCf4wVqY9k33k8r6HaOa+xPm
        xP3/ueJrbPnp1TI6tJ7tGELFq1k8QhsGIKkRcsCZ9T6ox4vUUEQic/10vbdnC46R
        tWdx1r/jwgkfO3nlecE2Q==
X-ME-Sender: <xms:6FcYY4GeGJ_bO0bJRklMK1f2_CTY62pLVtJG_U42Rc9mE08rzE5pBQ>
    <xme:6FcYYxV_xSC_HlhoX_XyrLKIj6qkqiUBpWsi8HkqA-oozMBdB1ykzP8fPnUg7F8UG
    qxVFd9i3FAeZWi6zVo>
X-ME-Received: <xmr:6FcYYyJSALkWxYavLe0XO1MU2Jx6hm3iiT6ldqaux334v_mVTTaN1pYZL-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:6FcYY6HwKIeqqXOW3dGvC14D5L7u-YlM6kNoiErEeFLzfsClVNMSNA>
    <xmx:6FcYY-XeTgPZEJHNts5dbaWMxkCIcGV4PojeiFGONcmA0V70QCvD2A>
    <xmx:6FcYY9NB2dbNdtIyEb49TE0RKiAUZy5QHDwIBb9_mPYb8dK_SztWeg>
    <xmx:6FcYYxccDmLVXh4M4g6iLcopyj4oX-SSZ_IcNu1K_wo_eAt0D-gMUvno-mM>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Sep 2022 04:35:51 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     David Airlie <airlied@linux.ie>,
        Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <mripard@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Dom Cobley <dom@raspberrypi.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Phil Elwell <phil@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        nouveau@lists.freedesktop.org
Subject: Re: (subset) [PATCH v2 34/41] drm/sun4i: tv: Remove unused mode_valid
Date:   Wed,  7 Sep 2022 10:35:04 +0200
Message-Id: <166253967461.2236193.2186831685710970121.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-34-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <20220728-rpi-analog-tv-properties-v2-34-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 15:11:48 +0200, Maxime Ripard wrote:
> The mode_valid implementation is pretty much a nop, let's remove it.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
