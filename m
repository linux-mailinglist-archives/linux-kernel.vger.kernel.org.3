Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75851CBD7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386140AbiEEWIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237116AbiEEWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:08:16 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00EDD1EEF0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651788274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=PweeKV1NXVpyIKwskeT5YWzMaOC8hxCWX50B+RJhVgasW4M/7b+YGOgtPuiB5iEyMrZMwE
        u/eKyb8rJxxRo83/ZqQ2JBqwy+JwSm+opIyQoZJFx4Ad4b1A6ndjELKCAgmnoPkfcNP9/i
        BkgkF24AE8ikHmSrWu7Rp+Lwao7EvC8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-2g0Sq597PYuiA62tgGDZhA-1; Thu, 05 May 2022 18:04:25 -0400
X-MC-Unique: 2g0Sq597PYuiA62tgGDZhA-1
Received: by mail-wr1-f71.google.com with SMTP id s14-20020adfa28e000000b0020ac7532f08so1872384wra.15
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 15:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=X7IKakNfuemgSg7A1tR+HChKeEnWTxcXVbnFIWG/rbURC1lwmLql8U3z0Ovj/1kAGe
         JPX7nq9wpBpnn4B2OL7LDBCzPIcEraAnLtVJouvvwlDXt/YIidhQmKuSQdqVMbPoxr4n
         e8cqtn51Ukao88VwUUdqzsqgxSFKsJWUAt/EenSgadYp48ZuA6Tu0QfOtuMFcslcaavv
         wDyyrjmFA/OggqBEtFy8r470scErsmgwyUN8MtakIdi+J7GayLC9FW4nbpiszaIak0IH
         09TP8JWostrrtbj4pCmp+drOC4OoKi6SmmXZxxMsroI9P6fNCKRqJ+S0QCKsQ1sPaDwV
         msGA==
X-Gm-Message-State: AOAM530Cn8icTu7pTtC57hJfmBMu+43pPvXIJkjKCFa5o1pNlUsHpNK8
        waQZudw/h4PQyNO0Dlszcz/MnRNaPVgYmfmsRHwT6F0AhxAwdjNpf7ksteDai/3lH3WRSPQZh/3
        k4lBCSPHpcW3AJYkL8NBAF73h+CKPOn6wM/HUF+qHCxT9K/Y1nYP+KXNB1bVEMjDxGmtZlDBMxY
        Y=
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id bi12-20020a05600c3d8c00b0039460979994mr6726669wmb.29.1651788264100;
        Thu, 05 May 2022 15:04:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfwhAOIQeVF2O3srNOg8rIqNBWMADJBM0ucjW4JDKss+KaRrP/Oe0Hd/iuu0biw9+SXEcE9g==
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id bi12-20020a05600c3d8c00b0039460979994mr6726643wmb.29.1651788263758;
        Thu, 05 May 2022 15:04:23 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b003942a244f4bsm7980875wms.36.2022.05.05.15.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:04:23 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 1/4] fbdev: Prevent possible use-after-free in fb_release()
Date:   Fri,  6 May 2022 00:04:13 +0200
Message-Id: <20220505220413.365977-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505215947.364694-1-javierm@redhat.com>
References: <20220505215947.364694-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

Most fbdev drivers have issues with the fb_info lifetime, because call to
framebuffer_release() from their driver's .remove callback, rather than
doing from fbops.fb_destroy callback.

Doing that will destroy the fb_info too early, while references to it may
still exist, leading to a use-after-free error.

To prevent this, check the fb_info reference counter when attempting to
kfree the data structure in framebuffer_release(). That will leak it but
at least will prevent the mentioned error.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---

(no changes since v1)

 drivers/video/fbdev/core/fbsysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 8c1ee9ecec3d..c2a60b187467 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -80,6 +80,10 @@ void framebuffer_release(struct fb_info *info)
 {
 	if (!info)
 		return;
+
+	if (WARN_ON(refcount_read(&info->count)))
+		return;
+
 	kfree(info->apertures);
 	kfree(info);
 }
-- 
2.35.1

