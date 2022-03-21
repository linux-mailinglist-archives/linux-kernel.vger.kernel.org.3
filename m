Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7E4E2F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351989AbiCUSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbiCUSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:07:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3C5EDDE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:05:43 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z8so17062197oix.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=csFbV8mex3SknnrbFvywrMSrr0CsC7QVTDfRrFG7bIc=;
        b=RPet5TW1bR0DE2bWAU0VRzEoOKF0hmUrHqGvQL/S8gHdSwSDeg8xJ5mnbmRb04fKlY
         E13YRRZ8/UN1VdBu3PoT3SWm3oMlVbfIyEA2i2xCQaxrfkKWkalxP+yPAWnrWrJnag0u
         XXCzsSJNTRLY36JtE0LjLuoubdR4u/OkR+3E9lXsYrYpzIrLIa42k4JrdPaln6fBJcfh
         Uc51G5e7zC5A40UWGUxrOUplsoBupbErpXcAw457hLkkBEqCPJ7Cd6Z5Dn9eLf5KDL58
         vf6jW4Oaw9kgJjgzSveQml59YIqwHB7JwQxPOnMVzaNST5WZbIsMaSwxPXC/ECiyXhoZ
         9r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=csFbV8mex3SknnrbFvywrMSrr0CsC7QVTDfRrFG7bIc=;
        b=e9/9K7QAXeZ4bjakbcvF2k0YyoS6EaRU3927yXbWjQ3Cxsd9BiXVcxT5Wuto8+OB37
         JjpuAet9DoHCMDsMiEDlVpGjlakdynbNaenSgkGUjnfLJABVkLmfSPlZEIjOLaamp2PS
         D7Y0S4vdejaoh+nkTv21c2TzK7v5eQR8sZjIoAzUN/qwNKBCWAq+LGv7x2kB1shMpaDb
         ZSm9dQSJ/BQK2spuNNOnBacqktOAXpQ37CQi9qJpqZOllwCKnlINz4buMJIjyDCsfebs
         MkpyugNhziowHYvMF3MzzFLXMYxlTMPquQNQRJ4jG3hYyn4526xIZIYeEUapAEmM3Ae3
         +mZA==
X-Gm-Message-State: AOAM5303QkKEdnVcHllNSrAsvBhfSphASq/Zn8Yoe0SK8eYKs/2G/CfU
        xR3FedzGERihS34TLCZj5UD72g==
X-Google-Smtp-Source: ABdhPJx43cjfp86LlzUzMsjt6s0dwo08dMlqc4P2DpMOyie/m//toVQ1lOOAa3zRzo0GllwOMVjkQQ==
X-Received: by 2002:a05:6808:19a6:b0:2d9:c463:fac0 with SMTP id bj38-20020a05680819a600b002d9c463fac0mr179438oib.135.1647885942940;
        Mon, 21 Mar 2022 11:05:42 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id r129-20020acac187000000b002ef358c6e0esm4086763oif.49.2022.03.21.11.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:05:42 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] checkpatch: Validate "Fixes:" references
Date:   Mon, 21 Mar 2022 11:07:09 -0700
Message-Id: <20220321180709.1177684-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch guards about non-compliant or invalid commit references
embedded in the commit message, but a similar set of mistakes can be
made when referencing commits in "Fixes:".

Add sanity checks for references to missing commits, short hashes,
improper spacing, improper case or issues with the commit description.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 scripts/checkpatch.pl | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..b602ab50fc5c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3273,6 +3273,42 @@ sub process {
 			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
+# Check for valid Fixes:
+		if ($line =~ /^fixes:\s*([0-9a-f]{5,})/i) {
+			my $orig_commit = lc($1);
+
+			my $case = 1;
+			my $short = 1;
+			my $space = 1;
+			my $has_quotes = 0;
+			my $id = '0123456789ab';
+			my $orig_desc = "commit description";
+			my $description = "";
+
+			$case = 0 if ($line =~ /^Fixes:\s+[0-9a-f]{5,40}[^A-F]/);
+			$short = 0 if ($line =~ /\bfixes:\s*[0-9a-f]{12,40}/i);
+			$space = 0 if ($line =~ /\bfixes: [0-9a-f]{5,} \(/i);
+
+			if ($line =~ /\bfixes:\s+[0-9a-f]{5,}\s*($balanced_parens)/i) {
+				$orig_desc = substr($1, 1, -1);
+				if ($orig_desc =~ /^".*"$/) {
+					$orig_desc = substr($orig_desc, 1, -1);
+					$has_quotes = 1;
+				}
+			}
+
+			($id, $description) = git_commit_info($orig_commit,
+							      $id, $orig_desc);
+
+			if (defined($id) && ($short || $space || $case || ($orig_desc ne $description) || !$has_quotes)) {
+				ERROR("GIT_COMMIT_ID",
+				      "Please use git commit description style 'Fixes: <12+ chars of sha1> (\"<title line>\")' - ie: 'Fixes: $id (\"$description\")'\n" . $herecurr);
+			} elsif (!defined($id)) {
+				WARN("UNKNOWN_COMMIT_ID",
+				     "Unknown commit id '$orig_commit', maybe rebased or not pulled?\n" . $herecurr);
+			}
+		}
+
 # Check for added, moved or deleted files
 		if (!$reported_maintainer_file && !$in_commit_log &&
 		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
-- 
2.33.1

