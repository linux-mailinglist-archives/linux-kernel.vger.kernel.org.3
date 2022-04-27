Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91883512223
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiD0TJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiD0TJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:09:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE2C69CF9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:57:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i19so5184461eja.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPKi8PgGQaBnzyHIXBRWRUTqjsQoxp2zAwkTWoaTAuc=;
        b=GZs2Ap7YssDTDUzMi9Tmwfvp52es0XpGnz/uyDvPKjQsmCEEr/oCIDLLx+CfQbWjhx
         PESpWsgxHMdYHi5A3U6qfQPYCQOpfxgBAiljS4p0GYzJDLAg5tnlzQq49HNBIIlbfcho
         0sEXEDb0Kq7bJc4Ryi4nh6VifDGAm7PQebMPlX9c49SC4O0g7QtnzERU0tsyY7K4KmyR
         u90eageJ8I8XauO5IW5a6CpngCi+kU0hYYHDkFd0bQ+n3ApcZUBdtLIk8uI9hAhTdCv9
         WqzXupQfiMIqaz8lq8p288+7itiSFKawnRin5Tb1s9Z7V+9q/ih/L3YO0HZ2PWVk9SML
         n9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPKi8PgGQaBnzyHIXBRWRUTqjsQoxp2zAwkTWoaTAuc=;
        b=P726l8W28WyYniYszsme0MfoKBdIvOOPcnNuP9Q3yfjNfbhG8Vq36YyTUq66pdDta2
         0Mmopx9RWJpyIUeZBw2uSkXlJar/tKKn6g2+bHMEqk8/vr/FeSVODC2a4PsqtU+9Ekvq
         MyXrd2HzEPv+2EJqpWMygl5Of/CKEHHDJ7+QN1xN8qBEXdrluoodbetArcGNkgfW+KSm
         DDHIXmvhg1VYnb60koV4NLmbFf3oT75hNIl4GCoSjJCtWMzPzirnJWF4hY2dVl9+rUBw
         +QQMYIVHIrhA0vq6g4jdMF8WnBVJsp+AR/GxuYTLqioKwGvMeJNxS+cJWO/vMB4JtnoT
         cx3Q==
X-Gm-Message-State: AOAM533EKGQSoKkZ+ORN39iaHU7UZkZFCfpmuMBIuDPSCvsTVK/ZGY1z
        gTp0iaRLLs0dES74d65nnn50Ag==
X-Google-Smtp-Source: ABdhPJzfkdw3+HaFRXiY3ueNL3+pwS9ImdeHsOucq24QuQGFw4LxzzUQh62Tb0G3YV6tOTE5oga+mQ==
X-Received: by 2002:a17:906:ece3:b0:6f3:da10:138a with SMTP id qt3-20020a170906ece300b006f3da10138amr266656ejb.438.1651085856857;
        Wed, 27 Apr 2022 11:57:36 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906378a00b006f3cd3e7b94sm1348563ejc.213.2022.04.27.11.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:57:36 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Documentation/process: use scripts/get_maintainer.pl on patches
Date:   Wed, 27 Apr 2022 20:56:45 +0200
Message-Id: <20220427185645.677039-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain that, when collecting list of people to Cc the patch,
scripts/get_maintainer.pl should be used on patches, not on the
directories.  The behavior is quite different, because with "-f" on
a directory, the maintainers of individual files will not be shown.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

It seems using the script on patches is not obvious and it already
caused some misunderstandings.
---
 Documentation/doc-guide/contributing.rst     | 5 +++--
 Documentation/process/3.Early-stage.rst      | 9 +++++----
 Documentation/process/submitting-patches.rst | 7 ++++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc-guide/contributing.rst
index 207fd93d7c80..d4793826ad9a 100644
--- a/Documentation/doc-guide/contributing.rst
+++ b/Documentation/doc-guide/contributing.rst
@@ -79,8 +79,9 @@ simplistic idea of what C comment blocks look like.  This problem had been
 present since that comment was added in 2016 — a full four years.  Fixing
 it was a matter of adding the missing asterisks.  A quick look at the
 history for that file showed what the normal format for subject lines is,
-and ``scripts/get_maintainer.pl`` told me who should receive it.  The
-resulting patch looked like this::
+and ``scripts/get_maintainer.pl`` told me who should receive it (pass paths to
+your patches as arguments to scripts/get_maintainer.pl).  The resulting patch
+looked like this::
 
   [PATCH] PM / devfreq: Fix two malformed kerneldoc comments
 
diff --git a/Documentation/process/3.Early-stage.rst b/Documentation/process/3.Early-stage.rst
index 6bfd60d77d1a..894a920041c6 100644
--- a/Documentation/process/3.Early-stage.rst
+++ b/Documentation/process/3.Early-stage.rst
@@ -154,10 +154,11 @@ that the kernel developers have added a script to ease the process:
 This script will return the current maintainer(s) for a given file or
 directory when given the "-f" option.  If passed a patch on the
 command line, it will list the maintainers who should probably receive
-copies of the patch.  There are a number of options regulating how hard
-get_maintainer.pl will search for maintainers; please be careful about
-using the more aggressive options as you may end up including developers
-who have no real interest in the code you are modifying.
+copies of the patch.  This is the preferred way (unlike "-f" option) to get the
+list of people to Cc for your patches.  There are a number of options
+regulating how hard get_maintainer.pl will search for maintainers; please be
+careful about using the more aggressive options as you may end up including
+developers who have no real interest in the code you are modifying.
 
 If all else fails, talking to Andrew Morton can be an effective way to
 track down a maintainer for a specific piece of code.
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 9bb4e8c0f635..1708b66c4672 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -227,9 +227,10 @@ Select the recipients for your patch
 You should always copy the appropriate subsystem maintainer(s) on any patch
 to code that they maintain; look through the MAINTAINERS file and the
 source code revision history to see who those maintainers are.  The
-script scripts/get_maintainer.pl can be very useful at this step.  If you
-cannot find a maintainer for the subsystem you are working on, Andrew
-Morton (akpm@linux-foundation.org) serves as a maintainer of last resort.
+script scripts/get_maintainer.pl can be very useful at this step (pass paths to
+your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
+maintainer for the subsystem you are working on, Andrew Morton
+(akpm@linux-foundation.org) serves as a maintainer of last resort.
 
 You should also normally choose at least one mailing list to receive a copy
 of your patch set.  linux-kernel@vger.kernel.org should be used by default
-- 
2.32.0

