Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91F1483A4D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiADCAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiADCAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:00:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB628C061761;
        Mon,  3 Jan 2022 18:00:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v6so11317727wra.8;
        Mon, 03 Jan 2022 18:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sp130HD3zIYsSZ4ZeBgOvYhLOCokJf2r9bj1XbETQp4=;
        b=U6THxrv/6sj0TbR2QAfYWPnEKzRF4ic9BxyhDRkznGShDjaZXQWHdpBWi6jRimep8Q
         T/aSWZZ7n+b6QaxFUbvfJhAO0QswkuM3ZHiMjyP5NeuhGCjoV9vtoxzWtFW47JDAYawM
         DPRNxcNB4dHIA86tikvcUzeogAdWvbjm58g/W7YlrrSOkievmIgIh3kQLRhwbP0ya+90
         5wRMHsLlQSIFnSbleaulfXEIyFyUw1A4MLRyd0Cv6x75XVap8lh/4Zyx6JCfxB0CMvwP
         P1fXsAlXBYZcpy3RN69PV4vfMYQmd2/8SzxuC/IlGlDHl65zrqMD+JAvJBCx9OrGoqEt
         S79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sp130HD3zIYsSZ4ZeBgOvYhLOCokJf2r9bj1XbETQp4=;
        b=EcqXPLrXtWgn1RJaEaspUDC8yk4fBtEpgE5Wd656ohyCwntUsqpxxMNwOcQ5sDgM6h
         gAb82hwKcrgo97sPqawDulDqGDLqOfmu7UHAjw/SnY3NIwX58sBD0/WEXEsq5/mrJJ3g
         lijI28tN2bE7Gm4F+8tPA+Tt/n4qlWzfN2j2VzngwsvJjjTkEOqn751RmTQqzB2wr2ji
         AdDj2IN08yd9pVIpeTGWZ8BTw/DbGjK7T4W2usrdDnG/IOrx205wgeZ1ncccPHnXG/Xq
         EUAhSFnhwaZ06kReL3soiXBuZ3fv4r7JqwiI7rGwGn2yQprGmfI9ieTHqXY3+0o0BWB3
         YnzQ==
X-Gm-Message-State: AOAM531DaCf91BTqkXo97TmpeceojZSMLem1QbjTRizA2K+DlEEUp19n
        i37Xxvi1lMFsnA05XksRr8s=
X-Google-Smtp-Source: ABdhPJw6X9LwRSVl0dOEBmg+dT5ZmEAkP+/NAjAN5yvYeLxNjlBtLfUReerB++wsC8BqqnWSOuLR1g==
X-Received: by 2002:a5d:5348:: with SMTP id t8mr40414912wrv.439.1641261600386;
        Mon, 03 Jan 2022 18:00:00 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id j17sm36422654wrp.68.2022.01.03.17.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 18:00:00 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/15] scripts: kernel-doc: Add the NAME section
Date:   Tue,  4 Jan 2022 02:59:32 +0100
Message-Id: <20220104015946.529524-2-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220104015946.529524-1-tomasz.warniello@gmail.com>
References: <20220104015946.529524-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can see the POD with:

$ perldoc scripts/kernel-doc

* Transform documentation into POD (1/15)
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
-- 
2.30.2

