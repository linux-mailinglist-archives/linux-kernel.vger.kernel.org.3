Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE4F49E8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiA0RXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:23:22 -0500
Received: from mail-eopbgr140131.outbound.protection.outlook.com ([40.107.14.131]:8580
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232024AbiA0RXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:23:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmJo1bcLJSqCn9/nY0R30nm9488K/mNvNSRTwuMfMkivAWR+pC9IIWNIONsuKx0TppMtw5P3K793QHKGJfuS9/LKaOyl72pulxae4LJGBa5gogMUy2qx5y4h9kYC0lJVNjXsmHtr4PLEizSeZdXglx5C6TaD9a5AsStKm0hTsMEUlANcOuUdY5hFalku+GUMHAbG/f95+7r+L3KNho3ryII+KkHjH7Yd5vTFytKJUO8i9csPuqWYfbgYn/26L2A2w8+GhtNbvrlIvhLU/ZU3U3As29lO51ytNUMiggeFsirE5T6bEGe4fX/Xzsqma8MqMvAhJ031smlbqqN75KZkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FzclXlid2G0/YBctwdLiXbaJOmtENI2vVBw04OZi4Q=;
 b=KurZwEwp8Rn6GYPk7Zl0V6Zkdt44g0RQDJdRLa0GjAj8XnlrSewIyJ67F14IyozhYaTDCvQS3YRoAU/Bw0uiKk3yr8IU1Gq07TAqLXLMfwFMmF4KPTag9fk6TUpZOwpiKr5OihsA4KrIJkrjIwJh6fFCSdJhKfBGg9aqDkf2eam6BlgJ96UQguu7iHEpljYp+ZuAxIPbB4l1M81fdWnppTLUOV+lboweDJFRlH2Hx5CSyEuIEgYF2Qh5o26ROsBhxOWKpuoUeY+qzB3nGX9awF3Zs/dCmWBXCGG+2Ig5gPH6HhstRRqRPsSemucj8vIuKJdYXIvtX0zcs/k/rF11HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=nxp.com smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FzclXlid2G0/YBctwdLiXbaJOmtENI2vVBw04OZi4Q=;
 b=MaPGrhy4C7rhwJD9XBATINN+zCzG5FJYCohODc6cQJDa354sq0AmVhbl7UY0zghEd4N0pv8Fcrh5U74lSIS4Qg5QRKfWI9HJhIHXMuTIuBu7Z3OALqhGR5+8SY8gdjZse8iEo/5sqhXULmDvULGNTCSVZGTfk04jpegCAlZsPdU=
Received: from SV0P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::12)
 by DB6PR07MB3111.eurprd07.prod.outlook.com (2603:10a6:6:1f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 27 Jan
 2022 17:23:16 +0000
Received: from HE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::c9) by SV0P279CA0007.outlook.office365.com
 (2603:10a6:f10:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:23:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 HE1EUR02FT008.mail.protection.outlook.com (10.152.10.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:23:15 +0000
Received: from localhost.localdomain (192.168.54.252) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 27 Jan
 2022 18:23:14 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Sean Anderson <sean.anderson@seco.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ceggers@arri.de>
Subject: PROBLEM: encryption test failures since "crypto: mxs-dcp - Use sg_mapping_iter to copy data"
Date:   Thu, 27 Jan 2022 18:23:13 +0100
Message-ID: <2126453.Icojqenx9y@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.252]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52795983-62cd-41f2-aa70-08d9e1b9b411
X-MS-TrafficTypeDiagnostic: DB6PR07MB3111:EE_
X-Microsoft-Antispam-PRVS: <DB6PR07MB31112B5E45756CCE694B6FFDBF219@DB6PR07MB3111.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYL/OIWrR9q9IuwY17H6ZTD416CUpRdMPdNfydZjs2DYZ4ErfCe207UpNjvDXz5Z7nZQM2J/Lvi+5WM34oMoA1WuAOPudeqyTbTQ/5li6F4IJKPtvbMO/lm8lslClVmeqnREE2gHTsE8x62cjMeVKvxKBNpFPFgD41fqlamvSc4t+o+pbsUwDPk4l4xpcGuc8j/vNpim/XIAw4r8n5Mi4zD9qOjAnuVfeQx+Z5LWPVVQYqnpEc5BE6ZjFIitqkgNBg4PqvXniAKlUnoHRbk7lo8RVP6vUoeBME8CAEfmaOSUeUPIU/9Wr/dF+kv7o3j7f6FGqsbSEugexmNDjfGPqQZ4HixaaJkLMF6nNEGbb/GtWab4QHeJY+Rc+0uQPOogXbd3v557S8pKH7jtYb8HehMALa+iLys51Hq4+D1i1DX4kJ+cn3fEp0KIOaL9+YV78hCIJ+U/DXXl0YeuS7ZkHDpLj+ZLJhQq/tJw5KGXvjHuQsLrkcYNc15x3aE97fl25gQ8reJH5M3X5+DLozO9h83SVYXDMQ+NmMHZqWF3bxGqOjbxmRcD7jLEIx4hQhBR4+z8ynDp70EA36UYsG8gpDPV9j7avBE/CZNvIS0C9wAbPNP7R11MQnsycW/Ausbjbhry51S2jYNv3NyXTshIZ1ZBRxRQX2ZLqsa4rzcCeDXfz+/rHDzAycW5QEOPktEf7esjD5FtZKCPiXMETEGKCZKBF+fnCPZqE9wEJ6XTlAQQm2a0d4XiOIGHiDC54DkgaJU/nnX6pGMYtIWyI2+WQkZEwfKr8zWrglTauQgfFe0=
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(426003)(5660300002)(107886003)(83380400001)(8936002)(4326008)(70586007)(8676002)(36860700001)(70206006)(356005)(16526019)(186003)(26005)(55016003)(82310400004)(316002)(47076005)(110136005)(508600001)(54906003)(2906002)(81166007)(40460700003)(36916002)(9686003)(86362001)(7696005)(39026012)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:23:15.3079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52795983-62cd-41f2-aa70-08d9e1b9b411
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR02FT008.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC: i.MX6ULL

After upgrading from v5.10.65-rt53 to v5.10.73-rt54 I get two additional messages on boot:

...
[    3.786333] alg: skcipher: ecb-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[    3.789020] alg: skcipher: cbc-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
[    3.793741] mxs-dcp 2280000.crypto: mxs_dcp: initialized
..

After reverting the commit

2e6d793e1bf0 ("crypto: mxs-dcp - Use sg_mapping_iter to copy data")

the error messages above disappear again.

regards
Christian

[3.] Keywords: mxc-dcp, crypto manager self tests
[4.] Kernel information
[4.1.] Kernel version (from /proc/version):
Linux version 5.10.73-rt54+ (eggers@localhost.localdomain) (arm-poky-linux-gnueabi-gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #19 PREEMPT_RT Thu Jan 27 17:56:20 CET 2022

[4.2.] Kernel .config file:
[5.] Most recent kernel version which did not have the bug: 5.10.65-rt53
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)
n/a (embedded system, kernel cross compiled)

[8.2.] Processor information (from /proc/cpuinfo):
processor       : 0
model name      : ARMv7 Processor rev 5 (v7l)
BogoMIPS        : 16.00
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt vfpd32 lpae evtstrm 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x0
CPU part        : 0xc07
CPU revision    : 5

Hardware        : Freescale i.MX6 Ultralite (Device Tree)
Revision        : 0000
Serial          : 0000000000000000



