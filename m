Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8D4DB011
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 13:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355913AbiCPMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiCPMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:49:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC392FFF8;
        Wed, 16 Mar 2022 05:48:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w4so2559968edc.7;
        Wed, 16 Mar 2022 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=XygkMwuh2MWsaZ+MkMSHPntfTcHrWBaJgT8VxhIRrmw=;
        b=YVVZeqqYD6xLnTq4lZJk+K2oYMIm+k7Z1fSxloPG9AJXclhPEjY7B/Zjt9QNUDpl/j
         2WdHmvgbKvFGVzCOzkib8tchMvDvVwZ9nvJintoDictU5depVV1XFdDhRPLsNe4fTlfW
         /qGMMrsySxMaQqEVxhJgLW4lChzrcvPVpZr+87wDeCepL3PNl5hY9j8WiwXJVwVNa3J4
         0xidiQRTiCh2LI4syKweFiWTxl9ZKDthrpoSbmEPdsEtiw4tZzQpKxdSvMQV9cGUAS5e
         n3KWjagY91M2w8lhn2ZvZFgQ76Y7iWd+SstwU+FggiGScxUln7gISYEg2BzesePyRkTm
         3fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XygkMwuh2MWsaZ+MkMSHPntfTcHrWBaJgT8VxhIRrmw=;
        b=Ptp1ke1ZczohjAe8rgrkNt1DJLeRs5HRJMuJGY4us1uaXLAuiiKcV4ssQNuUU0ZO2L
         LGHstI16xLs6grSbFMM3jhiaASwnrJL1IH9F/qjSoZ4QazyDQFsPdwmnYb6JGScfG39+
         3nOMSy3jJi3u4m3a31uNya/95UYPjAblOlCC2tZQwi9rE2Ww6wpnyNOaeF1dXVNb67hv
         gSYcExMgA2nD9w6TE1DAcBfPorNL8JrVh1FGiDgL3PRbeeuluS2/ROrhaRbONBXFMs/6
         vmeyQU3MFK8+KvvF78SJ9yPBqrfnGfSNjixzOWjcvh7GHtkUtwOcEWukTiquOew56EAf
         Z+jA==
X-Gm-Message-State: AOAM5332cIncd4f2QelT03jTpBC/1v338ydBxjXNqvRARq7DMBEAkrxi
        AhhB3FdAXIhixJ9m0iRKE08=
X-Google-Smtp-Source: ABdhPJxUCbJI38d9XPAi/0rGzQd0QKenyZzwAhUeJfbNsh0a1ESINhjn30PLIdVhLxk5y5HgOnmQrg==
X-Received: by 2002:aa7:d4d6:0:b0:416:30a2:58c7 with SMTP id t22-20020aa7d4d6000000b0041630a258c7mr29118605edr.271.1647434897994;
        Wed, 16 Mar 2022 05:48:17 -0700 (PDT)
Received: from felia.fritz.box (200116b826783100351493f9f729970f.dip.versatel-1u1.de. [2001:16b8:2678:3100:3514:93f9:f729:970f])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b006d582121f99sm848189ejf.36.2022.03.16.05.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 05:48:17 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove the obsolete file entry for staging in ANDROID DRIVERS
Date:   Wed, 16 Mar 2022 13:48:02 +0100
Message-Id: <20220316124802.372-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 721412ed3d81 ("staging: remove ashmem") removes the last android
driver from staging, but misses to adjust MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Remove the obsolete file entry in ANDROID DRIVERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Greg, please pick this minor clean-up patch for your staging-next tree on
top of the commit above.

 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 963d7001f2ce..192e99b6b8f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1325,7 +1325,6 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
 F:	drivers/android/
-F:	drivers/staging/android/
 
 ANDROID GOLDFISH PIC DRIVER
 M:	Miodrag Dinic <miodrag.dinic@mips.com>
-- 
2.17.1

