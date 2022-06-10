Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E6854630E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348348AbiFJKDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347307AbiFJKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:02:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5608AB0D0E;
        Fri, 10 Jun 2022 03:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muxQF3cTR//2YFvskCyx0z+vDmbXDxxlJ+BTujz8PSWYe8/PKh6Jrx6ClzAW6uqwYsesa1DQLJfG+dp6vVbLqNtd80qIPi7760iuO1Ye2qi1VG6gENIpnYaMA2C7XyTM4s5WzXBrSc+xCcS66wQmyy6LjRx2TkXJcpJSUycj4lv6MScVTwtzE4Id9vO1FmRzNqZMoPhSY11XkbAmy8oT02YtPT3CGxfknKqTc+AhdB3LMDhlxIF1N/hXliOHeROKS/Zx4x5E3PBCWYzXpImEADu77YuoHkJqoizHK2htRKbMbvqiMrW5ZXr7JZgCm35eLIq2hjbtFnH2zz8HmTwmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEJX7UjSRzV53ogXSBzB67FcPe5SAip1ndWVDuoBu3A=;
 b=knMOq047/JfW6CzmB/NHiYMiDKUU6JfW8em+oQKFJyV5EnDuvUo1qgQB1YOGnRbN+oKj8BNLSzEDfK+GpmT9us0oj++kx48fC1D4R5qF4eBsPzgBSyK2HffSPC9+ZUPJ3y8ZbDc4oeMdWyHZrBhTw9y4PFk4bfbGj18NRcRL/YLNpFIPBtC2q8eVneQdoKhUDITao8Br+NLBpqyjklRrgZlGbH3YvauQiVwaYYY4uqoOqfdKTAhtoa9dM3v02tOm29MDrBdHcRGQ9DgtmsZxiVMCgxTIqfpmjoDKyKxVCuRXb/lVO/IxYoIrUIfjW6ZCgu12Vvz90YPOiAJNbOqGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEJX7UjSRzV53ogXSBzB67FcPe5SAip1ndWVDuoBu3A=;
 b=4ENPKqObLSXiYqGZWL+yZqvdWQn/BZdLEccDccnChmFmoCfw8D2fl/cMTi3T+75Ih5bpxTRbUm0oYxzMhDHAGCGwZagLqoHBh6Y9zxzWPvRLuaTHV/zqvkxPsiPbq+efvaAD78/U61D7l+Bd6aRhoVFu9+FrxQZpKsVB5nJJLMU=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 10:02:48 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::7c94:bf5f:eb5e:f3fe]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::7c94:bf5f:eb5e:f3fe%7]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 10:02:48 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Peter Korsgaard <peter@korsgaard.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "sgoud@xilinx.com" <sgoud@xilinx.com>,
        "shubhraj@xilinx.com" <shubhraj@xilinx.com>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "git@xilinx.com" <git@xilinx.com>
Subject: RE: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
Thread-Topic: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get support
Thread-Index: AQHYfAq3H1AwUW9mCkuVxsTByCkLV61HKF6ZgAAA/QCAAAG6EYABPtcw
Date:   Fri, 10 Jun 2022 10:02:47 +0000
Message-ID: <BY5PR12MB40335583AD9D0527DEEFC4E093A69@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20220609140833.1784738-1-srinivas.neeli@xilinx.com>
        <20220609140833.1784738-2-srinivas.neeli@xilinx.com>
        <87r13x28o4.fsf@dell.be.48ers.dk> <YqIJektBvAwOqNkA@mail.local>
 <87mtel287y.fsf@dell.be.48ers.dk>
