Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95B74FCC89
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbiDLCk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238840AbiDLCks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:40:48 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECA519C35
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:38:32 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-d6ca46da48so19401073fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bsj0qNf1cqMOve8zTWuJ9drSqXyGdLK4Rj/oCK1m/Vw=;
        b=XgOzj0UeLzDuVIHBr4rcreeBNCwlWGmgYsjRFbX4BFVJevtNwnkJNh1j0zC+/uCDwS
         NLH8fVwppFIpzyPYQYlv7EGsEJXDiQAjj02zu/LPpAgv+cUKNLpQpEodJpSR35MQvnOL
         vG/YOFXZnWse/RhQIM5+xlgkGzRwKjNcvKSLT9cAzUcRBSvGsC8lH1HpRdG0MGFFxMJR
         9s5lqMbmfo+jfWpsksadb0qyE20SvBA6TBBRrHksRfdxSeNxgyXe5mJmItVby9ZWDsp2
         pabGIvhlsHAnQPG4GXtkiLi6zBmHobjjwQbXwT3TEjkFAHf4vZ8GKJDpLj4IyCOAhbae
         Ul6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsj0qNf1cqMOve8zTWuJ9drSqXyGdLK4Rj/oCK1m/Vw=;
        b=7VSAm6fNTa+nFrXPBjNb7fDuRshCF9FfJXKVdBOSd/sCU7i3eNl/TmWgFI5QSAGeyq
         QoD2ODihu3ELl6KNcTC+o8EisdrshbhGf2Q5nwBPShFcd/wtkwzZTAFUpMYvG/6qD17d
         6H6+eei2uLFmr9iZTvom7GhUAHyxsAnfBcFmpyDdDjpyZLrLL5GBbEgDvDQVx/bZEubB
         exHagWiT0R+XZCG/gGkoHzAHDmOv4QxL8Q5sQCXmBg8jhHhm/p9w/nYNZ79u4yJml8RK
         1gtg92dQj4wUDM0dFJ+oWYrPF5yJUgnMp6sVd4kBiDW1wrdLQfhDlDQ8/XtNCS9B0JiL
         sHBA==
X-Gm-Message-State: AOAM531H5V33w6+PSY34b/6I9qMvG8FsyR6uBGzIZrTDR9p9Xhh5VjRu
        zYKniU8/IK5B3az+tz6IYoM=
X-Google-Smtp-Source: ABdhPJwn/eT7Uj7b2LPhT6qe+2cTBrkNzNfeW2ilc6QDKRQT9NdJmPl9aVBmcnoAGFAqimrtB/qAVw==
X-Received: by 2002:a05:6870:a1a0:b0:dd:e471:8baf with SMTP id a32-20020a056870a1a000b000dde4718bafmr1148349oaf.40.1649731112320;
        Mon, 11 Apr 2022 19:38:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8a9b::1002])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b005b235f5cf92sm12995256otk.65.2022.04.11.19.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 19:38:32 -0700 (PDT)
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrealmeid@riseup.net
Cc:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>
Subject: [PATCH 1/1] drm/vkms: check plane_composer->map[0] before using it
Date:   Mon, 11 Apr 2022 20:38:01 -0300
Message-Id: <20220411233801.36297-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411233801.36297-1-tales.aparecida@gmail.com>
References: <20220411233801.36297-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a copypasta error, which resulted in checking repeatedly if the
primary_composer->map[0] was null, instead of checking each
plane_composer while composing planes.

Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index c6a1036bf2ea..b47ac170108c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -157,7 +157,7 @@ static void compose_plane(struct vkms_composer *primary_composer,
 	void *vaddr;
 	void (*pixel_blend)(const u8 *p_src, u8 *p_dst);
 
-	if (WARN_ON(iosys_map_is_null(&primary_composer->map[0])))
+	if (WARN_ON(iosys_map_is_null(&plane_composer->map[0])))
 		return;
 
 	vaddr = plane_composer->map[0].vaddr;
-- 
2.35.1

