Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB245482DCC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiACEqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiACEqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:46:09 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7FC061761;
        Sun,  2 Jan 2022 20:46:09 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id j18so67653504wrd.2;
        Sun, 02 Jan 2022 20:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EsMsU/jL/vHyn8ThdIZ6mN2Ke+GZWl6YPgPi/uJEtEI=;
        b=QKJl60vtfYZ0JNvtuKZRwJVGnVHsWVIIrYdq5vzHhfG4GJQEY8p4yTouW70kr34mNN
         v4Ug1A7SPRhrU5NveuVOdEqS3c9lQfgZh1sjBg9DbfwZv7nCluiwZzoa+9WR9SMr5yKt
         bMS86uug737flbY8gG3fsqvw66r0b+eua+JmRUqBd12mRcNklGrq5YdZHOqdz3Z+/6tx
         aWvihuORIsbIZOvQx7Gbe2eykVXCaAnQYuKnVNCt9Q8GCVVDdlebk8blTuI5jN+c+x4k
         N7tYQ8lk9oukhqa/v9pXufX7+HYPvZnv8N8EL9qwmvREfemEv0y1LNMTkA5h6r0+/I0l
         zQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsMsU/jL/vHyn8ThdIZ6mN2Ke+GZWl6YPgPi/uJEtEI=;
        b=bl8syPlc57IXFxkYT8mywn42OVsKxExttEyh9DnOc4f9cZXnY0j6tyS0KIybWiSsWo
         DVoVrDJBU8su9YIvKcoGh68MXfJntET3sYcvaloE8/1HpFtEqhRUHuWiLV1rHFEaMTiH
         x3WB3W9zInqfy9S7z7QRtZsuYZ+TY4cQgwczN08lqypmZpdAx4T8utLVE0eEkvuTwJWs
         kTGZLzbfAXcwz1S4ekg7Mj3qrmEwjAKAzRbjB+l5CF8W/hLWClUukaomoQEy2F83b7ag
         Wdcsim/rkULIaezzUToSBo0L3oJP45Ey9YZLig7UZ1mN/6IzDN0zhRhvW2RAKiv+ABcT
         MK/w==
X-Gm-Message-State: AOAM533O8TpBTN2zq5YmbesR+1d7gu0ifB71FZ2TKB4bRgAXTWFm8chJ
        HAjFccszQ1RJeWnyNnAwb/pWcRQlc5RWtw==
X-Google-Smtp-Source: ABdhPJwsNSJ+BfKack+cHQbhbycK+O7gDYWhaSm9ShY5dLS8BDHgSwu4ouNcp6LAQtPk6ZqVSBk9lg==
X-Received: by 2002:adf:f904:: with SMTP id b4mr18455186wrr.457.1641185167908;
        Sun, 02 Jan 2022 20:46:07 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id o10sm24638860wmq.31.2022.01.02.20.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:46:07 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/15] scripts: kernel-doc: Transform documentation into POD (3/15)
Date:   Mon,  3 Jan 2022 05:43:36 +0100
Message-Id: <20220103044338.506244-3-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103044338.506244-1-tomasz.warniello@gmail.com>
References: <20220103044338.506244-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 3) Relink argument parsing error handling to pod2usage

The former usage function is substituted, although not as the -h and -help
parameter handler yet.

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c8fbf1d3d5aa..9be526073b75 100755
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
+			pod2usage(
+				-message => "Argument unknown!\n",
+				-exitval => 1,
+				-verbose => 99,
+				-sections => 'SYNOPSIS',
+				-output => \*STDERR,
+			);
     }
 }
 
-- 
2.30.2

