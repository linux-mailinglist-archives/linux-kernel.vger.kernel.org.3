Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172E5517389
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386082AbiEBQEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386119AbiEBQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:04:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54562BC9C;
        Mon,  2 May 2022 09:00:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l18so28559074ejc.7;
        Mon, 02 May 2022 09:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Os4/s4uH06DSewsQZ4Jw4mtY1gOh+ru8ll+LispUhdk=;
        b=De0pLEoiOywAueFbxfwipQsICqvS0dsuUca/89fJwmt8cMOCADBrLd0jk/+L3uSjIw
         2UIjl7fmHwEZv4kzpuU12JiX6t/hMIcRKrozwHoObJbe9vcKPsPYz3yF+A4tOu3QQzQu
         jJJ907cxlGe5ZhwrEpVu+eXW2I+w7QNe/wwhnRaac4iDzYXZWf7Tl6BHov6x44MGFzhv
         md/jQ1niDinl3W2S90Es19kf8nlUMyNqDk7DReRJON/IKscLS0AwPPeeir2fFgQ5tKlz
         B63TKfB7k12MM30ceHweTK2NAcvWQAEHZs0WX1AZAwYsdQbu4P2g/WRBq75njU/iMbeN
         y54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Os4/s4uH06DSewsQZ4Jw4mtY1gOh+ru8ll+LispUhdk=;
        b=zS+45VSY7tL7P4VXD5vF7AU91oQl6n2juVugkjuJcl7WwbvqXbwCFOSdxn8JRLy4qj
         J7YiIfaOxfBbQBJiEqkpIXVYDN0EHoFNbd8CEp2lq2EABUUE3SHTPxMZ4x7QCYkJ/DTL
         TAF6Ad1HajUp/jT/8PCWP471vi+KbXaYztNy+ZYji2f+0pdZuuq8siXEbPG2NFIx5tV8
         qyiBRjtdR+YPDXME7pWiB6Dad3PQmzlkNdXZEvHB2keDNMr887j/o1j1QRNZxUrbKYvD
         XzI3evUtBniFtKazigligdOTtOowOyH/x1s+lATrloTSKngbHXvyF7R5yEfuxPLTUZk2
         zfDQ==
X-Gm-Message-State: AOAM533jWR5p4fmFGBy0+VA6WKpN9BnXpBblyItaqH7tIN9z2kC44q5V
        308UnIL8DHMtF643/5awEfxE45HabOzojw==
X-Google-Smtp-Source: ABdhPJwNyP9B/ceNh6I/KpSWQ6cIw451YMz6DGK8zmKupHfg1OOBRNmxdcPTPxv74DJlpwk+tOpjaA==
X-Received: by 2002:a17:907:1c21:b0:6f4:7a8a:d6a2 with SMTP id nc33-20020a1709071c2100b006f47a8ad6a2mr811397ejc.288.1651507252707;
        Mon, 02 May 2022 09:00:52 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-001-135-067.77.1.pool.telefonica.de. [77.1.135.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709070b1200b006f3ef214dd3sm3689996ejl.57.2022.05.02.09.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 09:00:52 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] kernel: use new capable_or functionality
Date:   Mon,  2 May 2022 18:00:27 +0200
Message-Id: <20220502160030.131168-5-cgzones@googlemail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220502160030.131168-1-cgzones@googlemail.com>
References: <20220217145003.78982-2-cgzones@googlemail.com>
 <20220502160030.131168-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new added capable_or function in appropriate cases, where a task
is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..3ae87b864380 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2098,7 +2098,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = -EAGAIN;
 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		    !capable_or(CAP_SYS_RESOURCE, CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
 	current->flags &= ~PF_NPROC_EXCEEDED;
-- 
2.36.0

