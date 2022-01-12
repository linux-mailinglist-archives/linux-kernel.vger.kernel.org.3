Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F43548C01E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351715AbiALIly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:41:54 -0500
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:2528
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349400AbiALIlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFiSnn6GHRfW71gCQVtLssoNxi96uJ9Fuw/pQVjYGfiGfvgusd57oP2iowcO3Zk5iErfVibyhHsseqlIa4dxdHdKznC++HO6owLu0xA1VJVAPsjWg3WSYPXwZeer4zW+ol1a94p3rUd3Axk3CfvPY187vwWzivUY/RaBvRc06MQy7l7mawSMg4HhpXFnBfSMekt1aExbqPzYDRI1LK6lZLr8TlTnZdx48RvnAmJe8UeLbenBO0dDW+H/XH2C8dYFxQKPd4jD3DdMbgQQZA9zbjFZ+3SrfKNEyrhFqR0MmwEVKrXNAMiANnP92f+F2GWeb7hseFgPlfDntBVh3bZnkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7o5Hm/SbyOpJCbSE+gCojdRqFRwWRK4ovn0amVeayc=;
 b=c5yMIOpGKKIcdJWraPDdpsiLDZ57MyuDyKT8sLz+D/1U7f0W43ZXn7CiCIAhoOYarjA+ZhGdyvBoT9irkeFuLSXrOceuE6zR6RH+E2/qRn/ZehAQIrWdcEkTenSzvRYFzIqNdK+i26V+8BpRvso5rUYRJhpHnTnNCiIB5co0lSsem+AIp88X1xUity3CSl8mmxJIGjn2938WTaYX6RVzoVtFByXxqBwzBzmqkSZnpezfMP2Qwd11Uca7qQlAYJXMf6P4RnlKXC0zaTcEooCeGCYrb+0BoD5SfWeSmZUrmtTg9GNJmkhhO/G4b6L9G/0ekjMJGM42XwARK6btARp6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7o5Hm/SbyOpJCbSE+gCojdRqFRwWRK4ovn0amVeayc=;
 b=tvI3To2sK1Xm6EAFHQorFHGxkNU9/4dfeSOS6reGFGMfwE2ZuukrlayzyVgtl7ArwDyzZAVXqiu+zJe/umk9aEbDuR8wfJq2elI0ulcuXhI273O6GmrztwsVYEmiVV8U1L6P7+WaPcqJQ+Sp8qcJf6htO0taX42J8GZgXUwRDXLrav5hIPvkCphxOMxtPzaA+WLAY/AKsi/cjA7cwjdPDKVBftb0nKO9Pz2e8dJ3lkJOPYnQO9Dz3Gx0mVxkOBcOqqKPnNQVqlACtdH9/vJg932jtJDLmnCTFp1J7g6TpDeFdObNNEYLi1J0DoGNHVtgB8nBtV79kIHGBq2sB8Qk7g==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5499.namprd12.prod.outlook.com (2603:10b6:510:d5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 08:41:50 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0%6]) with mapi id 15.20.4867.012; Wed, 12 Jan 2022
 08:41:50 +0000
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
Thread-Index: AQHYB3g6BTbLBh/KqEOG2ftoGm/O7axfA0WAgAANzgA=
Date:   Wed, 12 Jan 2022 08:41:50 +0000
Message-ID: <0ba8f2bf-9b8b-04a6-e016-821200456100@nvidia.com>
References: <20220112054950.615341-1-waynec@nvidia.com>
 <Yd6IVb5hsc2jpXqn@kuha.fi.intel.com>
