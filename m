Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363004E74C9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359301AbiCYOHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359279AbiCYOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F4DD8F4A;
        Fri, 25 Mar 2022 07:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F618B82833;
        Fri, 25 Mar 2022 14:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC19C340E9;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648217118;
        bh=InqS59/swCZqQjPOSQ38Dh01/JCHMdXS9AaJZgOmLnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4e5qt1x2Z36b6bGLw/xt748snta88/BzOap/WiIJHUEK3WrGtWreQOunZTrqrcvz
         Uf6m9caxu4tWMNgeW7AvweqKRJYzKZD/MA7Cd2CH4Gnn+xwq1o0DEBpzXTI51H2Hqn
         tzZejZUUxGrmvtIgbeRNhNJB0yPhUeupaKt82gT6P/rpe5tDY1oD9GWm4M9OifbtpG
         xkHfqM/M0Pwr2MyU35ekzRu1J9mSuby0JARxCEdKrUS+CwN+u6J51Fpnf+2ON+/Hwg
         skKJw9BnvcG3DHzzzvVyP5pvzL2yFJinRYwYeNKsUV4de7Yp8UPnfca0HUjU2fs1+i
         72MLQ+uwaxTmg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nXkZ1-00Axyt-O2; Fri, 25 Mar 2022 15:05:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] scripts/get_feat.pl: allow output the parsed file names
Date:   Fri, 25 Mar 2022 15:05:11 +0100
Message-Id: <a924b46a80d750d808c28a27adffaa5d5a983e5c.1648216561.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648216561.git.mchehab@kernel.org>
References: <cover.1648216561.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such output could be helpful while debugging it, but its main
goal is to tell kernel_feat.py about what files were used
by the script. Thie way, kernel_feat.py can add those as
documentation dependencies.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1648216561.git.mchehab@kernel.org/

 scripts/get_feat.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 457712355676..b7154cf60c1d 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -13,6 +13,7 @@ my $man;
 my $debug;
 my $arch;
 my $feat;
+my $enable_fname;
 
 my $basename = abs_path($0);
 $basename =~ s,/[^/]+$,/,;
@@ -31,6 +32,7 @@ GetOptions(
 	'arch=s' => \$arch,
 	'feat=s' => \$feat,
 	'feature=s' => \$feat,
+	"enable-fname" => \$enable_fname,
 	man => \$man
 ) or pod2usage(2);
 
@@ -95,6 +97,10 @@ sub parse_feat {
 	return if ($file =~ m,($prefix)/arch-support.txt,);
 	return if (!($file =~ m,arch-support.txt$,));
 
+	if ($enable_fname) {
+		printf "#define FILE %s\n", abs_path($file);
+	}
+
 	my $subsys = "";
 	$subsys = $2 if ( m,.*($prefix)/([^/]+).*,);
 
@@ -580,6 +586,11 @@ Output features for a single specific feature.
 Changes the location of the Feature files. By default, it uses
 the Documentation/features directory.
 
+=item B<--enable-fname>
+
+Prints the file name of the feature files. This can be used in order to
+track dependencies during documentation build.
+
 =item B<--debug>
 
 Put the script in verbose mode, useful for debugging. Can be called multiple
-- 
2.35.1

