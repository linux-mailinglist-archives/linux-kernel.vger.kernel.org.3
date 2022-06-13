Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370075481BA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiFMIHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 04:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiFMIHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 04:07:05 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140042.outbound.protection.outlook.com [40.107.14.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA443193D5;
        Mon, 13 Jun 2022 01:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfCCHeYJ8zrTKa83M09fIor8UPAY/a6Mp6uAu4/DJOuIg/5x+RfYGlckwfvCpglAXEHTRHLIxLeh+AjQRDBl91q3mnenaRJpQFgi4ytVklE21WT8/WRWZUxwdNJLDasQnyL0GI/LFp3PlvtP+rqpNAlgi1TTW1jnbQqB58aHKWLyPqc0xfGlor0BnYz5HPQd/2fzZaMwfKxftYwLf1f23dDRyQ1dA+vKH3jEuGUF+0lViClRbn4RQGjpSiwdvi/oqi/YoirvBnaKQf5N9dxGzxL63Eq8qmzgZLh/4P4B04QAHdteoNMIo7k9WSejBNHiOMIEVw2jXCzusMK0B7/zog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+z8i+TTJOQm4Q0Gx2DPrirk9BczMLmUDhv/Pbe8A1gg=;
 b=GkSPV+AmrlnVpLG4YpUFV6ISNLHKx/jCe/KtTgwOGgwcD+GAC9cPuLNmpnIOpxZbhICdoed6D8fzgYY/K+Ijjn+IRqtHZrmqiWmQxzxXEDQkXZdaOGwHHuq1ZaU+/sT6PJ+TAqvcDMEhiWe97ipILvLax9Q+A/MB1Nb33jc57y80LFfIUy1QABaZk/h7bndv8yGSX0tRzPrG4bWtDsw2eQ5WQcn2Alx/NQbPnFyjRCxBoADqZtIzFniJjrCSxBcpho0OLzbjygJm5k470h7AY4NjYdvJFxj7pCwbQfBmZ3bw3qaSted+v5DPWt4jZ5pmUtlSdN3D8E10gwhchFOdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.200) smtp.rcpttodomain=linaro.org smtp.mailfrom=in.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=in.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=in.bosch.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+z8i+TTJOQm4Q0Gx2DPrirk9BczMLmUDhv/Pbe8A1gg=;
 b=LPgvKyZVjmlTcK7aekiaARnJ3tREkGb90ycDZmbpYFWbZ9pc+6pXCSXl72BK7TnJBrQWf3oJK0ZrXkOeZQDTXkOjfJbKmo5mzKALezF1JSQnyeMzQxgPBtMvINETRub1bF2l8kg1QHwFXrvfcBDZh9jHjwNAsmLx08g3T2sFyFc=
Received: from AS8PR04CA0148.eurprd04.prod.outlook.com (2603:10a6:20b:127::33)
 by AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Mon, 13 Jun
 2022 08:07:01 +0000
