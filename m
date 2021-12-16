Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92717477587
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbhLPPPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:15:33 -0500
Received: from mail-eopbgr70077.outbound.protection.outlook.com ([40.107.7.77]:36411
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229652AbhLPPP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:15:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WuLDrZyVJ1RUOZLBWfKsvWLnzoFjKY7mpjY2F5KkGW0zizF0XdCkp6UecBsw7pi3dZnCj5gGNbCfWZW9tWgRGdz188Pnntlvwec6P6SEzSRN1/e2DWd6L5qPAaTwVJTBDvA+xE/RmGScGtQuQXhjSAkLRxPpSj0aIkv5fvkEIkgujKxkd5lA8eAnSxLha/d2FzII4LnAwjEIC2WRPWe0+k2+xlWobcd7DI6TaRSvA+Y0twY3HKLcRlRz1UMA3cKsntsQTMhnFVcMT8oajzoHwiUXcrvTwr+NX8dJ4+CCR7199XgNvPA239DzRfzyPBq5KKgI+KioxF+7lVJ5xbn4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6ZPlJnBVUr52W7u8lMLRnA2U+OHQI4CzUtH0qMVSbQ=;
 b=Nt2/7LP1i8uorV3S+Cuk8WRaBTqsZsHT1q/4UQ3gB3++m2pl2xCfZ7whiWxN3vIkajHrsLWA6FcH8jYV2l0I58vHzXOwlTMFOzHGu4HDVsnYzdHfWOG4N2uvnoMMZbDoJkwyodg+kIT20dQG5Uh9oIXRFfayQM2lMCTdgQdznxJy89DMDf97Mm0FQRBrFMG21KN9uDvkBj0FHRJHWpIc8V3Dt5CJuLkV3Jtydk9rWM0QfbnpZRiCHeUClRUDtKR/LFzA/ofkzwrBIZbufOGDvopi6xnU1zTMMIji4tNQZ+0g5V0KbqW3E07vAjKztgz3vrg1hSO1cSw6OUOmlP22wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ZPlJnBVUr52W7u8lMLRnA2U+OHQI4CzUtH0qMVSbQ=;
 b=w0rnlMZr8aUlhdfTsmKb0mOyXkGKlJAZ0d0UHpVTBsF7wxhGkpkAuoFHAylLTLO8yBHWAcvVKqtkODw7VXK/CB9y5CDXCmVUkaqLqiuETh2e5S1exts/vfVzAEA1TqYt586RwKiA33OPvTZWcxXw+2WRKFZWg5CzenXGTTZpT2Q=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4683.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:250::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 16 Dec
 2021 15:15:23 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e09a:7d6:49da:fa64]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e09a:7d6:49da:fa64%5]) with mapi id 15.20.4801.014; Thu, 16 Dec 2021
 15:15:23 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v3 1/1] pinctrl: Propagate firmware node from a parent
 device
Thread-Topic: [PATCH v3 1/1] pinctrl: Propagate firmware node from a parent
 device
