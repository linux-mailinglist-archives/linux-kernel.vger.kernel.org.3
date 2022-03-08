Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C694D0E25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiCHC57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244797AbiCHC55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:57:57 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97E138DB2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:57:00 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id j5so13631540qvs.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 18:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6uT1PC10a0/sZU/ckmm4M9kWPDBuTdMim0OHDKjtDmA=;
        b=Azi0WH/ztvmKrce1UJJnwiVyDZaD4LIPGs6uqG9im6oFRdInBuZtRveYJc/GxaVqnj
         rMM86N6/HpxNHF6cGN2s5AXLdmdoPbBk8GLM+ZZdYe7kYSfNVs8FXLC4jQ7kZ6J970ja
         vVPg8rIW85cIAgPRgTJyPqutK8iUNl2aTc2od2PjCWohn8EKmnP2JZff/fzdXawCBAi1
         LGXDr/3lBMzfgmuApbvni75Qw9Unl1WLBI/te/aM9XEZii9hfAX3tLaoCvIYFyVo+YHG
         lkNv/dHIlvsbMO+62jdMAltFLKWmCxzLqqfVEkHK5cj9QMeZDwxHM7bT04X54sKMQtco
         z32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6uT1PC10a0/sZU/ckmm4M9kWPDBuTdMim0OHDKjtDmA=;
        b=7eJ54jOmLASjFzYsVWo8hYICAOKx46cSubi3hhyA7AX/vaEQGRXev0zriTaTcY2f9h
         XBBquaQFLGRk8ANzavb4q81rawzAmkSv50j+r0I3I/lQDNV5WMZOHt4bBIUav2Vueid6
         PpkByLujEDa0IGbHkVQQWB6UXQ6GaZRRMhP0kF8/wOy3uq41NOXk9307q0kh1/3+VyPG
         5wGT5BKDEy6p5OTjWhi7xLACWCwvVbFHfjpqI3pIY5LDdaG8LFmypUL5EoY6vheXshje
         jYljexoqq+ASObZe/YRMr44RkvINvl6/H5pCfF4gL6EnxUGAPi6cgAVjnN1Y05oxcYtQ
         VC5g==
X-Gm-Message-State: AOAM531jdB9pl2zvKjAwn1U+ZF0VUWFQ1iowupt3qlVxHWw5eNPiNi6s
        B3P/Z/rjpFnPthUEa4B3p2Vawg==
X-Google-Smtp-Source: ABdhPJwp2oZBKOCaOPhgGjcljZe0P5SmP73qzhpBTRNzL/xIMkqFF5pvnszy0ao2zwgsM4WQGq3RmQ==
X-Received: by 2002:a05:6214:da4:b0:435:66f7:e73d with SMTP id h4-20020a0562140da400b0043566f7e73dmr10611671qvh.59.1646708220021;
        Mon, 07 Mar 2022 18:57:00 -0800 (PST)
Received: from localhost.localdomain ([107.13.145.4])
        by smtp.gmail.com with ESMTPSA id de18-20020a05620a371200b00662cf4b5631sm7118375qkb.23.2022.03.07.18.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 18:56:58 -0800 (PST)
From:   Sagar Patel <sagarmp@cs.unc.edu>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Joe Perches <joe@perches.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-kernel@vger.kernel.org, Sagar Patel <sagarmp@cs.unc.edu>
Subject: [PATCH] checkpatch: use python3 to find codespell dictionary
Date:   Mon,  7 Mar 2022 21:55:48 -0500
Message-Id: <20220308025547.20412-1-sagarmp@cs.unc.edu>
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
binary is a Python 2.7 interpreter. In this case, searching for the
dictionary fails, subsequently making codespell fail:

No codespell typos will be found - file '/usr/share/codespell/dictionary.txt': No such file or directory

So, use python3 to remove ambiguity.

In addition, when searching for the dictionary, do not check if the
codespell binary exists since codespell can be installed via a Python
package manager. In this case, a codespell binary is not exported in
$PATH, but a dictionary does exist.

Signed-off-by: Sagar Patel <sagarmp@cs.unc.edu>
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

