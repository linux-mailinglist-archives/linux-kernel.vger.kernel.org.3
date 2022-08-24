Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F859F66F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbiHXJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbiHXJhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:37:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2F896FE6;
        Wed, 24 Aug 2022 02:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzxoXHiLD7qqcR6qiKxFfQAQYVnad+kKfLY/nDSX0jj5izHzRUTIeDRWpD/5wDubOI1f4kzeUMtGAbI05mI90B6F5xNeJcRPxJp5MmcQoV9nA/jjeaVzhgJY3YkvR53D07ClvmQdyJJSbH2uf1+dxVvK2rF7ES9r/kvNFC+HFmcvBvGAtrRd7i6YXK3MBdmJWbFx3K/LHkExFnBDjC9R5yTBTdUMK+5k6yLsfiyS0/F+y4NzPI0wJEwVEeuZR9VnoJUls2GXLAoArdUZQ2aZPC9Vb769bGnb2FaqTHAqAxxVotilD21CiFnG2i8vu28TrEZ1WdjTn5pFECmS+7J6aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1L2SbFKaqWTyNPq7U0THtVJxNnHmwPOITFy7JQvaDM=;
 b=azOdIFSMTbdStXLdyidMY6uqn3zrnVW8vl8smH5zl7StjsXKfjFCBUXHCRGHL2V6hUQbSibJDtnzdyuBxspHq0hozywTLGlXC92m+tZd9j+gwuCKVAzGvC/1/QdCwmcjWRosGINv8NlEqUGMUjLy0IWMf3bPCnWaxcwfMDt2M+xYhjg8KJ6aqpn+PT5l8U1Z5xsuFww8fqmn4IL9IRm6xizRTJVLTzubeRmb/L+oTNOgd8a7U6KHaeXU7BQ32Q3zqaCa6Z9UcRiasGNbTa5XCR97V/K9xXpjAX03GM2R4UhO5+Ed12w6PSy6BvKwgJHNCA28LwF7ggT/Q6hBDWGm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1L2SbFKaqWTyNPq7U0THtVJxNnHmwPOITFy7JQvaDM=;
 b=iUmRIJ+D8zg2J5+y8IHO52Y/5298ampq6oL+ttH/FTFnZTZ81syThDFr7C9+l333FjW57bMOqJlr00+OLf5l9eIlHs5HJSLedqwQlmWjzumB+sSUSUa/1a1kecyMEwmxLXW2JGFHs8a+isR+H8v+gWpxQXnYO4WJfOh3wEg0IXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7056.eurprd04.prod.outlook.com (2603:10a6:800:12c::21)
 by AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 09:36:46 +0000
