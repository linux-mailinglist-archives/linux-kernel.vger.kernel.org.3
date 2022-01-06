Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0242485D50
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343903AbiAFAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:41:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40610 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343881AbiAFAlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:41:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 198FDB81E90;
        Thu,  6 Jan 2022 00:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22C0C36AEB;
        Thu,  6 Jan 2022 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641429666;
        bh=CAYCr1/ia/a9kKhbVjt5zd28icmihIiNt3BO7eEzqYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9QB9ud7mSGweIKXBAoiJb72trapzPAVvYhLEyPP8Eld1sRS/SHlMzWcdCKq/9tLp
         TVo4iDPJZv/GyuAEqY1BIIeWX+WHFjBGrVbDoR3ILbmMw1KzyxOltu4ACt8Bpi6zRa
         aiQBDUdIz6RS3UqPYVItPCw5RffBYqYoiNIqFNyl1ufpyOpfMchqI3NqX3aimkVPzb
         JTZ555j5TiHIaTdXCVv+NUd08RIOb/WHK9UiWdECwVzblR/68ZGU9NgwtxabOhplRO
         Fvi1dyAsuWp/uGnoOfqsf0zoxi1efsDKeewkdAcuq6qnMps0HPTaUpe2W8KBGXyicB
         GO4MfcXmhSVAg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1n5Gq0-000NYc-KU; Thu, 06 Jan 2022 01:41:04 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Akira Yokosawa" <akiyks@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scripts: sphinx-pre-install: Fix ctex support on Debian
Date:   Thu,  6 Jan 2022 01:41:02 +0100
Message-Id: <63882425609a2820fac78f5e94620abeb7ed5f6f.1641429634.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
References: <84f90b41-7a18-d83c-8739-1d394175f74a@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the package with ctexhook.sty is different on
Debian/Ubuntu.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 scripts/sphinx-pre-install | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 46aaab414098..f126ecbb0494 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -370,6 +370,9 @@ sub give_debian_hints()
 	);
 
 	if ($pdf) {
+		check_missing_file(["/usr/share/texlive/texmf-dist/tex/latex/ctex/ctexhook.sty"],
+				   "texlive-lang-chinese", 2);
+
 		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
 				   "fonts-dejavu", 2);
 
-- 
2.33.1

