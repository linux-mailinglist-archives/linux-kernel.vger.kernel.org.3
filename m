Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE75348AF47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241433AbiAKOPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:15:21 -0500
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:46721
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241480AbiAKOPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:15:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPJ8JMMXNJGkQIC7m0jtfzLJR1p6upx6PzBdSlHMsRXypEg1ctwLV+7lI8MCRlbIaeQLzs+qKsfLtEOEd1yWQxmvWeTGtJ8QFUdJa/HQ0XuH5sNajH+qk2zGN4fSFq60lhQahIRbrXkj25KBjH94irYmskoNUTXfFLZrj3yPK/YdZYOLLLVfNVGhQ9hfB0og/sWp1iF6/hEy3zodnj4VCQWwtr8/mVP3nMYt0Q8fe/3QmH9zQ6XSPJw0pzKgMbNPFPoogw+aBA4MrsQwRNDf2q5M8CgsrAPUi1rj1KdHQVM3ue2lc8Dht3l2nZfloImY+4MTvDPbOotgZxkMCMGOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4W5LAlcjky45SVJxhsm8c9nx5IcY67vjQd5Lp4t4404=;
 b=e7B79zCGb4pedCh2H5JZmX+FuPDjYBviyhR94rl6Xhl+G8KioLhjgu8sQLYgSJvPASKX6uOFqLsD8jRvQ7CkvHnJ8pWFmPqw7iuKEb1Pkbwe6G8qrv0XvfKoXXTuBZf7L3lT2oVKQjc+rF1av3g9tcWHvUhiR0Tx6Ih/RiMlnV64JElNZJf+rd23LCQs5Jr6fiVfTSucZ+Is1Q6wtxS2Nxb3iLa9h+3cz2oXIeijDniwq/9uZmycM7+VcsXJl+AVLEAa0x3grUv3bJltNuVIkQ4rRkeTgSY+n1Czb9VY8nXw1MVUi4jLjCuYs0vHuZYWmXedsLRRdk5skAXS4T3uVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W5LAlcjky45SVJxhsm8c9nx5IcY67vjQd5Lp4t4404=;
 b=jco8pDpKUO/Q6bwad+v2xcBKdEcS3B/iirNs5/R3QpXogSX9lwkAuGeEPOlHCuCYYNNheCgfk92t64clRkhaMQ3uoa1daly7J6Ong+le2NGtvU43c4oJPiFOzTdTBjr8gvpguhudj06ZL9BPeQ7i/g5EdlOoPSS1JTcLqWk5JbuiFRVhOBlYE9havLfchlTzgiEF23UTiBTja2On4zKucGgU+Wrl2ljs506fuj1E16IzA8c/sQhU1lm0nP84mh4Fa+J9Kthc7e72D9OFfv8AuECjATvEoQS7KlZkagrPdiBoo1IYaaxdKbxiNAAv+EwRTUDKaiZpmUXqnCwJ/cMyCA==
