Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF21248AE70
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 14:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiAKN3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 08:29:53 -0500
Received: from mail-dm6nam10on2086.outbound.protection.outlook.com ([40.107.93.86]:59310
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240497AbiAKN3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 08:29:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzqSK8ePv7DkHLPUJhim7BfiScPcem6X6dLqeds35CK3SMt75pw5ASlXxmgJzsnLbTsoVhrLUtMgdgIY26xPo7r+oCaynLcJHAw0D/JEaGAyhntS4f0Eq8R2/2xIiggecuEcS05lTUYUBAcqMrxtxShFtc5+i5MJ5g18FjY0uYKv8HE0LUwXopaOBFdugGVJzYK5P/LI0Ad7x/M1dOK4Oort+EwYRJoylha9WGxv4xrQAHg0NW1QJxqO/RqvsJGspcNmt67ALnpy1ffGWSCtgxVB2hvboe+ZrZQKLXSZi/cQ9jHFWksnZkk01gXpu+8jW/rZmcoWh/cbPOzHBo/nsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILiNoMALXH+nW8WGs2owJdY4wqvIX3FmYtFcM39weHU=;
 b=dTs89hxpsY2DgZaKOja+BGkgieNPOgvCgejc7Xi4ogX9UWE2I0BPI41LWGMIF/L59+PeVWJdlZsS8y7O7C9qfIR5ijiF+708cS1iADm/ab46+2MYX9HQlZJ86D52p3CSGM2Upn+zNU+7PAdhkWD4acqKQZhSQgcONWXzqiGa1eV2IKY2kCtjVM/g3nrJ1cArI6DllbJqDOOW2c6L+3ZaDc0tVjXtJg6yMHjl5IyeW2X52CdFp69Im3hCP/V5MNq+J29QJX7Wib/DeYjsEzhA7K2uIZGiH3LI9ut/k9EHEO8VU1cC2KPI+DaPDq2JaDSATeVqUqJhLC25c+MofdBh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILiNoMALXH+nW8WGs2owJdY4wqvIX3FmYtFcM39weHU=;
 b=gC7JPCeHi8vaXLISXxHmn88rqecTsF2CSvE76uv1SDcxuEd2r2MJS98eLa0Cgwnij26v4iQXN2/7t84kKZYvTuKofmpitdqV9/KsSc1/cHTFrv6gVWqHLwKa2gZBdTEaucU0aid/jpo1FF90UVbhlDQFbLH4eSGC92SIDR4FHGZfPZpWHTcipFekKyDxSnkHBR5eprysJRW3Ym3woOib5c9K2Q704e4+l3YtOYctPuttcvGdYTScn6ep8Ytr5crGylEmiXEUYVWOKCd+xgKy3avlIoz0VhOFXc3ey33KTkrLDEkHUwbp/IoCqkkOiqymDdC+6S7322F5VKmr/4c9ZQ==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 13:29:50 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 13:29:50 +0000
From:   Wayne Chang <waynec@nvidia.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Sing-Han Chen <singhanc@nvidia.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Thread-Topic: [PATCH 1/1] ucsi_ccg: Check DEV_INT bit only when starting CCG4
Thread-Index: AQHYA6h2cOW+eXeV60COWzAQTHIB6axcJoKAgAGwY4A=
Date:   Tue, 11 Jan 2022 13:29:50 +0000
Message-ID: <fb83599f-3de7-bae8-af7d-ca4edf6f21f9@nvidia.com>
References: <20220107092455.150504-1-waynec@nvidia.com>
 <YdwbQeygHoF2wAcI@kuha.fi.intel.com>
In-Reply-To: <YdwbQeygHoF2wAcI@kuha.fi.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
suggested_attachment_session_id: 3f75ca72-85f3-5d10-632a-637a164262f3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39377a66-bbcd-400d-1a8b-08d9d50671e1
x-ms-traffictypediagnostic: PH0PR12MB5467:EE_
x-microsoft-antispam-prvs: <PH0PR12MB54673F59D62D9E817E6A5453AF519@PH0PR12MB5467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XMkpBC/9g1N9F0lHw6sCPTdbMiwrcS4as2d5EoZV3B02KEHZOgCDRw9MM1jkrYPnZToy/GWnUzDbCBY4iF3MxlqAIHhndFiGGaOfU68sVZvI9vy7xBAjDhofZVsBgjLZCmpz60PFBAScFX5QeNjbGt/QVJIuHTOHOZYFsF+FQjT7dRlQBwf7aNIrDJl1DBtHakETTqr+CPAjTrv8DWNh6wNPZ9zTrFJXprlx/aLRIXqyuzgheLG73FEeOV/4+KYLuF1ytCCPo4EobpW/M1/3DfN3guV16dpS/BrbxrYy0jN351pB6xqv5UliwCsYAC6Q4enl7QJzlamXFXE+KockilBaLyZC5DwiFJiiD8KjFj2NEt20a2Xh1DocoZhmX14fJZpLRMVgLkVQzDgDPCd2GJBYjLEfw7JjonHkhz68kXMrfPz+mu0+zWVKhp3WXluxOgmxtkkR1hhNL81jACzQhyw9y2GuRshimlOzepdCAs1fQ6qxQKy58UM4cgLRBrifc86/CPvQoG19GIBKkrXVsx0XvKg9ne3ynwkZVcotfBfZBSzvO1M9itaeYNlD2DiGtMb/sP4dS9QUiqj5iVooEX/e2dwRq3TRVvTu688GK3gcPiay1iv/fuogQ0ESqa00+cDZLJWrd9jlRcn5p7Sv58NW033Dw7i4xmv5S48Srn0/gGaIuEjQtp8s9RUmJW4Qb0JAvymQYHIkqOIrEaxQNTUHeRduE+8QJnyuRjvg6jvDQ2h5vDzMkcv/N5Ce0zaCLxTOa/yfwOVdlyznfiUbxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(26005)(316002)(64756008)(66446008)(66556008)(66476007)(508600001)(6506007)(8936002)(66946007)(76116006)(53546011)(31686004)(91956017)(38070700005)(4326008)(86362001)(122000001)(54906003)(38100700002)(8676002)(6486002)(2616005)(31696002)(71200400001)(83380400001)(2906002)(6512007)(186003)(6916009)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MiZdDuvdCdSMIXIG5PTQsqc+8J+VtP6JESO3oWclWDWvefXrb8YfpVR0zm?=
 =?iso-8859-1?Q?S47kq7kik/NNyUMoamuy8TdQUUEPJLXwOlEyfxqBPbir2SBHxamRbHh0Gn?=
 =?iso-8859-1?Q?9U6BPFzvZq8ukMw4iehaDmko6ULILdG6e1woyAKXzoEYguqjaSN810bR4g?=
 =?iso-8859-1?Q?CJGCotlPqxe768LOmCSrfS91+9/EKPy3Lyr4Ckc13EjWHq4ciTbtNRu5mB?=
 =?iso-8859-1?Q?kZ15e9v6spSPkHiiqiqgoY4EMLL7Zm3ZiXGH9Y9oGStezH2SzDkESCeBla?=
 =?iso-8859-1?Q?17FBQGV/SKDJx9uG3Ox0vTGYVuEhGZg8gScFs+u9gW4pczRvIUud1RYOUf?=
 =?iso-8859-1?Q?RTQrgaIQ8gtzfMUoEPNJh2JhzqKG4T1YnZJEDRmFtv3WgvHNS9VyEdSzEv?=
 =?iso-8859-1?Q?+0asfzANnZsRsQ0POCz9Y15CCZoWeDkmAY9mXr02kIcZB1y4+Wot1+RMo+?=
 =?iso-8859-1?Q?WdOrghleSy9LxiwjjIiJxPsLnbytUwp2GHLesJ2urwwcwXtcVYGLO6L0Rt?=
 =?iso-8859-1?Q?3aMIJ6CQYo1GmUm1psy1V8otnU6PxLW/Re+XWJlmym02Mv0Vpt98rsIacr?=
 =?iso-8859-1?Q?gfK8VmMtwZJHsHNQhW/pSp/2VpHaKAQCdn+4FTo4vWk3lmiJBkdptZQN0b?=
 =?iso-8859-1?Q?c5wJ6sVozVkeLX1EyDWHoRAnnTCCGEa/69ZmHjig0+WCCtQb2xt+13gyFp?=
 =?iso-8859-1?Q?RaVVFo7pO73wr9OLJPs1FCeO6i7rxBWmy2Imt5aSlWP5ez52gWTbhqivjn?=
 =?iso-8859-1?Q?nxI2otvatRytVJjOWYyB3XIngOJOFMm+T2g6j7Pm9mIta/zkBRflK80xyh?=
 =?iso-8859-1?Q?7nO/7m+QKbuTDLvfXbBidP9B5S1CzL8TnZYXIQ8/9mRHYckuV8HKwGwWnC?=
 =?iso-8859-1?Q?umeo/0MnCmtIDH2DeNntBIXPCdhsjR3YAdu/Se2zyqzQ2vq5EbVyna545W?=
 =?iso-8859-1?Q?TjU9o8W13Ijrt9Le3wgKOJnd8/XgKZWAc94xWopB3ORFO4QviHCR3xXsVB?=
 =?iso-8859-1?Q?ONJ3uWH6w71XkVikyllrJOoJKWPWlWy4OInQlJPRiZvldODme+CtJx5TzI?=
 =?iso-8859-1?Q?XkdpQN22tjapWPP+bwpJDTSrDF1cj851FWjcMNkw70505Dtpat5lw+SyRf?=
 =?iso-8859-1?Q?IYvvSXEkbh5dAnzyVnzC5GSapOyegOgdkwYSRnhXoOVdHr77otAqEPwjVu?=
 =?iso-8859-1?Q?9Kf/i4rSQV0to5LLjY+Z8Cydd+zrYSFhWPrt21HbE2gJipUtNnJsDQEMWB?=
 =?iso-8859-1?Q?fsVGX3BDtxLEeK6nCQlnIKF63WtdWzqT63rDgOPf8u03CEpTVTmL1zbvY1?=
 =?iso-8859-1?Q?F6e4MMNuzTBRj30/y70/DZYKOHd9daEQO4HzFB7WHvwXX6YiWRALa30uvS?=
 =?iso-8859-1?Q?wiPu3xCecSisY9mi3UIrMBfzDRTvFZ+vhUNnZfMtb86Wq8iw92XqNDyWIo?=
 =?iso-8859-1?Q?QihlNXJOor/i+itlLSOdxNEuCmAghOjflK/sRgYmo+AkaXWi3MkwWDMQwe?=
 =?iso-8859-1?Q?Tmb3sOP0m9opBM3kibftW3yb+qjEckFVnw8160XgM7zgfgEj7wrjZnHO3b?=
 =?iso-8859-1?Q?s2gFWyNv/rB3AAjJQdBYS55WdzepvsvInYIE5dM6IwhIG5TP7zawmJL2cK?=
 =?iso-8859-1?Q?vYsaZDAySXzRnGsQEF6rql0eYn+/qDmEhjeaDhDUPKP5wzB/9rMvaIgw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7B2E89C876683A4E920C0437BC7B61CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39377a66-bbcd-400d-1a8b-08d9d50671e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 13:29:50.5952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZr5+FWlKhMDLXWI+OG2N4MV7/SLrol9e5YIJU6achlKdSDKhhOxBNOMG+yOLPlENiiOEEta/bCpoGqdgbB5lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 1/10/22 7:40 PM, Heikki Krogerus wrote:=0A=
> =0A=
> =0A=
> Hi,=0A=
> =0A=
> On Fri, Jan 07, 2022 at 05:24:55PM +0800, Wayne Chang wrote:=0A=
>> From: Sing-Han Chen <singhanc@nvidia.com>=0A=
>>=0A=
>> after driver sending the UCSI_START cmd, CCGx would=0A=
>> clear Bit 0:Device Interrupt in the INTR_REG if CCGX=0A=
>> reset successfully.=0A=
>>=0A=
>> however, there might be a chance that other bits in=0A=
>> INTR_REG are not cleared due to internal data queued=0A=
>> in PPM and cause the driver thinks CCGx reset failed.=0A=
>>=0A=
>> the commit checks bit 0 in INTR_REG and ignore other=0A=
>> bits. ucsi driver would reset PPM later.=0A=
>>=0A=
>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>> Signed-off-by: WayneChang <waynec@nvidia.com>=0A=
>                   ^^^^^^^^^^=0A=
> You probable should have a space there. In any case, FWIW:=0A=
> =0A=
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>=0A=
> =0A=
=0A=
Yes, I'll update the commit message and send it out.=0A=
=0A=
>> ---=0A=
>>   drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-=0A=
>>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/=
ucsi_ccg.c=0A=
>> index bff96d64dddf..6db7c8ddd51c 100644=0A=
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> +++ b/rivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> @@ -325,7 +325,7 @@ static int ucsi_ccg_init(struct ucsi_ccg *uc)=0A=
>>                if (status < 0)=0A=
>>                        return status;=0A=
>>=0A=
>> -             if (!data)=0A=
>> +             if (!(data & DEV_INT))=0A=
>>                        return 0;=0A=
>>=0A=
>>                status =3D ccg_write(uc, CCGX_RAB_INTR_REG, &data, sizeof=
(data));=0A=
>> --=0A=
>> 2.25.1=0A=
> =0A=
> thanks,=0A=
> =0A=
> --=0A=
> heikki=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
