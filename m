Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008634719F1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhLLMFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:05:44 -0500
Received: from mail-4317.proton.ch ([185.70.43.17]:50746 "EHLO
        mail-4317.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhLLMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:05:43 -0500
Date:   Sun, 12 Dec 2021 12:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail3; t=1639310741;
        bh=58J3xn/bCtRIZhmEH6XTE/KJPyH/4XpTgvWYSnoD75Y=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=YHaddwk5k8n8rWsrA3+dfhL3zs/X9A1fvOH7hkmaQE95Xbu9r+vUyVPN9eiEGQL/m
         lwBQj/7klm5WTyXWS98xrE4OwMiFQxxHenjOn++ObQ9bbdITlbX3DO8Nu7x6bvJ+YP
         say+lQ66WUetM7uZsQ0+jgl0mlA3c1HueghRQcWkkgZauUvNDoJqukTxs1ng+W8c4o
         Jzkfqg6QOXTFKoGMZwQZUkmvX8hZ0CYzOzIfGWs4ATzlhdWEHVMKDoJVbyFB46hmE2
         kdqavvgGMAGNgkrgBiJDo8uROs7o5oPsKTNUD3sOicbtxaCV+2psrCOp2bJthScqpy
         ewT4+f/+WSn7g==
To:     tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech
From:   Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
Subject: [PATCH] drm: simpledrm: fix wrong unit with pixel clock
Message-ID: <3c4ed29d-1cc7-8346-03e8-1cdc05fe2e9b@acoro.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pixel clock has to be set in kHz.

Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")

Signed-off-by: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simple=
drm.c
index 2f999915b9aa..562bf09f9140 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -459,7 +459,7 @@ static struct drm_display_mode simpledrm_mode(unsigned =
int width,
 {
 =09struct drm_display_mode mode =3D { SIMPLEDRM_MODE(width, height) };

-=09mode.clock =3D 60 /* Hz */ * mode.hdisplay * mode.vdisplay;
+=09mode.clock =3D mode.hdisplay * mode.vdisplay * 60 / 1000 /* kHz */;
 =09drm_mode_set_name(&mode);

 =09return mode;
--
2.25.1

