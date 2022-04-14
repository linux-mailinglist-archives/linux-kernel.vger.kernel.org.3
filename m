Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10786500B63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiDNKq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242391AbiDNKqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:46:16 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5357778934
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c64so5776532edf.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gsZkfzMYeP6pd9u0lclNFF+p8O0+cqjChmSOXbRt/s=;
        b=IewDFGHfG/ljKouP909yUMkKnfqkQGLCtZ1vhKDaWpkKh+VVEliNxHU0c5L8V2ErxN
         TRn3nGEC1Q9WAtYW/uGXjuoScxaqRDA+GhxMuk1UJOoTQpkPYdtO4nAGNaVzDQwquJM5
         XeSMg9kM7lwxMvv+RNtvVaySj/9CmphfwB8tajknVt13Z4/w8zU1pAJo4z+cbZctGCWZ
         nfpdTZrurFFZ6N5uSMNX/IIA78hlc4FO26vPlaN+PSfjwA9mP7TYJuAsxza3wqfdddq6
         3wU4Uh1NlWdDmjQckButG3ucZS57D4e/uDZdBegOZKF+D3u93ViHW5Du/+0XvT8vfnZR
         6AYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gsZkfzMYeP6pd9u0lclNFF+p8O0+cqjChmSOXbRt/s=;
        b=N1IAPTnoIjy2PshKn+B6iq7bXop0OmWP1I97Mhwax1HD8+hHo85aOf7oqW/lbfk7C/
         bSkrya4T5Fs9K2TEsr4ERUNYTV7EZO40LAn4jugsS/nl6IXcGuoZYFbbKM4Gdb9I71oS
         dYfXYDvzpcXxccMVHi4jt0UTwjol81wzdx+hUdwF3OGDycVulruP+6eQ70s45j1smv04
         +KjTKH7XHpsC1LJytJcblmS4aiKoZoLr9UttaeKKRihFOmeiLoChXyqhu2TUSRXmVP9b
         zOswPYaAZTsdu6mElRlcQXrXpvNsfVS5e7z6HymAvKKioHUkaaQj42GRyjzqGcZxkl+A
         0DQw==
X-Gm-Message-State: AOAM532r0kBVqp+or47biBW4n5CGMyYqajAO0nhcAG5uZUugQxJd9h2H
        BkPAOSsitNZBRJW0xmNGc/Y=
X-Google-Smtp-Source: ABdhPJzo72aDyiS8Zt0ChKhuI/D5Raosh8XxvW6NynlopdOy/tC2lH2pCJ99HTMvZDPhweq46RjxWg==
X-Received: by 2002:a05:6402:e96:b0:41d:1a0f:e70a with SMTP id h22-20020a0564020e9600b0041d1a0fe70amr2251748eda.411.1649933029957;
        Thu, 14 Apr 2022 03:43:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm821318edt.34.2022.04.14.03.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 03:43:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/8] staging: r8188eu: use sizeof instead of hardcoded firmware header size
Date:   Thu, 14 Apr 2022 12:43:19 +0200
Message-Id: <20220414104323.6152-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414104323.6152-1-straube.linux@gmail.com>
References: <20220414104323.6152-1-straube.linux@gmail.com>
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

Use sizeof() instead of hardcoding the firmware header size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_fw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 3da52a1ba23c..94526064f29b 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -263,9 +263,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 			DRIVER_PREFIX, fw_version, fw_subversion, fw_signature);
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		/*  Shift 32 bytes for FW header */
-		fw_data = fw_data + 32;
-		fw_size = fw_size - 32;
+		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
+		fw_size = fw_size - sizeof(struct rt_firmware_hdr);
 	}
 
 	/*  Suggested by Filen. If 8051 is running in RAM code, driver should inform Fw to reset by itself, */
-- 
2.35.1

