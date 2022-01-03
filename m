Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AFD482DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiACEvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiACEvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:51:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FDCC061784;
        Sun,  2 Jan 2022 20:51:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so17714577wme.4;
        Sun, 02 Jan 2022 20:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfgtFWBOAntscrZjVoR2yDobZ73EctKONX/lgDmC4tg=;
        b=EpNRJwvN7RiJI9XMrZR8ScHIWWO9ohpBw2wLVhD+LfgUjwxecCVJYC/cpWAUa21WKk
         +B7r7MMMNsz+TRaTviqkHoPTK5i4Cik32b+OCKAr/4ZjPqKH5aQ9a3hDWb5xVGFijop6
         dRi7LXux17kOavlta8gm+oFeBhtVHmD+r2cShEAQzA8719jtAMFwMblj/MIiHZ+8NoUz
         b7gwcMhHVE1uX9XrL6pNVfLXCxsVJBd5ULFSKFGINXg4qR8fIWbzJmMyF/oiMRlFQB8y
         PT7FhXMTfPg7wUPtWmI2pgpUOEY69mCSxkRUl7jrLIPnxKOb1mEotEYgt7Vwf5Ey0mVK
         NY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfgtFWBOAntscrZjVoR2yDobZ73EctKONX/lgDmC4tg=;
        b=bVJF0MyaoIWgds5rTzjjfmRbZq0Ya3cPVtH45+w+0fDhQGh02dBSi1bWcWqUnXFELx
         jzuY3C+xwO3QWx/fviTafUCsykEuQZMvKbJDvxax4BEFLF/6P4rTSgstURKs3kRmhuEz
         PdcjrXH6VMyxvpXCuEFIXzKDs4vvbzaV/l+e2GYZc0VnzIoeAmgTKtdg0dRKdtXT6BEn
         +ze3+MJ32YouFj6YeSSkywcUjx0BYBc4QeNGJChVAiu2X9iIBKTgP5RP+0CrfOXM2n1y
         DgMnZP88gfc1vu8UhDLqMEZ3dC2qHMd6eWqVTxil+ECgC/ajrKSYPwdc1SvYUpYfuXQj
         3eHQ==
X-Gm-Message-State: AOAM531Yg++Af3cXQX9HBvecXKu8FqQ24Lc26PsrVK14iIZ96pWW0AkX
        yYg1Rsh/DvwLn1O6JiE+kW0=
X-Google-Smtp-Source: ABdhPJy0OMqloQUsZWDoSVQW6S/s2M6TWLxx6B3DF/pSCm1V6hz9tIBPLG22lsPqNDY9W2a/xszOgw==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr37470450wmi.79.1641185466519;
        Sun, 02 Jan 2022 20:51:06 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id r7sm32819090wrt.77.2022.01.02.20.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:51:06 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] scripts: kernel-doc: Transform documentation into POD (9/15)
Date:   Mon,  3 Jan 2022 05:50:50 +0100
Message-Id: <20220103045051.506526-4-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045051.506526-1-tomasz.warniello@gmail.com>
References: <20220103045051.506526-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 9) Translate the "Other parameters" subsection of OPTIONS

Notes:
- The -help token is added.
- The entries are sorted alphbetically.

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index fa1270272b3c..76018ca81594 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -83,11 +83,6 @@ sub usage {
     my $message = <<"EOF";
 Usage: $0 [OPTION ...] FILE ...
 
-Other parameters:
-  -v			Verbose output, more warnings and other information.
-  -h			Print this help.
-  -Werror		Treat warnings as errors.
-
 EOF
     print $message;
     exit 1;
@@ -2628,4 +2623,22 @@ Enable output of #define LINENO lines.
 
 =back
 
+=head2 Other parameters:
+
+=over 8
+
+=item -h, -help
+
+Print this help.
+
+=item -v
+
+Verbose output, more warnings and other information.
+
+=item -Werror
+
+Treat warnings as errors.
+
+=back
+
 =cut
-- 
2.30.2

