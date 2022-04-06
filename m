Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A634F6258
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiDFOzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235252AbiDFOzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:55:18 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFEB60290E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 04:31:50 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t4so1975578pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=xl6VVCAajevFuRJS9yPa1nlDbDqEUfMrrJAAj8Ufl7w=;
        b=Jm/MEaVSKPLAgcL0eRNOvFXKLkxCSUlelHrlNGJGE8zKGxd3mPDoOYmNNAr/PX2oZf
         RI56ezt7I/hXAiPJq0vjNGAcQdWuTdVWA/7HJ+WZ3/B7mbSna+w1YFowR0TTEWY06fIF
         WfJU0pApHvsua2/YXeuoXGx+e7I4ebchnLVYYnj8iygztCYswVz7jr7Dibf3ufK1ndcA
         mxmOxppTuxX3dtjyhVfSyWcNRIDUo0Z//arZ/poeXhMUaF3BOLjZy0EWeqKe8I2MeObe
         /A1vlRRhDQfVjwsZ3tA5TLRSHymZFcUXPpi8ktcYdFJDGzQe+HSYGq8JR+rxkv4chhPM
         MB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xl6VVCAajevFuRJS9yPa1nlDbDqEUfMrrJAAj8Ufl7w=;
        b=TIP0xqWBiyVWcTs++J+fPq2uQWEmzC3YQoylCeFjOkG45N5j7n87Pd9hLkt+y/Zi4m
         vWDvQovj7RBWZkNcXKMWUrdW6y646B1WtEukm5M5iVA6fvlHEHoSIXPiSTOXIw1moyvR
         0hbrSDCSjITYT5M38l9cPtvyQgPoJy+RHgsRV+wa+eMZkhopi2t7x+WwQVnQ0mq7x1ud
         5aUgEd9k5omlyghitR8khysSl4Yq8B7TIYvDo5w+WzuRLcuM5HxHPLKZaYPFYLS511RS
         CjTLGTrJaw6vU1gM1M77JeDz6YGXukQa3LZsAFmheI7XQOBJ5gEMhmXI5TzXrM8/ljnV
         YHdA==
X-Gm-Message-State: AOAM532H3EFehPAdc+LEw8uTi0zWbXWgLhTNaRdJS50RDmhCx3/ccTR3
        VYkIuhVyGAinrWad12xvo6mTUwu6bWmWeA==
X-Google-Smtp-Source: ABdhPJx3gTn89KY6+7NY2fQ+ZYGvPyx47HtqtU3a9MIUqtNVPY4y3m/hrg/EmUaMM3x0fmQTiwagag==
X-Received: by 2002:a63:221f:0:b0:374:7286:446a with SMTP id i31-20020a63221f000000b003747286446amr6759359pgi.538.1649244709835;
        Wed, 06 Apr 2022 04:31:49 -0700 (PDT)
Received: from localhost.localdomain ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm19760516pfe.153.2022.04.06.04.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:31:49 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH v2] drm/gma500: fix a potential repeat execution in psb_driver_load
Date:   Wed,  6 Apr 2022 19:31:43 +0800
Message-Id: <20220406113143.10699-1-xiam0nd.tong@gmail.com>
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
goto outside the loop when the entry is found.

Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---

changes since v1:
 - goto outside the loop (Xiaomeng Tong)

v1: https://lore.kernel.org/lkml/20220401115811.9656-1-xiam0nd.tong@gmail.com/

---
 drivers/gpu/drm/gma500/psb_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 2aff54d505e2..929fd47548b4 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -400,9 +400,10 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 		case INTEL_OUTPUT_LVDS:
 		case INTEL_OUTPUT_MIPI:
 			ret = gma_backlight_init(dev);
-			break;
+			goto out;
 		}
 	}
+out:
 	drm_connector_list_iter_end(&conn_iter);
 
 	if (ret)
-- 
2.17.1

