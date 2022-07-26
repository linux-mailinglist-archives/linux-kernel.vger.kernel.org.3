Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91015816D6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiGZPzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiGZPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:55:27 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11010005.outbound.protection.outlook.com [52.101.51.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B11E48
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 08:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwhpu7LjNcQx2Eyo1JR3J+pLz4bmZFWDE34bVFFIzxh8dIU/p83AbK1o39eWQhazNYNEHj7bWBQWlvZcD+TbaY+YNixd95jA0Y0GPavdn3sZPHheLCgE0zrQwrJFf5UBbF4dcuachwEwslBV8d0ZInDp/Da+yassecs5k68iohmGXQ1sF16RjKtNI5yPqpuCnEcKTUIwPg6XBZ9lP37gQAmp4Kfk+d6RhMpggxH6GOYSZgg3zSQvibf6wQV7s85V8jdt1McknGpM8x8uRTQREUtPn+uyQEDdhGyR01nHt0i22GLn62m6APLzJw7t6aj2wJPggWV3FPWgX62+F17N7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hlHdu+27Y/uE+0HgINvY+WqNo9RYB26syfKoMtWOSs=;
 b=dthoMu2NiYsPGbfDEQQ4/p+EZ4cC3+sXfMcAAWQ2nodyxTjC57BxOJsxDX0Urde5rHJkD3zcfI6L72BLvD7jGX5trDMmifXYGc8LDW4ncAZyN9FHFVZFTfdO22MQpqtZrf1fS+NQ0VHvtdkHpm30QEUU27clYhzuNqDaVW6jFVYUOgjZvZN7nAmc+58EDkB8OEKvwWF32qNIQoxsju35ZCj1hG5pCIxloCdw7GqnGTU1/d1NAi2ky/+q4hD5EurHyvcz+QvYFMmfNXCZj8eq5nrS2L92AbZxhKJl6HSC276d8zrwlFnMlEJ0okvyPku8JpvhS+jNZBzZu9VvmYPU3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hlHdu+27Y/uE+0HgINvY+WqNo9RYB26syfKoMtWOSs=;
 b=amE2crZ9l+RY1l9QgagM+08eqPQ8tv7cVTbuVJvZDKRDKds6GQ4tEZrhI9DuiHGcZbGWhL4kuLGx9MiEACsqmMVZ96mc+gt3pEiWFkVThznH5vc0luGa+/N8einldBXEnai/WT977wLqD/C0FFhLgHjVG+CYp6pL8ly1G37fGY0=
Received: from BYAPR05MB3960.namprd05.prod.outlook.com (2603:10b6:a02:88::12)
 by CO2PR05MB2520.namprd05.prod.outlook.com (2603:10b6:102:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1; Tue, 26 Jul
 2022 15:55:21 +0000
Received: from BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a]) by BYAPR05MB3960.namprd05.prod.outlook.com
 ([fe80::959e:de9c:2ea:213a%5]) with mapi id 15.20.5438.010; Tue, 26 Jul 2022
 15:55:21 +0000
From:   Vishnu Dasa <vdasa@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "rajeshjalisatgi@gmail.com" <rajeshjalisatgi@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Bryan Tan <bryantan@vmware.com>
Subject: Re: [PATCH] VMCI: Update maintainers for VMCI
Thread-Topic: [PATCH] VMCI: Update maintainers for VMCI
Thread-Index: AQHYoEQyk/xBLr4HNE2eyPGwuSIgoq2PYdCAgAAGloCAAVrWgIAADHIA
Date:   Tue, 26 Jul 2022 15:55:21 +0000
Message-ID: <47D07B41-C327-4908-A383-683FC6C67040@vmware.com>
References: <20220725163246.38486-1-vdasa@vmware.com>
 <Yt7bfyANrfdPxdS8@kroah.com>
 <FD326388-D2BB-42B4-B217-89DB9C134866@vmware.com>
 <YuAD90UfLnf1Ojso@kroah.com>
