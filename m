Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5EA4EC39A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbiC3MVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347298AbiC3MGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:06:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D641A63B1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s11so18474276pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4gcVpR2FizLJu6RR3F0oPHrwVu4t3M1EAjmgqnVTUXw=;
        b=jcHoloxMP+C79gc6dBvnkAdVCQRfO2uj4O8uKZkKARqsKyg1ZbGoC4b5O7l/sOAXJA
         SFHqCodMGi0ble3CbmlXAfQoy3mrD5wWpVxrpAsTgCbnT2ZFXZaor39CwUro9hliLND3
         pbMsCcEUJIyyQBYVfjXH8Byyfxr5avmvBM/BR+05VfzdWvnVNQglk2vLunPD1Mr+ApCA
         A5iE9zkrlIYRBUdxE7dirJZDht6JYnL+0rdCPLp1f54HsYXZONrHyPGYPYJtQAgXFpYn
         h9GogzzMAk0ipItJFIlRnVwrVFHPNEkOvuCLxahKny1fqMnjinQwrYd1P5rWYMc7IAYF
         4tRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4gcVpR2FizLJu6RR3F0oPHrwVu4t3M1EAjmgqnVTUXw=;
        b=eKDdDAf9XpPcVWJ0WE4KEVgBAWNFQoXxmjiFEdSjiO8lopuHXp15lCAzajlJ61GxGV
         aC+JSKCOX0cK9wcPEH63+l+MuDfmmAbvz/5jnjSwonRi2VbR7mi7OFsaGEF4zRS1j81Y
         T3hE/Xd0LUOFY3ubd9u2qkTpBXHLvXhfw0jh2TcLBi0oIEau0eaH5UTCOUZaBBRsf543
         jPaHocj9q7+uXPws+R5l4TF4QlC2rKs2UVv2NXYTlFVfTvy4GlCH8y/HmTmB0kIPdZbA
         0jtwZuxGVzaht70mEo5TvwU7LI+E6dakAOKrzNBkTiARSF9Rq+SV7+X4UKf7B3mf1iOW
         zUcA==
X-Gm-Message-State: AOAM533RIK2t3oSBcxY8UN4hYwPqwO/4/BhGFuIaKhy4xsYGR3dZDYc1
        p05hL6d0tzsZVVkekrIU+6w=
X-Google-Smtp-Source: ABdhPJzL0rbJ0K2I89qnqiuRPMDNCIkKbUY7vwxf1xIQFLHClFI3u9l3Ln29b5g4dAdJ/hFhzAoqEw==
X-Received: by 2002:a05:6a00:114b:b0:4f7:915:3ec3 with SMTP id b11-20020a056a00114b00b004f709153ec3mr33199193pfm.8.1648641807349;
        Wed, 30 Mar 2022 05:03:27 -0700 (PDT)
Received: from localhost ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id c21-20020a637255000000b003822e80f132sm18965408pgn.12.2022.03.30.05.03.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Mar 2022 05:03:26 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     rob@ti.com, yakui.zhao@intel.com, airlied@redhat.com,
        alan@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH 3/5] gma500: fix a missing break in psb_intel_crtc_mode_set
Date:   Wed, 30 Mar 2022 20:02:44 +0800
Message-Id: <20220330120246.25580-4-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exiting the loop as expected when an entry is found, the
list_for_each_entry() continues until the traversal is complete. It
could result in multiple 'is_*' flags being set with true mistakely.

To fix this, when found the entry, add a break after the switch
statement.

Fixes: 89c78134cc54d (" gma500: Add Poulsbo support")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/psb_intel_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_intel_display.c b/drivers/gpu/drm/gma500/psb_intel_display.c
index 42d1a733e124..85fc61bf333a 100644
--- a/drivers/gpu/drm/gma500/psb_intel_display.c
+++ b/drivers/gpu/drm/gma500/psb_intel_display.c
@@ -134,6 +134,8 @@ static int psb_intel_crtc_mode_set(struct drm_crtc *crtc,
 			is_tv = true;
 			break;
 		}
+
+		break;
 	}
 
 	refclk = 96000;
-- 
2.17.1

