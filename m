Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D7C4D21A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350034AbiCHTgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350025AbiCHTgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:36:38 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F85468F;
        Tue,  8 Mar 2022 11:35:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4fBX2ltDCjVhPzIWbzy2akpkNkAhUyuy/THYu89PtvKszEG6Z0bSlALoM0aYqO722AtMqO7N1zBQUfel+Nc81pLUadAxjn0YHT3kmSEf7xaURZwR+3ieAZpbpCGUeltid4Ail29cIFp0A362qiM1qASDyD+RsksPUarSrkJNS/drJ2jqrBfWxAwyP3EHaJu35fDlEbALM4XI0NliN8NH105IsbKyR3oX9FwVnfYIxIyGpBzpgUGUDHyxIZgTZyPviVN13bb1J+jzG7xfv6nwrMKi9GB7bJWDeJ8S4KBYWNaTguWqBS0Zu1T4On58W+Co5m+J+6ZA8BIQzk0M4BgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUWnqjEooCMHfDA18ZtjDNa8xSV23GItkW88ygAx4H0=;
 b=eT+8ycE4SwG5hO3e00Vi4WJwxs6Kvbxg1AqlR8xqM5b8oXjJbWI0pV5PUH63LpXYVdCcUkEAkqqs2FAV2pw2ipSSJH8AeKw5RC+4QQnbrfU1zvGgtVvcuXw4n6gRFtpAdmajHR01BAc2MLsheRzxNJ3YnSIjBE4/8UwmbhXydQSW0D/pySyy0aJaLGY+JStkoOiWEEe71NZEMqAY+wUt4FAWs+fFtvxBbx4wLqjmu1Ow60YmvVP7TWhogQSaTtUls6bELRtDNbFuXotcwhDRmkIwmJp2u+FOn2mC4qdfqJuXOjJboKpCtDx2gyvyp7W0A3hcyv/zyrCEAcIj9oP4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUWnqjEooCMHfDA18ZtjDNa8xSV23GItkW88ygAx4H0=;
 b=vURgsnOrTWX3/0q11Tbr5fww0MAKxcxdwnpaJZq02uc2HTVEvMfJry2MBaXUnGI83PLldhea3kZOVt/CNLm/2TwA2NTGFLLfKdUTbhAk9+WV549+5/9r6b+8K/FckaRe4/VYTxq2+LCt+VPiCf/L+iN6w7JHI2I0xcgjihEMaiZT1XFNiSPsMR8jkSNkeS1zhm1y1mL7DTUfTK1JQw3pa/VY6d5aE9B8zDwX70GjQIv3DOQAVRnvNpi0QXRqZ4ARAaVlRFp6p85JggYIhDf79K36BGKyNH+27Kl1Wh0VQN1JQD1sPgYjR8WDYUBgoI2NUdA94kQhzVvOSIGt9MdtBQ==
Received: from AS9PR06CA0342.eurprd06.prod.outlook.com (2603:10a6:20b:466::18)
 by AM0PR10MB3667.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 19:35:35 +0000
Received: from VE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:466:cafe::7) by AS9PR06CA0342.outlook.office365.com
 (2603:10a6:20b:466::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 19:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT024.mail.protection.outlook.com (10.152.2.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 19:35:34 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 20:35:34 +0100
Received: from localhost.localdomain (167.87.32.5) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 20:35:33 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 0/2] simatic-ipc additions to p2sb apl lake gpio
Date:   Tue, 8 Mar 2022 20:35:20 +0100
Message-ID: <20220308193522.26696-1-henning.schild@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
References: <20220131151346.45792-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [167.87.32.5]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.394800-8.000000
X-TMASE-MatchedRID: VCPemTal8VH4zHUf+U0L+YImdMh0fJGTRdvJFOk47xdswYo64ufkVaIa
        zKtJxIUHXvSWyok2Zx7bFFDOPuSQzIw1TMOkyb7hgd1tkLHrKtH0gpEqM7fvYQPZZctd3P4BhVD
        nkfzD7uYGmHr1eMxt2V+vEFKOZZiQ4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vi+DQ2ftY/Uqb9p
        0Hd2aQf1lvxOqf/EXskMy8kDnM560uHUAww70Mjw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.394800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: E07EF1879E6A395D4B4868F54B058D85E1DBB5FA5DDC9E79996FC8B3D44FEA022000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ee05ab4-d670-42d3-71ee-08da013ad0cf
X-MS-TrafficTypeDiagnostic: AM0PR10MB3667:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB3667934B80FB8978F1D3866A85099@AM0PR10MB3667.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTgNiG1n6eVjSERToGjo+QUT7yX06e6wKH2AQ3x4D3BH213A0jJtmr/KZ1LQaLihWLW1B68WTUnSpn3aTMqG+oLKqL3Gk5KmCeyxC6SQQlfzoO96w7X7hEgWjCJBka5p/djhH3yc/OEBckQnzPwMlRvIeD5JQj3rUHTbsslFtJ3BhIZGYtFoBaCbcoOeNR0XVmq0M9SSomewRBwhB5JEqRXgkQXZ21qYt8e6R+JD174r8mHjhqrnslSCQjO68yGfLQaEKuh73FdoFmYVbQlJ1t8yCVGzhe1DDSj9Oo8tcqO0GKfYDl8cQUqfpCEtEBKIE14nyvqn78xsDJJU5qdlsmD1OlnFYEBd5wN7tAwITGZqU7f7IXFblb/faG4gXGbveajWhzAmbLbggFD8e7T8F//bXj+o1yU8XWf5kDGaA5NLDuyTGxlyV4KKYbSQLdVD1227uF6pIhD7HIaNDAKv2RTOig5wevkeCOHz5qOEPlOWfUEc98YSQVRJGOWrdtw92zl3qU+NCHBMkXt5DfIk2dy9/jZyaszEurszEyvdYGm8c9/4kLV30GUqwypW+e1SHAtssRYWKoFZL6/RSJBquSO8iKtdv9ilFz8epUDrnDqj2mFw6oSTy+JK9Ndo98XN3i+lcwfXqb5XOVWSV3/iCLJjeU2vfwJTXa0SjDhjatGBRDQjVGdx37HSFaA5RiK7Nk1BiJ6EyGI5VVQOOQk8PA==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(107886003)(70586007)(8676002)(4326008)(70206006)(2906002)(86362001)(36756003)(47076005)(316002)(82960400001)(336012)(82310400004)(956004)(356005)(81166007)(26005)(16526019)(186003)(1076003)(6916009)(54906003)(44832011)(36860700001)(4744005)(8936002)(5660300002)(508600001)(83380400001)(40460700003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 19:35:34.8864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee05ab4-d670-42d3-71ee-08da013ad0cf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches the simatic-ipc modules to using the p2sb interface
introduced by Andy with "platform/x86: introduce p2sb_bar() helper".

It also switches to one apollo lake device to using gpio leds.

I am kind of hoping Andy will take this on top and propose it in his
series.

Henning Schild (2):
  simatic-ipc: convert to use common P2SB accessor
  leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver

 drivers/leds/simple/Kconfig                   |  11 ++
 drivers/leds/simple/Makefile                  |   3 +-
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 108 ++++++++++++++++++
 drivers/leds/simple/simatic-ipc-leds.c        |  77 +------------
 drivers/platform/x86/simatic-ipc.c            |  43 +------
 drivers/watchdog/Kconfig                      |   1 +
 drivers/watchdog/simatic-ipc-wdt.c            |  15 +--
 .../platform_data/x86/simatic-ipc-base.h      |   2 -
 8 files changed, 139 insertions(+), 121 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c

-- 
2.34.1

