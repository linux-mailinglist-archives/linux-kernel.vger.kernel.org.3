Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295355C7E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245110AbiF1FoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245103AbiF1Fn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:43:57 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AE11C122;
        Mon, 27 Jun 2022 22:43:56 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=V26af0oFF+xCnnglS860lTa8xncycLAXFStlKUuENn4p5B7UsdoC2u6GLOiEJ1btYFmDBkYjVoOnvmz3Rj/1QBCPgzStyXSbDd3h8HSLVKVG1NUfmiLkUnUCGydOUBrhaqNtKIZtX+h48jFzzRkIex2hoHujUTd1+jHDdvFScPk8mFLeacg8pZx7kT01INnYf3p+VGsCFotiTRIqQXaKjPF5KmE3Y7HgNKjqT30HKcO9Wj9oFpG99qSpzRT3xr4qigNiMi9Kp8nv5DTjB3qQUpb1szVKNvXM7ehN7HGjhWCtGeo/1Ezjbf9K4Xk+E2OJOMe2//yC0YGaGoPPMb9rtg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiI0c0+f2zcUW58+nFgKf/IqwrXqn5fzul1qqdQ9BPI=;
 b=H6OaL7fGdNTemy6WiYJ65w5g1h121kUiPmtMBOwRVzVkVp4ZnkYGm5D+kUIxmcFUybxQC0aMzsvf2gorc64YyKPDWRw8U9Oe79WfPR5YzzlGzHLCXbNypiLK63Wh8fJ+vm9F91QY2V+rwkH4aRfjW3XtvQy3a/W8/pLDtc0qXzqyzHhEqlE4KiIYZUVrMtq4q21z3NWnF9BOJxuqINynJNnM6rh7JkjWEgscz4StGFtfq/c9rfMRqHanHxDh/kPif2GEFqflSU2XZwZt400Fpf+A0GlfLKvVTCxeHVX38tB5fInwxsFhxEDeDLBPhnIf0eNNbP3m2j4bHN67evYb/w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=xilinx.com; dkim=none
 (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiI0c0+f2zcUW58+nFgKf/IqwrXqn5fzul1qqdQ9BPI=;
 b=WjtILGstxc35dUTys3EacqOyzFAbG0fHpWOl+BbV0iXyL9PH29XKkkWOEoH/WYLIlzjEEGpmfLip++NqeaWobfwkyXouK2X6GSajTXKStoqgfT3xXn25x653TpRFD1U4rPz8rMxQbuQik0UW1Nua0cITeBHvUWQ1FCy7RPIHTqs=
Received: from BN9P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::18)
 by DM5PR02MB3846.namprd02.prod.outlook.com (2603:10b6:4:b1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 05:43:53 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::6a) by BN9P220CA0013.outlook.office365.com
 (2603:10b6:408:13e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
 pr=C
Received: from
 mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:52 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id 150F042023;
        Tue, 28 Jun 2022 05:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlOhG9Race84oBohGigol8sIh0FiwDc63mQrQu9iOgcc/TBWQ5M9g/un8OEp8GK+s5ZAuetDz3teKN0KW9aW/EH8pR1yrZqAuucy9SEKsRXVlhYfV+pnvWfUHimBYr43eXMZGw0dhQ9ZDR90qIsSGNNglY9CFtsd0xr2bZ8vyXPs+F2Bq7NRY5ZXKnJGd4YMjXacZ/p3gQ18a35Jg3suFVLL5C8h7YExWJwYyijdgGyHEFXYwPiDtzs//dzrR4vNmh4lpxsdog1nWSJTmCP73dXUV6YKC0IdciHgRppEeXNQBdlWANu65OkN6wZZ+bGXcGNVZpMzdLl7Mi10Bkn6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiI0c0+f2zcUW58+nFgKf/IqwrXqn5fzul1qqdQ9BPI=;
 b=ENB9W2bzGjHBGSa6L2H6TbmaJvu6xi1Oiu0Gx1vj9fjf9FJBBn13wfM2jXPrplzXbVd+Qyc1vZI/19LaiVcre7XupTHs/2TNIt3Qo5SbP6745N2YAwX0BA8K3cpJLFYUpv/CoxNl/XXiH4LsBIpH+jHPTRBja4X9yxsBF+yf6tV5pIL7hXIXAVr6Rgyp5ZnIJrsK18NTc83TdH1DNfNjQV42Xe8redBpz/4PnrOrfDY0hPglCKMq1A4n7EJY2Gmk6/mMDmLCOTld8//dfO0q871qjlqNgfP6D6u/8hnk1Ajk8WcpxngPLBcIHWiDma76s4vwnc3TkSC1a5shLQSvXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from SA9PR13CA0087.namprd13.prod.outlook.com (2603:10b6:806:23::32)
 by SN6PR02MB4975.namprd02.prod.outlook.com (2603:10b6:805:99::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 05:43:49 +0000
Received: from SN1NAM02FT0045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::38) by SA9PR13CA0087.outlook.office365.com
 (2603:10b6:806:23::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.7 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0045.mail.protection.outlook.com (10.97.5.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 05:43:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Jun 2022 22:43:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 27 Jun 2022 22:43:48 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 git@amd.com
Received: from [10.140.6.6] (port=51114 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1o640p-0007Ut-Jq; Mon, 27 Jun 2022 22:43:48 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <appana.durga.rao@xilinx.com>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
Subject: [PATCH 1/4] dt-bindings: misc: tmr-manager: Add device-tree binding for TMR Manager
Date:   Tue, 28 Jun 2022 11:13:35 +0530
Message-ID: <20220628054338.1631516-2-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: e27eb48e-f3e5-4019-6b5e-08da58c92f35
X-MS-TrafficTypeDiagnostic: SN6PR02MB4975:EE_|BN1NAM02FT048:EE_|DM5PR02MB3846:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: St25eJ0ApQHa+4DVwhmt9P9nFpmhrEdse/Bfz58QlVX8mCiHDRfWK4Ui7KJthDbJXWfwEOFja+ZPfXV4nv34QiqGODPE3gwaO6UMSzmyV/Kx7RTrySFxhUUYhVzELjOQtp1tc4D3vswVtQC6F9J5yJlXMc7VcyhIN7wUMBGH184mD+S1GZPXxqDPc4NxzR15klDN2pFxpR9VWMtqXfwS/45+5ysNTd0wGDsT/sMiio/GbcpTQ6i/gkA7ljBnYSZmteCZL85NQIcDBegmsWFxzmA8jThk90aQiMl3YRnVrLf2ulTxMiwupw06rz37xo0cNr9bEX7akCeko6+YQ9oTnvcRlID4XM46syjGyOqaO9aWmpBa+8lw9J+SNm3z1JImjWEaMj+wIppmfAHAu+hzQrnrndtzsvrcqxOZKxXy6hlFwZluj/fZFdoBnmjvIV76mtYzqHUeruOnA9pP1xWGdeWRXVlpFATsBEKsW4Bzq3d3lAuyS7HNWe2LXuFzteKT+lnq9iHNOo6ewDmtAqJyEU1V8GfX2+YVug4YHkmr7rOtaKESR3h7ceeeoUvl6BBDW9LKC7SxpEG3oESn8W0fGHSJ4a4urMRrk/Pnn3ulBjkhh3aim3sNBVeW61mqF78Aqp2CRF1Aa7ufRhZABgifnEJcO7eA0ShPfFn1wL4T4mx9QnuItJFPyOLm15altCdkUgugSI1Xbm3uvjUaQqPB7xIxe5q/wIzpDu3O8DnxyTs67ylPa2xbtxpeTgYI6bxNEhAN4KVqcCZjxppLyDtZjIwg5ROAVFKZJoMfT54s7UvEWWEbMm7ZdJdu7E1hUIU1y8kSmYESuT7SQqMVXJSn3spTi44s1BIHT2uj7nM1Tn7HHgtc+KRkWmp7ZzbYN4Jn1+T+hl3+IK1hPW5z3TEXLiGgKlpwAdggyzYrqOrPkjg=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(40470700004)(103116003)(4326008)(7636003)(921005)(8676002)(426003)(26005)(83380400001)(47076005)(356005)(40480700001)(70586007)(70206006)(7696005)(82740400003)(186003)(8936002)(478600001)(40460700003)(336012)(36860700001)(6666004)(1076003)(54906003)(2906002)(966005)(316002)(36756003)(107886003)(9786002)(5660300002)(110136005)(41300700001)(82310400005)(2616005)(102446001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4975
X-MS-Exchange-Transport-CrossTenantHeadersStripped: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e2a6ce12-d1b9-4b47-2b70-08da58c92d30
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SNr67rePmUgZYoSxgmm4rqd6j6Dhw1drkF6Mp3TMQjhVpVpszaHg910FF8m1?=
 =?us-ascii?Q?axyG5qoYFAfsYhhv81lmLiGePCTvuSuBa1UZuf5gm3vvHxVzKE8keA/vGz83?=
 =?us-ascii?Q?kK2PPggsBAaRaGIYQEsM4Ad1YWruKsGtN4Ra8oYsPq6gG5d2TltHxIrCeBxU?=
 =?us-ascii?Q?71OEDg4pXB3LOY3RZkRkI6X6J/9SZgoIWeif6BHmm4okiEZvBtlkWp5JyfFS?=
 =?us-ascii?Q?on2X4uNQk/j00cEgXxRRznxyxJO3MtqjNsZkXqSKssObbO1Z2SUzHpH+RkIa?=
 =?us-ascii?Q?AstNI/Lxa9yqTIeGyamc1oKN4uLUZmaACqDB8FToHMStC+oxMgm3pGr3nbXl?=
 =?us-ascii?Q?SkxYW9j1FsayuVz+Cmjx1YboBojJEoM88CpTwXCjd424PszMddaHGyHyMzqD?=
 =?us-ascii?Q?InNnSbKxKTTO3JCfKKwwIRB6kuVYT/P/RkEo0VXpRayi2gnblXmfyqXQP14V?=
 =?us-ascii?Q?xOkbJeyGSvBADNspxSQqjCetKEaJ8/3Obf6tossDScxBY1ZLIz8+HhPTfyAo?=
 =?us-ascii?Q?cj2o31/j7PG3iEXitVt07UOvXolvU1qnCEGc06x1GpFgkk4OtZQYEhiqyV4k?=
 =?us-ascii?Q?Jwba0K19UFDiR4YLhuS+HbGIe9PDyUAvHRvguAhHl1gswpb2DozcaHnJd/+G?=
 =?us-ascii?Q?x4LesZPSmZYjSOc6hZi18nTQxw9+EFa2qC1EYybEAHXbwg5UdvcWP5AaKxTt?=
 =?us-ascii?Q?CwU9kX2LQbXLqbcgoj2lt7F1sUzKsD387T2i5g6E51gbO7aJwGRmgoBLheSo?=
 =?us-ascii?Q?9QDON54+oayrAxxkjQWHdFUJxkXm69e8no+z6yEIcDO2FOfC+sFpc3mHb2NX?=
 =?us-ascii?Q?0LHHeUHZ2t09rPAJmiJr8SxWOF3Xof/Axz7HqSyR2skma354FD+yMx7lacNE?=
 =?us-ascii?Q?ffewRUN6Q/wsY83WnC1aXmnYN5qdsww3OT451gh2SMOftd6Il07WqBhQcwL0?=
 =?us-ascii?Q?SRSUeNcf46/qjkcnByV93w=3D=3D?=
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(40470700004)(36840700001)(46966006)(36860700001)(921005)(41300700001)(8936002)(7696005)(103116003)(5660300002)(2906002)(82740400003)(6666004)(4326008)(83380400001)(70206006)(8676002)(9786002)(1076003)(26005)(966005)(40480700001)(107886003)(478600001)(54906003)(316002)(2616005)(40460700003)(36756003)(82310400005)(81166007)(186003)(336012)(110136005)(426003)(47076005)(102446001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:43:52.7703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27eb48e-f3e5-4019-6b5e-08da58c92f35
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000001.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3846
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds documentation for Triple Modular Redundancy(TMR) Manager
IP. The Triple Modular Redundancy(TMR) Manager is responsible for handling
the TMR subsystem state, including fault detection and error recovery
provides soft error detection, correction and recovery features.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 .../bindings/misc/xlnx,tmr-manager.yaml       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
new file mode 100644
index 000000000000..f6cb4d235981
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,tmr-manager.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx TMR Microblaze Device Tree Bindings
+
+maintainers:
+  - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+
+description: |
+  The Triple Modular Redundancy(TMR) Manager is responsible for handling the
+  TMR subsystem state, including fault detection and error recovery. The core
+  is triplicated in each of the sub-blocks in the TMR subsystem, and provides
+  majority voting of its internal state.
+
+properties:
+  compatible:
+    enum:
+      - xlnx,tmr-manager-1.0
+
+  reg:
+    maxItems: 1
+
+  xlnx,magic1:
+    minimum: 0
+    maximum: 255
+    description:
+      Magic number 1, When writing to the control register the first write data
+      byte (bits 7:0) must match this value in order to have any effect on the
+      nominal recovery function.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - xlnx,magic1
+
+additionalProperties: false
+
+examples:
+  - |
+    tmr-manager@44a10000 {
+            compatible = "xlnx,tmr-manager-1.0";
+            reg = <0x44a10000 0x10000>;
+            xlnx,magic1 = <0x46>;
+    };
-- 
2.25.1

