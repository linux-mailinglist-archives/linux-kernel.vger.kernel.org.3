Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7954DDD3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238211AbiCRPuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiCRPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:50:01 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2135.outbound.protection.outlook.com [40.107.114.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CFD2BFD79;
        Fri, 18 Mar 2022 08:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxhhQxDDk+nROZ5FBasCc4p6PxsJp/VnJ0nGRPXLSyTPh7FiGkMlD7kiWdkoaF5bjmbmCbzbUJCrz9NmCtF8Qi9OVN3VzRd6EFkZkptr0TpzNjg4DJ9X6odVyt6UZ8/ZKiVWkgxP/2XJ52trzVVY512e2BFtSHXkG1hHxuu1O1R4549bW1ElzFYBNwHDr4TRsKqxjQj8bg48p43Rz1+KyYZ/VZcvRCNvkWmfV3e/TDT/JBi7g6a4KE697fxT3V54N/ZaHQ4H5tynQOSjR0yUFevpj0HbdFzfKURf4rj/lLjKYGykjWvEchXhGFjuduI6JraKT6ovpMX101u5DDS6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo1TQFj3xkTwBPVKE/8m1QwdZE3z+xJ9ZvYoJ0T9V5E=;
 b=J2OQiLg/S3U0ht1TIPkzxhrFma6P3paBM0FcMuqOrok4GWnXF8y35K6t37YUiwdWkiG/uwKM5Bd3L+mQNbjDrrA2u7MOoKeu6MSOlQKU8kpp8Iy8490Oze+/ulVV/gjG3zkeSdSZNAquN/uKfxEk31oFruZ4luCPGZpWIiBZgHv2MEUm/XdEi8sWyipkorgMDzvvX9SQiDxEJDXh6tECI9bmRjxHnbMlOk2mS8DDQbe/yGwYexZIqJcb0Q+7XJI2/FoqQ1r4Ez2HG+aubTFuTEv32SZkTSFnzIOH4kgN2nLWRj/WTSKK9FdDs82zz91BkrFuPahedteQXwp20PUocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo1TQFj3xkTwBPVKE/8m1QwdZE3z+xJ9ZvYoJ0T9V5E=;
 b=LyZ9tZx9pbLzohewIan8D9thaYNzjxvo7P+d1sDPqKXizcOQNlVzUJj1i3Axto1oQduaR+jQCSTuZhvzRtGpDPzIxFX8gxKB3VrR0q4Mh67/kzp2s9NJV+zBIeAt/GyhzZrRiMkqwsQ761Zg0WCdBBzRve30Yo/megjqBGBYLHw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9483.jpnprd01.prod.outlook.com (2603:1096:604:1c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 15:48:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b%5]) with mapi id 15.20.5081.019; Fri, 18 Mar 2022
 15:48:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: linux-next: Fixes tag needs some work in the spi tree
Thread-Topic: linux-next: Fixes tag needs some work in the spi tree
Thread-Index: AQHYOkScgsk/xj9LYEmOA37VxW3HW6zEuPvwgACQdACAAAAqAA==
Date:   Fri, 18 Mar 2022 15:48:37 +0000
Message-ID: <OS0PR01MB5922B9EDD5CDB7AE907DFC6286139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220318081849.71228339@canb.auug.org.au>
 <OS0PR01MB5922ED18407C0728F09941A486139@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YjSowNPTqUHDbLKE@sirena.org.uk>
