Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746D24BBF59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiBRSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 13:17:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239092AbiBRSRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 13:17:09 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8A1A387;
        Fri, 18 Feb 2022 10:16:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u1so15904592wrg.11;
        Fri, 18 Feb 2022 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BKVwInCpVkxcu4QibmqUE+njZypLWjFf62FZiJ7RfDY=;
        b=idcfe+gYBoodhi/dxSiO7KNkyG85wSPk/fEcAhTr842WEIMqs266rypz/qc0pY0r7w
         gxvoTs5LE/DJ7w9tMOGgkba5oGTh6brZA4KLOiXKGllY3kC2mX3U0MWhLYBnwY4TkftW
         i2XKR8WC/vJjhZGSh9KYTOzIueFLw5SZZfv433Kkz6Owx+nQPCfrXF2VoHQMm57ZOKRJ
         txYAzMcrkanYrZvUWhFYrBJCQDKhM8gBZSrYNBWCA8ARvfX2jsPDnxayJzrAjFtOaxvf
         gmVmdtS6ILnDiPjHg2vH2XfUWEhBpoAPAzP+XgqCXnrxIHlT8B+Ay44dfhsXggSq1/uN
         7OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKVwInCpVkxcu4QibmqUE+njZypLWjFf62FZiJ7RfDY=;
        b=whF1xSq0/nGLQlhZGr5DX2ZNGnDPc3Njh5lZ+hGkDyBpUvca4+Y1Pfgqft1W24R/28
         +Vnz7EgT+b6wTGyU6TkGPDPkG+lqwQUh5sOymb0NxkQpy7OsOgJOibbFcVRiZrnOpx4i
         wZ1OG8XayOCbXkoA0d0wDfYN4pFHTZEbEv93XsPI4KbfFkm8eSHZqxG3uWqT3r/YjeZz
         nYcHbrB5ghb7gXkdeouGUe8yixWAvty84Lrz3JSZBe8I136jaCRkPk5FpnUM1TUarEaD
         A2QUylpMj1/F+UFrNSoX7tsaFyG8I3B/6DRl+6ywxAZnQWZpTQD27l9fhr/R7Z6eNXzO
         XpEg==
X-Gm-Message-State: AOAM533SyqLG0KPis+9sTztMQGWswMFYveUXhsD1e5HI0x6YdQpXiZWI
        /G0y7NUWlJd90Yzqfb+FFrg=
X-Google-Smtp-Source: ABdhPJwc1hqz5DkZxJCKnWZoWDp85ZWAwbozBuikgb2fXWlk2vNfr0PYY7Kw/ghPB9JEZnrI+7J2xQ==
X-Received: by 2002:a05:6000:c9:b0:1e4:bcc1:f806 with SMTP id q9-20020a05600000c900b001e4bcc1f806mr6966527wrx.372.1645208209067;
        Fri, 18 Feb 2022 10:16:49 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id b2sm20978639wri.35.2022.02.18.10.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:16:48 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] scripts: kernel-doc: Replace the usage function
Date:   Fri, 18 Feb 2022 19:16:26 +0100
Message-Id: <20220218181628.1411551-10-tomasz.warniello@gmail.com>
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

Aim: unified POD, user more satisfied, script better structured

You can see the results with:

$ scripts/kernel-doc -help

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---

This ends the fundamental POD transformation.
---
 scripts/kernel-doc | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 4a26a74318e6..d7ca4877eeda 100755
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

