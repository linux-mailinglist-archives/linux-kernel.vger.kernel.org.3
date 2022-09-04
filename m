Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003425AC7C6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiIDVq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbiIDVpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:45:25 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144030F65
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:43:05 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id n202so5657655iod.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=gc3CEPtxYjk29+Wh9qd9Uhba+Qcycq/xTeA557V/yJA=;
        b=pjBlhL+ATdSasCB8eiAlDBtg6VQZe3cAxxbzs1dn4fhsTGll1ZJKZVPkMR2mAe6vQD
         +1ZUleBqb9yFLUkLQLuRp4esV7jUMm+9nkPY8LhEgMfb+aZzAVC2mkPJrqbpGbEQhkRo
         beZ5FNifB5rdJxWg7R8D5bcVcnK7tDty4bpm3uL/kbFe0gGnoJy6MFouLJWvzkGtbSFw
         KbDqjScDXUcFQ9R/5Be0XLDU0graPMWJvrt9XQvpuQIZmHQO8jVZA6GPpMTQquJWxpzE
         uymD2AvAzBcc+9sFlbROngihXuT8MzFti5OGgYB/TVQyB52NFye/DNbIZ9Wq82jlh8uk
         kuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gc3CEPtxYjk29+Wh9qd9Uhba+Qcycq/xTeA557V/yJA=;
        b=GqbEPPa37T4YeyUTp4aAgPldX7heCECALg4/cr84gDsu4ldpNjH2cBCue9QRBuc36Q
         KUG5PL+lDRhWO15vxVaoRpRpLKMTb/fLOabbkdVgrUj40BkNfJiamCQM0xXtR0b9XfAu
         qdGr4WPcsQIsMMH7Wv6sp8/yjEn0CAQjTqJIVAH3Y1+RPoCBzea9Lu0YyOH3FrOwqt2n
         m+PacxqndtesHASfCr88QALvXMgRcm+ZeNxxjUzAX8eLL0EiOpaEkP99RKq+npjLpKmh
         eYvJcguPdLpgbbQ0SnOSACJyC8J+jRL61B+qszZnXummrjKQcbtnpuZKaJC5qzxtg873
         Cvnw==
X-Gm-Message-State: ACgBeo1WCfh0AswQzgHqb+PsnjHtv2QPy9eIhFZaLXYN2t9GrSWDUw2J
        y+kShT5N0jo16wnkNjfVrx8=
X-Google-Smtp-Source: AA6agR62BzXzT17KlWx9uqQOlpAhM116jyafKxT3anpuAMgqBhik1FZ5pmVPGg2GE9QdKZVv5ooKrQ==
X-Received: by 2002:a05:6638:24c2:b0:346:ce9e:3eff with SMTP id y2-20020a05663824c200b00346ce9e3effmr25894336jat.262.1662327784843;
        Sun, 04 Sep 2022 14:43:04 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:43:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 57/57] dyndbg: fiddle with readback value on LEVEL_NAMES types
Date:   Sun,  4 Sep 2022 15:41:34 -0600
Message-Id: <20220904214134.408619-58-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
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

my test scripts were writing one val, reading back val+1

  echo L3 > p_level_names
  cat p_level_names
  L4

fix this w a -1 offset.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 11fea1f818a7..7d458601a61b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -830,6 +830,8 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
+		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl - 1);
+
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
 	default:
-- 
2.37.2

