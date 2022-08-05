Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5DE58B1E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiHEV5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241806AbiHEVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:55:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77A7D788;
        Fri,  5 Aug 2022 14:54:56 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id c185so2857640iof.7;
        Fri, 05 Aug 2022 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8Di3KlCpKKLc83SvAaF4ufqdssAuqHwTNN+eiKiYlTw=;
        b=KMSBPxec0CZihP4SWoEQ8H+eUfnM6dpBj0CRtlFtLTYwb4BV0yDmo61reX1hHnGkp7
         S3V+E1OgM4UDp2ijXiPwTxvb5x/X23N+NRQsTJ6wrtQ7MF1xar01ugxg8JVIga5vuHtt
         EQapkyCoIWiVlU55niDWItnMQjycBO/b6kV4CX3GPUz6dMNFnGdTIrsCRJfVm2ybrLdf
         y/DWjeZpAyibNZrId6OjLyipoBONfLMyXKs18Vmo6ncq7x0wkZa+ZiCDQ3ykC/wUeoKF
         TQpFfiZuVsEMPNw/DilCduphak4xGdB4GPaVLDIZE0i80vY2GETKEVTfnmfykp92kaMR
         KQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8Di3KlCpKKLc83SvAaF4ufqdssAuqHwTNN+eiKiYlTw=;
        b=tXSUSQxnTYrWLOjNiE/juQ5pCwdfwdOW9IDvd6eAFYIqOVIJs5BuAGNthHVRw94sqK
         9DG1yviuXKPbA/uYzfcygtC840C73WbPiiBKrRqhhfb+I6kxnQ/QNrQ3yAeoV87nVwbr
         g6lwtsi2lRpF4ijn/6suqFzNGfcUoDgZsrpv7fNnASLIM0h0O1mcuTsRJOSHedG6bL/C
         VrxUHEyWobraqOFkYw8ByMiJ5Bcsn44ErFMlnfcrotrpF7AkHLDmTH/+KASxechKHSq9
         eHYKoZI/AEvWFIaj7XPitlViVsERz19R6fXi+AWlPY330cXZNYIqoZYIF+28HCo0/d3z
         0wNA==
X-Gm-Message-State: ACgBeo1rbkzTohM1D+3NerAK7G8DzsI8ORiXEYRPxrtU0B5FT66/t1Se
        FRE7R16fuFo97ZVoIi/tLulKmlC+ltXyPw==
X-Google-Smtp-Source: AA6agR4O2kdgTkTSTjS3wkx/1NG+MBZqECClAcHMDs/7cRn6A/ixRnTDTJEjOKioFT/ts6fhOTAU2A==
X-Received: by 2002:a05:6638:d45:b0:340:5c58:51f4 with SMTP id d5-20020a0566380d4500b003405c5851f4mr3839718jak.280.1659736495160;
        Fri, 05 Aug 2022 14:54:55 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:54 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 31/33] nouveau: change nvkm_debug/trace to use dev_dbg POC
Date:   Fri,  5 Aug 2022 15:53:53 -0600
Message-Id: <20220805215355.3509287-32-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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
2.37.1

