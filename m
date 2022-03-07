Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1C44D076F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiCGTRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240733AbiCGTRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:17:21 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAAB7D015;
        Mon,  7 Mar 2022 11:16:27 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227ITDnv010006;
        Mon, 7 Mar 2022 19:15:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jPorPDVnw+OFvD9g2hwRU9exR6wJK5CVWOOa7OF+5Mc=;
 b=i/X1KbY2bvx7sQId8mFPFZ5YknwPOyc8KxMgHSsufF840Bym58XDpWyIZkFmZgepsc2g
 GevtVI3Ty+GnsVjGz43ZXnKWd8qDU+4BznvQTgGvZgdmatl+xoc0wNzx7e4/oc67QhEI
 82R+ra6fuMoMMqCAYp+OTOPXCfaf1hz26l8cv6nM5JCzG/KVLf9+Ri/eAoRSIPWNeJYd
 gldohndrvbxL6QMROBDf51HbruNAve40FdZTDQbMsQiR6ryaBww2LbupOo7nwwg7yjZ9
 sfa+z8m8EWaC2xT3vYBXJDLMxfGd5WYBglzlRCP5pOujPyg8p7q1Y1ZiK8Myz5YVkarn 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0dtvwrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 19:15:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227J0KJG157674;
        Mon, 7 Mar 2022 19:15:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 3ekvytu08n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 19:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZInXW18icu/Z0RtpRpaen3A2oHJGxwDWs9W0bLXXdFpe2r24VKWm7bKtS611uNJNXidkRfJP2ZhA7ch36mWAP/gvIHw/CIrjf+EqVxzP4Fc1Oq7EhGGXTCPwIDeucvUA1NhrRYsHU+9qNi36sk26O7gnUXVV4ikmrmaWwLS0CXKthtQQagXUqn66gLeHcFKrpRiW9HUIcDodu5DjAIQe/dJmsRdiIe7KUqdE6RH/gS0+l+848mD++xstfZD62XBnIJ1Ys0fQls/Fmd6fpMI2UMAo8LcmUJ+hNWgjMHmCNMkQKjrwPb2yluJkYlbqSulVtZF5L83h8+7hYDBkOKVE8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPorPDVnw+OFvD9g2hwRU9exR6wJK5CVWOOa7OF+5Mc=;
 b=YbekMpCylfl6Q7V1GSM6D6xzDe/Ys9bfbMKhJVAfruW5NriD9ixigtow5fJ/ABgqoR1O92ClvE8f3lzjiE0hQgrrFZSY1S4lTsva28eT6F1Edut2VvjUo2j2T86j2f3blEUGsPK14fIY2TaPpDgJU3uAsUfNVhbXGH5ZThWkJQcgGcYqCSpJWj7zJkjOazYs4R7zn6id+Z+VCg4jwbdltQEQvAU3IITvZT4eLtftvpnf00XNMSeeg7Sx3xCpamJgK7yFQVMZgJi1W5zWMChkVmAYNte+inDhfIWSdQeG1pT51ujhnqnAvuZtrsbERprwOr1WTI3idYvUVWOKX8B+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPorPDVnw+OFvD9g2hwRU9exR6wJK5CVWOOa7OF+5Mc=;
 b=TBLXjX1EYU2p+ysDZH3WpkDxzcFEfhKFcSjp4wJd7AoaZ0zYhsE5HBt7dkLRENkEddC1ku1R4wmTj1G53GrloHz0qqW3tUE4hIcTMs0Assvtrzr62N7nMTMQXNG2oYdGAjLQXBipsLHK7XTVXULi9ZlLmTczJQgjA5L5KhxBv+I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5535.namprd10.prod.outlook.com (2603:10b6:a03:3fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 19:15:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 19:15:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Kees Cook <keescook@chromium.org>,
        Juxin Gao <gaojuxin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [next] mips-mt.c:233:19: error: conflicting types for 'mt_init'
Thread-Topic: [next] mips-mt.c:233:19: error: conflicting types for 'mt_init'
Thread-Index: AQHYKha0Qt9GfER96ESS/Fsj96HNTqyxxjwAgAKVCoA=
Date:   Mon, 7 Mar 2022 19:15:44 +0000
Message-ID: <20220307191537.jz6rho2vikdybpam@revolver>
References: <CA+G9fYtEx=k9TM7c7EihbO3U0qxZLbKX26NWJ1L=jjEOuy7cHQ@mail.gmail.com>
 <4c8f31d0-d51c-bb8c-acae-da1f1b1ada51@infradead.org>
In-Reply-To: <4c8f31d0-d51c-bb8c-acae-da1f1b1ada51@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99d764ce-c1f3-4183-191d-08da006ee111
x-ms-traffictypediagnostic: SJ0PR10MB5535:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB55353C93D6E792D03B2331F1FD089@SJ0PR10MB5535.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8AcvbiF3xprRnJRtLmjQLME2eEhDEs5nIEYq7d0YxUf1dl9/aII4bH0hbsVq7TAr+LisybrVDvM0SY+5FeNX0s32hNfF5qBwTZbQ7qfkeVbYxB0MOSBFDYNt3PBnEOdb1tzu5Oq8+xdUpzkacRL/GLDS1HCPbPBmLxR6C/ZHUxAm+drnKuaY4fY10tt9y5kQE1XvGmHSMuvkr77M5bWWx9S9hEIBvPKBdeHk9gUWp/o4py62OwKgpxa0obsb2kopXDAwFgS7CzOuOra4BaY8yHBshlPa6QzzZu2BiHftKltmVALI0TyI7vatxvy80G9mvfqimpx9DEHBoAZuYSY6YbQTgM2st7GyBMoaSWuytdA0X8cCr7EiGdCsKWEgvZtA3aMwED3gX7uWgCcwdKx+bnhOqHbZJ62rpOFrCfpLs0B1yivGFZbhiB/y8HqtRI4TXRpyeE8OXIrU3KBePH3SqSY6lYy9IPxTAEOrBEPRAtCcxERzaujWes18diD92zTyV/rTSW+KhBsPw33yX9Am+pv1GANzlxmWHo0oq72nz6L54ywDho7M5ZZTALt0VfpIT9JlAKEBh4KG3Bxo9lpJ+zUO/2FTiaw9sukaV1uzfmWb3qKGc69g9kmQuFMwlFM2cB03cJFbFNBTPqOJQCtSGrgUf9wJaLQzYuafcu8fZn9NknAmqh4z3Mllo5lfjQ7MWvp0Nonp60lp7LDO8XP0AXhgxVkPKNwpO0w+XbYxhfWgChiyRHcmu+MtijwuudbWs9emMXlXF0srIf/CVaATRT1d5CS9DNSkZ461gDhxVBjJgQqCDLNzG6jQ/rsb0d2CMTFe9zobWMv+bEwt8JA0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(7416002)(38100700002)(8936002)(26005)(186003)(86362001)(2906002)(6506007)(53546011)(508600001)(6512007)(44832011)(54906003)(122000001)(66946007)(76116006)(91956017)(66446008)(66476007)(6916009)(64756008)(316002)(66556008)(966005)(38070700005)(6486002)(8676002)(83380400001)(33716001)(4326008)(71200400001)(5660300002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?afOd55UiecogkbKiB/z66/Xx1BRkpWvioezgMoxn1I6rZUHaf9Bh4GOvVFbn?=
 =?us-ascii?Q?FOvKaVkN/xKEnD6EZJQhMkf/RyVMtSJtPdk80h7uBeUx0RKoIZ6k7mAnG6Hv?=
 =?us-ascii?Q?0HJj2bJzrAUBG2It9t2stMYyYdJW0bWqoN25zEa6bcebAjp+peF31QU1uWWK?=
 =?us-ascii?Q?SSgZkC1IWm9BjuXKIHRZ0WLvbQw47DQ6KEnyB874m1F5iOWcQEyDkBVCuznA?=
 =?us-ascii?Q?2d0gpsq8GAxXMvnT8SUWALa3E4dkQh9eQWW0GKgTkCYfGCJvUAMnJHgJhD3R?=
 =?us-ascii?Q?JRSHb3WMCoETIlOyh0Pv11tarGWuAkTTbM1BFRLjQPAJgBQVh2ZCfdf7rk/h?=
 =?us-ascii?Q?CjsbV/Jy6zb+N3Rp3+CbYOT2iWV7y3DIAZOzPgAdLJ+QNU6Z1APCUuSSk9p7?=
 =?us-ascii?Q?CTbDKhpZaSVXqfnWdYVcFuomUFNhaWUI2u0xV6vpUBuo62fqbQY+1woNavi/?=
 =?us-ascii?Q?Sv2+9nOLAim/KEW+OSXdYbrA2Kki1VJA1XyYyEpNBxY1J5oQZgorzVmG4zMF?=
 =?us-ascii?Q?H2doy/FkSbqknAOQQghId8y54rDtwiXX5DvfGUJQt7DMRCvxmlOykW4z4mt/?=
 =?us-ascii?Q?qu8gdGLCHSjDUQQaSqQ6oLHpzgdd9EUfUUz2H0i5Qm9Bu1Yy8bGd8W3/osaf?=
 =?us-ascii?Q?M2EF3I/vgVkzFpEQazbiNLACgzPYWJ1/RLMZnXHXbVpjC5I0T+Pf+vBHWRzi?=
 =?us-ascii?Q?2R0cJcBFaqhGKf6Q9q4fU99DeOpope8BzH8UEN8r0xYy0Hm+sLTgfuyiFSyr?=
 =?us-ascii?Q?fUPxsEBymwb/uKNPtKU0xwvYDAVIC+U6TLTZA9fB4d0X6/cs2NBxUpmaHKKJ?=
 =?us-ascii?Q?g4kJKWnKWrLBnEkhdSxUeRYfGP8YCtoJi8Od/dXcYfWTizRvwECc2eCGSbfH?=
 =?us-ascii?Q?VES4+48ALvrhObNf9pmMW7yc7MKyW8+wf417Q7WxczBNSPkuuw32qIW0TD+v?=
 =?us-ascii?Q?0VSguBkGkcCW5oQSBS5/EnfZCzmZd/0QcqF1FXVrFJtraIdj6WAxg3h9fD19?=
 =?us-ascii?Q?TgQJ7stkvX4hp0tuKaAwuKFIx0yuG5X+XXZdgna2phmRCtzDl4XwWF3++Xav?=
 =?us-ascii?Q?6ZepNdoLZtkvBpQVH2FTFgXg5K9A9qDZMwTFwetYFcduYDf5u9f7by4lh9f6?=
 =?us-ascii?Q?f5EV//Hv7SGrwITBj0JLVpguVnm/mE6t1B+74aIK52rdsMXcEC34PdqBCt0d?=
 =?us-ascii?Q?dMBA1WKjveqZ9FzaNsbtOI/a+hORPOmqcDe9+NwoAEMQixQot81Ww2T7g/RK?=
 =?us-ascii?Q?FUsAde+3jtvKXpQ7suzykdlzJ6kaYP/V2+f4WCro3z6we6I8w6cbtC9keIWZ?=
 =?us-ascii?Q?3kWTqIgNmYzrY5Y8USSd9ssyNGmq8OfNVGyFNSTqqfzxmNoiQghWBHULsRdN?=
 =?us-ascii?Q?QQOIS5hGpeDVn4zZBwPSIll7iHpFEmpxfp5oM0ODgjKNDI3ToZ0UEI3caEaE?=
 =?us-ascii?Q?xRNQkvwbQzkTH8iyI4KHAKQWifXncWsQcD+3UFFtig3lPvjcpUUpaQO2NaDB?=
 =?us-ascii?Q?rru/F0rqfRduo2x81jz7y0TNVm1UdU9z71z9B8BA4lvPF+L+H5ukD92KH50Q?=
 =?us-ascii?Q?o4lTkFl/n1KwQjz0IAwp1TRzDiYA4R6jzoU89/RB7UtRBLRV+Pr7cKoq2BHn?=
 =?us-ascii?Q?udMKRn5ZdUSpGzoplL2DTOM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FB5442B1FCBB9408CFA64B6157C7A9D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d764ce-c1f3-4183-191d-08da006ee111
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 19:15:44.7649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J4+KuVefU+UcyHR4GprxxuZiy2gH3x3+Fy3umIxxA95JYoboefNkRfTHMWKXliIw9Wsq1Oh5hzk79vD2duHAaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5535
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070106
X-Proofpoint-ORIG-GUID: 11n-UxnRaYdmhBwGOsgqrKDwzdvk0i0G
X-Proofpoint-GUID: 11n-UxnRaYdmhBwGOsgqrKDwzdvk0i0G
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Randy,

I did address this when it occurred on the 24th [1].  I had looked at
this and was thinking I would rename the maple tree function, but
Matthew suggested renaming the mips function instead.  I looked into the
conflict and the arch/mips/kernel/mips-mt.c uses the mips_ prefix for
almost all of the functions. So I generated a patch on my tree for
next-20220225 which fixes the issue by renaming the mips side of things.
Please see 51e773764d11 for the very small rename.

[1]
https://lore.kernel.org/linux-mm/202202241817.MXoE0NcM-lkp@intel.com/

Thanks,
Liam

* Randy Dunlap <rdunlap@infradead.org> [220305 22:50]:
> Hi Liam,
>=20
> Would you consider renaming maple tree's "mt_init()" function to
> maple_tree_init() or mtree_init() or something that does not
> conflict with the mt_init() function in arch/mips/ so that
> these build errors don't happen?
>=20
> thanks.
>=20
> On 2/24/22 23:09, Naresh Kamboju wrote:
> > [Please ignore this email if it is already reported]
> >=20
> > Linux next-20220224 arch mips build errors / warnings noticed [1].
> >=20
> > Build configs:
> >   -  mips-gcc-8-malta_defconfig
> >   -  mips-gcc-10-malta_defconfig
> >   -  mips-gcc-8-defconfig
> >   -  mips-gcc-10-defconfig
> >=20
> > metadata:
> >     git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
> >     git_sha: 44948bd49d878dad6c9707e34f4a06df73c3a800
> >     git_short_log: 44948bd49d87 (\Add linux-next specific files for 202=
20224\)
> >     kconfig: defconfig
> >     target_arch: mips
> >     toolchain: gcc-10
> >=20
> >=20
> > Build errors / warnings:
> >=20
> > arch/mips/kernel/mips-mt.c:233:19: error: conflicting types for 'mt_ini=
t'
> >   233 | static int __init mt_init(void)
> >       |                   ^~~~~~~
> > In file included from include/linux/mm_types.h:12,
> >                  from include/linux/mmzone.h:21,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/radix-tree.h:12,
> >                  from include/linux/idr.h:15,
> >                  from include/linux/kernfs.h:12,
> >                  from include/linux/sysfs.h:16,
> >                  from include/linux/kobject.h:20,
> >                  from include/linux/energy_model.h:7,
> >                  from include/linux/device.h:16,
> >                  from arch/mips/kernel/mips-mt.c:7:
> > include/linux/maple_tree.h:589:20: note: previous definition of
> > 'mt_init' was here
> >   589 | static inline void mt_init(struct maple_tree *mt)
> >       |                    ^~~~~~~
> > make[3]: *** [scripts/Makefile.build:288: arch/mips/kernel/mips-mt.o] E=
rror 1
> >=20
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >=20
> > Steps to reproduce:
> > ------------------
> > # To install tuxmake on your system globally:
> > # sudo pip3 install -U tuxmake
> >=20
> > tuxmake --runtime podman --target-arch mips --toolchain gcc-10
> > --kconfig defconfig
> >=20
> > --
> >=20
> > [1] https://builds.tuxbuild.com/25aFF2X7uoyebURaYzNHW9FVEmN/
>=20
> --=20
> ~Randy=
