Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D92554F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358801AbiFVPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357795AbiFVPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:39:53 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30128.outbound.protection.outlook.com [40.107.3.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E412E0A0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 08:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3u2Edl3HMf5pwMypxGQg4sq4zTOV/o7rds4Dgf7RbcxFwlRFKT1qI1+pqcV4z1M4oz/4A3b0ZtV02TqU/gzgF6MnC57wEO7HU1qTuXeK57ERp4KG/omNDMjs9owwGIV7MlxZiilAHfvIa012x7U46fURoR7hOExl/KOWVnFE9nv8kKSlgHCJUYBdUIKcPHv09xyLdydNSzApA51MjVG0mni76RFb9vmQPWUvlHAiLojIEUGCR6jT38XdHJJxj6/UjFpodL3Sy9GPMdOGrSybk6mOkLHEmZ3Pt9/MjZjDtNCUineZr8vnuUlwcdPWAPE080l1/lrxGFQO5QqkrKo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyi+l1idA39OqrKyzb7se6JpoIunlP4xOQ8l68zEJVs=;
 b=WdZei3b2PXJglzG6hoGukFDvKOhgYeNNA2TRTLOIBIxCINKzqtm23nuu/lVTiL4Yv/uuE2Y5xFUkL9mjmKXkN2zS51s8k03BiG7vAQ2AJJiwayYzi9X5+1JA+XegUPcjVmspYeklmNL6KoS91jcyso3cWfhV8unTOn8uae4VNInHDXHFG4Zv1KxNejBeBe+aW05ZtaDN09weMWJzpo7KpNuehjEOCHCjOnn4YQ/IihhPjL/VIjd7vjGQNIxYOs6vSM/WHQ3WjB/wiDhzsTMieZyG4CxHbVdCwStsW0ebpXbAwMTolBW5e2mur5jZxk9zG/UAhxL4yDdmeJEMf1M/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 212.159.232.72) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bbl.ms.philips.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=bbl.ms.philips.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Philips.onmicrosoft.com; s=selector2-Philips-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyi+l1idA39OqrKyzb7se6JpoIunlP4xOQ8l68zEJVs=;
 b=nCmadzPPEFRk//uglRLpBtMpI53CiCnpan+KdepRQiuQivKXpIrzNhxkZgUxRn02wwP/1G9dsMvTGhLBoydtWH2OYYG9gXXcoA+HWcxwFlfNghG1ieOZRnGHk+sk1SBYpZvcXbe5gelXio6+2XPIiejmdKLxyRensrmFwYQecT4=
Received: from DB6PR0802CA0041.eurprd08.prod.outlook.com (2603:10a6:4:a3::27)
 by DB7P122MB0172.EURP122.PROD.OUTLOOK.COM (2603:10a6:10:94::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Wed, 22 Jun
 2022 15:39:50 +0000
Received: from DB5EUR01FT084.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::9e) by DB6PR0802CA0041.outlook.office365.com
 (2603:10a6:4:a3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Wed, 22 Jun 2022 15:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 212.159.232.72)
 smtp.mailfrom=bbl.ms.philips.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bbl.ms.philips.com;
Received-SPF: Pass (protection.outlook.com: domain of bbl.ms.philips.com
 designates 212.159.232.72 as permitted sender)
 receiver=protection.outlook.com; client-ip=212.159.232.72;
 helo=ext-eur1.smtp.philips.com; pr=C
