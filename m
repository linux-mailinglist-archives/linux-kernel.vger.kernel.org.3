Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0129566FE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGENv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiGENve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:51:34 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B546223BC8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gXy/Y
        z4KCId8SFCAfrVNi5PuBJCfR9XEK9tE4hr3UMk=; b=fp/zwUlITCGkn7mKyHq76
        3krFugiAzVymSNKB6opO8r/aqqAyx0KMRPca+hoLlf7cD0vyKh3WvQixS6wt7Hu+
        StnA0YOMVgm4NIf7pn3PqgsfLAKdAvoeYNclnWAJcPpN8OpiIDc1U5AImG+CbnyU
        x6VAsFgL4FQSIbf8K3VHRQ=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp5 (Coremail) with SMTP id HdxpCgBXgTLcO8RiQtNIMg--.52057S4;
        Tue, 05 Jul 2022 21:25:55 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     bskeggs@redhat.com, kherbst@redhat.com, lyude@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] drm/nouveau: fix a use-after-free in nouveau_gem_prime_import_sg_table()
Date:   Tue,  5 Jul 2022 21:25:46 +0800
Message-Id: <20220705132546.2247677-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBXgTLcO8RiQtNIMg--.52057S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFy7tFy5KFyfJFWrJF47urg_yoWkXwb_ur
        yxZFnxWw1kKFs8ArsFy34UAFy29ay8XrWkuas2qF95t39xJr1ruFW7Zr18u34kurWIgr9x
        G3Wqvas0krn7WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRGsj8UUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/xtbBOQM1jF-POWd5wwAAs3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau_bo_init() is backed by ttm_bo_init() and ferries its return code
back to the caller. On failures, ttm will call nouveau_bo_del_ttm() and
free the memory.Thus, when nouveau_bo_init() returns an error, the gem
object has already been released. Then the call to nouveau_bo_ref() will
use the freed "nvbo->bo" and lead to a use-after-free bug.

We should delete the call to nouveau_bo_ref() to avoid the use-after-free.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/gpu/drm/nouveau/nouveau_prime.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
index 347488685f74..9608121e49b7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_prime.c
+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
@@ -71,7 +71,6 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
 	ret = nouveau_bo_init(nvbo, size, align, NOUVEAU_GEM_DOMAIN_GART,
 			      sg, robj);
 	if (ret) {
-		nouveau_bo_ref(NULL, &nvbo);
 		obj = ERR_PTR(ret);
 		goto unlock;
 	}
-- 
2.25.1

