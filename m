Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71690471B7A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 17:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhLLQGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 11:06:19 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:59875 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLLQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 11:06:18 -0500
Date:   Sun, 12 Dec 2021 16:06:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acoro.eu;
        s=protonmail3; t=1639325175;
        bh=58J3xn/bCtRIZhmEH6XTE/KJPyH/4XpTgvWYSnoD75Y=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=R/J28pha7lteLLvHIZA04J/cYQaE718BZ3dU4GJQoetCdslXf92+wxyOB7Wy1e4q3
         iuEyaehymm6DdH14+jSbC0N3oMc/snUJkBXH5Z9w94FbFfeuungyIooOg+ls6NLmdY
         P1fyAO5CePUzwCG5FU12j4+93MnR1T5K7xO/BJV32+FJtgNSGqMbTA0sO8B8QYmjF0
         QbDGcLCVVgksX/Q92UoLCYBKNYiRhnM1vqmjO/IDBusNXb2NdHYQHbD8bwcTkBtbIn
         IMkDuJ2JHb7Lu47DXP1xEtcgtZAd42MgSQZhYe7Gn5W4g/YeJKYSs9rOlSaKXmrB0J
         T9TuYqwBispew==
To:     tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        maxime@cerno.tech, dri-devel@lists.freedesktop.org
From:   Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
Cc:     linux-kernel@vger.kernel.org, asconcepcion@acoro.eu
Reply-To: Alejandro Concepcion-Rodriguez <asconcepcion@acoro.eu>
Subject: [PATCH] drm: simpledrm: fix wrong unit with pixel clock
Message-ID: <6f8554ef-1305-0dda-821c-f7d2e5644a48@acoro.eu>
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

