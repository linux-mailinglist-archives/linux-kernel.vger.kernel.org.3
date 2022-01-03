Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D999C482DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiACE4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiACE4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:56:03 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD92C061785;
        Sun,  2 Jan 2022 20:56:03 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso17779654wmk.1;
        Sun, 02 Jan 2022 20:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4JRW3Mnb4YcUcFjAFmMBeNVDaH4V5k0erAWsvxtB/Ug=;
        b=Qcn+NddO3vLYdGvnS4kK9itlbNigSapXJPE6RWMHsZBV1ftrl8InNC6oPgCMfRW1UW
         WQdDRmwqrAMRlF9pwFXp6yPf3m4xURj83wQH+BZUdUGCyAA3BV86UsVi+kSsdt5zHRoS
         0dzpNeoX7ZJuB/IORMjZgyVZ3X9c0Jec1PkYKzFKOD2XQijDGy15GEZVpWjTXEImd2wU
         4eZB+tWv892mDeCaysonqmW9dn1cvkFtQS6GrqwTrTFK+Aaw+EiOkueoveSEORCCD0FU
         UiZIVFup4dr3op0rpC0rbVkCMOgrNHHFbz/d1KTCB29LWMN7N/UWbe8Pcq6eQzUGDNFG
         3t9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4JRW3Mnb4YcUcFjAFmMBeNVDaH4V5k0erAWsvxtB/Ug=;
        b=e+6AOsx4dXSHLrm8xhY95G6u/awKUaE7lFXlw0ZQ9CnuuIu/irGILkuyL1XE6KJpc4
         l0qrQSlcQe+4Uw+iiozWP4BRbpRaKG28Z0Pjyn4OFn8qCPRtVsWbzvWsaFE9RXgIKM0h
         ekI6EKlmqRV4DooVsl8IUo55K1AfZPJEA+VZFUTEXGuGwU5aBx/Vj/BkdHsmENvVSpdO
         /GK0wfLoi1+jBl1PNC7fvM+m1iOOTXv2pL7XhkJw2+7fBGLw5XeW5cQZkMkSqU6zIGaB
         IOlW3bg+f+ThjXNQdU56yL6xWNUP36sw1/CsoGU2qK1vscmBJrz0KtbEmlhykl1e/KA8
         +/YQ==
X-Gm-Message-State: AOAM531UwF7hce/1+EpWqrBSMgY5e+Hn3nuBI53FPGWFB8EAs++rhJpP
        5csgJudzIO2xzNDJ7qbh5Nc=
X-Google-Smtp-Source: ABdhPJyzoxFsSwpyG243tx3SwQUXSsJMCZ9pYvRiVir7bp/XiYXm5Qq7T+O/b+Rkk9NwZXFLUQ7GFg==
X-Received: by 2002:a05:600c:1d1c:: with SMTP id l28mr36164935wms.69.1641185761941;
        Sun, 02 Jan 2022 20:56:01 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id d5sm34189032wms.28.2022.01.02.20.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:56:01 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/15] scripts: kernel-doc: Transform documentation into POD (15/15)
Date:   Mon,  3 Jan 2022 05:55:47 +0100
Message-Id: <20220103045547.506783-5-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045547.506783-1-tomasz.warniello@gmail.com>
References: <20220103045547.506783-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 15) Move the TODOs

Earlier I thought I could take "add perldoc documentation" off
of this list. Now I think it also means a self-documentation.
And this is not even started.

I'm putting this block by the end, where it can quietly evolve.

See step 1 for the series details.

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index c588e7a08c77..749a1ea3f866 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -53,10 +53,6 @@ See Documentation/doc-guide/kernel-doc.rst for the documentation comment syntax.
 
 # more perldoc at the end of the file
 
-# Still to do:
-# 	- add perldoc documentation
-# 	- Look more closely at some of the scarier bits :)
-
 ## init lots of data
 
 my $errors = 0;
@@ -2497,6 +2493,11 @@ Treat warnings as errors.
 
 =cut
 
+TODO
+
+- add perldoc documentation
+- Look more closely at some of the scarier bits :)
+
 PRE-GIT MUSEUM
 
 Original formatting preserved for its historical value.
-- 
2.30.2

