Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A97F482DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbiACEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbiACEvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:51:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D7C061761;
        Sun,  2 Jan 2022 20:51:08 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j140-20020a1c2392000000b003399ae48f58so20535783wmj.5;
        Sun, 02 Jan 2022 20:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fUpNFk7n1xC8kYBnaIN6s2IV4QPkRGqkGmgZxWFNjR0=;
        b=D4GN4gnEZX2f5537knsjoNwcViWodA0o3hg/jO9fmfhscAUjpfPpZNoJWJgIcRutDa
         oSOiKguaPOGtut116jzjZhkcZ4rGGwlRNWP809WayOv0MVnRbAYp9b14fNKZyZyNt9jN
         pQlDzcOxCP28DFTkLUlNioQLdmwN89KR9MzG3acygiPQC6o6lwJcCNDFFOw8xR7NeFrK
         +Z+bJgGwaP/klx/cNoEi/wNhKcSrDvhvBQZrSTplgzaCCzWHsaWo/DWGWY5I/ra21d9P
         5MlgFOi/tnHlK37VcKG11lXvFpWGRpDByNR6BXYI+RmkkNsgHiXazrTrnFNj5vBVAk5d
         Q1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fUpNFk7n1xC8kYBnaIN6s2IV4QPkRGqkGmgZxWFNjR0=;
        b=qBK6HQEM54r7w4vNoWfZ9eD6HE6jlKI8UglES+y98Hm+TiB6MwmSn40HU2eNOCpva9
         NdqYdmSftEjC7C7oWi8wZmfJLyXNjKXTiZcO9zSLoKs1ATjixAom535luXdTw7/JhpeC
         rWHOplNmUsAhKenc9a63XYJDuwHRJZL2IYN44PD4rmmpZK1lCphDWflQjvWdD/VJ5Mki
         JvqlISdxLAmI9VvQKR1gWbdHsQdbqmw9jNX4wn3Hik6mU2gT0HVsAFThV8qKZzU6/SVi
         zto5FeLNEkmMNsRJCPddoamcANpDzUfDz23eeUfPoMLAngkLOxRszPqQ9hOW2qg9b8yx
         5dJw==
X-Gm-Message-State: AOAM531HNT1YNnaCVi0ubCS1KNqdn7tJUtxQPK46zYic9mN1RXw9oIjY
        TwO1ts38RJ20KFKPg+5Nq7wWU5mEphZ4Ww==
X-Google-Smtp-Source: ABdhPJwSG+E61BiWFkr+QkKy3SzHk8gc2FI96abNeDdfT86kfc8fwekaj6dGCSYonr2/fN6z5p7n1Q==
X-Received: by 2002:a05:600c:4e86:: with SMTP id f6mr37010528wmq.144.1641185467256;
        Sun, 02 Jan 2022 20:51:07 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id r7sm32819090wrt.77.2022.01.02.20.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:51:06 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/15] scripts: kernel-doc: Transform documentation into POD (10/15)
Date:   Mon,  3 Jan 2022 05:50:51 +0100
Message-Id: <20220103045051.506526-5-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045051.506526-1-tomasz.warniello@gmail.com>
References: <20220103045051.506526-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 10) Replace the usage function

This ends the fundamental POD transformation.

You can see the results with:

$ scripts/kernel-doc -help

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 76018ca81594..bf0c5bb7b026 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -79,15 +79,6 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 # 25/07/2012 - Added support for HTML5
 # -- Dan Luedtke <mail@danrl.de>
 
-sub usage {
-    my $message = <<"EOF";
-Usage: $0 [OPTION ...] FILE ...
-
-EOF
-    print $message;
-    exit 1;
-}
-
 #
 # format of comments.
 # In the following table, (...)? signifies optional structure.
@@ -468,7 +459,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
     } elsif ($cmd eq "Werror") {
 	$Werror = 1;
     } elsif (($cmd eq "h") || ($cmd eq "help")) {
-	usage();
+			pod2usage(-exitval => 0, -verbose => 2);
     } elsif ($cmd eq 'no-doc-sections') {
 	    $no_doc_sections = 1;
     } elsif ($cmd eq 'enable-lineno') {
-- 
2.30.2

