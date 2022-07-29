Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47458538D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiG2QhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237411AbiG2Qg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:36:59 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CC83F09
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 09:36:58 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 120AB580987;
        Fri, 29 Jul 2022 12:36:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 29 Jul 2022 12:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1659112618; x=
        1659119818; bh=KPOI4/TXZTWMxLhqbVA9Fbfap16PAXSDXDUftOCVS/Q=; b=Z
        SvEofhte+UnkbZTWldfewQfZE53m3+a+dxFnpzIXi5Qsri/rdiSmWjlXNfX1B6wf
        lQLFNC6aqqLrhAyMbkhjOAXgQbP/zx0DaCcWjkXRj+2324xBf0Zwsn8K81M+VqP7
        KIfLtPfZ+s1pEV9tioIsnSrP73TXhurck5XNJ4OXwC+iQMisiG/dnVCWWtdK+NWS
        SIFr8DoR20UVvyxTedG7cKaDFzvQnlCGd8UW9PAQsGXf+4kurJi7kXs8WK7rdi7j
        lE6vcMsokUH8TWMhIBxBo43CEj/mLnIUr5/WBNnHb5rc7t6uriXQRF+mXNu3GYZc
        NP87o0fX7LAim2cCy88YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1659112618; x=
        1659119818; bh=KPOI4/TXZTWMxLhqbVA9Fbfap16PAXSDXDUftOCVS/Q=; b=h
        32uz+j2a2L/Huo9mna3KEPDvPLAa3pVj78Ipdn6Gb/NVxBCV+3sv/hcE+8YNcdd5
        U+d5HHhL8Qc6BKKSmpCZZRU+WiC23SFDE8aqti+nNGkkzPY5L/oXeF4olgL1BOFD
        AFZOnZdo+UK1BGms7Har+xAV/roS5bZFl9Jfole3ZlsraAdIfERIlxHiPavOWdI8
        wy9P5j412Ct+bKyDWzIvo/q/BCWGxAj/Gt8vII5f9xvv2dBgu1f8CFtxmIFpJ2+c
        FeBWHFoISHNm2sAC1JkqKTkjonAne6A2l0SOoGj0FRewfBOTg/o0e29M0Di4Vwrb
        VFAmhpLUwwoLDKZ6o9e4g==
X-ME-Sender: <xms:qQzkYpzloqQfoT_acDyNQtwnAChbN30XjkWGJKF0rwlRCFp0HdK3Ew>
    <xme:qQzkYpQHbK8oAtnqCw-8NzhqJfrj5D1cwHuQ3YdKdX22Z17aH68p3hIkUzbQE5jHZ
    rLOyL8HDp1vfKkc5To>
X-ME-Received: <xmr:qQzkYjWKngt5fDyW7s9sj6tqE6yR8JMmobF7JB4ygevesrsIl5QrP40yCf7cPe0EVVLRM0qioQ1GhYv0Uqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddujedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfgggtoffgsehtkeertdertdejnecuhfhrohhmpefo
    rgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecugg
    ftrfgrthhtvghrnhepgfffgfetffduudelhfevieffffduleevgfegkeeutefgffejheel
    leekjeefhfejnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrh
    homhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:qQzkYrjiawb3_zSB04cqWyXGMTtPgHxCxfS74cg1CMsHespIBFuWWA>
    <xmx:qQzkYrCchHeEeb-4Olku7epOZ27yxBCD1LzLXXZFhsz_X4D9Oj6LSw>
    <xmx:qQzkYkJzY5vPvIpMHGtch6z4FRbNG59Gwz0rZBJzjTQIwDvfzd9EcQ>
    <xmx:qgzkYtyqp0pqKektVuKakc57RnaxNqFRSl46UC4jHpEFywzrnkWIaw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Jul 2022 12:36:56 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: [PATCH v1 25/35] drm/sun4i: tv: Remove unused mode_valid
Date:   Fri, 29 Jul 2022 18:35:08 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v1-25-3d53ae722097@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-49460
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=maxime@cerno.tech; h=from:subject:message-id; bh=Z/IvtOhxkP1S2d5G4fie4sSqHzE+LzlsmSMCeFD/rMo=; b=owGbwMvMwCHc4XzqmfnC7acZT6slMSQ94VFavOB2svwPZSF582fnpi7503Rwfds+16buhsA+uX/x 1x96dJSyMAhzMMiKKbJcF3xrxxcW5RbB82EzzBxWJpAhDFycAjCRA2GMDLffJF6ofa74ccbHIPejZq 4lLZs7Cnavy288/6lQk/nmoxMM/ytPa7zaWqP1ITPg1oMlk69OuH5ksmyLpmqEf6nGHRG7vscA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp; fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mode_valid implementation is pretty much a nop, let's remove it.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>

diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 94883abe0dfd..53152d77c392 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -497,16 +497,8 @@ static int sun4i_tv_comp_get_modes(struct drm_connector *connector)
 	return i;
 }
 
-static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
-				    struct drm_display_mode *mode)
-{
-	/* TODO */
-	return MODE_OK;
-}
-
 static const struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_funcs = {
 	.get_modes	= sun4i_tv_comp_get_modes,
-	.mode_valid	= sun4i_tv_comp_mode_valid,
 };
 
 static void

-- 
b4 0.10.0-dev-49460
