Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD648CD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357819AbiALUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:54:47 -0500
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:52257 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344755AbiALUyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:54:39 -0500
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20CGT6JW010893;
        Wed, 12 Jan 2022 15:54:26 -0500
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2053.outbound.protection.outlook.com [104.47.61.53])
        by mx0c-0054df01.pphosted.com (PPS) with ESMTPS id 3dj2j2g5e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 15:54:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpPrVEjc5Euice7Gq2TU+p/1VlH/Lqh2vquCZS2Oq6VBrWrxCeWxXaOy2u/JGpbpuDOMw6DHgG3WevwFtLFTYMZUVUhRgJLAVg0iytlbvuG1MQOLLhNJXva0LTUfbFHEp47lCM4BX5exTpakGsDCMLgxHsmEeM3dkifpQeR+vrMkjBvQnJqEzXeVkrFsZQrm0q+zQpDcXPOJhMtjBIcZ/AHzJ5TR2qhpnM3TLfZgTPLFU9nWZpmnbkrO/vw8+GVxLM66JVuDplAEmw/g3DsbEroS6GyL0LCBU4QMU+mXBXNx2VvZNejYqIRagizwa6fr3ktOB/SdLe0dAqLTmUNZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAQot4PV6vPhDigwCx6tOPPhc2i52XJueTvKeqE65xU=;
 b=dNYuD7tNnjFINfOCxXIzTSFTUGUufHGHntRjCHxJaWcHqcaQO0tKKovfSVQGPheswYEpaiUID7SKzZ+rNaEAxQyDYx8WDmL5AfnZQjh/xqfsP8x7zKHQCENI7IXUT4IgR8UX6BMjbOqLLuZbqDLtrqcfSxW994R5hfxJEmycy+acoeFMl/t4IfByLdvFTWiPnGolDiheigzbv+8+7uSBd4WntP+wZdLb/IC/P98YQHRmzQdlTLJB4TiY3zYuGcSfGfHxH8kXOCQp/KRKiSd7+1Iw+En+gZcYFsK0dTdQzoaU3I1I1o7m0SL8TH8jHUzblcdreFb+rdl1bocADpP4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAQot4PV6vPhDigwCx6tOPPhc2i52XJueTvKeqE65xU=;
 b=u7HjAdCSwjsXb6Aqdn8EyalCoI9d4byopIB/syPSfKL7rV7aDUEwz2FxyJI9yd6xN9Q391gTZ+yCzjhnTRMLOrhsUIBOB9GW9f8achlEKPzmEKEMCKS6uroI7a3GmaBaAr62rlEc7y+mhsrbfFK5WHD/ecjMb0uBQLQsCrZ51wc=
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:6a::19)
 by YT3PR01MB5666.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:66::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 20:54:24 +0000
Received: from YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8]) by YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6929:c39f:d893:b6c8%2]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 20:54:24 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, rasm@fe.up.pt,
        jamesnuss@nanometrics.ca, akpm@linux-foundation.org,
        Robert Hancock <robert.hancock@calian.com>
Subject: [PATCH] pps: clients: gpio: Propagate return value from pps_gpio_probe
Date:   Wed, 12 Jan 2022 14:52:14 -0600
Message-Id: <20220112205214.2060954-1-robert.hancock@calian.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0117.namprd04.prod.outlook.com
 (2603:10b6:104:7::19) To YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:6a::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa63faf4-6ed1-42ca-0235-08d9d60db706
