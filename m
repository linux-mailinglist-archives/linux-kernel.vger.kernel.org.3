Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B651EF60
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiEHTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353322AbiEHS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:28:53 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861EBC2D
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:25:02 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r192so6081798pgr.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGEwWPgAOFv3suN6nm6KEA8gpXdmMPjJNcqn8/i8d/I=;
        b=kPql0bm+gk1+YgYsHlo0ZyE8Zgdc39j/z7vVCXNE1Tc03WigZf+xdr6/JxyUs8LZnl
         cyXck4msvnCHexQIY2TfLFFQatrqP93c0yPw1G0hA0V5ceiWM5JPA+NFfgFYqGuRgqJv
         d8g/ec1hvcSlwOyrvIU1E/EixJ6e5Re75QFrMvMPAVUFJGWd4lacPRrFbMNjuvvMcE3D
         DyeGOCWehMG4c4V3HEU5GxC1wFA0b5oaAeC1s8USOGHNnYwNeQXj2oWWpuJRmSAZVGIm
         ZJDdjMeRzmJDTpaYYgppFI7LRlTXfmcZILyc+vMekb2pkTCiKE7FpK3aqeQhp4Lwqurz
         iOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yGEwWPgAOFv3suN6nm6KEA8gpXdmMPjJNcqn8/i8d/I=;
        b=kqzMYZYrZ5yLd4jWtd+Dtb5vCRCYRU3xL1rqTMMdgYOMOW7OHV/0h66VLYrfCyjKdC
         /9vdYZdgoqRiyNOVvA10gEKBpYF3wubqtNRwMntRI485WWRQURLPc8cnYSsvSthQfq4m
         GFHJH3CoBOeKULMiMqimgY3nkRufIC8c9m1Muvgh0NGzTimv1lyTvQL469N1tu7CV5vJ
         RN5BAwiBy4GvSRa9atp8IfeENQgGDimpa2hUEaVkBucS24ZY30rmhGOFtE/2FN7a1HDi
         mWK1GfS78xE8o36xROGSJ8O3W4867NMukKvyszgcwEQqPai4jzE784bUnkc4/dHbrYGH
         SFHw==
X-Gm-Message-State: AOAM533CWP0VdJgMJF2IAqPNFaffi/vO0D5zOCKYpozcIWDuk+innKHK
        ZBt6g4PpY+eFl3FVm5tfkSk=
X-Google-Smtp-Source: ABdhPJy0QzY0A2OvBHcri4IUIulvRCPLb54YMI48MHcGTQq+D+FXNhkavnPv8OITmWwAvtHnierUpg==
X-Received: by 2002:a05:6a00:181d:b0:50d:d56c:73d3 with SMTP id y29-20020a056a00181d00b0050dd56c73d3mr12613659pfa.22.1652034301383;
        Sun, 08 May 2022 11:25:01 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:26d8:8642:a5dc:edc4])
        by smtp.gmail.com with ESMTPSA id b187-20020a62cfc4000000b0050dc76281eesm6889258pfg.200.2022.05.08.11.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 11:25:01 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH] staging: r8188eu: drop redundant if check
Date:   Sun,  8 May 2022 23:54:01 +0530
Message-Id: <20220508182400.22433-1-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for ETH_P_IP is already performed in the outer if block
and inner if check is redundant. So drop the check.

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index d086812f8..9a99aa5e8 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -448,14 +448,12 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 		_rtw_pktfile_read(&pktfile, &tmp[0], 24);
 		pattrib->dhcp_pkt = 0;
 		if (pktfile.pkt_len > 282) {/* MINIMUM_DHCP_PACKET_SIZE) { */
-			if (ETH_P_IP == pattrib->ether_type) {/*  IP header */
-				if (((tmp[21] == 68) && (tmp[23] == 67)) ||
-				    ((tmp[21] == 67) && (tmp[23] == 68))) {
-					/*  68 : UDP BOOTP client */
-					/*  67 : UDP BOOTP server */
-					/*  Use low rate to send DHCP packet. */
-					pattrib->dhcp_pkt = 1;
-				}
+			if (((tmp[21] == 68) && (tmp[23] == 67)) ||
+			    ((tmp[21] == 67) && (tmp[23] == 68))) {
+				/*  68 : UDP BOOTP client */
+				/*  67 : UDP BOOTP server */
+				/*  Use low rate to send DHCP packet. */
+				pattrib->dhcp_pkt = 1;
 			}
 		}
 	}
-- 
2.30.2

