Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8394F7FA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245583AbiDGNAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243515AbiDGM7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:59:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB6848E73
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:57:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id p23so6284971edi.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I2kKuQm9mBVMxGG2tuqK5kvCq3TE0hPoH+duL8WuPFE=;
        b=fREgNyiTU+JgehQuQun/naOApONGw77/dtDLqvcR2nsBwPsXkPL44tiLSGRkpl+g8U
         nVQTq7mUgmzMGC/FV0TUy5+XsuUIic2y79YJ3KLnA3Em+Ry3mvg/3dnASZsGwi+l0Qu4
         qSLof8irjPFEG26f7yW11EVSQbayAVC2oEn2O/FClJkObCqo0Wi0RijRzPW7+XMuflRV
         1fW49RE7eO3DPVOZjhFo7LrpiegCKlzb79Z70GdlOJLdHXN1U9vfedInRfsvZr0lRCeG
         rgFjDQzge0XSGnifixG7ZxtlqFxKrUHEcr1kQoC1A2gQFYIU18lK2k7UDpqPsOSfS08v
         N66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I2kKuQm9mBVMxGG2tuqK5kvCq3TE0hPoH+duL8WuPFE=;
        b=BLBzlopuZG08f59rEbrGtuIDKwVNbz2u3wN7IIJoX/0AApXJRW1VvKUtj4kQc2IdaG
         ANkVT9h/cJiQGVFajJOZ+7gWH7ov6vAAjqFJmsVF+k4fRGZzp5daAxGjfihdsZbWyg7W
         GJHpTUF029z2nK2NLD4ZkNAMF5HcbQHS5yLN4ZYY/mF9rOyHa+JcmQdOB3SF5yWC8O2L
         ya+R/5r36HTdO9lOIHRnXG671yZ1LcdeLsMtfhT9/3RaEfvrh8FawS7lgrsdEAzLw2tG
         p9E4n0wmtkDExAWZo8I4/y58lYjYOBCa9qMf/i/7U38F6v3HeWFsQx8wx27qpLzPXhK9
         Nw/A==
X-Gm-Message-State: AOAM531F8PCRKJO1nqx8gVe5uwa13Ku96tyCAUuB76i7fnF0OVfkIvBR
        z2NaxLzV2iJrz5Mw557qvVk=
X-Google-Smtp-Source: ABdhPJzipgYuM30uDF84FFOslfVMcPdQ8T/8aZ0+xYG7Wk5AyEfieXrgPeFqOSRCjuOFlA74RwPVJA==
X-Received: by 2002:a05:6402:4247:b0:419:3990:3db6 with SMTP id g7-20020a056402424700b0041939903db6mr13837423edb.193.1649336269266;
        Thu, 07 Apr 2022 05:57:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm7676764ejk.119.2022.04.07.05.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 05:57:48 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 2/5] staging: r8188eu: use round_up() instead of _RND4()
Date:   Thu,  7 Apr 2022 14:57:39 +0200
Message-Id: <20220407125742.7814-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407125742.7814-1-straube.linux@gmail.com>
References: <20220407125742.7814-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use in-kernel round_up() instead of custom _RND4().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
v2: no changes

 drivers/staging/r8188eu/core/rtw_cmd.c          | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 9b53b92c6795..ed092faafb0f 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -264,7 +264,7 @@ int rtw_cmd_thread(void *context)
 			goto post_process;
 		}
 
-		pcmd->cmdsz = _RND4((pcmd->cmdsz));/* _RND4 */
+		pcmd->cmdsz = round_up(pcmd->cmdsz, 4);
 
 		memcpy(pcmdbuf, pcmd->parmbuf, pcmd->cmdsz);
 
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 56e5cbfec1f1..388c22751d09 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -96,14 +96,6 @@ static inline void flush_signals_thread(void)
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND4(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 2) + ((sz & 3) ? 1: 0)) << 2;
-	return val;
-}
-
 static inline u32 _RND8(u32 sz)
 {
 	u32	val;
-- 
2.35.1

