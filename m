Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E25A4D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiH2NQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiH2NQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:16:21 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BADFD3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 06:15:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 1EB102B0606F;
        Mon, 29 Aug 2022 09:14:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 29 Aug 2022 09:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1661778880; x=
        1661786080; bh=j2xVn9DQqZPAbk7DRoXYb3Gc5hDkTHCbiLk8VjWo/kk=; b=e
        W3j3X3F1dNP+pa/mcTJLoDMJqZBef4D/FGT1sPX4/CUeEpPKponvnnrEfXDmFBgW
        0Nub1MuB1jlLAg/EzhjXasY8BJUQ8rKpHIhcMKQh61X8TJfZsAxPI/jJnpc24i90
        amfoHYudd41jeY0PkAw7Jp/Fcu79hBGKQIp4/5g8zG3whwSC2XXJxiqJUBJamYBs
        /SqSk4izVhzmg7fSYZdJkXJf8tSmPWUhoa6V49XHefL01GJA2dx5AR2S1A6oV3Gc
        FncuE4NhSo/1roMVoYOH1bKkMMq0z+E3bkpBugIXnIl2MM3fsGVUdg9EAZcujSKu
        85ZZzfRCjIjbUg1WWfj6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1661778880; x=
        1661786080; bh=j2xVn9DQqZPAbk7DRoXYb3Gc5hDkTHCbiLk8VjWo/kk=; b=R
        HBNrPu/uPbhJTXjGYBfVwYJnJN3W4TTcnoJ3vA0o7bJq86e2MA+10nN6ul7AbD37
        jVqeMevFjyloNkTLwRwQpNle6qq0HueW3Z1b3XTkmD61LWaWJIGRvOdgm32a/Xd0
        TkifOGVrVAi9wCnTHlUdfeOcaXKQK6sRrTS5QreBHaSKp5KJhuCn6xAV85d66/Ow
        MW+sGOR0ogvbG9B94FjPdrFgp+P0q983icXxiPxEy0oJ4Vlp1DyHC6OVHN8onIHY
        UvZRZMbKEb/ELFDqnDG2OWte0uSu+63ry4ZDBYgcC7acx7bPmVZHu2+7S71OPgQl
        R7KxYA08ud/pbOMvcV8Cw==
X-ME-Sender: <xms:wLsMY1NekOJvxc_t9tAGy9mE_YZCC630Jsknh-TDy-wK_jzugvAljA>
    <xme:wLsMY3_XsGJu6S8ULZCYbAdSSxKe-9Z3WHOPVgxV2OGN7AJkIoexttVmIAO5kaSjc
    rwZBt4htsUNe__QrBA>
X-ME-Received: <xmr:wLsMY0QzXKmM-RlRXXfub5YUGjDBc_TIi7VLYEPYEVTAmrFjgJa3H-nWlqua>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfogfesthhqredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeefiedvfefggffgffehveejieffuddtgffhjefggeetieduvdeileet
    lefgveegtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wLsMYxtY5HFuMIuHg1D34nW9s-bvI5G1aJdF3kUGOVkqQgn5YsYwEQ>
    <xmx:wLsMY9eJiYQbhUO7N6FRJiFjjIeTWlZOaX3hdPmmltuGqZu2wBQS3g>
    <xmx:wLsMY912gQU1m3gcNa1mkC1SNypESQ5blsOxESnBQF6Gwg6u_k0Vlg>
    <xmx:wLsMYzHW6Ip96oCKchx9zN31DvAn_RpDnv6qmUWlyApecVVNVWuWLZrUAbY>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Aug 2022 09:14:39 -0400 (EDT)
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
Subject: [PATCH v2 24/41] drm/vc4: vec: Remove empty mode_fixup
Date:   Mon, 29 Aug 2022 15:11:38 +0200
Message-Id: <20220728-rpi-analog-tv-properties-v2-24-459522d653a7@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-65ba7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=maxime@cerno.tech; h=from:subject:message-id; bh=wQYMsg2bmhLsKtW1lnmR3k72TWcOcF4pQQLI7ZjpLm0=; b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMk8uxQqthccT5d7kl7cGP7Z2vzITQYBtV97u7dd+v/Ya6bS jAb2jlIWBjEuBlkxRZYYYfMlcadmve5k45sHM4eVCWQIAxenAEzkqQ4jw9L3sqcktpqIlbzZcln/k6 C34ko95pNZC9sU98xq3jih5SwjQ5dQc8fjcOFz9xle79zLrRrpuTpw68Zld2Q5+rb8bPfN4QUA
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

The mode_fixup hooks are deprecated, and the behaviour we implement is the=
=0D
default one anyway. Let's remove it.=0D
=0D
Signed-off-by: Maxime Ripard <maxime@cerno.tech>=0D
=0D
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c=
=0D
index d5140fe0be4f..d521ffd8d75c 100644=0D
--- a/drivers/gpu/drm/vc4/vc4_vec.c=0D
+++ b/drivers/gpu/drm/vc4/vc4_vec.c=0D
@@ -483,14 +483,6 @@ static void vc4_vec_encoder_enable(struct drm_encoder =
*encoder)=0D
 	drm_dev_exit(idx);=0D
 }=0D
 =0D
-=0D
-static bool vc4_vec_encoder_mode_fixup(struct drm_encoder *encoder,=0D
-				       const struct drm_display_mode *mode,=0D
-				       struct drm_display_mode *adjusted_mode)=0D
-{=0D
-	return true;=0D
-}=0D
-=0D
 static void vc4_vec_encoder_atomic_mode_set(struct drm_encoder *encoder,=0D
 					struct drm_crtc_state *crtc_state,=0D
 					struct drm_connector_state *conn_state)=0D
@@ -518,7 +510,6 @@ static int vc4_vec_encoder_atomic_check(struct drm_enco=
der *encoder,=0D
 static const struct drm_encoder_helper_funcs vc4_vec_encoder_helper_funcs =
=3D {=0D
 	.disable =3D vc4_vec_encoder_disable,=0D
 	.enable =3D vc4_vec_encoder_enable,=0D
-	.mode_fixup =3D vc4_vec_encoder_mode_fixup,=0D
 	.atomic_check =3D vc4_vec_encoder_atomic_check,=0D
 	.atomic_mode_set =3D vc4_vec_encoder_atomic_mode_set,=0D
 };=0D
=0D
-- =0D
b4 0.10.0-dev-65ba7=0D
