Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9774D3863
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 19:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiCISEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 13:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbiCISEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:04:13 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4054565C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 10:03:14 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id im7so2632688qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7//5WGEHwjqe2bICZboVYvRQFNwW3c3+2be3/LbYcZ4=;
        b=Fn4AI9GPiTd3TQeCzD71Wyi5K3kXWyZckgC0YzUgQlVz5UnOu7njPWw2IT51slzD3D
         vUT5lsYAU5SiMCH2p8/Yw2uDGjXZV/GmFoEZYP/OYMEsKqEndNXPnck224zYXHzur1CR
         3noGqnExOjfvMgGnKyZRp1fJXj+i7eYFzgk/GqZErayKw0hfLC8lHVMQWgLw0AQylQvQ
         zBcpcuKvFS1XIDs31oU/B4IlXSXslVgisJkeKS4480/RCpedsHCrrfqNSITQsvQrXPWo
         WilKu3nfVO53UnfqtxksO8Dr3PAmr3VqLTyS/+XRMnymFO0+zE1B2x4R5yJpatuSzFKP
         ZcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7//5WGEHwjqe2bICZboVYvRQFNwW3c3+2be3/LbYcZ4=;
        b=RWOMf2XqeDCzGwJ6817sJMkS81+fC5WytJ+I3e65jAf0G/3HbNF0bobGl0VzLYSWbt
         YrAOZ5jP8VyVH7HdQ//qRqlOZKmXVRd4cjlEzDtuPVVyR+Hscsq+GEAN9z900F4ozI5R
         RkyDRyn3otnLSlFwpbooCV8LkFDaKFwa1oWkxxImcSLIBONL5wR5VjWQmGFq/RDeEGJI
         KUj38M7YUNglLvKXsBfcjdktsFMcPKRlCfT6DfUPducybjtRfs9KWlnga4FWrrexrPw8
         okniZ6YOLKpRWaElU2MR1w4+eIFAmgqa08xIqD1Y7kncoZ6Gu3GiIJdNYUImLviHcjWi
         /sbg==
X-Gm-Message-State: AOAM530rpdS2Jh51LGnOm+IdIHRQbx9NFIWWyoP9ew7sObz0RbQze00N
        wV+4By7jenKTCuu46/WZupqoYA==
X-Google-Smtp-Source: ABdhPJwZ1gCjB8wHBq7S0Ok2bKRSbw+YhaU3o/w8FElXExas99p92MP+dcVE4fVLyrP1eL+S1es8bw==
X-Received: by 2002:a05:6214:19ed:b0:42c:289b:860e with SMTP id q13-20020a05621419ed00b0042c289b860emr781716qvc.73.1646848993287;
        Wed, 09 Mar 2022 10:03:13 -0800 (PST)
Received: from localhost.localdomain ([107.13.145.4])
        by smtp.gmail.com with ESMTPSA id 4-20020ac85944000000b002e1a12b17fesm1584136qtz.92.2022.03.09.10.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:03:12 -0800 (PST)
From:   Sagar Patel <sagarmp@cs.unc.edu>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-kernel@vger.kernel.org, Sagar Patel <sagarmp@cs.unc.edu>
Subject: [PATCH v2] checkpatch: use python3 to find codespell dictionary
Date:   Wed,  9 Mar 2022 13:00:49 -0500
Message-Id: <20220309180048.147672-1-sagarmp@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0ee3e7b8893e ("checkpatch: get default codespell dictionary path
from package location") introduced the ability to search for the
codespell dictionary rather than hardcoding its path.

codespell requires Python 3.6 or above, but on some systems, the python
executable is a Python 2.7 interpreter. In this case, searching for the
dictionary fails, subsequently making codespell fail:

No codespell typos will be found - file '/usr/share/codespell/dictionary.txt': No such file or directory

So, use python3 to remove ambiguity.

In addition, when searching for dictionary.txt, do not check if the
codespell executable exists since,

  - checkpatch.pl only uses dictionary.txt, not the codespell
    executable.
  - codespell can be installed via a Python package manager, in which
    case the codespell executable may not be present in a typical $PATH,
    but a dictionary does exist.

Signed-off-by: Sagar Patel <sagarmp@cs.unc.edu>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hey,

Changes since v1:
- reword commit message to clarify that the codespell executable is not used,
  and that the executable may not be present in a *typical* $PATH.

---Sagar Patel
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b01c36a15d9d..46302e074b18 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -334,7 +334,7 @@ if ($user_codespellfile) {
 } elsif (!(-f $codespellfile)) {
 	# If /usr/share/codespell/dictionary.txt is not present, try to find it
 	# under codespell's install directory: <codespell_root>/data/dictionary.txt
-	if (($codespell || $help) && which("codespell") ne "" && which("python") ne "") {
+	if (($codespell || $help) && which("python3") ne "") {
 		my $python_codespell_dict = << "EOF";
 
 import os.path as op
@@ -344,7 +344,7 @@ codespell_file = op.join(codespell_dir, 'data', 'dictionary.txt')
 print(codespell_file, end='')
 EOF
 
-		my $codespell_dict = `python -c "$python_codespell_dict" 2> /dev/null`;
+		my $codespell_dict = `python3 -c "$python_codespell_dict" 2> /dev/null`;
 		$codespellfile = $codespell_dict if (-f $codespell_dict);
 	}
 }
-- 
2.25.1

