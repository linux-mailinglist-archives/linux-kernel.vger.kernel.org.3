Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BE1562EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbiGAItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiGAItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3D710554;
        Fri,  1 Jul 2022 01:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 811A4B82F30;
        Fri,  1 Jul 2022 08:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24761C385A2;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665335;
        bh=5NEFfbQ4uRZ4CMrxr5oCuU2LU8Mhd/b8q8KWgb2amyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fx+39/nngvd8cGJxG3gEJ11+UOdFwDgn52p5DBdlRGjGeBRir/ZBOt6mDLTKt07L3
         xVFtkOrdxUWuqQgon4infY1einUkrkH3blGVGqDaPisX34XJ8u5G/hKHuap2C9dkcv
         zXCvnD49dtgaYzF7sAYGAOR3FulWOIt5FcOjnoNDLxK/eEhwEvf5L+xeBkcKKDJigb
         0D/tyT1eRUotyQPMv14++y9NU7KCEywu3R30Vprhw3UED27+QeRQvm31VvauCejcdp
         09yOOv/C/WbD5JvZQvPtAjIEy57Y+auX6stjiT67tKfJioDO1e17i76QRucUQE+oOn
         pxlTdgg4AaTFg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7CKZ-006T9B-Qm;
        Fri, 01 Jul 2022 09:48:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] scripts: sphinx-pre-install: fix venv version check logic
Date:   Fri,  1 Jul 2022 09:48:46 +0100
Message-Id: <c7ac6c50287e71a8ccfdb33fa537b642d80ea169.1656664906.git.mchehab@kernel.org>
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

The logic which checks if the venv version is good enough
but was not activated is broken: it is checking against
the wrong val, making it to recommend to re-create a venv
every time. Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/4] at: https://lore.kernel.org/all/cover.1656664906.git.mchehab@kernel.org/

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

