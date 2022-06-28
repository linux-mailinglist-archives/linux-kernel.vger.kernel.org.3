Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978EA55DD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245138AbiF1Fou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbiF1Foo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:44:44 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D072A1E3D5;
        Mon, 27 Jun 2022 22:44:42 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=FybYvLvogtBzvtp7wuWUy7n5iIVzT0ahrPC4edN/D1ZgWQ0yNjp3TER3tOA7UWl6Un/ifm0tPSPsPcB4CLSdhqMLvw4ybbHbBFWaPzfn0sINtwjJJB+2qyD1KmoWOKC0WoY9CP4zzq5R5l3gLinCQItCco0/9WaHtBPl+FcqCjPpf2za0PtJ/3nEEHXkInHKxcPQh6NGR+p7KcPLS1JPTFih6fHFe7IqiOcbP650pGqBhbceAdodPMJ9pe704k0REknb5/iankboZFQT27qJ5JPZRlgjRZuEwDIh9OUtxyLuoNPWnZPETarySy7NsPjGbqRuMpj+Fd5Ivz4j1xWZaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2jLdXMcTf1cTwkOzltrXEIYxyozG8BF1A8HEFo8JFU=;
 b=Avh8kDT/aUSQJLEKH48B0RyEm2B+VHjmK241sp/rQ7mgp6YRcgUlJ3IV51EUzqHgE1egqNHdNgKEKyR71Fg4i7HbINzdcXpfnzWKYbTpYGyq/L66iGKL1DGA2lpMv9iteQMLaqpchCMSVpHG7r7Y72lf9cPM6UTqrKT3JS1qRZsvdwllhGdrExjT/0QY7z9wU2imU4wyUW0wyKzp8CXy1nKo9BC/FZraqoosLl7CbtMf3Zzv7D/2KpSNmEe9Smq4l760m7DfbwgjNQn//8vHBZLDBI8A/UqA3mKW8HfW0SzyeGe/CftNDVmftLB7M3vRsApJxYKNELd82I6WCOsnGg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=xilinx.com; dkim=none
 (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2jLdXMcTf1cTwkOzltrXEIYxyozG8BF1A8HEFo8JFU=;
 b=AFRjIaoxXsn8vil7fzKUN38Vlvk6hpLVvuu3+uavhRuw4hAEnJwxSQMypaQQ04CLO7ZeSo9L3Omn5qLWMptXBaFPShq1drZTV0q7EP7MaLLnkVq9N4kkB+6hhi+LSDz4z+kEJD0PO3QWthc8EbmQeqAPn3qls9kZxk2KmkzVY4s=
Received: from SA0PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:d3::19)
 by MN2PR02MB6208.namprd02.prod.outlook.com (2603:10b6:208:1bd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Tue, 28 Jun
 2022 05:44:40 +0000
Received: from SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::2d) by SA0PR11CA0014.outlook.office365.com
 (2603:10b6:806:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Tue, 28 Jun 2022 05:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
 pr=C
Received: from
 mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by SN1NAM02FT0047.mail.protection.outlook.com (10.97.5.120)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:44:39 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id 70D973F04A;
        Tue, 28 Jun 2022 05:44:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnzcftfHgf6HquxEirBqht64x/9KM2caAyq5h7AkNGS7DJBLwXOn9JhNiMEC3X+wLdwGrx72SHicTFtYo8f1BR6RJm3zpgSqD2/hpsgs2gNYAyR8J8sDV8SCeGwMnrpxQiCxio533eCA/A+z36B6Pvk9zko54XEqzdZ9rFwEc+8cM715BAVeZckfR7jNjq5I7qxTOJvs4IqMjJyI0PwupksYJVFXzPTY0ctR9njCOELg3f6u4/QdNOKJDXgSAp+JJc9L/WH2Rav4O0saTFmYrRndS78cSfrvE9zD+GTGFBO/JrLLu4ri6MjZgwtOe5mkgkMumGGmZJIOe4GrBL8tdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2jLdXMcTf1cTwkOzltrXEIYxyozG8BF1A8HEFo8JFU=;
 b=HgWjVSjaK9Waz7EHAriW0yYSj49my+Datc6nRm0Hh3iQ+vuckogzsqqvcQvfJpCHteNqx7SjcnBpRuCwE+m/0In2GqAm0pf4wPsU6wLBs9vgd1oudQwBsGyKgsrdPKZRwMrtlURjpTMJT0g6HK0ZcJNOFzUh5M8b6mRuqxC1Qan8Aa6HdHtqo3fCQp6OROHLZS9XK/kw6S18bxVuVUJFJj7AG2eI8A/JC4E3tcOu46sZEhPCz38K98vEGjhbgQxCcg4TXXsf4ryFuxaUJfI5A247aohsIgLi8hJCfFpuzjQG+jaSh0wu0UcqUm287c0u40rmDQ/2C1SM3QqnziWh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from DM6PR02CA0151.namprd02.prod.outlook.com (2603:10b6:5:332::18)
 by DM8PR02MB7989.namprd02.prod.outlook.com (2603:10b6:8:12::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 05:44:35 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::27) by DM6PR02CA0151.outlook.office365.com
 (2603:10b6:5:332::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 05:44:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Jun 2022 22:43:59 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 27 Jun 2022 22:43:59 -0700
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
        id 1o6410-0007Ut-Ei; Mon, 27 Jun 2022 22:43:58 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <appana.durga.rao@xilinx.com>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
Subject: [PATCH 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Tue, 28 Jun 2022 11:13:38 +0530
Message-ID: <20220628054338.1631516-5-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 059f37f4-887e-4015-6155-08da58c94b42
X-MS-TrafficTypeDiagnostic: DM8PR02MB7989:EE_|SN1NAM02FT0047:EE_|MN2PR02MB6208:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: b39ZkRPtbrf13ULM21Vee2YQoAIriTnvdinDxfLwcdRxt1BcU0ZNfpkGQZaG9NWmoHwQB3kUZWwsjNLUzBX54tejMQ3XvEhJvmlCU5aImAoKfvvVxMSEHNhuD9NGWBOtEgOlO0ACX0NnzuzvHFggLP9TEUgTCHrt7iVCb8PsNT4lwA7HOC95mNANnFIqB4gksyyV2H8L0MNh1FjLWdR3DePrQlMtrifDE0RdBj6tzXhmxNKQRIIvZ1933luoLH2Rx69d1tEj56ZHjRzx17i55ezP4mfGrwlEbm4h0yEf33Ya+/Pxdyzqm7NlXnXZ7uvz33fRQrRIh+MBLcQYmOE/BO2LdPnKoIjQ8Qm1m12mM6ZTHk16TXHgvMitCrMnJH4LcRYFSrV7AQuXa2E1tBPlSEzSJcVbVe+9h9V1A5fvUrUskCQP5O8TrFft5LqxgoNTxmkyG/TABhd3C8MFzBKHlR1YJnuCjW/FsBACz7cTruv0+yxOHEQEvxuTsDKeXLnRVxWWVTyy/2/q0bjV1upIxsji6soPlX3MvJb3UBbmoUbM2QYG58p2DwoEDyvSecJOcSBcPT7bIkysdD7Pa9URTSIvfSBlgDXP0Mej1BtCZKHOYX8iKu2J8f1x8X59Z0BOWOx5QPcPUH04iqWZtrJicYojf17pN1t0bkkCJpB61lWazxQzDlfLA3JLKgzlUviTc5MDjgEVPCLLvHKHdaOXqsBGK/APSFV+olvgGwL0UvHCYCGwRN/7sErmJgKap9zMM8eSoMRBjDGCHv5WEN2VdQv452yX+JjTNeIFiEvBYzswdN+SNZ0e7Ae223l0kB5Eo2Al6uE8cNMyXUey6hILOTdGxBe006EoVK1/U49fTQg=
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(36860700001)(107886003)(2616005)(54906003)(41300700001)(316002)(83380400001)(110136005)(8936002)(336012)(6666004)(478600001)(186003)(47076005)(5660300002)(1076003)(40480700001)(103116003)(70206006)(40460700003)(8676002)(26005)(426003)(7696005)(4326008)(9786002)(70586007)(7636003)(2906002)(82310400005)(921005)(82740400003)(356005)(36756003)(102446001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB7989
X-MS-Exchange-Transport-CrossTenantHeadersStripped: SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: af634646-1f4d-4773-ec9a-08da58c94885
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jwvo50XqW9rQS1K40v/9TfaSzC2k14VY011dD7H1LPaej0jManQakvOM/ikhhJ69jdhckIrMOWEWL0m21+JigN/0e9QHC42GS96mkTma2KpczOGJlEnuDbYrQLogEMq1SkX48EUg0yKjnqzeQEcYxbYBwc+hHETW+lTbqVSIN3hwqBOo8np9GcQITFgNLU2bi5SrCsgYU3sSLyohpNmdNDyajrjR3BsbWO6pGuyjsoJUa2p08HYjbrCx4xpwRMBQUwb4Kl15bDtWOYjx/VCBByi29gzhUL5tCQSHufkp0RX4lnkG5LUIAF304sVH5/3y0U4FKoWGJGtbFVsBh5dUaGUtGRzj0knFsHD4NZS9OhtjEljhVg93v4zirzU+jdNdZXcT5+LUR6lzgotvpQtpzaBRNi/wxMBQkLa1vA0Q+fPx2ziuMI4xm+w5F9tCxEqyKyqLzIGZ4N02MUfg73E+A2Z6E7IDhQkbOKUgnub2Zz4PVS1BHsT6tVzbOOUzE8/cPtKtcTEpBL1gkLQa2fI4GkQLM0ag1RCstBbzqpwGXrS+3s1LGxRo+n+G5ZIphD0hExt0LQ/MR2zucLdqXUWneJMFzS6KIjyN04dDchVIqKNDsBLK/j0kNDEd73CSCZrUoo/AtKuNGzTwS6OcuHgUt2HgLSljlCvEN1TpdR6aplfAQjUTP5t5qb47wWNu964yqw648+3vkfCTLd8uan7mRnRDTTXn2Zzf8uXNgXqb42N1yu7CeRZY12aiOwrfNPTSEkRaOoV1/ksueSfZ46dqMCo8q2/CZvyHPJ7xpCUdN2fAYbyQLrd2oP+3TWBtWuMGLro6Tq1ukq/Fe6i7xqBAsN+lWOnhKJCO27AtDn+LUeZSlu3zcd1jnFsdwbM0bKzm
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(40470700004)(36840700001)(426003)(70206006)(40480700001)(103116003)(2616005)(54906003)(6666004)(336012)(107886003)(83380400001)(5660300002)(26005)(110136005)(7696005)(186003)(40460700003)(47076005)(921005)(1076003)(41300700001)(36756003)(8676002)(82310400005)(81166007)(4326008)(82740400003)(8936002)(2906002)(478600001)(36860700001)(9786002)(316002)(102446001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:44:39.9252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 059f37f4-887e-4015-6155-08da58c94b42
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6208
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) provides functional fault injection
by changing selected MicroBlaze instructions, which provides the
possibility to verify that the TMR subsystem error detection
and fault recovery logic is working properly.

This commit adds support for fault injection, provided
sysfs entries which allow the user to inject a fault.

Usage:
echo 1 > /sys/devices/platform/amba_pl/44a30000.tmr_inject/inject_err

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 .../testing/sysfs-driver-xilinx-tmr-inject    |  12 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/xilinx_tmr_inject.c              | 201 ++++++++++++++++++
 5 files changed, 231 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
 create mode 100644 drivers/misc/xilinx_tmr_inject.c

diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
new file mode 100644
index 000000000000..373a5964cee9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
@@ -0,0 +1,12 @@
+What:		/sys/devices/platform/amba_pl/<dev>/inject_err
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file allows to inject fault using tmr inject.
+		This file is write only.
+
+What:		/sys/devices/platform/amba_pl/<dev>/inject_cpuid
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file allows to configure the CPU identifier
+		to enable fault injection.
+		This file is write only.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3d29109788ed..1446c5aca9e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12969,6 +12969,13 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 F:	drivers/misc/xilinx_tmr_manager.c
 
+MICROBLAZE TMR INJECT
+M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-inject
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
+F:	drivers/misc/xilinx_tmr_inject.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 555ae2e33b91..0989c36f3051 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -493,6 +493,16 @@ config TMR_MANAGER
 
 	  Say N here unless you know what you are doing.
 
+config TMR_INJECT
+	bool "Select TMR Inject"
+	depends on TMR_MANAGER
+	help
+	  This option enables the driver developed for TMR Inject.
+	  The Triple Modular Redundancy(TMR) Inject provides
+	  fault injection.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 28b9803f909b..e9d0a709e207 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
+obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
new file mode 100644
index 000000000000..e458d6d35ae1
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Xilinx TMR Inject IP.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Inject IP,The Triple Modular Redundancy(TMR)
+ * Inject provides fault injection.
+ * Fault injection and detection features are provided through sysfs entries
+ * which allow the user to generate a fault.
+ */
+
+#include <asm/xilinx_mb_manager.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+/* TMR Inject Register offsets */
+#define XTMR_INJECT_CR_OFFSET		0x0
+#define XTMR_INJECT_AIR_OFFSET		0x4
+#define XTMR_INJECT_IIR_OFFSET		0xC
+#define XTMR_INJECT_EAIR_OFFSET		0x10
+#define XTMR_INJECT_ERR_OFFSET		0x204
+
+/* Register Bitmasks/shifts */
+#define XTMR_INJECT_CR_CPUID_SHIFT	8
+#define XTMR_INJECT_CR_IE_SHIFT		10
+#define XTMR_INJECT_IIR_ADDR_MASK	GENMASK(31, 16)
+
+#define XTMR_INJECT_MAGIC_MAX_VAL	255
+
+/**
+ * struct xtmr_inject_dev - Driver data for TMR Inject
+ * @regs: device physical base address
+ * @dev: pointer to device struct
+ * @cr_val: control register value
+ * @magic: Magic hardware configuration value
+ * @err_cnt: error statistics count
+ */
+struct xtmr_inject_dev {
+	void __iomem *regs;
+	struct device *dev;
+	u32 cr_val;
+	u32 magic;
+	u32 err_cnt;
+};
+
+/* IO accessors */
+static inline void xtmr_inject_write(struct xtmr_inject_dev *xtmr_inject,
+				     u32 addr, u32 value)
+{
+	iowrite32(value, xtmr_inject->regs + addr);
+}
+
+static inline u32 xtmr_inject_read(struct xtmr_inject_dev *xtmr_inject,
+				   u32 addr)
+{
+	return ioread32(xtmr_inject->regs + addr);
+}
+
+static ssize_t inject_err_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t size)
+{
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 16, &value);
+	if (ret)
+		return ret;
+
+	if (value > 1)
+		return -EINVAL;
+
+	xmb_inject_err();
+
+	return size;
+}
+static DEVICE_ATTR_WO(inject_err);
+
+static ssize_t inject_cpuid_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t size)
+{
+	struct xtmr_inject_dev *xtmr_inject = dev_get_drvdata(dev);
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value > 3)
+		return -EINVAL;
+
+	xtmr_inject->cr_val |= (value << XTMR_INJECT_CR_CPUID_SHIFT);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_CR_OFFSET,
+			  xtmr_inject->cr_val);
+
+	return size;
+}
+static DEVICE_ATTR_WO(inject_cpuid);
+
+static struct attribute *xtmr_inject_attrs[] = {
+	&dev_attr_inject_err.attr,
+	&dev_attr_inject_cpuid.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(xtmr_inject);
+
+static void xtmr_inject_init(struct xtmr_inject_dev *xtmr_inject)
+{
+	/* Allow fault injection */
+	xtmr_inject->cr_val = xtmr_inject->magic |
+				(1 << XTMR_INJECT_CR_IE_SHIFT) |
+				(1 << XTMR_INJECT_CR_CPUID_SHIFT);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_CR_OFFSET,
+			  xtmr_inject->cr_val);
+	/* Initialize the address inject and instruction inject registers */
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_AIR_OFFSET,
+			  XMB_INJECT_ERR_OFFSET);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_IIR_OFFSET,
+			  XMB_INJECT_ERR_OFFSET & XTMR_INJECT_IIR_ADDR_MASK);
+}
+
+/**
+ * xtmr_inject_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation and creates sysfs entries for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xtmr_inject_probe(struct platform_device *pdev)
+{
+	struct xtmr_inject_dev *xtmr_inject;
+	int err;
+
+	xtmr_inject = devm_kzalloc(&pdev->dev, sizeof(*xtmr_inject),
+				   GFP_KERNEL);
+	if (!xtmr_inject)
+		return -ENOMEM;
+
+	xtmr_inject->dev = &pdev->dev;
+
+	xtmr_inject->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xtmr_inject->regs))
+		return PTR_ERR(xtmr_inject->regs);
+
+	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic",
+				   &xtmr_inject->magic);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to read xlnx,magic property");
+		return err;
+	} else if (xtmr_inject->magic > XTMR_INJECT_MAGIC_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid xlnx,magic property value");
+		return err;
+	}
+
+	/* Initialize TMR Inject */
+	xtmr_inject_init(xtmr_inject);
+
+	err = sysfs_create_groups(&xtmr_inject->dev->kobj, xtmr_inject_groups);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to create sysfs entries\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, xtmr_inject);
+
+	return 0;
+}
+
+static int xtmr_inject_remove(struct platform_device *pdev)
+{
+	sysfs_remove_groups(&pdev->dev.kobj, xtmr_inject_groups);
+
+	return 0;
+}
+
+static const struct of_device_id xtmr_inject_of_match[] = {
+	{
+		.compatible = "xlnx,tmr-inject-1.0",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xtmr_inject_of_match);
+
+static struct platform_driver xtmr_inject_driver = {
+	.driver = {
+		.name = "xilinx-tmr_inject",
+		.of_match_table = xtmr_inject_of_match,
+	},
+	.probe = xtmr_inject_probe,
+	.remove = xtmr_inject_remove,
+};
+module_platform_driver(xtmr_inject_driver);
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Inject Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

