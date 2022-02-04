Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B924A9E41
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 18:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344976AbiBDRrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 12:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377210AbiBDRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:46:58 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADB7C0613FF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:46:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m7so6314306pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=3NUT0n+bilcYFPggFNdZCuDTKMVTtwiLZbBB5rJkswg=;
        b=PI5199P5ZDM5DFBPWJAal8FAkkCncMtASfOWU3UYNZPtWxQvJjJ30BCQqBTOwH8lJO
         2Z+4l0/vWBzZ304RF4dQUqsa57DtpMBxzWk7AkNUSUd22UnEWDqFD5fFLT5c9gSJd5F5
         QiOj8q9vjdhjqQ1C1rOXq60TmY1kxHJwlf9zpTprOPIXntRX277iuNik4zbamvhF7fIc
         5QVlBdGAi4sNepqnfDbfEqaJ1bBCmFWjDwr1W7HFLpVnv5LtBW1IAsyUaPhNjgtv6tAC
         GrQ2xoLisizviFGDDMfOJtPju/7Qda2xxk+18i3GX/Sk43pMVSHz2GEGsIxqJoUnU6v/
         Jndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=3NUT0n+bilcYFPggFNdZCuDTKMVTtwiLZbBB5rJkswg=;
        b=zHLRANsD+rw2NJkT3vL9fJSxbeRLmr6KVvD1jMQjMJnK7Qv8y7BFl2O+5ZhQKk7e40
         4WX9bMsx46YjT1I9YIsmTBQA+453BM6dwxICDw0j3GHKNMXfU7pg3QzGNeVXMZTjaoAF
         qh4gv7rTdKO+I69MYWhS0Y1Jcq0/oYUfsr0dkLRdzcAGVBPvT2RtJahhlvcElECAVIzY
         dd7R5Ei+4pZUN3l/ehXLHqzeemJB5ohK4Z+75DzYpBzZlVIX8oog3v/Idsgy+EyN5Zb9
         4/q9kG2/RiML90Ns4Dm7Z3Hx5fIS6ao7mclBxwDSjg024mk1Pjbjxiv2hsDgD7mQTW9d
         RnNQ==
X-Gm-Message-State: AOAM531vlyMGzxbsdWALjDf6a5Y4XPFIodgmOsZX+WnZ+IqYiAu/e/SA
        AzIopPn9y3AYEB494nk/CnQTfJyv2OG5pA==
X-Google-Smtp-Source: ABdhPJxJ/N/2kfQey34wz9jaLn+ZQentkAAlCBQ4ZOjYZCuHS/ORXHyb0jJ6fB7MtPCvzg45GZ7Dkw==
X-Received: by 2002:a17:90b:1909:: with SMTP id mp9mr84050pjb.84.1643996802504;
        Fri, 04 Feb 2022 09:46:42 -0800 (PST)
Received: from kitty ([12.231.191.170])
        by smtp.gmail.com with ESMTPSA id q9sm13769586pjm.20.2022.02.04.09.46.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 09:46:42 -0800 (PST)
Date:   Fri, 4 Feb 2022 09:47:11 -0800
From:   MZ <10maurycy10@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] fix unnecessary invocation bash in hashbang of scripts/tag.sh
Message-ID: <Yf1mn7RAGkviFi0Y@kitty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Make the /scripts/tag.sh script more portable by removing bash
dependency.

Signed-off-by: Maurycy Zalewski <10maurycy10@gmail.com>

---
 scripts/tags.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 16d475b3e..f066b4e7d 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only
 # Generate tags or cscope files
 # Usage tags.sh <mode>

base-commit: dcb85f85fa6f142aae1fe86f399d4503d49f2b60
--
2.35.1
