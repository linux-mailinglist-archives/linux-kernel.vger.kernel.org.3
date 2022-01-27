Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4CC49E9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244928AbiA0SJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:09:49 -0500
Received: from mail-eopbgr10130.outbound.protection.outlook.com ([40.107.1.130]:24451
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244873AbiA0SJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:09:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqRQafXKgxlltTTM0sNjI0LsXkV6IpNg+cIuPUfjXk4QElTSpkIQc/MWgZbsK64ZshTIUEAWxXThLEJ4bSxGz+km6uxAiRwHBF2WMBfuLI9RHzYNFp7J5n85/pu+0raDD1W66PAjOUZ/rxxgd0/wb+xaniQ3xCTosgn8It+ibe1YBWUKtJHaelB1Zs2OsbZiR7LZolbCHBGCfFPavpthGKq92yyUwZgJiqsMw44FuCjuXjCVyf5g13nO51rYjhzWREjWTK3lsjnWUza1SECbKRql4f+uTiVGjE/U/DNYdXc+8GOGQgBG3iLAyFElA6624jprCOA/5NOBA/ZQuzNCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nC/acceBH/9MPaW+STQpaMF27ZLsSEMvyyvVeI3WT9E=;
 b=cLbcNoVUDxgzuBWQPB0K/4pLpJdHwyw7aFj7xZAzVXnzLhxRiZNh2RwEw6bVD63S0rQnGeGEuwGhpRLYBWtfEAKxx38B1ixW0ClSzBXgI6jrGFpD6YWu5QHv6/2x0J7U0t5a+psxqAOeVtVoxcAfKzmJdmd0N1GCbHXcxRYoZGjCZQIHGRQsIEDVx7CKtGx+NSPklzbIAzdJn/zAgJ+Hw5vilWdfUGxGdQ4gbjrjCtDvNOGmP0ATZpUcFQh6UeVw1EakT/wJvHjGLYgDXf5k/rFpP5nsngHgwhYou5AYDzQ+QJkRF9O8LIg/7bVpYrABPfjC5ygcVLgivAqPXH05Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.66) smtp.rcpttodomain=nxp.com smtp.mailfrom=arri.de; dmarc=none
 action=none header.from=arri.de; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nC/acceBH/9MPaW+STQpaMF27ZLsSEMvyyvVeI3WT9E=;
 b=ssyzPMX+1C/+12x75NZTAcs1z4HnPcXB7IiikAM9qsaax1yUWLGhfnCNwqGfI8uumavSYmzSegxB8fPFvu9YQHrGvtHUCHN1Tf9YI+ClGYRhPHx08FP3gSTGyI1Bd0p21WbPD7+6MO7NM0b6qjEwXP0RcsXRZ7+q1St5sW4iJ6E=
