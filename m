Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53EC50BC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376874AbiDVQGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbiDVQGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:06:08 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08olkn2031.outbound.protection.outlook.com [40.92.45.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706215E14E;
        Fri, 22 Apr 2022 09:03:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6zEpgCm1ylcPqpac2EJIzgli5fKI7x7ml+Mab/9r/NdhJ1LzXg2Wr4DyGfHkM9M3JbDRbwO/G9pSnYjENQpsAFiJqmUxmvgVP4w0X7qkX99dw9Ya0dQZjZSnVaZBGZWmyvc6ioAfetJvGY8yO/KRIxAZKpkIXaMvwHTe5DwFM71tIkWldDPUe/LlESSk5pCHec9OcWnlrcGyBHGbJj0/o5kCM9VzpAy/74VnrQ9bDiKXkZRA+ZYpLZNZ84rJpVXKgJqE2z9aMV06n3CgVlesxyYVj3loA8xaGQdsdH/mKyVdVJloJDXmln/rRncYxuwtEi9uyPLNPlix6lX6t8q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dmRmvkTqQATY1SddI7aH8HC55MQHwYxtVFfi+Ezz6w=;
 b=GNxXECybP0X8nzcoUoE2fWMZg/1Uhm0YK3oAxL50JOPwI5Eka8XwB4rh6spXMLaM5rFBoaKTjZkxseKvFFzz0oNJ8aMRSDZl6VOKfla7sYWHh6IMyVBENsZFttI+1kynCx4U9RtAQ5Kwr4txi5H/YCmvjLPqNLTSj4FoE96cZQa20PP9c/IoFXWoseCqxABgz5t7KAjuO/z7pQDaksMjRcanW6r0vC+tD4X0yrxl6igKyW24mI7xXk9V/wSa7xkNw05fAivbqfdj7qyUu39/uvR4W7asN9id3/nA3ncNxs7Ui0AJhOOkjTWPVlO5LkqtMPX4HpZSvx+0qseO0ZLcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dmRmvkTqQATY1SddI7aH8HC55MQHwYxtVFfi+Ezz6w=;
 b=nCkHETPswnFbql+xCBMfHTH+g0JeuLCr/9KNsR8VatLoTogqFcScPIFRqpP9NTehsFkVE3GWTgCWfN5PaXnL9ot/0+GrmFeVWs3D8ty8FovB/2w7AgcXx3ERHC9ykZ/8Piu5Y7xigMiuf64N4mSCqpTyIoPoX/xuof6odzxT7unR/8L/XZ3cr/dsfIL91AlhHeOiNr3xyKx+oOca35KqAAY1zK9lDoeSEs9I8F46rQFEf/oagST6YdH9jD3xYmlyNOHkdh5aHOidX1wuFGc4xuhqCOevcH+KioImJUZo9yqLJSqDPdr4f06OSLLhG0DwmuSfxbhl08FwZQXwkHzpAA==
Received: from BYAPR20MB2472.namprd20.prod.outlook.com (2603:10b6:a03:155::16)
 by MN2PR20MB3277.namprd20.prod.outlook.com (2603:10b6:208:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:03:12 +0000
Received: from BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3]) by BYAPR20MB2472.namprd20.prod.outlook.com
 ([fe80::3480:160a:eb92:d6e3%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 16:03:12 +0000
From:   icenowy@outlook.com
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <icenowy@sipeed.com>
Subject: [PATCH 3/3] Bluetooth: btrtl: allow longer config file name
Date:   Sat, 23 Apr 2022 00:02:31 +0800
Message-ID: <BYAPR20MB24725656E0878F7506E16411BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422160231.1072810-1-icenowy@outlook.com>
References: <20220422160231.1072810-1-icenowy@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [dDZm3PGpGqlaiGeCqj+byiPjhnA0yuy6]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To BYAPR20MB2472.namprd20.prod.outlook.com
 (2603:10b6:a03:155::16)
X-Microsoft-Original-Message-ID: <20220422160231.1072810-4-icenowy@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0923ec21-1c3c-4d3b-d968-08da247999d4
X-MS-TrafficTypeDiagnostic: MN2PR20MB3277:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXo+I+LO3xCfU5SG29ZbYsm2xr9B8pcQoL6YvOvWZjhX5kUoHpUGP1a5sF/QMrdG0A0bAYtX98jNrY9S5N+xhLcJ3MacQxNsPN5sV/3DUq86J+OO7qYTGPV6lI737kcZ8TDyUsRdXa4WCGmR2gqtnrXgT1aasiwfiWzrgR1O/fjIm4RcqhyiOk8jEPqpHLMsKZDc04OX/Lo8/aUkmx0y7fKtd6iTQGxz4ijQbg7UIDHp+5EJmWjMRpOAgNxCjZsinJVEn6E4G0iNDkID+FN0adOHfi6Y72kehw4TAqEXOYoqMIH9pB6GNtU35/muszPpHOyOOOy0IzNLE2TZ3AIkHQsBhUO58YX0oYhLBCpzZUAJHh/zW9H/dk9vBOHMsCFKkgLIHr4nDgUqP6WNCGdw7Tx7+uYArZUj7TbHLs1ahCxQNsstGXm9Rzs/jt/OM5BCXXo+jwsfCymY2CJOLA6X9Y2ij40eQEOWsDRGwEL+44uq8mvufMyOIYDuE4aJHRyPlAzSFjtwNhUNhpxkH++UxKR8cu5zaMBF3sOk68UKlSvh7g8hDHgfAp93Fs952YUVnNrbsf0guWtMqAGCfDHaEw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxZLuQ7BZZA+mJKg26xbB0ibbT7/oBvfKMO+A2aylbiiFuHtBwCscNLPK5Si?=
 =?us-ascii?Q?hruyIRPrwqXt9lluSi7z5OIaCclNlvTNhX4HzoAZEnQtXkXZCcL27cpycmY1?=
 =?us-ascii?Q?ll9RSmJBwqDG6ZpiqQNeIMHB/NTJzuesmTFIVPvsBvy9/m6Wn0V55piKHCxp?=
 =?us-ascii?Q?nXci1+NFll0X6mZp69JU/ujC+R+WfBw5FqKfqdZIrDXx7q+CZuzhpxkbu7yf?=
 =?us-ascii?Q?CCBnzYxqFM9EKcIBIrjs+5cNY2oTMC6RVRbwhPVSraM1FHG+9aG0aRLb0k2g?=
 =?us-ascii?Q?zU+XuAebF+HMyF68N8D4DCihoi/TTptFOXUOMSizKa3YdKdLXwRPqAIHBgty?=
 =?us-ascii?Q?DKBAs8imjleW9yWj9LZWBcUsHhn4DlJ8Cx6ss2vJdrJD1cxUQYPT5IJ76YmF?=
 =?us-ascii?Q?fsfSahaai0Sw92UCzIKMnBvHWF++V9muQL67DxRVDO/bL88orbaBAiolUj1W?=
 =?us-ascii?Q?DmrhGIB5/qRztjJBY+rSQiKR3wkB0XRd7axXSJB13KIN8MqAaNScgN0mPwfo?=
 =?us-ascii?Q?WxrEvQSf1Fd+wgVGVpTMK4oX2njoBctg/YXvFpG1gvtgdUsWzDR05q08dzZJ?=
 =?us-ascii?Q?B79dA/hosekmG2vRCH+7zvNUbxtWERYHw6GWSF0Y/98mbU0Fpgr50+FKfhxL?=
 =?us-ascii?Q?f5OKXoiNf4Qb2+lRDX+8hPuN0m4KvQLrGQpcH7hQFgqsmBljPsPmmy4Dpl7D?=
 =?us-ascii?Q?Avbm2ryM3djlDL44HXKZYZyytyxWK3R0OcXewlZNAzXTz1Uc+ZGJoZxJz9dI?=
 =?us-ascii?Q?5zRAV3h1bDjP1/sGmvh76j5dmRaLt0dS7VR7TL9nNObHDLvW82qVqZcFYnO9?=
 =?us-ascii?Q?9yj65d7Gyz6tsT2hSIVJatlRVJK2cd0kyt6XLYiP+qu+eHJLiM00mtMMsY2j?=
 =?us-ascii?Q?yLYsOcsjOYREka4BjdLMFBmhXhl6jUyajr1YBSfVXNR4mVo4nEPRQtsSoDef?=
 =?us-ascii?Q?Byg+cRyStYEXMPVeZkm7vP/AwWJGCeiv6IzEKyoJ9Udv8+oMzqtLVrxVJ8jd?=
 =?us-ascii?Q?Yk9L1xOhoAZYHB4/WyQMiGZF+B/3ICtZTn+hrpORnior9mW8pLSvgLm1xxy8?=
 =?us-ascii?Q?QhXclQFwbhaqz1551SpIt9kevmWKwaRaTdkGa0lX9lsX+k2JLCfRuDYZ4Xa0?=
 =?us-ascii?Q?n5KQJ8I408ME5vR6e/weZk83Ao4PfC3zSRdvaRo4WxL1yDnE2NmbswJ+mpor?=
 =?us-ascii?Q?ihhoT2pMENxBgfMiAm7mcja+TA3Ufgg66KgOGNAFyDwHyImMaldgd2C+0bNm?=
 =?us-ascii?Q?OLqkJvsRKh8Utr+Q6Pdz7s1PMCrvW+/mz7Du7CWsDvhBqcciq2XowWNbVSFh?=
 =?us-ascii?Q?KXZpN8HT8R4qrVVFvJY6P2heg6xaWt+LFHVqMx3tU73t8h2qgO+oBSN0yIND?=
 =?us-ascii?Q?22S1GJITjVfa/3ffHMgW0c5GIpEBTjgkIZ5Z6rEGSqDihxeriGqW8lp8m/5B?=
 =?us-ascii?Q?8fxB1EbXlbE=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0923ec21-1c3c-4d3b-d968-08da247999d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2472.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 16:03:12.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR20MB3277
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Icenowy Zheng <icenowy@sipeed.com>

As we now use board compatible as postfix on DT platform, we're going to
have long postfix strings.

Allow a longer config file name then. The value 320 is taken from
brcmfmac driver, which has a similar behavior.

Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 1f834513762b..383428977a7a 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -591,7 +591,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	struct btrtl_device_info *btrtl_dev;
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *resp;
-	char cfg_name[40];
+	char cfg_name[320];
 	u16 hci_rev, lmp_subver;
 	u8 hci_ver;
 	int ret;
-- 
2.35.1