Received: from AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::54) by AS8PR04CA0148.outlook.office365.com
 (2603:10a6:20b:127::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Mon, 13 Jun 2022 08:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.200)
 smtp.mailfrom=in.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=in.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of in.bosch.com designates
 139.15.153.200 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.200; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.200) by
 AM5EUR03FT006.mail.protection.outlook.com (10.152.16.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 08:07:01 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.28; Mon, 13 Jun
 2022 10:06:58 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 13 Jun 2022 10:06:57 +0200
Received: from localhost.localdomain (10.167.1.123) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server id 15.1.2375.28; Mon, 13 Jun 2022
 10:06:53 +0200
From:   <Gireesh.Hiremath@in.bosch.com>
To:     <krzysztof.kozlowski+dt@linaro.org>
CC:     <m.felsch@pengutronix.de>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <bcousson@baylibre.com>,
        <tony@atomide.com>, <robh+dt@kernel.org>,
        <dmitry.torokhov@gmail.com>, <mkorpershoek@baylibre.com>,
        <davidgow@google.com>, <swboyd@chromium.org>,
        <fengping.yu@mediatek.com>, <y.oudjana@protonmail.com>,
        <rdunlap@infradead.org>, <colin.king@intel.com>,
        <Gireesh.Hiremath@in.bosch.com>, <sjoerd.simons@collabora.co.uk>,
        <VinayKumar.Shettar@in.bosch.com>,
        <Govindaraji.Sivanantham@in.bosch.com>,
        <anaclaudia.dias@de.bosch.com>
Subject: Re: [v2,2/4] Input: mt-matrix-keypad: Add Bosch mt matrix keypad driver
Date:   Mon, 13 Jun 2022 08:06:38 +0000
Message-ID: <20220613080638.1339-1-Gireesh.Hiremath@in.bosch.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
References: <20220506072737.1590-2-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.167.1.123]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b7252c0-d18d-4721-08c7-08da4d13b20b
X-MS-TrafficTypeDiagnostic: AM0PR10MB3140:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB3140D2DED762A544CDCBEF10A6AB9@AM0PR10MB3140.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PvEhW+eSx26Jc36Fcw0miJoOvRNwF+3RSwwZoYdQYonhC8x7bnNH2firGKQNYicskAJowa1epjool3U8e6OVMj1Jtrz7ZgcDaJOJ3D5Z9TWEaYdoxKeoqWR+IoZkiX4U/uTNkMagR3inTmqwnmsQH+Yfv5ICBZe+FoBs+AH853BsUauhJXZ6h99K4aYCEiiHBMdSTw3rqov8maED5Oxl68I2IgdBZLWa8/2BF0uBWoK2T6Y0BJZhaOfnbywrYt9KD8C2VwR9novMEMjrupe86jsNJS5tAV49zHUGvHdlgjx/mkX2PIt50+D/jLoskqIxn1aYolmtpXHgYVG/1Zs9hwnXfjRPk3DSb5wixF4yh7WzhQ7vUwzRznRX1hvCuCJijEvlof9WISs3axIfu4YEoQYLcQLyMd5cjMCC/IAxQKHuNP/TS6CxaEcSqbCpRzrktCx+jh1qmlb1o/yfsu1GeKKTn7vipMIHvXbypNsjWTYCU84olWY+hcWBQBeoRNdmndmxENbnr/ja9gE6OqHs2TrPx/PqMvFyV1ilISi4vgbMB5fZcpTe4YD/q/wrbpBZmQ7+3a0tnN3wRE3hpDbAr9RX2NRmwJW39rjUdqtub+VWaSScrgamsdxoqPqifVRZgsq6iCTTkFIOFU6I4S7wSfebhb/muS5Brm5MBvB17aj5341bEHMsHyfxdR1XIx/o+D/z8FhKyCte5foNzWcfyw==
X-Forefront-Antispam-Report: CIP:139.15.153.200;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(4326008)(316002)(1076003)(6666004)(2906002)(186003)(16526019)(47076005)(70586007)(336012)(81166007)(2876002)(36860700001)(70206006)(82960400001)(356005)(54906003)(82310400005)(8676002)(5660300002)(83380400001)(7416002)(8936002)(508600001)(40460700003)(86362001)(107886003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: in.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 08:07:01.2350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7252c0-d18d-4721-08c7-08da4d13b20b
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.200];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT006.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>

Hi Krzysztof,

>You wrote pretty long message explaining how the device works, but I
>still do not see the answer to questions - why it cannot be part of
>matrix keypad?

Following are the difference between matrix keypad and Bosch keypad
make us to add another keypad driver.

matrix keypad:
	- By hardware schematic, a column GPIO line will intersect only
	  with row GPIO lines, not with the other column GPIO lines
	- so, row and column GPIO property are fixed, because of this
	- key scanning work based on interrupt mode
	- and key press is determined based on setting column as output,
	  row GPIO as input and set interrupt to monitor the changes in state,
	  serve the key pressed in ISR

Bosch keypad:
    - By hardware schematic column GPIO line can intersect with row GPIO line
	  as well as other column GPIO lines
	- so, all GPIO act as row as well as column, because of this
	- key scanning based on polling mode
	- a key pressed is determined by setting one of GPIO line as output and
	  other as input and poll for change in the state of input GPIO lines.
	  Setting one of a GPIO line as output and remaining GPIO lines as input is on
	  round robin bases.
>
>"It looks like this driver has smaller number of features than
>matrix-keypad, so it should be integrated into the matrix-keypad.
>matrix-keypad features are superset to this one."
>
>"But anyway this should be just merged into matrix-keypad. It's a
>simpler set of that binding."

This keypad driver specific to Bosch measuring tool or similar devices.
Please let me know to send latest patch which resolves build warning
and gpiod API support.

Best regards,
Gireesh Hiremath
