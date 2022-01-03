Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC98B482DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbiACEqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiACEqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:46:13 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59889C061784;
        Sun,  2 Jan 2022 20:46:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so67647545wrc.5;
        Sun, 02 Jan 2022 20:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0xneqBm3V185M+xDc0wrlUEW+48D5RWRNu3nLnm4e4=;
        b=SpPxdLTXEExwo5AYhiy4jhJPUxuJgmCLhAxAvDxU0WjpF9jTFYTVL5S+4+1gjAe3ee
         YZXdbVCoL9sOSZXTYcKBQoPbqKZmnBa83GsoPVsWG19XZkPw5lvY2Eea7R4ZAu/PFrLQ
         HjmyH7XWjg3lZD9jao7Rk4yCZzik3vsDa/mcRrF+9iRvuh/XiZK/i7QaHKI2M5nZJlqP
         EgZgqMMb1/+WnknQw9H8mNekziTbxC3yLh0ak9sbIolvxkUjGiaxpMRAenYR9TrUkmzU
         KW9DA2q8OoSxrWkepsNqdjRloLtM3Q7lasMaAAj71sqT7aJaZ6etThiAFmFhVDhBjT1y
         FDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0xneqBm3V185M+xDc0wrlUEW+48D5RWRNu3nLnm4e4=;
        b=4Ik5YMlpoh8WpXf9iX1geEjYDSkdO9BmgNOkk5MfNkCN1Eds1nsK7IIdxjeuBF7hjJ
         1RmB7iEKAAFsdiYIwmb0AwPok3yiGPbWbOXf/5jv9FGDGpQ0z5GZLLgPprjZixAyH69w
         A2p96+BtiOblYKxG4fNZjbUceQsIE+Ndh4msjPBxHBnKSs3Q7D/l0Nyxow2HhpTaon3L
         Bhnk8F3wof2N5hWHB5jrLl76sicPkY++jXe4Cat32QuztKE64BiXPc9kxVQvvQmeKcco
         NF+weSxVfWXPut/J2oDOBLi3ocFc8ja4soiBkewistzatV2Wi3GzChTkroykj9Sb4lWs
         rR2w==
X-Gm-Message-State: AOAM531Y++pbDRZknd6/M7y4Ek6PTey3s4rsDSRbXnLS0WVCzFVx9rug
        s8TvGSPDRfimd5VlAvrHgWwlJ9emO2JOHw==
X-Google-Smtp-Source: ABdhPJyUJsa5FYM0/4IEJKyKZpZSj28oteVQReTojhfWMIGDv+lK73cgybE65Uiu6HVnN/JyA5Tm4A==
X-Received: by 2002:a5d:5255:: with SMTP id k21mr38853638wrc.381.1641185171985;
        Sun, 02 Jan 2022 20:46:11 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id o10sm24638860wmq.31.2022.01.02.20.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:46:11 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/15] scripts: kernel-doc: Transform documentation into POD (5/15)
Date:   Mon,  3 Jan 2022 05:43:38 +0100
Message-Id: <20220103044338.506244-5-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103044338.506244-1-tomasz.warniello@gmail.com>
References: <20220103044338.506244-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 5) Translate the "Output format selection" subsection of OPTIONS

Options land at the end of the script, not to clutter the file top.

The default output format is corrected to rst. That's what it is now.

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c58c812c74cb..896c4775102d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -52,6 +52,8 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
 =cut
 
+# more perldoc at the end of the file
+
 # 18/01/2001 - 	Cleanups
 # 		Functions prototyped as foo(void) same as foo()
 # 		Stop eval'ing where we don't need to.
@@ -81,11 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Output format selection (mutually exclusive):
-  -man			Output troff manual page format. This is the default.
-  -rst			Output reStructuredText format.
-  -none			Do not output documentation, only warnings.
-
 Output format selection modifier (affects only ReST output):
 
   -sphinx-version	Use the ReST C domain dialect compatible with an
@@ -2563,3 +2560,27 @@ if ($Werror && $warnings) {
 } else {
     exit($output_mode eq "none" ? 0 : $errors)
 }
+
+__END__
+
+=head1 OPTIONS
+
+=head2 Output format selection (mutually exclusive):
+
+=over 8
+
+=item -man
+
+Output troff manual page format.
+
+=item -rst
+
+Output reStructuredText format. This is the default.
+
+=item -none
+
+Do not output documentation, only warnings.
+
+=back
+
+=cut
-- 
2.30.2

