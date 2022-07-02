Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADE6563F6C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiGBKLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiGBKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD9918B2F;
        Sat,  2 Jul 2022 03:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13E4260C1D;
        Sat,  2 Jul 2022 10:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C72C385A2;
        Sat,  2 Jul 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656756694;
        bh=TMtnHo/8GUFYMa8hq1V2c5cTtfe8PC0ceSv5rkb1fL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVl7NF0u+LWzCek7eSm3OFN09fXrCKtslN7rkSs8aaR7Hai50hJ+AloTnOKLvA4lt
         A0N9jjngFWhIFgYYgICYxy/Wt9fjWdjTJvdLWz95CMczkNA0Nh62OPzrQ8I8qRCIJs
         jhhVRD/AA0ns1/SpgMddO8GQ5yi3LbsNnzNWFB4lWdCYOJO56ItRcX0TReNG8M5/Tq
         hkf+/VxGuoE8NJAiAF1eedrptNmjOsvZdcajh20WvWYtqhUCiuOcArogWNP4LLyZfk
         KWHp50DLNcg6SHIZmEetxPWHagvPdP+deISwcb6+WDLxEWUNvWy4wgRbSagJgx0N3J
         ZykEwgboeZ8Dw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7a67-007cMd-Lz;
        Sat, 02 Jul 2022 11:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] scripts: sphinx-pre-install: fix venv version check logic
Date:   Sat,  2 Jul 2022 11:11:25 +0100
Message-Id: <afe01b7863fd655986d84ace8948f3d7aede796d.1656756450.git.mchehab@kernel.org>
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

The logic which checks if the venv version is good enough
but was not activated is broken: it is checking against
the wrong val, making it to recommend to re-create a venv
every time. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/5] at: https://lore.kernel.org/all/cover.1656756450.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f126ecbb0494..ae8c49734899 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -741,7 +741,7 @@ sub recommend_sphinx_upgrade()
 
 	# Get the highest version from sphinx_*/bin/sphinx-build and the
 	# corresponding command to activate the venv/virtenv
-	$activate_cmd = get_virtenv();
+	($activate_cmd, $venv_ver) = get_virtenv();
 
 	# Store the highest version from Sphinx existing virtualenvs
 	if (($activate_cmd ne "") && ($venv_ver gt $cur_version)) {
@@ -759,10 +759,14 @@ sub recommend_sphinx_upgrade()
 	# Either there are already a virtual env or a new one should be created
 	$need_pip = 1;
 
+	return if (!$latest_avail_ver);
+
 	# Return if the reason is due to an upgrade or not
 	if ($latest_avail_ver lt $rec_version) {
 		$rec_sphinx_upgrade = 1;
 	}
+
+	return $latest_avail_ver;
 }
 
 #
@@ -820,7 +824,7 @@ sub recommend_sphinx_version($)
 	}
 
 	# Suggest newer versions if current ones are too old
-	if ($latest_avail_ver && $cur_version ge $min_version) {
+	if ($latest_avail_ver && $latest_avail_ver ge $min_version) {
 		# If there's a good enough version, ask the user to enable it
 		if ($latest_avail_ver ge $rec_version) {
 			printf "\nNeed to activate Sphinx (version $latest_avail_ver) on virtualenv with:\n";
@@ -897,7 +901,7 @@ sub check_needs()
 		}
 	}
 
-	recommend_sphinx_upgrade();
+	my $venv_ver = recommend_sphinx_upgrade();
 
 	my $virtualenv_cmd;
 
-- 
2.36.1

