Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0F9572CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiGMFAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiGME7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 00:59:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B77174340
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:59:42 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e15so12655144edj.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 21:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbR77KaYU0b8CrpQnqAfg4nKTl226cIZ6lhPDiInDxI=;
        b=k5LPmNUzmeiJ8k5kn7gY+1x2BNP/YPF8Hk0Tqiwp50RoSEMbIYmfAbzPYYtsAIh2Sq
         Fny0cpUJVkafQysIxsceNQw/B3g+i0KjrDXhY1zKiuMuvAyOl9A85jqx4TVYFZWJSH+n
         pPU2zL4BVblAWaE6m4sPBjVmYUNYPI/iwWHoRogEMIOrmg+Oyz5nei3HcH10eusrGNug
         FSoMsQGYaYOmK1Oyv12rH8CkE1aVOBiA/lOfoeKfrps23MrtHMCo2DVhzDLXDIKpYez7
         +uVu4T/5LqSNpDmYhor6keD7Bps+JkP7dYVrwgRNDd4mzxgbYFDoXZ9S0GlGkKzN3Ja1
         sPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbR77KaYU0b8CrpQnqAfg4nKTl226cIZ6lhPDiInDxI=;
        b=8K26IYQV2REw6sZG4FK7xBJ91qma+wNAWgoGKWxsjqYepQRubS5C7X1NhD/IoCLKW9
         Q/d/7hOu5PW69C1Q/xEiHVPtte1uDLV36w3KfYB/S2Ths71TIda0+g+BXXlIwd1QmEsn
         rlFklKM1LSq4ypreii0nJYTRwGzrRtu1rvBE/G17iLyiT/m0k+YkM1CT7o/lOUi1IU5Y
         hxc/KI/9AvWq19ft7IAbrQ8rjJxuAUvAHaqlaCYKWkt9IQ3gUu7uG7NfSPZ+vWwbxjyo
         BBu3FDuLeyeD48HCELEv1RDPicVjyahmknp/hB7oaG/in2BdObIJRr1+qMWKdxvIGc74
         h1gg==
X-Gm-Message-State: AJIora+IYbY877BvqJWG/I3yr6XMMpqp3epL8AGh7TXA4607J7a1pDZS
        x3c/WhkmaVsYKaqcg78s860=
X-Google-Smtp-Source: AGRyM1vPMh/lKBc+3VZvDGn4Tto6gf+E77gQ31z5PtD81c0cRx3reRfRsckERlTIDcf8sbhXOprrgg==
X-Received: by 2002:a05:6402:16:b0:43a:f435:5d07 with SMTP id d22-20020a056402001600b0043af4355d07mr2290455edu.420.1657688381130;
        Tue, 12 Jul 2022 21:59:41 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id w12-20020a05640234cc00b0043ac761db43sm6187706edc.55.2022.07.12.21.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 21:59:40 -0700 (PDT)
Date:   Wed, 13 Jul 2022 06:59:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] staging: vt6655: Rename wBits to bit_mask in two macros
Message-ID: <8929407dc7355df515b7f9fdd195b45ff44f6b98.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a variable in two macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 3037502c1883..b8f543aef716 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -544,11 +544,11 @@ do {									\
 	iowrite8(byData | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
-#define MACvWordRegBitsOn(iobase, reg_offset, wBits)			\
+#define MACvWordRegBitsOn(iobase, reg_offset, bit_mask)		\
 do {									\
 	unsigned short wData;						\
 	wData = ioread16(iobase + reg_offset);				\
-	iowrite16(wData | (wBits), iobase + reg_offset);		\
+	iowrite16(wData | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvRegBitsOff(iobase, reg_offset, bit_mask)			\
@@ -558,11 +558,11 @@ do {									\
 	iowrite8(byData & ~(bit_mask), iobase + reg_offset);		\
 } while (0)
 
-#define MACvWordRegBitsOff(iobase, reg_offset, wBits)			\
+#define MACvWordRegBitsOff(iobase, reg_offset, bit_mask)		\
 do {									\
 	unsigned short wData;						\
 	wData = ioread16(iobase + reg_offset);				\
-	iowrite16(wData & ~(wBits), iobase + reg_offset);		\
+	iowrite16(wData & ~(bit_mask), iobase + reg_offset);		\
 } while (0)
 
 #define MACvReceive0(iobase)						\
-- 
2.37.0

