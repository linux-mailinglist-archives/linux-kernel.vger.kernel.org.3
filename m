Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D570B49AE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442625AbiAYIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:41:54 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17808 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiAYIji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:39:38 -0500
Received: from kwepemi100018.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JjgGr2YR5z9sJ5;
        Tue, 25 Jan 2022 16:38:12 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 kwepemi100018.china.huawei.com (7.221.188.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 16:39:31 +0800
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 16:39:30 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <zhenyuw@linux.intel.com>, <zhi.a.wang@intel.com>,
        <jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
        <rodrigo.vivi@intel.com>, <tvrtko.ursulin@linux.intel.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <intel-gvt-dev@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/i915/gvt: Convert list_for_each to entry variant
Date:   Tue, 25 Jan 2022 16:39:24 +0800
Message-ID: <1643099964-13905-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert list_for_each() to list_for_each_entry() where
applicable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 8882843..1f0721d 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -350,13 +350,11 @@ static struct intel_vgpu_dmabuf_obj *
 pick_dmabuf_by_info(struct intel_vgpu *vgpu,
 		    struct intel_vgpu_fb_info *latest_info)
 {
-	struct list_head *pos;
 	struct intel_vgpu_fb_info *fb_info;
 	struct intel_vgpu_dmabuf_obj *dmabuf_obj = NULL;
 	struct intel_vgpu_dmabuf_obj *ret = NULL;
 
-	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
+	list_for_each_entry(dmabuf_obj, &vgpu->dmabuf_obj_list_head, list) {
 		if (!dmabuf_obj->info)
 			continue;
 
@@ -379,12 +377,10 @@ pick_dmabuf_by_info(struct intel_vgpu *vgpu,
 static struct intel_vgpu_dmabuf_obj *
 pick_dmabuf_by_num(struct intel_vgpu *vgpu, u32 id)
 {
-	struct list_head *pos;
 	struct intel_vgpu_dmabuf_obj *dmabuf_obj = NULL;
 	struct intel_vgpu_dmabuf_obj *ret = NULL;
 
-	list_for_each(pos, &vgpu->dmabuf_obj_list_head) {
-		dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
+	list_for_each_entry(dmabuf_obj, &vgpu->dmabuf_obj_list_head, list) {
 		if (dmabuf_obj->dmabuf_id == id) {
 			ret = dmabuf_obj;
 			break;
-- 
2.6.2

