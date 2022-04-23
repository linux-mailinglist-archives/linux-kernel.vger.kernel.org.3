Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5469850CA50
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiDWNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbiDWNFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D56F1F040A
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id c23so16766479plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KrgVC3UPNzr2hlG0BxhLQFDCAl0tXFxgqHvP744zkDY=;
        b=hNsr/DD/bbhFB2+PqlTKJgoT+/OfTJgg+SQcqbSBWJsGPDvgnY67fsL83OXpsVJA6f
         MkJ0Z4bjqg8CV2hsyrcg1TM1xmGuMeMbKD18HVBNuNmbqxOWNjBXg4Cxcw8BFhUimiRV
         P9PB1dymobQnVePd7vIHBdcIVcj+4GiPQy4REzPH6tiO45Ckys+xLK3OCweuZ77YDAT8
         TqrXKqACg77aUSdytJPfbK8Q7I5ByTOU3vQQF0l5qU1GcZpjDT3RgRs7dv8/8yv++7Un
         m+Lgu+YybF0gBkiyN3OOM4okbxtUvWir0VuDD6QcZ1tVhaJ/8aBHKR9r6CZABo+Bze+S
         ORPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KrgVC3UPNzr2hlG0BxhLQFDCAl0tXFxgqHvP744zkDY=;
        b=ivsc6shuKvxhFpK8aYpVoiPeUoUe9d7ZLdjO52KVUdlL0U1IuPqp5faTb2jDyBfJMX
         4Pn6xpUPa8lMFxc4EvyEtbVe0Ka0SrQlqqIhGUZro02RWlk2rI2ybfan4CkhwMQd5F6i
         S48HVi9qa9VAuAZiabbHjDmc5GS5Gp5P7+Stp2ANGfWpRyWgBVbPJ2RolQBXtC6iG9yQ
         w3t4OFTtiinwsXc+Oo+finm+UrtDgMZFJAL1FRAPa7Z63mcyiQOC2elrQ+6dJKLeJmBt
         p+WqcpHJmx7oCNMlC8OQSgXs31vBaNeXniKFMIE/VBS7v9uDyjzdiD1NSYoNXwOuKHTC
         yvaA==
X-Gm-Message-State: AOAM533PCFlp9ZppLjQ5wq57WlRLmUMNo30ywb1O/0tlLxmqm13XVxKi
        tPZUN7Z7vlNrQMUcWkTxngweMFNLbs9/jw==
X-Google-Smtp-Source: ABdhPJyTbZVGl+TE0cMbfLiKFHFwn4cywT2egZi8doupH20ZPQrMCFEL4VGd59CUCEmD4DMGroZVLA==
X-Received: by 2002:a17:90b:4a0f:b0:1d2:fe13:841e with SMTP id kk15-20020a17090b4a0f00b001d2fe13841emr10789827pjb.97.1650718947490;
        Sat, 23 Apr 2022 06:02:27 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:27 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 6/7] staging: rtl8192e: Remove u16 cast for u32 parameter
Date:   Sat, 23 Apr 2022 21:01:49 +0800
Message-Id: <20220423130150.161903-7-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423130150.161903-1-wjsota@gmail.com>
References: <20220423130150.161903-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The explicit u16 cast is not necessary because rtl92e_eeprom_read's
second parameter is defined to be u32.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index feddb15bccbe..4b9249195b5a 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -320,7 +320,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 		priv->eeprom_did = rtl92e_eeprom_read(dev, EEPROM_DID >> 1);
 
 		usValue = rtl92e_eeprom_read(dev,
-					     (u16)(EEPROM_Customer_ID>>1)) >> 8;
+					     (EEPROM_Customer_ID >> 1)) >> 8;
 		priv->eeprom_CustomerID = usValue & 0xff;
 		usValue = rtl92e_eeprom_read(dev,
 					     EEPROM_ICVersion_ChannelPlan>>1);
-- 
2.36.0