In-Reply-To: <87mtel287y.fsf@dell.be.48ers.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a3ec196d-c058-4a98-ade8-00007a39f588;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-10T10:01:08Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae76f24a-f169-4a5d-9c02-08da4ac85f61
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5068E597E229498C293A9F0D93A69@BN9PR12MB5068.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OyD1+RkNU707r0Y2Y/32bS/pPONX5hRombgtlSlvmBoRpj42DJ9xkeD86YKakNk0Pz1Bx+nUnh5ptheX3dTaqQDhVedhDTLW2988zvecFm+NliRgOXx41fpy4J8OTEeDqgEzaGhMxnM6lrW2KMHjRim8JoeN+w7UeE1iBqZZITYXqNFavNluadt3BcVqQ+zApju1uZdAjn5uUtzIej8qX9pXTl9mAeAlq661b57n3mO7P2YAar90I48L5vjMqnRcP7ONnzFOX+On+53pJ9Jbt/iF7JZqu+UdBy357E3vgNCXY/v9prcENrKxTiIjlBdJLHfsGn3leFeaTO2SyyVzQg0JW4Gzv/w4UYldM4IXGmSdMjU5ELARRYBRvQHqMnDvqJgL1PIz2Eu39uUozv0NR61zy+cMHVExemzaqXt2+lx/9Qly8WfKva8W0p7BjhTQzhGWd8BWY5kZFPmbyWbP/PcnPRGnHQXPwrjcMSJrvivZHjtBeY5UrgZ++IGWln0ERYszLZrcEdTJYz7Fl9kumQwV4yLSaMvuXsWRXAej25SL+ydyabjk29y0MXZ6/rmZ3Q88UYtzfZ3KLnrPU48lD76zhkuPR/HPc2LxWXNEHPNSQe68U3ezjxeasnELwH4U3MTMCxVLDxvDWO6bxWo8QayrN9hS2oAEwTFhOFRchNcZPAKXxvhlrcsLAr+coiFgkTbNe3hmCojg/u30uuugUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(186003)(2906002)(66476007)(55016003)(316002)(66946007)(66446008)(110136005)(66556008)(76116006)(64756008)(54906003)(8676002)(38070700005)(4326008)(122000001)(9686003)(107886003)(52536014)(8936002)(71200400001)(508600001)(5660300002)(7416002)(33656002)(53546011)(83380400001)(86362001)(7696005)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nj0mupgUYELqz8KTlmemGXxD9B1DevhUXUTM1jL44smGp+36Pwh+JsnBKWcS?=
 =?us-ascii?Q?l1OnfWu3lzSJ0xzH4fgixtWtV4ti/nPl8NoP/bwK6NciT+Xy3HwHGOLiU5JG?=
 =?us-ascii?Q?R30raZ7eIgp0SvGSCAEC9ItbaGoBA4K2DMv7gg17PP8Ii7v8P2mfIU8Sempq?=
 =?us-ascii?Q?AB5JK3orWrbo2dZRZqxL5Z9/Iac5u9Zk9oLeiy7w6EgMeX94aNCsnEDb5Ljf?=
 =?us-ascii?Q?BYI9j1Bt2jkHMLm8myYGxMeP1BFlQLL3rElt/iH+lQzxXmwZq5kyft7eSOwt?=
 =?us-ascii?Q?TatURMPx3jgkikjIEh0Qslbu/SNlpKunV96UnXrEl7EuCPR4uH1+ubn8pU8K?=
 =?us-ascii?Q?v708LeIIDBo8Umj16E5FoQBIu9OpVZG+QtMEPyjFFgmrR2fzbmgIQgHy7ywH?=
 =?us-ascii?Q?2U2hZoLAVOUAskRRDglsB+ivMYKouqTu285UOViSGUkB7UtDI6EXaUHtVLZP?=
 =?us-ascii?Q?j8Cm4p+Eh8UM3E8aff4VM5Bc8Y6ZMgjqMfJt766Bt4Ll0E790SGpk7yWaZ37?=
 =?us-ascii?Q?BN3cEcjbBM2svQVHaiBIQxxY0vn0SgIGz+HAOhxbbCFTxTb4pUtjOUWIYbdp?=
 =?us-ascii?Q?9sTm1V5EGmmvR3GROv/v18u9S4h84RXDbyOR8dY6IkU5cy7sP+PSZcFRsQGa?=
 =?us-ascii?Q?xbC7SjaTQMPiO2uvBB3LIUjHdBeVH5bJ+sLKZg8YP6wJ2hLmoyL/63ClzS+N?=
 =?us-ascii?Q?vklh6d0gwLLEPX+yGpqaLXay3CZv5YewnIcgWQWLqWJFOz9sR36bOrKN9AE3?=
 =?us-ascii?Q?ERQTQ3Wz4cBr5vTzuYINpRQd88zrZkK/4DQYlyvQwqdrgj32cj0UqoZAY4Jn?=
 =?us-ascii?Q?n2XH2nXaZ7/e14DF2nW513u4YXWASoghUe20oRoWk3fWYdpu89lHyGG+DBHE?=
 =?us-ascii?Q?zYRqHQja5Z2DeWdke/lkSbfTd6HXiYzwRXhHpBkfEizoUsQImdVK/WNnzDBh?=
 =?us-ascii?Q?McT2UFYaVZ4hig6+4RIE5exDgyrngizjHW9dSoiWhFz/1P8cv08ww6mz1r2K?=
 =?us-ascii?Q?jL1bjt9GKasNznKLRjdhmV4JzUe0XtmcJcNuwimNxLI3sAeuyeCfUQ6tHT64?=
 =?us-ascii?Q?BEwE8eueeKhOGBhSgG9mpMxjtt2de7t32AgGEv0tklBhP/+QlhGfaIQneQPq?=
 =?us-ascii?Q?dCfCLZ0NRqYzwjj3tW0j3o69H3Pnr/Yoqs4DIyv25yi1AtVX35YpYp6BRsS3?=
 =?us-ascii?Q?RwpnkNzlvSbb717GVINCOePcib8NGOrfGF5VbH3G3qgpCO7HfQKYHsL4IRFm?=
 =?us-ascii?Q?cTBTY118MuyOknkzCkaTfqc+wpbgeHx1xMWT6j+Tj7sJBunxa+bLOwIl6jvf?=
 =?us-ascii?Q?3kdq0iXDvcL1tzFs9ULXPfXbGpEtjGE7Uu7u+xB8HroZHcmHTzcTAHg3L9II?=
 =?us-ascii?Q?HzIWwQMv9hrN+tC2HsxPi4x83lEIshy4/wpfZcnYfTRL2Fdyp6azdEJAeatz?=
 =?us-ascii?Q?mM264nlbwuvHw7H+oBlgNZdQ96QV9g5UqB4KxQbVVWnR3PICbmfjOeB52Xyr?=
 =?us-ascii?Q?jhchF4NtoyIwU6qAEeiJ7XzAD+WEHwDSAKGWP5fZX/Ctn6TmUFEszj+jqimJ?=
 =?us-ascii?Q?Vri9soUjYNfFNW4/ekrJkis3kc9txo3D+01SddR6OX00V8soyifqDuvHyz9B?=
 =?us-ascii?Q?nm99NHMaWLqXD+JG09efGX7UwYTg4/x6pBQxVoDcTtVgko4qN55FYiozBwY2?=
 =?us-ascii?Q?GaNli0OJLvp6RCVsrOJuJXYAZNAAqHeKNL83yqW96PLavwd1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae76f24a-f169-4a5d-9c02-08da4ac85f61
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 10:02:48.0024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xkBTBPiyt2rhi7aMn5Ki9qxGqt3ZZeInwLYlK3aIx/i+iE3MdorwB5U1xapf41cY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]

