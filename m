Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF257585C9D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 01:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiG3XTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiG3XTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 19:19:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A390813F1A
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:19:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q30so5492812wra.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=VDb1fygqmzJq+4ODXnKnnrG1zJ5IMlTZW7OoKxaS5S8=;
        b=AAAp2ws1QCgGbsgAWKfpIVhIIiXOqVKRilbalzriAoKHYqU6axRIpnpCWNf13hrOgj
         TmEUelGjHTR2uDN+mBV8Ie9ZiJdtcvXk6YorOCQ7ErIDUlV2SgO568APKK5hqWA2Xu2n
         pnMb5xvDQwlBLOfQmlM+CqfpdAhbCa/KFf8IutLQ6EUte03tiwbhuhdN7p8gTSF6qo+f
         ndlKsKWfFwcmYSnaz+Q+GXohciBMPQEFAsepA99KwNfQ4WN8RS0izvP29FRo4C8tIv43
         c1toi0rKgwU7fZaC7b1of8YcCEFZmLg1BzKh7tBjQY4JAyaEXJmnT68qykkp/zZjJSal
         KRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=VDb1fygqmzJq+4ODXnKnnrG1zJ5IMlTZW7OoKxaS5S8=;
        b=XhgcXJp9QgzqMYJcsvpLbWbO5yMnn7ZWx152dGl0V1zHySrQ/JNR5FRBzvLaROdGAK
         K5McI9oWHHXtvJpXcPMTMulhAcJsiX/chBSEoZML8kgXjxL3Hi12GGSrH5Jj7Y+eB+eX
         galej8KVvl8Esu1WCOJLB3ejbdKl9Bv4QJe4eS2RuZBoF7pQUyNZkYh1JwDYOROgBhBT
         m7i7VNgBWIbuTA8RvIogGMkxnh3f8N4x9xtju5nbYZZFz5XGxTc4gfJWHMsLMr8t2i/a
         S1Ljp2IugS+zLhlvob6YCdJDn72J382zjoW+oLLQtDzPThGlu0B/1CqTqNRS4REBqZsg
         TsDA==
X-Gm-Message-State: ACgBeo0JioxkNVF/fJhSQPsoveHGWTgRaBlZSJOQP+Clb5E35KbkOhjR
        AbI+HAo4kaQSn19Ikc8h1VM=
X-Google-Smtp-Source: AA6agR7uhwIFSGLZ+KbnvPVkvqnl4EdyZiLqBn7R765VXBBW+icHEpU0Hfv/9FmS9nxO1FaZrGhQrg==
X-Received: by 2002:a5d:55d1:0:b0:21e:cc2c:f357 with SMTP id i17-20020a5d55d1000000b0021ecc2cf357mr5946574wrw.186.1659223171912;
        Sat, 30 Jul 2022 16:19:31 -0700 (PDT)
Received: from localhost.localdomain ([84.255.184.16])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003a3270735besm9375351wmj.28.2022.07.30.16.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 16:19:31 -0700 (PDT)
From:   Mazin Al Haddad <mazinalhaddad05@gmail.com>
To:     mripard@kernel.org
Cc:     tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, paskripkin@gmail.com,
        Mazin Al Haddad <mazinalhaddad05@gmail.com>,
        syzbot+c8ae65286134dd1b800d@syzkaller.appspotmail.com
Subject: [RFC PATCH] drm/gem: Fix a UAF caused by invalid reference counting in drm_gem_mmap()
Date:   Sun, 31 Jul 2022 02:15:59 +0300
Message-Id: <20220730231559.85423-1-mazinalhaddad05@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes a bug reported by syzkaller.

Mmaping a dumb buffer can result in a use-after-free if there is an
error in the return path of the driver specific gem object's mmap()
callback. This is due to improper reference counting in the error path.

The use-after-free occurs when attempting to close the drm file as
the freed gem object is accessed again (through handle). A failure in
drm_gem_shmem_get_pages() within drm_gem_shmem_mmap() (or equivalent
obj->funcs->mmap() call) leads to a call to drm_gem_vm_close()
in the error path, which decrements the reference count of the object
in question and leads to a free after it is further decremented in
drm_gem_mmap_object()'s error path and drm_gem_mmap().

Fix it by removing the call to drm_gem_vm_close() in error path of
driver specific callback. This changes the code so that only two decrements
happen instead of three, matching up with the references taken by the
driver within the drm_gem_mmap() function.

Trimmed syzbot report:

Call Trace:
 <TASK>
 drm_gem_object_release_handle+0xf2/0x110 drivers/gpu/drm/drm_gem.c:253
 idr_for_each+0x113/0x220 lib/idr.c:208
 drm_gem_release+0x22/0x30 drivers/gpu/drm/drm_gem.c:932
 drm_file_free.part.0+0x805/0xb80 drivers/gpu/drm/drm_file.c:281
 drm_file_free drivers/gpu/drm/drm_file.c:248 [inline]
 drm_close_helper.isra.0+0x17d/0x1f0 drivers/gpu/drm/drm_file.c:308
 drm_release+0x1e6/0x530 drivers/gpu/drm/drm_file.c:495

Freed by task 3606:
 kfree+0xd6/0x4d0 mm/slub.c:4584
 drm_gem_object_free drivers/gpu/drm/drm_gem.c:974 [inline]
 kref_put include/linux/kref.h:65 [inline]
 __drm_gem_object_put include/drm/drm_gem.h:371 [inline]
 drm_gem_object_put include/drm/drm_gem.h:384 [inline]
 drm_gem_mmap+0x4fc/0x770 drivers/gpu/drm/drm_gem.c:1134
 call_mmap include/linux/fs.h:2063 [inline]
 mmap_region+0xbe7/0x1460 mm/mmap.c:1796
 do_mmap+0x863/0xfa0 mm/mmap.c:1587
 vm_mmap_pgoff+0x1b7/0x290 mm/util.c:552
 ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1633

Link: https://syzkaller.appspot.com/bug?id=e84227937d2d71da66e62f8c67b69a0cc387123c
Fixes: 45d9c8dde4cd ("drm/vgem: use shmem helpers")
Reported-by: syzbot+c8ae65286134dd1b800d@syzkaller.appspotmail.com
Signed-off-by: Mazin Al Haddad <mazinalhaddad05@gmail.com>
---

RFC because I'm not quite sure that this is the correct fix so guidance would be
appreciated. I looked at the implementation of the drm_gem_object's
mmap callback in various drivers including, exynos, panfrost and the
cma helper and all of them also call drm_gem_vm_close() on error
(which only decrements the object reference count).

Most likely other drivers also run into this issue on mmap() error,
as the dumb buffer create can have one reference on entry
to drm_gem_mmap(). Two references will then be taken (one in drm_gem_mmap
and the other in drm_gem_mmap_object). If the driver decides to error out
and release a reference within it's own error path it will ultimately
remove three references. So maybe it's easier to have the reference counts
be adjusted in the drm_gem_mmap() and drm_gem_mmap_object() function rather
than have it in the drivers.

Is there a need to go through the other drivers and remove the
drm_gem_vm_close() call? Or is there a better way of doing this.
I'm not sure if deleting the call is the correct thing to do here and if
there is something I'm missing. Please let me know if there is anything
I need to change.


 drivers/gpu/drm/drm_gem_shmem_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ad0e02991ca..01908bba5970 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -622,7 +622,6 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_object *shmem, struct vm_area_struct
 
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret) {
-		drm_gem_vm_close(vma);
 		return ret;
 	}
 
-- 
2.37.1

