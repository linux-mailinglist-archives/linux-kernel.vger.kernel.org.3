Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104F346844E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384837AbhLDLAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384734AbhLDK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:59:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36353C061354
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:55:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id p8so11210512ljo.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KpJG+dZIKMWfHUy9cRIbi/fWUlXgNegU2DlqIwxqCCg=;
        b=XSuEd/aztjZTNFkVTdND9ThEpZC8tfRUibgQ0FbuO+Y9pTS9AIFhjcM59HnI1TMibt
         pkLkC8Tu/km/G3bs+gRczOpS1fyIWVtvknfTft6mcrbTqn+17snNs+zzedOGKanu6wnS
         oG0YyYqtaj5WYteewkMioSabHEek0sCxzA0OtKvE9YO1Xi8cmsYFpc/iR2uPiVxKJK/m
         iQ8TQWTC7H8+R5ooTzd8OWTRMkR9/2PkwlqGI67c37kb9weU4u4HQCadsLDAVMKb2ro1
         2BK3mq8F/8bqRxwE1zLa4+Spy8m0VJ9VfYRfHs3wTu9QOC75X9Uojny3U3ytkV9LRWJh
         Qlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KpJG+dZIKMWfHUy9cRIbi/fWUlXgNegU2DlqIwxqCCg=;
        b=8QGmIxAVCNeLENsMQJIEZK0Ona6tug6Wv43kE9bNelVlo4OBFV/vv0ankVE1Bk41io
         BZvdzJAEpEfrBCbYSRM0U0Y58wW3cuDB/T+RwQnm44df6Zukyhrw8qWAp7VoRW1808mR
         jxz80tjmBS8bIWFEpXBRaW6w85Bzi46Zz85rKgg09NgElQTl6xM/5JSDE6T3RBXzmk+g
         JJJi8wSyO1004YFW3aOc28rZ4qVPm+bSEB7U1dXXCIJ+B5d1/vK/MNy0myacf+qfWoPC
         BcKd1I6vKs+EoW9YQRClvkhJS5qnrV26i75qZVdhSzRn8tbidlVUvsU5S+NEf8quyIR6
         zXCg==
X-Gm-Message-State: AOAM533bqZPiMWK3ld4WJmT3nLv9BNrs+bBCeAn1unlu58UB55+bPJGQ
        qE1fsJHvqsjF3vnfvoMl6Og=
X-Google-Smtp-Source: ABdhPJwR00P/dErhD2wD/pyjqENrBh+9h5sjMb5T9+VNLzmG+b3L31NMSBiUlvXBCEk8Sxocwb3p+A==
X-Received: by 2002:a2e:a482:: with SMTP id h2mr23375178lji.87.1638615342575;
        Sat, 04 Dec 2021 02:55:42 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id d23sm723918lfm.107.2021.12.04.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 02:55:42 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 8/9] drm/i915/gvt: Constify gtt_type_table_entry
Date:   Sat,  4 Dec 2021 11:55:26 +0100
Message-Id: <20211204105527.15741-9-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
References: <20211204105527.15741-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never modified, so make it const to allow the compiler to put it
in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index c8cd6bf28ea8..614156856f16 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -185,7 +185,7 @@ struct gtt_type_table_entry {
 		.pse_entry_type = pse_type, \
 	}
 
-static struct gtt_type_table_entry gtt_type_table[] = {
+static const struct gtt_type_table_entry gtt_type_table[] = {
 	GTT_TYPE_TABLE_ENTRY(GTT_TYPE_PPGTT_ROOT_L4_ENTRY,
 			GTT_TYPE_PPGTT_ROOT_L4_ENTRY,
 			GTT_TYPE_INVALID,
-- 
2.34.1