Received: from VI1PR04MB7056.eurprd04.prod.outlook.com
 ([fe80::a9ae:f626:3c4d:7d72]) by VI1PR04MB7056.eurprd04.prod.outlook.com
 ([fe80::a9ae:f626:3c4d:7d72%3]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 09:36:46 +0000
Message-ID: <4fdef6f22ba6fe734ee11601aacc884da2b9820b.camel@nxp.com>
Subject: Re: [PATCH V2 2/2] mailbox: imx: support RST channel
From:   Liu Ying <victor.liu@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Date:   Wed, 24 Aug 2022 17:36:01 +0800
In-Reply-To: <20220615130009.1457986-3-peng.fan@oss.nxp.com>
References: <20220615130009.1457986-1-peng.fan@oss.nxp.com>
         <20220615130009.1457986-3-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To VI1PR04MB7056.eurprd04.prod.outlook.com
 (2603:10a6:800:12c::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9850e6d-92ff-4ee3-76fd-08da85b4293d
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HreezQjM3PWSXrZJKXbAJFYWi4mdyCoRdQ3TwoC8q5X7RmWU42yfZVKA6LC9Wh1FiGsFK40Y9AoP0ms7BqlGqOy9mZtIzC+ZVFNMc3Kci/N6aBrdPQ9cB1EuHqFXFl4xQGNuUkMQTAUEtpmRuzCCOFoopdegW+zR7Wdt9Of2q5+QkXxSraUJ6+dba1we2o26DEWp0yWk+FDqpK9al6kD7ptpciREG60WfNObGWyivo3pnsWU5Bmf/YvyIgNOwc+TGf58ZyCdov+02qVaDRwoYOJ6t372I6pin0SfF93y41j7HQsraAbYERHT4idgiJ5fWVV16Y5d0tovaBNQeIjyfrwUdmMDnkOFfqDImvcKeu/Mc02xis/u/u9OgtJsaW1fJ2NcJWjoNxKIBJgOeyM7ifHYZfKQXYEJyxGzfQN0rR9sN7j3J6NTyUvveRYhMCLK7W8U9t7v+ZtfFW1DtchowLoFueVUErP/lnlrcmTs3GIt4+NkRhyj2y9+VA/1Wp1zGURlIGwaGYkT3VkuAtJDS+KsaxBrW+gXTRUkWIm55GDKOMjBm7eoIOvEvQQOxA0yvBHuqiWlSTB9osTHLJ+thoR/cuT6/nw3poF+j0qmyJiMVtp1XecvBcABRYQrGMQ2xYsVvZbgfn9VQ457WveFza0xJFPmTyvsKlirlC4w6afLQoHQYrCCsGRywI4W/WYJfCUAZtog5+GsXHx0m1XXTrz/0Fv2OV2bXT2fYy+XfekV7ogU539NLqSXfClfPsp/YCBf/wchiPYHSy7PAMDQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7056.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(8676002)(66946007)(66476007)(4326008)(66556008)(316002)(186003)(36756003)(5660300002)(41300700001)(15650500001)(8936002)(2906002)(7416002)(478600001)(6512007)(86362001)(26005)(52116002)(6486002)(6506007)(2616005)(83380400001)(38350700002)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVJZTVBzSjFuTC9mVmFkaG1iejI0YWFOOFpPUzh0ZFBLVHIvbnlRc3pOWm4v?=
 =?utf-8?B?bXdWbVZxRzBRUGVUQWZka3hVMUVqZDVtdmlyaWVEbm0wQ2pENkZtSXhvZWtu?=
 =?utf-8?B?U1pxc0dyb0hENys0TnJHK1pmTlJGQXMwaDVpVWMvMnRoSlpqMU9kZU90a0wx?=
 =?utf-8?B?SHUvUjRtSDFGMVlQYTFuK084NndlVndmQlloWEZqQm5BVnFlZUlqaDd5eEhM?=
 =?utf-8?B?eDR6WCswSnFwbHhKbGlDUE9RMmpQNnV4dko0Q3U4a3BCaTEyb2NwNFpTQnpr?=
 =?utf-8?B?bjd2RzYzanRCZUFGSHZhenBoazRYVUNnVnR6dHZsNmVSbHdRd09yTVZ4cW1y?=
 =?utf-8?B?Znk1UmdPNGVIL1ZpQjBISFNHRWtuYVo0NEFvSGtnVndVZjQxdmc1dzI0Tmx6?=
 =?utf-8?B?cFVCand6Q1plb2VYNzMyRFJNdGFRNTdRTHVzWWR4SXNVN3lFR1VuS2JvNWNX?=
 =?utf-8?B?aDVVOFJHRkowd29iTVh0RVNDWU1MRnJWZW1xTFRDcmh5djVxOUp1b0grM2VV?=
 =?utf-8?B?S1R1VDNxNHZad3hLRmQ2eHFmRnU0WTBoL1Q4N0NyQWUrejdRYmJ2TTQwR1h1?=
 =?utf-8?B?TEgrRHhMNThHMmlhQXRRTVlsOEc0QkZta2I3b2tuZDlGYUlDVXhpU1VkV1VX?=
 =?utf-8?B?d2pjT2ZZaGNVM3JOODBpeGs5WWxhYjA0Nnd4SjhoSXIzcE1ZYzFmdTVBSDN2?=
 =?utf-8?B?Z2x5QzZ3Wkk2UXNsdzVYSG9ZNDBCMkZ2K2pFRVcxT3lRSllmQlVmQlNERHZC?=
 =?utf-8?B?T3NQVjFkSjFXejZjdW1iZ3gzR09rTGk1MHJUSWVEWmo0YXFUU0NOVGhkbWxY?=
 =?utf-8?B?OFhFeVNRTGtvalV5akM4YlpkZ3crU1VGaERwNlMvTU9SZ283Rm5Hd0I2TVFk?=
 =?utf-8?B?ZjVUSHpCbmNYRDlZYVpYbkp6UlhrSUZ6OWVvZlRSeVZZOWMzQ3pHV2hqbk8w?=
 =?utf-8?B?dHJyTzRoRXBhQ3JsQ3JjN0dMSUpIOTJBM3kyNmFKT3Rza1BHQ09KaTNILzc4?=
 =?utf-8?B?NHpacS9iaTh1ZE5WaURQZlBwZGU1QkVpaXVNVzNyU2orZlVDRXBTbkgrWlRX?=
 =?utf-8?B?NWFxQ3FybEx4UFRhaVc0TXhsM0ZBVHRGVjY1ZGsxdkpQUERJSDlHSTE1c3JS?=
 =?utf-8?B?cVhYeUdEOXZlK1VGL0c0Q2dwZmxSU3VYZk1kckllb2hDeXVtWUtUS1A4RllT?=
 =?utf-8?B?YjRnd0VObUxHNzJJRGpKU0tjNW85YnZNQlNtOE9jUUtsT0hFMTJHUEhZUy93?=
 =?utf-8?B?RkFvMnRxOCtidGpPSWpLUFd5UlQyYjl1bkdjOHFBZDNBd3hnNzN0NlljYklH?=
 =?utf-8?B?T0c0d29jbCtlZHBrZzdxeVBMYjluVHZWL25Ud0daRTJzSE02MUNCUVJRV0M0?=
 =?utf-8?B?c1JkMXUvODlzd3p4M2FoczhwcDFCTGlibHE5WWpjSjc0aERYVWlKTmZxdkx2?=
 =?utf-8?B?K29sMmJ5L29rZTEwYlNjTnN4VEpRTUJNbDltSUdqa1pSUFAvTWhqdnFwUTNZ?=
 =?utf-8?B?ZWNJbmU3WlFYWFlKcWxjN1liazd2TXBxRXRWR2JJVmJRd2trY3p2cklSdTVi?=
 =?utf-8?B?L0NOOFozSXlEdmNpcnBHeHV1S1NDT2w3bUI5MG53bGtSWTU5a090K2R2QXRm?=
 =?utf-8?B?MkdFMDAwdWhrL0s5OHRoRjFDdjJBdmFFYk42MDh5SmViY3ZubW9uaWdwaG5Z?=
 =?utf-8?B?U3g0UnV1dXVjTytwTmRqMVRZTElBcmFaTHdsa0lwSXhXalhRSWljWk1aZWdM?=
 =?utf-8?B?SGhmOUhiSllTVTVJcWJwamJYLzRrb1VsRElHVEpMakphU0ticSs3dmVmTno0?=
 =?utf-8?B?U1dVajlkTSs3T29lYjc0RXUxZGdwWEVSN0pQZTFFSkhRS2xIQkozTDVMbzU3?=
 =?utf-8?B?MEZFaGs0RGEvWFU4end1bDQzT0oyWGtITExkb1k0N21QTkVEK3NObUxPVWh0?=
 =?utf-8?B?OUZyZitmMzJEblhNUUNKTmlnZ1hkbEQzS2VodE9ITXQxMXBuTDFEZHhOVjdm?=
 =?utf-8?B?TTN3VkUxSU9uak9MMDhHZXJPVWJnSngzUUllUjRnQmZCRHF0SForcVBVcE9x?=
 =?utf-8?B?ZE5BaGppRnR1bVZjanJyQy9zK3padC9IUW9WMVRyK3BuaDUwUEE5OXNrU0Nm?=
 =?utf-8?Q?IHw9HIEgcsmft80CXZZcXd7+Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9850e6d-92ff-4ee3-76fd-08da85b4293d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7056.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 09:36:46.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaRJ5R8snZ2MV6iZYwIi4cG3w+U8doOvrIQR1PE2jMzjG3Ogcb/Lt8C4CN7bL38qdDFG7cXlQ8YKLskB21I47Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2022-06-15 at 21:00 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX generic MU supports MU-A/B reset feature.
> 
> When stop/start remotecore, MU is not reset. So when Linux stop
> remotecore, the MU-B side BCR may contain valid configuration,
> because MU-B is not reset. So when linux start Mcore
> again and notify Mcore, Mcore is not ready to handle MU interrupt
> and cause issues. So need reset MU when stop Mcore.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

It looks like this patch causes i.MX8qxp MEK boot failure with v6.0-
rc1. After reverting commit 82ab513baed5895c8b0e991557a12fd38d5f25f0,
it boots ok.

There are a lot imx_mu and imx-scu error logs:

----------------------------8<------------------------------------
[    1.166567] imx-scu system-controller: RPC send msg timeout
[    1.171843] imx_scu_soc_id: get soc info failed, ret -110
[    1.177221] imx-scu system-controller: failed to initialize SoC
info: -22
[    1.184019] imx-scu system-controller: NXP i.MX SCU Initialized
[    1.230605] imx-scu system-controller: RPC send msg timeout
[    1.270559] imx-scu system-controller: RPC send msg timeout
[    1.310561] imx-scu system-controller: RPC send msg timeout
[    1.350560] imx-scu system-controller: RPC send msg timeout
[    1.390560] imx-scu system-controller: RPC send msg timeout
[    1.430561] imx-scu system-controller: RPC send msg timeout
[    1.470559] imx-scu system-controller: RPC send msg timeout
[    1.510559] imx-scu system-controller: RPC send msg timeout
[    1.550559] imx-scu system-controller: RPC send msg timeout
[    1.590559] imx-scu system-controller: RPC send msg timeout
[    1.630561] imx-scu system-controller: RPC send msg timeout
[    1.670558] imx-scu system-controller: RPC send msg timeout
[    1.710559] imx-scu system-controller: RPC send msg timeout
[    1.750558] imx-scu system-controller: RPC send msg timeout
[    1.790559] imx-scu system-controller: RPC send msg timeout
[    1.830562] imx-scu system-controller: RPC send msg timeout
[    1.870559] imx-scu system-controller: RPC send msg timeout
[    1.910559] imx-scu system-controller: RPC send msg timeout
[    1.950561] imx-scu system-controller: RPC send msg timeout
[    1.990592] imx-scu system-controller: RPC send msg timeout
[    1.995838] imx_mu 5d1c0000.mailbox: Try increasing
MBOX_TX_QUEUE_LEN
[    2.002262] imx-scu system-controller: RPC send msg failed: -105
[    2.008260] imx_mu 5d1c0000.mailbox: Try increasing
MBOX_TX_QUEUE_LEN
[    2.014682] imx-scu system-controller: RPC send msg failed: -105
[    2.020681] imx_mu 5d1c0000.mailbox: Try increasing
MBOX_TX_QUEUE_LEN
[    2.027103] imx-scu system-controller: RPC send msg failed: -105
[    2.033105] imx_mu 5d1c0000.mailbox: Try increasing
MBOX_TX_QUEUE_LEN
[    2.039526] imx-scu system-controller: RPC send msg failed: -105
[    2.045526] imx_mu 5d1c0000.mailbox: Try increasing
MBOX_TX_QUEUE_LEN
[    2.051949] imx-scu system-controller: RPC send msg failed: -105
----------------------------8<------------------------------------

Regards,
Liu Ying

