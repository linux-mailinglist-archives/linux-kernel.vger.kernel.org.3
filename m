Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608F35A4D47
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiH2NOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiH2NN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:13:59 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37EF6E2E8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:13:44 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 1333B2B0605B;
        Mon, 29 Aug 2022 09:13:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 Aug 2022 09:13:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778815; x=
        1661786015; bh=3cA2OufWoWcBPPMmarJbJeQBU07cKTKh4Zqak42tigI=; b=d
        fcn2HpCWlVWvu+ZDmYxNviyOJbpvJdb/sYJ199sfj/4zTzwqX3F3kDyz//ABqsXo
        QevIYkHKvr6IS4GSCa8GWgmPx/oMwFGPl4AlHQD3KldhC6xmaidxTK7aIDUY2FpU
        flWCO1wi140aovdzyz5hSXzeM/qvS7xwAwfXRdgbudGr7tAz0M+RentzR1vvL4fK
        fVCg87KGfcA1N54Y3gqqfnPrIMQ10sBmtIl2eX8MFYrYpk3QIP/r9HoX4sw0tJ6N
        HR+N2tu9TbdpYNOqEwsJQHYFz8nKz/vHNQ5eNDB0gfJPczKsqVrBl6oSFb7dQGss
        7v8cDuWC9/6J/123S9Ksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778815; x=
        1661786015; bh=3cA2OufWoWcBPPMmarJbJeQBU07cKTKh4Zqak42tigI=; b=A
        F8ztcmvlKScp5VD6dfscZkkYSH8pULe5JhGdlrn6D9tmou1xfNGuPyGsDapUuLfO
        /L8Gndt+HjsZafQiZmNFdj52f+hC+4MOM/1TLqmTd/Kx6RkAFBnfdA/Si3G4bvhV
        rXjRqc0RC8CwJ4et9/aqFiNNLRATcbyO/30ZJ5+dARQd4rqWwlglVrGpoK8z2gVy
        38E+g6SB6s1Inbeni/IvT3orEwQxm/4Y1GCm71Gzn5s2sAlGm9FKt5jCo+kJDTuU
        TCvRzwecZ4o/jEis6VXvRuibvq7XHB+NfQE/de8Rk8sizcLhMZl/SVIuGqpkMKPg
        C1WgQ2XKAVj2D8yOcpKyQ==
X-ME-Sender: <xms:f7sMYwBYyxBXYPskpifZLcm_WtuDBb-CiIOd6pqk_YTNkQWOLq-P-Q>
    <xme:f7sMYyiUmj-sFw-W8Q7ueECkOA1_KVODvauH8LzYEfpOT3GHMyMzs_8ZjOBoWAYnp
    T-PNlJFhXBUJWzcJeg>
X-ME-Received: <xmr:f7sMYzldLTLmEwpvhYBBOYcCkS84dksq-I8h8U6TknWjSldqLhYqGfO_rT4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:f7sMY2xTgcLM6NuLd9q_7YHtmYGJrt5R0TUD1_gKnzQ0N4f5Y4DMag>
    <xmx:f7sMY1RR180C4FEVfn2yxHnpq9b-VBDxFLFkbX0-9AL5rCSJ_RspwA>
    <xmx:f7sMYxa1FWqvbo5UkkzfcXi6GUr5Ya3DjapW-mClEdBzbkY9DA-byw>
    <xmx:f7sMYxLaJC9tEncZD5g9Tspw7nDRtDlUh2e3b1CtRGU3dWMrpMUTRtWkfy4>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:13:34 -0400 (EDT)
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
Subject: [PATCH v2 14/41] drm/modes: Move named modes parsing to a separate function
Date:   Mon, 29 Aug 2022 15:11:28 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-14-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3500; i=maxime@cerno.tech; h=from:subject:message-id; bh=g78xF6eprUFyI1I3Lc8j/JkwaSEg8YsZvbc0EnOZ45M=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8u+SntIuc3+vdVhvklq0t6iPJ8vjeinP9jYWK700fLs99 pfqoo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABMR2MDwm505M9T4i4pTmdgHn63Gea G1lZaxIpt3mp7btLm6aWVuM8P/RPs5Lz69DDuo1bb40m3fmT1qnnO1W/mW/XOZpPIu+9dufgA=
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

The current construction of the named mode parsing doesn't allow to extend=
=0D
it easily. Let's move it to a separate function so we can add more=0D
parameters and modes.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c=0D
index 99a21e5cd00d..0636cb707544 100644=0D
--- a/drivers/gpu/drm/drm_modes.c=0D
+++ b/drivers/gpu/drm/drm_modes.c=0D
@@ -1909,6 +1909,9 @@ void drm_connector_list_update(struct drm_connector *=
connector)=0D
 }=0D
 EXPORT_SYMBOL(drm_connector_list_update);=0D
 =0D
