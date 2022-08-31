Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059645A8495
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiHaRlG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 31 Aug 2022 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbiHaRka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:40:30 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC900E10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:39:59 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-CmmM-FzrMSKtC1c5qeS16w-1; Wed, 31 Aug 2022 19:39:46 +0200
X-MC-Unique: CmmM-FzrMSKtC1c5qeS16w-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0614.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:45::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Wed, 31 Aug 2022 17:39:45 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 17:39:45 +0000
Date:   Wed, 31 Aug 2022 19:39:44 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Question on armv7-pmu interrupt-affinity property
Message-ID: <20220831173944.GB147052@francesco-nb.int.toradex.com>
X-ClientProxiedBy: MR1P264CA0126.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::29) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce5274f-f201-48e0-0bf6-08da8b77cb5e
X-MS-TrafficTypeDiagnostic: GVAP278MB0614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: avbePL7Vc6HlE8PhmchhPX+vAy5wfxwEnnq7bV7QWd/sqTtMncLn8+E3p0osvyyKrus7GeQV04LHu/wkz0DopFiTiyjzsm1HjaFKYoUA7TNJzai0nuxeHKYz6bh1czqKs3UizD5ewbm4em9g2WMapbOzTwiE0IoXVA1Ijyel5yq9Lc/leE1BdZVjH+FrYN+bi8NVmuHDDXPydELtWZNzu8vcjI08uQyOwFCLyDyD02ZDVSSNtcHylg+b+7GEwl77snHvWchPIry3wmn/rcL3wyX5Q++jfRjBjxmzw0Mu9FU1JMJY+BMhWsEYJTlCKEBVIAsrblQTKtuzsT0QshRKiEkqkF+GGTNAm2EO9bQiof/F3DQmkucm/er0QvOcxWJYn7Fv7d/cZhlc3vYQYpuLQtlXylXZkn4NKS7FbyNJgBKPm0E05QD7z2rBlIh0rhdiImoRP5YNVCTTW2QabO9yZSEVRbaKJh/jIUqVOPRrd1etRbJj16n8U+mf0ui9c5crPfFlqlhbM1W1I7gjE3r3Xu9qYllKKvRaWfy4S5a22cEvb8/k+qU1ICjEK8/v+wh4BUiUXSk5bx32Fr7m9bUkELnnJNVL0JmJGFFR6kf594vA8Tfk1sAAqGUVSHHrbJspqoPK45LPyrIagPmcKoDRSqV7v1mevpTnsParAMIrW+E84SMQ7KswmZ99k9BglILz6R2aS1XuoLVwGpSPTGH4dwctV1E3e6UW/YB2Ok9y8BERiSdtIzibfBmO9xRmrtozQCI8m5Sr9KvPeBOTpb/ryQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39850400004)(136003)(346002)(366004)(6512007)(52116002)(86362001)(478600001)(6506007)(6486002)(41300700001)(26005)(38100700002)(186003)(83380400001)(38350700002)(66476007)(1076003)(4326008)(5660300002)(66946007)(66556008)(8676002)(54906003)(8936002)(2906002)(316002)(44832011)(33656002)(4744005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wgnq6Xc7GDHqksx+Oi3OFYk9wzAloZbwyn1lVPMfHpAkljiR6I1vcvyXwx+w?=
 =?us-ascii?Q?BKs2o8s+GDz5lNiLIB07eOnSvgI+bDSU5SUlzajQFlVdt2vdURmxwxFmkjEG?=
 =?us-ascii?Q?9O6ac6LlIz7SwwAw4FVnKtL3caaPMgF2RJM84h2SwowPGdwiStqeR7l3R1tt?=
 =?us-ascii?Q?OWOFTSsNlO5v/VXNHKLA2E/qM0MkSBXLqzWTNOX4sHnJAaF2RHgRXLRDZJMh?=
 =?us-ascii?Q?kIzinhEmeSI+xyvdgNZWlUV492yxTKqkF9tRg6H53ThVrABUSS93d7sVNau9?=
 =?us-ascii?Q?aBndxlIwZ7yHo0wO8pmjuWHYlqtAizSULsYjdFOOs+Cxz7y+ut4MCpEoqC1b?=
 =?us-ascii?Q?2XPAJAO6ztxJwBzo9Dj7VtXrBJGgIvvHOOeautHPlEIiXtf5Iptaa/4KVMnf?=
 =?us-ascii?Q?Z6bxlDYLWKrGvxKqiA2JaPw1GW/Afyo73/Ds/wviVOM6yzd2EtrUwekYspG+?=
 =?us-ascii?Q?oBKuLnHPgMYATh77El9vzmnw5gxqyCzZLrNpjcfwGvT+d/8ACZUnWZuLPzAf?=
 =?us-ascii?Q?6M/yZkB1yvym12NDSBUS3kE0DPHvmiTeNl2ncctd65PUxqc2uoIBfVShr4ye?=
 =?us-ascii?Q?s1hmqVajxsw1W4uGt7Q+kfC6JImlyX2IvlkezJaR4HndQdcYKeC2+YTyxdGl?=
 =?us-ascii?Q?15uc4ZAjDZDwE4Nw6CW1B9DwSAozQVPKFFWd4EbZEp4kkzv8TKOz3Ka/0+CG?=
 =?us-ascii?Q?QLzutTdiOWxI1XzOxHMmHyAYndScgiYzDDgbPQ9wQ1K5ElgRuGA9u6OGnOAG?=
 =?us-ascii?Q?bek1lfcQ0C+yZRwnu/CYk8IAFNkRngTz90cjljffrrUHoCchR/YWLwVKdZvp?=
 =?us-ascii?Q?Y9aLqq8AAzuesOxJEwmWz9fGoR+d6SJafn8erwmQjlCLbmVIkQEBDheqrG9T?=
 =?us-ascii?Q?MXVnfY06xMG+Ln8yZ4z5hcFFiPriWF6iaHfDgY5MDGwgoJEEim7ggF5PEFEQ?=
 =?us-ascii?Q?tMv8smttJP4pgcMRBpI04bHd1JoGWGq0lMLS0N42RToL4Do+7yQNXsi7VSLI?=
 =?us-ascii?Q?OMYj7W5c5VhPYP67j5O9EzXJ3vl1S3qBwa/BuIFzJXXsd1oVLTRv4zzofclx?=
 =?us-ascii?Q?3GrX7cPizXYbeKPAs1ObLiUwhPyVA3uoZHb9HqkyDYk2ZkY116oGzASIytME?=
 =?us-ascii?Q?dvswRmFPfH4acK013gWJfNQvKIOP0lwjy3ezaXRzQQnKxmEmeweXm3ht5OKK?=
 =?us-ascii?Q?Ha0fI4jcpbEV+e1QvF8bxl0zqF/lpKJpYtSzgW1f6fR5ErCX2MAAXmvleySC?=
 =?us-ascii?Q?hEdMGrcYe8WuayTlpgXahvxME2ER6NMOS257fSg3XNkKD9jqmEdDfgMICVkD?=
 =?us-ascii?Q?kO19lV0JSs1LTYnuzyK7fEf3XFgqwijYj/8m0s3zs508UhqwzrMHX3Zqm7nM?=
 =?us-ascii?Q?5AvXKTx0n/H5b5jGkA4Ob36+dP2Ac3+tGzdgHbxMN4j4XPIGkFJMaV/+2M1x?=
 =?us-ascii?Q?Z0W/24kUKi9ZL7Bb0LceY0RhgAeU4O7PAN4KKXwXo5yfTXiRgXXzyzw5DLdg?=
 =?us-ascii?Q?dmuHsKtzEyezj10w/MU6oCUiNk8AdJ4y2SxqD4nQcUVxq3ysaFfra4AHUqrP?=
 =?us-ascii?Q?SRftFQs4jH8yIaTp1XED4IE5sX8xfOSoKZ5dkMddaNMJ3EwB8nxu7mQG4eni?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce5274f-f201-48e0-0bf6-08da8b77cb5e
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 17:39:45.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AWd4NEgWiPIeiJlmN13tLip9FsmhkZy++FHeJFY9xY+0C8Vo+HajFCBSi4AKwDtlpDBv/xYS9fK8+WHPOBaethz1mnnvSRqyYzo+ZD31VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0614
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
I am getting this warning from the kernel

[    1.488888] armv7-pmu pmu: hw perfevents: no interrupt-affinity property, guessing.

on two different i.MX6 boards (apalis-imx6 and colibri-imx6).

From my (very limited) understanding we should have the
"interrupt-affinity" property set in the SOC dtsi file, but this is not
the case for imx6qdl.dtsi.

1. Is my understanding correct?
2. What's the functional drawback of this property missing? Given the warning
   level of the printk I would expect some kind of malfunction.

thanks!
Francesco

