Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6009B48377E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 20:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiACTTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 14:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiACTTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 14:19:32 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B733FC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 11:19:31 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m21so140719491edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 11:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYW+GlDgxuMha0v3wE5Ost5hQDPE9vGdy3lUXZcEoYs=;
        b=UKmcg+NlBTV/+iKI2Al18jKKVKcDKOPGFk22FJXo5fUFOv6vlBWY9BItsdp4eY/wdW
         AiiqNp9hLt43VaNZt6h5YX6D8saXa4Po49FYSYirxsjXUGmhs/WIcM4lApRijhNOIfnZ
         gRbsVmJuF8SyO5UoA1HttgpOU6u6XTzEoaIRnChJeNGv4vZiX6y7YOQUO3h1peuNVd+5
         B0vUh7eaW6OhiDm54U0BCrn7UB4rjib0zHlndME12lSvUzT1IeM5IFCTnhkTow0npTU5
         M2WsUQoiWwJpRe+xHHLpAVktNUXIkgp27ZCMgAx5bOw4o8XiUGxekl2jwun90NjCQ0el
         obkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYW+GlDgxuMha0v3wE5Ost5hQDPE9vGdy3lUXZcEoYs=;
        b=Xrnh4rpYCsoS+pSlusCjQwmxruqGOETttpo7rS0S2is/jI26jUcI8HmYHwiwBerGg/
         GUqFQBBCLuGth7AR7x67Utp761UZXVgdf6r4KCZZN4Hewi6mOIP1gACbQKh/e/kV1VO6
         8HnVC5A6dJhBZnSdB28F5Fd+cZ3zqNo4tiYpxZQJX5F7vAeh549OJGekfyQzaxga5hha
         VI2VALqehMxvBQRzzlvkxEryqV5EXrpWntxyuQsD3zDssSEyISBDXhAJV7qQtuuPg0ku
         j2uLbAa24ePhQ5lYluEWJ0MIXrrM9bhgtCTzTDq+r8c23lh+gz54uNR33yD84F0z7P+Q
         lcbg==
X-Gm-Message-State: AOAM533HQZjx+mvPlB/hl1G42SzsA4LfD1UKlLsevfpJz2Y/uP5NHShS
        mYGG3j2obIuoEbkjyOxryM4=
X-Google-Smtp-Source: ABdhPJzwWSH/AGoJwEhDRAnELFxBOYC3hMaJWUjKsxw0NhLterizuVlFGU2n3p4rnrKx6MbZLN7Hsg==
X-Received: by 2002:a17:907:6093:: with SMTP id ht19mr37998915ejc.286.1641237570325;
        Mon, 03 Jan 2022 11:19:30 -0800 (PST)
Received: from t470p.fritz.box (host-87-18-201-21.retail.telecomitalia.it. [87.18.201.21])
        by smtp.gmail.com with ESMTPSA id gt20sm7009614ejc.11.2022.01.03.11.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 11:19:29 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     alb3rt0.m3rciai@gmail.com, linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/56] staging: r8188eu: rename camelcase GetRetry to get_retry
Date:   Mon,  3 Jan 2022 20:01:50 +0100
Message-Id: <20220103190326.363960-16-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename camel case macro GetRetry into get_retry

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 drivers/staging/r8188eu/core/rtw_recv.c     | 2 +-
 drivers/staging/r8188eu/include/wifi.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index b033705c0578..885a6412738b 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -433,7 +433,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	ptable += index;
 
 	if (psta) {
-		if (GetRetry(pframe)) {
+		if (get_retry(pframe)) {
 			if (precv_frame->attrib.seq_num == psta->RxMgmtFrameSeqNum) {
 				/* drop the duplicate management frame */
 				DBG_88E("Drop duplicate management frame with seq_num=%d.\n", precv_frame->attrib.seq_num);
@@ -3706,7 +3706,7 @@ static s32 rtw_action_public_decache(struct recv_frame *recv_frame, s32 token)
 	u16 seq_ctrl = ((recv_frame->attrib.seq_num & 0xffff) << 4) |
 		(recv_frame->attrib.frag_num & 0xf);
 
-	if (GetRetry(frame)) {
+	if (get_retry(frame)) {
 		if (token >= 0) {
 			if ((seq_ctrl == mlmeext->action_public_rxseq) && (token == mlmeext->action_public_dialog_token)) {
 				DBG_88E(FUNC_ADPT_FMT" seq_ctrl = 0x%x, rxseq = 0x%x, token:%d\n",
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 0f87a01a39fb..ed2a563ab63c 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -975,7 +975,7 @@ static int validate_recv_data_frame(struct adapter *adapter,
 	struct security_priv	*psecuritypriv = &adapter->securitypriv;
 	int ret = _SUCCESS;
 
-	bretry = GetRetry(ptr);
+	bretry = get_retry(ptr);
 	pda = get_da(ptr);
 	psa = get_sa(ptr);
 	pbssid = get_hdr_bssid(ptr);
diff --git a/drivers/staging/r8188eu/include/wifi.h b/drivers/staging/r8188eu/include/wifi.h
index 4b124376d263..20a70cde2272 100644
--- a/drivers/staging/r8188eu/include/wifi.h
+++ b/drivers/staging/r8188eu/include/wifi.h
@@ -183,7 +183,7 @@ enum WIFI_REG_DOMAIN {
 #define clear_m_frag(pbuf)	\
 	(*(__le16 *)(pbuf) &= (~cpu_to_le16(_MORE_FRAG_)))
 
-#define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
+#define get_retry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) != 0)
 
 #define ClearRetry(pbuf)	\
 	*(__le16 *)(pbuf) &= (~cpu_to_le16(_RETRY_))
-- 
2.25.1

