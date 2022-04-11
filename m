Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A04FC628
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 22:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349953AbiDKUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 16:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349956AbiDKUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:51:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9781B14086
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so14691347ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 13:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=31uCAJiyq7QrqdMYo3XU+OFlXDPDCua4Bs/5v7Ob/uo=;
        b=EMyoI33OZNOXsnQUqwxuKbE/1kfi8pvyYRP4JJOnqqBLguymIjgREKWey3l0nWGvDX
         e0bkvT/9nwkF1b+kCDvvRu1OK8CpzYVPj0P+EAZpkAq8EIQg0jJx7WRYxasMNJkA6wqI
         HZ1Z9kVgu4kEbPGlKbOCK9fjua0jmgJaVOdanwbfjCtEoCky1RQhq+kEvcxRriuKX09Y
         vYFLUx5lv5JR7G4I63cy4Zzw7R8szLmWIbYlDNsry1zM3475v+7xvhuung8JvlsN+dvt
         CEGUo4Klppdyx/LhK9civ4v5Gudvp57ylpazZ4OqJKOAfqO+hq/YoSw2Vlv50nI6k5cj
         l0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=31uCAJiyq7QrqdMYo3XU+OFlXDPDCua4Bs/5v7Ob/uo=;
        b=1pK4ZVrbnMwM4AHykJZMx+Yt/N0ksbCB/0WPnxFBv/XYX8eRUuEpCLrSgX7dBeHZhb
         z66T4H2Li06eaeTUfM8ESt07pcySvYWFMgo0YUzIAfHBOVztQ4cYYDpqdx7dI5zcDsPf
         +l+v7ThOh+aGPKR0t6w8jGeytxnOBFPm3Ytmpou2J1B4YIl4XsHe2T760vu5PhH7a7Gc
         ARRBhqxHXC4bQowNkRQLS6IYfCsEEOlZDQy/xsxq0e+G+MInuZL2yxcqnX1I4xltkVch
         uiwLJNk15QqYPJTMmqkpjQmVBhNqWB299a3olELLYtKBVNTvUFNcSjJuscb8T4ztWrHB
         VD/Q==
X-Gm-Message-State: AOAM533pjJABvaodRGCvGlzuUG8A+gX8T5SrEp7TqNUoWWdByN+QLVxK
        Ffclrz1RA7n6b/AoTdI5Cog=
X-Google-Smtp-Source: ABdhPJxJodTfjny+R0IqyIY3sjWc/vYuaDggsMt+TWW/Kj586hiQH9QbVCdBx1cD1jnems7PZiFqXg==
X-Received: by 2002:a17:907:d20:b0:6e8:4090:b9db with SMTP id gn32-20020a1709070d2000b006e84090b9dbmr20044655ejc.480.1649710170959;
        Mon, 11 Apr 2022 13:49:30 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id e11-20020a50becb000000b0041b64129200sm16222363edk.50.2022.04.11.13.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 13:49:30 -0700 (PDT)
Date:   Mon, 11 Apr 2022 22:49:28 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] staging: vt6655: Replace VNSvInPortW with ioread16
Message-ID: <c8b0bdbe8ef47b8264acd0e1705e92d551822880.1649706687.git.philipp.g.hortmann@gmail.com>
References: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649706687.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macro VNSvInPortW with ioread16.
The name of macro and the arguments use CamelCase which
is not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 5/7 and is now 4/6
V2 -> V3: Changed from
          "Rename macros VNSvInPortB,W,D with CamelCase ..." to
          Replace VNSvInPortW with ioread16
          This patch was 4/6 and is now 2/7
---
 drivers/staging/vt6655/mac.h | 4 ++--
 drivers/staging/vt6655/upc.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 88bf5dba9b43..4e7875ff9ff3 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -548,7 +548,7 @@ do {									\
 #define MACvWordRegBitsOn(iobase, byRegOfs, wBits)			\
 do {									\
 	unsigned short wData;						\
-	VNSvInPortW(iobase + byRegOfs, &wData);			\
+	wData = ioread16(iobase + byRegOfs);			\
 	VNSvOutPortW(iobase + byRegOfs, wData | (wBits));		\
 } while (0)
 
@@ -562,7 +562,7 @@ do {									\
 #define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
 do {									\
 	unsigned short wData;						\
-	VNSvInPortW(iobase + byRegOfs, &wData);			\
+	wData = ioread16(iobase + byRegOfs);			\
 	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
 } while (0)
 
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index 44d746de6344..99bf7aeb56f7 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,9 +20,6 @@
 
 /* For memory mapped IO */
 
-#define VNSvInPortW(dwIOAddress, pwData) \
-	(*(pwData) = ioread16(dwIOAddress))
-
 #define VNSvInPortD(dwIOAddress, pdwData) \
 	(*(pdwData) = ioread32(dwIOAddress))
 
-- 
2.25.1

