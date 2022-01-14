Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3548E1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbiANAv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238556AbiANAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:51:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476DDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:51:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i65so1365169pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=iBLRxf0v67W9YPVtNbbF8mmQWl4IgMVhEpvlsnbP9vA=;
        b=ZSBCFxx5Iep7Qdk5i2wyrQdCkVxfdqlqwuBcQRkmlcQmM07qGEp8HX1XPJ7/WeH5bG
         hfVmLYDZdx32XlUEfFguMvs2HCaMqOUJIY+M8s+sutm5xvCa/QAO1gE4RFriKAmW/JIn
         8JmcFdwyNOaY82Yr7hktF3H8Bts8SQbJ2sb5kiUfH59AerYHjOpwtpp6p1q4vtZ1HDNW
         5SJ9cfQxU6QjBoudenTfWU04UBu9ouermy6QxCE53J2d3LzhRVNUk0HYsLeRpum56PU5
         C96ml1tbedkPjgI4qZLdANcV0b7hNnTeilKbbJMJeL3RbP5RXfyTCAIl4wKoGBBsGy7a
         0Ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iBLRxf0v67W9YPVtNbbF8mmQWl4IgMVhEpvlsnbP9vA=;
        b=Iyca8IpwdMf2aWDZR+B97v/PtOV6qbBmyJtkqeeQWnyVm6uY2rx75Nnqv7PQkNYs9v
         bNemY/4iBpLIG7J3W6Gp3gWCkxmn62DvEViEZAD1+2nKR8S34TqYg+czcF1ygjeJ1Dik
         4BpZpH7IvfOdb01yJiJqdm8jKP/3WkkQ12QGVpCebbaxhoTmMqHSnBA987/7Mq9fzSlK
         hZPoVvAMVTbNqUuUwhf9ePLPdKw3zBOcg+ydx4xDlTxjbFx7irg5/Gnt/kVoNLJV35oU
         TjuY4Fkkpouj53tLHGJaDWO9vXl7oY3UaSyr/djPJa2AjoLnXYNw4153suwumpH2iBB3
         0cYQ==
X-Gm-Message-State: AOAM531bH9ey9GLjHo/hHat3M1N/ajjgwqftIRojAzm7hE8bKf254vBb
        0qzSzGY5EIL8cMGqJul3gjM=
X-Google-Smtp-Source: ABdhPJy0oD5IKX3vekWb+epr3v9VkvMpSZNrXmumP9vPI/qhAbVetSyI/42ODpyadnNoYqTFrhQsdQ==
X-Received: by 2002:a65:6241:: with SMTP id q1mr6010973pgv.98.1642121516521;
        Thu, 13 Jan 2022 16:51:56 -0800 (PST)
Received: from google.com ([2620:15c:202:201:935c:b3a0:3d11:6f75])
        by smtp.gmail.com with ESMTPSA id oc3sm3931495pjb.20.2022.01.13.16.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:51:55 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:51:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] module: fix signature check failures when using in-kernel
 decompression
Message-ID: <YeDJKNTYVu/Fe9VS@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new flag MODULE_INIT_COMPRESSED_FILE unintentionally trips check in
module_sig_check(). The check was supposed to catch case when version
info or magic was removed from a signed module, making signature
invalid, but it was coded too broadly and was catching this new flag as
well.

Change the check to only test the 2 particular flags affecting signature
validity.

Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 kernel/module.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index 201398d58079..24dab046e16c 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2883,12 +2883,13 @@ static int module_sig_check(struct load_info *info, int flags)
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	const char *reason;
 	const void *mod = info->hdr;
-
+	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
+				       MODULE_INIT_IGNORE_VERMAGIC);
 	/*
-	 * Require flags == 0, as a module with version information
-	 * removed is no longer the module that was signed
+	 * Do not allow mangled modules as a module with version information
+	 * removed is no longer the module that was signed.
 	 */
-	if (flags == 0 &&
+	if (!mangled_module &&
 	    info->len > markerlen &&
 	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
 		/* We truncate the module to discard the signature */
-- 
2.34.1.703.g22d0c6ccf7-goog


-- 
Dmitry
