Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38065A4D36
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiH2NNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiH2NNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:13:10 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE7458B66
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:12:51 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 3A4012B05FD7;
        Mon, 29 Aug 2022 09:12:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Aug 2022 09:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778767; x=
        1661785967; bh=6PNL3E05HqgK9IW/MtDEQBeUSg/jnNc6krZQZz7WWqU=; b=S
        CrmkmWG+i+etfnzZ/jW3Y/UWhtS9n8Tx3Mi1wBI/2ps7AfxEAHmgC9ChWUa9RSX/
        fkIfNETMt9ipYhmeM2jNWGAeVHnDQeOdpzSivQXBg1z8viUKEHihiX6qUUwi8Icx
        WYELVnyFExAByIdK3vMTVoCIHtOiMAjEjtRl6UfBPOHkOQe6AAHqscTYxTunEdBR
        y0zBUpDKvNbHYKT2yKehiJXJ6DvcdgzrqEtSoOTsNAr6C5frVJGR91FZnsKJcn8S
        vI/I9R4rWZGVATEVVhWykj/ThLdsDQ5tHmxZy0lbzvkvsU4Soh0ABEuQbyiWyB0I
        /ko2ZM9j3xfI4EqgtVbfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778767; x=
        1661785967; bh=6PNL3E05HqgK9IW/MtDEQBeUSg/jnNc6krZQZz7WWqU=; b=s
        bCXQbOmwgGQejzwb7lDjTyCP4/nXAv1nQzo9pqqyVqE7JxCZe8fwO/6vxIMhmPS+
        9jXzOHoH56gSFpxXdj6b8NxHUO/m6QWvT9lZjU3TlMXNMttfWoxf+5rrHYMzClzh
        lRLACh7k0K3BLb/3j0m1/PQ/mKpYfnfaJY62uWUVr/r1eLe8Ww32IMHJNQ3faCf/
        G4iCgS8yZ+vB3vDgppF3MWGiUaExqKhHv9UsouScEg7Z+P3fwXRKqb/aqNKtTyyq
        uv5JMeFR0Dn0IUHQtdJfyQK5Iy8nrdJ5EcvqJLKl+RRGbOtq4ZUkNqTewP+RnYlR
        V2gQYsmjbYmJz02Pi8Nsw==
X-ME-Sender: <xms:T7sMY_jPT6dwQOA4BCu5LdXKEyY3JXwP_zk-LHkYdIBhyPpUCwvpDQ>
    <xme:T7sMY8B4agLnKGuRwwlFHsr00_SzMW7ZUfTz4HGmIk0TrQTvdEDBqSuSbDEuYOZkg
    Qnj5b_GTgRkAMvPnzA>
X-ME-Received: <xmr:T7sMY_FBMng_G1f4uWnfBSOYILxtXUpFCGZ7MHSM6BNKDWsMKm02O5FTQ2Da>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:T7sMY8QFtGEVYPHVigOnhSYdkOxABWsrfVHiGyWjWogYCw_MexauLg>
    <xmx:T7sMY8xQyNvqOR0x08HW_yCl8KDqoujGm1zjppqlEBgFWffoduCdDA>
    <xmx:T7sMYy5L2HGUCkedtkrToySWGVCELLnPoI8dhrpzF4SJjMLl8MPbcA>
    <xmx:T7sMY-olBjx9ozhnzgCaWgsvJW1Ydho-X4hekT6-pqvZPkUi-UqadSvzSvE>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:12:46 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 07/41] drm/connector: Only register TV mode property if present
Date:   Mon, 29 Aug 2022 15:11:21 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-7-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503; i=maxime@cerno.tech; h=from:subject:message-id; bh=360DckfKUI/oiBSyUvmkKcjfDELX/wp7WZq7mSLzHYY=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8u+R9F749fcX+URp/0+mNklts/+osLbExydeqlHnk5xCx cO2hjlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzEdwfDf2eNYsvfu42bnU+zT+xnfO Q79+f8ozt6fzV8Prf4WvmC2SGMDP31u7j2GFU3anCHMd34KpJz8v3pBU7M7drctyrSzPUOsgEA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp; fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_create_tv_properties() will create the TV mode property=0D
unconditionally.=0D
=0D
However, since we'll gradually phase it out, let's register it only if we=0D
have a list passed as an argument. This will make the transition easier.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
Acked-by: Noralf Tr=C3=B8nnes <noralf@tronnes.org>=0D
=0D
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connecto=
r.c=0D
index ede6025638d7..17a5913cefe3 100644=0D
--- a/drivers/gpu/drm/drm_connector.c=0D
+++ b/drivers/gpu/drm/drm_connector.c=0D
@@ -1686,15 +1686,18 @@ int drm_mode_create_tv_properties(struct drm_device=
 *dev,=0D
 	if (drm_mode_create_tv_margin_properties(dev))=0D
 		goto nomem;=0D
 =0D
-	dev->mode_config.legacy_tv_mode_property =3D=0D
-		drm_property_create(dev, DRM_MODE_PROP_ENUM,=0D
-				    "mode", num_modes);=0D
-	if (!dev->mode_config.legacy_tv_mode_property)=0D
-		goto nomem;=0D
 =0D
-	for (i =3D 0; i < num_modes; i++)=0D
-		drm_property_add_enum(dev->mode_config.legacy_tv_mode_property,=0D
-				      i, modes[i]);=0D
+	if (num_modes) {=0D
+		dev->mode_config.legacy_tv_mode_property =3D=0D
+			drm_property_create(dev, DRM_MODE_PROP_ENUM,=0D
+					    "mode", num_modes);=0D
+		if (!dev->mode_config.legacy_tv_mode_property)=0D
+			goto nomem;=0D
+=0D
+		for (i =3D 0; i < num_modes; i++)=0D
+			drm_property_add_enum(dev->mode_config.legacy_tv_mode_property,=0D
+					      i, modes[i]);=0D
+	}=0D
 =0D
 	dev->mode_config.tv_brightness_property =3D=0D
 		drm_property_create_range(dev, 0, "brightness", 0, 100);=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
