Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8624DD70B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiCRJ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiCRJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:27:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2107.outbound.protection.outlook.com [40.107.117.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A42B5AD5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNxnSzjGqdutSzsDTPoIg/jJHKvrTdwGq4sn9jQ/zwESzlmCsTsxFLruUJOqUGK0GlYXK8cyR9H+VVafGBfAHG2VWJjeMW557a++0dJfRhiQ6MoTf3zXxLC6uHGqp2Nb2alnGt/3hx6zzQscVtYxYk6wBn/S3HVTUaBbK8vXjV7aCyNvSo4zBEKo0HqblSc0/Rs+Mvol+YQ740Z5XBycv6Eba8bcm3wbxEAxmxOB/WAI7HLEhJnQSzjIJOzUJqBYgC4KQ56jkTYYv2LJQBUibbvqg879xG8u5ymEvgsFxYYKel1MPyfURjRTTn5B59tDiguM+bAUyELewWLk52T7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esYWZXdkwMQo2u87gOmcsy5B4Ne0nTuYvbnqz1l/w4U=;
 b=ICUo/eyM0j0HtdunuTACF+5ljPIitVVhSnR5c8L3g1ePuRfa5nN+2PGtEIhnXPlG1ngv/UlKX4jD23pDwuEbZTj2yXD6BzyfYnOOTk6VbpH/GLZBpChpQmaLIN3S0Oo4ONGLmuuFlRb22Oq6OuPc2fzag8aH8I/DTjLbNpH6dYqcPlclGyp3YhqmxrQTFd8E36nlwXbCiBR0fBoG21sppKtUGICSK6OSbzrn43H1moy/ebHUPFQrPoRWkbPwyeQVxmPcdRiruBpB1vd9PasN5mAuahGb9K7XbBCgaxjk4vXIwm4mGfWet0yz4CGMU13+XlpmtgXRGZjOwPLShFjhEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esYWZXdkwMQo2u87gOmcsy5B4Ne0nTuYvbnqz1l/w4U=;
 b=OPuUnuMewXnXWIxuaxMS0U24WzmWcGJk3yGl7YeewVtMEGQA67ZWWIQ5Gmq60l+stzQYwReOcf35J0EGZK0CK9f/solgft6v238tvHxOrLp0iDowRzWhtUx6eAqwVxAenPcNin4SWk1M0QelY+YIai+zLaIVuxWA9l4ndKCqvMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PSAPR06MB4103.apcprd06.prod.outlook.com (2603:1096:301:30::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 09:25:45 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 09:25:44 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Abdun Nihaal <abdun.nihaal@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] staging: r8188eu: remove unnecessary memset in r8188eu
Date:   Fri, 18 Mar 2022 17:24:48 +0800
Message-Id: <20220318092459.519225-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18485dbf-6bdd-4dea-3c1f-08da08c14751
X-MS-TrafficTypeDiagnostic: PSAPR06MB4103:EE_
X-Microsoft-Antispam-PRVS: <PSAPR06MB4103CC95759ACE97B08E3451AB139@PSAPR06MB4103.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ELltat1Sq2rLTQoBFzw7OoSk44jShcMJvrr9imjkVv1Jum7eDq4Xz3zMzR2yOFXok4Jul8yGd1qHupsCUCgMehOl+jtu6WTTEqHl6Vb7C33Z6BkOTnkWMpKbJUbUTgPhHq6Bzsaltlf5cb6byFWu99yejbgZk4diKhjG8RcQqyMgvegIGRnERy7WCZFX7Uze8q0CXIgib1iAmdNldm64KagthaEzU7K5AYuNswfDMnAs+7wPIyJEQulqv6amTklTLt7DNccjezzGuHPH8KY73Fv98Ph+x8Vz+e6u4iY8PgsaVno1jBqES9Iz/JbHTSrTd1LaZ+S6il1j+qwjdPBGrobXRNhjjzsiBG5x8w2mMM1Z0XgGLDMiBOLuLGPylOXAQJSumEmwIAEk1RzXTgr4D8OhDiEnqNC2abYbL5lgZfY3qnq225w/JZNAR74cIDqFZrzynLAGl8W3ua7rPKGc4PFSAydNj9KP9S3aqLwHRDQ0qlhsYgyh0D8fukDbHkugsZ0iREqepvqwLMseYcKr+4YMNl80pe1X6641KIYlDE4ht+On52Ap7+NZqPx/9rJx7W8FeHwhCbmHXqwchIN0hXzhO5TNYwQER1Jhwy3N9omAn3EccSAd2xC+i2kk9Qgrgdua9vhED4wnQkRgHj1rIraYkdhgfJr5Q1AKTr57iT5KER3D8yEl2Vc42VT0ztNz6zV/rwFSLEoBeoKbcTPMSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(316002)(110136005)(2906002)(6486002)(186003)(52116002)(8936002)(6512007)(36756003)(5660300002)(83380400001)(66556008)(66476007)(66946007)(8676002)(107886003)(4326008)(2616005)(1076003)(38100700002)(38350700002)(6506007)(508600001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cESWKf1MTfHycpBbqhAxE5S9ihGas9VwOEKzED4loTk3Fgml7fhomLT88U3A?=
 =?us-ascii?Q?PztwQiYRD0eg8Wt1ZmLMEtTUEJ1jEmu/Py2o5xgcmxoVRCf8cWNQrNLRuYIE?=
 =?us-ascii?Q?NnmlSinHSMuUdlfJaRH4Ha7whZIqQXovBP+EzmbLpcW+4DLjDx3PJcX/FDNs?=
 =?us-ascii?Q?PqGF6svRYPEDemB6AQ8poapxqE47p9bXGgrucubCjE2MLYH43l4l/ucYDBLl?=
 =?us-ascii?Q?z2o0J/BosgNicW6W46fGNyvGz+pcdy3kphaokCw+W2VZACobMBVrmCyX60A4?=
 =?us-ascii?Q?+YwoUQ+M8u55CSI1YJ1MuB3jbr2/Mjll6UxdvC0Xx2Ca2+pfUV2JsgUr7WAx?=
 =?us-ascii?Q?8/+KsgaMPV75PsGmVF78Gy7UMBSNhNM+w6l4RT/DCCYFygrsBjMNIyNa9W+K?=
 =?us-ascii?Q?/p/YnTaZfsFihfNBkP+UHgpkP/QeIrYgKbgFAypfCZrz1M+Ft+4QBw5s32wu?=
 =?us-ascii?Q?89d8iZE0H90gU/xHbN4nYJ0NAJ+DUvdwrYBDxq7hwnfMe5DBudk1UGLi7boG?=
 =?us-ascii?Q?BPLejS3G+5uH8rNIFQaTeTLlJOS7Q/SXPi2gFfzmXbxScPMDohkDN1YyJbkh?=
 =?us-ascii?Q?uLTfCiirClkDGp8i8kLKP4zM9ScdTnm9kYi9H8HIEF7VhalAzotXRe74wcuA?=
 =?us-ascii?Q?9Et+0AdX/tp9k2KfrJ3C2BFEjU8fwOlxI+muARxQ57zUw7lBMN1Cx7qr70pL?=
 =?us-ascii?Q?1J1U7RBy5gFN198qlT+jjSdWQNVq2/O8CN3DxNhU85AN86zULi2wHtb+yj8t?=
 =?us-ascii?Q?7IfOJPu155Gk3wuLycky9lcC8rNCUzlA82gEKRElaPm6/RrKLp5GSUXKGiWy?=
 =?us-ascii?Q?oHN+sBKuVRXal2dHJo8FCihA6cnXrxbOAFUp++/rskJbikBuH86xTXNgWsed?=
 =?us-ascii?Q?ZLwKSPAjXF78MV4Oz7tvLdqOmAJ52hb3DZIK6QV7/FgI15h07XScCVfIDUCG?=
 =?us-ascii?Q?d42AaSdqQtFDpp5iVps6lbzYYPAKbHOlnp35kD56f3nOzA0Nj2/pzEnVR5xI?=
 =?us-ascii?Q?JmmtD8Bo+d3C/sgmLeWgKnRlcTMeG8C3/n3vDFOw0QS1gdSnOHYexGf5umi9?=
 =?us-ascii?Q?2FUgmteWbhhL2/zshkLMhSr3VJ0lunWTQldPRU6G2muBWOKmQd95Ier4ZTgJ?=
 =?us-ascii?Q?4RMzkq4Tn5XchfeVdWErdkVN2fcCo2TSvSQMGMxX15ppptvgdo//+ASRBEMX?=
 =?us-ascii?Q?MTDzGeP+tGqN/ylyvZFOZJF2J0D621OTuoiqX0hB3//6E3BkXuKbhuzLMI65?=
 =?us-ascii?Q?3hvcV91Wzd/k/FnJ7EaOnuUi3VFxUhrjl58uanpZG3srpwSK/L5JBY45Ml0I?=
 =?us-ascii?Q?v/G6N6pleU29JiCPAfLx+KxZx+oZhuxnCXjxUNmj/7gqqkTSaPOWif/6pmv0?=
 =?us-ascii?Q?17h0mxiNvzbxEsEGI/+NVx8M9dCnGfAkvg40SU+x3cIlyZXVeQT/km26BGBx?=
 =?us-ascii?Q?rx7C+LcC7MaSsBDwkhLdPNgpPA97REAr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18485dbf-6bdd-4dea-3c1f-08da08c14751
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 09:25:44.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bdgu1UJsSSnVKV5xRZi7UEBnLQrkJIvBJlo+EAT8JpOJewnW8MhQ6hqVdYaACXp+dG/V+QS+Qjpv0BIMi7CuuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4103
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

psetauthparm and precvpriv->pallocated_recv_buf are allocated by kzalloc().
It is unnecessary to call memset again.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c      | 1 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 8d36ab955b96..6f0bff186477 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1521,7 +1521,6 @@ int rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 		res = _FAIL;
 		goto exit;
 	}
-	memset(psetauthparm, 0, sizeof(struct setauth_parm));
 	psetauthparm->mode = (unsigned char)psecuritypriv->dot11AuthAlgrthm;
 	pcmd->cmdcode = _SetAuth_CMD_;
 	pcmd->parmbuf = (unsigned char *)psetauthparm;
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 322b4549a92d..727e1adce1dc 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -31,7 +31,6 @@ int	rtl8188eu_init_recv_priv(struct adapter *padapter)
 		res = _FAIL;
 		goto exit;
 	}
-	memset(precvpriv->pallocated_recv_buf, 0, NR_RECVBUFF * sizeof(struct recv_buf) + 4);
 
 	precvpriv->precv_buf = (u8 *)N_BYTE_ALIGMENT((size_t)(precvpriv->pallocated_recv_buf), 4);
 
-- 
2.35.1

