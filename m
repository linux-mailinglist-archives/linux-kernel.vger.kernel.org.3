Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57B3563331
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiGAMIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 08:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGAMIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 08:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C22AB6274
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 05:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656677287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33CX6tqttkMHMf61l9Fet5nDm88rS4svreUI5dKwpqM=;
        b=ProV9usfHa8aQKjRF+7MsiG7vA8qhyrQQ8ITR1qYfrorIv6f3ATB9uT7IxUypy50m0SBga
        PA3RuEldFM5fuwn4487MoX15+f1fAI7UGen6g1urrzIn4CCth7h6hMQTomNX93uwB48A4c
        Bhxx420OeYz88S+ZxWfcUhB6QOzFGpI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-ijuZ2uxVPCKp3CNllQxi5A-1; Fri, 01 Jul 2022 08:08:07 -0400
X-MC-Unique: ijuZ2uxVPCKp3CNllQxi5A-1
Received: by mail-wr1-f71.google.com with SMTP id u9-20020adfa189000000b0021b8b3c8f74so340744wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 05:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33CX6tqttkMHMf61l9Fet5nDm88rS4svreUI5dKwpqM=;
        b=deZnqoI8zWr5HEaL82pm73LE16TxxfdFFSU7WKVUTnXtNEerUH5x3oI/aSjSuu1Gzx
         A9vJ0QR42dUkGR789Ttm5VTIKpzUfzeZMdLUqTyG6Ge9liLsgwbt3uqGMnBkL9vtvaNV
         8+LviUp6RMHhq+E3DQ8uzXAnh+JkN/0I3gzt33CFKfzOFogVx7zBfssTMz6tChZXkg91
         U+OFsSieGKWun1BfWGiL+M9lRkzOgzCiek+9yLOHygz/D38H2ikJ4lha7g0C+P7EZVWz
         HJFb2J1fbN1cUGuEzwiL8VAdr+mg+tpkhuKcYZNoX3Z2DHliw6XpQpYvIfcnOSa90wFK
         MMFA==
X-Gm-Message-State: AJIora8dIvypTDZnXWh3LJEqfefkON/8t5QD6Y5EaTa2eSwi1mKCULvE
        Z8oUiBv9UpE8PQLCN124xwCOcVHqZRuT2DdWjrs8WagDRE06vrjPVm2AgEf4jWnNLA7Mo9fFjZj
        EMTn2YstTd6RGOvghiZzym4PXbumV4I5vSNdkqEfoNHI9mqYm7wSV/yjTX6VfsRaCJ56GwkljPD
        c=
X-Received: by 2002:a05:600c:4fd4:b0:3a0:334e:241e with SMTP id o20-20020a05600c4fd400b003a0334e241emr18258859wmq.73.1656677284013;
        Fri, 01 Jul 2022 05:08:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uYAikOSSOPPoi0aaWV3LrSgiuaCowzzz4IMHySnpiKFRNdnx51jOHlhQgu8NYG8h3fw/z43g==
X-Received: by 2002:a05:600c:4fd4:b0:3a0:334e:241e with SMTP id o20-20020a05600c4fd400b003a0334e241emr18258817wmq.73.1656677283681;
        Fri, 01 Jul 2022 05:08:03 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id v4-20020a7bcb44000000b0039746638d6esm9813160wmj.33.2022.07.01.05.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:08:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 2/2] drm: Prevent drm_copy_field() to attempt copying a NULL pointer
Date:   Fri,  1 Jul 2022 14:07:55 +0200
Message-Id: <20220701120755.2135100-3-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220701120755.2135100-1-javierm@redhat.com>
References: <20220701120755.2135100-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_copy_field() helper is used to copy some struct drm_driver fields
to userspace through the DRM_IOCTL_VERSION ioctl. But it could be possible
that the driver didn't set some of the fields and are instead set to NULL.

If that is the case, the drm_copy_field() attempts to copy a NULL pointer:

[ +10.395966] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
[  +0.010955] Mem abort info:
[  +0.002835]   ESR = 0x0000000096000004
[  +0.003872]   EC = 0x25: DABT (current EL), IL = 32 bits
[  +0.005395]   SET = 0, FnV = 0
[  +0.003113]   EA = 0, S1PTW = 0
[  +0.003182]   FSC = 0x04: level 0 translation fault
[  +0.004964] Data abort info:
[  +0.002919]   ISV = 0, ISS = 0x00000004
[  +0.003886]   CM = 0, WnR = 0
[  +0.003040] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000115dad000
[  +0.006536] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  +0.006925] Internal error: Oops: 96000004 [#1] SMP
...
[  +0.011113] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  +0.007061] pc : __pi_strlen+0x14/0x150
[  +0.003895] lr : drm_copy_field+0x30/0x1a4
[  +0.004156] sp : ffff8000094b3a50
[  +0.003355] x29: ffff8000094b3a50 x28: ffff8000094b3b70 x27: 0000000000000040
[  +0.007242] x26: ffff443743c2ba00 x25: 0000000000000000 x24: 0000000000000040
[  +0.007243] x23: ffff443743c2ba00 x22: ffff8000094b3b70 x21: 0000000000000000
[  +0.007241] x20: 0000000000000000 x19: ffff8000094b3b90 x18: 0000000000000000
[  +0.007241] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab14b9af40
[  +0.007241] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  +0.007239] x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa524ad67d4d8
[  +0.007242] x8 : 0101010101010101 x7 : 7f7f7f7f7f7f7f7f x6 : 6c6e6263606e7141
[  +0.007239] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[  +0.007241] x2 : 0000000000000000 x1 : ffff8000094b3b90 x0 : 0000000000000000
[  +0.007240] Call trace:
[  +0.002475]  __pi_strlen+0x14/0x150
[  +0.003537]  drm_version+0x84/0xac
[  +0.003448]  drm_ioctl_kernel+0xa8/0x16c
[  +0.003975]  drm_ioctl+0x270/0x580
[  +0.003448]  __arm64_sys_ioctl+0xb8/0xfc
[  +0.003978]  invoke_syscall+0x78/0x100
[  +0.003799]  el0_svc_common.constprop.0+0x4c/0xf4
[  +0.004767]  do_el0_svc+0x38/0x4c
[  +0.003357]  el0_svc+0x34/0x100
[  +0.003185]  el0t_64_sync_handler+0x11c/0x150
[  +0.004418]  el0t_64_sync+0x190/0x194
[  +0.003716] Code: 92402c04 b200c3e8 f13fc09f 5400088c (a9400c02)
[  +0.006180] ---[ end trace 0000000000000000 ]---

Reported-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/gpu/drm/drm_ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index e1b9a03e619c..dacaddc59c82 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -474,6 +474,10 @@ static int drm_copy_field(char __user *buf, size_t *buf_len, const char *value)
 {
 	size_t len;
 
+	/* don't attempt to copy a NULL pointer */
+	if (WARN_ONCE(!value, "BUG: the value to copy was not set!"))
+		return -EINVAL;
+
 	/* don't overflow userbuf */
 	len = strlen(value);
 	if (len > *buf_len)
-- 
2.36.1

