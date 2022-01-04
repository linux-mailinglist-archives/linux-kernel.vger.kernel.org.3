Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8F483A57
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiADCAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiADCAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:04 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A005C061784;
        Mon,  3 Jan 2022 18:00:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so73119752wrb.0;
        Mon, 03 Jan 2022 18:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZovIGBSj8XwnFs6zndR1wYzs7e7U8XwYk4aDPF6CluU=;
        b=FewZdPJAGatSLciSWmMjUP7X6nVyP54DYajS6s05t7HKRn7xNOb3yiomVj074nD8r2
         jCQFFhfT2pCa7aEzqYq+Txer9PDfQ5LAftQM3NDsbue1Xcdrmkw3V29blmuE9L4ImcEK
         PyKhblrEZUo55bvYbrPxIaJFI93HymqOT6jL7Ap7ae7xTDKnoCfBjLcL+TWay8+iWvRQ
         vd5RDQdoKPZNveyW/dqxNBNswCaloyNE5Ll+wS+QudTrREwNmztn/M+D2gZDb3n/mJNn
         CY2F8s3L0inopwjObVEGBYyKzDJqFhXSBn5Qe13Vun/XE/Gc0wqwRhSm0eKpwgWmHcED
         zwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZovIGBSj8XwnFs6zndR1wYzs7e7U8XwYk4aDPF6CluU=;
        b=MyE5MJ3WhYJowxh+Roryh3o0zzB3eD58qZkrhbLWWRlL5K1pJq364TO0ozkPowMuHK
         vg0JvW0/BXeZ00+RpIGr1t8F8tbMRGebNksvS3Bjc3vyWYGbZcmNnnID/TyUdX45Q1BI
         16BJciRbemVLdPSO3kBeNj821a2gTSFljARR9hU5u6IaBe2cG+oUcfYOnCv5KB2seBA+
         jd67qxBUZfhs73e7hkHrZk0V6WmP7I6cJ4tabnWFubD0qnTznEcVVMEHqtJ5GdZxAEFn
         aEb/zIF3j1z46R7Tk9F6UbiAejVcKVQn3YtilamU3tW5j84fjfRtzPPjJtWuprRCZSxW
         NPag==
X-Gm-Message-State: AOAM530UeA2pURp/yrjn8F+QUFiQ2VQqAbJ7CmmkcvbdrxeNSXTiu7II
        pxuTEov4pGnGHuo6lC959g0=
X-Google-Smtp-Source: ABdhPJwHLZZwvlYx0LZUeK3m2MTTLceOP0FkfDMgrHJIZvut9Nv2fye8dby6wDTCnlIXlbrXJ4OOqQ==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr42105642wrd.105.1641261602827;
        Mon, 03 Jan 2022 18:00:02 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.18.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:02 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/15] scripts: kernel-doc: Translate the DESCRIPTION section
Date:   Tue,  4 Jan 2022 02:59:35 +0100
Message-Id: <20220104015946.529524-5-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notes:
- an article addition
- paragraphing correction

* Transform documentation into POD (4/15)
See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c37fd36860f3..4d0b38c82bfb 100755
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