X-MS-TrafficTypeDiagnostic: YT3PR01MB5666:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB566637B7074B80C350803612EC529@YT3PR01MB5666.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHCB9xG2evP5kIdGDA6pSNNUw5hDeSoGdEojSSIEF6JaQQ/XGoEDZoe6jFNozSQK+zcPeIY3VaId99ylFoNc62TQ+Gj82QVwcdP4lMfHdQMM+bdHW1RIQwBTmT4svX9VOkg7ts10RVhYgQrmffSmNNpvep2T2FY1aVwPxLfHxcNBUemenXP0le7j1WF/e4LZbZGfeu+9ynUAF1X2mVeOI4hj7LXsGJdXeUDJ8c9Dy3FqzeUh9ji6W6Fu3UH0JlFUtT4oAJpEwgjsZXrHbBntrykVhUNHg2MGBepsAV14ipv3j6Z5MlwDZp6VaDzdxZ3Y3EG5a8HP/vWlIu/SGkQXK+0stu+9aoWBg6gt4Rvuwbv06NNcGEjtcdZZjHEpTxzK4ct47fgtq44eTwBkL8YPhWUw+7jtUm+m5wBTAn80DNdzhAUuBy72PnuBOHCaQG7Sml+vuUU7gdf3BI6gKrHZ0S5B+OM2iz/21F7okuavJin7XH7DybM22441x8I/v5la93dHlTzYjNrSD5U5AyZ1eArEh7HBKpDKArinETEkmxjtMc1NFx5pVXI+mVctNFvGOH3RT69kYBZxr/VBYbIJa3gbDub5WRm9p06CrobbdX/YUvL6s0d/lLKpV2LrG1R9cxHEhWnm+3jTef+xz4QbqpX7F7Uvq3UBDBSA3CVsNj1/y9NR86u4xYSh7MgCkSVrkqVs0g8DIY1dboomx7zqDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(36756003)(316002)(44832011)(86362001)(2616005)(2906002)(6916009)(186003)(66946007)(38350700002)(38100700002)(66556008)(107886003)(6486002)(508600001)(6512007)(4744005)(26005)(4326008)(5660300002)(6506007)(6666004)(1076003)(52116002)(8676002)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNxREGgbyKtMDlkJ3GyT5pmCJVbyTN1kVFtdYqDjJkqmRiHc5YjroEIYJ28A?=
 =?us-ascii?Q?uzVC3jIU3JXAfU1bCF+A8GIgMOfhIHu0uGfkleBBAKpcjPXoQITvh74CeaaI?=
 =?us-ascii?Q?nqn3IT1a3uRqxNVBrZcXLhxsC6XKG6LS05XHOWdYC9LDk9f7d3x1cwhL9wjZ?=
 =?us-ascii?Q?2GMV9jW4ZLQ9r950TtITD25Vyvk4gHztudecMJ1WmncN4pSVOlTfvInClJaw?=
 =?us-ascii?Q?GOK7uLpprz8PqjPEwbHbcgZy9vFHv1yhQp8qYAi0uR4YrQPLs/M9G13eHjk0?=
 =?us-ascii?Q?DZajFMbA3whPmqzcX5oDZUHN3y6FQFFAx4CdfjLvEGHF+oGxcFv8T+AGJXqk?=
 =?us-ascii?Q?5kc20DSuUku2tLnfXaaPVqJZAXjAkesGbEU+bPy48DyteclhWKwfSx//inYG?=
 =?us-ascii?Q?8ucry+Ukj6CnggdhfDEyN9nrrq17kDPaYaPPTnIjxTbj4RC2FIEEgkvHeYRJ?=
 =?us-ascii?Q?B52fHYemobcK0Zae/n/tuNMS17kWcXgCjdkbKzbwALms2tZ+RhAuHUJv5Gzv?=
 =?us-ascii?Q?YAuZPtp9HaBqsw/hvFF0pwznB6eNRZq6rRfA8pLFGlkIuH4w3EnRKNirNRcq?=
 =?us-ascii?Q?klYfuvwK7a2OoUONxTZoYDyTlG0QK5YtmrVRweXkqvlejht6onNSTHlJo+CA?=
 =?us-ascii?Q?vTHY9xTydKf9R/HpyNXwUo5Rl9+aP6y/gb9rAUqAjBtW5oSu3cr6xmY8rj7b?=
 =?us-ascii?Q?CVA0qrLrWNTS7z/Pk0AL70nqlav9UPjOGSiPlOpaBiBx5nhJHeJOB79Z7BcY?=
 =?us-ascii?Q?NyQvhkuecz3qHarLLksDSTs66WOL4jeLThxtKnp6rMXfN3FMfYVjE/tMllwe?=
 =?us-ascii?Q?rWmYbbcjBMT6xbAHkBx+meW6FyszFs2nnJWvnzndx5y3VPFHJaaIA8nIPpgt?=
 =?us-ascii?Q?c4KnK9xv8wn6QMZB7t//0PVZk8IEm6Xh7y9MpL9hSLrUm68IgD46A0Wa2zgp?=
 =?us-ascii?Q?qUWggeTEFuRs5bJSSU0FZyfbDDcG25h4UHVOMD1/onE2U2TRaAnljqXj/S9o?=
 =?us-ascii?Q?FmDAfHkTBVkSrFvEuntO0/kYwD0vOQa6JncZVpKy0yKKNn8hQX9Acoh1seXx?=
 =?us-ascii?Q?J8DGT7rmAr6f+/UfUB8PsFB/TltsAo+ExnS0Te3B5Y6N+uGMqrgW9ydZB8fT?=
 =?us-ascii?Q?v+e/NQyOFOllViV+YmJJwL9/KKi8hEUj6O+rAvc9DKAueNXCNFVC1X9/qcxv?=
 =?us-ascii?Q?pzpi0qmTc9WCty+8AcKVfqneft5ao4drKTJ+m3/WHePmiQvxPFwyPJZPcHbI?=
 =?us-ascii?Q?DyXsF0ivH6dQ/xXIgUpeudqwjdG0WWvGzvG8ooAHw6opbMAotLdC2cnKR5JY?=
 =?us-ascii?Q?WcLG3t93WFKfE3aHNkrbj+jFBRsyf7m3zUuvF1ZkaWuXjpLBT83LROMBOHUG?=
 =?us-ascii?Q?F/Dcu5Cw0fR2eJreDeV06y4q9qRXtRUig+9+GDd5T3uyDI0rHmFVBN+wjc2O?=
 =?us-ascii?Q?38jFK5qLxVgc/2MNpfTjlXPosNmRlt1SMbMbG3futNtWpAklNsBApSpr3GfD?=
 =?us-ascii?Q?7aVkABytwQb756WyLj5u4PEoMm8Az63GD+7yJb4Ox9iaptFr8RsayX6xktGx?=
 =?us-ascii?Q?c3FwEPHmZazyBD3U67M86dY7oi8mcvyazCjmEnIPz8Dl77WUXuQtCOTAH0aU?=
 =?us-ascii?Q?vkAYWPXTGGMXXu6MUQ5JlyUmvTuTtBhfWi7Dz+2ZwOmG46Wu494tG0WWcO21?=
 =?us-ascii?Q?Bq0TduBEkQrhPLgSYW96HWXEYSY=3D?=
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa63faf4-6ed1-42ca-0235-08d9d60db706
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB6274.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 20:54:24.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +LE1fr2bhoYnZFawyTBg9BSZECPpm8U52r6AROVSA1F1OT4eA3YIX02ki6GYXjqIJzgHhlTjFMo3vmcCTnN4il4h+mxK29WtDwooW6lml20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB5666
X-Proofpoint-GUID: 6FUS1j35rN5uxVJ_p8xZFB9r9d1l7WTK
X-Proofpoint-ORIG-GUID: 6FUS1j35rN5uxVJ_p8xZFB9r9d1l7WTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_05,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 mlxlogscore=801
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201120123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the pps-gpio driver was probed prior to the GPIO device it uses, the
devm_gpiod_get call returned an -EPROBE_DEFER error, but pps_gpio_probe
replaced that error code with -EINVAL, causing the pps-gpio probe to
fail and not be retried later. Propagate the error return value so that
deferred probe works properly.

Fixes: 161520451dfa (pps: new client driver using GPIO)
Signed-off-by: Robert Hancock <robert.hancock@calian.com>
---
 drivers/pps/clients/pps-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pps/clients/pps-gpio.c b/drivers/pps/clients/pps-gpio.c
index 35799e6401c9..2f4b11b4dfcd 100644
--- a/drivers/pps/clients/pps-gpio.c
+++ b/drivers/pps/clients/pps-gpio.c
@@ -169,7 +169,7 @@ static int pps_gpio_probe(struct platform_device *pdev)
 	/* GPIO setup */
 	ret = pps_gpio_setup(dev);
 	if (ret)
-		return -EINVAL;
+		return ret;
 
 	/* IRQ setup */
 	ret = gpiod_to_irq(data->gpio_pin);
-- 
2.31.1

