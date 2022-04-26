Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1E50F0C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245114AbiDZGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245070AbiDZGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:14:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FEA36140;
        Mon, 25 Apr 2022 23:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3803B61300;
        Tue, 26 Apr 2022 06:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB566C385A0;
        Tue, 26 Apr 2022 06:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650953506;
        bh=4AtGfUOOD7eSeXBmH+CWZwnEA9Plcz+reR06sgMw9ao=;
        h=Date:From:To:Cc:Subject:From;
        b=oqKVBQHa38u+k5V/hkVv1rWq/L+s5zTOQ99ZMyK0aSgRILWjIu1BPkushPZR95NAW
         2fEfCPq7z9hD/rdjXvr1tjfFVoJ7j7/hyd/9XYtmkK8WUVEMkIkl5KobrBbWffuNPe
         nTKSIV/2p+PvNpROLjsJ/phM42xqd8L598FQTN1D+Izo6r9Cu7R8rTXx+bsz210MUy
         fsxGEX9Z4UST37L0MSi0/hz/4ULd3E0uOeBxstgbOuj9JgmUBDMw9qgARUQNDOZoXh
         cK9ejjiS0eKDB1qxI2BHvPh+X3QplyTaWABjB5bZRC7yRcig+DYQBj1HK3P97OeOE4
         TuIzSh7cvgWng==
Date:   Tue, 26 Apr 2022 01:20:43 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] checkpatch: add new alloc functions to alloc with
 multiplies check
Message-ID: <20220426062043.GA19970@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvmalloc() and kvzalloc() functions have now 2-factor multiplication
argument forms kvmalloc_array() and kvcalloc(), correspondingly.

Add alloc-with-multiplies checks for these new functions.

Link: https://github.com/KSPP/linux/issues/187
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 scripts/checkpatch.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 577e02998701..503e8abbb2c1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7033,14 +7033,16 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for k[mz]alloc with multiplies that could be kmalloc_array/kcalloc
+# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
 		if ($perl_version_ok &&
 		    defined $stat &&
-		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
 			my $newfunc = "kmalloc_array";
+			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
 			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
@@ -7057,7 +7059,7 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*(k[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
 				}
 			}
 		}
-- 
2.27.0