+#define STR_STRICT_EQ(str, len, cmp) \=0D
+	((strlen(cmp) =3D=3D len) && !strncmp(str, cmp, len))=0D
+=0D
 static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,=0D
 				      struct drm_cmdline_mode *mode)=0D
 {=0D
@@ -2208,6 +2211,52 @@ static const char * const drm_named_modes_whitelist[=
] =3D {=0D
 	"PAL",=0D
 };=0D
 =0D
+static int drm_mode_parse_cmdline_named_mode(const char *name,=0D
+					     unsigned int name_end,=0D
+					     struct drm_cmdline_mode *cmdline_mode)=0D
+{=0D
+	unsigned int i;=0D
+=0D
+	if (!name_end)=0D
+		return 0;=0D
+=0D
+	/* If the name starts with a digit, it's not a named mode */=0D
+	if (isdigit(name[0]))=0D
+		return 0;=0D
+=0D
+	/*=0D
+	 * If there's an equal sign in the name, the command-line=0D
+	 * contains only an option and no mode.=0D
+	 */=0D
+	if (strnchr(name, name_end, '=3D'))=0D
+		return 0;=0D
+=0D
+	/* The connection status extras can be set without a mode. */=0D
+	if (STR_STRICT_EQ(name, name_end, "d") ||=0D
+	    STR_STRICT_EQ(name, name_end, "D") ||=0D
+	    STR_STRICT_EQ(name, name_end, "e"))=0D
+		return 0;=0D
+=0D
+	/*=0D
+	 * We're sure we're a named mode at that point, iterate over the=0D
+	 * list of modes we're aware of.=0D
+	 */=0D
+	for (i =3D 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {=0D
+		int ret;=0D
+=0D
+		ret =3D str_has_prefix(name, drm_named_modes_whitelist[i]);=0D
+		if (ret !=3D name_end)=0D
+			continue;=0D
+=0D
+		strcpy(cmdline_mode->name, drm_named_modes_whitelist[i]);=0D
+		cmdline_mode->specified =3D true;=0D
+=0D
+		return 1;=0D
+	}=0D
+=0D
+	return -EINVAL;=0D
+}=0D
+=0D
 /**=0D
  * drm_mode_parse_command_line_for_connector - parse command line modeline=
 for connector=0D
  * @mode_option: optional per connector mode option=0D
@@ -2244,7 +2293,7 @@ bool drm_mode_parse_command_line_for_connector(const =
char *mode_option,=0D
 	const char *bpp_ptr =3D NULL, *refresh_ptr =3D NULL, *extra_ptr =3D NULL;=
=0D
 	const char *options_ptr =3D NULL;=0D
 	char *bpp_end_ptr =3D NULL, *refresh_end_ptr =3D NULL;=0D
-	int i, len, ret;=0D
+	int len, ret;=0D
 =0D
 	memset(mode, 0, sizeof(*mode));=0D
 	mode->panel_orientation =3D DRM_MODE_PANEL_ORIENTATION_UNKNOWN;=0D
@@ -2285,17 +2334,19 @@ bool drm_mode_parse_command_line_for_connector(cons=
t char *mode_option,=0D
 		parse_extras =3D true;=0D
 	}=0D
 =0D
-	/* First check for a named mode */=0D
-	for (i =3D 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {=0D
-		ret =3D str_has_prefix(name, drm_named_modes_whitelist[i]);=0D
-		if (ret =3D=3D mode_end) {=0D
-			if (refresh_ptr)=0D
-				return false; /* named + refresh is invalid */=0D
 =0D
-			strcpy(mode->name, drm_named_modes_whitelist[i]);=0D
-			mode->specified =3D true;=0D
-			break;=0D
-		}=0D
+	if (mode_end) {=0D
+		ret =3D drm_mode_parse_cmdline_named_mode(name, mode_end, mode);=0D
+		if (ret < 0)=0D
+			return false;=0D
+=0D
+		/*=0D
+		 * Having a mode that starts by a letter (and thus is named)=0D
+		 * and an at-sign (used to specify a refresh rate) is=0D
+		 * disallowed.=0D
+		 */=0D
+		if (ret && refresh_ptr)=0D
+			return false;=0D
 	}=0D
 =0D
 	/* No named mode? Check for a normal mode argument, e.g. 1024x768 */=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
