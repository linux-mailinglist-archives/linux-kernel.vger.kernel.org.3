Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DA9473B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 04:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbhLNDJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 22:09:38 -0500
Received: from mail-eus2azlp17010003.outbound.protection.outlook.com ([40.93.12.3]:15346
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234476AbhLNDJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 22:09:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXaFdzaWxagShWAdM6UWLsFegH7zcTq3JzSnRikt8apEriRFZKAw0KWWKKx+Qsg2nuy0YYC2ei4mptfdM2d7j3BhubGPRZVlnttlYkBa4g2gBevGqtD9qa/te3K1a0UM8eZxmf86MGDDHd8Rcd+RilnZGVUOXMi8cL9hJTOq2/JF9+GUAdIF/83nhezUUjZ81nILTBPSSJhT4Twq1/SAu3MuwgogkY94JH3H90l5FuOua9E/Lvs06Wn5BPedWU9bOvLdr551PmUzUDryXJoLMs9hQlehM5/Qq80Qjb3UTTWFz7FUxf+SBMJxB8VfTXYhwg6O4AsTF2ifJxndrPMsCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHiRhH9OTXPDFwdfv1SHYVEU3Qm/vvGVJC6qZiUOwYE=;
 b=AUWCPhXpaf9hO57vx+dWQsZc2DJOOfSYRTin0i72eJOLv6EXcWdHmJNH4X3ZqrjA5e4nWo+do5JFLDb59O75LPlQbWGKA6YR+8/6LPKuJEnOkaNEOrCbO0vCQEUv1e97xktbtPA8X6/jf177LElWGppF2w/+4qhbR4eZdtH3F+nsUtp3GImxrRdTYOsdR5l/YUEOQ8ldFduPK0j+ZX4wiiFHqzTK5xyLqda3WLLjrgZnTtE3ki4UdFMKkQ723vk8ovd1Y/KeQ59sZjB5/pzlb9mNBPeZ08COCAFQA0p5+3QyupMAeSiaIsIev8soVOuXzsJtrvaotIuCdYZHRASCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHiRhH9OTXPDFwdfv1SHYVEU3Qm/vvGVJC6qZiUOwYE=;
 b=BB1Amq1INfIWr5zhfJ9g0hTow3HxEoupHAzBK31D0OsOfHrjwi35tvvZlFdl8QKHvBrnAMIsyWMybNZi9PNjl/iQHjFXtEgWJaKRwQDpPRB8X1EKUJGj4/PNF61L82dYIYvzNGio2Gq7QNI4MtSHc33w7i26WK7rB8Kugcx82JI=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.6; Tue, 14 Dec
 2021 03:09:32 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Tue, 14 Dec 2021
 03:09:32 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>, 'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>,
        Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: RE: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuwA0I/TAAAIttYAAAhJ/YABlPzcAAAFj94AAB4PEgAAi6P2wAAE/dgAABJYKEA==
Date:   Tue, 14 Dec 2021 03:09:32 +0000
Message-ID: <BYAPR21MB1270D09A8CF5F21CAA33108FBF759@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
 <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Yba8nL4x9R6rmTYL@T590>
 <BYAPR21MB127006555030F7BFA47FDAABBF749@BYAPR21MB1270.namprd21.prod.outlook.com>
 <Ybb4X00rfsjRgHj7@T590>
 <BYAPR21MB12706DCD5ED9FC7AB3EE2EEABF759@BYAPR21MB1270.namprd21.prod.outlook.com>
 <YbfrBpcV4hasdqQB@T590>
In-Reply-To: <YbfrBpcV4hasdqQB@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9607a5bc-aab3-45dc-b941-912b06617ad0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-14T03:04:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccb1ef23-4d5c-43f6-f536-08d9beaf2699
x-ms-traffictypediagnostic: BY3PR21MB3033:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BY3PR21MB30334C56F8E8DCB3F6D385B6BF759@BY3PR21MB3033.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ye5K0JNRcx2ORTotGeql6lenzZ6UZw3BUipzGN34zohkwh4gQFXbfZu9Bv7GIynYhV1nD9zVp7YWRcp/9fo7ykJqrLKprxe3OkbCJnj9nfy8CyiTfiKtlluLa9pkzeRi6ItvsRJuj4iX3DzWMYwKF8C6i9vEkXxUj1Dp8BTYtnthO1l8ACaBvvfk4Ot0x7UaWFa2FjfK2lYmqSUJd2yTJlW4SqmyF3vUhMM9GbZJzoyhfKZpqQbX6+09vzdye7CykLPSyx/G0HzDggPfwSfYOUY5tH6vZmJU047XXJuoWOoYvFjSVJBhZfS/2rwTdmZwm3ar9q1fsxDmlmvd1fKOKVxsHg5glwfdCzMWylGdq1FclXBto9k2sYCqgLDTWqzmng1iVHxGyL2EZGiSyP9Z+wSjexvDca+at73/8rfr5IKDX5GvjT2P+G0orrap2qVOuh3mjud5mXoFjQDEOI/fPmaZ9HrY/TOEOB2jfF/yzZqII4wrpHJd4KwYbXO5XiFUQiD0xjGhoYfTZR8d+RTDrF0fllFvdjqXm0hVNVEYdptIWcDnjdXF/Qbpwgo+xXcnCQHhbm+YCp414427iv24dYbxlyWt5erSBUOc0cmNS9Zt6U09XtuedxM69vs5UXnM7pvkS46O0F+xR6GwAC+vtagKYiLfvfd0MNQ+GfkPTLyfTw7etwry1bS8ZYWPc0oqdXYkONgQ+j2s1RFCaqkDU6sstfMRg01qKbiY5ussH1mNqq6lVIiUkC6X5+lRqDAf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(508600001)(10290500003)(71200400001)(4326008)(54906003)(66556008)(66476007)(66446008)(316002)(6506007)(64756008)(9686003)(6916009)(86362001)(8676002)(8936002)(76116006)(66946007)(38100700002)(122000001)(82950400001)(82960400001)(186003)(83380400001)(38070700005)(26005)(5660300002)(2906002)(8990500004)(52536014)(4744005)(33656002)(55016003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lSMi3N5XejgS/G3dwcwJfSdRZQB2myICUe25f2Xk49Q4ZKjUnRde7vbj5nkV?=
 =?us-ascii?Q?sUe5Dp0mI08q4BBxFldpo45/GJqwyc5W0LYMwhrI9bIMy71MGvu6JDtxc75T?=
 =?us-ascii?Q?lGSJaFDfZQMtqhqVNc/Fy7xQ1FRsRbICFMviTwyUpvyet7WM65gTsriINGit?=
 =?us-ascii?Q?Vc5/QOl3eag3UjXeivL28MCaPg/JQz8E5RYAwraRpstb6XhzV00mP7B54s30?=
 =?us-ascii?Q?/p/h6LZgd9hqt1HJtkfAAttsVwkAliEjLGVgu7+N43ZvpVE0/gwhj0Pgx/F/?=
 =?us-ascii?Q?a7SylccX4AZ5wzwTR2zjHiXn1GQ8+CmKLExLr8Pe29B2n6Vimq5mDbJJOGHV?=
 =?us-ascii?Q?WIrMarn4xTzyCASiuUxJmyfv0zSsUvZ0kXoLq6pGR40o/pVUzYRHr0Xe5w+O?=
 =?us-ascii?Q?H8ttRY7aTRTfomCwW0KSRT104bJvFcmpjIGbaqoIBoSmSgT/XstsFsQIqUwv?=
 =?us-ascii?Q?lEoakd3+ImFhBz6fAj724OlsTRV2P2+UqSjQAyyvHcPZR3q0K8MXPMpWsKKo?=
 =?us-ascii?Q?q2e0+Hji5ecYGhwYEL2/olm9wkkk1dCwOIy77SJYLP/o/Wi615gIpXAz3iC8?=
 =?us-ascii?Q?8DKPEOhFlk2I76nuaveCL3/YJSoU6R5vDDZUHSzbgPXVWd71M9OGKMoZ4b6Q?=
 =?us-ascii?Q?3W0Fz0wvNnWLVf+/KwnBi9DHe7u8owiHq67g1FSPKjqj4sAQqa97LmOCPmCj?=
 =?us-ascii?Q?j1u307M5jzUB1l1YSbVkgi8Eh+fFvW44zk0Mo5i0K+IeWEqFd5axQRWMKSub?=
 =?us-ascii?Q?seONHKRt5YJcGGvuliNSuc1tFqE/w0t0tknVlmDuswOmaojG6vFUOTeihxcc?=
 =?us-ascii?Q?gZEm+8T9jp9+6huBXMekbj8JijGRN0CvLpEYNHvvzAkJTuC4sETgfDUzEJAX?=
 =?us-ascii?Q?2kp2QaF1IP2G2QexpXC9oh1hMAKIT+3I3wHgQmfOacEGip4tnrSxee9WIEKs?=
 =?us-ascii?Q?Ilj+kwOWa49VQfwayAu0kTrKDMJ0apQXjsNk7WV1uhtAVOUbGcE2BpdVZlEd?=
 =?us-ascii?Q?F9YoDx1NuwSoX027vuAPc1perRA21m7wAMzxQBPx5//PBtm9mv4JKU9WzfHg?=
 =?us-ascii?Q?5aWANO8N17ga9Ox8WD1IYO1hG5g42qkI/RVRfx9SUHOo03i6fmaFc1KMMbkV?=
 =?us-ascii?Q?4WbPM2LEb7hBLbkJUnPRZzOZoTPddXyoWxX66ZQXA+Goe3qZnHyXLx+B172K?=
 =?us-ascii?Q?+lEdOvh98pZG2hq0JPBKw/9MqCZp8A8NUZtgT8ebZfz7xoObPeAOOkt0tjN0?=
 =?us-ascii?Q?azK5BawA9QnOKU/QjQlctm9n8Ypz0CzUJmszxAaY3w2uHMO5WXmXF7h09GhO?=
 =?us-ascii?Q?Fmc99KZfc8jUeNKQU18ZC7Ai9k/s1KzmPFkTVscpPHWRLcpvQsLlE16IC3bP?=
 =?us-ascii?Q?p3gZCbqbNVl2RuYfUOEYWtex14E748g/Js047OO3kCce4N5pMGjbqQjFSbEH?=
 =?us-ascii?Q?1XKYlsur5/ahi614mHxaW8j7uSZBS9i4j6N9TrtZFpfmMKIUOUsR9NuK/cGi?=
 =?us-ascii?Q?S6mdMu+7RYTB+Wpq6uzxyVkCR7YH2YzpProTr0vQHZ2vaIaX9QaN7ZtcEUcz?=
 =?us-ascii?Q?UVWWFCniOmqch6hQY1N14uLubNUgGG0U7iFUvOu8BbyCIC/lYmtjBlt/ae68?=
 =?us-ascii?Q?Ov6EOm9thIu6Xjv6WZL6Dow=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb1ef23-4d5c-43f6-f536-08d9beaf2699
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 03:09:32.4764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ZY+2M1CG1GEGX37lbZF7pk0opnGsAvGjbBSeL00ORaK1TQy4pdzOSffboqreuhGYeopu0d5orwJ2JbKRepd9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR21MB3033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Ming Lei <ming.lei@redhat.com>
> Sent: Monday, December 13, 2021 4:53 PM
>  ...
> The single hw queue may be the root cause of your issue, and there
> is only single run_work, which can be touched by all CPUs(~200) almost, s=
o
> cache
> ping-pong could be very serious.
>=20
> Jens patch may improve it more or less, please test it.
>=20
> Thanks,
> Ming

I replied to Jens's email with the test result before your email. :-)

Jen's patch does help in the absence of dc5fc361d891=20
("block: attempt direct issue of plug list").

BTW, the throughput in the case of dm_mod.dm_mq_queue_depth=3D256
is slightly better than the case of dm_mod.dm_mq_queue_depth=3D2048 with
Jen's patch or dc5fc361d891.
