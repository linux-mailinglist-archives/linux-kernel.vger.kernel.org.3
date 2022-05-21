Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB85D52FEED
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344891AbiEUTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344530AbiEUTOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 15:14:14 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B60D4BB9C
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 12:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=7vIT+lsmvfOs/mOlYOd+9SsSCqSed33kzxsCCfpa+Qs=; b=Ld/fOuJBZ2DPBIp68qeHncnz0N
        4L4rMFExhnheS+F0Wqwi3XqmEVGrTYyWAY+CPfLoeQGnp/U3rWq8DY5kZBGX7S6gXNmxPpGNnf6Qe
        J90k06bVWBuHg+pkxKxislOe/oICfEA/AmoJtJ2ib0ia1r6MrWgr+VQVJn9qBEkuCS1YWgmFm6U4J
        Ggz+UFM+mV+NXbU8vNtiSaiaAAr/MJPoL3pf0xKNzTTWrVW/k4te76M4i+jAfNWvNg3/TxM3fMOyJ
        t52zvtPRqb8RRt/IWvQo0jh/3iiSDkiCKJ2XmCwNEhR+wbflyCiT+/qrFLCDnCtygBmIz2v6ZCtC8
        tD4+qGQA==;
Received: from [177.25.82.44] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nsUY7-00E4bD-WF; Sat, 21 May 2022 21:14:04 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] drm/vkms: Update vkms_composer_worker documentation
Date:   Sat, 21 May 2022 16:13:42 -0300
Message-Id: <20220521191342.23520-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit ba420afab565 ("drm/vkms: Bugfix racing hrtimer vblank
handle") the work is scheduled at vkms_vblank_simulate() and since
commit 5ef8100a3919 ("drm/vkms: flush crc workers earlier in commit
flow") the work is flushed at vkms_atomic_commit_tail(). Update function
commment to reflect that.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index c6a1036bf2ea..914c0ac7dc8b 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -213,7 +213,7 @@ static int compose_active_planes(void **vaddr_out,
  *
  * Work handler for composing and computing CRCs. work_struct scheduled in
  * an ordered workqueue that's periodically scheduled to run by
- * _vblank_handle() and flushed at vkms_atomic_crtc_destroy_state().
+ * vkms_vblank_simulate() and flushed at vkms_atomic_commit_tail().
  */
 void vkms_composer_worker(struct work_struct *work)
 {
-- 
2.36.0

