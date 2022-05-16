Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D91527DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbiEPGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEPGiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:38:50 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2183.outbound.protection.outlook.com [40.92.63.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E77C31353;
        Sun, 15 May 2022 23:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKuvm8iler1qGsKRxJ100CRYmcQ62jKSoBUbOo7+g/GHL2M+zwv0zL2eaVixkLOb596ZdpN9eB0r9/7BXtMvtEDqCISdksJ7rTqUGU3Lr8tammDoWnimXN/9DuPV5Ufd/jnGhkHYce5yETh5d6iB3YxKpdt+Fwi9enR8Ti6ucl8W4wbRBpTWaXb1+XEk3qb53xntSNFM0qouuiu2u64ddg1J8ziXvYTHHBT6LacjdqWG10A3TpmKBFoESGSOSJM8wketzOEFWSlLcKlxdB1fqZ2ygkMBgiQcKkv6bzi9QZ4jFl2AJ84Zk+7kw9w+ECHfwGuKyrKf8duwUXtdbog4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvigWkKvoIq4jLaUUvWDvrqXzYAAhIgs3IXbJuA11LI=;
 b=VFOQ0uHNXKuSW7/SZNRT/SiYWwV6lbVdy3v37Xf2V/4QmfCQ6H3xjyIbsVh2hAdQWrULo9F/4FQAlUVVmkMTfeNU3xKKntst8SLRg2ICmIl49u35KHS1Q6ZN4cViXcX5u4+9tDZKhQN61v+jUzwzdpGP0UDEpYycHjkM1IemHZsHhMG0t8gOQKNU39202mPz0mpNGNZ4mJu788+cUR3ZaOOOsBuscdJ7SvlkkHa3yK2b9ZuMLxnXHz9mv5XzSWowIQMMdH8CiJsEXiJmZsvotw0ZN5+DaUKkn5P6l+luzfP6Me1Ni8GoVaYYKJkM3drpYb3REWy9AZdnBNS/RBg1/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvigWkKvoIq4jLaUUvWDvrqXzYAAhIgs3IXbJuA11LI=;
 b=qK+1jYam/nND7symaZ5q58bVvjA21CeG9lCTZwX/3BpjXDMOVIt7+7xfzBSuwLi07l9cRW9VOWfowGvN94DttlajPbbmkaaFs9MjiedCFXTO/GMutF5ARbe2oOJb2UnI1pis49fsW3odnoI1Hka2qXip3Clqr6JfLNCXH0dVtybIMIJuXchJKjSPsJ4rrFRCfW1K+9xEuREKOnIspF15rqU/tjekCUrAoCQyTSMKKQjSSWJxorH6vtw67xClBg2JQOLp1zRSTWzznMYGhvJhT0E1Cp+lYNBq1Esfz4e3rLXe5hbrtxYDRA/H/a0zZTxQxq9i+i57hIoVBrjbqM36Lw==
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:113::14)
 by SYZP282MB3252.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:169::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.17; Mon, 16 May
 2022 06:38:43 +0000
