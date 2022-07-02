Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF969563F69
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiGBKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiGBKLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:11:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D88718B2A;
        Sat,  2 Jul 2022 03:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B65060C14;
        Sat,  2 Jul 2022 10:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF254C341CD;
        Sat,  2 Jul 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656756694;
        bh=tyjiB6KXIb2t/OE4/soCi8nyF//+2DvXcvBFmclJruU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tqHiiJ6Jne5DcQX2ahkE0KDPkGEHznmWfh365Q4dkbNYGNCo/gpwQiU3beWEo+rx3
         abIMoF1s7y/kn5tRTBc6BCklWV5LKwnfgs3arjHnR1GBBsamccMkd+N+7tAsSVWCTu
         Bd2LSLLrZiJzuIJE22MVmfTx4pETQ2Hb8Weyv39tDiIz+0GygFrkDkvosFJ+Bj414P
         t1s4ds/YzCFgFXdo7BAZK/iX+YvgBSw+5+oheRt4bAP1XUFMypX2E/VL999NCMvkoM
         sgCju8OdJofs+8px3zJ8neSf9J0tukSooajV8UqvIi8sRZpA9g/faZHWfyAi/VPek4
         InQwEYqiIdmpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7a67-007cMg-MX;
        Sat, 02 Jul 2022 11:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] scripts: sphinx-pre-install: report broken venv
Date:   Sat,  2 Jul 2022 11:11:26 +0100
Message-Id: <f117f03555b0636d2be0b68f3a23b1d3f03ccf1d.1656756450.git.mchehab@kernel.org>
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

After distro upgrades, the directory names for python may change.
On such case, the previously-created venv will be broken, and
sphinx-build won't run.

Add a logic to report it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/5] at: https://lore.kernel.org/all/cover.1656756450.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index ae8c49734899..18537e5af692 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -720,6 +720,12 @@ sub get_virtenv()
 		next if (! -f $sphinx_cmd);
 
 		my $ver = get_sphinx_version($sphinx_cmd);
+
+		if (!$ver) {
+			$f =~ s#/bin/activate##;
+			print("Warning: virtual envionment $f is not working.\nPython version upgrade? Remove it with:\n\n\trm -rf $f\n\n");
+		}
+
 		if ($need_sphinx && ($ver ge $min_version)) {
 			return ($f, $ver);
 		} elsif ($ver gt $cur_version) {
-- 
2.36.1