Hi,

> -----Original Message-----
> From: Peter Korsgaard <peter@korsgaard.com>
> Sent: Thursday, June 9, 2022 8:30 PM
> To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Srinivas Neeli <srinivas.neeli@xilinx.com>; a.zummo@towertech.it;
> robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> michal.simek@xilinx.com; sgoud@xilinx.com; shubhraj@xilinx.com; Neeli,
> Srinivas <srinivas.neeli@amd.com>; neelisrinivas18@gmail.com;
> devicetree@vger.kernel.org; linux-rtc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git@xilinx.com
> Subject: Re: [PATCH V6 2/2] rtc: zynqmp: Add calibration set and get supp=
ort
>
> >>>>> "Alexandre" =3D=3D Alexandre Belloni <alexandre.belloni@bootlin.com=
>
> writes:
>
>  > On 09/06/2022 16:50:03+0200, Peter Korsgaard wrote:
>  >> >>>>> "Srinivas" =3D=3D Srinivas Neeli <srinivas.neeli@xilinx.com> wr=
ites:
>  >>
>  >> > Zynqmp RTC controller has a calibration feature to compensate  >> >
> time deviation due to input clock inaccuracy.
>  >> > Set and get calibration API's are used for setting and getting  >> =
>
> calibration value from the controller calibration register.
>  >> > As per RTC spec default calibration value is 0x7FFF.
>  >>
>  >> Where do you see that? ug1085 rev2.2 still lists:
>  >>
>  >> Programming Sequences
>  >> init rtc
>  >> 1. Write the value 0019_8231h into the calibration register, CALIB_WR=
ITE.
>  >>
>
>  > This is a very weird value. Last time I had a look, I couldn't find an=
  >
> explanation for it.
>
> Agreed. I am not arguing that it is sensible, I just wondered where this =
new
> value comes from?
>
This information is missing in our TRM, as per the internal RTC IP design s=
pecification document, the calibration value should be crystal clock freque=
ncy minus one.
For a crystal oscillator of 32.768KHz(0x8000) frequency, the calibration va=
lue will be 0x7FFF.

Will update TRM with the required information.

> --
> Bye, Peter Korsgaard