In-Reply-To: <Yd6IVb5hsc2jpXqn@kuha.fi.intel.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
suggested_attachment_session_id: b71e8714-068b-eed0-7a8a-f620d8517f9c
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d45177c5-2217-4ab9-82d0-08d9d5a7607e
x-ms-traffictypediagnostic: PH0PR12MB5499:EE_
x-microsoft-antispam-prvs: <PH0PR12MB549904401986BF457C57B9C0AF529@PH0PR12MB5499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yKGc+8046DeSD3+F7bLv30pVzasvHFeHvXUIsdJj7vzznvKCzGCgv7xzgi4zm3Uue/PQ0/IQki2ZiJNd7lRLHwQofMYTtJbP4fgxsILfQZpJMhplPrGt1aRsu5k2DbFTZfXquFtn3mEXazJR9E60Jq/zEz23G5cmFXfUAXUUfJLUlplxh7rJVGSdIaauwMzDASo/37VKDuiAY0nWx2l4k/+NWIg814BhP+jJPmku4nze7NkftvJYPgBwZW5Z6QvBQHh4yiXwEpSNa2dWy1SxKrTe1A/6fnq3IUWLDW5+54biKPb3FWwWOV9WaFOMNsznQx9B0BAGLCu+5z2LDAZoxCPrljv9GhACjN/oQM63uH1paO0T7c0yxHoHIOBDD+k6/rdcFl9BmfNS7J6aWhT3aC1fkheGrccXWQwyPrY+070c6Cu1qb5U3PFeHXsttSkYJxppirQIUjlZxYcmKsZKJJakG9SFMp2kO56iN44pa23flXQkhro2wTX6ytpAQKcg+GtA28u95mjBkPvlyb1K1IAZDBsGd4vrS8ecnFPZmREd7Xv6QR8vq58H3q08u0RKZ9PvcUIHdxS18FW0uN0WqPdN8IqT+NrYso3DyP4j57fjjP1XXnsyIPOaNRTUMsq2QBgMNhs5kZYewf3JnXcS98vU17mFRXMvGah/wL38IXJWVLUYqvckb102a+dBn4kcDS2ADbwHZnq4UH3sepThGVILGuIstwifxEijv12MZsceBIWEXDwCvYAkkdh0gyyKYPjUtXXo9djI9FxKwnvBO9lnsQ0uSSWD4dHc/2UY2OCiI3ACkThTIU2KHi4DquLm1NmkjnyAHQJXJCHhzKdyGm4U/FtBmntKYmUAtEWnh9M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(6486002)(6506007)(36756003)(122000001)(83380400001)(66946007)(66476007)(107886003)(66556008)(76116006)(5660300002)(91956017)(64756008)(66446008)(31696002)(508600001)(38100700002)(8676002)(316002)(6512007)(38070700005)(966005)(8936002)(2616005)(31686004)(4326008)(71200400001)(26005)(54906003)(6916009)(86362001)(2906002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?887UjNCixjGikyI8ZVOCLKy35zt4TuUFWn5BdgHvZ+i4R+q8J70Pn9hOx3?=
 =?iso-8859-1?Q?uDwYCOG78tREZ5XYzOxrPaLhntPn822cK4MgzXJdMEXIzl0JAj3ci6SOFA?=
 =?iso-8859-1?Q?+ivGxD6dN5S0FYxoILIRHoLW+Zo2se8hLPsalTNB6Di1gS4tMcp7rbIycg?=
 =?iso-8859-1?Q?lUfQ28MISnR4toH+FITYVPmFzeCNnAH+xNLh9i+AxugBy1dymmWV6nFkoY?=
 =?iso-8859-1?Q?CaV/Reqi/vAFWlNp/bWGioz7yqeKBP6TPsaiwwuv4cdgxGmFFK0Mq2TYu9?=
 =?iso-8859-1?Q?cA4iuMd9eEF8J/X5UseLs30tzNNKlEqtwP3stDS7/b/dggUrDc+J/g/H3l?=
 =?iso-8859-1?Q?WV1EAV+ebYbSICNkKnLVhA7jBJr9ZNYA/ZMYnwSRdwx49+awBfJGUQk7jR?=
 =?iso-8859-1?Q?iOTdSORo/01QZh4lNaxKQmqQ2fKnHNHCdQ6FEkDeO3C+ldbQGoh0QjixSD?=
 =?iso-8859-1?Q?HGKMeQkpgevoMZjtaXGlRA8ZYTsdG6CZVgRivqxC/U8bfxjU5TkQ+8ovSD?=
 =?iso-8859-1?Q?G1IO6W02rov0Ba4r6mGghCQoXkSnvLzIzUGg+9XuDtpVrrcIOYrSCR+Ggp?=
 =?iso-8859-1?Q?rdYP57TkLBC35euLI2PzwrXGgi1ttzjR+WV0sYuLg0bN+lrdV2xC/P36Nt?=
 =?iso-8859-1?Q?Fkv1cbJNOH4SqlfRSHVY868InAsB8dypGUUAlrTOKkNWsfTs4hK/o/rqZB?=
 =?iso-8859-1?Q?f/xcwTLKfHp7E4IbcPzu+vEzu/QGbI9f4lpmF7ZIDfJVVsb3zNs+VodZ1S?=
 =?iso-8859-1?Q?MS+6wdKv4nq3Tv3NslLLxoHsslMwk37P0GAhFRi7JQdRZY79P225VTPap4?=
 =?iso-8859-1?Q?N2jxxKCOjQgCKjpwopVuVJoKjj15L/QBeNTp00uxdlZXJpxZmH1oTmuG5C?=
 =?iso-8859-1?Q?mB+i8DAsFUXT1mTWCTIKpFM65OgokaAhBvVCE1i+8cYpudtGm883wIyzd+?=
 =?iso-8859-1?Q?rWy461IRXmJ/P4KkZEouqYFx066eUHJhm/c1aCZScemtm2cZVPqi109BW5?=
 =?iso-8859-1?Q?rlr2cog3uAh/w8Fr4hmzXzD8cyWVZajXrj6nb+5QxphI9UlegE4aJdJpgP?=
 =?iso-8859-1?Q?vilrEO7m77jghSFgGxtG7L+M87cmKgewrBzNdSw6OIQvFjQteCrA2cTM/z?=
 =?iso-8859-1?Q?bPUyRj1/yNI0lW21sk3SGsUFPOuOxUmWUDy1GbCTUCVC+unaHkvltk3qpv?=
 =?iso-8859-1?Q?i87s7Fs4APGTS/wF2TLER05X5jbtwOzku5BW1m9yB/4i7yAM43vyTsNtRp?=
 =?iso-8859-1?Q?GRiQKPqRH8OZAC+74AFExtDpCGloizwmK/SUmALwEEREBy9QuvoCNXjdPo?=
 =?iso-8859-1?Q?cSfHTrQL9cdtQLiByZthCj7SJ9ivMYzUM+t8ZsJkC2TbSPK22yFw5ZhGzx?=
 =?iso-8859-1?Q?QHnWFO9V/XbrOpVKDhQgaMnEOKzicKDAgc33yIwAJp2hgf7HW5uJCObL1C?=
 =?iso-8859-1?Q?QezM79dsvsNYXZT5Hbb8/VrVjWoqWz2ovVRa/G3ZoDhXfPlTev/N+T9mcf?=
 =?iso-8859-1?Q?0mLfR854BQWH8Jm5eJcPZyivKnHo3lSf0eWB9ACAyGJ/zgVa0uaayNf/r5?=
 =?iso-8859-1?Q?+KZdvyUX4CXdPAH6t+3gT9X70ds3wiiPsg1Zm5Z7f6oMKN+aTagDe6MF4+?=
 =?iso-8859-1?Q?oPaMlTS34chBNkI3IHtNhwySMDNyu02/DeXWXEiqjxjHf6jEy1y436Ig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D8D708EA5EFF424186BD9D6274FB7ADE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d45177c5-2217-4ab9-82d0-08d9d5a7607e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2022 08:41:50.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxoEayf4uxXjgH2+fvk5Jkxg8KefEQnlmSC8nxB842IHKlKIRnEyxZ7EVxPPd+pJWmJfMX6uiHjUMED83eNWfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki=0A=
=0A=
Thanks for the review.=0A=
=0A=
On 1/12/22 3:50 PM, Heikki Krogerus wrote:=0A=
> =0A=
> =0A=
> Hi,=0A=
> =0A=
> On Wed, Jan 12, 2022 at 01:49:50PM +0800, Wayne Chang wrote:=0A=
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
>> Fixes: 247c554a14aa ("usb: typec: ucsi: add support for Cypress CCGx")=
=0A=
> =0A=
> So... no need to take this to the stable kernel releases?=0A=
> =0A=
Should I put cc tag here?=0A=
>> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>=0A=
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>> ---=0A=
> =0A=
> What has changed since v3 (and v2) - there is no patch changelog here?=0A=
> =0A=
> In case this is new to you, you list those changes under that '---'=0A=
> line so they don't become part of the permanent changelog:=0A=
> =0A=
> https://docs.kernel.org/process/submitting-patches.html#the-canonical-pat=
ch-format=0A=
> =0A=
The changes are resent for updating the commit messages.=0A=
Added the Fixes tag which Greg asked for.=0A=
Thanks for information. I went through the documents.=0A=
Should I put the following messages in the patch after "---" or should I us=
e resend in subject =0A=
for the commit messages updated?=0A=
v3 -> v4 commit messages updated=0A=
v2 -> v3 commit messages updated=0A=
v1 -> v2 commit messages updated=0A=
>>   drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-=0A=
>>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/=
ucsi_ccg.c=0A=
>> index bff96d64dddf..6db7c8ddd51c 100644=0A=
>> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
>> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c=0A=
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
> =0A=
> thanks,=0A=
> =0A=
> --=0A=
> heikki=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=