In-Reply-To: <YjSowNPTqUHDbLKE@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcbe048e-d309-4747-e9b2-08da08f6c4b8
x-ms-traffictypediagnostic: OS3PR01MB9483:EE_
x-microsoft-antispam-prvs: <OS3PR01MB9483E74B4DA240520EF4A30F86139@OS3PR01MB9483.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRbLHAhCgu6nmxAUk1+v0xBYHqTg7ayL/KHgkRxbjgCEAA0db5ryweJGF3Vufg4xvs5NEj+1ZI5WxARf7mDGwec0WGhlmBfKX3DowWdGpYTo7iuXBIl1UDS0b+umfseB6f5UWWi2dg6aAtzVhrbv567x+eojbFTXePCZ/DI9HjkBbU6W9Tux5ZnHhDWbjTLzRzehwyksJzLQO4RUpnIPd2idAWXgZx0l0ZaT1B+HJNvk7ZAfFpq6IN8j3iQ1A5ByUECQWKRKnuV4cVmNtDet/QjLIhFw8RRyLkl5xVWGdWRj/0R04D/9iq+5Ez0ghgDeViwcIwrfJ7uzbW56s8h2NiUXB4VJKNkUti0s4KD/oDlK4G11OEgc7L+9uyJZsRmsqJwB8fUqCPLYWxKM6/BA/k3VxY6FL+8SlLL2PKCCw7xvSaA79xzcdRvLvkpLsg3lBTqRrd3oU6WyTuw02NILreiL/r6s8kCLryWUQFWXBBFdO+JdlTF6tq8S+Er97AWtvTiTJWJ0fKFl8foZQX4GnCduqCBvYkqx2Eb3+6FLW5wLXt6eXYFxF0LHZfOpPgFWeiI5hlDMT4LDiUBaMo476jvapY65LjLHukqN57/SGryNjM4hXtzVNYYeiFQiktOi+LBleITv+vZ/QB2rwHkpTzJgBZTxU2VZCntW3E+49/pJNHPrddWU93sqVtALUI9o/HJR9d/b96R6cT5a0EBrPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(7696005)(33656002)(9686003)(8936002)(4744005)(71200400001)(6916009)(316002)(5660300002)(54906003)(122000001)(38070700005)(38100700002)(86362001)(52536014)(2906002)(186003)(26005)(55016003)(76116006)(66946007)(66556008)(66446008)(66476007)(4326008)(8676002)(508600001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P+FwOdLd6Yd1lmiMRHAQ8+B7oecuvy12uPfg4wvEKjSI54/+JckHiOPw0pck?=
 =?us-ascii?Q?tLkYhpddAkemqMnwnUL3rQQ74QPMzuCj0YhmzmaE/3BYx22tnCKyF8is7A/W?=
 =?us-ascii?Q?xrifP/9vu9b20GXWIkyguHG4Bd1mo7vpfd7Fvju42F9FJfSAgRaThOl0JLsH?=
 =?us-ascii?Q?59MI4+OaFj0ILm2rRsfSgdABZ9lJFwet1KLjoY9/+2FvwKd2jeBeaYkqBuz8?=
 =?us-ascii?Q?3m0hrTd7YzC16yr+lo7oSLOwoaf2wXHefh+br/aSLoak1ZGSWDfGVm0Fn8Oy?=
 =?us-ascii?Q?QwsI6h/hfI5L44B9FyWaR0pHWCvv7PSC+I0ARjFjo186jk4c1db6qVYHMQVH?=
 =?us-ascii?Q?0drNhvQHDexFPOd+Y6Vc0EQJE/WsWkmCHvZD24zsyOUpFFXVOimgGtHkFIbu?=
 =?us-ascii?Q?tymC/AUHsVwZPn+fgW0AL4e7EONgQg/OakzmBF2pHWcWUpl/TkXIpvw5qWlL?=
 =?us-ascii?Q?R28SzRLzv061efilllS3ZZwv6sSZT58ScImTHu0Ykr6em9vtKNar5O+TYngA?=
 =?us-ascii?Q?kjIPJOG4OiQMCxNLQMG1BrIfgR5TqRSeFDka3az4TFEY6lcV8P7UiUoXztJC?=
 =?us-ascii?Q?MdEHN/9FT3hlCmvLL38l35uyswcNQS6lQNEVRNBj3+QFjDN12LLhmCkslHjQ?=
 =?us-ascii?Q?yge+eiIo0/cJyFs2MB9TEGUb8t7YsQ7WYOy2BXz5R0PDOC+EoxSbVNsB3R0n?=
 =?us-ascii?Q?TuBe4qf3mFW9LFx9uo3jXzuKzkSzzq1udX4h+wYuKO3azwGrA8HqMvhTdi+M?=
 =?us-ascii?Q?6/O6Fw4lvH/NN70tbGIs8cIvsZ3oTG20u0Sgm3Vzd6G80fOhJ3cYEUR6jauQ?=
 =?us-ascii?Q?KLEjfCrxnwKYseQy5ppL0iuPkEdiShAbRfngjCpHlEGsf/IMxpFyPqkHFZe8?=
 =?us-ascii?Q?+1y+CmqQ5kSwCosmJIeSvh+mpJUIZf6C0uEYv1sVT7S5IfVGnblqLA2Pv9A4?=
 =?us-ascii?Q?mSPPPoZF4PBG5QFFnKjaCfgPhCg95X5uRWzFrqUrcL52JBmCfeKanKU1Ixwi?=
 =?us-ascii?Q?3EHt0WMAY8l/YBJRV0QuVBVsQZoafmmvu3ipgm0D1uCMetWR4S2b+KhbAbu0?=
 =?us-ascii?Q?ePKSD3vV+g6VjaL+990hAWYdOHAHn0NZ+N12o7tvSt5xNgi3euLSFYiXenW0?=
 =?us-ascii?Q?71+yLaJB9NjceqUbFOzpFE6zG5PXnOaDEgl6bGTxML4YJK5jnLT0oasNRIZ2?=
 =?us-ascii?Q?kA3lYtP9ChXOE1k4BwADAQNM9eSMlRpelIhAZ5FNICzCKCt44b709t+8cADJ?=
 =?us-ascii?Q?jVIudWcEW6yTpkdjpYxPrLtnAuhvMgZhRad65OsqV354TnOW8dSIGPnivFDc?=
 =?us-ascii?Q?lOg8vAn21o8X9SUCeZ+G3AJojfMJpmZhCcaqJbm6sQsyC1FUeCiXf92WRtzX?=
 =?us-ascii?Q?XPyKAdOcbnjTPp8BjoQQWjrGs8EZtmVa59oTX6qLg2Fz3zdXaSunanGco/bq?=
 =?us-ascii?Q?WUDIQ6RDa4QyFU4ZT0H9QDJdtVw5ZWwcL4CF+S1pBRf59qiuxgdqaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcbe048e-d309-4747-e9b2-08da08f6c4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 15:48:38.0214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncmQqKIH9pmiL4H+5lwcm3BkBaMnaZMIXwJ2UOeW5RvcwdQwrNvslJ0IzvaiXtE04hf4EpOabMWWZiVmlTmVOSU/1wiAvp6dUeiull8E37I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9483
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Subject: Re: linux-next: Fixes tag needs some work in the spi tree
>=20
> On Fri, Mar 18, 2022 at 07:10:59AM +0000, Biju Das wrote:
> > Hi Stephen and Mark,
> >
> > My bad, I have added Fixes tag at last minute and missed running Check
> > patch with that change.
> >
> > Is it possible to manually fix this?
>=20
> No, that'd involve rebasing.  It's fine, just remember this in future.

OK, Will take care this in future.

By the way, I have ran check patch on this patch on Linux-next and unfortun=
ately
It doesn't complain about leading 'commit' in fixes tag.

Thanks,
Biju
