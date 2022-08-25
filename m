Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4A5A0EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241326AbiHYLDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiHYLDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:03:41 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60051.outbound.protection.outlook.com [40.107.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C06AC24C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A26w+OwH8V4lxuffDQU+Ua0HFCdkJtRBMrtBhhhG6abZ9oZY60UZ4BUnvmaojV4zzRtUtA9xCePQ5sFJfk4+uV8tHEJTWEs65phytPUb1i2owc0DlCN0tW7wVjNRWFC2ekY+kF2bF3SlN49aMT0PnPH/Itky5d+GMVjJoReRMY4cWo9Frj9qrBw2abUDwKt1Vm1+wEJ00dt1pDnTdY9qYDLoJ2bxDAI5GtSqUWzMP7uO/6zP600O5nptkHXjymAJVs0BxQ/F8uhSNqASvRMUC9vJ0RqpqqtGfe6LBQ/FI2K5rplg4fATvjK4H+TVID+tnAH9fAoSjkMqbR4fm5hqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cH0OZpJn3fXWUZrNAohJX2Y/fE0byTxhfS81ZBcMNmY=;
 b=ME01LJ4Us3kSO6v234R5F+/PtE6lz7nFn9ZN2XkZuLLeJJrhwWU42QpzsWDnbF7EYzHe74UXzkaoM0rAKqi4jn54IJ61V1QuD+XI5qyN1OCC2IRSYVUQdiUHJHisPxxDKMh6dd9NDdQC4Ff+9he8CSvA9MbWplbOB58GbUnDNVHco7XSv1oM9eG7KjxZaW1Ap/v+nkdCixy0xzk+sKW1VjZbyvn0ByUTeaqd0a5AnrpoVBgCKOpTywaoINP+h6run6ayhR5Rt9+C/ntHCNahMKLezT2gt96JNeKzNkmiNzjHqaTI6Y+WRccAGwFPCFLJa/kTiYKygO04ip0ow0nGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cH0OZpJn3fXWUZrNAohJX2Y/fE0byTxhfS81ZBcMNmY=;
 b=GAKPIoM1Nxr5EW6NIFVkiap9jtKPobsJpklRkr+/kQcKXXubLNumfOUWC/HOtkLwRJIgI6hPVm6aZN6EZ8vMZkzegMHZx6aPkDFCmP4mplibiULxy66W8rZZd2NpeTT6z4noAk1nXW4Jm5ZQovBst3QJ1On9TpJMCL1adLsvUToF+A0r92Hp2oB4f7xb11j/u4eihwl/a/VjeTzPumoYEGUpQe+KyXOYcCO3HIv6q3gEtZ1LsFvH9Hc/R197lLRQsjxLnmb+qvEBbsr7Z6iwYsRBI18DvD5PW4x9D5RzUvhzT1zR4+m7MhPC9hUoZgK5XncCi8APBD9kkzlUKDG4xQ==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by AM6PR02MB4952.eurprd02.prod.outlook.com (2603:10a6:20b:83::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 11:03:37 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 11:03:37 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     Borislav Petkov <bp@suse.de>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andra Paraschiv <andraprs@amazon.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH v2] drivers/virt/vSMP: new driver
Thread-Index: AQHYuErwCwPojP5fak60UhGlJnJEo62/bykAgAAAfyOAAANkgIAAAM5y
Date:   Thu, 25 Aug 2022 11:03:37 +0000
Message-ID: <PAXPR02MB73109E18BC8277424CC6950781729@PAXPR02MB7310.eurprd02.prod.outlook.com>
References: <PAXPR02MB731058B69D178E026C578BB481729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <20220825104604.GD2030@kadam>
 <PAXPR02MB731016E9CB8C7E04DAC4790981729@PAXPR02MB7310.eurprd02.prod.outlook.com>
 <YwdWL67QkBfpp9t+@zn.tnic>
In-Reply-To: <YwdWL67QkBfpp9t+@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6e94b98-e996-4fa6-cec9-08da8689762d
x-ms-traffictypediagnostic: AM6PR02MB4952:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4rQxpEK3IwZkYrqQwuvdxokhkrFsRKCyvhRiwjHlT/5EJpmtNhRRdUrNq/vUY9FTs93NI6vt3Z0+PW3IYeFW49acWgh32RKrcQTz57LOaIFPJ1GoAgD2jufYarIt+6pzdpI3t/BG0PtFc3vPKF3hgRE5HaawhzrEBuMFw0hQnUXu6c4aFvNCKK8PvR6snhzChBwvx0P/vjGILQJi6jcAahVlLjbO/lA/DoW67iTvvO/rSQOYCVh8dwGjmuQ72OV68yCRaEAjhL3H6Mb4tcJjFbmqbe5MX8zE2bcc+yxh6XHyXLGXChij8x4X9NK3UDjPU/lJ1OrytK7m1ZnudxM1/kylmEEDUhWfJHFxfy0Wf4aVEETvSYU+SM9qOtOhq4sn/uO8GHNtbvoPkFcKKQbeC5u/zqe1NM/ZJpswZ8HDO6y80Zn9bLPjsSIuViDJ3OWHwTvaJXm0OCJ9EhcmTFP+8q6ehrfamLeQHz9A2HD/9LKZW7k0h73T3e90q5uY2mts/fqtLiqki+Uw+OT2JmPLF5FqtfJyqg9I1doyJctKW6XpawUBEJEacLRI0N4wZHwwzDnPelsMZfRPCi7eBi7H0pznAzn0N30nOUmaKn7Knxq1D/KksApsvX9GAD/wa3ZEDLkXu5PGxm7/0/eInkA0KoygPuglIeNByhfhc1cYHYPCq0xe3jU8j/gLDVu3GptdHCQmdvDzmb5ihv6/qOF2zLg6SV0cB+Wp7/dY/NKEREFvMAsMU51qYD91YpuTqGyNjClhcNgotz/ONuk/k9h3cbtdelJ6V8IzLKFAwmZiWFA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(6916009)(122000001)(2906002)(54906003)(38100700002)(186003)(316002)(76116006)(66556008)(91956017)(55016003)(66946007)(66446008)(64756008)(66476007)(45080400002)(41300700001)(4326008)(8676002)(86362001)(6506007)(71200400001)(33656002)(7696005)(9686003)(5660300002)(52536014)(26005)(478600001)(8936002)(38070700005)(82960400001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EbzrUugEhB+NSbbtetH76VXUo1UEyYCHBC9az4/4zJVqDNoT23cMJGLFlG?=
 =?iso-8859-1?Q?XSsjwy0+u0vr9h4TdlFydraMtlxYDd9R91fYdhs1E9pe/FZisj5rss83cD?=
 =?iso-8859-1?Q?hfBJEGKyeCqJ6uB1pDxlyMzSoNjP2+mF+TN4aJHTUxewcEVWYM5MZsRGh+?=
 =?iso-8859-1?Q?cYLFS3HusLjoJCI8/x1HolSanrfXvyAah+foTT5jDEcYnxevCbay7c7iTh?=
 =?iso-8859-1?Q?Fe4OKP4I++phb9/6k+X8FioNt1M1w7k8uBa4Ghh62QmkuSBFKTRrOk6QSI?=
 =?iso-8859-1?Q?uZMU+qSb3kgFOZl6ECdLvZyXbiz1A8rIVHQToNeoLWiUUkDYUZjQWwosBb?=
 =?iso-8859-1?Q?3cvKTi7r6ZskhhZh7e52mWaNhBmX6wHkiD6i8vsK5SD35peMxpyIB+bYd5?=
 =?iso-8859-1?Q?AguFyEbSVuYjw5/YvfMgm8Ha9Q8HRSPDzXGzF7p6gcDzQXYC5sbsovvCd9?=
 =?iso-8859-1?Q?VUyDFmT+q7OV4vFTaMLT7ofmGQmEsB89eyPiw2g2I7HA1MvQZVsU/hjxE7?=
 =?iso-8859-1?Q?IhZvcalS/LaV5W6bxM5hUqFRPWXstblE/upHsV9MBY7/4D0KJNbBx8I6zM?=
 =?iso-8859-1?Q?MacM1XtXnk6dyvsqawuGrP6uU/j+T0VW7pQ0LkIbuDIwfai4cGDYJRPJ6I?=
 =?iso-8859-1?Q?jaQoQOmFKw0OFzwtZVGmsOqoqjqViIxU9LnoG7/aXwUIBK/Ozg1Now8U5F?=
 =?iso-8859-1?Q?TD4LV6taLZsrx5qASF+qKWptH9gNuvNMi5DbrDAl4OfifLqCXXgZaVzYG1?=
 =?iso-8859-1?Q?SEuUR9jpKEokBkUZvuNP8amD8u0nuNi9YTmc/UQIM45rWumudzastIeUpB?=
 =?iso-8859-1?Q?cNVncQ0oH8Mkh3ndDsd09rDRrzfRbZ8Vvyikv5xKyVQ0hR1upAEBB0zBFS?=
 =?iso-8859-1?Q?Pnys48yIpy0djPWoWgXtPsWqJOJ5mNZHC7dLNrAMuns7XOSa5HdrWGniOR?=
 =?iso-8859-1?Q?N4jFZYTH+MwTSfehespfu2tzbIYtQ6Cqt1vCG+4BaBcJ5B2Pri7fthlm/S?=
 =?iso-8859-1?Q?MFrlea/zG9lM19VMsfeIMypu4AjehxCDYLXjaIylHd20ftkc6T6zizctp4?=
 =?iso-8859-1?Q?euQE0aQsaWZ8K/++90hgyQDpuCwe2l53eAce3VOd2f+u91T6USDDq6gjui?=
 =?iso-8859-1?Q?mZq6j/v1pCBs+TUJmGVb6GFjOA8ubYvNc6bGgC1ehC68UgMJzl+4yOhgS+?=
 =?iso-8859-1?Q?xUQT9Vp5np2fv7nWQSeY524qhE86FuYRZ70zxnv85oWmx09DD69yF0QGJL?=
 =?iso-8859-1?Q?pls+JkWSBaQv4oxNnZX+bchSeWXlheM61WlZS65ZnIepx8q2hkMa56Tudq?=
 =?iso-8859-1?Q?IibYNBUKUbEF0KbG1ICdqGZuJsH8a3zhJaN1wPOuul2eXrigZScbj2llql?=
 =?iso-8859-1?Q?ma1Zy753bjyOe+UqGntluCz951D+JRXf1fpErL9IwAJeV9q9SBEgUbOfJx?=
 =?iso-8859-1?Q?UEeOg9whAqnbxPhkTQleMN9HUvU+iDWyOU1kwE99gYaEZayTuoZK98q0SN?=
 =?iso-8859-1?Q?f4IgHtffLBlxnx4BI840k/Cin6uQYcs300450fEKl2OGwjB0F7xHuadiO+?=
 =?iso-8859-1?Q?QdkMbZRzWZtmaF1p8WVX8EGE3nxto5V1vGuDcKO4tkRLFEODI555/x58z7?=
 =?iso-8859-1?Q?ilcGaoSBiIn7zGN6ml0BNJY0qpwjGaqByP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e94b98-e996-4fa6-cec9-08da8689762d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 11:03:37.7076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZnw+Pp8CT9KHaQMb5T0NvsYDK5qZCqlCnp+zN6DEnuoIWhvo8rTOgnKEkwM2XKqJBWxWJNCfSx7k5MEqMQ3wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
>=0A=
>=0A=
>From: Borislav Petkov <bp@suse.de>=0A=
>Sent: Thursday, August 25, 2022 13:59=0A=
>To: Czerwacki, Eial <eial.czerwacki@sap.com>=0A=
>Cc: Dan Carpenter <dan.carpenter@oracle.com>; linux-kernel@vger.kernel.org=
 <linux-kernel@vger.kernel.org>; Arsh, Leonid <leonid.arsh@sap.com>; Twaig,=
 Oren <oren.twaig@sap.com>; SAP vSMP Linux Maintainer <linux.vsmp@sap.com>;=
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Arnd Bergmann <arnd@arndb=
.de>; Andra Paraschiv <andraprs@amazon.com>; Brijesh Singh <brijesh.singh@a=
md.com>; Eric Biggers <ebiggers@google.com>; Fei Li <fei1.li@intel.com>; Ha=
ns de Goede <hdegoede@redhat.com>; Jens Axboe <axboe@kernel.dk>; Mauro Carv=
alho Chehab <mchehab+huawei@kernel.org>=0A=
>Subject: Re: [PATCH v2] drivers/virt/vSMP: new driver =0A=
>=A0=0A=
>On Thu, Aug 25, 2022 at 10:48:44AM +0000, Czerwacki, Eial wrote:=0A=
>> I did not know that, sorry=0A=
>=0A=
>This might have some valuable information while waiting:=0A=
>=0A=
>https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fkernel=
.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Findex.html&amp;data=3D05%7C01%7Ceial=
.czerwacki%40sap.com%7C94e3d24f919341c5273508da8688f804%7C42f7676cf455423c8=
2f6dc2d99791af7%7C0%7C0%7C637970220076350755%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7=
C&amp;sdata=3DB6CapwsmFNygl%2Bm6ffT4QHV%2BBAa%2BKCYA4vV8oz0oUSE%3D&amp;rese=
rved=3D0=0A=
>=0A=
>HTH.=0A=
>=0A=
>-- =0A=
>Regards/Gruss,=0A=
>=A0=A0=A0 Boris.=0A=
>=0A=
>SUSE Software Solutions Germany GmbH=0A=
>GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman=0A=
>(HRB 36809, AG N=FCrnberg)=0A=
=0A=
thanks, will go over them=
