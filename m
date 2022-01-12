Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2D148C119
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349493AbiALJgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 04:36:24 -0500
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:46560
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238584AbiALJgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 04:36:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGEjJ84IzRRShL202fN3CtDuvdh8JduinkiNL9xE2Asu/TBeTHRNOq3wnYIgTYwZbG1dGIMVMCwa6iRulFyylITR1NBJR0eex8c4TguAzMLhpj0l8nTkqZ2uZ0MgdBv3pURt3YSA5KY+JckwXbtEz22aGcd0fmlqXQ+U86m13ljLDYv+mGxXzx1bIAgbNk+EkY+NlPXu95AUc26FF3MO3Xd3jj1H1m8xa4Ly53koDkYtBwLjWq2Q+8X4R83/26sSzj2eBfoohhSc7mSah1zI/neu2bz4D4fWjMJbtiwJmV7Zso+vPGgR0dEzzpc+24n/jMk3b2bLzXAogBnTm4TwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vJiMCgFv8kaUkNrb8XC3ItY0HsGRIs7fYoFSgS0D2s=;
 b=NRLz9vmH8eP+jQ1oXBOJ2URJWqYW9Fk+5Lf2yxBOWOX/5ytL3QUJlwJE1Fq0kb7q0REkeLJl7XzA3uByjdeUTpmNxYL0q1KGwUiaKUmhTB270t4tSMp8mZGZ3XOwTst5NQEL1qH3xjqT5vwTJyIgm0vXOa23VOoDjKIw3EEPD+tmOfJ0S5dVhMAhHSM6qfTHqR7Ab0woeo+jacZ+NhNYo45OMIJ8QwG7nzezwklNnm4mILY4LCGkH8gmTRTRJx75zNymr5bZbuyIxsKxgv0IQHNOs4OGYsn8ygb5g1JvXqdrqcgTDpuyIBT22wjU08QsbftsWabPjUICNi4LWwHcVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vJiMCgFv8kaUkNrb8XC3ItY0HsGRIs7fYoFSgS0D2s=;
 b=OcQ9NcYn1AbVWIO4NwvwD9K7Jb7sGBk4AzrqbdRte3gcj7bcK+l8b4LNJd74Fh8i5DRhWO7t18IEhB8EDb8LCpY7eq5QmwSHh77OGMeB6SMqDAnmMp6jAID8E0gSqinfmarb4oolJnNG7xkRv4SC3JX9p0T5YoSFD9if55eylVDzhvWk0gmwTfpK9D9zW2Kn1GgJLziC8lhdtqiCvDRhQLp+7De4zWKAC6O7BoKeITnXvWcAyQEPqMImCJHuQwAyTSqNBrwRreyH9Lf5Jw/VAPz9Sym4eSGcwXp/g6Rz1GE/d0S2g/tsKhjqHTu35qWh3otC7KAQpVUJtTzYFVn6Bg==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 09:36:06 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0%6]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 09:36:06 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sing-Han Chen <singhanc@nvidia.com>
