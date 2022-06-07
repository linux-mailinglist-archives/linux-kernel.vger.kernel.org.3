Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486B853F6F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237535AbiFGHNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiFGHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:13:03 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8ACE1057B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gvH36
        QjK8hx1fii/eQMosYL0OpSsVFi8yqDxaN79F00=; b=jkxKeMQalPoRSfYYWFa/3
        aVQSwDn2x0fzsZ/+IACmfp2cxZG4FlFcwM/dJbRaFv00QJE8hjuxlM+nLYOuRff3
        nJ+u3YtkaA2SXeULfZxqoyXmskS4of6ObHWJybfKFpwlCueLqvJWpjFqXGT903iI
        JmLGvLVn4ZdahDD4DZOc9U=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp3 (Coremail) with SMTP id G9xpCgCnHGhm+p5i8kyGHQ--.37666S4;
        Tue, 07 Jun 2022 15:12:45 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Hawking.Zhang@amd.com, john.clements@amd.com, candice.li@amd.com,
        Likun.Gao@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] drm/amdgpu: Fix reference leak in psp_xgmi_reflect_topology_info()
Date:   Tue,  7 Jun 2022 15:12:34 +0800
Message-Id: <20220607071234.431245-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCnHGhm+p5i8kyGHQ--.37666S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4xWF1rKry3try8XFyrWFg_yoWDZrg_Gr
        WUJFy3A39xCr1qgw1IyrWaq3srKFsa9rZ7Gr1ftFsaq34UZayrAryUGr1kXw48urs7Casr
        ZF1YgF1UZwnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREsjjJUUUUU==
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbi6w0ZjFXl16EqCwAAsU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amdgpu_get_xgmi_hive() increases the kobject reference counter of the
hive it returned. The hive returned by amdgpu_get_xgmi_hive() should be
released with the help of amdgpu_put_xgmi_hive() to balance its kobject
reference counter properly. Forgetting the amdgpu_put_xgmi_hive()
operation will result in reference leak.

We can fix it by calling amdgpu_put_xgmi_hive() before the end of the
function.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index e9411c28d88b..7b3a78da1684 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1292,6 +1292,7 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
 
 		break;
 	}
+	amdgpu_put_xgmi_hive(hive);
 }
 
 int psp_xgmi_get_topology_info(struct psp_context *psp,
-- 
2.25.1