Thread-Index: AQHX8o9gQYaYMAJCiUesJydxXJ2SOqw1OguQ
Date:   Thu, 16 Dec 2021 15:15:23 +0000
Message-ID: <DB9PR10MB465262B9D0D856CDE85454CC80779@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211216151227.58687-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211216151227.58687-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f698d8fb-a521-476c-9919-08d9c0a6e1ae
x-ms-traffictypediagnostic: DB9PR10MB4683:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB468354654996D8102577FDC6A7779@DB9PR10MB4683.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v+0HdmVgsBxg5GHPFxIRXutAU3J65+8s5DZq+P6/R3W9beqHdL91XNjXHFV0bn3QH2N9DvqUb0B1Igih656Za4BW6mOnsMTAIrAG7ic408l5lN8hYS1/2FoQvunmMRIuAq52QydVN9HJudgO6oDhIt3oGZbALw2tR5g7iJ8JTRFOUE+aj38dJzoUC2SXwA/lcT5wksU9y/kQ6rWdI0LM5/qUD/pAwwj+px4PD+6d3G44a+jC59FcQUPk39P/LuOOp3npPOTqUPVTMnOT85mGS8GZ8rfO0Zy03FXoeOirFHAZsi48Ol7zQIB+4tjzRhUog4AYzBNkkgnPAKpxmRnLgt9izBSQViadxb8N5QqhiRazW1KwcrMvG6kt1l//+Q+KvWQDqfNtWz67nBX4QK1v6iBZ2w8YgswghiIxsB4cxhdom4x87TWJBLJcW5fxP59ul1U9akdl+ZwGa6d2Pg+mDVVhhIm3FfIL6KTv12b6N84QQzjbm7ALIXTMv7KWQYOWZ0okEMFBCnX6hnU+4cWc+HmbtRFipFmtntQQyGetNpJk28aCqyXJ6R82t6hT0z9IrGTjxzFL6RAqO8jaCwMcjAkHR0F3DxZhhMasTtK9xzA+DiyyzhyHvtFMJIOtDbcfkw2bopglqvEtaJzLyzq1zo0BhU21RBlhzMHFg+k63ylpRI7+Rb9+YiyOm5gbdXM+UCfk+ejC8QkdtsEPhnbSaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(4744005)(55016003)(33656002)(38070700005)(53546011)(66446008)(66476007)(55236004)(316002)(2906002)(76116006)(83380400001)(71200400001)(4326008)(52536014)(9686003)(66946007)(64756008)(122000001)(5660300002)(8936002)(107886003)(110136005)(86362001)(186003)(508600001)(38100700002)(26005)(66556008)(7696005)(8676002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UwvG5Y+9rgFl7kkkaKvgu8eH+fKbS5ape+co2DgZSFmHAecfGcE++LV3/hvK?=
 =?us-ascii?Q?86GNiGF4ai01PVTQVt6bQR4ewj5ZLQ5mf7wVmnyuRWCgDmYKfi1plePszTXU?=
 =?us-ascii?Q?GB8jMV4+mG0F3gLZQncwVaZElXl8nJxGYDXwcVE4/MspGBHRqc/sSgAR0rpQ?=
 =?us-ascii?Q?jn+nnSGeb8LbNit5ZBkWswSkKTtuHIN2v7ac0jkRIe3SjVXa3ClsPDibc6GC?=
 =?us-ascii?Q?L7eUw20Hms+ck7miC+CYTGNwKD1H6i9AG//tq5k26sYBJa6r1U8OhQSUkpyp?=
 =?us-ascii?Q?Dyg3FHCnAhCKCnz9fxOcEU2jLafxTGTsxOcsUicxLkn+j0v+iajodWYaT62+?=
 =?us-ascii?Q?5NLLeLU+Th0unseoozuyDKe1RW29QoaL9okdkUPZ9qL2IGBpnf3mh6H7oBdI?=
 =?us-ascii?Q?skqg3WiNlUUl8GXv9gjOAru8iym6Hit5EjoQdn/3fONXIzmpYVxAL84fPFGa?=
 =?us-ascii?Q?hhqE6ChMTd2WUjDMZtgEcMHahLKKD7z0wmlcdQ/1ryU/KPBktFvsiWOQLC2F?=
 =?us-ascii?Q?v2WFm0u6/Vib288HYF4WSmcyaIt4x9C/hVyEd8NI+gC3yQweWqZWrvSBBsxz?=
 =?us-ascii?Q?OIXSFx55L4637eAV0egLKCTzKbuJ+H6KZUo6Vp7LKO9EoHIR872ABP3EF7C/?=
 =?us-ascii?Q?Szaca96Ow886mDcjNtfjnvryp7cRR13zM0TS/MXgw9XB7uPsczmuSZ2utVA3?=
 =?us-ascii?Q?EEzBN+gyzTCAKiM7y4oKDEe4HOFiu4clhCySZjakOn/VPIRTtz13VxhaZ7yF?=
 =?us-ascii?Q?cyjvMoqwuj62BpYzfIsIbSsquntfIMqDfj7SaSLdyw+CGxMvCMjhiOvARjaK?=
 =?us-ascii?Q?7bp1ZCT4OA43zoeyrRmzaVuCkp5RrrB40cyb7QM4cF84hcyU8hJSpeYB1X68?=
 =?us-ascii?Q?4VjeOuA6dbm3NqkzQI6rcG4y0Uc9KEvYCLmHgrrEIS5BEa9R/AY7zNT05hFJ?=
 =?us-ascii?Q?cZ4OIWJGTTZMtZ0PZgGbOk0HVpukS7SebkdPhv6O+Hf3Uyjmm8fipZk8/KiA?=
 =?us-ascii?Q?9pCGhGnZbLXM6u4IzL1unJ2hv8zvkShonrqAbHUZttlKhs1VGpvy88hTlG+F?=
 =?us-ascii?Q?VQBhjZqg1+LzL0BOFfWbSO853zrZB2fHtn6G4ou/YZZS95DXxVlUbS3uYVyw?=
 =?us-ascii?Q?m/0Bc3oX0V9vvvMOshljWHs2/EO80+JOqmvVFMaPVu72TjU+3ybeoVMa7PuR?=
 =?us-ascii?Q?dVpOrOGydo5CiwebuyRo0VrvFwD91z8v9ktXoUi9rGnggoRlUCRB6Utd6X3o?=
 =?us-ascii?Q?qfch38bpGoRbihW+ErGwNRT4G6iGZR6a+JI7Zj7iJ9UkWK1pONyjhZNtgLAQ?=
 =?us-ascii?Q?TfClyiwrOg2uW7LzgL0wxYBGQ2I9gx2gT0h/Dd2MQBUbktMfGEljDeVb5cxt?=
 =?us-ascii?Q?eTvFH+nw9yXqzuKvFbc85vV0SF/9plq6+45nvcg9jpJX+UTlhDwdB1MFZYpB?=
 =?us-ascii?Q?jKtmNn7x24+EgEH0klfXNHxj9mYT/AQ+lY8Ko+Rgf2QTkulVhDMsXTq0JPtm?=
 =?us-ascii?Q?BdVHqgXSPYNL9AdDpLCNOnifnxqoYx3JKrpmENd4DQXE5qiuDSrLG2uesR6g?=
 =?us-ascii?Q?EuI9Q9tcx2w5qL5NFr1Gpxau4dtovevj5s2CxbjFbMz0qH2lROAwAJ4lzTj1?=
 =?us-ascii?Q?7lSi0L8jk//d7kRrnyO/8xHDhbSUNsEMlR7FwI/616kPTDclYEro90UEweUx?=
 =?us-ascii?Q?TbFFqA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f698d8fb-a521-476c-9919-08d9c0a6e1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 15:15:23.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ja84yN/rZteJG2ToEpqXuIfHdtPfi4FQ5d0cQBt66FS5Cm7kDVQo08uZjkJr1RF8Yh/hZN8h30y0iFpLnLsUhQ+K6zvBNmZ3Crx0Tpo3bKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4683
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 December 2021 15:12, Andy Shevchenko wrote:

> When creating MFD platform devices the firmware node is left unset.
> This, in particular, prevents GPIO library to use it for different
> purposes. Propagate firmware node from the parent device and let
> GPIO library do the right thing.
>=20
> While at it, slightly modify the headers to reflect the usage of APIs.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For DA9062 updates:

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