Received: from ext-eur1.smtp.philips.com (212.159.232.72) by
 DB5EUR01FT084.mail.protection.outlook.com (10.152.5.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 15:39:50 +0000
Received: from smtprelay-eur1.philips.com ([130.144.57.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 256/256 bits)
        (Client did not present a certificate)
        by ext-eur1.smtp.philips.com with ESMTP
        id 3vKZoYjuDl9Zi42SMoHNJp; Wed, 22 Jun 2022 17:39:50 +0200
Received: from mail.bbl.ms.philips.com ([130.143.87.230])
        by smtprelay-eur1.philips.com with ESMTP
        id 42SMoEnQNK1kB42SMoyQry; Wed, 22 Jun 2022 17:39:50 +0200
X-CLAM-Verdict: legit
X-CLAM-Score: ??
X-CLAM-Description: ??
Received: from bbl2xr12.bbl.ms.philips.com (bbl2xr12.bbl.ms.philips.com [130.143.222.238])
        by mail.bbl.ms.philips.com (Postfix) with ESMTP id 5064F1832D3;
        Wed, 22 Jun 2022 17:39:50 +0200 (CEST)
Received: by bbl2xr12.bbl.ms.philips.com (Postfix, from userid 1876)
        id 4C1E82A0010; Wed, 22 Jun 2022 17:39:50 +0200 (CEST)
From:   Julian Haller <jhaller@bbl.ms.philips.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Julian Haller <julian.haller@philips.com>
Subject: Re: [PATCH 5.4 1/2] hwmon: Introduce hwmon_device_register_for_thermal
Date:   Wed, 22 Jun 2022 17:39:50 +0200
Message-Id: <20220622153950.3001449-1-jhaller@bbl.ms.philips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622150234.GC1861763@roeck-us.net>
References: <20220622150234.GC1861763@roeck-us.net>
Reply-To: Julian Haller <julian.haller@philips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6759a5b9-171e-4180-d6e3-08da546571f8
X-MS-TrafficTypeDiagnostic: DB7P122MB0172:EE_
X-Microsoft-Antispam-PRVS: <DB7P122MB01728A9CE8B865EA8EF18034C4B29@DB7P122MB0172.EURP122.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/bZslCDs2U3HcqqYjkKKu+9iC7aDB/dhKhF457tzeGWho6UbQoU9DolVFwGpIhvRc9gqoPgr4R7zztKxtC6SMzKvitz2VbiXb3ILfks0kqGJpWkPu0U+hqvhMTBrxsufUeKX+NIumRspi6NKPiGAjBzlSIYmc0AMy57G98cN+8lv1iQ1ryZXsk9C4UIgHfTb3YvTlg2RJatVlAppohn2gmY5peSrON54sxRi1gXB5do75PasWKfJtBNxGD9AFrM1xybYSgUeF5qDiqhHtZ6nNpC1h7PFLjpAbGdyTP7RgZJcSiMvBKIukWC3PMsvsH7vvPT35esSluudTIy4jkxqyzTrxDu4mOUszQfXoLNAsSzuAnQQDnfgl+jaSBDUUOribTohdv/Xf9g+vjkdVSBc0u3gjYghv3DPmy/Zg3WdHrRr2ljyQTmqQM/XJzgLQL0XAbv3ctOR6SbwYbe+7F+RGulxWizdEagUFuHZ1otagFNlmDAiKfVwvJCr12ouboRBFNUzbUcA4fDNt5BY33crv3NiHqZOz4sbp6JddtQkJJvxecGSopQ6rM77iw8f2+eME09uo9UWJpQgrV87pnCVf7egn+jTnoXM3JEikVjVWPBndhcOhABib4KTxMQRQfVDtMJdkCrbr3pc7qpZQiyL5wejuXAw2fx6T0DxxFkuXCxO+144LdiXhqgmoqiZZAHo6Y8mcGzLI/iD/6O+T0MKqJCdHsNHH+C9EC7v8iii+YJJw1sygSyf3gBn2k0DI5kZUCPil68uNUCM85uTJe4Fg==
X-Forefront-Antispam-Report: CIP:212.159.232.72;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:ext-eur1.smtp.philips.com;PTR:ext-eur1.smtp.philips.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(36840700001)(46966006)(356005)(40480700001)(186003)(42186006)(26005)(426003)(7636003)(8936002)(316002)(82310400005)(82740400003)(120186005)(47076005)(4326008)(82960400001)(7596003)(107886003)(478600001)(6862004)(86362001)(1076003)(70586007)(2616005)(41300700001)(40460700003)(336012)(2906002)(5660300002)(8676002)(36860700001)(70206006)(6266002);DIR:OUT;SFP:1102;
X-OriginatorOrg: ms.philips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 15:39:50.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6759a5b9-171e-4180-d6e3-08da546571f8
X-MS-Exchange-CrossTenant-Id: 1a407a2d-7675-4d17-8692-b3ac285306e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1a407a2d-7675-4d17-8692-b3ac285306e4;Ip=[212.159.232.72];Helo=[ext-eur1.smtp.philips.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT084.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7P122MB0172
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Jun 22, 2022 at 04:49:01PM +0200, Julian Haller wrote:
> > From: Guenter Roeck <linux@roeck-us.net>
> > 
> > [ upstream commit e5d21072054fbadf41cd56062a3a14e447e8c22b ]
> > 
> > The thermal subsystem registers a hwmon driver without providing
> > chip or sysfs group information. This is for legacy reasons and
> > would be difficult to change. At the same time, we want to enforce
> > that chip information is provided when registering a hwmon device
> > using hwmon_device_register_with_info(). To enable this, introduce
> > a special API for use only by the thermal subsystem.
> > 
> > Acked-by: Rafael J . Wysocki <rafael@kernel.org>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> What is the point of applying those patches to the 5.4 kernel ?
> This was intended for use with new code, not for stable releases.
> 
> Guenter

The upstream commit ddaefa209c4ac791c1262e97c9b2d0440c8ef1d5 ("hwmon: Make chip
parameter for with_info API mandatory") was backported to the 5.4 kernel as
part of v5.4.198, see commit 1ec0bc72f5dab3ab367ae5230cf6f212d805a225. This
breaks the hwmon device registration in the thermal drivers as these two
patches here have been left out. We either need to include them as well or
revert the original commit.

I'm also not sure why the original commit found its way into the 5.4 stable
branch.

- Julian
