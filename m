Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29624CB035
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244640AbiCBUtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiCBUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:48:58 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04028606F1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:48:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d187so2944817pfa.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIoDn3EA8TVCn84Dm3V6h82LZaIrnrhUBixZa0FUPlg=;
        b=QBqqUc72LLt5d+ZGpIgqsTAeFT4aCrxKy31QdV+QmSbhssjwBUnECJIze7uFxMYIso
         rJidVw0y8hcrdZeuUeTEYGRiKDJ6K7NxRs0PoK/kZk5yt8vvPdhDFmVP8KZ7sDvnXq2s
         3GDP/pH/VS+8RNhqUYmEeHD7DdKfbnytG1reFyGq+dz16BeYXpLNJP1+jpZtzUHLkYV2
         skg3pxcWlV3e1/HzKYhh2il5lQ+MdJDeHRMjuv/iGr7UJ0S9iHDkECQNypyrMMKaZApY
         l+QQaXBBGQPYbju8XkRonZQNCkkLcRXqbBVzREaeyQ/dUgyN3pa0FWf2BQhZyQRZ5Hwl
         kP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIoDn3EA8TVCn84Dm3V6h82LZaIrnrhUBixZa0FUPlg=;
        b=s03sGQCn7gCaZxxEDQ8pF116moZMGYt+amjr2vZQQnsG6vvFU0vUtG/IFPF6DMNsBe
         WsTsLTBva4psXJMS99N7xCf5vg1qRLLPbmgtV1GSq/TAVtcs/O8QHzIz5CaqDUcuee4I
         VT9BYm7/PSNkmGnrWpXhlsb6My/KiAzpSqlLrynKeKpNqnkQbZx/wLYXQMEW4zIzNSkr
         wH/MAgkWjH8AAhjaYrYHXNnHM1OeloJQ+dt8UVxxnAdfxZTdXFhpfB9NNYb1Cyr06QAx
         AZyoiaLlUplH6uu6TSagyhQw+2FNpON+AdlV6XgGKXXKWaozuC2WpMMB9UqKQpKvF4jD
         e8LQ==
X-Gm-Message-State: AOAM533XUhNk+BmuyS7e3UKl0+ZbFrHtTqYWOMnz6l/J+0BEitThJ6XB
        M4X6JokVAoltyEcZ5+put1g=
X-Google-Smtp-Source: ABdhPJzHcQw6NXwzbiQcgQvYzhpVcsxMou3WjWWtCbyNYfAdOvDSYYW1ccpmo2MSyU3WBYLYNbsH/w==
X-Received: by 2002:a05:6a00:1593:b0:4f6:6c38:f75d with SMTP id u19-20020a056a00159300b004f66c38f75dmr394165pfk.81.1646254092559;
        Wed, 02 Mar 2022 12:48:12 -0800 (PST)
Received: from localhost.localdomain ([103.161.98.179])
        by smtp.gmail.com with ESMTPSA id bh11-20020a056a00308b00b004f40144cf76sm50905pfb.142.2022.03.02.12.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:48:12 -0800 (PST)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH 03/16] staging: r8188eu: mark rtw_is_desired_network as bool
Date:   Thu,  3 Mar 2022 02:17:24 +0530
Message-Id: <20220302204737.49056-4-makvihas@gmail.com>
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

Mark rtw_is_desired_network as bool as it returns true/false.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 4bb6edcc0..8d36ab955 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -571,7 +571,7 @@ static void rtw_add_network(struct adapter *adapter,
 /* 			(3) WMM */
 /*			(4) HT */
 /*			(5) others */
-static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
+static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
 {
 	struct security_priv *psecuritypriv = &adapter->securitypriv;
 	struct mlme_priv *pmlmepriv = &adapter->mlmepriv;
-- 
2.30.2

