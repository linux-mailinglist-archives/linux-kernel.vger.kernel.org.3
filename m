Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28C74A72DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344842AbiBBOTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:19:04 -0500
Received: from mail-ma1ind01olkn0142.outbound.protection.outlook.com ([104.47.100.142]:32310
        "EHLO IND01-MA1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230171AbiBBOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:19:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaOvzixmz00463s5vULn5eAwAi+K6rtQU+Yu6kDhXwAPO38UPJOja3wYOZQ62fE+5meFy4NUFYinlnCtPOHT8gpiC3wGhgglGl+gqX7KbAZuDhR+RwZopls6OfRQzXlWkepD1JNbLs9BfOQesH33SHtmL+D7KLY5T4qxsz1PljUVKBSgGSSjuBm5sO5COcrfEtKyDmqPvUkesbYKyxxRWmVenwF192GERAX/fug5V4duQ9EHJtkkJg0Llv3XSB08Ar2WtExzCmg1jFHrwOhg+BErTDZVLO9tlANdXvcWhf1TG+fpiR3un+zZ3G0p3kyYfR9dM2/nJAeafYtLrxxF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKcRlRGnjUxasz+Vniie9H8iGmkK4UqmYKp/BadT99A=;
 b=ahnz1a3opzPqFM9dJYKMdSC18khV2e6wmRX8xlDoKPPdhYi3LQf8LbjZo4py30Ru7yPVattDybWlTZtBgMgzpIZo3jSbClOD02wV/7PiG7MDvnhAboV71kE2DohadUnozfLDqONEPtUUdrofl2xdZIgf4S+o5ZvllL45lmTnlqfr9bWnO+mGQRaEB3fmWG6NnswJvraiA8kqj5Dcs2EYrhLbxw1pfGe8WAc6+X5JpGezeg6IoWfdwzbLG+6XMngKiTiFYGYXvKuNqEWbNANHFRVRY0HiEPnZ8AfFkHCNZU+N5R0O/uaN8Tz7Uo0dsMIVl0hS1NsOf1Df05Ck2VpgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKcRlRGnjUxasz+Vniie9H8iGmkK4UqmYKp/BadT99A=;
 b=nda8Z2czOu2MmT8I6vfXiok2al+i1HpZQfWcMUZd2OzpUQCqY7IOAmg6Les2XJExLqb+7WnaQuPot+A30xU6sRqUaf/nUwaiRcNSbgC1D+aMXlSvhfGMB/GTa7lUmRFoTNQq8O3RRJ7SnBzHrjOaKghDml3TR21o9UQaxkoZ4iO9zktYEGowxvQz4fkt1XDoeS8+Gzn7K3e1kM/KHqzUigd8+fyIokl9DiP5AKWFw+DnjhVin0DB1hXqr2uUEFYc++K5ejvgRwjgfV9Lk/1IThI+ZNX+YW/qOrGc8QCGilEHavn6yWsUvrU+NdHTOsTjcNdo7iSJl8kWPgo72GUk7Q==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by BM1PR01MB3489.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:6b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Wed, 2 Feb
 2022 14:18:58 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d19b:7cd1:3760:b055%9]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:18:58 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     "alexhenrie24@gmail.com" <alexhenrie24@gmail.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul@mrarm.io" <paul@mrarm.io>, Aun-Ali Zaidi <admin@kodeit.net>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Topic: [PATCH v2 1/3] HID: apple: Add support for keyboard backlight on
 certain T2 Macs.
Thread-Index: AQHYETQ7eA8f8fgzvkGVPkQueNltWax9E1WAgAM/AQCAAArkAA==
Date:   Wed, 2 Feb 2022 14:18:58 +0000
Message-ID: <DBCC31F7-C8EF-4248-B439-DE6501925CD0@live.com>
References: <67E7EA8B-CF21-4794-B7B4-96873EE70EF6@live.com>
 <9B28205B-24B2-449F-A6B9-BE87C1B9A39E@live.com>
 <nycvar.YFH.7.76.2202021439120.11721@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2202021439120.11721@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [raO2/9PD2TvuwAxIueOQA7EpPdB6I5m0fZ3tb8EWcSCDbascgr2aqd2mUkAMBLTh]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b8ebfe2-624e-487e-6019-08d9e656f415
