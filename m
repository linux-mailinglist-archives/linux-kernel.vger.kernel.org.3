Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1C95AC6BC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235023AbiIDVm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiIDVmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:42:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA82C643
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:14 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id p187so5652637iod.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lfSfy0OiU9ae6zZc6r/YuzMWOjdJ0UjQGjJ43pXzmPk=;
        b=KcesxilWXRdWpOhaJNS8hSdNzO2vJhvPIX8XFE/aZuuFFV/+3fkufo6o6ElznrbWN1
         hoQZPHbfdOcz8L6sXkvFrKKZliazt6a4HKb0p79Fa2Zhrdr6HDCcI0KK/H9P9yVDZ0Y1
         XOoaExBg1xHhuXs3yHeI8R5l5GWskuW3Z+FVRjyUb653F8P0zqYTLWJiVIDzJ2NhKKTd
         sAM2TckvvjW2cAHdzhkzl7UYgmcQlxp7qgTNOjT2XZzRsRWDv8h0wvTVgRljyvneh0q1
         9N5+8G6XjIRe/5YLV+HiKEXVas9ltjJefKy4f23RAvj1+gQWPwzMCaVO52+Z4MXYdv5k
         T+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lfSfy0OiU9ae6zZc6r/YuzMWOjdJ0UjQGjJ43pXzmPk=;
        b=Qf1DmaPsWRVIHAUqsdVJqOB6XO0h1ccmRM7dzeJh3MbFFfUUfugvPXr/P6AZISDDBP
         pb5fxXiyNHuekY4Bhgr6V44jeT0LMvpIScMgKV3K1NMccCjeGbsayBX6bUVw0kiuHnyu
         AynaBSEX7QBcDnMS++zX5SEEFQSTr1KnZIjDztFHw2p1W5/r04I7SOq6//X5myZpm3+s
         SzY6C2b2kcVYikiZso3EmYHBceiNRKNCjTYTzEb0wC2NElDnraLtFyIVSCM6/ln4CvQv
         3+qYGxu1Nzb17PMEmsYiJ1nzqeIkKa1X+3+oiKcGbH2CfqO7lGcGKSODoArzQebTDP86
         NcZw==
X-Gm-Message-State: ACgBeo2Vh574bwyNEoyIw6mJfTs6O4eMLj9jCQF+ERHxHZRnniW+ThGZ
        9cifGXrVFWp5qaFUN1lyF44=
X-Google-Smtp-Source: AA6agR52gEm4o8C36a4sLU4vrMjIM3u6oGZjtYr9bqiC4iAeliEnkHdid9H5R34pPZS4s09WvEyVEg==
X-Received: by 2002:a5e:a70f:0:b0:684:d596:b7e7 with SMTP id b15-20020a5ea70f000000b00684d596b7e7mr20134222iod.84.1662327733775;
        Sun, 04 Sep 2022 14:42:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:13 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 04/57] dyndbg: reverse module walk in cat control
Date:   Sun,  4 Sep 2022 15:40:41 -0600
Message-Id: <20220904214134.408619-5-jim.cromie@gmail.com>
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

/proc/dynamic_debug/control walks the prdbg catalog in "reverse",
fix this by adding new ddebug_tables to tail of list.

This puts init/main.c entries 1st, which looks more than coincidental.

no functional changes.

Acked-by: Jason Baron <jbaron@akamai.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8faf584f2f4b..7fb99492c16f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -970,7 +970,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
 	dt->ddebugs = tab;
 
 	mutex_lock(&ddebug_lock);
-	list_add(&dt->link, &ddebug_tables);
+	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
 	vpr_info("%3u debug prints in module %s\n", n, dt->mod_name);
-- 
2.37.2

