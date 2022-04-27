Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D779512056
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243654AbiD0RB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbiD0RBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:01:55 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B54F9CA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:58:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d15so2088333plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/JwM83vEyJYw4lhNwuusBWh1f+jSke6lCkPjly6Ebc=;
        b=cjLxjZ5pPM/pB7JnFzLZXYKAccowQfJbaFGPyDuax5hjiGW8t39TNg6rtkpShjEIC2
         iRsEDGwejDrW222GwsVt6E7/hz/MnB1FhiKwFYq/WAZTB0G5fpqWzXTbgVOLU95jUwo9
         V1XdeM2tBzhDz1Lw5jRcxLTi/4iKhiDorhwJApIT2fzfEBE/4PEmjHRlR/hK6pdN3Fbf
         byTeUyjzVC24F0W48i7MkUCL/a1VebVEQG/AVZ4cXq/iU2wg+LNWvkI85IahkpnrUjhm
         G+Yt3nFRy6+OfAujsvis2Gy2DVEO1lpMRDGFPXmCsbutYWOO+3TdY4A08SEksQ7NByyw
         faTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/JwM83vEyJYw4lhNwuusBWh1f+jSke6lCkPjly6Ebc=;
        b=PHT8ZybEh2qOr5aorfTWPqNU1p2RfHAqSFUGcSQjCFaPDigB59EqdV18334r8oX080
         ChXl6KP48AqlEepBjxaiiX0xkvCHbMYlrc+menpK6j+8dTCfNTRkMO5UT96C42atvnkO
         o6vaj4tjYtL3+yvZb70CqAAabT0DAx0EtBW15HZfmVu509+01fCoFGv/N/bVVHE3PsTH
         CAFoPAhAOqgHz/R/JwjmMpplWvkN/62HQYV7r8PGdic9z53YhzfLVjf0Ei1yjWF1ipId
         43GKUZLp3LMsr1OEP08NeUZ7MVOkUyb18GgAPn5+kmLd2l0fBo/6cyaVdceIO2uXn6PQ
         1oQQ==
X-Gm-Message-State: AOAM533jt/6BoQhITBGiP5Cb332v2YDxcBfDmowGMFK26nN/vqkumSPT
        lYihpTtVqRyi0sCGzvxDzII=
X-Google-Smtp-Source: ABdhPJzrsOeX9sw7o07/w+XFOTLhvPc45yPbOC5DIw81qtPrtiKqiDsXw9GVHNrIhLFVqpN37G6Hww==
X-Received: by 2002:a17:90a:d584:b0:1bc:e520:91f2 with SMTP id v4-20020a17090ad58400b001bce52091f2mr45201814pju.192.1651078721541;
        Wed, 27 Apr 2022 09:58:41 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:15:e0d6:603e:265d:6bf])
        by smtp.gmail.com with ESMTPSA id t15-20020a62d14f000000b0050d3846c538sm13050483pfl.57.2022.04.27.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 09:58:41 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2] staging: r8188eu: drop redundant check in _rtw_free_mlme_priv
Date:   Wed, 27 Apr 2022 22:27:49 +0530
Message-Id: <20220427165748.10584-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a NULL check on pmlmepriv in rtw_mlme.c:112 which makes no sense
as rtw_free_mlme_priv_ie_data() dereferences it unconditionally and it
would have already crashed at this point.
Remove this redundant check.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 v2 -> v1:
    drop the redundant check
 drivers/staging/r8188eu/core/rtw_mlme.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 080e07385..353f3eaed 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -248,9 +248,7 @@ int rtw_init_mlme_priv(struct adapter *padapter)/* struct	mlme_priv *pmlmepriv)
 void rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
-	if (pmlmepriv)
-		vfree(pmlmepriv->free_bss_buf);
+	vfree(pmlmepriv->free_bss_buf);
 }
 
 struct wlan_network *rtw_alloc_network(struct mlme_priv *pmlmepriv)
-- 
2.30.2

