Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41D659D0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiHWGBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240407AbiHWGBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:01:09 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2123.outbound.protection.outlook.com [40.107.243.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E24D5FAC5;
        Mon, 22 Aug 2022 23:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7ng91bZGLBV50amqUpTwZwFFcbejMn9o8m7VCfi+cAmxGx2SlHjIkArCmMW+WpD+UAoEneRaT8wWQH5FKGmI24M3TwyMxnV42Et+vwhhSDkhKsi+jA5NXQTQZDvtLqaPlwgieosgmrP08+2l5ZKRSJMViRkTDxms7p+XkWakCPjYPiYrLotFPeyIJfBffHE+78JXPJ4era8iqlGExQK8wITwlXfLD5B5hlgPd7gnjTizI4SY/SmLBjJPYWqDJB18qOZW+4M5gzyb0NhhOAZgMhqY9QHwViJMoyjFlQdSLMJu1l4ilsmN3xIy7QSYifZki9QXz1TxCs50nIl+Y/YoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTI6ERXpUggPlaCF04Mz5GTR5X4F0mYcdg9kdQjA/Uo=;
 b=HLdwX/k+csXpKnsttOIjYZYTj3iuyi3qBtgnq+Cz3R7UyO4l+xfFuMbOU7kySfIHhXQsov0ieBBrW8bGEVelRmYKc3pAOv20iMTvbgTYOzdA5giV15ro5ZuAirxrROd4TFHai5rzplr8ccrgyYowGQ5w0QL125fmEqNxTqWkVnd/NzXBlR7bfu/SMDcVrqlQ6jUNqqwCpXQQ1ODHFtpAAKc3Xi1CS/GTCddbRrNz3Gs4YYkssQZPrAcJOVis5iCOR27DMwTV1saEdFf9aKcTBMFFjiv5A8aRbgdbHDjcM9UoSX3VMwj/2dxtBD4Hk0pIwxE1Assh8C1mfDKwq3OmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTI6ERXpUggPlaCF04Mz5GTR5X4F0mYcdg9kdQjA/Uo=;
 b=Re+8hnpz6tXEQiRcfsljt2QlF7YcsGOIxSrvdPTxFisvxKwm7m45uVY4PMBtlRRaSuGDaOMv8jYTfN2AiIB5jbupDXpFqvfgwKClQsza6HDufyM9ShVUxw5fbFA67UNFU5D76MsQsnZSBjUYLlgZ2wDcjaE9gRBumzACQUTB4eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BYAPR10MB2984.namprd10.prod.outlook.com
 (2603:10b6:a03:8f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 23 Aug
 2022 06:01:04 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.028; Tue, 23 Aug 2022
 06:01:04 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     UNGLinuxDriver@microchip.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v1 0/1] Convert phy-ocelot-serdes documentation to YAML
Date:   Mon, 22 Aug 2022 23:00:51 -0700
Message-Id: <20220823060052.3921849-1-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::29) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 246cbf13-8080-4776-a82a-08da84ccdcb0
X-MS-TrafficTypeDiagnostic: BYAPR10MB2984:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1ymk9EismCzfN2JKPI8ijUgAh+PjkQe7Kd/UBn3t7fQbz7VG/zM8KJwViyh07/Y3Am+zmrw7QszQ0jmLkjrlvHBey1q+/G41l4MdFxpbt8xfWzUTVcsAB4YnbSyAxVLyy5pA9hVlJI1mHYq6I60fueM//aONHEDGOVnc7YroelrRqlf6B8bsB8EgmDC4H0331lsodeTguoQY+B9+iLCAZ8sRKWKqdp0zyK1szGerjMbk39RJVhgT4XJ+5fpFLSXkQA4ab86wd/NHtbpD4AFpc49wWXM8hUcTOfv5w/wObVsJ/75hTVbcYLWprlSRb71wSmXXAMn5hEfNVSKfDuH5cAp/bjkF6LeObBmtTH07w2wu8TIqx4PvNgzsTxCWoTneNiaLpPJZKnMh1c+PJe43wf4and8OhRfv/sfFKc+ixKaMb9my/i6reO1t7vn0qMmpgvnX/eVbFGXZg5nOBqIdpNl6IDw88p6WHRBpD91niOrhnoS1ec3AicurQhWLcw6nswrpja9/pQfFh3g/xUsLdXqwbqTIWj1Cgii30m27lVqNbYmZdJIdbcsoMbbfVTx+Nk+SGfvt/3dpQwlBEK0DTMvKaY025AzBVOE2Pho5STp13m+wxlqwR9BPIZerdHWXsZxAg4tZYJagl2GJ3qU4exwFLHHOy2YY5zUmBgXzuWG6N0DhvoqA90RZWDYwoqHotw6zzxZXnOYxff8DIobjsv18QvkmUKZcGLtwP2uf6fPxtG2JISP+CsiNqQ1Ol1r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(366004)(39830400003)(396003)(376002)(86362001)(1076003)(186003)(2616005)(38350700002)(38100700002)(83380400001)(4744005)(44832011)(8936002)(7416002)(5660300002)(4326008)(66946007)(66556008)(8676002)(66476007)(2906002)(36756003)(41300700001)(478600001)(6486002)(6512007)(26005)(52116002)(6506007)(6666004)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcykDPyYLbOedI9jqHHPnYkk9ZR6S8OLTidGudVYOcH3w8XK5NER3WkqN8M4?=
 =?us-ascii?Q?GiKzezj0qrRvYwK1FhfUNRfOU35MgOwWY+COMfg10jxXTW0KghrYWDzT1Cnw?=
 =?us-ascii?Q?+G5aCdWKnvNGle/2X/aZrdPexmoQ9o6a9soP1VQtcnsXC3N6rNGr+S9EN+vl?=
 =?us-ascii?Q?m8iNzemObbWXZHIKHmq7KIkp7Y2ZdG7ZSyDBOBae+fUcKuExIyHi4Vd6RxGO?=
 =?us-ascii?Q?DsB+XT66Bm8KA/BFjkxd7ISno6nSebIxii3Va8Ku4smLTYDkjEHDxVEK7xmY?=
 =?us-ascii?Q?IvPYzEl7KlnHVCsFzNPEc27vHJiClDPaDGD36J+a+RKuddruUxZr4tNuDmI9?=
 =?us-ascii?Q?Pq4kae+iu7u05KWIl1An60NehxZukGMVO6dTpC8Zd4YsEaPDM2oWfl9hPsvv?=
 =?us-ascii?Q?xgK7hOMrJo21b8kWxMcVcuKhtJzq038SlE2pGVa1a91MGkJDYvAe72yMuZ1p?=
 =?us-ascii?Q?vaCim+QNs0c50khY+XrMDM35e6euDNAfms/073uE1OSb4k/oVHvyj100zFlO?=
 =?us-ascii?Q?t0fNoMtxQ1cWVCMF7cZ23SRcSDAsTnvEIzFDZ6InfqP/vDJ7S+YZ9nj4A6IJ?=
 =?us-ascii?Q?FZP3FJ0LKRdDRDQuGa2Gr6h+dyoVTQAsi5I1+/6iZHEN1Hv+E5G6THZXdKH0?=
 =?us-ascii?Q?TtTWMy85Pqf+GuYUmS8AeQYEsabxOzlEPCqb9KTKQvjhJBiONAXTMwioYG4T?=
 =?us-ascii?Q?eWXt42PL901VbMjG9tPMAIM5/V/Nzk9219UwiY143TBLgHUUnjcv3vOjsFuQ?=
 =?us-ascii?Q?ZD/G2bWESWfPqIQN1/yP5FhBvAzRVovpNHeP+nRU/7rZRbwmGcYzJmMY/GxW?=
 =?us-ascii?Q?LHm0I5/P08Q60E3896mROwDURVlXcofFn8/9zp3H1gSR4MOvID/0xLO7whYq?=
 =?us-ascii?Q?mV3Ivw0pfHmUwEY4BdWDMPBLTT9SXL/XoVi9Zl2WEjI6GJdXc1mE4gUJbMJ+?=
 =?us-ascii?Q?sBNFw08gyYYDranVz4679HCtTPxTbRtDQSwBwudtGF3OJQbZXnxitZkRInkA?=
 =?us-ascii?Q?EhG/FHVFjyPbzfuxr72mVWvjZMyopVdpj48L2dmtInUBBVMgV62PGg4GllGV?=
 =?us-ascii?Q?k/RoXVAuhGbCF/PEiaDiyyAfh02Q/Jl4k6yt+VW6tWiL1Q9RSS3AkcEPaKV3?=
 =?us-ascii?Q?B59WqsO8amdgqYB0RMpi/b5C2lVul23ghGfhUCrKQ1fSujp+8gJWGKoPMSIy?=
 =?us-ascii?Q?8sFqmt8kHAAGtf+xbHLoOCTYOK5/eypsP14aocieW8sSDqTzIzriyHzeP6GF?=
 =?us-ascii?Q?FyDS4UazUSM5YVGQsV54SO2YuA/Rv29L+ESOj3tpjUJYIvms4+BR2sB1wqF1?=
 =?us-ascii?Q?huPbVss4Hc7Pm4tslX2BxulgHSjtuYTH50tJgU5vIeAwq/XuaozINhXPSR1S?=
 =?us-ascii?Q?QYwidl1cfdZsH2kQ72xDICFEMbKSV9HdbtrfBlPB/AjInHlDF/RqXJ4GYzvd?=
 =?us-ascii?Q?y6d8kD4D+Pc6iApvVZJEryj0RYeNWtXquUw31okCFSAasOEcdO9yfXBer5v5?=
 =?us-ascii?Q?E8uPl8hoI1Nn9BARStQpP0h2qZoXQAV2vVrnmz430S8HeXJHWKpaGhE/2j3p?=
 =?us-ascii?Q?ssidPi3GTxFuWBMiA9T1y+x7a7+Jm2zzZkznJNWlhViNxUBfpgL4x1V2QBfT?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246cbf13-8080-4776-a82a-08da84ccdcb0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 06:01:03.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Jc6eQee4bQzvR/xsVgfHZThEDKvO/fFIz9d6MehvS0IBoyAu2cDmdHoxZ+XJwP7RQ4la7QGuwMpvMMYzGCXV/KMVtm9lNUBJwAlR0rXa0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2984
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Work is currently being done to add the phy-ocelot-serdes driver to a
non-syscon configuration. Doing so will require updates to the
documentation.

I can certainly wait until that change set to submit this, but I feel
sooner is better than later for Documentation format updates. Also,
those updates likely won't be ready before this next merge window.

The only liberty I took was adding Alexandre and UNGLinuxDriver as the
maintainers, otherwise the content should be the same.

Colin Foster (1):
  dt-bindings: phy: ocelot-serdes: convert to YAML

 .../bindings/phy/phy-ocelot-serdes.txt        | 43 -------------
 .../bindings/phy/phy-ocelot-serdes.yaml       | 61 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 62 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml

-- 
2.25.1

