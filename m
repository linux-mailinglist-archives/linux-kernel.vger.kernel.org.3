Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7915483DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiFMKBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 06:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbiFMKBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:01:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7CB1CFF2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:01:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so4254491wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXL2Lw4zT1IVwqhSEjXK+P84WMP4plTQkpOVGJlhBIA=;
        b=ZDZIsn9c7ugi0coJdHHAzqz7LC9hiSymPF+sxu4AnAYi0JsbcIyjPab7wa+3S93DPt
         P4HmJ8FtO26nbTUy/2rxxnx3kL4tjwvCRRlKJgfRKjJ52tbJTfn1lIolTBNd4TL9mWhf
         cczSgS5F5FOW4FcKVePQ5xUZokvv7OQV2eGXixMfuPBOne8iTEXf5v+Bv+ZIqPFYNi76
         GqOohJ9wt6MEfAj8UnBoytnTqNwlGjBr2BsEq3a24nReT8E9/Z4GtBVUyVE26t0o9rX/
         TA9CtY8RzHG+nt7N/sBa9tKiuq8AQUHthtlDloZBqQiTIF2vZsOZ/iW7TJxic36z/Qtc
         L3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXL2Lw4zT1IVwqhSEjXK+P84WMP4plTQkpOVGJlhBIA=;
        b=dR90P40cER1TO8c0OnHbUoOWB1ZkDHFmuVIEXs1q/qJzi2wqtb4uV7/uqkx8+er3gy
         9O0765uwj/DfPTzwkR6rzh+P6eV0otJMMts5/HU3D4V5rFNs5YY/Ycuynr6ja5nNkEiK
         eCpMsAc4pfi4d4kppKJdOHnidH2EhSFPt4bRuULU/wCM59y8NPrhAEfaGRPSOIZkUmsx
         vVLyPVfhpTDkWTjZ8C6skrDiZNRYXWjeFBmsFzLbAMz8obAB0D15MkOVsucBHCcfStJ3
         Zl36Dv+/bSbPHaYW5Y2fth8S+ljNwrfEINH456iS2mnSKWE9FMNWQ3n+pKN/qM3pLwSG
         TpiQ==
X-Gm-Message-State: AOAM53363UtiaxCnekbO08EZmwkSQXzWubKI+F83Aw2QC+Gs8O9vmrf3
        wG9R0++cPuQM/AC1P7nUfUY=
X-Google-Smtp-Source: ABdhPJy7//M5Jfa+8jDuILscPRJU1dGZvEQ9blmTTUOALSKYYxivr8+CrYCs22CrgbjLpQRmpWprUA==
X-Received: by 2002:a05:600c:1f0c:b0:39c:600e:6d51 with SMTP id bd12-20020a05600c1f0c00b0039c600e6d51mr13536097wmb.3.1655114468558;
        Mon, 13 Jun 2022 03:01:08 -0700 (PDT)
Received: from lshz10676.. ([2a01:e0a:4cc:a210:2e0:4cff:fe4b:7422])
        by smtp.gmail.com with ESMTPSA id bh4-20020a05600005c400b002103bd9c5acsm8276137wrb.105.2022.06.13.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 03:01:07 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Antonio Borneo <borneo.antonio@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] checkpatch: fix incorrect camelcase detection on numeric constant
Date:   Mon, 13 Jun 2022 12:00:55 +0200
Message-Id: <20220613100055.77821-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <93eb25ab04c2f7436a49f301c2c79a49cb209c44.camel@perches.com>
References: <93eb25ab04c2f7436a49f301c2c79a49cb209c44.camel@perches.com>
MIME-Version: 1.0
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

The code fragment below
	int foo(int *array, int index)
	{
		return array[index & 0xFF];
	}
triggers an incorrect camelcase detection by checking a substring
of the hex constant:
	CHECK: Avoid CamelCase: <xFF>
	#3: FILE: test.c:3:
	+	return array[index & 0xFF];

This is caused by passing the whole string "array[index & 0xFF]"
to the inner loop that iterates over a "$Ident" match.
The numeric constant is not a $Ident as it doesn't start with
[A-Za-z_] and should be excluded from the match.

Similar issue can be detected with other constants like "1uL",
"0xffffU".

Force the match to start at word boundary so the $Ident will be
properly checked starting from its first char and the constants
will be filtered-out.

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
---

Well, already one year has passed from v1, but anyway here is v2.

Joe,
I have modified the commit message, hope it fully matches your
review.

v1 -> v2:
	fix description in commit message
	rebase on v5.19-rc2

---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 503e8abbb2c1..ef4c656a99b3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5720,7 +5720,7 @@ sub process {
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
 #Ignore some three character SI units explicitly, like MiB and KHz
 			    $var !~ /^(?:[a-z_]*?)_?(?:[KMGT]iB|[KMGT]?Hz)(?:_[a-z_]+)?$/) {
-				while ($var =~ m{($Ident)}g) {
+				while ($var =~ m{\b($Ident)}g) {
 					my $word = $1;
 					next if ($word !~ /[A-Z][a-z]|[a-z][A-Z]/);
 					if ($check) {

base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
-- 
2.36.1