Subject: Re: [PATCH v4 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Thread-Topic: [PATCH v4 1/1] ucsi_ccg: Check DEV_INT bit only when starting
 CCG4
Thread-Index: AQHYB3g6BTbLBh/KqEOG2ftoGm/O7axfA0WAgAANzgCAAAgRAIAAB2cA
Date:   Wed, 12 Jan 2022 09:36:06 +0000
Message-ID: <7b650925-3f53-7a17-de00-aaf7aae0cbc8@nvidia.com>
References: <20220112054950.615341-1-waynec@nvidia.com>
 <Yd6IVb5hsc2jpXqn@kuha.fi.intel.com>
 <0ba8f2bf-9b8b-04a6-e016-821200456100@nvidia.com>
 <Yd6ariWZtZN9PlBe@kuha.fi.intel.com>
In-Reply-To: <Yd6ariWZtZN9PlBe@kuha.fi.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
suggested_attachment_session_id: 8c2acf3a-fa43-c81b-5cea-6380dd801a33
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baa77f28-5255-47bd-24d0-08d9d5aef555
x-ms-traffictypediagnostic: PH0PR12MB5500:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5500F2EFEAD106BBDD7DAEA1AF529@PH0PR12MB5500.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iigT1bFMYapbib9vKQC3My8MxArm5lq68lzMwNW1jC/Nz5CWQJxrHzqZWnFMcOTDylB48ArtYHIknWaKfr2f9RFuBdKdYWX6ELMMq2ebC/avquPrg3HN2qYY9oLzuGLapnAAEXau5U9wuXK0EH+1GZNZFPKmM/w1gI6e7u+zj7wiZaHhf8A+Yn2Phl5MZ9O/xMG7KcxMRRsHF83iAndc34pcfg+4Y1Fy09UwnXpKKK9xQ6M5Z7jg6YjJ/+vtoV2jEYOepraDWNDnSbpYIBRODw7Gra3n3myOJY1Kq/PK6Nu5Tkd5BiwO+Ayle2oBTZhnZ1NjInJbkucBSH9wGEQbaTZh6l3qPZA1Q9r8det4m9JQO8IFoiTJYD36QoxUY1Wp1nfAOr/gi6DWNryWLg3G1f5QdhcZ5j3NrCqiED6uosV+wi+r8L7NGIeQTdaVPVKxkJUtwF6KmwcMiTgRaSLW4tnN8UkGR8ZoAs5B3W04uNXGnha/Os/Go7Vv5CbDA38eFGeEJOb3FKspMqpq6qYjJlmUgRTTdRhRbdJYxC30ohnIuCxBsOfoQPPrE7JIu7QZGZxUMKGR5UPKK3vC+EngMuTTfUCRm5nWBWlWdfiIDIQqVQBiINacTkTk+EFHgVqzq1a6CrTanMkoU9Sd+nldkbgkb7SIV9a2prH5P1pVEIs57BQvbZOu2nWI4x1vCslXIM4OM5uYlc9iT3dv/TdMFagyxvhtA0IUVKgxhIXZwItt6JeaaqnJ8cZ5v2FRpsOYmc0UoJPsH4nBUdjTY2F8skmU8FFy7DB298uemzUxdg78jYQsYA8slJoLNwVa2QIdtPjQa0/92mPUIIjtc1RA8dSYVVPgzThbTxCsh2buAxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(66946007)(6512007)(71200400001)(83380400001)(2906002)(966005)(66556008)(38100700002)(26005)(53546011)(316002)(76116006)(91956017)(6486002)(36756003)(6916009)(31696002)(508600001)(38070700005)(31686004)(4326008)(66476007)(64756008)(186003)(2616005)(66446008)(54906003)(5660300002)(107886003)(86362001)(8936002)(122000001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F0ODqkrQU2nawKl4TWjwJsrNnrOnkHzbKoxGVvzC6S+W1pzyfHUFPgf/UE?=
 =?iso-8859-1?Q?p7r3CrjshKm2N8hqjkpsXvF3qbALRL2Np+Yi3AAjQ4BewQb7EIVXK5BI1q?=
 =?iso-8859-1?Q?2gEo9gf2d5wB669IgrNgWJRiOp8K7Fq/CX0lmCOwfZvix//sfU6P/OPQ5k?=
 =?iso-8859-1?Q?iOR0wNtnEhgmoPTChRR76kYsCtrjVuxGzKb721NzqJYb6L1mz2lpYkZqKQ?=
 =?iso-8859-1?Q?0loxc6/IdrMrxnccK1IRrJf0hbpQ2z5f1wOvQ/n+jOwDXc65lcpSjrN4X3?=
 =?iso-8859-1?Q?szQBHsZW0QB7lOPkwhwneQluPnVMZN7vEH3LfpZZvOUpMQE0d10LPr2NZ+?=
 =?iso-8859-1?Q?xeTAdNdKLkfOjE32Phdws2WrD4/BmxV8uaAtVZVsQel+i2bZK3/+ARpoVk?=
 =?iso-8859-1?Q?C10lX3NPwKF+lvaaDw5DWw92TNpzVEWAPtFrxmygLEdrfsCWj0o+5ke/v7?=
 =?iso-8859-1?Q?xmJ36MBGGXOVcJhunxmBKEVp+BixE+601J8DHOlZMPw9Q74ZU+rxSRGECD?=
 =?iso-8859-1?Q?PMhN3yBLf2zWk48eUOc1Npmt7ptk0aR0M975ki1M8g9D/q3sTtTXDrgsai?=
 =?iso-8859-1?Q?WFfSqYU0IIVTscjOlj7piUF25+U7gfm4aRlhePoiVUhNhKZJ1ky8sQ6N0T?=
 =?iso-8859-1?Q?J3jkbXaUZXwXr/bq0I7p15LWUpd6qqJhLztYlpy4hAhuGr+uYE1DEWZ3ew?=
 =?iso-8859-1?Q?O3veVLJSaErqGYRyrZ5DCXPrwo1k99XjR3oGXTCtLbFdKB6r/hgQt23qh7?=
 =?iso-8859-1?Q?arGr5l6RWTLcsHFluCl20snZi9kR7mNdl58YeRykcRDoQkYw/Cw1nkakYu?=
 =?iso-8859-1?Q?3oqNgDBoDBEinyf7lRcs0HkZsI8xgQVNAsTedp4fDZNZ6y90NyPaM30e74?=
 =?iso-8859-1?Q?Mb+AzRRIbcsADqh+arindIsMupluc0u993v+0UgcOJcN4NwDLF7Hi8HeRx?=
 =?iso-8859-1?Q?1xhklmZlG3aMwd5emF7D/YTG1h61awp8MNAJHDCyoBn3OrU7+QDWHtN/tp?=
 =?iso-8859-1?Q?WiS6gAtDzmU7lbTWkfJo57ut/Lcc9wqIAcmEcaL0D8qFyRi5bxbWWbrDFm?=
 =?iso-8859-1?Q?gfpnz4wi9T95RMOWeW9qtzNrA0t9nClXUdo49AZlnbBtbUcnglgY3ISfuj?=
 =?iso-8859-1?Q?XUg86FUm5KfHznkpknh7UrXDBM4onHpbGiTI0Z3+SOw4Yap574IZhHQNNC?=
 =?iso-8859-1?Q?6rxlx0ldz5gCaWcaBrG5jYPVIdCe54Nzf7yXKLSPx15yrfx/OB+WosREcB?=
 =?iso-8859-1?Q?mcD6O0CZDEqfp1FmYc6nlYE7pKaoUlj/R4Yb5gZg67badtSVJmPAfGK1sv?=
 =?iso-8859-1?Q?wgMuEn2d3DpwP6z3i9+qSdaeYvyxLeCRmxmDinQ/fjnhYXUZnSIJ8claIE?=
 =?iso-8859-1?Q?ZN+mEr9ol1dvqg6654D0hDC1YKqJAtn55YRTRBf4FB4Obk3nsyYfBmOeCB?=
 =?iso-8859-1?Q?gH7s671/pMls2N903md9Y0NMIkT5Kis5FIB6RM/0H3MKvFk5qPobHrQ3/F?=
 =?iso-8859-1?Q?honfKHyAMPbx5ZsTYevKOn101V/V7Z3xhaM7Vt0T9Vn0J1T82FKa2xaFhI?=
 =?iso-8859-1?Q?57fbycvmtyJAUsuofUXS9H6zJoNoWJTu3VKaBdMeR7LEeCWbPNRuFPPrYH?=
 =?iso-8859-1?Q?jTwmAGqjwz0aBI35K6MuSjKClFB2zuzRPCypEBpXf5T5XdqzVrV+vUqg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5BBB9725073DAF4196132F19A1F30337@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa77f28-5255-47bd-24d0-08d9d5aef555
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 09:36:06.5878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1E0PC563qnnIPg/oF1r5KtUShQtvu3hqtSIPesrx94O4vx/UnvQVmWLXQUrml4ld7/aPoLwS95ZmuTCpfPhiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
On 1/12/22 5:09 PM, Heikki Krogerus wrote:=0A=
> =0A=
> =0A=
> On Wed, Jan 12, 2022 at 08:41:50AM +0000, Wayne Chang wrote:=0A=
>> Hi Heikki=0A=
>>=0A=
>> Thanks for the review.=0A=
>>=0A=
>> On 1/12/22 3:50 PM, Heikki Krogerus wrote:=0A=
>>>=0A=
>>>=0A=
>>> Hi,=0A=
>>>=0A=
>>> On Wed, Jan 12, 2022 at 01:49:50PM +0800, Wayne Chang wrote:=0A=
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
>>>> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")=
=0A=
>>>=0A=
>>> So... no need to take this to the stable kernel releases?=0A=
>>>=0A=
>> Should I put cc tag here?=0A=
> =0A=
> Yes, Cc: stable@kernel.org, unless you have some good reason not to.=0A=
> I'm guessing you don't. This stuff is also explained here:=0A=
> =0A=
> https://docs.kernel.org/process/submitting-patches.html#select-the-recipi=
ents-for-your-patch=0A=
> =0A=
Thanks for the information. I'll add the Cc tag in the next version.=0A=
=0A=
>>>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>>>> ---=0A=
>>>=0A=
>>> What has changed since v3 (and v2) - there is no patch changelog here?=
=0A=
>>>=0A=
>>> In case this is new to you, you list those changes under that '---'=0A=
>>> line so they don't become part of the permanent changelog:=0A=
>>>=0A=
>>> https://docs.kernel.org/process/submitting-patches.html#the-canonical-p=
atch-format=0A=
>>>=0A=
>> The changes are resent for updating the commit messages.=0A=
>> Added the Fixes tag which Greg asked for.=0A=
>> Thanks for information. I went through the documents.=0A=
>> Should I put the following messages in the patch after "---" or should I=
 use resend in subject=0A=
>> for the commit messages updated?=0A=
>> v3 -> v4 commit messages updated=0A=
> =0A=
> I think you can say exactly what you did, like "Added the Fixes tag"=0A=
> or whatever you did.=0A=
> =0A=
>> v2 -> v3 commit messages updated=0A=
> =0A=
> Ditto.=0A=
> =0A=
>> v1 -> v2 commit messages updated=0A=
> =0A=
> Ditto.=0A=
> =0A=
> Since you are going to do one more version of this, could you also=0A=
> start the sentences with upper-case letters in the commit message?=0A=
> Normally I'm not very picky about the grammar stuff (I make plenty of=0A=
> mistakes myself), but this time it's driving me crazy for some reason.=0A=
> =0A=
Sure, I'll also minimize the words in a sentence and make it readable.=0A=
Thanks for the advice.=0A=
> thanks,=0A=
> =0A=
> --=0A=
> heikki=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
