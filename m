Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0F24C41FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiBYKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiBYKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:10:34 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A05A1AAFCC;
        Fri, 25 Feb 2022 02:09:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipUDZlAiwOA9WiskHlxYO3I4/Ii29Kxl/V0RPfYNnZlo3rUkhpIYO+wzPLH8D9S+hlD9WCNKnIh2cPxKvXHUMGBtetrvpwvjeyk7+EK9cPGIi8v+bV6knYFnqABHDOdLnrYAm83uifUoeEanEYnqpvr0wAR7+r9ww7+AffsdooSZf2tElGsLs7w6AKC756ltEX7IPEqa+PqIo3rZUq/B9dJ/UO6nW/LXIyzpPXFm+DtLcwuUhjLOOkavb9+jtg4S+ZL2ieS6z/BKq+ReVABjL1ki1zxJdf1deIO0dO891y7DEtntw+v5NLPj3wQEBHQSp1niL+HcV+W2ShK8VK5gqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTpJlYaKgekGwzvd1LTwSBlpd2MahFBQszYeTh4Y8Fw=;
 b=lj472d1Mygdw+fjHNh00o2ar1+P2nA6GnGCwUYhlm8W+CxS9c8a8Nvyf5nzMC+mSFhanA0Yw0ginmC/zBHXk8yvIhBuRA+sDnQYhPIkS5xdjYNK1w4CoukxKzHE2K2FKDRc6ewZ137qNkR21mpiaXJnHG6j30OOIymhDME+SN1++SxiV+DLk7p/uvX20b9U72yAm6ditpWJgit1E+oMOZOfLGMJIFXqeZeXECGFCOmcI72eNcWmi3dfXj/YeDfZz5cqis6CRa3bXW0qT5Qj873fGO5pGUFW+TwH0vf+7nXs33/3ZfrghMml8ziLq8JbXVgF8KsIoQcXH1jmr7XxqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTpJlYaKgekGwzvd1LTwSBlpd2MahFBQszYeTh4Y8Fw=;
 b=FRb+RSZWP0x0fb2FJDNM65DMUjBgrfTWQuy9vvv0K4wi5L/oBvv42FrlvqY9JGwJAwOy6odjt1qROi/NTNTGglfAlS8xUK/sG9rfm7hQM+co0BIV+BbruDXyajTuxvTq3dj1ubtqhuFspJ3CX/UjXsOn/rN2SC2Rlhzk0KCdNiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by DB8PR08MB4169.eurprd08.prod.outlook.com (2603:10a6:10:ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 10:09:56 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.4995.028; Fri, 25 Feb 2022
 10:09:56 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: [PATCH 0/2] arm64: dts: rockchip: add usb3 support to rk356x
Date:   Fri, 25 Feb 2022 11:09:41 +0100
Message-Id: <20220225100943.2115933-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19671656-dac3-4aba-22f0-08d9f846f8d8
X-MS-TrafficTypeDiagnostic: DB8PR08MB4169:EE_
X-Microsoft-Antispam-PRVS: <DB8PR08MB4169BDE9D155734B5A8F9AE1F23E9@DB8PR08MB4169.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2/qs5h02f4u5eAWXhzwHsY0EetbvOS/UpBAQ8DbEHaQpdbtB54eKASVQjBR+D0Wmar1tL41I6UCcbLxw5LzoJj+IisjLUnzjtxY4dIISetOGE4aznxydUIBn8FhpVEdHeY81Ac34WobZBR8FQC+LqGwWtPLWhCBrPmJMhfS7d57QZXX/897VPQGOO2ISPDXP2GjbzMRfRI2c0vvVU0XA9tjeqz55a/W8SwQGwhi3aayVNz6rNjmfGTtbnst+ZKPTS/7uNOtBP7eqGS+yWe1RHXeYR9DWwE0ifiwH+m4YLDPbXMallzFD6TJYWZp+RoT6T87dcBKuP14catqtIa1or7n9oKnwsyQXxAb3kwb0TlwO1fnbyBzcpzeOtg64/fKyLTMO8IJXLWbAF8/pLbBbiiZ8oe9bVLWGsBTGKVEbeBdLufMiuPfgMePJHjpO2rbJB42QcEJN2lIxrHff9eGNZFuKcKmKXyZ77c99A7WAz0A+QGhEYzWvhx1gfX/5b9n+pCtV8yHdJPlcHgzUFrnehL94PYFTb13aU8cPFqHGP4mtwdhX+9/IynbojdrKOX+v6VBVMYuRf1L/BXgsZS5BDK0/4uMnVcLewPy+uwHzJTaJ5XCGy6vXbQCGGUjDQJU85hSAHUy3SHQW5w+691Q0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(396003)(346002)(376002)(136003)(39850400004)(366004)(36756003)(2906002)(2616005)(186003)(1076003)(52116002)(4744005)(44832011)(6506007)(6512007)(5660300002)(6666004)(8676002)(4326008)(54906003)(508600001)(38100700002)(316002)(8936002)(86362001)(66946007)(66476007)(6486002)(66556008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bwQlsobUu0tLMrI/mx5qTLpBLwNtvhGt2hptOyYF7KEsf8wKzwaTV+5NIDg9?=
 =?us-ascii?Q?au80HX5XRuIbwpOTx+xrVfEfACX1MCQNLUzL9NcANpEC72b/771qj7/72GBE?=
 =?us-ascii?Q?jYgd94v/ugS5TdFDIkle4NJskk8YPDMv7KIFc2RBgkkSHd2F5aXmWOLj3v8s?=
 =?us-ascii?Q?IluGOeAfpWOww+IVG+Arcs4QyvBzTMsWrmVC2WMRH8pFrQxOo6pGaiqVEUNe?=
 =?us-ascii?Q?WX2bLKx4BkIKMFi4SZkVwqQc/NR9ClG78qsC2tN7jCd78vs2KPHJ1aC2S+DV?=
 =?us-ascii?Q?inc/CLRv6liscH4kEL93BccN1V+W4CsALyeu9nCNxtpOHbScsrvCrdGkIKH+?=
 =?us-ascii?Q?rbKpKs1Vlqyt/f0eQoj90C77KhjOzDmslXD9aXJoo6xQYg8f5eWBuZNjS0YR?=
 =?us-ascii?Q?ft9MKiA1s41LrhPTBXKl+S6UYMYvIGc5NyuSJZxvBtYzWEBJAFAzGuoWozcb?=
 =?us-ascii?Q?/xLkZXuzJDke+sF+2sGEX2TQr28baYkPt8JFfefM9QZ2lbWENXzUnAeSEOw+?=
 =?us-ascii?Q?DMSwSZlrlPm8fTJacruDHeNtZHw5Nw4k+oXellhaiVD3AYrS5TN3EclDk7/t?=
 =?us-ascii?Q?RwMLeMW/spcddEtLNkjlWVsA+uxVfFH3WPYHzR5n0WCHYVpwWJg2hGEjWwRt?=
 =?us-ascii?Q?eospjFKmypGmupzYxYPRbl1DamrKgi0CEt6EosToTs1kL3qema1AtV8UgkQX?=
 =?us-ascii?Q?m/VRJXwM5ASB5+fDmq0Qe3LlWchuU6ZBQvx90rG1MKNKi1NSPuPf/ScWRp/H?=
 =?us-ascii?Q?s4uRbe6VvBjuSfy3/TSqKD5yGDa6oR8S1FWczY5rLo50ZJdiJbkSpWkLuAOp?=
 =?us-ascii?Q?TUMcOcuIfKVj3noqUtdw5fp80o+SdOYQBAdeZ2qgrUC16vqgg0Opfi+NYnau?=
 =?us-ascii?Q?BHfTBt1PMfm4mlYEVzYKafwvbjUFfsUcT0nmNdu697ZNZTBBdlN/sdrhl+jb?=
 =?us-ascii?Q?UARra2vmcs4/T0kl5xGd0ATPujU0KjmKB0023QEn5Ccb202NqBG4tiGZM+Cs?=
 =?us-ascii?Q?2d7IziM+SZ2fiGOwSYLTrN5M5fsiVqUWJ/GvClUEQ+4/rr/UYxYYrG4+dVEX?=
 =?us-ascii?Q?KIsC2LfHdRqlNc7wk3MKODtbmEHFzwwCIfJ1CN3WGxjVYIQ8NtktdfaHMlkH?=
 =?us-ascii?Q?cTOem3ahdRYJRJghioime0XlJ5B0fUZIJxQ91vuGl6Sbgl42mAR3HMN6Aj4+?=
 =?us-ascii?Q?MaFCwxqFuJUFzVX23eYYsPHbqRBKzEPaGX1YqWxOtcmKP3+L8MO3Pyf6vG4Y?=
 =?us-ascii?Q?QDvF1KY+aZwk6UKv8T2Rh3ft+VyfYofDniup3zE7/IaKT9frP4OJrSQ+U8bd?=
 =?us-ascii?Q?BypLyy5STTNbQGAAq0ubEgEX3I+HyNb5oJrD9v1MwTNAF5JrUPlTiCAZ1+Fb?=
 =?us-ascii?Q?QYw7rTz9u7z6NxnjeiU0NJR51/Xq+eEm2+Qt/RRF5kEcGbBOFSxq09qTBGzm?=
 =?us-ascii?Q?xSF9w7QpnmyE3JLbH59SVDyquf10QT4k2hkRuDztmKPyaf8X2BxHcmRFGRED?=
 =?us-ascii?Q?AOnRKzxGtTMooCl5xeIPNkAhUu8BAsSsjJFhfr6R2L47A4Xe7z6+PMI0eM6v?=
 =?us-ascii?Q?z+om1JN3W8RjCAIltoEKSncxAh+TB35AEZornxyBthLLa/aEauD1hareKnn+?=
 =?us-ascii?Q?4o+xIFTQNeD2hcpEPNCOLwZmKUXnriMeGn/f1XUhpr9/RP5BQTowctFkEn8n?=
 =?us-ascii?Q?IDbKxClndk9q7//9/cqj0EpeeFyzaWPEw1seo0GDgenqftFHTL9H3oCwAczV?=
 =?us-ascii?Q?ak89Ahi+QBIex2pp9PWqR2qP1okAOUo=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 19671656-dac3-4aba-22f0-08d9f846f8d8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 10:09:55.9230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9dFCywMi8qfSf9CUXI6T/Cs1dzN2WoutzbncSFD6T7Bs9lSMqvSX5A68QjucoPuZC55z0kpV7Ol+MVplTyamf/EgY2haeT8s/Q6bhcukBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4169
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series introduces the USB 3.0 xHCI controller nodes and enables
them on the RK3568 EVB1.

While USB 3.0 host and gadget operation have been tested successfully
on the EVB1, the dtbs_check complains about several issues. However,
since several issues pop up with RK3399 dtbs as well there
might be something strange with the binding and/or existing board
dts files. In this regard I could use a few pointers.

Looking forward to your comments!

Best regards,
Michael

Michael Riesch (2):
  arm64: dts: rockchip: add the usb3 nodes to rk356x
  arm64: dts: rockchip: add usb3 support to rk3568-evb1-v10

 .../boot/dts/rockchip/rk3568-evb1-v10.dts     | 49 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      |  5 ++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 58 +++++++++++++++++++
 3 files changed, 112 insertions(+)

-- 
2.30.2

