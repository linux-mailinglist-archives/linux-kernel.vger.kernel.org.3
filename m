Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5A44E219A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbiCUH4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbiCUH4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:56:04 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150083.outbound.protection.outlook.com [40.107.15.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864515A26;
        Mon, 21 Mar 2022 00:54:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHNU1f6UIVufFKI7iiAdKPLYlkYd4O8rinz9pyohTUls3U+d9Sm9uwX755vpSJ3fcRSFm9t1c/Zer711Okt4udHb9ij9xy9aBanP2JHLzxqIlH7mj0aFSDiZ8YY/0ck2RORm88Ch9UZrVHzto3pTMvBn+YG4YZ8do/55ZYMBogMEIUXNHlu9ofE0+dm3uPNASQg1rAqAbzwuRnX+xP6iq4swILg0YmCMb+ymxTyIhmHTiqJb4SqmaR0LhfCFqKkn2qWJ3Ms4qFsNXRbcSCAJsH/9vuOUJttTP1sAWzWORv3//283jBcqLG9KkLpyN4Tee6PdL0pwjNAi7Eux+SVjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrK6CvNNGwGM8lXSw+1gnI+VpCiLrh0o96AyUOXGB+o=;
 b=D69+yJYtc6rJHOkohgxLxjgLoncKSQWUhYicp2MLGmR175XyykmiftTmUNbUz0tjBtLHrb9fNMItQJVlpb+3NYijq0piJInunaXE7qHf/8ZZESOb8yTxKRrFD/B4BC3GX8DGtnEkxL91U3caA2LGUUDpVJ0WOl8gFFTd9JchlPPdk91GNJBdc7Y5Kgyu0n1qKrmVMOboIzvV1AlrlxWIFCA8x4PXZyqLvTsZYtQCHXQOq0lMgIqFldcUvE0vSU188fqqKPNDRNpw/+vfulRiupUvnMv1bsSfDverjKTFrY1L5jxtd/w7FHWL6GQbKw2RIYg2Ra25b5RPa5kdtoYbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrK6CvNNGwGM8lXSw+1gnI+VpCiLrh0o96AyUOXGB+o=;
 b=HFocsPAEcUXZXK8NYS5FypfdFltPfBcvL1flTMe0PyVCYY9Sb1ygatyd8okDlj/uTHYhDA4XtDyMVlD3VkOi4YYuEMYgK8QSUnbaaQud70g8C1zz/n4LFzQdQ3qU8UZYUqm2y5aZr1mizwfYMs9ZEfoQ5dj+5NFbrQXQeqZ0ij0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 07:54:37 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 07:54:37 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     robh+dt@kernel.org, krzk+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, manish.narani@xilinx.com,
        michal.simek@xilinx.com, dinguyen@kernel.org, bp@suse.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 0/2] add ddr controller node to support EDAC on imx8mp
