Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3814BBF49
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiBRSRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbiBRSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:01 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233BAB2B;
        Fri, 18 Feb 2022 10:16:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so7000966wml.5;
        Fri, 18 Feb 2022 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=00cL4DnAgoaxV5Rvy8O7BsAp8kCiEs+BRzzZKLubkW4=;
        b=LihUMr/bfgZB1Kg75rq3aoIlBe1TN6lpW6pMJxsfVHUsAP2YCIcd6kcepAN2NmuJ/U
         mbVJhtgzKfT+lRFkulVV9Hbx+rAd7x6J7/TRxEczktniInTLNy/T1dAewsWVXR3TBI9C
         +qz083AKJRMCzZA/dEinS6LhPCWuwFURSODMg9v0CphGfMZ6Qh9mJ+pA5uncGZMzg3QX
         X+1Rw550NPI61O53t0W0SK2d5ftsDwWhiBhBc1Cq7xgM4VkPuZjCpWm/Ei8TpyyeeTzt
         yfQpRRn6goDtgEkDknKhUBijBn3QTgtmmFy/7LUEYgN2hHkoD+J+XuSQtfIStmxDuYY6
         /ZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=00cL4DnAgoaxV5Rvy8O7BsAp8kCiEs+BRzzZKLubkW4=;
        b=RFuXE13FUgrhWLKVddR4vSzLkUof5Oaz04hOmEA7Qm3xdHctqGWfNFqFPPL1HCwt3N
         ifFkNoE+DBzlGkEghvZVXwyAtrCdgbcMk/26iSFjQ+ektEcZucDpQ+mfI0YX1jghfsJi
         TyuJCJGvIg9rMAPjfrJ0764vDV1DIOu9t24El/UTkLgCOvUjhXeP5mawmupqBNEiBrB/
         X0G4ycrWzwwMHzwrZF4pN29LQ3dS2P1DwZ/XIOOl4/cTL9a6eyNEVasVPPjERcRYRfZJ
         BGHCgupOX0pTXMPeYGmBCI3rNrcR9MQmwmfnnllDLmPDicXae8dv3prCMfbcr7jEDTHA
         32Sg==
X-Gm-Message-State: AOAM533VszqBUXLLmw6wK88mE0C/ahEVIlS4jkDLlE58AkK+JPxLl9OI
        xa+crVd1mgac/tlo0jMnqXs=
X-Google-Smtp-Source: ABdhPJxpDXyQWtueLGM+MHmeoIlox+QZOBsVKOayEKds+7gqifmctcLzfmr2JZyDvUFIXU86e1QRkw==
X-Received: by 2002:a05:600c:4e8a:b0:37d:1bcf:de22 with SMTP id f10-20020a05600c4e8a00b0037d1bcfde22mr11421031wmq.195.1645208201448;
        Fri, 18 Feb 2022 10:16:41 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:40 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/11] scripts: kernel-doc: Relink argument parsing error handling to pod2usage
Date:   Fri, 18 Feb 2022 19:16:19 +0100
Message-Id: <20220218181628.1411551-3-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
References: <20220218181628.1411551-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The former usage function is substituted, although not as the -h and -help
parameter handler yet.

Purpose: Use Pod::Usage to handle documentation printing in an integrated
way.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---

If the indentation is still wrong, please state, what you expect exactly.
To me the style in the script is random or eclectic.
---
 scripts/kernel-doc | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c8fbf1d3d5aa..e7f7251771bb 100755
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
+		# Unknown argument
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