Received: from PH0PR12MB5500.namprd12.prod.outlook.com (2603:10b6:510:ef::8)
 by PH0PR12MB5467.namprd12.prod.outlook.com (2603:10b6:510:e6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Tue, 11 Jan
 2022 14:15:17 +0000
Received: from PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0]) by PH0PR12MB5500.namprd12.prod.outlook.com
 ([fe80::acba:c3f:c806:8ef0%6]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 14:15:17 +0000
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
Thread-Index: AQHYBvBJH4DecszPnEWyy1cyMFhieqxd2kWAgAACwwA=
Date:   Tue, 11 Jan 2022 14:15:17 +0000
Message-ID: <a8b185cb-3f4b-9d57-7eb5-7c09dd3bb5aa@nvidia.com>
References: <20220111133643.589346-1-waynec@nvidia.com>
 <Yd2OTRrtP1XgxmHA@kroah.com>
In-Reply-To: <Yd2OTRrtP1XgxmHA@kroah.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
suggested_attachment_session_id: 213d48e8-e52d-21a7-3a53-7134e5c23dcd
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa1d0e38-a59a-4774-9097-08d9d50ccafb
x-ms-traffictypediagnostic: PH0PR12MB5467:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5467138F41CFB17B546FEA3AAF519@PH0PR12MB5467.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIRqPzOrzvjifTfa1daTCWSOENEP/YrxRXRjftbIDk0Y0j9JIJkVnKwZULqaNx1VNRMEGdyVv66oPZc3FkB+e9TgF/0cYYrTYCG5IqlR6Ndp01xG7k0yHA6NZ47ZbBCIQkZ8wPE2uACJAInBaBoY0wg2rVyfKGImeVIpaGWSbe4/Lk76S566At47tify7NurAt4cqHoMDRcZzvrgGozYRRdeN2STgbKkpvsB4urdf9ZZvEWRvNo0oGPicQ9My6BO9rDe6U0Zh4XStJGNJpC8zrX/d+YgLzgP7AwuSorV53dfS1OUKJ9nprKI7HvXuvCqJhsBmvxNGUnc40Gsoaf2GPWtWCowa1BrzKaPne430A5YyV78bAskkDujhGpCXxs2IhRghCXC2yQmZcDnesw+oJA9n24Dw3R8kzs1n7CjeoCcJ0lCyypfQwaIqZtoj5IVmMRLuZL7V1TbjWxDxCztyl4lgoOvFMlMoNAXiJjOQ9pPA6S0mhF4kPYFe51VBkfUO+M83iFPveqsU3i6B27PbEz/rvV4ih34bGqGMKFnak2goapXPz2zDc7W2icSXyvJNRDfCSt/0Cpa8X7jXH5mOCLaZEfajfSPRaNBhB1M9PzjCz3DxovxM4Yny1UAWognuAeHuXc9ZqzL4zDTQGSXtxQYD+qspIFUQcHILDRXRUT52ykgiFhiXRCYldakzDEyPXaDF4XxaDGSFAYGwqoZp4rHokmy2TeAGOq9/Bz98qEObhjITu14556mApndqS+gNwnFpK51gexZ/0folADI/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(31696002)(38100700002)(6486002)(2616005)(86362001)(54906003)(122000001)(186003)(6916009)(5660300002)(83380400001)(71200400001)(2906002)(6512007)(4744005)(26005)(36756003)(316002)(8936002)(66946007)(6506007)(66476007)(508600001)(31686004)(38070700005)(53546011)(91956017)(76116006)(107886003)(64756008)(66446008)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XZqqMuMifMzIJxlynHZyMhZOLNEg7/Qnnh7Yjp+c02OM2SYP6O79hSwAwu?=
 =?iso-8859-1?Q?5UIa+Hoc0Lwfq25fWoznOnGVOxzB+r1xDAfV0plY6rzqOEH+6D/fUNkLRP?=
 =?iso-8859-1?Q?NLiNSW3ngnWKB9S/lCMsQ0L3ZGbevGq/sNHAGYkDhGm6QoFYBNjYIINWnC?=
 =?iso-8859-1?Q?F2Zu3MdcjJv/dYfOKmVm+hcZjPNpPbmq6+SkrLB2nD8b+3VClvaqmTEe8R?=
 =?iso-8859-1?Q?00abfPFnr8lyercvFnXulEX8Vsg8hSvMCjZLyIZBDF93sne4fH0p3Gx/0y?=
 =?iso-8859-1?Q?EaNUkyxBpaNIjry+SGRczp11C+fFX5omiaB9AjoLI9VmvWNnPKxbH2oYuA?=
 =?iso-8859-1?Q?RTzOY0+EcBt4Qx/drVBdrc/4bezDgoKuw4hoj7vooh4kGfGgP5A2Bi7NMQ?=
 =?iso-8859-1?Q?AT/2+1dzvyBN2omzltrH2eroOuP2m9hcqJ8ntjbFuhhUxJPitYGLGIWYl0?=
 =?iso-8859-1?Q?ZQq35u/oIC+kgDYky3PugNc3hBN86i284P+3rzyrGxrREzWCO16qfpv1YB?=
 =?iso-8859-1?Q?DO4DJF/IliT57ENB0ImWNzuxXP4aKxwkS3oLxdCVkJWK5P6c2pHxi+XS6i?=
 =?iso-8859-1?Q?QTPo4lNixeXu9ZBeF1NpNYpdCXmdDo404kVpeYFtHtNZgnmyZezAOTeDnq?=
 =?iso-8859-1?Q?V/zhdwjthgCCBRzejAIyZT+Rm+8GzPxVCiWNoqWqd+44rwTo66CpSgMaJ9?=
 =?iso-8859-1?Q?jDwh96rb5hXUbDw9vbHvwRp22rJ1Y0pjzaxjeyDGZAHJbWqlgYUeeC9p58?=
 =?iso-8859-1?Q?CEpm7B5RLax1KJiiKnEgjqvd7XeSEM2hpyh10Fo6xaFLTrxJ7tErKewNeR?=
 =?iso-8859-1?Q?Hi/vhNI/i9HTPvgOQ49hluzpuAW0HILDdJfKko7Pv/QfEdz/Gl9wVHg3j3?=
 =?iso-8859-1?Q?/856TMlnq2gOBnjWHU8qBa0N1b/7wsDHXxl2bOxLGEziWGfBVzzK1vF2lm?=
 =?iso-8859-1?Q?Mdx0ywjBNk1jtQW9enciIdoubP4n9cbzmloi7HK4q/djxvxw3cHu0b6bvm?=
 =?iso-8859-1?Q?5aVar0BvIrYSXpU7p9opXdip4yDQx6+AQe6AzEQwj1LU9Exb4ffDhSlVrC?=
 =?iso-8859-1?Q?OdIKTn5urTWmFA07cK+jXc4gimhVg+wIpHRMLadCCSuRGPk2vryGLT+9xf?=
 =?iso-8859-1?Q?YD/NAmpeKcNmIVOAY17Av3JnmtKo6j1Hn9/opRGJRASG3LPUobD28IwZdh?=
 =?iso-8859-1?Q?tKBWSquvI/phzBuyNC2i5imIAIbbiyeolVRKkS/CmDXOsvKoXQPrmudLDk?=
 =?iso-8859-1?Q?+0mVrPIMJxYNgiKbKPmTXn58umzeh/bCgpwG8/P4uX9+/6GY85p8d10E/A?=
 =?iso-8859-1?Q?ZFr43/x5tBapO1jL/1dRsDEod8MxptgI5wF9acPApRAg6QXuxKLyqrmY23?=
 =?iso-8859-1?Q?ZwlT2T3MD6a8Tw89XoGFCnb/Nfh7br66cuaDhqxEldCeoTABjk1vEe5qdr?=
 =?iso-8859-1?Q?Z4zZsgQtT2A7qeWCe2NI/NoWKCz9Tc/G6Y5ntB426NYtw1HNkMVD2BykCf?=
 =?iso-8859-1?Q?scZJzo6wqhjM7SxuWJKr3tBDSGITP+VMZhCDeOZ8lJgKDcNb46nvqI4Nis?=
 =?iso-8859-1?Q?nn1JItJ/D3Day6Y3/BPMWxg55XwVl6FA6afx8ZsnQZ77TnUbcXUUOu1qut?=
 =?iso-8859-1?Q?XVjJq65sO+JPZhIEd3+hFS/qCdCnAmlLip2XF8rjW+o8ZNaCfDlc9ahw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <29C639BD3ABC584FBFE69B571D8E190D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1d0e38-a59a-4774-9097-08d9d50ccafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 14:15:17.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjuqWedX0hY6Wn/LVXVsOcdnYpN/MwFguEkIFpXSWtbX1wtm3882/JHXhJl2d1WWeKS/B1l8RNNV48OckBAcGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,=0A=
Thanks for the review.=0A=
=0A=
On 1/11/22 10:03 PM, Greg KH wrote:=0A=
> =0A=
> =0A=
> On Tue, Jan 11, 2022 at 09:36:43PM +0800, Wayne Chang wrote:=0A=
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
>> Signed-off-by: Wayne Chang <waynec@nvidia.com>=0A=
>> ---=0A=
>>   drivers/usb/typec/ucsi/ucsi_ccg.c | 2 +-=0A=
>>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> What commit id does this fix?=0A=
The change is to fix the defect of ucsi_ccg_init func based on the CCGx =0A=
spec.=0A=
The original implementation's commit Id is i247c554a14aa1.=0A=
=0A=
> thanks,=0A=
> =0A=
> greg k-h=0A=
> =0A=
=0A=
thanks,=0A=
Wayne.=0A=
