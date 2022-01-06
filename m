Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808524862E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbiAFK0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237129AbiAFK0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:26:12 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A85C06118A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:26:11 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q8so3769611wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 02:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXEy2JWqJ3SIAUYkh8ZNaC8ZweH0TNacKsusb8Rd4Cc=;
        b=cpTHs1MmcQ4aVFKUDrCc10ZLWTqvE6Zz0AMAvgNV6st8WB8je6nDeju74emJLV4vq7
         w+cLYv46RHMRlnSeZzaCZebd9gWYLDVMXMXK/Z6d5Iehi+CvAup11AIbHy0J3f6R+NX3
         BlUxM1uzlwnomEvRu4fqFN0UaWRnfD8NL96RMpmt7gGvEJkfta30ThbJ0626pUvdETa2
         93fZ2PbW4GyopCmg60w6JdcfRHCKj5Uxl38GJZmgzUN5DCpl99ni3SZkJTs3fulQ63ej
         5nQw1biCp00wIrfQlQyzaADnMyp3iSI/bS+7dGwl4/CfmZRWF02ODZ4grwmDTqULTgHa
         yJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXEy2JWqJ3SIAUYkh8ZNaC8ZweH0TNacKsusb8Rd4Cc=;
        b=RhwiA8fD0Kio+mUk74ypYUFqXQYZjfFvbvvaeOkjBn1KCTZECaum9/K7x8hiJBIUGC
         df+37unCYklNC26t/CnM93Y8zilwdl5SBaitxcrlcRzcyL/Rp80HuL1FKZnRqVB+P6UF
         y34KBqyPWjPn4JFBrCGc1LKUaECLxvnbeXula4JaJc1WArCo7h7eeLqyl34EfFMB3Sl3
         b/9HRvXR9Oysm0g+Js8+fFWnpFwgGiN7XpfWT2Ff6ikaJVigvonARdm9UrY9PqXgmzZc
         LgReiPmOwphiKmcgcCBTtViXZjlTC781vGKWV9j3hLCweNk58lXZLghVJaDkoK1gtqKq
         zkgA==
X-Gm-Message-State: AOAM5321zMzeO+gh2sApm8paJW+kLsG460hO7RAngU5mANxa0BwMN/OQ
        hwjnKEjuT6KBHUIVrpUxyFLjKg==
X-Google-Smtp-Source: ABdhPJzyMbHwEPoud6lmHP1xhl6IJo5bRI1Oil2SZ8cbIoUzjb6ksEX69Lkr8fG0rS/zqB64CgO85w==
X-Received: by 2002:a05:6000:2c9:: with SMTP id o9mr50414363wry.377.1641464769966;
        Thu, 06 Jan 2022 02:26:09 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id h204sm1363792wmh.33.2022.01.06.02.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 02:26:09 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3] mm, oom: OOM sysrq should always kill a process
Date:   Thu,  6 Jan 2022 11:26:05 +0100
Message-Id: <20220106102605.635656-1-jannh@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OOM kill sysrq (alt+sysrq+F) should allow the user to kill the
process with the highest OOM badness with a single execution.

However, at the moment, the OOM kill can bail out if an OOM notifier
(e.g. the i915 one) says that it reclaimed a tiny amount of memory
from somewhere. That's probably not what the user wants, so skip the
bailout if the OOM was triggered via sysrq.

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/oom_kill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..3c480b24a93c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1057,7 +1057,7 @@ bool out_of_memory(struct oom_control *oc)
=20
 	if (!is_memcg_oom(oc)) {
 		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
-		if (freed > 0)
+		if (freed > 0 && !is_sysrq_oom(oc))
 			/* Got some memory back in the last second. */
 			return true;
 	}

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
--=20
2.34.1.448.ga2b2bfdf31-goog

