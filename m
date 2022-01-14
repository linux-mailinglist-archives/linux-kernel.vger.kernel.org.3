Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB148E344
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 05:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiANEYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 23:24:47 -0500
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87]:53815 "EHLO
        out162-62-57-87.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239155AbiANEYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 23:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1642134280;
        bh=Urrkg6gwwF34U0YTNyiFQ168PUplzRETtVsXA1AEVUY=;
        h=From:To:Cc:Subject:Date;
        b=PSopq1s2afJg2RbousGGyHogPPAl475J4/LyUu8/mVURJm09TWFbrQJP+PRCbSUNy
         d5nF/Hu0ADZmILxrW0bJCgdSXglJyIn2uxhdLjaPMynrDN6OWdBHZUL44DkvklRoLL
         ECGivSrLjoNyJUhjZWmb2DCpLbUYuE0WNTzeaF6A=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszc7.qq.com (NewEsmtp) with SMTP
        id 624AE4DF; Fri, 14 Jan 2022 12:24:36 +0800
X-QQ-mid: xmsmtpt1642134276thc8y7i40
Message-ID: <tencent_A49992D0BF00081EB37A6E21070E45563806@qq.com>
X-QQ-XMAILINFO: MdDuF0zFTqpBTE1h0UcV7El2iSZ4hsOsUyhv1NB7KJLEDYXIncMeLXrV79mQAV
         Cv9Ur2fKKv30U5O8R3Qh787ksB8YCZAounoOQuHXspH5OkgK7FginIIqRxRR5EPRh4q5mc7oLFgG
         4F9SiAuU7iZe2H7CZcxa3h3naAO1m42DxbMOrm1fOTMaI/jComTJejrViXSVuv6bJvcQUERcbGtl
         K/v+LyXB+svOnxTLue1bYkuhyL5yfmQ0Qb0KU4RgL1bHIeFeu+dx673sYyoQm7pXY9BZSUDHVOTI
         ly/vtMl/aPthF62lZK0kcLMfMNjxSfRInMsOV8iNdM7Zs9ItIcNz9xFOWSP05qt+dtQl6U8sGiOt
         iYU2SDNxVTCI/Gsurn//HjV3KPH31cgv/Db0DadH23xYNqmznYaK7JtNe7irJP9e7BmkpshU74bH
         s8Bxywjut3dVO6Jc314bZwswwFXWt9b46/IaAxEbn9iyajzwEGvyU3RsfjFjiTO7SkXkJU2JjiLB
         ExpnExs4HlnzfbeA8JHUJM8R86Q/vdJYJLf3eh8GumWHFsPJOj68jmVKcxQTxoTdj7fj1q1XNusE
         MxXBbr9gZPZNhAjSECFaNjry6wMGbwGYl8hLGZGbLvsHqROArV5l0RTzas/ebdTjbDnjKC8DV0Ca
         ++Q/EmtLsXFHUjG9W1GnQJTa0h8m4UWrk4oKERNk6XUIFfWs1LKVl07FSiItgfGIpYx2iqeykCVH
         k+JPUvJrClgNh8+5Y/6wk/5aGHIpNXowlFYmwzC5OYWBeU5xP5MGXWt8qgfEETKc/KxEVvGnOE3c
         iYAILGS4Pl22PNAEMa9PgtXH4lV2vkZhqjFSa8rBEwV7VaQRnXNLU7PrZQeWw4HsoMcREmwynpXn
         b6q0dbp5VupVFos6RHWozjBFJJnlYcOWaVEgG+v5A3xYKSCB3qbhw=
From:   xkernel.wang@foxmail.com
To:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCHv2] integrity: check the return value of audit_log_start()
Date:   Fri, 14 Jan 2022 12:23:44 +0800
X-OQ-MSGID: <20220114042344.1693-1-xkernel.wang@foxmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

audit_log_start() returns audit_buffer pointer on success or NULL on
error, so it is better to check the return value of it.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
Changelogs: simplify the patch. 
Note: Take the suggestion from Paul Moore.
 security/integrity/integrity_audit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index 2922005..0ec5e4c 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -45,6 +45,8 @@ void integrity_audit_message(int audit_msgno, struct inode *inode,
 		return;
 
 	ab = audit_log_start(audit_context(), GFP_KERNEL, audit_msgno);
+	if (!ab)
+		return;
 	audit_log_format(ab, "pid=%d uid=%u auid=%u ses=%u",
 			 task_pid_nr(current),
 			 from_kuid(&init_user_ns, current_uid()),
-- 
