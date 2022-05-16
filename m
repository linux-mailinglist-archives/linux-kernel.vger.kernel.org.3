Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A752948C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiEPW6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349969AbiEPW5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:57:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85814476B;
        Mon, 16 May 2022 15:57:31 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id t2so8465564ilm.13;
        Mon, 16 May 2022 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+2n+Qi5LKo8xdlXx8cZCrXhjdY5i9BhXeRgFpMPxBs=;
        b=NQvoUylIO5JvRYRKkb/PCHnnwolYl6EbdFp0mMCOv7MitmhVqHAb5guVHOretvbXjK
         ZljP5Zq8ojGECCuyNcDWedKGEwHiFr3bCx9zWLEYf9W0C+nds9whhURlD9XhKiSCO7DQ
         OGyXFxaVtVysjInj2DdhVyi2W/F6rtyFXOxT1NDAy0Fyt81yzfNimcH58u9kA9Qk38k+
         sAUPfKneovsA95xw04+fA0iGvfWCZmSteGV7Z7d92x+iUTw7lesFH+Yg1NwMefbEH99a
         RIrxuNyTYvZK9T+FMAQcUTHSJMrLbpYDwtOrpy/1WdhW9+HOExR1Q6lM+Eh1+wASXI2c
         ojNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+2n+Qi5LKo8xdlXx8cZCrXhjdY5i9BhXeRgFpMPxBs=;
        b=ciuDilkgHBu4pYzq243P6dLkZCbHm9Rz5JoftN9BUEVnImKdOd2K1cJ7YuR5FeWtAB
         vXRiSJC0AkMy5Zy/P3hAxK+6YWFPBFgmRcl0EuTpreSX8LSaTaAdfHqgfm/J5mN/tsGz
         9y8oulJh5j9EkiaPwBer707GtUuALYkdfK4Y8Hp1B/Mgjv0GtDq8x3wXb78oiqVQY1qj
         CT3YtbkvmIcIeMukSZO9j7VJzD8SVt1lMViAZCCYxZwaH555Cb5Mte4DgL9n/htxoHE7
         y/bBwHt0qfEGYbEEQ5MwyiwmcVdCQzzzzkdARRIvfRftVf1HiBXw2xio8X9l1s+u4B/s
         7vpA==
X-Gm-Message-State: AOAM533Scwe3btshePqSB16z5bx0WZY/y8abtCxkhCVPJzoPccEJGPnV
        1c3Ixd8ox2q+jOHiVdwx4Ww=
X-Google-Smtp-Source: ABdhPJzgjBowqiniO3Eh7ofaYMSxlAshWUZJs/9dRQj0V0v9y1HG3rau/LeKW1REX4tDssVHSSqPxQ==
X-Received: by 2002:a05:6e02:1bc6:b0:2d1:1344:6727 with SMTP id x6-20020a056e021bc600b002d113446727mr5815014ilv.58.1652741851004;
        Mon, 16 May 2022 15:57:31 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::dd9f])
        by smtp.googlemail.com with ESMTPSA id k26-20020a02661a000000b0032b74686763sm3133949jac.76.2022.05.16.15.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:57:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        seanpaul@chromium.org, robdclark@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, quic_saipraka@quicinc.com,
        will@kernel.org, catalin.marinas@arm.com,
        quic_psodagud@quicinc.com, maz@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com, vincent.whitchurch@axis.com
Subject: [PATCH v2 24/27] dyndbg: add _DPRINTK_FLAGS_TRACE
Date:   Mon, 16 May 2022 16:56:37 -0600
Message-Id: <20220516225640.3102269-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220516225640.3102269-1-jim.cromie@gmail.com>
References: <20220516225640.3102269-1-jim.cromie@gmail.com>
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

add new flag, and OR it into _DPRINTK_FLAGS_ENABLED definition

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0a81a3582281..7581fe79980a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -42,7 +42,9 @@ struct _ddebug {
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID)
 
-#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
+#define _DPRINTK_FLAGS_TRACE		(1 << 5)
+#define _DPRINTK_FLAGS_ENABLED		(_DPRINTK_FLAGS_PRINTK | \
+					 _DPRINTK_FLAGS_TRACE)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
-- 
2.35.3

