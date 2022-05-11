Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B564E5231C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbiEKLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbiEKLck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0442A41322
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652268758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j9CH2v0YXJ3HjUK6dIstavUpY+IdJA0p7lKZyzF8giE=;
        b=QljuTuDGkoTfJn2Q/jAgjWR9qIs1l0rRUGFoDuz9tjiWtcjjOHSq1Rs/syy3L6hX9k7ygA
        xUDxJAjb1LVjz3oxU68YKeOH6C2ahPiSuPu5xFHxSqP3O3xZeB3p/Euv+wLB0qC9tCWCoj
        EPtk06Z7PG85X4DhGb9RsTwlGZtZUuQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-RqNKb-q0NVuw6I6LvF1tfA-1; Wed, 11 May 2022 07:32:37 -0400
X-MC-Unique: RqNKb-q0NVuw6I6LvF1tfA-1
Received: by mail-wm1-f69.google.com with SMTP id n26-20020a1c721a000000b003941ea1ced7so609740wmc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9CH2v0YXJ3HjUK6dIstavUpY+IdJA0p7lKZyzF8giE=;
        b=l7l+TEIqUWfLmGypAfPCksKbuisVr2to6aq2CBtrx+hwixqAHPNiviw6jm391xov1q
         APcISlzNRDk5SbQ1/qrPIIVPh1IiHBddmoDe6SgCILWgmXAb4m8Brx9EmRJMPl0QSqGw
         4Y1FmMnwVwvUEdAi1TQ5MMSCnuZhoaeAVezMLOQ8o20tauHw3lhaC26mSKXvlNVla8d0
         ppEayOh+dQnuQu3bAgzRscAIoYZxSzyoAhx5GUD+jlgfFssRpfOwLnkG7DTy9tIb4WwY
         6+8gr4vkRrtdylhNY0xHl665Tzbtq7Qf3xPjCQiyMdXOcVdt3Jv4F56scnHTZytpZI6K
         kRPw==
X-Gm-Message-State: AOAM533DYyNpHEfuWv+5woe4hbzGj8RMQhtGyMJGhJ9PIzMFHkrFaiW2
        MwrKNIIzqHeW6hTpaHhESIyQ2ky0D4dPvb5MOyqT/3nrg6/qzcM9A/qp0qbXaERXfmh1/Qq5cWk
        iYgtuCan7wvJm5z45yXJHnRMrzfYImcA+AQpL00H0hjwB3E87tQ8dMFtd604oRXGx2eR1Xgz3k/
        c=
X-Received: by 2002:adf:f747:0:b0:20a:d30a:5f08 with SMTP id z7-20020adff747000000b0020ad30a5f08mr22334028wrp.278.1652268755838;
        Wed, 11 May 2022 04:32:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgrtdXH49XbKTYGY6jvwa/LsalnhjTRPZOQcdgbrMeYtoBsK3sJMoM3gRNyeWCwdLsXBrWuA==
X-Received: by 2002:adf:f747:0:b0:20a:d30a:5f08 with SMTP id z7-20020adff747000000b0020ad30a5f08mr22333989wrp.278.1652268755534;
        Wed, 11 May 2022 04:32:35 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b00394615cf468sm4928533wmb.28.2022.05.11.04.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:32:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel test robot <lkp@intel.com>,
        Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        linux-staging@lists.linux.dev,
        Daniel Vetter <daniel.vetter@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 7/7] fbdev: Make registered_fb[] private to fbmem.c
Date:   Wed, 11 May 2022 13:32:30 +0200
Message-Id: <20220511113230.1252910-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511112438.1251024-1-javierm@redhat.com>
References: <20220511112438.1251024-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

Well except when the olpc dcon fbdev driver is enabled, that thing
digs around in there in rather unfixable ways.

Cc oldc_dcon maintainers as fyi.

v2: I typoed the config name (0day)

Cc: kernel test robot <lkp@intel.com>
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: linux-fbdev@vger.kernel.org
Cc: Zheyu Ma <zheyuma97@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 drivers/video/fbdev/core/fbmem.c | 8 ++++++--
 include/linux/fb.h               | 7 +++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 265efa189bcc..6cab5f4c1fb3 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -50,10 +50,14 @@
 static DEFINE_MUTEX(registration_lock);
 
 struct fb_info *registered_fb[FB_MAX] __read_mostly;
-EXPORT_SYMBOL(registered_fb);
-
 int num_registered_fb __read_mostly;
+#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
+EXPORT_SYMBOL(registered_fb);
 EXPORT_SYMBOL(num_registered_fb);
+#endif
+#define for_each_registered_fb(i)		\
+	for (i = 0; i < FB_MAX; i++)		\
+		if (!registered_fb[i]) {} else
 
 bool fb_center_logo __read_mostly;
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index bbe1e4571899..c563e24b6293 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -632,16 +632,15 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
+#if IS_ENABLED(CONFIG_FB_OLPC_DCON)
 extern struct fb_info *registered_fb[FB_MAX];
+
 extern int num_registered_fb;
+#endif
 extern bool fb_center_logo;
 extern int fb_logo_count;
 extern struct class *fb_class;
 
-#define for_each_registered_fb(i)		\
-	for (i = 0; i < FB_MAX; i++)		\
-		if (!registered_fb[i]) {} else
-
 static inline void lock_fb_info(struct fb_info *info)
 {
 	mutex_lock(&info->lock);
-- 
2.35.1

