Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0244B7C40
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245372AbiBPBIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:08:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245291AbiBPBHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:07:35 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1F7F5408
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so2631299wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZR7xiffqxgtLzMmjkgsmKhlDEmRIJt6j/5rXXfqzqc=;
        b=MzQU6pKbdYjhGMR5xX9JhVNIBD8aTFsewyGNpdcZluPVvFsy10wGYkX65jPCc9SM8r
         0dWyBSjCPFxNOEP0TDZIT5MYr+6y7XpJsYiSWZT1Nvd+tKxl8wy8H5HGjuXOHRzuq3lH
         XLAfvrvhqey2GfFz2LAP+UGgKvI3q4cqZjaFqEZdQSC+XKGEi1b5W1xhTNEhb6jx9mni
         jaSGfx7srSIFgDMVPQS44/KsBK7+4UtLCMy3AD5ORfKjzpeFFZAbrULghtfgkPWiOe6A
         JWTHafIednFjk+ZQ5hdeFnJTTL6v6joGTeYKazbaVPDQ4r8JnaBjdRAzZ5qHKc/Jqqcd
         pPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZR7xiffqxgtLzMmjkgsmKhlDEmRIJt6j/5rXXfqzqc=;
        b=q2rdSsURq9zeH9bSWdkYI6ct8avJLpPuzo4wdagVcNoLel3qqyu23t03OW/4+ZF6Gc
         IQHdFohGSSEEx8qTHKMjGK2Vc90xBbtU1W6Wyd/WfNEYjeNXKpE0Ji/C6eHWP9e5y9EL
         fRaaFfcIaIcGnLVQeF6FzTIiSDOwJRk4KN48JJsDhMElPy2JPLKFOU9HWwMLrv2sLQ2E
         utfTkzDDUNCyDMLXOCsqotudFEyHxLcWElgAROggo4JPUmE6Xam6HVENXEtV/v/erRLU
         QdKrshnxv5FzAMD0XRWOwhy/j76Km585cIPUzmjJo3fG/m8EUJAPp1K2I8do4CpVz2Vx
         +3JA==
X-Gm-Message-State: AOAM530icLkNn0ZMEn+rql9vFURyL+o9S+5JlgNJwoVWwRAZIfTi7EJO
        dFWc6Lv0ArepsJeBDPhwyKBPCa3GTHAPQ6Is
X-Google-Smtp-Source: ABdhPJxmCJIH9VYS3CAtmMfl4vXT3uX8buc5qpeZc6N11Y3rMnhu8g4CtvaQDpMEZEdnz9JJXbgYAw==
X-Received: by 2002:a05:600c:4e8a:b0:37d:1bcf:de22 with SMTP id f10-20020a05600c4e8a00b0037d1bcfde22mr4978082wmq.195.1644973642551;
        Tue, 15 Feb 2022 17:07:22 -0800 (PST)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id m8sm10551185wms.4.2022.02.15.17.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:07:22 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH v2 13/15] staging: r8188eu: remove rtw_sctx_chk_waring_status function
Date:   Wed, 16 Feb 2022 01:07:07 +0000
Message-Id: <20220216010709.791-14-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220216010709.791-1-phil@philpotter.co.uk>
References: <20220216010709.791-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the rtw_sctx_chk_waring_status function from core/rtw_amit.c,
as it has only one caller which is unnecessary.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 0b87ce342bfb..c2a550e7250e 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -2125,25 +2125,9 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	return ret;
 }
 
-static bool rtw_sctx_chk_waring_status(int status)
-{
-	switch (status) {
-	case RTW_SCTX_DONE_UNKNOWN:
-	case RTW_SCTX_DONE_BUF_ALLOC:
-	case RTW_SCTX_DONE_BUF_FREE:
-
-	case RTW_SCTX_DONE_DRV_STOP:
-	case RTW_SCTX_DONE_DEV_REMOVE:
-		return true;
-	default:
-		return false;
-	}
-}
-
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		rtw_sctx_chk_waring_status(status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
-- 
2.34.1

