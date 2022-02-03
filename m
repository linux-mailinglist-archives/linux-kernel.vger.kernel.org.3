Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785494A8543
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350867AbiBCNb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350854AbiBCNbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:31:51 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8FCC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 05:31:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id t17so1983899qto.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 05:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vkqw7ihAAseGtawoWQ4hf4k9LnUB3LMz8HTo/0cqpis=;
        b=FLtuJwLxj+fWxpizltQwf9tRpiQFjPpaJadJECzAMOd+9Qw4OwYya076LMoQzGUXiU
         5YQLJOIYh9hnTnw9WhOGbtUV3iTn0JfHDLlEvws2/cgse5s0zliJJrzvXcz8BaGTK7xO
         Yw4loHhJf88RrJT+/e/ChaCv9qxtN6vCN1vKCKUbgU2TY2RJ0KrZ+AqjTUgksgXwrTyK
         ecnSL+Nzno6xJCy9B5ZjVk9oiTvOa87iDDViae7ROIJQcxIEAkFcmvov5PJm/IPLcyWX
         Zoymdoxj/dhvzL65IIWTfDPqkuyYCrFc0GcUI/76h1Y4p1iqS7Qi9ZqeKxPQhAj3M9+J
         W3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vkqw7ihAAseGtawoWQ4hf4k9LnUB3LMz8HTo/0cqpis=;
        b=YaGR7MNbDxYm17QrVIl7IqNut6OUyYF3N76PTeTEFR6+sGVubRYSvH7KFNGY4RtHJe
         Q5LPawORP/YcpBCdIxikoH94gFaLTObf4hwTVEw46tP5UQvBT4grwHSCNYnuCCy5st2H
         CfFzydDzfGGC9KhLoOXQ3u/vM//UrNOsu26A4hfv99Mn5g9lEychH7fTgiHjkeB2hF/1
         rMTcVoctx1Mjl6AW5Q5u4LRHRC/UKj4LdBDQvcWE8+QB8h1ZGaR60e1cMFJUPndZPdTS
         b85uwAR07gUI3lKuTUNbT/MLVesKXlAHv+b4NMRXNnNMvumNHreHYzWILEAC9RblKBQB
         yurw==
X-Gm-Message-State: AOAM532fd82b2qd06FtGmydFRWt2KCEMxOnNPw4DcEGTCJc4eo2reD1n
        kGngJtsqn02qVy4g16ejZG/vnx9v09M=
X-Google-Smtp-Source: ABdhPJyNiCKD9BnRkxLjj4WL8rwgnJIzBcZ8fX0jKHh1zaH9cQ8FvpERxZ+nbXDdeOdjb0XremTmFA==
X-Received: by 2002:a05:622a:8f:: with SMTP id o15mr22180002qtw.487.1643895109702;
        Thu, 03 Feb 2022 05:31:49 -0800 (PST)
Received: from pm2-ws13.praxislan02.com ([2001:470:8:67e:ba27:ebff:fee8:ce27])
        by smtp.gmail.com with ESMTPSA id f16sm5502316qtk.8.2022.02.03.05.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 05:31:49 -0800 (PST)
From:   Jason Andryuk <jandryuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH v2] kcmp: Comment get_file_raw_ptr() RCU usage
Date:   Thu,  3 Feb 2022 08:31:34 -0500
Message-Id: <20220203133134.6949-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This usage of RCU appears wrong since the pointer is passed outside the
RCU region.  However, it is only used as a number and not dereferenced,
so it is okay.  Leave a comment for the next reader.

Without a reference, these comparisons are racy, but even with their use
inside an RCU region, the result could go stale.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
v2:
Rephrase comment and tweak commit message.  (Cyrill)

 kernel/kcmp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kcmp.c b/kernel/kcmp.c
index 5353edfad8e1..04874c7ac0ab 100644
--- a/kernel/kcmp.c
+++ b/kernel/kcmp.c
@@ -63,6 +63,11 @@ get_file_raw_ptr(struct task_struct *task, unsigned int idx)
 {
 	struct file *file;
 
+	/*
+	 * Fetch file pointers inside RCU read-lock section, but
+	 * skip additional locking for speed.  The pointer values
+	 * will be used as integers and must not be dereferenced.
+	 */
 	rcu_read_lock();
 	file = task_lookup_fd_rcu(task, idx);
 	rcu_read_unlock();
-- 
2.34.1

