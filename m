Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E4D563F6B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 12:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiGBKLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 06:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiGBKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 06:11:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C571218B0D;
        Sat,  2 Jul 2022 03:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EC85B82ED3;
        Sat,  2 Jul 2022 10:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7355C34114;
        Sat,  2 Jul 2022 10:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656756694;
        bh=zSYkGS2HJ+WHpni5N2jtrIv0c5dT9e/UFu6JXtlIEM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxLYJRdzwkScLW67dCya8z32Ptg9ZRATYeWcVIHmYMyFXf1EW9Ba/sv/9t0T5fmnW
         EL1obzl/d6Vgojfm/W8079lfCmkQGY3pf/yRFfIvYFbYOD5dBZ6hU7yE7xvlGsbpKV
         r/39j8VsPiQNvCa0v6A8+Cz0dtFZr7vgs/+wx/i9VmMupmPTeUVh55PqSKOplXp0hW
         5Ufb57aqwShAFaTAvZkh7TXTXxAP5DN9SDGEKcEy8BR2GQwJwqj37q/j0a9khN0Xof
         lmHjNGiO29w6jwcPYChT4XHQzUrXvWezhOpdav3+sSi6S57Vmaq9XXEd8rDGn9SUNY
         NGmDsWKiDjZqw==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1o7a67-007cMp-OA;
        Sat, 02 Jul 2022 11:11:31 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] scripts: sphinx-pre-install: place a warning for Sphinx >= 3.0
Date:   Sat,  2 Jul 2022 11:11:29 +0100
Message-Id: <085e0ada65c11da9303d07e70c510dc45f21315b.1656756450.git.mchehab@kernel.org>
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

Newer versions of Sphinx have a known bug:
	https://github.com/sphinx-doc/sphinx/pull/8313

Those currently produces 11 false-positive warnings On Sphinx
version 3.1+.

While Sphinx fix is not applied, let's warn adventurers that would
be using Sphinx installed via distro packages.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/5] at: https://lore.kernel.org/all/cover.1656756450.git.mchehab@kernel.org/

 scripts/sphinx-pre-install | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 106d75425d3f..271c4eb1d702 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -902,6 +902,10 @@ sub recommend_sphinx_version($)
 	$need = $old_need;
 	$optional = $old_optional;
 
+	printf "\n    Please note that Sphinx >= 3.0 will currently produce false-positive\n";
+	printf "   warning when the same name is used for more than one type (functions,\n";
+	printf "   structs, enums,...). This is known Sphinx bug. For more details, see:\n";
+	printf "\thttps://github.com/sphinx-doc/sphinx/pull/8313\n";
 }
 
 sub check_needs()
-- 
2.36.1