In-Reply-To: <YuAD90UfLnf1Ojso@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9f49cc1-5e05-49d4-7689-08da6f1f3ebc
x-ms-traffictypediagnostic: CO2PR05MB2520:EE_
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gksv0vXyekNaSmZckpzhtU08LwESN1ilTt40dD1y4eOcpskU2UHL2Arr/FBY8TDGIDbaLPGFcPDkLp6dhEYJ4kuU179HTpWx8AcvG+fbrHb2taTz9R1hVJx9wLyrqGALl/AmndmnBoJdNYqCtydaB3DFykGtVlGN1c7cSg1KGppcpsUEVtv6ROLQUd856MwiYdLbI2Vc3G+lKzhrxywH93qn/6sA6ty4cB+FwfAJvqHXP1NVAUSMwQiWlwspPt25iWm7v7eH5CaTyEvryVmqWbbBzBo+RrPjjLUfayvIxK2OUvOSwyCa/VwhgMLfWmdXrIkZjRgkq18OQVII2B2FppSsMBG3dPAzzmvFRkclzW9YD/H5znQf0c2mI0YzYbs3TKBOP3l+J2UbwKgG/neQ/qWuIjpWAczLGjUrXnoyUm4nIDiefGMUQquWQ0qrYNfSsJbFfLYSMOZTO7h7vy3Ji/XSIfNbRHCzIPqnDMA5RYtzafmechpYW/h1MXTH+/d3a4zyzSTlWG6tnMeJAh5rOsALdnJ/HSDEcxQB33qHFAzbjS5wIM0bTgLW3AqgE1J1VGwkkpNLmlXni3myqOI1ITAzSGVvQX/fmSeLA+yGZAeVLqTv/AZYg0091uSwMG40FN+edvMvdz0oBr717jNYNXi1eOMceQOfsWDv5vHrZsy3deLiZet9Qkn1j3dq2Dj+QLaFcHLW1IquxLdGZXwtwhLCXhz0bdDh5hG5h47OsYCWDQ0+J+uPM7oGZWAaANeJ8EbgL6AOFBIRi9K+1bFLTh9O1QZjEzBwhenDcJLE6jNTVGxb4gNe8nemWobvYzeIHSQkbHRMA1ldds8gpB86JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB3960.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(2616005)(186003)(76116006)(66556008)(64756008)(54906003)(2906002)(66476007)(107886003)(66446008)(71200400001)(110136005)(4326008)(8676002)(66946007)(53546011)(41300700001)(6506007)(33656002)(38070700005)(38100700002)(86362001)(5660300002)(122000001)(316002)(36756003)(8936002)(478600001)(6486002)(6512007)(4744005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sEjfml+VpvidrJWp64QhVbDnbcIwX2RYk62R4CHEbtV16cXT9+XihhuYCqsN?=
 =?us-ascii?Q?p0STJApSMpE65+HkSTSCp3O0eK9JeP+tsmlrXPl5ahrx2cfO2KkTan0Hn/xu?=
 =?us-ascii?Q?rIblBQMZwBxkFqcgbb/W7dRMMP1m2omPOEOLdPUmwlbt0wh04zTVBaqOftQP?=
 =?us-ascii?Q?nKHrN9x1TPo627X23AzDNLGmE2zgVn9k4RFsTYMC1HSdr73Rla7kXq9wyAtY?=
 =?us-ascii?Q?4tp5w1uGPlvujqVHR+zIiESYUTf8P4PamPHiUn82/A/XsAg3exK+B1vc8UY9?=
 =?us-ascii?Q?f/iHZf0Bxz01bpKSNNTHKHkqWdh6ITVlSG118cYjTIOwrN4pSPYc15e3849W?=
 =?us-ascii?Q?TDe44qxZT8Zhb4l6PuSo5hvD4v48MUKT09jK+GH6pvQv8IkGmZF3z0fO7qD6?=
 =?us-ascii?Q?JNto8K8zRW7fbHx+KYKcS0B6avxurQxycvSWzjRKhPgZ0laZEsGRaLGnUQvS?=
 =?us-ascii?Q?FYCoBOVij8IYbFcM7MSCJrrZu635LZmDvj01oXDVv1xFZGTYthqHlLNuPr6b?=
 =?us-ascii?Q?CIxXZ03MXcIdVWWDzvlphbjjC1tHVimH+T4zIO6hg21Iwtwm2cQjRd6zsA+i?=
 =?us-ascii?Q?ZVbPd5aKgTl811psZnP9pac/sd96wE/8YFUY3RJRdCni1P4j9eGFJWLA66tm?=
 =?us-ascii?Q?NQi5gPDJKCSoud9MbDBbAm3YTPCEGwaESVY2Hj17EY5KDEhg27QcqZS5eUKt?=
 =?us-ascii?Q?dCKOk2Lk/H5xs+JsEQedI+iAA4hP1ITq2fNjfZFBZKtg2YUwLx7nvIB43Bob?=
 =?us-ascii?Q?djWpURNwkvCWr89uJgZQpnQOwV59pd2eIVJNPJ0pSImQqBFrWscOK6keMg0H?=
 =?us-ascii?Q?Rn74scIq9gdeCm1ApEPZZyOeZTT6A4DJsgZY3N4/j4M9PTHLgZEtwa0S2cuv?=
 =?us-ascii?Q?keOVgJPtPuBevZTy9ywVvR1Tzy5Lp98fKrPJMWZ7ZW3NU27fGVNdzDhYQ/P+?=
 =?us-ascii?Q?eOlx49X+M5hbBZVdhYkF514i/VzASoHlSKIdqxE7A1eErPw7Zd1ExsCgS/ix?=
 =?us-ascii?Q?WPtwaEK5VgvT5mmLiRkrivtJ/0sYc3qMlhl0kueADjsJbEEBTBA3BohVuzw3?=
 =?us-ascii?Q?5gys9T0jLOARNx+UZCbyF71cZHOJJcEnt3uybjqU7+M+6T7mkjO48kUv+LQU?=
 =?us-ascii?Q?VvJyeoT0dhPTl1o+m8Y8bhbm9d4OU6Prvypc7BBIxvGeqmn6xnZizNZn5dmg?=
 =?us-ascii?Q?TI3hRza08f3/iSM3gfPxEM3jNxXIqydEd4rUBg+I4BbGW160tm10qIi4QDzk?=
 =?us-ascii?Q?kJLa3nOLk9HQyuFxzpSszJjRJcaKQxOxDHgLFozNT6Q7qV4q0xxzdSppOIUY?=
 =?us-ascii?Q?ELzzIMLxnm72A4+WtzEt+za0CYnmYeFBPRIJWDswRGFIr5Uu56sUmigtfTOy?=
 =?us-ascii?Q?+O5UyEwhfW6ZpZQ7ykYCN6FTTPNRAf063gkAIIWR0pikUcVXK3RjjuOYTLBs?=
 =?us-ascii?Q?AlmXyGYYZvk63zpRbNuiDQYP+kks1I+zPwLs5LoWM117AhaKTMcXOujznV9R?=
 =?us-ascii?Q?ZUdFuM3fqVLEqOEB4m5YUE6VoIOBwaa6/pYFGfge/VLmxi48VMvE4LuPAV6t?=
 =?us-ascii?Q?FT5v6Z/gPVbKXXbJbyPReB/5d9gp0ymgSa1tFeo89ardeizLcCunhrt7Bino?=
 =?us-ascii?Q?dDfOmYX/4ZfvtuAdoZ3k6YnmCrkY5TwnK5IScsH4gikP?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54B8EE16F1894442A7AB420AEB8B14C3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB3960.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f49cc1-5e05-49d4-7689-08da6f1f3ebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 15:55:21.3241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ulkAQZrRUu8QlFEZrZTLcMWQ30q8DVYJl77YkBGAZlZcJxSNKX1vjKEkbSVX51E8PhZe+Sg2xmjxHlQjE4sFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR05MB2520
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 26, 2022, at 8:10 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
> On Mon, Jul 25, 2022 at 06:29:25PM +0000, Vishnu Dasa wrote:
>>=20
>>> On Jul 25, 2022, at 11:05 AM, Greg KH <gregkh@linuxfoundation.org> wrot=
e:
>>>=20
>>> On Mon, Jul 25, 2022 at 09:32:46AM -0700, vdasa@vmware.com wrote:
>>>> From: Vishnu Dasa <vdasa@vmware.com>
>>>>=20
>>>> Remove Rajesh as a maintainer for the VMCI driver.
>>>=20
>>> Why?
>>=20
>> Rajesh is no longer with VMware and won't be working on VMCI.
>=20
> But employment does not matter for maintainership and has nothing to do
> with it.  Maintainership follows the person, not the company, you all
> know this.
>=20
> So for obvious reasons, I can't take this type of change without Rajesh
> acking it.

I understand.  After getting in touch with Rajesh, cc'ing him via his perso=
nal
email ID.

Rajesh, could you please provide your ack if you agree with this patch to
remove you as the maintainer for VMCI?

Thanks,
Vishnu=
