Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F30D5AC729
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiIDVot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235680AbiIDVnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:43:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271E2F657
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:40 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id m16so861459ilg.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LAElKATTm6r2TIe9HchZuJ0iTvp0tkidaAAlkqZf57g=;
        b=ioFXEtAboLLUIN/kNyc61L0HOu8/6UCEVPrRpVK/iZqDkjSxhy1lokEax7skm4mwOF
         mCdRRCoU7224D2s+eeI9bmOsLLpeqbAXpSoc5ewN3Vnu4++5Y8MjvC45CARQ2eSUmtPM
         vq67RMmjwELCYQ5rsDgJHAwkUX47ytKixYLVLxiRln+UZzGGvAk+2JB+Sw0belDPO48F
         qDmzIHF6L9eAsm4bEnMCzLrXaEJmVUloL5mpLRJ14V94PQCg5aoimHZKHASnmIAq31fh
         i6l/G06rgbvOyZ/eJK8nqcrZ4A1qC4+YiBem4FdzmsbXjDz5e2YWLpntsHdBPAZvrPbS
         m72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LAElKATTm6r2TIe9HchZuJ0iTvp0tkidaAAlkqZf57g=;
        b=P67HNdUyjaExBdl5MMlXDQHlR+pscy+wDpQ1XINCVFWHnD2ddLyzxe3gy+7aIem8kN
         BrHmaYicd3KCWyhfUWZoHHdpHVX2FsxgU6EMm1hjhkUBfsDTlhgMj9P71HqF2jQ8xuAX
         RXHeIknFDxErJodXde5D/1NuISCtyOawD9jlH7iK7lFvvTZCTmymVV3CaICXlUrzlRWP
         mUygIK9bruChj4OIeZ32jMX/KMY3rgTCnVdkt+3S9ukVEQje8fD4YPLkJOWjSsXlfPev
         myz//cBUXUFmOlm3JMn7R24uLkg+ZAGV8r0W+tAkKzrcpAI/0tc/Bz65cRCjpihap7EV
         IyRg==
X-Gm-Message-State: ACgBeo28teYZ9mF7d85s+/KOmkwfDZ3hJ9o0cbosxxlYhGPOs0xbtNEe
        F+QR78igXYKf09/hXZLkLNc=
X-Google-Smtp-Source: AA6agR4JZnvP+IfSOvpE/ZnPHvuTyE3m/D+cXn8a4t+7sZ/c+tnbIR9Wi8DqdENHAxq6VZVKf3h3Ew==
X-Received: by 2002:a05:6e02:20c1:b0:2e9:f747:ad54 with SMTP id 1-20020a056e0220c100b002e9f747ad54mr25614470ilq.144.1662327759838;
        Sun, 04 Sep 2022 14:42:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v6 31/57] nouveau: change nvkm_debug/trace to use dev_dbg POC
Date:   Sun,  4 Sep 2022 15:41:08 -0600
Message-Id: <20220904214134.408619-32-jim.cromie@gmail.com>
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

These 2 macros formerly used dev_info, and they still check
subdev->debug to gate the printing.  So dyndbg control is redundant
ATM (and possibly confusing, since its off by default).

prdbg count is up from 3, or from 65 (with VMM_DEBUG here)

[    7.765379] dyndbg: 516 debug prints in module nouveau

Its possible to control error, warn, info callsites too, but they're
usually on, and the .data overheads on ~450 more callsites (56 bytes
each) would just be wasted.

$ for l in fatal error warn info debug trace spam; do
      echo $l; ack nvkm_$l drivers/gpu |wc; done
fatal
      3      19     335
error
    289    1956   30651
warn
     84     513    8860
info
     14      88    1502
debug
    387    2339   40844
trace
     31     219    3368
spam
      1       7     123

bash-5.1# echo $(( 516-65-387-31-1 ))
32

Thats approximate; not accounting #defines and doc/comment mentions.

NOTE: this patch changes the log-level of the macro-issued messages
from KERN_INFO to KERN_DEBUG.  Adding a .kern_lvl field to struct
_ddebug could fix that.

RFC: dyndbg & subdev->debug

Separate class-maps for each subdev are possible; except for the
coordinated use of _base, each is independent, including choice of
DISJOINT or LEVELS, as long as class-names don't conflict.
So theres some flexibility.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
index 96113c8bee8c..065d07ccea87 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h
@@ -59,8 +59,8 @@ void nvkm_subdev_intr(struct nvkm_subdev *);
 #define nvkm_error(s,f,a...) nvkm_printk((s), ERROR,    err, f, ##a)
 #define nvkm_warn(s,f,a...)  nvkm_printk((s),  WARN, notice, f, ##a)
 #define nvkm_info(s,f,a...)  nvkm_printk((s),  INFO,   info, f, ##a)
-#define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,   info, f, ##a)
-#define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,   info, f, ##a)
+#define nvkm_debug(s,f,a...) nvkm_printk((s), DEBUG,    dbg, f, ##a)
+#define nvkm_trace(s,f,a...) nvkm_printk((s), TRACE,    dbg, f, ##a)
 #define nvkm_spam(s,f,a...)  nvkm_printk((s),  SPAM,    dbg, f, ##a)
 
 #define nvkm_error_ratelimited(s,f,a...) nvkm_printk((s), ERROR, err_ratelimited, f, ##a)
-- 
2.37.2

