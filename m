Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8F250CD0D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbiDWS7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiDWS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:59:15 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B55929835
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:56:17 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CF5412C1C74;
        Sat, 23 Apr 2022 18:56:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 635702C17CA;
        Sat, 23 Apr 2022 18:56:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650740176; a=rsa-sha256;
        cv=none;
        b=N/wfyJy/Zgxo4I/fH7nkiTcu9s7Mme0bCJmgBszR1zfGqEn3m1pDZ7Uk+FsU4rb/EdD3rZ
        VyRBBl0HE2aAZ2G9dunlSFmGhilX9LrD/oyvTBwAE2Ezlaq3Psg43nJ+1U09n8cHYtuIbT
        gE+0U37CByqBBadoKEC+Qk0gcK72F3Rr0Cjz84ynvp2hihLfJJ6uVzPNqM/ItFESeR5TtI
        WgwLWTxNZ6SVXtVo7tgmgdC57cDUZr1DEcnA4IyjBva4EqM6BdNe7oJPxH0jthGb+joOzM
        RQ1aIzcIA7pKP7ATBfCRw8t6TleIgrfzWGXLK00LMikLwBfrh0vFnYWQD4j4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650740176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=W65KaRAPn4X0/N0KkhSECgSQXT6ViyLCcIqNeKUjBzo=;
        b=xsPlqZxY7pSNPLiL7CZ9NZRyzpuU71a0xWpnoBjqEwTPOG+MMFb5dNayI8r0Uqi6WEgt1d
        NRiFkBqtAOnJzoy1gDGMUhpL9E6OCmmWzquJU6omou5+mXB8rVuo04E6iFtAWcm2oFF+yn
        j1n0vmPC4eGC0nAaapXTCrlDxJTJeOnmp7B+STtYWlAaK5NQiS+KPPd8eJhbXtaSBv6gSM
        wbRBxv8U5cSNHnj+zb16x+nO9fE4BghoR5iBl0jxN9EK6hsNcsOoRI907y2MjFaLoZS7hu
        brI/3Vb5CBazpClQBFh7HLGuvwuYhMoyNf11b5Pj/D0QsQuljb/U6S2h746osg==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-tg62q;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Soft-White: 76c6196c6caa5c60_1650740176668_1261024006
X-MC-Loop-Signature: 1650740176668:1773818257
X-MC-Ingress-Time: 1650740176668
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.255 (trex/6.7.1);
        Sat, 23 Apr 2022 18:56:16 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Km0qM6DHVz1NC;
        Sat, 23 Apr 2022 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650740176;
        bh=W65KaRAPn4X0/N0KkhSECgSQXT6ViyLCcIqNeKUjBzo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=nfhM1Ae4CYb9FvgTxZz1SRGGIgAi3CQkrHUez1kUCTop0GM++L4ziOojZM57klOxr
         sC7cF1OwWPM9xBkBLrA0mwM5y2yylOvpJkH2ng/YjiP83ivO/D3mwZ/n7TTw+mUe3B
         yVkD4Fpko9YCKQlzaoP/bNCrL8zzp+CUQib+EER2eOnhJM/yoAT0sxcoQaK0iqrkGy
         Ag54gHeMIWH7bSnZK1XivyL7CCJhdJfnbKGks1RF5XB3vrDfUWLyhPSW/LnKf1ENTC
         j4izUqIEN/EBqpmIUDqpmRK/w8n79Ru8UFU2pCP7T+jtFG4apigxg7JdaWnooAyZoO
         47tc1hb3CxowQ==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, ian@linux.cowan.aero
Subject: [PATCH] scripts: get_maintainer: add an option to format for command line
Date:   Sat, 23 Apr 2022 14:55:52 -0400
Message-Id: <20220423185552.126453-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the option to return the list of maintainers in the format for
sending via command line, specifically targeted for `git send-email`.
This will add a `--to` tag before the first email and a `--cc` tag for
each following email. The option can be toggled by using the
`--cl-format` flag when calling the get_maintainer script.

The new addition is disabled by default and will only print (even if
enabled) if there are maintainers to return. This will prevent the
script from trying to generate a formatted line without any maintainers
and also allow the user to visually verify that the outputted line contains
the correct maintainers and lists (by verifying the roles).

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 scripts/get_maintainer.pl | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 6bd5221d37b8..fc6844a56c87 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -53,6 +53,7 @@ my $output_section_maxlen = 50;
 my $scm = 0;
 my $tree = 1;
 my $web = 0;
+my $format_for_cl = 0;
 my $subsystem = 0;
 my $status = 0;
 my $letters = "";
@@ -269,6 +270,7 @@ if (!GetOptions(
 		'scm!' => \$scm,
 		'tree!' => \$tree,
 		'web!' => \$web,
+		'cl-format!' => \$format_for_cl,
 		'letters=s' => \$letters,
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
@@ -636,8 +638,13 @@ my %deduplicate_address_hash = ();
 
 my @maintainers = get_maintainers();
 if (@maintainers) {
-    @maintainers = merge_email(@maintainers);
-    output(@maintainers);
+	my @maintainers_merged = merge_email(@maintainers);
+	output(@maintainers_merged);
+
+	if ($format_for_cl) {
+		my @format_for_cl = format_cl(@maintainers);
+		output(@format_for_cl);
+	}
 }
 
 if ($scm) {
@@ -1071,6 +1078,7 @@ Output type options:
   --separator [, ] => separator for multiple entries on 1 line
     using --separator also sets --nomultiline if --separator is not [, ]
   --multiline => print 1 entry per line
+  --cl-format => Include a formatted string for emailing via the command line
 
 Other options:
   --pattern-depth => Number of pattern directory traversals (default: 0 (all))
@@ -2512,6 +2520,23 @@ sub merge_email {
     return @lines;
 }
 
+sub format_cl {
+	my @out;
+	my $first = 1;
+
+	for (@_) {
+		my ($address, $role) = @$_;
+		if ($first) {
+			$first = 0;
+			@out = "--to '$address'";
+		} else {
+			@out = "@out --cc '$address'";
+		}
+	}
+
+	return ('', @out);
+}
+
 sub output {
     my (@parms) = @_;
 
-- 
2.35.1

