Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF274F4B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575026AbiDEXCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiDEKax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 06:30:53 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4929DE081;
        Tue,  5 Apr 2022 03:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmXZT2bSV++Y2zowvZAw8jwa4T81YrETuxRZ3PqRpWCVkYL9e9OgADEBcd5lCnQA37lRI1nOXPh6KijmOCC1fNQsHRDfS7LUEA0DhZlGFtAlnSjsqUNF3XwNqDOjgVTK3gTaOJCFlbZvbFO4DgXHN6X4Bvvj6MQACeAYnLv6nfwl3JgKtXo+L5dDgMUCkLgmsCRRRzfzlwWsdjzW432DR/tdIEftjZH8PcpTH2mE/Xmeowty2K2M653FDc+OBxQmfvyiw5H6V+ORKP1CLWFBB8d6ix4LOX7bO3ajfrzNxGiZndVLADEYrpbbTuJny1nW5mxsWdXPw8bpACGGxzsiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFhiSGPq8moWofolkbCfEtbAGbS28yqYceNhcocEZJk=;
 b=Eesgj1yM/MEAaew3VgBziTnANeUK3sz9BKVCnyFfhWbEQ8kmjJexNIxhEcBmZHxiryi+gERbbpu+7x9ydA2Do2slCCoUPh11FUop5i7C0Lv5lzjvHy6Z6ud0JWdfAn2iUOUF5GTnxH5FqKwUTcyHVYLJNAVQVVVfyhwwsi2nEDGDmD3HqihVuv5piK0tsyy0XlaRp+bELkEYSfWkHxt/16ZvAfdAIXy3W59iNh48/hLfSz8XDMZTQ5zyz1B+yYiwSqkUEVRUPBbKO6UxiIEjGbYClLDBpRhgpBCalacMbbJYygYq4Z+ZZSMuFtLayj99XBYahLpmI4PczkPgXiT3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFhiSGPq8moWofolkbCfEtbAGbS28yqYceNhcocEZJk=;
 b=D7chy1ZQVrYQwDjtC87LO08i61EOkz9XzM/rSBeNRfwJpjyGBCdXGHsjDaCAP/J4VQ6rAgSllXRiJJbM+9o5NYT1VMOlFxRl1aHQaqhmYwoX662/Vk2e5HoVXOiwj72NZvN4Cd/o/Y2WXD4dHJDc9syGa5DwCrO+bBZlUZ1c/+k=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by DM6PR02MB4954.namprd02.prod.outlook.com (2603:10b6:5:fc::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 5 Apr
 2022 10:18:24 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a98b:ed39:5b71:5209]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a98b:ed39:5b71:5209%9]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 10:18:24 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     git <git@xilinx.com>, Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpio: xilinx: Trivial patch
