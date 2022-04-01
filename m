Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046B64EECAD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 13:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345133AbiDAMAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243520AbiDAMAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:00:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5DFB26
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 04:58:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c11so2226813pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=pNnolXvBibVhqxDqWCeFrSPBPwyB5lZY/VZp6mQCeHA=;
        b=Yd6ygkuuA+1IeY5weMNKvZxSvo7KmvYZHJezeyjkEIUPjSb1ZLica8eb7RZ3kaC2wD
         w2bWnKZPX4LdsrQHU88VkW2Djz+2HRZY/qIVgZ0cY4XVGywe3wZHL4IxCNhVsNqosJey
         fgXhNw0NsLPIxqwWuJHEes0WS+2wVYq/5ilYrFYGo8sXVJnL0PQKIaUPZ/vlodxulH4B
         PWD5Lmj5zvbCDDBEKWpD4R+ulUvsgaDzyM35MhsogJ4Q2A5W2v9juxouyDF+NiBk33zL
         vI3tdb7zS+FjPzgq8W3YXcnj24yNXrX/Z4iLUlDm0TLuRsuazFm57UY9Fp4PAFaorMXl
         KGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pNnolXvBibVhqxDqWCeFrSPBPwyB5lZY/VZp6mQCeHA=;
        b=3NOgGaV7AQXnYPKEjyfKQZQZaSQb6l5dNEyCDCVBcpsZpevSlVeZSgqvL+HepHaZaV
         /DV4h/uZ9Q04MQL/6YAY3PNr8SeDg5eOOU/MSrxJM6vk1xtpjr3VPo0U+RuEbvzvxNjE
         V481hjlf9G9oaWZpAwLv/1vZFIyL8e/Qhnva2OmKPFbRCWbQMpJi601FmRFIKgTkRHmV
         xLBBEMvb3OYlgMunBcCS3v0M6IFmfW2II9oJFMXMv15exMkl82LxTLKB9QT36OWuW4qt
         K6KBEx4zpUjNPpTJwo1N8zapKt1dDRX8TUs6BJ27x6NBWHP2ATS1Q7WCxpbi334O96eD
         M5WQ==
X-Gm-Message-State: AOAM5322aku0daimOROtdwZ1UX7+uN9delFly5G3WrWiuwSkKVpC4WNA
        igM/bKNl9eTgkeH9xh+R3EMvWAV8XlHIcQ==
X-Google-Smtp-Source: ABdhPJxIC6mkCVE/l4zf/4k9AWKh5V4DbbpyGGI36gOJmNszhaTTmeM1VfUSsbFoNiGDYq6Q3gmgXw==
X-Received: by 2002:a05:6a00:c8e:b0:4fb:18a6:18f9 with SMTP id a14-20020a056a000c8e00b004fb18a618f9mr36107343pfv.47.1648814298932;
        Fri, 01 Apr 2022 04:58:18 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm2978064pfh.46.2022.04.01.04.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 04:58:18 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] drm/gma500: fix a missing break in psb_driver_load
Date:   Fri,  1 Apr 2022 19:58:11 +0800
Message-Id: <20220401115811.9656-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
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
list_for_each_entry() continues until the traversal is complete. To
avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
break the loop when the entry is found.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 drivers/gpu/drm/gma500/psb_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 2aff54d505e2..b61a8b0eea38 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -402,6 +402,9 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 			ret = gma_backlight_init(dev);
 			break;
 		}
+
+		if (!ret)
+			break;
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-- 
2.17.1

