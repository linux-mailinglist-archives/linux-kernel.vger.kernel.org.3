Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB5562EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiGAItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiGAItM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:49:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B103101ED;
        Fri,  1 Jul 2022 01:48:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 69D4DB82F2F;
        Fri,  1 Jul 2022 08:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C3BC3411E;
        Fri,  1 Jul 2022 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656665335;
        bh=h5ZruEJ95WKJ2GkkQoahYktyKw9EOQdVkp6S/Q58M/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjUvQ6ldjSecl9YK6o+96aDdSYZlAySFkpsb/m9xVhslmuoV3a8QB4r22WhgvZ7aA
         bj318/1wCaFEsl2ahHyJioDNDMC+LxKCLV186jos4gUb8lRZXr+5U6nSzunuiUqh14
         b6atIYfcy2M8poLGDiFWWvpZcpAYbr0VFt+gipmVIgvE+0OL83Nr31Su3xFOvKlBy7
         QygFWDFtT5K72RPjm8G0rrTJ5g/aAQwSa7uxBVT+BtjlWD3IL3GAq6kwIq14pVYwgP
         JE4SLDobYts7WwdC0cunxRm515oelOt9Uu26/ryT2IBnUaP7MhEpx2nMhDAzPn8tcq
         tJBAjnTBe5HQg==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7CKZ-006T9E-RI;
        Fri, 01 Jul 2022 09:48:51 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] scripts: sphinx-pre-install: report broken venv
Date:   Fri,  1 Jul 2022 09:48:47 +0100
Message-Id: <d323efe8d6e90a5a53e351f94b5ee1cff9049395.1656664906.git.mchehab@kernel.org>
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

After distro upgrades, the directory names for python may change.
On such case, the previously-created venv will be broken, and
sphinx-build won't run.

Add a logic to report it.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/4] at: https://lore.kernel.org/all/cover.1656664906.git.mchehab@kernel.org/

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

