Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D87563F6A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiGBKLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbiGBKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:11:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636DE186C1;
        Sat,  2 Jul 2022 03:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E905B80B74;
        Sat,  2 Jul 2022 10:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA03DC341CA;
        Sat,  2 Jul 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656756694;
        bh=4fxaIwjih4ajTW4WLPyem4PV3PKwddCqz91QnrLu8SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX4JyE5M7c1wuWFOZd/BEwy2IJ5ge1tG8q268GdQTbZ2KLHQ/2C/9msMQNmvHzZI9
         kj6VP47UPjYBjV0VNXlP/tJxjbnXESdEbAHEDGNlM8EW8CUbjoWdyOqAr9W50T8Fy2
         Ze+PVJl73Inrzu448uDcqPsyR0jqD91BufK7xUg/S0/KM+VYr/OMsy8OTDsZdmRnMl
         xGYQrfYGMiBIOd4uWd5Mh64lWax5cRg0HNLv7Qg5+gvc9Ll3daBdBUxIB+/MFjup4z
         GdFYYKsCQ9xbWsRzCkZ0TlydU2T+gZps14xTQ1tb9gJVC/kr2HpDqTCgjG+Dpyih5Q
         GCWoAxtd32iYw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7a67-007cMj-N3;
        Sat, 02 Jul 2022 11:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] scripts: sphinx-pre-install: check for PDF min version later on
Date:   Sat,  2 Jul 2022 11:11:27 +0100
Message-Id: <8e117aabe6dfa1b1ec92dccd20e801393c977667.1656756450.git.mchehab@kernel.org>
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

Better to add the PDF note late for venv recommendation.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/5] at: https://lore.kernel.org/all/cover.1656756450.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 18537e5af692..930a6d058c12 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -785,12 +785,13 @@ sub recommend_sphinx_version($)
 {
 	my $virtualenv_cmd = shift;
 
-	if ($latest_avail_ver lt $min_pdf_version) {
-		print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
-	}
-
 	# Version is OK. Nothing to do.
-	return if ($cur_version && ($cur_version ge $rec_version));
+	if ($cur_version && ($cur_version ge $rec_version)) {
+		if ($cur_version lt $min_pdf_version) {
+			print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
+		}
+		return;
+	};
 
 	if (!$need_sphinx) {
 		# sphinx-build is present and its version is >= $min_version
@@ -837,6 +838,10 @@ sub recommend_sphinx_version($)
 			printf "\t. $activate_cmd\n";
 			deactivate_help();
 
+			if ($latest_avail_ver lt $min_pdf_version) {
+				print "note: If you want pdf, you need at least Sphinx $min_pdf_version.\n";
+			}
+
 			return;
 		}
 
-- 
2.36.1

