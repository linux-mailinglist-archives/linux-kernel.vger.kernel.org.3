Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5530483A56
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiADCAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiADCAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:04 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070E9C061761;
        Mon,  3 Jan 2022 18:00:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s1so73039895wra.6;
        Mon, 03 Jan 2022 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U4A1ya3ZBhppFb6gPFviCdTS1d/Uqn0YN2yJAph1WIE=;
        b=OHwgWD7Po00ldCLP+AE+QxysIQb20FxtObobjDDjIKvJMuOjLe8zMejppC/0nwXIo8
         dXLR/KQOxXo1NDUhKWb22DZk3Zgv2TVwpkLIe6lPedE0XV25M/gie/QnTntPwbGv2fU0
         nbPnQ/XbA/d8tW4F7cYUzVSxwi8JqwpM7pcpyE8WiHJbCYu2qyM8PGQphnxmtQzLbAZr
         rmIp0a61utnyp/PirlhYS82E3yTrDUswBo6L8OcUr7AeJCxppA8JJ/CHwfynYZ50Bv5D
         zuK9wLdSZectMyWvi55D8pgwF/asuKZGM1mUtETWZEWhPAnVuKpsCCr1FUUNM87dSv/4
         FCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U4A1ya3ZBhppFb6gPFviCdTS1d/Uqn0YN2yJAph1WIE=;
        b=A3HTkDLDqVa3Z/Exun+X/xPv+ZlTZC90pwgaDKWXI8gZuGaXz8QRPQfWC6WjZBncH0
         KULtBzXmzXv7OWuWqm33VXXQtw+4/b5ay/zlYFpD7atk2pzJTVM8f2XOC+6crEbER2FG
         14DWTV/O1xeLomMwkkDOofQcxmZNxDjRBfYQZTtrZcJV95KHscaaDoUulIgHiCivPE//
         KAPCCw3z+wc6Z7T0lBbtGrqAzzy3FUEtWEC6zDauI2tFZTaB8+kNpHWDLCj1N3sMGBp6
         hr6rvp88BC6ixJgrmHSpB+6X0IIF6QVZazSJzthvthB8WvNg3/sP67kRDKBNzPCcPz7d
         C+FQ==
X-Gm-Message-State: AOAM530jNgFo+dWKJguKvOZbYxeBZI4ZZJXVbO+1dCHD4SN9RnTXX6EL
        LuuE9uS9euo7agpNVNRh8Jw=
X-Google-Smtp-Source: ABdhPJzORNa4c0cguimtZxz/MEcO84ft6UeieEyu0yBpqGP3PEuKalVXRFCkAFnwoo2QqSFPGK2kAA==
X-Received: by 2002:adf:c445:: with SMTP id a5mr22712967wrg.631.1641261601927;
        Mon, 03 Jan 2022 18:00:01 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:01 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/15] scripts: kernel-doc: Relink argument parsing error handling to pod2usage
Date:   Tue,  4 Jan 2022 02:59:34 +0100
Message-Id: <20220104015946.529524-4-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The former usage function is substituted, although not as the -h and -help
parameter handler yet.

* Transform documentation into POD (3/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c8fbf1d3d5aa..c37fd36860f3 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -16,6 +16,8 @@ use strict;
 ## This software falls under the GNU General Public License.     ##
 ## Please read the COPYING file for more information             ##
 
+use Pod::Usage qw/pod2usage/;
+
 =head1 NAME
 
 kernel-doc - Print formatted kernel documentation to stdout
@@ -298,7 +300,13 @@ my $blankline_rst = "\n";
 
 # read arguments
 if ($#ARGV == -1) {
-    usage();
+	pod2usage(
+		-message => "No arguments!\n",
+		-exitval => 1,
+		-verbose => 99,
+		-sections => 'SYNOPSIS',
+		-output => \*STDERR,
+	);
 }
 
 my $kernelversion;
@@ -518,8 +526,14 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
 	    die "Sphinx version should either major.minor or major.minor.patch format\n";
 	}
     } else {
-	# Unknown argument
-        usage();
+			# Unknown argument
+		pod2usage(
+			-message => "Argument unknown!\n",
+			-exitval => 1,
+			-verbose => 99,
+			-sections => 'SYNOPSIS',
+			-output => \*STDERR,
+		);
     }
 }
 
-- 
2.30.2

