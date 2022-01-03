Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C75482DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 05:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiACE4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 23:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiACE4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 23:56:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ADAC061761;
        Sun,  2 Jan 2022 20:56:01 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id a203-20020a1c7fd4000000b003457874263aso20547215wmd.2;
        Sun, 02 Jan 2022 20:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6J0jL/7I6UF0IFFbH8+QUf4x1xxdkaz3zFnVMFHVvU=;
        b=l9+HYV/0b8GR/YD4I+ITEMVdBuxylhXZj6teYY8fQA65W5aSWU5J8pRMPnWoyBQFmJ
         e86BQoFja6J8Wdhk8hr+FCbBLf6I927EW8UPU3oT/jMQPPpxS3SxstvDAghzSZF239Mt
         AeLU6yo1TLcEg6Qdcx8L2ihQXImcSTg6uZwLg1mZTaPPVVPBPxzUT+9hDV2lZfUVlIFP
         6ZJ5xG4WHSKkGGjiJod96VdD/uF/cVVXMixIo0bq29O61FuR9WMP7NN09+9s2toDx76X
         HGfhdO8QKcSpyKX9kMssLmpDoVI2HLQiqYAfObnTXP7jEeJlpRBqXtDYwRYx0plWUGcy
         kXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6J0jL/7I6UF0IFFbH8+QUf4x1xxdkaz3zFnVMFHVvU=;
        b=VJ4SaHMYhjQLfzH1K5nFC3+4zJHzfxXV1G6fdZZiJ02ZVGdUjUgYIBDX9Pt4vnX3Nu
         pJ7d7i6OJuXRIjBlNoP8/hdAPMSKNVW2Fe4XlAdENFKI4FItlMJOhBATM+C0s1XDSpHq
         twu0nYDppKomaDDH/5yCEGe3BnXR4EYnwbWruv3qch/o6NLLUdzrXAyEus9wdttxJV0H
         GVxNClrtzoMuoTYwswjOo6MAfSvsiEGriFX2i3mBWRW93yEG3pH74Gu2vo7daUKO2PR0
         yVg5vSkha0DAa+0iPh6ammDr6Ny9SUEm7HzpijVdHbPju0l37jjtTJ+ABnoydqkqFBF7
         vTyA==
X-Gm-Message-State: AOAM532eCX6S0mkNIEgzGXnJzPmBy6ia2BvX+TPa4SqeeZAflpYPlH6h
        7Z5B74GO88dfrgjkL+VevyA=
X-Google-Smtp-Source: ABdhPJxF02O9y2k1Qh9Qvprw7pfSPLZZmecxtcUvdtlLEiydFyARRZQJAAlie7hiwXxCqgAUsroc9A==
X-Received: by 2002:a1c:740c:: with SMTP id p12mr37215159wmc.140.1641185760295;
        Sun, 02 Jan 2022 20:56:00 -0800 (PST)
Received: from fuji.fritz.box (ip-89-161-76-237.tel.tkb.net.pl. [89.161.76.237])
        by smtp.gmail.com with ESMTPSA id d5sm34189032wms.28.2022.01.02.20.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jan 2022 20:56:00 -0800 (PST)
From:   =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>
To:     corbet@lwn.net
Cc:     =?UTF-8?q?Tomasz=20Warnie=C5=82=C5=82o?= 
        <tomasz.warniello@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] scripts: kernel-doc: Transform documentation into POD (13/15)
Date:   Mon,  3 Jan 2022 05:55:45 +0100
Message-Id: <20220103045547.506783-3-tomasz.warniello@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220103045547.506783-1-tomasz.warniello@gmail.com>
References: <20220103045547.506783-1-tomasz.warniello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Step 13) License cleanup

As stated by Jonathan Corbet in the reply to my version 1, the SPDX line is
enough.

See step 1 for the series details.

(Still not sure about this tag line, so please correct if needed.)

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Tomasz Warniełło <tomasz.warniello@gmail.com>
---
 scripts/kernel-doc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 51e813a84d8b..eb56770b96c5 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -12,9 +12,6 @@ use strict;
 ## 								 ##
 ## #define enhancements by Armin Kuster <akuster@mvista.com>	 ##
 ## Copyright (c) 2000 MontaVista Software, Inc.			 ##
-## 								 ##
-## This software falls under the GNU General Public License.     ##
-## Please read the COPYING file for more information             ##
 
 use Pod::Usage qw/pod2usage/;
 
-- 
2.30.2

