Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288314C90AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiCAQrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiCAQrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:47:36 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EC542A34
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 08:46:54 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id d3so12992456ilr.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iB17natQD1MoZXV2qkvWvbusYAfF8+WZi2MjQWQu/w=;
        b=SHplEMJ4dgHQP7e3PXFiBHg0b5PrXGyYSjVU4WM97MmcMC8lOxaE+n44zic8aROkue
         YJdXX8P0waLgppC8wUfg3TPWWpPLZ43WMZhNXseOpaKUIiaQwABtxpUf9fsu7DNCjstI
         8IbA0ejfY82JTbCixhin11dJbzKOp6EHlG+zrVV9HCZcuvwQdSz48pnbzG4vk7M7RlUx
         VG6drh2X1ywcyBZ2WRkNyO5FWAldJ8e+ijz/Zx5BvGVUqczqyRyvgZZFm9AAh9aHCAtt
         JMjSVUBelGF+64eRHC6eM1PvoM0Y5Piq4V6fEpZLUed4c0GPKgFKSFH3RGyUaBYCImXz
         GMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iB17natQD1MoZXV2qkvWvbusYAfF8+WZi2MjQWQu/w=;
        b=63a8YLeK73HIbS1z1nbaYTOc47j1wXfm1Jc8Vwbjd1IC5KwGqHkZjziQOPTzjHyTW/
         hbEgx7yrAQGmhrBDhNu6PM/4btj7wdmqVhM2AS5xKSmoqLZS/PBMGjXR6jSkLPy9n+R5
         sA5ii0umJ5iUnysKPS7MUwI2uuK5FWFJknzNvQdRLdIltEOeUUEay/hjXkaiBlYTSmZb
         tLO2kPGumL6Je5Zc5quf5g7DErN6Eny4G8KrG3Ada99zNr6uPaXpxvWgDhX5DScohAvS
         yY5pOuYF7lfWWzpWyuINSKhIRBySLi/3vGIZ6QF2IB8uHXVd7gGtysvz9PYFnODZky4w
         +FxQ==
X-Gm-Message-State: AOAM530819LR3QamJ2itReKiBvIk44R6yhGFSz7UZohbm9YGelLCH24a
        Ma9DDPjmsY1ltcJq20aFI5k=
X-Google-Smtp-Source: ABdhPJxLY8uCZOj8gfXThodH+sbeS3tw4N8aFtECPOV8owdml6wtey6aG7AC7+fAtaCy8s8BIGAwZg==
X-Received: by 2002:a05:6e02:20e8:b0:2c1:e164:76e6 with SMTP id q8-20020a056e0220e800b002c1e16476e6mr23670264ilv.135.1646153214231;
        Tue, 01 Mar 2022 08:46:54 -0800 (PST)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:2010::f10e])
        by smtp.googlemail.com with ESMTPSA id o3-20020a6b5a03000000b00640a33c5b0dsm7272411iob.17.2022.03.01.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 08:46:53 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/13] dyndbg: abstract dyndbg_site_is_printing
Date:   Tue,  1 Mar 2022 09:46:22 -0700
Message-Id: <20220301164629.3814634-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220301164629.3814634-1-jim.cromie@gmail.com>
References: <20220301164629.3814634-1-jim.cromie@gmail.com>
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

Hide flags test in a macro.
no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 664bb83778d2..106065244f73 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -56,7 +56,7 @@ struct _ddebug {
 #endif
 } __attribute__((aligned(8)));
 
-
+#define dyndbg_site_is_printing(desc)	(desc->flags & _DPRINTK_FLAGS_PRINT)
 
 #if defined(CONFIG_DYNAMIC_DEBUG_CORE)
 
-- 
2.35.1

