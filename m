Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8944D58754C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbiHBBzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 21:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbiHBByE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 21:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074404AD6D;
        Mon,  1 Aug 2022 18:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7142A61073;
        Tue,  2 Aug 2022 01:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0246CC43470;
        Tue,  2 Aug 2022 01:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659405191;
        bh=Xhoz/HriTf7Mix6x5COkG2so3swkdjDhA9Nt4WJUA3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krwkJpRhHtM2NabndDo2nmtesgum2cCa3tXEqiD6zTuQdmhzAVvLLDGNerS2ZAHS6
         J6BxY7F6v4emtF8I8YMAA/zeClyGdgA7MycJhvf2MVNLr2KugMbktpimbQC08ZxiIN
         21qpB7Wv0Y3zkTagg/nNFgerOTx6MeJ/FrvPtg879YY7OZ3rznuEQRILcAfDxWyByd
         red/0UTTsepsinXY3K3jxssrlX7/scXw39ugz8xilGe+JA8a9zLsxtMUEdMEtK9vaT
         tnC/7apzRkjQ+x/CsT8B5uUK30W19xV9J/4VJoWAJ+hBXmAjFgsHDpo7ASYHqAzbmH
         PNN8xr3iy2IkQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v8 21/31] scripts: checkpatch: enable language-independent checks for Rust
Date:   Tue,  2 Aug 2022 03:50:08 +0200
Message-Id: <20220802015052.10452-22-ojeda@kernel.org>
In-Reply-To: <20220802015052.10452-1-ojeda@kernel.org>
References: <20220802015052.10452-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include Rust in the "source code files" category, so that
the language-independent tests are checked for Rust too,
and teach `checkpatch` about the comment style for Rust files.

This enables the malformed SPDX check, the misplaced SPDX license
tag check, the long line checks, the lines without a newline check
and the embedded filename check.

Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 23799e8013b3..bd0025d77bcf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3615,7 +3615,7 @@ sub process {
 				my $comment = "";
 				if ($realfile =~ /\.(h|s|S)$/) {
 					$comment = '/*';
-				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
+				} elsif ($realfile =~ /\.(c|rs|dts|dtsi)$/) {
 					$comment = '//';
 				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc|yaml)$/) {
 					$comment = '#';
@@ -3663,7 +3663,7 @@ sub process {
 		}
 
 # check we are in a valid source file if not then ignore this hunk
-		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
+		next if ($realfile !~ /\.(h|c|rs|s|S|sh|dtsi|dts)$/);
 
 # check for using SPDX-License-Identifier on the wrong line number
 		if ($realline != $checklicenseline &&
-- 
2.37.1

