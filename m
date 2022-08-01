Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF3586AD8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiHAMdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiHAMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:33:25 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BE297A3B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FgS+tVrWVvrj3OR9EZi2gn6WuOkQZ87UMSjlBH7SAHbAnOuAw4DnNrTuLu1/qfmEJ2wCoEmhFfm3k1EF303l6aqP3cwm/HPb/QRYB7v8S6msbAoC4C+IVL2lQerzidn336+S3/ONlGZ52yU8PKvbSuE5YVmS3qYeAg6B/tTlDCH2WZHS4bUqi441YKetUuF1ikDhJmtTBwu2E00remRFdVa5nTi8SP7X/Yc6X7pK4AjZjMDF7zVxBHyNM41fOXiJ0Fq51V3Fp/Vnd5bCgWK77KvS4qmyiw0EudiE63+QPLHL+m3vpnrSZL2L4MW+PbJBmzXzVotCNLApp6UNJGJXUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUvL5yk5K62O+gYcVUSQDuniUjhAOUMXNLULM01hNmI=;
 b=TEh1FQFIDDyFClI7qdkaC8ui08kycCaqOLpsFsXQhnJ6EAfKWojm3JCGWqXo2M25bI5GTHBpBdE13m+t/QS5drd7pygFtpGDWNASFGG7zOhxJ9Mwx9k6WlboNl6INJUaZiOxOBin5Zji1e06E2bVL+hFvy+bQYnp7LoejsRJavE3rY9L8HY42IY+S915l+zJm0HF+xZkySSoY4+VCg4z/p1K27erVFP+HbhXNgArsocx4j7EYTDw6oCyKPQLWraOqfUHlzTsGgXL9uOwOPRuOkxvBKd+Xh31/rXCulPkpHLJmNRRW2RBrLcSAyDo0jKZBccCqUKLvvj4MWAEeX5mig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUvL5yk5K62O+gYcVUSQDuniUjhAOUMXNLULM01hNmI=;
 b=IHz3tA5pJuViAoE0vklJ4Lky/vWgk0AAyMb2gs5DoOedFVkzpy83RCUng6iYNsI6jR6wA7luKwoe9LX2ZMQdYP1lW7EDMVN7B192JJUFnVAn3kDfaBxssH4BiK9OxIMjpmLQO5PCW7bq6gO3vCF8yRgMjj0z3IiYmUlTVA+PShI=
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com (2603:1096:604:6e::17)
 by OSZPR01MB7915.jpnprd01.prod.outlook.com (2603:1096:604:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 12:13:25 +0000
Received: from OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05]) by OSAPR01MB5060.jpnprd01.prod.outlook.com
 ([fe80::d083:eb12:1d4a:6d05%7]) with mapi id 15.20.5482.011; Mon, 1 Aug 2022
 12:13:25 +0000
From:   DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
Subject: RE: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
Thread-Topic: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
Thread-Index: AQHYpZYYkopTX/ODm0m6gaAsd7CCL62Z5ncAgAAOanA=
Date:   Mon, 1 Aug 2022 12:13:25 +0000
Message-ID: <OSAPR01MB506015B38A0A9DC6BE90F7A3B09A9@OSAPR01MB5060.jpnprd01.prod.outlook.com>
References: <20220801110140.7DF6280007F@slsrvapps-01.diasemi.com>
 <Yue3LpR7FdHygLze@kroah.com>
