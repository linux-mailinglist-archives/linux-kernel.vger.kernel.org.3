Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B79562EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiGAItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbiGAItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D21E0DA;
        Fri,  1 Jul 2022 01:48:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAE02621F9;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1ADC341C6;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665335;
        bh=q6GO+RA/vkKq8tjuoPuRJhM1OnZmuwwmIL2YmITsc+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u5jMWUu4ZGh+zipLD92yG6S3biqgvWqIVE8J37n7tlhAC/EqzUFEtLUwfhFQqVf8k
         +gRwEzMudWiJ2vGVuHmtRTAXztevdl8R3ov28IvLQU2Hq/R5+Xo2HhiNLDokirmaSA
         liaypvRlpeTxTfTwske3Aexemhnx1RtJNfpwJWK5+C4T9LhkcGW5tyeXwhuD4khalf
         mGT2IqAf1/wT76KqRRpl6YBD6F4moSxMW90jxv3uqgqjdU+ZgW+yGuc0YiR8C3tvHF
         /2f6J8S/R4aaIRE1/ck71DMpiIJlVd5PNqjF30lrgl8MdbIt5mRQzc7+Z2KrbBt6Up
         WXaBVdOOqNs4A==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7CKZ-006T9K-SY;
        Fri, 01 Jul 2022 09:48:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] scripts: sphinx-pre-install: provide both venv and package installs
Date:   Fri,  1 Jul 2022 09:48:49 +0100
Message-Id: <22f35e31173b368b40252df5ff9f3ef42a87c409.1656664906.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656664906.git.mchehab@kernel.org>
References: <cover.1656664906.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: "Jonathan Corbet" <corbet@lwn.net>
Cc: "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: ksummit-discuss@lists.linuxfoundation.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

As it is not a consensus about installing sphinx using venv, and
modern distributions are now shipping with Sphinx versions above
the minimal requirements to build the docs, provide both venv
and package install commands by default.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/4] at: https://lore.kernel.org/all/cover.1656664906.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 43 ++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 930a6d058c12..27bac4fbe35b 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -25,6 +25,7 @@ my $need_sphinx = 0;
 my $need_pip = 0;
 my $need_virtualenv = 0;
 my $rec_sphinx_upgrade = 0;
+my $verbose_warn_install = 1;
 my $install = "";
 my $virtenv_dir = "";
 my $python_cmd = "";
@@ -103,10 +104,12 @@ sub check_missing(%)
 			next;
 		}
 
-		if ($is_optional) {
-			print "Warning: better to also install \"$prog\".\n";
-		} else {
-			print "ERROR: please install \"$prog\", otherwise, build won't work.\n";
+		if ($verbose_warn_install) {
+			if ($is_optional) {
+				print "Warning: better to also install \"$prog\".\n";
+			} else {
+				print "ERROR: please install \"$prog\", otherwise, build won't work.\n";
+			}
 		}
 		if (defined($map{$prog})) {
 			$install .= " " . $map{$prog};
@@ -386,7 +389,8 @@ sub give_debian_hints()
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
-	printf("You should run:\n\n\tsudo apt-get install $install\n");
+	printf("You should run:\n") if ($verbose_warn_install);
+	printf("\n\tsudo apt-get install $install\n");
 }
 
 sub give_redhat_hints()
@@ -458,10 +462,12 @@ sub give_redhat_hints()
 
 	if (!$old) {
 		# dnf, for Fedora 18+
-		printf("You should run:\n\n\tsudo dnf install -y $install\n");
+		printf("You should run:\n") if ($verbose_warn_install);
+		printf("\n\tsudo dnf install -y $install\n");
 	} else {
 		# yum, for RHEL (and clones) or Fedora version < 18
-		printf("You should run:\n\n\tsudo yum install -y $install\n");
+		printf("You should run:\n") if ($verbose_warn_install);
+		printf("\n\tsudo yum install -y $install\n");
 	}
 }
 
@@ -509,7 +515,8 @@ sub give_opensuse_hints()
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
-	printf("You should run:\n\n\tsudo zypper install --no-recommends $install\n");
+	printf("You should run:\n") if ($verbose_warn_install);
+	printf("\n\tsudo zypper install --no-recommends $install\n");
 }
 
 sub give_mageia_hints()
@@ -553,7 +560,8 @@ sub give_mageia_hints()
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
-	printf("You should run:\n\n\tsudo $packager_cmd $install\n");
+	printf("You should run:\n") if ($verbose_warn_install);
+	printf("\n\tsudo $packager_cmd $install\n");
 }
 
 sub give_arch_linux_hints()
@@ -583,7 +591,8 @@ sub give_arch_linux_hints()
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
-	printf("You should run:\n\n\tsudo pacman -S $install\n");
+	printf("You should run:\n") if ($verbose_warn_install);
+	printf("\n\tsudo pacman -S $install\n");
 }
 
 sub give_gentoo_hints()
@@ -610,7 +619,8 @@ sub give_gentoo_hints()
 
 	return if (!$need && !$optional);
 
-	printf("You should run:\n\n");
+	printf("You should run:\n") if ($verbose_warn_install);
+	printf("\n");
 
 	my $imagemagick = "media-gfx/imagemagick svg png";
 	my $cairo = "media-gfx/graphviz cairo pdf";
@@ -873,6 +883,16 @@ sub recommend_sphinx_version($)
 	printf "\t. $virtenv_dir/bin/activate\n";
 	printf "\tpip install -r $requirement_file\n";
 	deactivate_help();
+
+	printf "\nAnother option would be to install Sphinx package with:\n";
+
+	%missing = ();
+	$pdf = 0;
+	$optional = 0;
+	add_package("python-sphinx", 0);
+	check_python_module("sphinx_rtd_theme", 1);
+
+	check_distros();
 }
 
 sub check_needs()
@@ -945,6 +965,7 @@ sub check_needs()
 	check_program("latexmk", 2) if ($pdf);
 
 	# Do distro-specific checks and output distro-install commands
+	$verbose_warn_install = 0;
 	check_distros();
 
 	if (!$python_cmd) {
-- 
2.36.1

