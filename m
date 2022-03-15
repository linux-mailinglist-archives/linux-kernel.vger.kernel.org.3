Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1274D9E01
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbiCOOpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349425AbiCOOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:45:14 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C364E1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647355433;
        bh=wovb6kZT2Sne2tbxUxcchS5UK7kD/TEn0ztb8HjtObQ=;
        h=From:To:Cc:Subject:Date;
        b=fMaSrYd98a92qYeqSobQ5oDmyXHDa9ke+pGM0pi73PG6fuQSItulnA3ek+4n5lzqN
         hefDeur3lPjM9NTU4nK1ehjF7ay0ebepUIKF/QBoN7cVHLSFSzTdsz+RUS3zf0t+nw
         Uie6xnIIGfk2NMgfaauv7dyh/gu6KBLO6Gtyq3hk=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id AA5BCE99; Tue, 15 Mar 2022 22:42:37 +0800
X-QQ-mid: xmsmtpt1647355357tmli9xpaz
Message-ID: <tencent_7F2A8AAFF05125C6FF159033E69B5C108E07@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjLrdrsX39shVro39worYR1UDLSN2cTyEArcFFifoOABgXifLxwX
         6JFdXmQ7B/PQCQbi0Z5tftnnOjpmVgZD8RCJnkc0ADg5oiDEqwS4lcakdY7R4gdtg0YUSrlF44FE
         IEBz08CP03lfcyTGcinz1HXZlHUzXdSi26BEKEVLWCe3PSpcUOPeMWg+HSgXlbSUaHUr6a7OSaPg
         ty5Wn9GRqRls5YcCMRraDw9jBN1xXZ+N3yrryrhRKq3fJ8og86F3Dc7RZ/bqYxZa3NW/Upvxw608
         U6u1DNffgjKSp+sMcyENm7FT+DWY/NPSC86MwjroOuSgb4TnQSDG5qnDemkhXhxeSJOsfOyH/cVh
         MaQYgU1dYv/akE2ojDUWB2gbCipRN6opdoyQpYBZu52lToH3IOMiH1j1mluS4qdL1zMCyg3wP92S
         r91pM7JpAAoNdbzF1TUSlTXRB9QL3rkh/hoRdKZGMEWaLFD1RU8sud4YyLmHnpF/NSxJ6l+v/Wru
         Gf5kDwnbJxtlShFh1Bi/9KfNqd6wSg8ymYH0aFp+Jf9+pOgX25i096QFdpOKy3/wctohsLnrZpL/
         eaVP+QGpYTDJrkRWymozTM0pNLnP/TnrRQYwWsXk/eb54mNty/xOhAsy1XqiJX+1m/WBe2E5TNMH
         bvfFM+gj59CLjM5LlGsHv+SLbQG+zGnuPmM8vWrOX+y+Ym/S9FSAIdJTVITZBeJX84vThfzuCpz7
         OecP4pIQypCJwJtqewUwqlTqdueZJr4UYRIMhm00ER+Lm7tVnk6JSgl9xA4Dev/6iPG57sunKNRs
         3eIL1EGLVPb+aFHuFOvE+Sovup3Hd7jpJTi8CxLeHo5AiW/8cUZsBrtQYn7Mu+gVY43CpxJgI5T3
         ZzrFKCPBJDsgJgFNnaw9u6eo+75KUTXQpvJvMutOE9+SPH7DTdHMIA3oAemwkp0cpQ3UHta8AgPz
         jmFyPeWMNv7fDu+FwSyVYX2xFw4Qaynv2O9VtkDQU=
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, nsaenz@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] staging: mmal-vchiq: add a check for the return of vmalloc()
Date:   Tue, 15 Mar 2022 22:42:07 +0800
X-OQ-MSGID: <20220315144207.623-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

vmalloc() is a memory allocation API which can return NULL when some
internal memory errors happen. So it is better to check the return
value of it to catch the error in time.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2  jump to the proper location and remove redundant instruction.
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f03..ff4b484 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1909,6 +1909,10 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	mutex_init(&instance->vchiq_mutex);
 
 	instance->bulk_scratch = vmalloc(PAGE_SIZE);
+	if (!instance->bulk_scratch) {
+		err = -ENOMEM;
+		goto err_free;
+	}
 	instance->vchiq_instance = vchiq_instance;
 
 	mutex_init(&instance->context_map_lock);
-- 
