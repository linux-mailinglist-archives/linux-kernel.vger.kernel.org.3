Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BC563F65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiGBKLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056D5186C1;
        Sat,  2 Jul 2022 03:11:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A24A60C09;
        Sat,  2 Jul 2022 10:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21CCC341CE;
        Sat,  2 Jul 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656756694;
        bh=wMdXq2y82GLiB6F6ppucYweW5DGaedV5+P83VXCnYMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwEvOgZZIv/S7hq91E0RU8y2CGQDZq1wliv9825COknHo1AR+bpXqQWp6ZcmYC/Nr
         iTlriAk7SUEX2p32Xm00lXafO5HdrhRz5UQ3fkzoiliSDc4bttlnaXJyVk7FH+kYt5
         rsDh+59Ir5KGBSQModfpKvE9UujjwteJRUNOnHOSK9Cm48EU21ggnPBHYvEyceY3Ce
         8vq6V3ufFtyxxoBCb60ztBijNNYcrUZ/lqMMGqNXyWGL2+feskQEKZXJKu3L25BX4i
         8RCtPzxs7SOwWqqzGiQlcR5PYPuLWGtN/YPHUDuXeNcoyzkBYoO0LrtE08zQUoOYvn
         3RzRS39skKmDg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7a67-007cMm-Nb;
        Sat, 02 Jul 2022 11:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] scripts: sphinx-pre-install: provide both venv and package installs
Date:   Sat,  2 Jul 2022 11:11:28 +0100
Message-Id: <7c99d985df204c73e3daafd5fd2f30a31269405d.1656756450.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656756450.git.mchehab@kernel.org>
References: <cover.1656756450.git.mchehab@kernel.org>
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

As it is not a consensus about installing sphinx using venv, and
modern distributions are now shipping with Sphinx versions above
the minimal requirements to build the docs, provide both venv
and package install commands by default.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/5] at: https://lore.kernel.org/all/cover.1656756450.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 55 +++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 930a6d058c12..106d75425d3f 100755
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
@@ -700,7 +710,7 @@ sub check_distros()
 
 sub deactivate_help()
 {
-	printf "\nIf you want to exit the virtualenv, you can use:\n";
+	printf "\n    If you want to exit the virtualenv, you can use:\n";
 	printf "\tdeactivate\n";
 }
 
@@ -863,7 +873,7 @@ sub recommend_sphinx_version($)
 			print "To upgrade Sphinx, use:\n\n";
 		}
 	} else {
-		print "Sphinx needs to be installed either as a package or via pip/pypi with:\n";
+		print "\nSphinx needs to be installed either:\n1) via pip/pypi with:\n\n";
 	}
 
 	$python_cmd = find_python_no_venv();
@@ -873,6 +883,25 @@ sub recommend_sphinx_version($)
 	printf "\t. $virtenv_dir/bin/activate\n";
 	printf "\tpip install -r $requirement_file\n";
 	deactivate_help();
+
+	printf "\n2) As a package with:\n";
+
+	my $old_need = $need;
+	my $old_optional = $optional;
+	%missing = ();
+	$pdf = 0;
+	$optional = 0;
+	$install = "";
+	$verbose_warn_install = 0;
+
+	add_package("python-sphinx", 0);
+	check_python_module("sphinx_rtd_theme", 1);
+
+	check_distros();
+
+	$need = $old_need;
+	$optional = $old_optional;
+
 }
 
 sub check_needs()
-- 
2.36.1

