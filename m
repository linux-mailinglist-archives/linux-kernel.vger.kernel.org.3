Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA2547A91
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiFLOtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 10:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiFLOtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 10:49:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE534B85
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:49:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so6566896eja.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 07:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jc9EKbluzjQbPf5iJBQyy57Za56oj94XsJi9//DUTBs=;
        b=QAe6zVMMuPfsOQVPhxjW7XQINSyvokcP1UXdDMRe3lQrtwNAX48p8aTaJq+fVtUi2W
         tdKGv1ukA3ximfBZb+wbyixuIibc+PNndOgm0dQmTnezjVki/HaSY3bW2E63Ce9htt6q
         OyI2DQuX5UQ6ukHBMmmH6YcQHHH2f0dbWFjOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jc9EKbluzjQbPf5iJBQyy57Za56oj94XsJi9//DUTBs=;
        b=DW8pkoa0Y7ZOokLQYBun1qPvj39KsT0hsjriMop/cXE6GeCyIhbVw4NBNGwqVun0mN
         89RMHduuQRt3n1oDHxTbu+6GIUg94a9lYCk4KwtFk0UftbBHOHjKp1rhYbdSc4EePCGt
         KmTxEvnV3WI80yOO1TXftzY/g1QH5IRF8v72jLYoXTxL50TvJBUfJffdH+uLXs5qYTa5
         NrlB5aTJIzPFnGjqrNqXALnR2MMgn35Xz+yyemxSIk2eGx377xvLB+2EfL2RBDuF8uNK
         pF/uTrDLZdGP9txnCCJR120fvdXsfFmQGBTUseErid8vMsRN/jF+spJ5vJ+Ieu//towq
         Oxww==
X-Gm-Message-State: AOAM531s1ylsB+yZjvgT04m3Eg6hUrSXjGCoWVBimlkSWCeYVowic1mv
        XATFLsHt2KMjWlymPcGrrIIbWQ==
X-Google-Smtp-Source: ABdhPJyvv3bZy0x8EdZVGn713v6ewfo8zGpqATwhEb2GGbMj9l6HERl46xAPhCd2QbNHUwuDFardFg==
X-Received: by 2002:a17:907:da2:b0:711:f408:f098 with SMTP id go34-20020a1709070da200b00711f408f098mr20945715ejc.208.1655045357616;
        Sun, 12 Jun 2022 07:49:17 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id cm20-20020a0564020c9400b004316f94ec4esm3257076edb.66.2022.06.12.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 07:49:17 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Archit Taneja <architt@codeaurora.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] drm: bridge: adv7511: unregister cec i2c device after cec adapter
Date:   Sun, 12 Jun 2022 16:48:54 +0200
Message-Id: <20220612144854.2223873-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612144854.2223873-1-alvin@pqrs.dk>
References: <20220612144854.2223873-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

cec_unregister_adapter() assumes that the underlying adapter ops are
callable. For example, if the CEC adapter currently has a valid physical
address, then the unregistration procedure will invalidate the physical
address by setting it to f.f.f.f. Whence the following kernel oops
observed after removing the adv7511 module:

    Unable to handle kernel execution of user memory at virtual address 0000000000000000
    Internal error: Oops: 86000004 [#1] PREEMPT_RT SMP
    Call trace:
     0x0
     adv7511_cec_adap_log_addr+0x1ac/0x1c8 [adv7511]
     cec_adap_unconfigure+0x44/0x90 [cec]
     __cec_s_phys_addr.part.0+0x68/0x230 [cec]
     __cec_s_phys_addr+0x40/0x50 [cec]
     cec_unregister_adapter+0xb4/0x118 [cec]
     adv7511_remove+0x60/0x90 [adv7511]
     i2c_device_remove+0x34/0xe0
     device_release_driver_internal+0x114/0x1f0
     driver_detach+0x54/0xe0
     bus_remove_driver+0x60/0xd8
     driver_unregister+0x34/0x60
     i2c_del_driver+0x2c/0x68
     adv7511_exit+0x1c/0x67c [adv7511]
     __arm64_sys_delete_module+0x154/0x288
     invoke_syscall+0x48/0x100
     el0_svc_common.constprop.0+0x48/0xe8
     do_el0_svc+0x28/0x88
     el0_svc+0x1c/0x50
     el0t_64_sync_handler+0xa8/0xb0
     el0t_64_sync+0x15c/0x160
    Code: bad PC value
    ---[ end trace 0000000000000000 ]---

Protect against this scenario by unregistering i2c_cec after
unregistering the CEC adapter. Duly disable the CEC clock afterwards
too.

Fixes: 3b1b975003e4 ("drm: adv7511/33: add HDMI CEC support")
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 5bb9300040dd..023c0ad132e0 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1339,9 +1339,6 @@ static int adv7511_remove(struct i2c_client *i2c)
 {
 	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
 
-	i2c_unregister_device(adv7511->i2c_cec);
-	clk_disable_unprepare(adv7511->cec_clk);
-
 	adv7511_uninit_regulators(adv7511);
 
 	drm_bridge_remove(&adv7511->bridge);
@@ -1349,6 +1346,8 @@ static int adv7511_remove(struct i2c_client *i2c)
 	adv7511_audio_exit(adv7511);
 
 	cec_unregister_adapter(adv7511->cec_adap);
+	i2c_unregister_device(adv7511->i2c_cec);
+	clk_disable_unprepare(adv7511->cec_clk);
 
 	i2c_unregister_device(adv7511->i2c_packet);
 	i2c_unregister_device(adv7511->i2c_edid);
-- 
2.36.1

