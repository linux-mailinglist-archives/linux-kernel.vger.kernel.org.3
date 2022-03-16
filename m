Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410294DB7A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350787AbiCPRz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiCPRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:55:57 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2117.outbound.protection.outlook.com [40.107.113.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C4D6D956;
        Wed, 16 Mar 2022 10:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdhUZ9QqzEElysz/rlBS+Pvj2b9XN/WznJL3qPM6TKwGqHdH+IjoOo2bKKxrhPMJNueZANQ51JScrUwOxt0pEXxqsq/P23MZJNC2yfKH0ZYgnH7PZfvUCleIFg/ud3gbJjbGaqrv9iYb2jeVRxA8vwov97eQEY7w9WFaYzBc/nOWTR+WL2mzHAviy++ZCG2oQ1ONJ5rJJDrIrScB+H015tueU6ajTbQmfuVtta3evp+v1INjcWNe1XvL5lFizapsYQuNV4DM1MSeNWJPLbYVBUt0ZUfVE+HSYRQhMb9hn9qsItafB+WOR/BiAXVpP0foroZLnVzTEwXdrCFIXm2V3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifnWG4ZEffCheMnglHhqzkawCorFCAJdUUv63KdXUzM=;
 b=ZUymj7F0wCvdJ8rfSJPh13OX3ozeyviC06+ZZ4OUQeXRiVY8LooVaepsFZ49WDOjloKBD5sAJP5lbrP/YsBh+5rh0WU7/h+hf5P8ppjpYENiFXdpuaz8+CdRTBYpHghyuN2A1AEMztT+wiK9QAJEyBCzB8EIeslQmdJGicQ7MMwDEP3uYwgH1WbFLWRm6DsodXMg4mKNv5+NnIEYM5VQOrQLgU3RKWQxE8cD7WVt+NqTcqhtLy+IfYdTAjcuzAI8NcxNfEwPcatsOfCvzTwTdfS0xB1K/LLoZ1cOCbzzzrnZp14lNfDCt/GrjRdzUVF6nbQOdEoBaHJZrDOy1QTedw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifnWG4ZEffCheMnglHhqzkawCorFCAJdUUv63KdXUzM=;
 b=GKmhNYexE4hOVEpAHyuPliuqq6autoW6hQJ3hlAdyThrh6m+dzzrhEvg1LnEbqJUowIu49WVN02Mq9v9aYiCZebYHMafmqI9V9XSyKhq4Kf+8gJsUSsfSX9DJ/HtlcBN1HPWVPAlvweZY/KGHGHhb/gHnI4EtpN552FVB1uq+gw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10144.jpnprd01.prod.outlook.com (2603:1096:400:1e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 16 Mar
 2022 17:54:39 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::cc77:910b:66c1:524b%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 17:54:39 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [GIT PULL] SPI fixes for v5.17-rc7
Thread-Topic: [GIT PULL] SPI fixes for v5.17-rc7
Thread-Index: AQHYOJ5hk/ihoi/AnE2OZXC63Y67wKzCNAMAgAAYRKA=
Date:   Wed, 16 Mar 2022 17:54:39 +0000
Message-ID: <OS0PR01MB5922BAACEF18BDFA9BC68DD686119@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220310121327.63C6FC340E8@smtp.kernel.org>
 <CAHk-=wgN6bYPgaB7g0zGXQ5HnbVQ9910o9OQMBLs_S_ax4H67A@mail.gmail.com>
 <YinzW413m6p0H/i1@sirena.org.uk>
 <CAMuHMdU9t2wLonWBjkXBdxxyK_oJiOUTSqrYVrZWjsY2JKEJ2g@mail.gmail.com>
 <CAHk-=wiZnS6n1ROQg3FHd=bcVTHi-sKutKT+toiViQEH47ZACg@mail.gmail.com>
 <CAMuHMdWd_eAGjXRAODXvufoXT_QqqOpuLJTAj9ZG7d-EQyRKBw@mail.gmail.com>
 <YjIPxMrt5rzQ2AtQ@sirena.org.uk>
In-Reply-To: <YjIPxMrt5rzQ2AtQ@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23cb76a4-1669-4b38-c9ac-08da07760adc
x-ms-traffictypediagnostic: TYWPR01MB10144:EE_
x-microsoft-antispam-prvs: <TYWPR01MB10144AD36EDDD7ADEC85BE3C286119@TYWPR01MB10144.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39Jphg4auvUcZFbNCGek8N6cr7O+RafqFypBWoKPuVmPKu4Oke0qMF4/xmNoeTEpwrVZsbhmDLoZ8M2O8ZzsJ5nxYJT3JEkJ+KDLz2JpCSY1aDgsqKNRVBwDZYIBSb9XvhbI7yY5ESWndy1KhD1OMwgvkw/5yfw7KcMNyp6LwSQUn5JtQmYgJWNn7JiF2NTiJvY14NyRbIHbVdFZjDGog4oqE8KqeuBYO3kXmP6GP/oO3ZmSI8I2FLvcXZY819CGSQVpuzDeKnc0GtT2Y77ELiSrhFlFdJWNpdUHuHhkmTenHk6FoXLj2GktQ9BFtEV7aeVGmPOOlwHOPe4HFAcC3iMZMsPG/gZgCsEcb4tZ3wXw1VA6KBkxAXPtKgqTHEcngA7GDgccAz1HvzgPtLk3AEg+7GKOuYrt6GGU2Rtb6eL/noLf2StkMEwxq9V+wli41On+Myc4fkuHEgSgV5r24fhNKHbcEbszzw72E9s1MUi40PZARJTjy6brP3vz7mcSXqqSvqroocIAkyq6HlW2Bgv8VOmZQxdX8b6j6QvKb9atie+MenX8Ika1gUSfqrIwdRJrWTYVcp/gnc4k2oOh3Fy8qSJbPy6OCM2YnXtWbJesHWnvPdwQc1vj10Syr5RrpcvIVSpdAFZlJzrZjRF8QYJk5Qf2Puul/S/fFMAKBvCLzwJ24MPXx/Hm+XwEB1yjIaz5R4aDFU/BWC1RRRpYIrHd1h0ZU/2tFvuMyC3enDpmnUNEcsLUWpkGk9AQ9H4kdBXX+j49jXWWjxMgrxi6HG/yqUr7UYMcw5VLroh+AVs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52536014)(6506007)(7696005)(2906002)(9686003)(508600001)(71200400001)(5660300002)(966005)(55016003)(110136005)(33656002)(8676002)(64756008)(26005)(186003)(66476007)(66446008)(66946007)(66556008)(8936002)(122000001)(38070700005)(54906003)(4744005)(316002)(4326008)(76116006)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y+dDumPiL0G6wLtS0AYG5wJW0I8bYPOPVXn2FvYDh+7yB8urDqA03jIzuBAi?=
 =?us-ascii?Q?WSBmj7M4pW0mujHeeEHYC7YjRUhag9enTAm9gklsC0DLDx3dAurisuUHeMus?=
 =?us-ascii?Q?ZaS1TvN82E7226NsS+fCs+aKH+Du5O2DJVbg2ETv9/dmftaRWW6CfGTcNKff?=
 =?us-ascii?Q?ocSF3Tad76bimjKhasgnndtMalAxJZ6OyQuLmHXyE4lQ+V1bdZtcXItBQ3Et?=
 =?us-ascii?Q?Gf7p7Yxi9tgQfar7pIIzUI5SKU3u86OCNOxZAqM858mWMAWRAQz+nI7yrJmy?=
 =?us-ascii?Q?CTZfkY5Md2n1V2e7/ORklYMBgRDIHvPW7prILGuYQPaZUG8F8CCnTqaJ1nnx?=
 =?us-ascii?Q?QFRiI0KPSHw1x1q1pbyHAIj2F8Q3JUowC2CYbW0e1z9AcyQApmJQ5k0NCevQ?=
 =?us-ascii?Q?EcPj+Gj2d3LjX0Cgf+oo3aWH+vu46JBwd6eThAuciEwLsJXadIjabY+09Afp?=
 =?us-ascii?Q?5LD2yuncYPIcMyxyYIDsNKVqi9dfi5B1fxCt5pOBtrx3GkYYiB4HUKnJsWEh?=
 =?us-ascii?Q?2x75GSB+1N0YurjDNt6XMAYobf3ZD7l9uOlA7I60omcjBL6JnJyu+yQj+X65?=
 =?us-ascii?Q?fzZVykaG+x2f89+c8FU7Kcxij2cVNGqMJQN8FQOCqPvctTBczD7oat9iN9O+?=
 =?us-ascii?Q?kPX6OtuD3+sHW8dPBfwgpn6mWnPba0oelySi4TVSqG4eRv6+KhOuM6T10UFD?=
 =?us-ascii?Q?nYvR1hueJ0y/HwWHghjqLVuya87Hl4TowwhlHWJkiN3ckjmAjPqzRfOAbi7G?=
 =?us-ascii?Q?Aisxb3u63piWeVFQRBDunO0yyWefnDMHxjDd6/0d+aNbMqOTwpI7j4OGvhWa?=
 =?us-ascii?Q?JFBxHx/BTSoQGzDL9nGcWzcGtF6vw+i9/n9n7QXj+qFYlBY7hvMcf4/4AjI2?=
 =?us-ascii?Q?OGCUST1h9v4ALjDLueQ9EmXPSp88Z89iF0oA6DiRMlzKJT7OqOb2H6Ukk10R?=
 =?us-ascii?Q?xVhwEWLqjrHSyhgabVTy9qO0tCR3JwKR8bkkmf6/9SF/n5tV6pBnTTr3e9iT?=
 =?us-ascii?Q?KsWmsEvcDJaQzLqWhIz7J2SVYlaocccq8Fy3jH6Hdf8N538x7f9X89FQCNQM?=
 =?us-ascii?Q?IKZvmxfAJgV7Bf1GhwJv2QSORGDmggNG+70C/YGgk8GMeBmlnV3Ls2IDJE+x?=
 =?us-ascii?Q?LWAYKYQrJ0Yrwre+rQUqd+HEWg45X0LO91nnQVsj2gO8du/2WPCdsnY7AIX3?=
 =?us-ascii?Q?AxaYio12i6T/dXfRYU2xusRD4oTMh2xk9CpIemLf6ykwlRSlnzV8B+Ov4VU6?=
 =?us-ascii?Q?qB6X7S3BrRmXNB6jT47qk9QkSYaJEzv6WCQgJRY1K6lW70utnb5XJgaijLVl?=
 =?us-ascii?Q?hgPCIVBrzcn5ceAS9wp03vF1sMT+Hs/9XbA5++A4EsR9VhkkI6vpje67GuiY?=
 =?us-ascii?Q?vAaZDjpesFDCN0I+hR4wFK/7rvS652mJ6XELbLAaW7ynmyenCfLLRdhcIJGM?=
 =?us-ascii?Q?9jkoxvt1Kn8HGPWpYUAJvxYsLYIg3VLJ1kF0AXGOneOXqrSv9qm49Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23cb76a4-1669-4b38-c9ac-08da07760adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 17:54:39.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ODZm2Sbac1O8weBTiLBUSRxB3m9+inXSZSsWWjyMN5tHsBMgTlhhnju6tUFl8/jC0za612yYTL8wKTx1FxCTvR4RX5QkHjbl79i+BP6H0ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10144
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

> Subject: Re: [GIT PULL] SPI fixes for v5.17-rc7
>=20
> On Tue, Mar 15, 2022 at 07:56:13PM +0100, Geert Uytterhoeven wrote:
>=20
> > You're absolutely right. So the code should be changed to:
> >
> >         if (vmalloced_buf || kmap_buf) {
> > -                desc_len =3D min_t(unsigned int, max_seg_size,
> PAGE_SIZE);
> > +               desc_len =3D min_t(unsigned long, max_seg_size,
> PAGE_SIZE);
> >                 sgs =3D DIV_ROUND_UP(len + offset_in_page(buf), desc_le=
n);
> >         } else if (virt_addr_valid(buf)) {
> > -               desc_len =3D min_t(unsigned int, max_seg_size, ctlr-
> >max_dma_len);
> > +               desc_len =3D min_t(size_t, max_seg_size, ctlr-
> >max_dma_len);
> >                 sgs =3D DIV_ROUND_UP(len, desc_len);
> >         } else {
> >                 return -EINVAL;
> >         }
>=20
> Can you send a patch please?

I have send the patch[1]

[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2022031617=
5317.465-1-biju.das.jz@bp.renesas.com/

Cheers,
Biju
