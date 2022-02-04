Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639FB4A99F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358839AbiBDNdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:33:00 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:42300 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356417AbiBDNc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:32:58 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214Bcjud017598;
        Fri, 4 Feb 2022 05:32:49 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3e0jvrkrww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Feb 2022 05:32:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9VYoUK64yh5cpIqNeT84kMnqRTCw0sabOPwxe9ks2r+zEZeSjMm/LfiBRecnkD+/3uAH8Naq0T5KjIFIzEMg6pXvULjWMWEF0a/Oi8MaMZN02NS059bsOFIPXKh4110TukVRSRsf7NBcG6kZXycuo41pIhK3wXF1UcRZpHldzQ9bgGzH94eiyULzO4hCj6/W3q3rm/TA2IPyMj4ApTtGDn4JN5mLmlzBcD5xSH14Vl+bTAP+Wq4hFwqHfKReaQiUI1L2CImIO91Kwlpx58iEAV0WW7B6SFs1gZ+e8igapvGTfxW/0OitR80o7KYTXOK01AUH2sx+M7iNtF9kswROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AacEUI3IA33LlHJbI6h2zw4DrhVaRCR59fL5JJb6Hw=;
 b=Mymn9Iq+tL/60tW5zCOBIYaubrB0MsWfGxJl4bQ8PJaBlXWh9g2S9cEeS7ucZLsXNT04XMnO7wBLD0eI0rqErkFeQ1640FIE8v2WIWdS1SxCdnQt46Li88p+XpnjT2j0gvRSTwZ4m/VXe+aHQrzdQMVuavqS9E3a02ErZrA+OBK5DiOXCSaNy5JF7kKsbrUO63gtgp0oIiIQnglSkGDS4jgR/Z3pQeLXysr4Lz0fvNwoLGAqL0yc7DqeDbUP7i7psnG9IaV7DfNC/f9zw51ueZAN3OAz9kRmdW2BF918e2E57MEUW5vTEYpeTwueb1n1I0AIm1MPjQDbk8pvCpsKbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AacEUI3IA33LlHJbI6h2zw4DrhVaRCR59fL5JJb6Hw=;
 b=hBLsbdK6K77lWXcQmNvVYT4xIR6VND0yHpnqmnPLb1cZtOC7S4/zMQMn1DJXZKGZn4qbZLQ+BPZe6opo7Bt72kyOE6fwXjiOWxIB6U2pXnfgUkKBXfz2goG7ICuy+CfAXCzJxDoVOcuQ+WBOyNQO8DOqxbZBb8FEwOdGK/L6Vgs=