Date:   Mon, 21 Mar 2022 15:51:29 +0800
Message-Id: <20220321075131.17811-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36817720-0e7e-4149-53f7-08da0b100b9a
X-MS-TrafficTypeDiagnostic: DBAPR04MB7222:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB7222799CAE4FE3EB8A7A543692169@DBAPR04MB7222.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vn5gpQRI4hTBaOCYzFYlt9B02cRMysaYGr4dFV64b3WNzF7TaNUIy1GfFhqp1PeWq7W024dK1Yos7glt2XA/wWuzG41D1dLuS/Wi7/duG8/fziKsSk75fAC0KP1jKi0r90L/rZG+cnEJ+TCFze7PjOxRDRpU7DJZjaCfKV2IE6Ra/bfTsSHSX8rxYlrQmU5rqZSAgPconFaNMxKhISD36GODIn/VPbt8hpVrjwkG7eT/XX6gMn7HpCH31w6qRxmGNhfkUeVb5NJF59gEh8SSXdjtnPXfENwOFhuNtMC3VOjZurk2jrprzu6hdSGFz+53xniDtESpVWj//XDmUrelm3q8Xl8Ot5GcS1JzA12wekLDVgGwfpU47KDmTaQwbFKJr6CABfAM2mqIXkfMR+60WQcPHzm4YYyqU21CSb27hN/u8U3pzx7Yx5mjDexN6bbdB1F0zedl09gcmvxgymfNmNW6+HuPJHph80/zJtJwZJYF5KRjAoByJr2UhWOT3quauJw5X1crPKstu+RbHCtPEpjqfNI9HEbGwjV8DL+fDwYvHgan+a3BxQO0cOU3aqm5d/w+o+a953ogqYsfrCHhwX1vq7J7p1xZ3E5PyA4PACofQpZbdbiRyAtVUJ7QODbExdBktbu5VZ6gY4a3mDzM4503L8D6Ouz3cfCesVW0ErvbUDaiSu8kzfimBl6CHnSTS5aC5GB/zSEls3Ccqp7/u9UxkkFJgctTBT8ykwl0ons=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(36756003)(83380400001)(316002)(6666004)(6486002)(6506007)(52116002)(8936002)(508600001)(2906002)(2616005)(1076003)(186003)(6512007)(66946007)(38100700002)(66476007)(66556008)(7416002)(44832011)(4326008)(4744005)(8676002)(5660300002)(38350700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g8ee4dPlRWk/S8Y9JJ3gM17XD1G71/M7Y5e7u38gInyJCdmKVLKLCGco2Ggc?=
 =?us-ascii?Q?cAnVe3nP6bAkLJ7C3irUwFxloTHF2plxdlUoO2lInlW4QAH7zDXNd90Fv2VQ?=
 =?us-ascii?Q?1MR/wSeEU04Ixpcbi7DOJp0FtpDigW75Sm3C7sNaDPPrpUmH+rlHNmaMyJqY?=
 =?us-ascii?Q?RlAXAeTmTc9wnBInNiX9yZIrzm7JMArU/zmEqCbNKZosNsB1W4/a1ib0C7hS?=
 =?us-ascii?Q?tiZlAGcb5c4YPRKcoC44l2qA0vtWfxOjRri61KxnzmOwmuJ1fExWCGIEM97E?=
 =?us-ascii?Q?bZpMMbZlrFlvEvuK7fwIRK8SlzPbFZ3CR1urutv2uXEWfVhkVEKd9loPsI3V?=
 =?us-ascii?Q?vb7+QpdaaNVmdDohDEpxG0V2RScrwwAyp9cSG0eSSxhgXUPjTkLb1/mTDm4d?=
 =?us-ascii?Q?quC4j9K7t2bPwDrprJUUt5kj1q1vjl5He4Aeta6sKGpotK2SOHVKywkP3SyM?=
 =?us-ascii?Q?PFaU/B6rHPT3bkdLuB5Z9SO9TlGKrXMDtaz9T8139VUX9m7nrrEhI4qGXyaD?=
 =?us-ascii?Q?MM0/oHFhaJ/8TFvV38zqTpDKUytVgKxzaoY/51KiSxuJ18dxb5kr5zfJq7cH?=
 =?us-ascii?Q?HRKsP1Qev32O1u2HDqWsFdsbr2ChL/MdycND2EIbl7EbrcNE4GiMrPCS8gvm?=
 =?us-ascii?Q?YQSkK2qRScEdM/wB07+iW8gbzF0GGjueWeS9FMFE/U9IqBD7qjt0yR1thib8?=
 =?us-ascii?Q?cIuO/7lJ0KmZcVHU8gvRrKJxLRYu4jdrmNLvp6HcSK78G9XOYR/2Mc6+2F5x?=
 =?us-ascii?Q?9YwTkhNdvBRk5+TtFpzYCvjh8z1aj25CaR97ZQ92FJ41I4WQENpfTlp5Uk36?=
 =?us-ascii?Q?5wjNMIbdkg1chJxhmZe1BMiO8XeYXxLzp2JeediaGMrN4qfHVR/LYL6rixeh?=
 =?us-ascii?Q?wqe7QbHq9eGypg2NNxfWiJLP0XD1VI6ElDa41YRtmFXW7yXecejSbVXQgGP+?=
 =?us-ascii?Q?ZSs75xScnUm+3hQG8aAvKidlybHjedZA1TRr6FJnPlGPy+DOl60SXqnfhny2?=
 =?us-ascii?Q?H57Rvtog1gFUeO5f46evz5Fy7e7cOCwJ/wwLYoPDXzGeE/+hMg/Df+UsYKHU?=
 =?us-ascii?Q?HUvIJFKARY3fXaf5CpnoXpC1/0Bs72qBjlgOBEOpeyVpXw42cm+7kFHca9Dw?=
 =?us-ascii?Q?LLeFYLLb6e2kzbikzyag3eENRN3deaoiyVOcEnk49ZD9ycZUwdmcN0+nWUD4?=
 =?us-ascii?Q?Mn9Z1IdYtuEI5aSwqNnxA4Ji5EEJpFiTbuGYxJfm7e0QZFzoJ1oj+opcFdmS?=
 =?us-ascii?Q?u8uW6l2jh2wxyUdS7Uln7p+m3l7CmiREwII426zUhcg2KYg9Uhq06tx/DTsO?=
 =?us-ascii?Q?8TzPWcyhM+ZyAmrEE6n3OK2w1iIAgruTCyzi3J8upNirk6Pjq+IFdMmnF9vQ?=
 =?us-ascii?Q?GtyAjn2XeVK0ObT8ddSpHKji41QrpTkoUFq4FwzrKVU18bvm4QJ7t3Q0gKLa?=
 =?us-ascii?Q?vJ6tTpNb/Ikp/BAIyAw05Mh+DkiRRHZ3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36817720-0e7e-4149-53f7-08da0b100b9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:54:37.1997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAVCLpQh2nefDgLtERG17UuS/nqTzPH3EJQPu+91JZ8+0T2gCoxM2Vu2R4k6OlZ5nyAGMMLWlaac4cHunyzosg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First fix the errors for snps,ddrc-3.80a in DT bindings, then add the device
node to support EDAC on imx8mp.

Changes in V2:
* Suggested by Krzysztof, fix the error for snps,ddrc-3.80a compatible in
synopsys,ddrc-ecc.yaml, then add the dts node in device tree.

Sherry Sun (2):
  dt-bindings: memory: snps,ddrc-3.80a compatible also need interrupts
  arm64: dts: imx8mp: add ddr controller node to support EDAC on imx8mp

 .../bindings/memory-controllers/synopsys,ddrc-ecc.yaml      | 6 ++++--
 arch/arm64/boot/dts/freescale/imx8mp.dtsi                   | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.17.1

