Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887444BBF46
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiBRSRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiBRSRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:01 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBDAB32;
        Fri, 18 Feb 2022 10:16:43 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id k41so5760383wms.0;
        Fri, 18 Feb 2022 10:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u266b+q8DWQtLBDTpUPs6zbs4k5v/SuOwsj80SYD5EU=;
        b=ECGPAd/MXong9ZMK6CthGlD/mwjV0pnvoJtpEpiCc62rkwpDSrOpx1GUby6lwJSHVl
         76PVZxx2vYsNlNB31+wvj0UFXYCX5wA84bD1NSqEhOtobs4T8/sPI+wNZsI+B+udLXBq
         nwxUfcEYrI5vI0QC02cb661WZCO5jtIwNnw6wdnWNwclrnH8Wkw8n2xCYWkhzU5+9i8M
         glU7Ia4owIClKHovN/kZcvDEh/SP7nbAYIjLvmJ37YOwGLGNdggqUY+67GLdpd+kZe2f
         XUhJ7xmwqAa3RgraoTLAv1UH07mvcT6IkMfQDb71gZ5Gc7mImOwRABl2aWd96+sZYyd4
         5tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u266b+q8DWQtLBDTpUPs6zbs4k5v/SuOwsj80SYD5EU=;
        b=1ZkykU3VmluatwkhPiED0CP9Cfuj8sHXlSaHEllA/jTA5Ufho+xMk/UH8SdWCzDaJn
         iw8wPyJayF/5u5A33D30U2ikgPJdl7+HQBrfirgjbfApUjKRA+Wutm+AXW6Svz8htqMO
         wB1HdFBMUgNJiXBJE4g4IcuAwzPolZ1Cg0WNREuMXS31ehXwwwDBEtAgRmKJdNoj9BkN
         T9H8jr6VtZdndhzNLJpSP4UlfOW8e+zob2qE+S5OmX98w40gYMACOtmdvsXWrNNqQZ2L
         3g39gp5HKZ7QoAj2qy8/r9fhArGHMOmUEmY4Fe2oDIEjCtfKnGKUKuSm9kCUSnyWUwhR
         WELw==
X-Gm-Message-State: AOAM531bIct8Y5MwRb8N5o0bd/OrfJkegyZe6oSTNVKTffzdm1Ia+D9V
        aC6N5uZX8L3cquYciXOhsQVtNelOvD14vQ==
X-Google-Smtp-Source: ABdhPJza6kIMlScBd7xSsCHIq78rTSq6V+kxh5jEIVdDyw0gZXyjitJN+lsYm31OTdkozWNjaLFkzw==
X-Received: by 2002:a05:600c:3491:b0:37b:d710:f565 with SMTP id a17-20020a05600c349100b0037bd710f565mr11943366wmq.10.1645208202430;
        Fri, 18 Feb 2022 10:16:42 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:42 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] scripts: kernel-doc: Translate the DESCRIPTION section
Date:   Fri, 18 Feb 2022 19:16:20 +0100
Message-Id: <20220218181628.1411551-4-tomasz.warniello@gmail.com>
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

Transition the description section into POD. This is one of the standard
documentation sections. This adjustment makes the section available for
POD and makes it look better.

Notes:
- an article addition
- paragraphing correction

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index e7f7251771bb..e4203f13fa93 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -41,6 +41,15 @@ kernel-doc - Print formatted kernel documentation to stdout
 
 Run `kernel-doc -h` for details.
 
+=head1 DESCRIPTION
+
+Read C language source or header FILEs, extract embedded documentation comments,
+and print formatted documentation to standard output.
+
+The documentation comments are identified by the "/**" opening comment mark.
+
+See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
+
 =cut
 
 # 18/01/2001 - 	Cleanups
@@ -72,12 +81,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Read C language source or header FILEs, extract embedded documentation comments,
-and print formatted documentation to standard output.
-
-The documentation comments are identified by "/**" opening comment mark. See
-Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
-
 Output format selection (mutually exclusive):
   -man			Output troff manual page format. This is the default.
   -rst			Output reStructuredText format.
-- 
2.30.2

