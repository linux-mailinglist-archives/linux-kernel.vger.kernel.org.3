Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF60F482DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiACEp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiACEp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:45:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4910C061761;
        Sun,  2 Jan 2022 20:45:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id e5so67646609wrc.5;
        Sun, 02 Jan 2022 20:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIcAdCifadUP8IyMnc7xgV1huS5h4wPFDg9JyzZcoRc=;
        b=NKxydIQadbWAyXgILy76j1j+EV2q4YknXiqwJJ5Es/yQULcKzDXugXt1yNl3/V4M23
         6EXE8meHyeixsQxhnjd7mLMbhQpCzqohioT5W+oTMKpozDyIKgDgOzaM6onc7MeFvUuK
         bqVWsG5gdjIokgQn3gdT9v+QbmOQBslC39ArhlpL/3ILihQVol2EwsKbmOFJV9FSTlAD
         U6MRBRHziKWZ928sBQvk8ULOgz5pvkwTWeeP/OmACxCOzbAf5xiGzDuhkXvtFSCdpD4b
         fRNwdckTWhh8XlCtNYXRnaPRXElsh5swVhrLJNErUFpg20cYeYfJdo5jyyTrr/esqHe6
         vEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIcAdCifadUP8IyMnc7xgV1huS5h4wPFDg9JyzZcoRc=;
        b=gdYOKuKiceLIA//llJNZ9/oXBodzf4Jg2+wQgLwJCPY4FkQTUbi9Cx8zw/Hl10pt7m
         HB891/feRcs6vqJrA1OQwVyxdp77vqHTizAzFWehgkYhwc2xHnyam8zu47qAY/E1UUZR
         e/j1mIa6YqGhFznvNwD8e83TYNG2QWT3aAjU/J88Wil0SlXl1fxmtRteyrKIhRABeRJI
         vdvyhuRt9tiePkMLMlsC3608wxHVqMOPGljagXlyuPsxuQrHDD7Qwm9k6kAuOaqcpUQm
         KC79cjCxathiRfJIonDU1snqDt9LCMG2+3+lQplKqCgVj2N/lgrdmDA92hDs5CFk64HZ
         ulUA==
X-Gm-Message-State: AOAM5327LG+VXY0ZVZF56NJgKMViZ+tf4PrH/BE8ebDVeUmI6f2rvWzi
        jm6bTNY/I1aaMlczz/vUw4U=
X-Google-Smtp-Source: ABdhPJy+j6S6imiaHGftIiLA2NLP4mVoDRFZ0U6XTZNeUg44UeSfmbkW2CbJ0pyFb6sRRnAzZ3YPfw==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr37343202wrj.680.1641185154318;
        Sun, 02 Jan 2022 20:45:54 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id o10sm24638860wmq.31.2022.01.02.20.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:45:54 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/15] scripts: kernel-doc: Transform documentation into POD (1/15)
Date:   Mon,  3 Jan 2022 05:43:34 +0100
Message-Id: <20220103044338.506244-1-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 1) Add the NAME section

You can see the POD with:

$ perldoc scripts/kernel-doc

= Series explanation =

This series transforms the free-form general comments - mainly the usage
instructions and the meta information - into the standard Perl
documentation format. Some of the original text is reduced out.

The transformation includes language, paragraphing and editorial
corrections.

The only change in the script execution flow is the replacement of the
'usage' function with the native core Perl 'pod2usage'.

The TODO suggestion to write POD found in the script is ancient, thus
I can't address its author with a "Suggested-by" tag.

The process consists of 15 steps.

1) Add the NAME section
2) Add the SYNOPSIS section
3) Relink argument parsing error handling to pod2usage

The following subseries is disfunctional before its last part.

4) Translate the DESCRIPTION section
5) Translate the "Output format selection" subsection of OPTIONS
6) Translate the "Output format selection modifier" subsection of OPTIONS
7) Translate the "Output selection" subsection of OPTIONS
8) Translate the "Output selection modifiers" subsection of OPTIONS
9) Translate the "Other parameters" subsection of OPTIONS
10) Replace the usage function

Here the DESCRIPTION and OPTIONS subseries is finished. The -h and -help
parameters are handled by POD now.

11) Remove the "format of comments" comment block
12) Archive the pre-git museum
13) License cleanup
14) Refresh the copyright lines
15) Move the TODOs

Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3106b7536b89..46d3e779bf5d 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -16,6 +16,12 @@ use strict;
 ## This software falls under the GNU General Public License.     ##
 ## Please read the COPYING file for more information             ##
 
+=head1 NAME
+
+kernel-doc - Print formatted kernel documentation to stdout
+
+=cut
+
 # 18/01/2001 - 	Cleanups
 # 		Functions prototyped as foo(void) same as foo()
 # 		Stop eval'ing where we don't need to.

base-commit: 2a987e65025e2b79c6d453b78cb5985ac6e5eb26
-- 
2.30.2

