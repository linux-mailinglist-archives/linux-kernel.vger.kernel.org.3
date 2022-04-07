Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7E4F881E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiDGTb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 15:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiDGTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 15:30:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A978E29C943
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 12:28:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id d10so7663834edj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4GbYZVMFElHvzO+iQClMBl41EoDQR5lCZDpNuOsesIM=;
        b=f32jQxMh6cZJunXjmKXPIN2VZ4JZ80H5ldflvegBNmDDa31AknYQsB+Nj3CURL2CXY
         5OwinzxJ6SpDcYo6Cp01D1NtEwCAPf8lAcDUBx09nsGpQOTM7VQGqU6UEN/JOe2IGdjE
         QtrPIYNvH0+yEcrelL4w09e7Mk0p9T32Nj+PQokm4HWUlm27K+K3sxqD2bMlAFCe/wlq
         XF/q0jJCT/fxtpwgFS/yNMLU13bdueiDNaHFQCGhbkrF/KxcAUwZDd0C9OQUrp6Ej/43
         aaLKtoUKZ7IzdqabGq2yDjTBRJu990iN0h8FPrbWIyaxVKbiJIsHLE++xkGX6UPJUCcS
         PZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4GbYZVMFElHvzO+iQClMBl41EoDQR5lCZDpNuOsesIM=;
        b=jEsXGogr3KoByIAUGSJsVi+v+dVju/BIyWR3tEA4KxgByqk6+vjHIEbaPn+mEyC4Pn
         3Yx14taBtEYCW4BtKhwrYqdBzGqzEd4HU3XkCYq61jbdW4aCS89E7DfpODF6KPD/Fjrq
         bHYBWEGMf7DDIHAQQpFpRXPg6WmvupgGYPcahdcdADldBf3KOOkrUxdgIDQ9MhdfIWpb
         pjA4tkYvrkBz78DKpO0zLICJhx0LxgijORshKNII+/ynT5N2gTKNSGLSyJU5iTh+a4sH
         CF4r6f0zmai+SnR46/8anLb8ikYBxFMcbHEJw60UMynR8FJ2pEFvyJmlm9DyPlVNh6FB
         QAkQ==
X-Gm-Message-State: AOAM532pApWNpakOjzX4c/86np5+Qw9iy/rVtpQZqnFd4+NzprMqz+z6
        CxiQFbsuQnem8XLLyWLTR/A=
X-Google-Smtp-Source: ABdhPJwa2YoCvcD2WKGzObGQEXzbP4u8iJPAKRnadWcx7XVVMMiZd+6wnUsRPw0XVcwmt143NjEf5A==
X-Received: by 2002:a05:6402:4247:b0:419:3990:3db6 with SMTP id g7-20020a056402424700b0041939903db6mr15627565edb.193.1649359709066;
        Thu, 07 Apr 2022 12:28:29 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id k14-20020a50e18e000000b0041b6f23f7f6sm9652798edl.22.2022.04.07.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:28:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: r8188eu: clean up rtw_ioctl.h
Date:   Thu,  7 Apr 2022 21:28:19 +0200
Message-Id: <20220407192819.10661-9-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407192819.10661-1-straube.linux@gmail.com>
References: <20220407192819.10661-1-straube.linux@gmail.com>
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

There are lots of unused macros, structs, etc. in the header
rtw_ioctl.h. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_ioctl.h | 79 ---------------------
 1 file changed, 79 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_ioctl.h b/drivers/staging/r8188eu/include/rtw_ioctl.h
index a36bd7313755..c704f3040ac8 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl.h
@@ -7,86 +7,7 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#ifndef OID_802_11_CAPABILITY
-	#define OID_802_11_CAPABILITY	0x0d010122
-#endif
-
-#ifndef OID_802_11_PMKID
-	#define OID_802_11_PMKID	0x0d010123
-#endif
-
-/*  For DDK-defined OIDs */
-#define OID_NDIS_SEG1	0x00010100
-#define OID_NDIS_SEG2	0x00010200
-#define OID_NDIS_SEG3	0x00020100
-#define OID_NDIS_SEG4	0x01010100
-#define OID_NDIS_SEG5	0x01020100
-#define OID_NDIS_SEG6	0x01020200
-#define OID_NDIS_SEG7	0xFD010100
-#define OID_NDIS_SEG8	0x0D010100
-#define OID_NDIS_SEG9	0x0D010200
-#define OID_NDIS_SEG10	0x0D020200
-
-#define SZ_OID_NDIS_SEG1	23
-#define SZ_OID_NDIS_SEG2	3
-#define SZ_OID_NDIS_SEG3	6
-#define SZ_OID_NDIS_SEG4	6
-#define SZ_OID_NDIS_SEG5	4
-#define SZ_OID_NDIS_SEG6	8
-#define SZ_OID_NDIS_SEG7	7
-#define SZ_OID_NDIS_SEG8	36
-#define SZ_OID_NDIS_SEG9	24
-#define SZ_OID_NDIS_SEG10	19
-
-/*  For Realtek-defined OIDs */
-#define OID_MP_SEG1		0xFF871100
-#define OID_MP_SEG2		0xFF818000
-
-#define OID_MP_SEG3		0xFF818700
-#define OID_MP_SEG4		0xFF011100
-
-enum oid_type {
-	QUERY_OID,
-	SET_OID
-};
-
-struct oid_funs_node {
-	unsigned int oid_start; /* the starting number for OID */
-	unsigned int oid_end; /* the ending number for OID */
-	struct oid_obj_priv *node_array;
-	unsigned int array_sz; /* the size of node_array */
-	int query_counter; /* count the number of query hits for this segment */
-	int set_counter; /* count the number of set hits for this segment */
-};
-
-struct oid_par_priv {
-	void		*adapter_context;
-	NDIS_OID	oid;
-	void		*information_buf;
-	u32		information_buf_len;
-	u32		*bytes_rw;
-	u32		*bytes_needed;
-	enum oid_type	type_of_oid;
-	u32		dbg;
-};
-
-struct oid_obj_priv {
-	unsigned char	dbg; /*  0: without OID debug message
-			      *  1: with OID debug message */
-	int (*oidfuns)(struct oid_par_priv *poid_par_priv);
-};
-
 extern struct iw_handler_def  rtw_handlers_def;
-
-int drv_query_info(struct  net_device *miniportadaptercontext, NDIS_OID oid,
-		   void *informationbuffer, u32 informationbufferlength,
-		   u32 *byteswritten, u32 *bytesneeded);
-
-int drv_set_info(struct  net_device *MiniportAdapterContext,
-		 NDIS_OID oid, void *informationbuffer,
-		 u32 informationbufferlength, u32 *bytesread,
-		 u32 *bytesneeded);
-
 extern int ui_pid[3];
 
 #endif /*  #ifndef __INC_CEINFO_ */
-- 
2.35.1

