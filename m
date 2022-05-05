Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8513151BE13
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357543AbiEELfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357342AbiEELfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:35:24 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DB9D25C44
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=h6ipqcuK2WSU7j9avNOGI+pZ19FNbegkvj/ZZVq4SdL/ExB2cvOJoA0I2LGqEExndhlhQC
        E5ckoHdGmi3wKTh4nF+e1ZI+9L6XyOReqlt1Wj7impTDMm9HsgaZ1Ztw8V6PMtMszcNdUn
        4sTwwQiRn9+XvrKy3gUghEPch4atmuE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-VF2-X5dTNzeNlOWMGnolBg-1; Thu, 05 May 2022 07:31:40 -0400
X-MC-Unique: VF2-X5dTNzeNlOWMGnolBg-1
Received: by mail-wr1-f70.google.com with SMTP id d28-20020adf9b9c000000b0020ad4a50e14so1356449wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncwUrPXa6D//xAE+gUKX4W9jlEJvsWNrctcaxVQSCb8=;
        b=fu09bV349Z9KKfXSdl2/602R2dSxOWbIkcQ83y+p/RTsbuXcdBk9elKYTZfWB5TDdq
         gyXBIQa2r0nEV7jPI5NxzhA2g4Qbg3EQTO8htViwVMG41vrH2Z4PuyaCK9IycuoA60vX
         /Z2HkIy5nKC0FtFmDElYdy1XLDA3Boc+HF8zmReVD/5/2X8Nrz5tEDK3oLlmTCdlhOQT
         DVKCFBwq6Ud8oTv3DQs4Ws8TgWUqkMfRtTl7c7l1UE233FE9EHnwffDocDvhtVYYpf+F
         la0PiFIPFPdcaJeYewW8TTdEXcFqryDnZvPOAL1uc51aIKB7+AzpJcM+UE1TkYxzPwar
         NMzw==
X-Gm-Message-State: AOAM531QQCKz6QxWswdljL9HO2MbKJ0OO52jXw3kgG8cEfX8Eufwlbjk
        kb4KYvyuN6cWde3MogT58pM6M/3uMLyzQe9ZlxS6IYkw8qm5deE+9zm9v5XvqWXUNIzWeSXn2yY
        mE8R4p44y3ctK/dVAKTQc0wpyYK0B8xNE/V95xnFB/s9qhXJUCamCJY7NKi/GV7d/e/SY8jiyNY
        Y=
X-Received: by 2002:a7b:ce82:0:b0:394:2514:6f07 with SMTP id q2-20020a7bce82000000b0039425146f07mr4288650wmj.56.1651750298709;
        Thu, 05 May 2022 04:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTaX+emZRGME2XrbVDdeWq3PLdol9IHOXQKtajyniJm9UY0h9+OnzRg+JdW6I4XRxCo9UumA==
X-Received: by 2002:a7b:ce82:0:b0:394:2514:6f07 with SMTP id q2-20020a7bce82000000b0039425146f07mr4288610wmj.56.1651750298397;
        Thu, 05 May 2022 04:31:38 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:38 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/4] fbdev: Prevent possible use-after-free in fb_release()
Date:   Thu,  5 May 2022 13:31:24 +0200
Message-Id: <20220505113128.264963-2-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505113128.264963-1-javierm@redhat.com>
References: <20220505113128.264963-1-javierm@redhat.com>
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