In-Reply-To: <Yue3LpR7FdHygLze@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 661d147b-cec8-40ca-1a06-08da73b73c15
x-ms-traffictypediagnostic: OSZPR01MB7915:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOLK0aYDwmUwcOy3J0skgVuqzxHpS5a6BA4MvemII26Jb8d9qcC5QRBeWhOvHC7pcdiMpXSMRhFpimaDpmn5cLfsqm1QjS06uQ7aAnHS5F+JirZYQpfhfo2LaWWa9CUDxc1yWj3ZFiz6QVvMgzaHsmeq1B/EccXWWvH9NqWQlO8LT3qGsZgEljmUVMllFYEjSGpINyA4FIhLBfuivx/T8+OnECmX1McF41PA8byEr51FQlAnrm6BtWUxPRMjLTvkysWompvkb+pNo4egpLe9bJWWoyI2zyL8xDQ2D94ry8gFgBdEAm3u/CkxG072lNOkajQegSvHW7Ey7SJ4oPX7tkuSTRZaKy1ptBYoPxO36kRJAn4YMpST+xl8jcreBfo0tDGOrvjfS2mDkntNvQkE9mIbjIFlDj/B/TANCoHKdvbjar7BdBZZ6VeSJs8yTy6nlvm0lE6MTiCyHpbS9req1dinC3XancAhu0x9JUOIKZWqkyh9gUBX2iy9oj5DG2tLHuqazVAEud8OIR7go6cYNpXcyaF7zpJ7blFr11uJg6qaeAehhCi390qalNJOV+YqK4jwkT04j2hEvzJxI2I1N9S2ZmliiwxANC7KishMT8DXTB663jWAHSKnmZKdK4eP/8KgTbyyu7T0JATubweCFTjTWs8m6H+GdNaF1c5Db7du1fv9vtg71L8cEHhe7EZP8K0lqSVltV3ys3LYh9TQv2EyqQengeG5V6l5/+jLg5wjnMjnVc/oUlFlUlKIMjiugua2g1E4WNdGeBGD9Hw2dhw2lLr61pDR8Zq9vmVZ0VBtQJhp5Iaiu4ltm1X/Kk1MyQl7MYpeFz4SLwaJFSJ1FQwy8NcQ0Mm3nTNKy3U6zv791UmH/2tAF49QmNk80CnV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB5060.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(186003)(33656002)(53546011)(7696005)(6506007)(2906002)(107886003)(26005)(9686003)(38100700002)(122000001)(86362001)(38070700005)(55016003)(83380400001)(41300700001)(76116006)(4744005)(66446008)(66946007)(71200400001)(8676002)(64756008)(4326008)(66476007)(5660300002)(8936002)(478600001)(52536014)(316002)(15650500001)(54906003)(66556008)(110136005)(130980200001)(223123001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?baMf1PP+K6C+yiwF/+ZF37Saaqjh0JPfbgGs+2/j6I5oVKarJw5UOldSC8AS?=
 =?us-ascii?Q?NVxQUkFvJJiQAGExozJxJ5NSuQO1OC2KAbXbm4j3BC1CqQmD4DjKgKmFC4Zw?=
 =?us-ascii?Q?FPaiigKitJb8uhoh7px7BQsttzc2iNi5mQB9NR5G611MYhlOm4rc84eYkdrP?=
 =?us-ascii?Q?5Ro/EqjyBIDdpbfDAqFLOUrUdKJsNUREy5P08KPUflxUn++AzfBjW9+MGgIX?=
 =?us-ascii?Q?lEBicmSFrT29UAMTboY87zPrWudGVqyxotS9G+QtozUsUaJxV9/ht58rUCOs?=
 =?us-ascii?Q?nni8kk0STaq2TZk8S7pLlnTamkVgU6dVk7Vnj//4vedFePidGHbiEMXiDWYh?=
 =?us-ascii?Q?5ye2sMY04yOudRPaT5/PQ/HFvTJJ1GpSO348u2spiNHngTJl4SFxdQsDjMLf?=
 =?us-ascii?Q?M+W+yKeHdPh5VvGR7qyF45ftEsSNysVyj1NLWeN+tNbTpqR8ovksTtwVnkr6?=
 =?us-ascii?Q?kddJiDYYvhv+55oIzBGkPAL9J7jvd0n0qUPG1k9aFK3ugHhxUzlctuZuJbc8?=
 =?us-ascii?Q?fo0E5JJfaI8paOJWFhslPBlO688pR1hOI/cobAxbNgSh2/1l2qWOMbTJoc8y?=
 =?us-ascii?Q?7IIYpw6O3Cvm66i3EJuHyxlPB4gMIvLti2Oz/+8E+qTB5mHd7PGYq9XaxhlK?=
 =?us-ascii?Q?5wZKHYPEcR2r1zADlmO97U3aXxmHX4g7mleGsr9r6R0MUgLJG/5a/W8BfVXP?=
 =?us-ascii?Q?gsYX1x0xfjZgIsvUUGKr8pveXEJk/dTgUS7ZLCwSB7QzF9/u84PPSR+e9mGd?=
 =?us-ascii?Q?lrGyvoSeIiplGHvWvnVY9egdxPcuPo2Al5FWiXBcUVXAQ/5hBZYR09991VHU?=
 =?us-ascii?Q?BWUPY6of61+7csFMVJnr4VgqZlp+490HXoGAGMxl2UMFkoYWCj5aV6kDc5TZ?=
 =?us-ascii?Q?J2hnZuwKi+9jXUXKxzAmq0Xf8Ik2+eAmZxX1jcB9LrqWaBm7AnjVqysEHI7m?=
 =?us-ascii?Q?QUNWx7d6NVbTq+1iPOrNPir10ytqzN6Wch8Acrrd4FPuOUqHuJb3QOaGMHSc?=
 =?us-ascii?Q?wP0SqA0+QE/n74ITGDZnomjjdyjfmUjBUbPHNlBfkeALb4vXodD10r6UDE0J?=
 =?us-ascii?Q?fa/9y2cZebt73pYsR7oBQcYzC7q8XAHoUObAoTQUsa6fxhfC5Z3HwYRqBHzr?=
 =?us-ascii?Q?NCgxoaCHksTUZ2V7N6GDhg+J15uNF7AuI6ZPyxnY5SnbyFCNPfBp68JXbMlY?=
 =?us-ascii?Q?XLkSXKR7y03f71uTi0mwSmpJusJcFNO40QRFFq7rTwNAR6rlGeyaD25eCHl3?=
 =?us-ascii?Q?IBZmft12X2uDSNQ8y64M3+ZsM/cLl8NVR2fKpjcZX8xeq9Yko5Fbwjjuy9d0?=
 =?us-ascii?Q?ZNRQnsR1htOG8mdL0dQQ2DmuRavcHNPQaKcwDgQ/luXGUBGRxW/DlxKnjkrn?=
 =?us-ascii?Q?m7ZXM6pi2PRQQodsOnThQJu396daVih0S8/QIHyX3811V2VhXZnRoY4AZbF6?=
 =?us-ascii?Q?jVRVy4dR7dxnKnDhSHZ4TnPboTxMCjEfOOs+WlAOPYS69QpbdHyW1ZM17ssE?=
 =?us-ascii?Q?V+359qF7K2S9/FmmZ6r2GOEvti6Ev+GlVm5gjuoX3OG+fKXjdwQd+9QgE8uZ?=
 =?us-ascii?Q?noufuzTTpUS75fpmzKT2toGthhfNhjieOmdLc5hn7EFf/yYZsYIO87gNWYX/?=
 =?us-ascii?Q?qA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB5060.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661d147b-cec8-40ca-1a06-08da73b73c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 12:13:25.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j332P5WzL6E5o2pTZwCa+ZW5Hgy4OYtj2Z+JQmafCls6ulGOtrIl2VB5ByYvKSu88tQDwmPHTKTJ+Hmh8c+YRawUI8uOJirgkWoY+OA0e+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7915
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SCC_THREE_WORD_MONTY,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 August 2022 12:21, Greg Kroah-Hartman wrote:

> >  DIALOG SEMICONDUCTOR DRIVERS
> > -M:	Support Opensource <support.opensource@diasemi.com>
> > +M:	DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
>=20
> I strongly discourage any anonymous "group alias" for maintainers of any
> kernel code, as that takes away the personal responsibility from the
> maintainer entirely, which defeats one of the strongest reasons that
> open source development efforts work so well.
>=20
> Why not just switch this over to you instead?

Appreciate the input. I will no longer be part of Renesas as of the end of =
this
week, so wanted to update the mailing list address before I leave. The actu=
al
mailing list itself hasn't changed in terms of the people on it, aside from
myself dropping off of course.

I don't know if there will be changes to the maintenance of these files in =
the
future, but for now I wanted to ensure consistency (and a continued working
address) in the short term. If that's not acceptable though then another ro=
ute
will need to be found.
