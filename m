Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAE848BD9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 04:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349154AbiALDTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 22:19:55 -0500
Received: from mail-dm6nam11on2087.outbound.protection.outlook.com ([40.107.223.87]:32096
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348321AbiALDTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 22:19:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvkxxtBjDYWHNwPmh5guqmuT0LJa45trUdg4wpv2Lnq12D2BfQeS5yBKYWe2f6RNO1NFU7d4Ao1xQOag0kl92rAVAzFtsUBRP61Om03bnpTlz0osePc1/04qXfryTAKp7vZkOJfr/Wy1smAfW52igfkw2I4jTBiyeuamj6H6I1yIFVAFgJn9xUSVjVzKfu0qsg0QPKmMvLvXqhHGAqN0+KbiC0L9L1C3KuINZamvbKQ6wmIeg/Ox1xKk0Ms81UUAF0ktNZG6oLoafVVXgMu86GUhLNSCoxvx66bq9mIey1xd91wL7z8HEG/exDj41jbLJKVHlx//B4HcY5z4JqCYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuoPgyiR5rOfbSnXf7DHfM7QljivMNKERM7RzClYR5Y=;
 b=cF+EKfgJwU+wzA4QbUVKXP3GDVliLHJJrcgrsZIMiIO4SXnrKAybDlvTyS62/85cYi7q+wo+LkUQAsuG2Xzc9l5zP3Ee8WR8+cLsDZSuzUDR8XH1hRM8aer79PZS2icu4smQkJPEM3Y2hDTZtZjTZSvD3Th5LcHHsT7h5sk3vCvVhXeX1EVZN8T0E04JDstVBQXk/ROhGpb6fIf0lGsZ7Qn9agqJ5jNIt+mppdTb61biPql9iQyGgbWd2srA4McPL0F4hvYZYUprFCEOfQA9gsF2hWa4x1FsQsMhWi7jL6L8xk/WucXIyQg42dtK2ffHwgIMTYW35D2bEFf9cqGgYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuoPgyiR5rOfbSnXf7DHfM7QljivMNKERM7RzClYR5Y=;
 b=St4CmowPZ5la3LQE3zqLzVsIpUT0RvTZ6PUffGzTVdwxGNay/HCVaZGijhF63HHpu+VCYq9aSij0ecGolmaP2jk1gwRZeprXeYc+Kz2L4OD14AyEojZakLge8Q/YZcbjtsjI6PJzZofRdjOfBm3ENipodwmCvd6DyFUgBhdlbRObvO2/uwh3RcxznrZiazcqVtV0sfhmeRlc01sqaPuLMY7Dh1V/5Ix5NOFnfSXl4dwvF6DhkkxS5xWqmB6JmdYEnqtFBcGYZzho0HCihC1k+dpitnMupweuVEDgYqYHJq3iAmvz7tjOS6jAjbECHUkOTyMZ1qRNSeMjl/58A5SOOQ==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Wed, 12 Jan
 2022 03:19:51 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0%6]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 03:19:51 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sing-Han Chen <singhanc@nvidia.com>
