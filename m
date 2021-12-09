Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB7F46E13F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbhLIDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:25:12 -0500
Received: from mail-eopbgr1300112.outbound.protection.outlook.com ([40.107.130.112]:6123
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229601AbhLIDZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:25:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRSgwpaOlCFSrq2iwh3NHsArSZyuXTWIyvrvPPn3l7sIeJaIvsWHWXhi9Or4bUQmE0OIODBOgs9AY8go5pTTvSZ/AEN1QEv2U0sj+5JLbjxOJMJtGygQ8N1RvlbsK0yDV8NhjNkCa/44qC8W+7xOMHarxRjs5fS8a9I4+73msd481VH7fOCUCob2nzkrhVWcjC2JDXRSnZcDc9Nnlzj3kVF1pkIWbzaEG6ihzU8kHq/yhjXjAk+I/2QWe70VhmrR5HgmIB3CAV5UReTBGptU98YX7ih5DYB9HS1ctvIjA6C84WMKl8sVfSvAKHUai8OSZwAxZLjP2dQlFRgn8XiTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd5BMxfJTGZNlZrXgp+uh/YYRXUtwG/9b+9LZ6sr8Y4=;
 b=N9h5u9IRFY/QPIdbxQ28Zf0TQm6ek9s7Q3XdNOJbD/jgdWaMAQ2Q7Wye4OFwHxiRqzDK13/OLivM8W0Je3dOIQLu4RH37RixCauTGrC6DwTW+QA5dKqOPbQIFbqdbROAPx1poqs1WryncODHBapjbnyfPE1zTB5lCQWf2SztgZg+pn73TGD0KZoBU0YCP029tkBEZN2GmPv9/GLyuPYaMYwEj0qeAW6IuBPzHK7q0XAl1dSzlAmGITEJgCE1hL5sEKbm/IhBKSKrhy2MUC2fAInYpjVIrpwl61WzlSN+itBVCLSPIfeHFtZPEBZoVcmtz7w6bIEsuOvWWgF1ea1tWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd5BMxfJTGZNlZrXgp+uh/YYRXUtwG/9b+9LZ6sr8Y4=;
 b=Q4D7fQtIO4a8dDas8k1tZeokAjfpqCvQvQIh4/zmcBcJW3LJsTGGAbtpNkVUGcMyzNj3YBrf5GBcrgUR8RdUBC5EQvElcLwoPlRS54UlxYqin3QeMiWEtmCrXnQkrP4oXbYDyYC/TbgzyoWqcj+q4IAVk4hoerh/nNF5lmghQAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by HK0PR06MB3140.apcprd06.prod.outlook.com (2603:1096:203:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 03:21:34 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::8986:b885:90d7:5e61%3]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 03:21:34 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Cc:     kernel@vivo.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] phy: qcom: use struct_size instead of sizeof
