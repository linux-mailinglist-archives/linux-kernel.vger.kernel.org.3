Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B325AC7C9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiIDVqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbiIDVoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:44:46 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9702F02B
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:55 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id k2so3867984ilu.9
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jSafBWcpIkewykTpB/1313WvVuyh8yQZEmhBKVyM37c=;
        b=kbrF6hjoM+H17g9j3Wc1/6pJQXLvRnZ3Vs2WK1V3kWoZOwTfI3zERDRkFgtpBOrFAe
         aGn093m3smVeCRZc5LHalL7AoxbuS4AQdvZJaVIGnimvkEeM+rU3RRvd61Y/+6IWXHfl
         kzGQAdJFvZEfilUjxUNjkQBoZrnnNuWzDxd3Yt6Ikt65YhKsu8QQofbdJP1Nb7Jw0VW5
         kMVkkJh4rdB9IpjDMcRVjEMDMbxOf5ddpY8akTKF8dSThHmxapKpkB5IEwhZVzCE7tj7
         3JBKIi1e8jUIyR7UaiNXs4jjXjUOieSwp2MgZNZauf5xpbvtBGKzVaok6AF7eoTkzZnt
         HL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jSafBWcpIkewykTpB/1313WvVuyh8yQZEmhBKVyM37c=;
        b=wffhvnBOS4uTD4xJNZ8APLLmUwHlKtokiC37Ki7APapz2Vjc+d6yoNivrxGWormUYy
         HMXk3FpcV37E3ubp1fGrL0EKaWCpl3aDWdaqnOj3yZAImYePh965gJerUE0diV2lL+OA
         twVfwKwMNLFkjaqjW2IHU7iwD9DQxaMDFNGyYCCzbdSV88VInkk0hQcBzhWBzYFPto0A
         RanDVMDZoOboa5YM7JGFkOcd1UZIWMCtpEfsMf48WBLz03nm1EXLXAdbTsLubEwZBXRz
         dnglBzjO6HObXIlLPCb1d6EXYqiYS7rrx/YoTu2MrXMSTV8bmz/LxzIYRrFIVPr+A8cJ
         mhWQ==
X-Gm-Message-State: ACgBeo0SxrfX96LLObiBE23z1JPiwRASW+C5//Lij1TiNhTecIAvPWvP
        PGZq1P0XEEUwITyvQE7O1rs=
X-Google-Smtp-Source: AA6agR5AVD3WIg2eP3iWjFE39m5/nR6rpJNEPwSMnDilTle2doeCtgXvqbPXlS48tak7nK63rsd6XQ==
X-Received: by 2002:a05:6e02:1b86:b0:2f1:76ec:4b91 with SMTP id h6-20020a056e021b8600b002f176ec4b91mr848152ili.191.1662327775227;
        Sun, 04 Sep 2022 14:42:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 47/57] dyndbg: demote iter->site in _init
Date:   Sun,  4 Sep 2022 15:41:24 -0600
Message-Id: <20220904214134.408619-48-jim.cromie@gmail.com>
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

---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 059212df68f9..65b0a1025ddf 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1547,7 +1547,7 @@ static int __init dynamic_debug_init(void)
 	}
 	iter = iter_mod_start = __start___dyndbg;
 	site = site_mod_start = __start___dyndbg_sites;
-	modname = iter->site->_modname;
+	modname = site->_modname;
 	i = mod_sites = mod_ct = site_base = 0;
 
 	for (; iter < __stop___dyndbg; iter++, site++, i++, mod_sites++) {
-- 
2.37.2