Subject: Re: [PATCH v2 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Thread-Topic: [PATCH v2 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Thread-Index: AQHYBvBJH4DecszPnEWyy1cyMFhieqxd2kWAgAACwwCAAAMrAIAA2DUA
Date:   Wed, 12 Jan 2022 03:19:51 +0000
Message-ID: <d06ba64e-885d-573b-052e-d60e6fdecba0@nvidia.com>
References: <20220111133643.589346-1-waynec@nvidia.com>
 <Yd2OTRrtP1XgxmHA@kroah.com>
 <a8b185cb-3f4b-9d57-7eb5-7c09dd3bb5aa@nvidia.com>
 <Yd2TRuUaZfG/+RQJ@kroah.com>
In-Reply-To: <Yd2TRuUaZfG/+RQJ@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
suggested_attachment_session_id: b38dc600-17d4-6a31-cba1-7286e53d243a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f9dff6f-2178-45c0-b207-08d9d57a65b3
x-ms-traffictypediagnostic: PH0PR12MB5402:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5402B13F565A04056857AB02AF529@PH0PR12MB5402.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhkoWbwGvzP7jQO6PAZ8i+6AT6oqCe7ZIJcgIjzOA7UVYVFFLBYYBKH3Hm1xxsn8+bTcS9y7XcOE/KOY9Frqz8xh85qVsPEd7o5pwOZPzEUQ1LmkUiZM0yyl7I7bJvHeuHbFf5dzI1hA5Zjjv0bT6C6L5bUt796grOXi8emkujMNx+0ZbouZqqUCgBZPL5/j0mQIIlrIOXXT1RwQt7OKEkVEi25KRd0MMeksvV00Mkm6xMPNfTIVMbNjCSGaa3X1g+noF+anclq0RuObpoOGKGi9pjS0qmwMqzZ1+ExM7c+xCsSyOAjs+fP2j43NKItPvsjN9gc6FJeDyTvqUrIo5J57BaJ+vcZfRA0KriAeyE4G8pHcupmqMj2z2d7hTArYwzd2JxCXiGCLWGJ7IOwgKsT1IP34cvxCNoekfiJWsPsOJk88sP1N/TOFDYn59KDBXC2YzKvVRkSCNnp0khMvyJdf+Dl/fcsUB2PUubZZ+NJ33nqNVRsvsdR0NV9NrgNPaPliv/C7SuWjpzg1gc5dzCdXzlCoVIN+BJRGhicgx88Z8+AOeWLh1Ws+pW6ZLj5RYCFEwhz2TVXCrH+doPZwXNKUIx5/Y3TtlDKZDscAD4MAtXk+bfSa7t0laz41PRipUPB7GIcxPrPFFaUzYW2qmK5DLk5CTq0IAA0yDxvjjcmm7rG7LUBLAEFgqYenuIFIUGh91I8JCfJIhF+Iw0Rq06w5iV/fk9P/71vUY8gV0r4hFVMAyKE8p9NYXm1m4GnNqdyyAcHDqIHg1+5gPHNimQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(5660300002)(186003)(2616005)(36756003)(26005)(83380400001)(6486002)(66446008)(86362001)(76116006)(71200400001)(91956017)(64756008)(66556008)(66476007)(66946007)(8936002)(31686004)(8676002)(31696002)(6512007)(38100700002)(122000001)(508600001)(53546011)(6506007)(54906003)(107886003)(38070700005)(2906002)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LdnJChKeNUDCkSpjjxRCq7cmh903a6EOGV/IbCZ6HIMBEmQtXYnOWo/CWg?=
 =?iso-8859-1?Q?dS4fweHxg7KMi4A6C48RUFbGJbtLdNcKRbO+dYddKFrV5MWOvegzeWmW3W?=
 =?iso-8859-1?Q?Uh0ikcYODAwIJWHfGWUee59Vrp3P+yMlwrBUEJEzlWVEPIraIryndKXMZ/?=
 =?iso-8859-1?Q?ba2aCKrwNns+uCZQG7gKmye0vquHsNxue6cVr4jcikfWVQrTupUt1JYp7n?=
 =?iso-8859-1?Q?SmSi1yDjVO3WdjEdIRRZu10SHxPMxrIZQ22J5hxm91KfoX1VGo4/vXCq+S?=
 =?iso-8859-1?Q?FlbMO2YCb7k41paolirhnrAiLiJhrwX95Fj7ceG9Q+N9V3rTOPeDdyyNHY?=
 =?iso-8859-1?Q?MwNTsj3LrPUXkUigdmGa4cbGgF39W6ZIY6ogvYfCnPDlZOEUmgJI4FV2IF?=
 =?iso-8859-1?Q?oz+ELIp+MHWWFnGskqnoTmHZ4UutZzJXbfkylNW+M0OSg34Rpw/Fl7d6kh?=
 =?iso-8859-1?Q?W37+xxfYRuEd51OQNTo1mzTlvjgs8R4P78xVksMvidH7qCkxm1bR+PNSpO?=
 =?iso-8859-1?Q?S+YxmvfEow8g3BzON8fgqCsVitwDwQVCFVMF8TA10qv9ZuI6uOcOVHlPBN?=
 =?iso-8859-1?Q?Ha/xGxxMNkzV1arMBUzo1i8tepMmEuOyWXUwxUN/1PoafXpGQkQCAinArX?=
 =?iso-8859-1?Q?Xg/17RXYGOeC4HaOTHp/SfSxzGdAnOvzpA4iSBeTaDHixtCS//AeQ9ul7+?=
 =?iso-8859-1?Q?J2PSYn5pBmfkyQdC3ok3xIwB4d3Y31cIco1PorPE/V8/0gTjCOiNK378US?=
 =?iso-8859-1?Q?9crY6laaT3o6o6pVm0madq+yIBol2BaVs8iAnGpj0gOs9xZbXwCGS1ap7V?=
 =?iso-8859-1?Q?HG4fXHIlSMHBNSS+k6bfhyG0fLOrk0fy6UmT3QF91OujjhmgORwfGE2mI1?=
 =?iso-8859-1?Q?Ie7eEVWWGTip72sw7aH/195Js4/zF9+81x4xocZZQIa22jcaHZo5huZe1F?=
 =?iso-8859-1?Q?BYmDxjSGR+IVVvIOK8ccGmX58GRR4UL3jC1l2GgjIjQJToknREdngsULFX?=
 =?iso-8859-1?Q?U1sK8mrJ0ii39BgV7tCtlDuf2L+DvH/J6Sa2Nz9IrBrr/EB2uPfQTH8Rwm?=
 =?iso-8859-1?Q?48TbtF3Gceifs/2JJJxq7HI1HHjrb3EenPc731En/4B2n2eb6Bn8i8H3ds?=
 =?iso-8859-1?Q?XQinUAvSCkIRlicuguDFisg7ACnuWvFTzd/hBoyUdBNeHTUV8s9wfHTuWU?=
 =?iso-8859-1?Q?qwmv4oaB0f/MwCnunXnRtW/HNtsmbSzUWAef1auiHA9k07DIzj/idYsIDy?=
 =?iso-8859-1?Q?vUTPsckz24kS4HwscXzvSVJnzFE4d9ZLxowjJ6txnC+E7BVokQOB22VoTY?=
 =?iso-8859-1?Q?zdQItiCOLU3ho50UajEFcaII/jmuT6PL46Otinw0EmX0I/BhFFMoXx0VTW?=
 =?iso-8859-1?Q?h7OmGdkjDDUAMA0S6HJqLn5r/jP7FTW4BpF3vHPdkhqwHmqF+7FtQFXxqh?=
 =?iso-8859-1?Q?o1X1xRMe9ae5g7K/Y6juea+AIyR+ybiMQOKETCG74AIUON2SCKPjQRJP88?=
 =?iso-8859-1?Q?F269vGQ4EfnH+v5MfM3mPKpJQ0H1DOxVbax0JgYmbbLYIoucBzLC2jJ0+t?=
 =?iso-8859-1?Q?A1JFxNQylpsGwudwnFcJWJy8ibaEKB0mvS1Jd5zwRITiVppz7A7etKMXR2?=
 =?iso-8859-1?Q?owJyp2lqxm6rXZpFlUZxSUawYn3Q4yDmS3VhMdaXggWNfMJPfcPJWGBA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <ACBD88191BF6F743BB61C58F08BBC117@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9dff6f-2178-45c0-b207-08d9d57a65b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 03:19:51.7856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oi3dj92tOleEc0yzNr/PyIz55/o74MEcDF8J3I1F9eM8aHWTg6CIACYeRNzoa5l8wq8chlJuPcQ356ZngqwRsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
On 1/11/22 10:25 PM, Greg KH wrote:=0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> On Tue, Jan 11, 2022 at 02:15:17PM +0000, Wayne Chang wrote:=0A=
>> Hi Greg,=0A=
>> Thanks for the review.=0A=
>>=0A=
>> On 1/11/22 10:03 PM, Greg KH wrote:=0A=
>>>=0A=
>>>=0A=
>>> On Tue, Jan 11, 2022 at 09:36:43PM +0800, Wayne Chang wrote:=0A=
>>>> From: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>>>=0A=
>>>> after driver sending the UCSI_START cmd, CCGx would=0A=
>>>> clear Bit 0:Device Interrupt in the INTR_REG if CCGX=0A=
>>>> reset successfully.=0A=
>>>>=0A=
>>>> however, there might be a chance that other bits in=0A=
>>>> INTR_REG are not cleared due to internal data queued=0A=
>>>> in PPM and cause the driver thinks CCGx reset failed.=0A=
>>>>=0A=
>>>> the commit checks bit 0 in INTR_REG and ignore other=0A=
>>>> bits. ucsi driver would reset PPM later.=0A=
>>>>=0A=
>>>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>>>> ---=0A=
>>>>    drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-=0A=
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>>=0A=
>>> What commit id does this fix?=0A=
>> The change is to fix the defect of ucsi_ccg_init func based on the CCGx=
=0A=
>> spec.=0A=
>> The original implementation's commit Id is i247c554a14aa1.=0A=
> =0A=
> Great, can you resend this with a proper "Fixes:" tag on it?=0A=
Sure. Will do. Thanks for the review.=0A=
> =0A=
> thanks,=0A=
> =0A=
> greg k-h=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