Date:   Thu,  9 Dec 2021 11:21:14 +0800
Message-Id: <20211209032114.9416-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211207131642.5313-1-guozhengkui@vivo.com>
References: <20211207131642.5313-1-guozhengkui@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
Received: from guozhengkui.debian (218.213.202.190) by HK2PR02CA0156.apcprd02.prod.outlook.com (2603:1096:201:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 03:21:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c9f8157-1673-4c86-ebb4-08d9bac3006f
X-MS-TrafficTypeDiagnostic: HK0PR06MB3140:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB314072C05AA4F71C15C91102C7709@HK0PR06MB3140.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQKgswVhEYipuChMpVBkrqtSX1y5BZPTJRI9niEPv4Oip5h+p4w6GzQ6uXV6fkhFo+SlmclmErTMB1ZZzsfU5L+0wVG9LoHbRGBL9vy1Z4bepgIUZfd/ZVxxrPIMgn7yolSDTO8+ULlcL3I46XDfKzQ+RQHwWu72/5q9FNkSEL7fZ/REjc/wVByUxWuz5thFWeO8kCUGhDlzvjvNkirjgLmQIaBkRKezkK5XKCXuOldRmlzUZoXYefVOawHPdCH7B4rNhFDX4Lyg3Sv8ezh1aQ2LC+IHQ/QkNVwyMizBC/9dRv5JOb4usP0M5bgtAQBDI+gTl/u213SQNxalCREy7NwiMwZBKHNQ3NeWA9bWnDsTtVKEBDHtxr++tKQsFEgSLBYd3nNyFnHieNB0S4tXGlvyjvQF4DjnpTBkzHiYtO6tzBri7z9lgUlN3u+/9xYyjOfk6+qY6shHjjIwXhHnigu6jotpdDPwMyoP/eQrWK1b3GWSCxaSsRYwxlhOjUcUTBgywpInwaBuTrBMuUvyld8ZOkfkEd5c1ZNK7hQAHC24skVtVfF94dgTAxuGEJOcl1HLMML8m3fVYakcJnZNGmdP6yRsR9KP9VOkFxA/XkBLXy0rcNx4LbrFYxRiUVe/8JcahfhXEqaNW05Td3HkUWr1wznTo4kij/B4LiKgW59uMnNTvnLsKkRMJ2ucQVRedpgjo8BP2Dg1DAW60CGvUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(1076003)(107886003)(8936002)(2906002)(110136005)(83380400001)(52116002)(4326008)(6486002)(6512007)(5660300002)(6666004)(38350700002)(38100700002)(36756003)(508600001)(956004)(26005)(2616005)(6506007)(186003)(8676002)(4744005)(66476007)(66556008)(66946007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q8jdjIr7uCzVFSO3HkVObuye5Y67pnr5PX/7iv1/8V/qnw9rh5BrKBOMCY0I?=
 =?us-ascii?Q?tzNONvn2MBRkATCEAOBZ4EjwPcw4czZJR1iCUBs19Oez+t+NIElqoBn5aIYY?=
 =?us-ascii?Q?ZEuVvikrvlG6gh/ldL5K8dFeo4ik5Vce5d9XnoYwwkTNiJHluOOrs/reRTcW?=
 =?us-ascii?Q?GsX1OVtfeXNJK2YepN6o2+77IecaGVA4fs6N6TDGtkHSh5ebTGvWn9m9yFU+?=
 =?us-ascii?Q?iQJ96dl2ptHSZYciFd6PU1C9mU+Oj8nE9ZtC4axEPWJRM98fYOWFUtduUWWk?=
 =?us-ascii?Q?CwFi+CFt0WgsnvG1McWYVpEoMsi2Fak6xhQejAbdkrbSF7oGIJDXLxqUTHpM?=
 =?us-ascii?Q?K6jMtkOGSHClwj9fUIdozqAUu7KzMItcNoc2+JgJA3IKPPzkL4zAc+uocnQx?=
 =?us-ascii?Q?WS31RP90+8DgYeGHAiOVA5QzqP5RzOIw1Dx5QAjt8eJngwMWcGX7hC9p8XK8?=
 =?us-ascii?Q?Gl/2722l9DHB4Ipjr0HmHzjwnIuuNtVHXbvdtYs/C7cRzQqskQcblywZxQ2R?=
 =?us-ascii?Q?Jd9khpMtoARo6LhuQfty30JNpj37D4CLTFvAHJfhjsHOZe1EzGkFbHCRbX8F?=
 =?us-ascii?Q?fSjlmXWKvSFiFq/6JwoUgRc7eh4GO+lzEhYU+h/qqFuN4R0f+ikdsOyk2wmP?=
 =?us-ascii?Q?NG1pI8po/NDl5T0zkQ7cSSE4INrVAO/KGo52H1KNkWnJDPwJngp9Kt4wXK1t?=
 =?us-ascii?Q?w4BRsQ/fkSaxXclqYGbjBlP03Pu8Rbm6lHX0Zz9v5HgRcRYEvcvsu7/gBbPs?=
 =?us-ascii?Q?hSWuKCljkdt0qDiDLkjUCdTodfwYlsEbStS7ACt03ZHLdRkN4aEhZ8EMpbeP?=
 =?us-ascii?Q?NCd87pA8LZfmvBMAPNCmlyccqmk2Y+ext3tl5KdZ+9k6aONjsmby+P2g+Tbu?=
 =?us-ascii?Q?0xNpDz4vv+fT8at3u62/O75ydGkaFgdIkLAQ/kHW0r6Riyeza2oAyb1MFAlV?=
 =?us-ascii?Q?M9wPhvsof1qOsCR/8kfsA13RnpPwPijrrewsoKAg3sNm2MDesCthkaVa5VAp?=
 =?us-ascii?Q?XXCDZQOffTwKcCPqCCI79Pg8QYOI6hpPRNFh8OK1FLPE+f95cD/xqQ2NETGl?=
 =?us-ascii?Q?ss7TAvVdhyl/XBfNcwB5e9sizEFHs3QBpGWgMWhF0LgsgEpUgg960zx5qRFx?=
 =?us-ascii?Q?92bXZ+eD+Gb5YVxzt3HI0OQ05JKQ79tvFZ5CLsCZE0EnRZA+wsp4TWKinf9T?=
 =?us-ascii?Q?nxSSmjK/6YfDk4aaE3yGZWFHdvhVl/2CCI0nePV1T69hY2lPBbqqxlcp4q3s?=
 =?us-ascii?Q?ln5dAlGQdIAf5ps0Y6j0SHu5RSGLi/KpBk8U0CwM8T6zTw7e992y3w+Awje1?=
 =?us-ascii?Q?LRtoAPpUtH01hCYQBMy+LonpXBRXDDE7d+Rk4hlrd9jEsJqjASFXrlew3W5L?=
 =?us-ascii?Q?OEd6rnenqStaave51q3jPGz5GI0RRAYYhU0jukZ9hNNR5t19lGopN4gWQlfd?=
 =?us-ascii?Q?wXkb8KKBaXgtW43VbpJY+ZVYnZshpM5/+bdZ+PZnWMMpYgW7okoIqQxM4+kQ?=
 =?us-ascii?Q?A3yFForndLUSVtXkGxkPw6rQm5faOuNzSiTSvWGmrPL5inRwNfQ4yubLiIp0?=
 =?us-ascii?Q?KBAgc4YoX8WZV5O5N+ohZJ0lL8PPYNOwJQHv2uvgyKDapsLuoZPPh4Y4AStE?=
 =?us-ascii?Q?FcYz3WqYH9fkv+B6mjqmBuM=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9f8157-1673-4c86-ebb4-08d9bac3006f
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 03:21:34.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v1BR7oZR37Z6AImAQbK4QUpaA4lJVOlRRXHXaFlTLDCyMun0xxDW/eLVLJc52xvy2qBDO63ojp0o+Pyo8QLniA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct_size() to get the accurate size of `clk_hw_onecell_data`
with a variable size array, instead of sizeof(data) to get the size
of a pointer.

Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 17d5653b661d..a8ecd2e8442d 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -571,7 +571,7 @@ static int qcom_edp_clks_register(struct qcom_edp *edp, struct device_node *np)
 	struct clk_init_data init = { };
 	int ret;
 
-	data = devm_kzalloc(edp->dev, sizeof(data), GFP_KERNEL);
+	data = devm_kzalloc(edp->dev, struct_size(data, hws, 2), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.20.1