x-ms-traffictypediagnostic: BM1PR01MB3489:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+zW14DdOGkCZOP/hRp3dx17OdsSfqPZ/S/wUR/a5fOFmEFhte1LirMptczWT+APh9ErEi5ZMuT8Dj4GtTcNJfQWzqduV+Kryrma20Se+uEgUEaL6W0bpR2LKJBa4nfq3rp+tT1kXDwWa4CWSMjOgdDRNN++hjLLHBQMeAZYqAel2ivu36zZ5JqFnERXUORwWn/RR8H74a5Pjq5akzjf9/3vWO+uI/eWmhqnJJ8u965KW5nZGHvpTDpEaQMih31HV3p/O0bolfkT3mWB4M+i7SFB++dJdagj4HhAjwOgZkHCQrJledMVP0A9wwGCYR095+LWYvNf/qlyTwb6g04NoxQ5O9X+oDhq249aW8f9sg60U6EJrfSfmxHp0cGA6XMjhfKwFgC1hfCwWc41YSPT4Ik0OVz7wd4nwHmxbB7M2xfUv82T7F3qjWFdp5U60Rh2tlw48LlBavBBjEa9hhD1z0S+VGZ/R1awpsCr+nFjj8FQdVEl+0+raLecR+gXuxJJ9DEfg0QZn6oYfnb4UiqP7FIllkRGck9kVAKLQ3qIi28lUKwb5tc1o5fX0A041sjIpVt6iDWAlcpQfuej9F5z+g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dwjHg97pvSQiEx6LNcUBCqXXDp3+56CK899aP4GaJ18y+jZXE4SkL5po9uWJ?=
 =?us-ascii?Q?8KJN+sWeQyArwjcQLE8h2CzxSl0FeEUbxUfOkJOBBEJQBnPYv1QIaRbJVIpA?=
 =?us-ascii?Q?DoImKp/iVxkdY3J1iXhnwPd/ZW64ooLKgHaxmzuZJ+FkoHftThvNLaUWrOU2?=
 =?us-ascii?Q?iKZTT+2SYnxcRsyjk6fsBcBB34Aoh2WX6r1SlBdEP8kcdDi8qpW0hWxa2w+F?=
 =?us-ascii?Q?tuH8mlrTXwZiAMU22naBidC/yQqs6j9UGDDP5G+u3Tu7SQkypXicebPdF0P3?=
 =?us-ascii?Q?D6+8sbQ9hzi8vOU8e/ILL+dY0UORNe3DAti4n6xTXh0B5iWMq/paqKxuDuH+?=
 =?us-ascii?Q?Io6GjXfDpaNlPETm1Hq08bqVAyRloL7IMTvRKMIkmtl2OZYn7jB8f86z9Ju2?=
 =?us-ascii?Q?4zFRZ0njQwOZst5YiYk8WV21YvEohWDK8wGpNc2wHN2/R8fP95Il62d4c8Uz?=
 =?us-ascii?Q?f7RjAADHcgn/ZPBFr3V9zHbanvn5j2DS82f3Xv0c19ZZDiBZxdeS53wuNAC+?=
 =?us-ascii?Q?8W6yQRF+FQynw4XfGTxaFFQ78vZej5Az2+KHMyl3mTvPYOZjPxnLLHN4Ab6J?=
 =?us-ascii?Q?ZN8fynn00qVniekCabgXdsLGSiSUgFScJ+aDsDtIgmyiDfX781q3MDK2jHfb?=
 =?us-ascii?Q?Fc4Tsca3YoodPbQISWbBWtV8yS9BuVza4yTEd+NOyUHt/kie38VzxSw4Vk7f?=
 =?us-ascii?Q?PfxkUi7CcVaeFbra7OP97xsGT/mNtMicFFXbP6kpz/y30qzSdREHdFVDPRnT?=
 =?us-ascii?Q?K+UbZ5GF9N4KfaiWP7BtIMbkSLzfduVNojVFCgzPcw9JeCG4ONV+q7owiP2o?=
 =?us-ascii?Q?2Gde7wRX1cw6w6Jj/7RAOyS3JZOy11SWHd4VkrmEqPtMhC+Ta1+wYYrsav3a?=
 =?us-ascii?Q?uDivWaPJVvnQnxt2PoxE/5u+w4YOzYzj18GiwFxcrQR2TQ6d2xUfhF0WQ+Le?=
 =?us-ascii?Q?jkE2wNHhSdhYkB35yEe4pXQeJA7DbcynKxiGbuAKOEtmJ8kQcQGysZ0t7onb?=
 =?us-ascii?Q?x1Zi4NZiNIfivkgHUDvCfW2wFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41D76251A2C25E498B04E406510522D5@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8ebfe2-624e-487e-6019-08d9e656f415
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2022 14:18:58.5784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BM1PR01MB3489
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 02-Feb-2022, at 7:10 PM, Jiri Kosina <jikos@kernel.org> wrote:
>=20
> On Mon, 31 Jan 2022, Aditya Garg wrote:
>=20
>> It has been a week since I have sent this series of patches, but I=20
>> haven't got a reply yet. Before that, I had sent a v1 of the same, on=20
>> which I wasn't contacted as well. May I have an update on this series.=20
>> No reply for a long time is something which doesn't sound good.
>=20
> A week during merge window and -rc1 phase is not that horrible, please be=
=20
> a little bit more patient.
>=20
Sorry for being impatient :)
> The patchset hasn't been lost, it's on my radar and I'll process it this=
=20
> week still.
Thanks
>=20
> Thanks,
>=20
> --=20
> Jiri Kosina
> SUSE Labs
>=20

