Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC885483A63
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiADCA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiADCAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:09 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685B4C061761;
        Mon,  3 Jan 2022 18:00:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d9so73120177wrb.0;
        Mon, 03 Jan 2022 18:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cBImQisBKAHtvlDQJfX6bglH26IaJinQfqeXp5MNMQ=;
        b=HXxbijwEe2V6r9bC1wui/7cTUPhTP5bk3OVouq3z0HL1USs0CZipSIFWxiWt+B7G3g
         yMTkoZax913QcW1DzdCXHUBcY8ngL0DNaXlq95T5hJ3qjS7TJu0QqytLeUAYWgTbRPV9
         Sgxf6ORObuKil/4TkNfdk0XUdKBAcwqsNCbOF7IOqocl0fkdguxyVbCQFfXtlys/smG3
         0w0jFKhqCrFLerQUSWQpd4uRetQsJ13lBjEJep+PCfgxQDgI/RJ1/Z38eqxNYJ5eviga
         URUejOQIMRc8UIf5K6967tx06d7A43/w49IYZ4N3jLj5u2zmzwSjvaByBlG5cnWohJLW
         ijfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cBImQisBKAHtvlDQJfX6bglH26IaJinQfqeXp5MNMQ=;
        b=lN+hOvWUvgqQfix+FGVNo/ZrYVekhEOUnPZdhDce/UwS4w0gBm6yzyYcDtz7Flxr5B
         Iiyh5xnkZS3c6Qod+M5e/9uOJpw5qw+lg2fCzO0qQ4/Wsj/nSVymjVMMcvY3xIOk5pc6
         mte5kRJ8kRobeN4b8eWSz3jKQbV9AjBpfseGK6zYd1dym7uVeXDrBXGpFLu+EuyAInve
         IpyEY4CnYHWCVV3PchBNs+yjz3aCfUkkzRAuZBv3jXLoT+BOqW3JwdbmGoFf8zJ+glzt
         laWjWRwwziSehw0CV92MOlRXg1trlcMDcAnh61EnZDtPXQp4YBYdRWvO+9JK5S2IKQtV
         Z7Yw==
X-Gm-Message-State: AOAM531XXqZARw0Zz7iWw17mjg7S3Ni6w3VrvzLZILUUUfI+lc1PRLg5
        agvRvbFRFvEyRQ5q0BtlUyeMY4I3wqxOsA==
X-Google-Smtp-Source: ABdhPJyLPnjP8W9Fe/hso4WijGNNx3lpV+7Pr+G4Dlm6HhesJTNZn/ox6KZXvchj1ISKhK0eAZb6JA==
X-Received: by 2002:a5d:64e1:: with SMTP id g1mr40578730wri.403.1641261608048;
        Mon, 03 Jan 2022 18:00:08 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:07 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] scripts: kernel-doc: Replace the usage function
Date:   Tue,  4 Jan 2022 02:59:41 +0100
Message-Id: <20220104015946.529524-11-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ends the fundamental POD transformation.

You can see the results with:

$ scripts/kernel-doc -help

* Transform documentation into POD (10/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 33e7923683a0..b4852c2ba243 100755
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
+		pod2usage(-exitval => 0, -verbose => 2);
     } elsif ($cmd eq 'no-doc-sections') {
 	    $no_doc_sections = 1;
     } elsif ($cmd eq 'enable-lineno') {
-- 
2.30.2

