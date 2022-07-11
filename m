Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3145570A98
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiGKTUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGKTU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 15:20:28 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B783AB14
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yeatAA7c4woASlu6p943MCUP6aWF68CFbJiBR8Awayc=; b=QScllVEELXl/YZKDOJRngNzOdT
        Ujzm65/KqIljrVyVD09HcG2/19c/Nw4cmeYOelWDLJ80UoN1cPcl40pvHQT+CJTY6LYMrc/Ll6TTT
        zeDhS0R9+FVU3HU+YJbT1Ta4+Ibf6HicD+tlgH55FMEv4/YKB+v92xJjlwfT+L4vLT+8KhAy/F+h3
        fOGP2Ce2dD70tSWeZWuJPVKrRZpy6YTZerO8tg/uufS9tjL7tAWEpuT7skd3uYla67jGcOc2fNonU
        bNHr/YZWPpYGoWj/fszONb8hrQUoD6VUkMPsYcRucYe+UFV+5Y+JAcOH49VVAoWpBm0dwydAB9Yyk
        GdV1BB5g==;
Received: from [177.45.248.119] (helo=localhost.localdomain)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oAyxC-00CJom-VR; Mon, 11 Jul 2022 21:20:23 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
        'Pan Xinhui' <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 1/2] drm/amd/pm: Add GFXOFF registers for vangogh
Date:   Mon, 11 Jul 2022 16:19:52 -0300
Message-Id: <20220711191953.145518-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711191953.145518-1-andrealmeid@igalia.com>
References: <20220711191953.145518-1-andrealmeid@igalia.com>
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

Add register values to access GFXOFF data for vangogh GPU.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
index 8361ebd8d876..9c7b0004d842 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu11_driver_if_vangogh.h
@@ -279,4 +279,16 @@ typedef enum {
 #define TILE_ISPPRE_MASK    ((1<<6) | (1<<7))
 #define TILE_ISPPOST_MASK   ((1<<8) | (1<<9))
 
+// Registers related to GFXOFF
+// addressBlock: smuio_smuio_SmuSmuioDec
+// base address: 0x5a000
+#define mmSMUIO_GFX_MISC_CNTL			0x00c5
+#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX		0
+
+//SMUIO_GFX_MISC_CNTL
+#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff__SHIFT	0x0
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT		0x1
+#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff_MASK	0x00000001L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK		0x00000006L
+
 #endif
-- 
2.37.0

