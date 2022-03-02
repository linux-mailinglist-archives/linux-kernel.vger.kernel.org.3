Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19FC4CB041
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbiCBUty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244710AbiCBUti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:49:38 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4617CD64EA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:38 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 195so2637935pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qqbW4mdqciy+82dvr9Ujq0D1mLaRlfhiMe48ZVZg+Ds=;
        b=JJ6JYyQE/5/9vxeTZIIdWgeBM/zmg+L98MNjcZd0o2zhHMBTDjYcxsp/LuqCKUuFsJ
         viLEUxdLWN1Kg1SWyfTYIBNpl2ih0WB7MwW1HJCHhDisEU7cBvdIPoSrykrsH/5DW6x9
         yYLtqtF2CdidfNOlAaKFnU1+UKtH6gIttB4IkwstNnOtF8ogVfZTTX5KSPJUHPFz41Zp
         1fc4X7h72QUp2ryaurEPId7wNP673kqBCSebYIzwgaPKPEaVxyea2ZtuuvJ4++wHhHux
         EoT1F/hTytT+15sSnDJf8tkkHK3wY/oJcpwROOl3TvQ4gatqRJ89ZFt7htd7sCVKI2rf
         2vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqbW4mdqciy+82dvr9Ujq0D1mLaRlfhiMe48ZVZg+Ds=;
        b=t14g84MGxO05DZF7Y4NuKnfLk52+QnuhoEdpt7twuX3qMfg0048bX14BotjX9O6wuM
         mYez5B89HV2m4xjLEDXuf+TTBjOwSKYK1K876Td6c1VvQ+2D1PPx5+FRRWBCN5ESBC7H
         qOyN3M9sl2v0hPj4dWBwDWxT8sgoI1rh1uxQu/ZIZJpd/GOCeKvMDn2JZbpr0mW5jKpU
         n8dYLFOk/B4V3XWcgfzHtwnlgqy4kaMNtKQamEEGEV968XAGOo6oq7ke35IXgLZ1D2iz
         DZQBiPDd/pjT3AxDMMh7AOsJOVDG4opydKC94hprI+Y+Itr1TLpTgy3DlOvqnVJwi6Gk
         ScDw==
X-Gm-Message-State: AOAM533bU3Y4Jysaj2fTPcYHxltFtDqVJXPFhwO0ikxDAzAUjfQscW7G
        HP0DqcEYjL1OFDz1fwa7Ums=
X-Google-Smtp-Source: ABdhPJxPv4BnSvxVWj8xRhjbwT5XPOZlzy7nsDZ/fonBx/0aZNrIynaWFG7cZ+7WPnnjhQt35h/xtA==
X-Received: by 2002:a05:6a00:248c:b0:4e1:4b53:18f1 with SMTP id c12-20020a056a00248c00b004e14b5318f1mr35078186pfv.79.1646254117836;
        Wed, 02 Mar 2022 12:48:37 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:37 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 11/16] staging: r8188eu: mark is_ap_in_tkip as bool
Date:   Thu,  3 Mar 2022 02:17:32 +0530
Message-Id: <20220302204737.49056-12-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302204737.49056-1-makvihas@gmail.com>
References: <20220302204737.49056-1-makvihas@gmail.com>
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

Mark is_ap_in_tkip as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c   | 2 +-
 drivers/staging/r8188eu/include/rtw_mlme_ext.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 8e8a82a1e..665b07719 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -1013,7 +1013,7 @@ void update_beacon_info(struct adapter *padapter, u8 *pframe, uint pkt_len, stru
 	}
 }
 
-unsigned int is_ap_in_tkip(struct adapter *padapter)
+bool is_ap_in_tkip(struct adapter *padapter)
 {
 	u32 i;
 	struct ndis_802_11_var_ie *pIE;
diff --git a/drivers/staging/r8188eu/include/rtw_mlme_ext.h b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
index cf397ac68..0c555ea67 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme_ext.h
@@ -508,7 +508,7 @@ unsigned int receive_disconnect(struct adapter *padapter,
 
 unsigned char get_highest_rate_idx(u32 mask);
 int support_short_GI(struct adapter *padapter, struct HT_caps_element *caps);
-unsigned int is_ap_in_tkip(struct adapter *padapter);
+bool is_ap_in_tkip(struct adapter *padapter);
 
 void report_join_res(struct adapter *padapter, int res);
 void report_survey_event(struct adapter *padapter, struct recv_frame *precv_frame);
-- 
2.30.2

