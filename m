Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6ED599C82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348653AbiHSMzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 08:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349127AbiHSMy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 08:54:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C06056BA0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id q2so3435186edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 05:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tpAs0I6mi3SUOtwu0/CjcjkIDmk/Vrs04W6AV02/W+s=;
        b=NhPiQyO51UgCQXdF3j2uQqCC9wCloxzP4LFinLB2hRf2wfol/F3UuJgwjzKbhXDsK1
         L2hLK746NxNSM6q6vbbYM+7mqIHavC8P6hsvInYdy/RcIZqCAyVyJ4j9Ev8WNLF/FHOg
         4f0lQx6hgP9AcXTOKqZfB4nZw5EfdPiMFGDDHrEnjx3RI39f2Q7MruizK32z8Qwhe9oq
         raqjkH4Q1STK9Qo1cQjPflAja1eOZQeSbSapJBRhnOfwITzn84ERU8ho9GReeyvbxAiI
         TpXNibgG6Npa8rWvB7cV5Qn2649k4RKxWqpktkm6AP8AgTRPDDQh9xU12sBRDNE786Iz
         OUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tpAs0I6mi3SUOtwu0/CjcjkIDmk/Vrs04W6AV02/W+s=;
        b=v4lr8Tsl9kG6OCp+xndmjllHRtuWDDX1AnZUBaT2CHWUjmNMcC7KTsY66jWasp5cEW
         3L8QJzZ2w/UQrMZ1Vr5prrPK3R5h8KtcV4OwK3jblCzTRaUqJLGM8wF6vX/ezJe0auso
         N3Q5Dt5CTORD3uscA4X6rWF2XfAh6AVDtDIS+whorLkaQrudOtCf5F5SPkByvKj5dGg8
         N9RWZoeEcxGCJAWX18Ocd8yX/V4k5mp+qeao66VBe0z59l2EBFwGCtTeuFLshTwwsl1h
         He141je/NGvM0gXPR72yQupMD2C+drD9mbxmbxfePVs/RHXAIlNO5L/BhhA0h/i3jcXT
         fmyA==
X-Gm-Message-State: ACgBeo1tWJIYXIH+aHgknoi53wyXQaD5b/E+TaXgLPbe5od6ISjNtalo
        oaUKbI2+t6By6DEbRCUqWu0=
X-Google-Smtp-Source: AA6agR6qVQcCrDUpgOztkeCznxCfbvHrHpp/3zRAM8C3jGY+6jtCKN/MbpTsHsvH/CjwuSbO51ZZ7Q==
X-Received: by 2002:a05:6402:270d:b0:43a:67b9:6eea with SMTP id y13-20020a056402270d00b0043a67b96eeamr6003185edd.94.1660913682645;
        Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb77.dynamic.kabel-deutschland.de. [95.90.187.119])
        by smtp.gmail.com with ESMTPSA id b12-20020a056402138c00b0043d6ece495asm3000955edv.55.2022.08.19.05.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 05:54:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 06/11] staging: r8188eu: remove unneeded initializations
Date:   Fri, 19 Aug 2022 14:54:23 +0200
Message-Id: <20220819125428.8412-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819125428.8412-1-straube.linux@gmail.com>
References: <20220819125428.8412-1-straube.linux@gmail.com>
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

In the function rtw_reset_securitypriv() three variables are
initialized to zero. That is not necessary because they are all
set before use in the code. Remove the initializations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/os_dep/mlme_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/mlme_linux.c b/drivers/staging/r8188eu/os_dep/mlme_linux.c
index aff9e18476db..48287aeaf502 100644
--- a/drivers/staging/r8188eu/os_dep/mlme_linux.c
+++ b/drivers/staging/r8188eu/os_dep/mlme_linux.c
@@ -57,9 +57,9 @@ static struct rt_pmkid_list backup_pmkid[NUM_PMKID_CACHE];
 
 void rtw_reset_securitypriv(struct adapter *adapter)
 {
-	u8	backup_index = 0;
-	u8	backup_counter = 0x00;
-	u32	backup_time = 0;
+	u8 backup_index;
+	u8 backup_counter;
+	u32 backup_time;
 
 	if (adapter->securitypriv.dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		/* 802.1x */
-- 
2.37.1