Thread-Topic: [PATCH] gpio: xilinx: Trivial patch
Thread-Index: AQHYJ+5SiL1MXZihcEKy+bxY+XIzuqzhXFcA
Date:   Tue, 5 Apr 2022 10:18:24 +0000
Message-ID: <DM6PR02MB6635361B1A2CF6E94A006D56AAE49@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20220222131548.17513-1-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220222131548.17513-1-shubhrajyoti.datta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e80a3fb6-8f6a-4d1a-dfbf-08da16ed9e2b
x-ms-traffictypediagnostic: DM6PR02MB4954:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB49548501EBAD1FD61C9536D5AAE49@DM6PR02MB4954.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2OLN0wSYMsQKsyH/m44bxQAzPFpacVC5Ds9E3a4OI2djuWRCVyHg+3o1rREm38B2131KZ90sRDnMoTEpxpUBl+S5ia4vlZP+9E1jKWD2mkjP28xmToTn+jeyk0GMwVqOXgbNJRH5gvB/et7RkB4ifig4iEb5cyKRteJT5Jud7RqhM5L6kGtJqqT4PIp96bcypR9txOMukrk3/s2UBmIPTJ4kd81YD9c228yKbMyMMkyRlSJHSd4z/VpMTwY3b2ETGH+MJn+l6u+61rb8sem8xROKfiVTBuNhlK2fgmqPldoxTnjbgVrVktqmJgUGDlwhrgbboHyVi1AQthvprF9BI5zh94r/70tb6w0VWFiyJkpQavuRgeZBz0+NMW6RlwJ31AnBU4eQZEbavHYkrAgHCaWY1sr/hlJYVE0GjmzVpGAnti6oZh/AD89uNDUE9YFe8Ffh8qGPUayRlKftahZX4yacWgjpfJA8SthXMyE+diM0t91YNXHgcspjkSO8ZYqTTJerQLL+U5SCssmQcnqLbs4IdmeMMX73SGYvt7lbn1FroVHMvWC+DyCADyd5uv6APRiqJvc09sjKq3281kBNo9X1ERZ3kIfzv2b0bhqfw/9gSZo9vpSoR+ELFQDPemv3Wpw+1PQ7waCms8LwKUmAkbZDZy5hXTCOal216w06klti11a2PIOTf2DDf4vqWNmvPlOT3xEu6pOx7JLClL+xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(83380400001)(71200400001)(508600001)(110136005)(316002)(52536014)(38070700005)(55016003)(2906002)(54906003)(7696005)(64756008)(26005)(9686003)(4744005)(76116006)(53546011)(186003)(6506007)(5660300002)(86362001)(4326008)(8936002)(66476007)(66946007)(66446008)(66556008)(33656002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CkOTo+Sf/U16ugBPVZuKh5GjCv84rlzHeTMyj4YgdDHRwRXq35L8OrlPm5/6?=
 =?us-ascii?Q?coWeIofaYiTIOoamn8y+ZnhEIFJYYczZvCxD5U4aZRGpXbV0J2JeUQrMD5AK?=
 =?us-ascii?Q?5eRFQLk4KRSNXSxgNHwyrnteCwodugg4pGolnjfqMBT0qt7xCqDCTEEbH6GL?=
 =?us-ascii?Q?9/MAaN3XF/IkYjK5NfCOKjiUaxfVMN5qzhjEClo0LqOCso6CcTp179NQZdGe?=
 =?us-ascii?Q?a6CDm/vWycHRq/rmZfaS/Nzc6LW3anUORNM8qRPbM9fAybbQNhReVT6S+MqV?=
 =?us-ascii?Q?F5PvxQa5o6tg3oI2jWe/+5uWWddnwCkWYu4qQly1/iQzgBuf+sMw826uG2cG?=
 =?us-ascii?Q?l4JyAASqMnq+nLqxnkq6q60611AUhRmY8PsNead30FSH+SAkxgA66WvKAVkC?=
 =?us-ascii?Q?iV+X9XSqEncMITlDEN9L8wNsCYA4JuGeZJPSg9BU6Kl26HST7i15jFdFoUdQ?=
 =?us-ascii?Q?7pxMZNi+V5C8j7XbUPXZbBnWVJJgEVK+JiF96cYQ48PIdBKkhrKBcfWBvwKz?=
 =?us-ascii?Q?V678N71Oqk5pPkCqnZDlkNlTCyIukG3faliXYgnOSVb8SsZsHsUo+YkDV9bK?=
 =?us-ascii?Q?ToUqSEd9dtP76vO1uRDjbXWnnQoVPoXiVKBaZQ+hwwCvfVVrdcZ8BpTS3i/5?=
 =?us-ascii?Q?4t9Q08KJjswl+uREAP6DLgoQreKsjtkBacMNDanWBBqgdiCwAxb184VlIdid?=
 =?us-ascii?Q?cRYlcUenP6sNNUsbU7dDjoGp9v66AJZyx+l7gb1PVkjzHO1hym++gnRV5tww?=
 =?us-ascii?Q?U9dv7YkTFHYrS15FNeOzuJqj5yFWZxjlulLC3kpELeXJIGcQIhs4OXLaAo7Z?=
 =?us-ascii?Q?+R7nMFOt8NsEBZ3OAbw3HiiUL6eYpHghqKeZZCsv/j/wCOq1K5rdTC/U8fJG?=
 =?us-ascii?Q?Y63Yq0OuES6Ty10njNWlsp3u64cRGDbG7zdMmbWUXwWM19MPwTZgcCnxjNpp?=
 =?us-ascii?Q?HiGbStm/VbMQHFFdGgqBMYuZC+xNGhEYLZ2a9ZLhGxG7dNmseyaHmGhI4BLr?=
 =?us-ascii?Q?KjyXjr0PLR3dy4PpR4HSIGuo1wkPMFqtpp+kfQHPE5YDBa9pHy+Ob2KIY13/?=
 =?us-ascii?Q?Zy4Gb7h7DKPZ3NZd0YHRgYvxbwiyj+FM2hJ4IiCJZTRbR1ax1LVFXr1k3Pfc?=
 =?us-ascii?Q?7lXoLGYGS6XYjhqBKkEJAJyhfCnF1IChKR1vW8RKFwEkK4wmRPlVYDm7O25x?=
 =?us-ascii?Q?6CdN1swA4fVRsT0e7/Tb9HEXXgpPsACNBCaNdrdPt3hlVpxRBrCNIiKxqNLV?=
 =?us-ascii?Q?Vz3yoq0e6vBO9Xqy5HsZsYGNDnpnZXVU316YDORTjLQmufF+ZPCEFJjAT44q?=
 =?us-ascii?Q?4QM3kGu/sNQH+tX+C11s8VBv1dN6T5F856VwwC/TjkqdbF/FVycwP2uYK5vv?=
 =?us-ascii?Q?Gm3GE9Ms5mS2VzjJ9RYfGDt1AkgikoeGj/WIOKQEVVgF+9PLALcudlePLIyb?=
 =?us-ascii?Q?2YvY0SRKVKGGJGCZpw6aq0hwE/sXwfpQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80a3fb6-8f6a-4d1a-dfbf-08da16ed9e2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2022 10:18:24.2301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2i/f3TTPDPBSPP/A4UNwDFaYF9OcNOnnLQfBYnFkgjB8LrGFV/0o5TZzupF0L72Ys9e3VWFq+Td+gIdad6NwhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4954
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Sent: Tuesday, February 22, 2022 6:46 PM
> To: linux-gpio@vger.kernel.org
> Cc: git <git@xilinx.com>; Michal Simek <michals@xilinx.com>; linux-
> kernel@vger.kernel.org; Shubhrajyoti Datta <shubhraj@xilinx.com>
> Subject: [PATCH] gpio: xilinx: Trivial patch
>=20
> Add a missing blank line. No functional changes.
>=20
> WARNING: Missing a blank line after declarations
> 128: FILE: drivers/gpio/gpio-xilinx.c:120:
> +       void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, b=
it /
> 32);
> +       xgpio_set_value32(a, bit, xgpio_readreg(addr));
>=20
> WARNING: Missing a blank line after declarations
> 136: FILE: drivers/gpio/gpio-xilinx.c:126:
> +       void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, b=
it /
> 32);
> +       xgpio_writereg(addr, xgpio_get_value32(a, bit));
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
If there are no further comments can this be merged.