Received: from MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00]) by MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 ([fe80::702a:73df:6a57:6a00%8]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 06:38:43 +0000
From:   Yonglin Tan <yonglin.tan@outlook.com>
To:     mani@kernel.org, loic.poulain@linaro.org,
        gregkh@linuxfoundation.org, quic_hemantk@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, Yonglin Tan <yonglin.tan@outlook.com>
Subject: [PATCH v2] bus: mhi: host: Add support for Quectel EM120 FCCL.
Date:   Mon, 16 May 2022 14:38:29 +0800
Message-ID: <MEYP282MB2374837FFCB18B12BFDEDE80FDCF9@MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-TMN:  [dVkMxWN3RS1xdHUk5VZzyuXUMSWFaI/7]
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:113::14)
X-Microsoft-Original-Message-ID: <1652683109-5171-1-git-send-email-yonglin.tan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dda489bf-92ec-48bb-0db1-08da3706b895
X-MS-Exchange-SLBlob-MailProps: gjx25WM8ZNWdKAFq52I1YRrlMZv+xx8wbnqnrhAr/ueQc/sD1Kw11YDM57h9aPNeH+N+Du9xEeKChRXrSPoT17vF2EkH1olgFz6eRwuer9iCmVljqIbG8I+Ul5eJwRrTw3Zi9aPQE9wrIrxdNcg9GEHpw1a17vBJniT/I32sxUiaxJz4RvDQqY9PAra4N8FAxp/VNuTASdIl1w7flC0FoSzWFfB0ZUGMjeC+Sm/xzmMU5NO7CsfXJ99oV+iI1eDXfLY8IYWYLcc8yv+JiXZv1WjGtwOhBWzleWNYNIZaoK9iqIZrodisXv+Rav2RX26RC8TCX+OTU4m8LEgrEdvmrNUKOV7AJOjJl34PYnb/B7LEOHrohRzh0re2w+aweBr4pdGP7zBbMcwV2RDK1ERbmbInt96g8Tv/N2LOIXkyfAEB2wSEjSb60lQZfNSNrNsW5DsGFwGCSnZRxiiPIyMRXCD3Wg64KdAzRbObdBTcvGmcBizVN6MJzSpjXrnA2MeAMpNfYdV1XeCtr9jIxozcRpnJcQAEE72tH/CUYNUhmEXRimF/pQ1BQTJMcKRN+sU2awOEgaVkUgw2DmB0HZebYd9c2VFW49XBe6WktnMHwe0obdgWo96s0TewnLBeCjhFqTPjp3L9E83yUFfh+1aPzaPfDdfo6szZg9aH9e0yTdLTbvpYbDp3FmperIZ14VSHt2wR2btjkC4iPctfohtRJnK7f9vdOfnvywLJJtjguhc=
X-MS-TrafficTypeDiagnostic: SYZP282MB3252:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ow7dGGwwq+hhvkb3NN+/A9/8inpa+JaxypSVFujaTKajsZ9WPErbHZf7P18CplhX7AmrVR9KlMk0QB5i+EFZsQ+mW91YvwugzuBsApNkJw0wEwUiOUprTWADah2w0+pPK4ZSxbHbq0J4BfT0myk9GHj/dq4hRC6sp0wCVETVATmsS7nYALf536m+roJgTOm+h/ip0z/LznSLFGyeh7YlOhkOs8likTbNmUiJPnN3b7vWmllfOu+3GC+UWOXRln3SIH7FYfXydPhRJpo90ZeaR0nR6phGhYr+ZXR6596PZBUThqQgDkoTKsP7d51+WL6CXWVlGQHSZ/nLvo7x6pE1jUJ1/UFKXN9+kxujFBxzXSn55odmUpgeZDgiLvHJ4DuQiX/yHSIGzvMYaFe+JRGDnHBguc9weTEjd3A+jzgwwhT4IlUnW4f8hjaMv4fWwW8K+ibiRWU5wuxc2fbNDaPN/FKzzCFh8+YyQ4+14eNfz6ZL919Fd8EpHW+2Zv2n9X7Y163nOLt20n3Lo/xsfjvGz+781iLPBN2AteHL5pSf2CxGURIoLjrl4wtdKSkOt5ECID4F8W522KG5GyVbkbFwxQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/0OAjazJJwAxixdQTrTGpSA0G/6YL1keHshq2eJRRJ6jrgf3xH1YiXzpofSg?=
 =?us-ascii?Q?NN7wL/NXzQuMQFw85wP8tieAamEceFMd3k73bXktcoU1wq9T4atVKaoU5m+e?=
 =?us-ascii?Q?npaex+BBRj5//ZMnNG7jmo9A5npWOOifuAT4bOyPaHPUn7a5jxJTO/PiMDo/?=
 =?us-ascii?Q?ivnAr/cAihsrzjvii+8H7xSRO6HciF95XwVnahpHW//VJzZHSN2020P0cWDM?=
 =?us-ascii?Q?OZqVhE/6D56ss09ZxQqVoLEWukzktrR9H6RKiByRlGq9C8LI4JqJ6m/0yFpe?=
 =?us-ascii?Q?ft73hFCNQ83Xs+V8z/JYyF4N3M7Bkoez6y7uiYHTg2vOz3JT4Lh02vHzViKo?=
 =?us-ascii?Q?if9oOAGtgWA+kJeIj7EziE4DjwTFPm+/36twygSyPa2F9D/7UbwIvp0mMVrr?=
 =?us-ascii?Q?kHtilo+PoDsivgGed46vYKDVzqRZwCPNHlH97ko9fZBE0H364kefRA7jyfvp?=
 =?us-ascii?Q?yUD8BXOAbasqstYcWeIuY+e1CMJDAXtaB6j7cYy1UcZFkU98XlJlXFktqdVQ?=
 =?us-ascii?Q?aUx669THYGjQKHJ4BDZ/EtA1P5M4QNzmUTJFGlUt0/5t3Fn4vCe7jb434CAi?=
 =?us-ascii?Q?+XqjDeO/tmf+l27bUG3cDkJTy7k3CQ8CBJzQ2TBNhAWXxURxkuRa/RebaxnL?=
 =?us-ascii?Q?cLBvGoGmctCTsdngQqXqF3sFjOGjCux106wEe5z6lz4Pva01C0LUee5gCl47?=
 =?us-ascii?Q?Df1+/MqB6T9CvMpJGDMWPSJxhI1Q1oWG65yss697pocP0KvNHuecWQrYkZFx?=
 =?us-ascii?Q?BYpHkdd7ZPApvUWTCwBMyAzPqy8sCKFVjNqH8760RhXvi2/TkD+Qman+Y7yP?=
 =?us-ascii?Q?buWNSzsMTbqrzaGpCmz57hoIFZ5zx2lYV/F5t+miBmTEqNDpdQspwCnc0YVX?=
 =?us-ascii?Q?43sUcFqI1IweFENtjeZkLV3tuxg2hF19E2l8ag1QcUjeGEvtT9n+UwWDzORJ?=
 =?us-ascii?Q?NzHooz70nyZXZqFKVCPTB4+a2f3ZBnaV459iDjmBZwln/O0iI7vvy5Wvo8rC?=
 =?us-ascii?Q?lpOEvkh314EnCOJdBR9Ka/Zfj+Wp6OJqEa8EUGCAgWF2mHuYUtZhrWx9ebUr?=
 =?us-ascii?Q?kgJ8s9PeiK+88f+wUxw8Fi2d2P8pp28zifOcN7ebw9y5VffAbx+NjX7RLaGU?=
 =?us-ascii?Q?apKBiw52vWw4hyIXKxkogmYr+ZNU3wxRPU6lG+RSnIGKi8h1lJSc2dAFuSif?=
 =?us-ascii?Q?M7JOGqxq/rwLkArEsoww5w+AGE8JddDCsb4QrxY4EQYHQ2n/KBRkuf8AP+yh?=
 =?us-ascii?Q?6cdBhwEB1an9BIcOZBI6FjS7XIJ3ksAvWpMeeTb/wKfjKgeXPH8yC4/15Gn+?=
 =?us-ascii?Q?btwATbdhgO9myzt4wZIFDeQMaA802uqeyAm8OjiqtFYmiINGv6DHvbr9I1Ka?=
 =?us-ascii?Q?ZGTvf7hPPIbhdnHqtCNUhoX8UalUCyiM9qtVKucPTxF67V6PBSYJRqDnoW9e?=
 =?us-ascii?Q?Y5LUFJ+MNrY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda489bf-92ec-48bb-0db1-08da3706b895
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2374.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 06:38:43.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYZP282MB3252
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The product's enumeration align with previous 
Quectel EM120R-GL, so the EM120 FCCL would use 
the same config as Quectel EM120R-GL. 

Signed-off-by: Yonglin Tan <yonglin.tan@outlook.com>
---

V2:
Fixed the format errors in the patch description.

 drivers/bus/mhi/host/pci_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 8416267..0a6469c 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -557,6 +557,8 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
+	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
-- 
2.7.4