Received: from AM6P193CA0133.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::38)
 by AM0PR0702MB3779.eurprd07.prod.outlook.com (2603:10a6:208:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.9; Thu, 27 Jan
 2022 18:09:17 +0000
Received: from VE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::ce) by AM6P193CA0133.outlook.office365.com
 (2603:10a6:209:85::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 18:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.66)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.66 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.66; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.66) by
 VE1EUR02FT044.mail.protection.outlook.com (10.152.13.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 18:09:16 +0000
Received: from localhost.localdomain (192.168.54.252) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.498.0; Thu, 27 Jan
 2022 19:09:15 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sean Anderson <sean.anderson@seco.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: encryption test failures since "crypto: mxs-dcp - Use sg_mapping_iter to copy data"
Date:   Thu, 27 Jan 2022 19:09:15 +0100
Message-ID: <2382032.jE0xQCEvom@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <414858de-f279-c5ce-83ca-5c28d6c847b1@seco.com>
References: <2126453.Icojqenx9y@localhost.localdomain> <414858de-f279-c5ce-83ca-5c28d6c847b1@seco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.252]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fa749b2-7c09-43cd-9967-08d9e1c021d2
X-MS-TrafficTypeDiagnostic: AM0PR0702MB3779:EE_
X-Microsoft-Antispam-PRVS: <AM0PR0702MB37791BA839F9C33272C978F8BF219@AM0PR0702MB3779.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30WLRsh9+0lr7En975I4uwYNDC4CWhJivIseh1cFySpFOsmnS3WAfprDW81L1Cp9/ToalH3AT1OY0ApWd2Z22H9ihGOChOQDt3mUuz3Qj7niWmjQj2ERfSuPVHRn6OidO07H5mm+vtTWPRY+x1XSPihLTeCZFC08U5Pd1HeOOiwco7NJ7e/TOBYTRBfcCCbA8jgzxDzJN91yJ0E6gApX69B0LJ9BM7a2AcTdo1sQ7UcgAwge3kIcsg2OFGFBRliPaQvtPsvuqxGo6FXeYVbpzu1DgtbqhImQ+iqeiVlbGUPvIIwPuIK0RFjW1hpMUNW1i3OkSyKFMbnHTEPXMOmdo5pXKdQJinnLIf2j7y8ylr4ZOxxvTNb9Zyww/cygYVaNjkeUhkuFBDoC2aj0t1qXvRiGzaSvGRhjzySd6hsw33of23FBpCNPNMBY9pBpPImnIbab1gXF9Irqy4BIhv+IJknkLXiazph8dIdQyxgyfHRKvT03dsuwGgpNbSYEcYcityEbbVpiZ15lYvQtcGmQGJaWZx8zxZEW2Zpbn2Kz8DvRsZ9r4c68PYsRacyoVmOBkGamTEMAN7l9uOjjICM63JshdAnAFvSR7tswwNBjExmVjJh+H4IRa+o2NSQC+/bEqLQuR9JeO+s3fXZXxYE7dqkNG+eBZKZHMNTxaHpQ8vyOuh0enk/DkRhM45XzHArPzalbalKBCuCZ4O0HoE4jaNLKNosSJ/HS3MKLetQ5IYheDL1sQDIPgu0KF9eT/m0vb4z2ObsEtiDXp2olYBsMe48aVaIC7QChyQJdzwMNP/M4hkvmT1E+J5ew8IY8+yv7
X-Forefront-Antispam-Report: CIP:217.111.95.66;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(55016003)(110136005)(86362001)(356005)(26005)(186003)(36860700001)(4326008)(70206006)(16526019)(81166007)(40460700003)(70586007)(316002)(5660300002)(426003)(508600001)(336012)(83380400001)(8936002)(8676002)(966005)(53546011)(2906002)(7696005)(47076005)(82310400004)(54906003)(9686003)(36916002)(39026012)(36900700001)(20210929001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 18:09:16.4620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa749b2-7c09-43cd-9967-08d9e1c021d2
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.66];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT044.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0702MB3779
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Thursday, 27 January 2022, 18:31:48 CET, Sean Anderson wrote:
> Hi Christian,
> 
> On 1/27/22 12:23 PM, Christian Eggers wrote:
> > SoC: i.MX6ULL
> > 
> > After upgrading from v5.10.65-rt53 to v5.10.73-rt54 I get two additional messages on boot:
> > 
> > ...
> > [ 3.786333] alg: skcipher: ecb-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
> > [ 3.789020] alg: skcipher: cbc-aes-dcp encryption test failed (wrong result) on test vector 0, cfg="two even aligned splits"
> > [ 3.793741] mxs-dcp 2280000.crypto: mxs_dcp: initialized
> > ..
> > 
> > After reverting the commit
> > 
> > 2e6d793e1bf0 ("crypto: mxs-dcp - Use sg_mapping_iter to copy data")
> > 
> > the error messages above disappear again.
> 
> Can you try applying the patch in [1] on top of your revert?
with the patch from [1] on top of the reverted 2e6d793e1bf0 there are
no error messages on boot.

regards
Christian

> 
> [1] https://lore.kernel.org/linux-arm-kernel/20210701185638.3437487-1-sean.anderson@seco.com/
> 