Received: from SJ0PR18MB3980.namprd18.prod.outlook.com (2603:10b6:a03:2e8::12)
 by DM4PR18MB4254.namprd18.prod.outlook.com (2603:10b6:5:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 13:32:47 +0000
Received: from SJ0PR18MB3980.namprd18.prod.outlook.com
 ([fe80::c4dc:634c:a33d:34cf]) by SJ0PR18MB3980.namprd18.prod.outlook.com
 ([fe80::c4dc:634c:a33d:34cf%6]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 13:32:47 +0000
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        Szymon Balcerak <sbalcerak@marvell.com>
Subject: Mixing SCMI and ACPI?
Thread-Topic: Mixing SCMI and ACPI?
Thread-Index: AdgZfkSmzLMZAnIBTCy7eeU7R7oKGQ==
Date:   Fri, 4 Feb 2022 13:32:47 +0000
Message-ID: <SJ0PR18MB39807064D4DAA0A6E6F62F3DB9299@SJ0PR18MB3980.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4e5938c-ebc5-4f00-adb8-08d9e7e2d54c
x-ms-traffictypediagnostic: DM4PR18MB4254:EE_
x-microsoft-antispam-prvs: <DM4PR18MB4254DD15A61411963D9CE3B8B9299@DM4PR18MB4254.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bWyQpWhzzUcTyzukRhbhVVfF4wZelMyxagFTjGpUD0b8twn4YKy1sbmnRvmBvcIjRsE0ln6KQnO4WM+ud2oYy+PmdzfOEDxyaVtZsatH9RrqWlF2pZCDLXiD7Xtay5Z6nEVg2RH7cGuUCwIoYcQiQ41UPiv8/LJnSvVUJ06EutL6J2u/tna2MsTExmL2z7pPOpOxnSRRGdP0A2vtklHuNGpUarbQiFwEbQWeaTo8MYU6iI5wbYa3Ql6crpRKQM95HbhT29CoLIqvfnWifT0ggjbO1YeMB/o9ZVVVkGXTXfW2sRpOiIzWn+WI/3k7+P0cDnpZJPJqzkQ7qTU54bZJ6qZrunJ/1EoQ5jdO6u0+cxWive8e+xZTt9twlfn7fxKck+jhn/x41G/4uswxtQOLwjelyEFLuZoIZKNTH5YGPq2uiR05DxksRUjpPhVybvF56f6tswSVwwIs90/9DjZ0rngiR6oQgb88JA7dwphs5MsCj2GtyekuwIUfcLHPUhviuUVznZT13NI7RtVzBZSPCaHTkOkFKWCvgOAZFOJ39/ik63MRrlHiz0Dv3KxY1cQR+P41vtExj7KYCE91m26Y+wLnL5tV2dsuqgRLDUlcno5PpiW96OxykGkVBg5gmQyfONRLAsg2L4BAGSBlvCfzmUtv5cvSHuwMJTpkIrLwN8jReG3I6IBhgkmzm2lOOF4Qd6el59Pqt1TVMDawu0kZXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3980.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66946007)(122000001)(9686003)(107886003)(8936002)(2906002)(66446008)(4326008)(26005)(186003)(66556008)(66476007)(6506007)(76116006)(7696005)(38070700005)(86362001)(71200400001)(38100700002)(64756008)(316002)(52536014)(83380400001)(33656002)(6916009)(54906003)(55016003)(5660300002)(3480700007)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1vLBgV3iFfNXLRjigUxiM+ltF5iUn+L1eIDVbKRE+b1X3Z+Bhkc2YkQT4t8W?=
 =?us-ascii?Q?fJkYjQerX+WTy0fbL+ced1jGW4o4kP7cwWAei+b9hbvduMD91sBbFPehN4H/?=
 =?us-ascii?Q?TZE7cMWgdpB7ONRXaOmIazACCbxzidNxEbhXF6+vCOtHvGgiSOgRwU6w8m9/?=
 =?us-ascii?Q?7+W+WaTVLhPkm6AOmkoKGKgsNypp8lIygCUo9xqE6L9854H2U+yna/H1utdr?=
 =?us-ascii?Q?7N7HlBWsBi77E0HEK+qjZkX/LzMYTRqFmVms1i1nHKcZvth7yY1c63Ca85i7?=
 =?us-ascii?Q?o+0wZOlfnp5tHOCdNHdJ457brVOFzhn/JNVRKwyjWdtyoFKgNUZx3jB24sii?=
 =?us-ascii?Q?G8Xeqxu//Y3+qynonENtaZDL3vuXnIQsqSEZB3iLMXR36724VSBu48ytpby0?=
 =?us-ascii?Q?F7Q05wwxoQ8zjtN1oHdDYjL1DO0dUl5AZQEAqihEnnzHGtptHm0wLDHfrwa+?=
 =?us-ascii?Q?inDX57Mt50qVqEvAXQHMQQXEgxH6M4hpAs5YNrPsPE9AM4TjACff8O1miK0B?=
 =?us-ascii?Q?cvkpGlBTSQD+ASpKiUfhgZKmcgN22gs7oozg3dY/Q41TBHOUNG6sYK6JAZhg?=
 =?us-ascii?Q?wzoEWemjNcn+2oy/I6jOtNxwWk0+wkXen4eixLaC1Fxlo5t5MYA1nSSgXApe?=
 =?us-ascii?Q?fgoO87avJy5uft/ZrO0vDUVLMFY3PIifdNWaimhsoN+pBMoJNdYpX7mWf2EU?=
 =?us-ascii?Q?sYlE1+N0O9L83NGR6+f/0UlsUcGmUfJ4v3+z8JGLKl2OsYTQVbD41wO150Fh?=
 =?us-ascii?Q?WNJjwp+1vcnGZ99nZRdWY0uiz7cwXFCXNu82cOIWGpn7VzKyuWVvqhc+IXUB?=
 =?us-ascii?Q?GwJHtYaLmMXuaM+W8ucyoNXw/4FgRfWBMJqC3MJW2EtzdhK5bVmmzBsGo2Gd?=
 =?us-ascii?Q?/bATgVNWYh9t6/+bF5l/CBVnhfAHmsnHqjI+CidN9r4CbE+uFgqtYXORA41E?=
 =?us-ascii?Q?LIxZey6Ol8r6p5wcbRpYdfTe61+7QebaGLmPtf6FzdJ2LUDGVFTA1yKKw1+2?=
 =?us-ascii?Q?I0Mcr0pBcBGlUMmCQJsg5DIb/bUOM5ep9hfonutHEispvCIC9Ns1PhQw2hKE?=
 =?us-ascii?Q?TUW7B8GZBl5mhZJAi87bT9pCiyVEScglxEEtARhzDIfV1M0V3QgwHJ5icSut?=
 =?us-ascii?Q?MpmdTDqURBANsM1R77q0dXl5vtRaqIrbh8u5ZSgF0Kh2wY6MGEJSIOIBM87S?=
 =?us-ascii?Q?BDLbrce86mbYoCHHGYL7r7K1MJR/Zd6g/vcfetYWvwkTRuEv2Pi5onZ96C+p?=
 =?us-ascii?Q?XVMTbGqI1+M7ZJdzCmAEXyMY/WLqlP6cuKJkoQKfN+Dw9TE650olheFbS73A?=
 =?us-ascii?Q?FDqTrcR7upzVnfKUucciSog5sOUIGIGAr5646Iu++E/Sjw2Njx6i/gAOJh0A?=
 =?us-ascii?Q?KboBSOLZap7aISTYlDuRWi1Pddd4P7R62xu5Vd/atYlYkNPyd3T6PZdBWz5S?=
 =?us-ascii?Q?eba3cMzTSJDzcv+VfJvtfIwBEkP6mVOPyG9pWAnY9glvuYDss33idyBl6Go4?=
 =?us-ascii?Q?G8lk4Z4vrvc5Rh9zuJIEiidMImb/Alfig7CpZwxR5zQCNOpBBF7YrmB+bXg9?=
 =?us-ascii?Q?5pUqtKyWMVa58zKHwY+Xle3TIs+emuMqZ4dNVVeB41XZcX3z2vLnCbuAzgqG?=
 =?us-ascii?Q?+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3980.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e5938c-ebc5-4f00-adb8-08d9e7e2d54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 13:32:47.5584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmTxV1otlnVFsb0gbdXixHhsPESQHOMNG04FHXUejj9QYWuM6LRgYQrXPIVWxLOd8oMpKRvYXQYO+wP1MPL7Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4254
X-Proofpoint-GUID: zDrAFZmiX4tiEOrAck2LdQA4r_TeTk6i
X-Proofpoint-ORIG-GUID: zDrAFZmiX4tiEOrAck2LdQA4r_TeTk6i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_05,2022-02-03_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I have been working with SCMI for some time now.
Here at Marvell, we use very common software stack.=20
Mostly ATF, U-Boot and Kernel. With this software stack, SCMI integration i=
s
just a matter of following the common sense.
Recently, the new requirement for supporting ACPI and UEFI has arrived.
The main goal is to have ACPI and platform that works almost the same.=20

This is where the problem begins. SCMI is quite well-defined for=20
DT-based environments. Unfortunately, there are not too many mentions
for the UEFI/ACPI based platforms. This is probably caused by the fact that
SCMI overlaps with ACPI in some points like sensors or performance manageme=
nt.
However, SCMI has one single advantage over the ACPI, namely it defines pre=
tty
nice framework for clocks management. ACPI is silent in this regard.
It is just delegating clocks to OSPM. The kernel and OS should be unaware o=
f=20
the clocks management according to the ACPI spec. This surely does work for=
 x86,
but not so well for ARM.

Wonder, if you had chance discuss using SCMI in ACPI based environments?
I am mostly interested in the description using ACPI tables and eventually
the bindings for ACPI tables. I need something portable and
in line with future development for SCMI.

Now the review of existing threads and forums returns almost nothing.
The SCMI specification wasn't too helpful either.
I did the code review too. But only thing I see are bindings for DT (v5.17-=
rc2).
It will help greatly if you have any advice or pointer that I could try.
Has anyone done this before?

Thanks,
Wojciech.
