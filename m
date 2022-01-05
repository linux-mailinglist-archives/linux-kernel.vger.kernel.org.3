Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A64674857AF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbiAERw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 12:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242581AbiAERwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 12:52:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68037C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 09:52:15 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j18so84622919wrd.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5GT6AWgowXMeNIuQyJYxsilVHwUS2CUc3fcBKbiq5M=;
        b=Z4UaC+WcOqG1yJseMWSPH9mDiu4olkW2I0tHm5x4PXwZ413u/NenAQZ5o5LUlc0DTM
         V2DLOD0kwfnuPlFLo0gcu9GoQXmxww9za1w3i6X9D6XzrQQEGeskyjn2+R6aVc1DryqJ
         oYGII0Yt336SXJgYycaWvEN2WGURvyyl4wct8xyqE5aLu/jbE25zKgudmOqRJi4VV0gK
         kg6/61YfaywhiDs0nssIdhcVDzw7pXazrjTsnkqdj0dUU0YY2ac5jkrAgR2nKD1bbNWG
         0L/K7KzXalozcC5o4pj924GYVepD5oEfTtlj/E3eet8NSjDEsHuNjDwMsSOYgVjHIa7y
         XpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5GT6AWgowXMeNIuQyJYxsilVHwUS2CUc3fcBKbiq5M=;
        b=y2mRg/dWAlpYeI67AoA1kC2wUUEuJbnX4kG9mZdL7MoSwYV+YnryMjhBekjsL/AsMq
         hO3D1kqVV3U5cYe1ddG7sLPNrv4jcK11nZFlvaXFD3o6wC1++biibk4Ze+u+odP74QoL
         b6FMQeZY+WYnnFSJQBbdB85PImXvYfhVM0hqceJ3T6enlTxyg8WE0W7/WFEx0CTgUA25
         x+rUCZod1zO9quOGQJg1dMpt6oDFVzCVo9ck/z9x3A9DK77kKbXvjCWvjZNnXOg+o+Op
         Mk0jiRi/kA9nu3W65tOIVhCqxBp2YpkNxS3VftsS5ys3paEMfkNJXSTUfaGwx0eQuTiD
         sXew==
X-Gm-Message-State: AOAM533wWQ/rfypy/ZgV5k40xH0hzkTdkhvoEiEWwiiMiNxkeQPypu17
        uWfk4qFEzLaZ5YNIADL307dTyA==
X-Google-Smtp-Source: ABdhPJxkDT3SlyZ2BvvPWw1OKwAZ5KiuQVU4U7TxsMzATu+Vxw+3+4t1wNjyxIq7/1Yldgo+a/ewtA==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr10927619wro.647.1641405133760;
        Wed, 05 Jan 2022 09:52:13 -0800 (PST)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id b1sm47085290wrd.92.2022.01.05.09.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:52:13 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH] mm, oom: OOM sysrq should always kill a process
Date:   Wed,  5 Jan 2022 18:51:15 +0100
Message-Id: <20220105175115.605074-1-jannh@google.com>
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
from somewhere. That's probably not what the user wants.

As documented in struct oom_control, order =3D=3D -1 means the oom kill is
required by sysrq. So check for that, and if it's true, don't bail out
no matter what the OOM notifiers say.

Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 1ddabefcfb5a..dc645cbc6e0d 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1051,13 +1051,14 @@ EXPORT_SYMBOL_GPL(unregister_oom_notifier);
 bool out_of_memory(struct oom_control *oc)
 {
 	unsigned long freed =3D 0;
+	bool sysrq_forced =3D oc->order =3D=3D -1;
=20
 	if (oom_killer_disabled)
 		return false;
=20
 	if (!is_memcg_oom(oc)) {
 		blocking_notifier_call_chain(&oom_notify_list, 0, &freed);
-		if (freed > 0)
+		if (freed > 0 && !sysrq_forced)
 			/* Got some memory back in the last second. */
 			return true;
 	}

base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
--=20
2.34.1.448.ga2b2bfdf31-goog

