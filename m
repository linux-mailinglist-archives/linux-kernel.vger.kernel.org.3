Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDF4E6913
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352843AbiCXTKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347107AbiCXTKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:10:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C08AF1D7;
        Thu, 24 Mar 2022 12:09:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVuCcQ+XV3lumVtQHfoT/Lkt+R0vwRUszuZfj4HKaPrdBMDURGAxp8A0dp9svHYeGYQUhramsB/wQ6jMdJqPd/hsT39qbWJ98p0Mcwskd0DX8pTzwTj9HNpV+GxV35M3qfSrgwyd8HCHeAl4RZPMN5weH0npBSRQTscf2fSbna+VSdGg/A3+JSo5O9S0AKHZRqmYX/9dafLmItRhApjWNMKrMUBPIVgjG5DG/gf5fxk+hzMRSv8HSNnlge3fIFUuj4HZMUc1vk7by3EFNLfMJ2O58J99j+PHsE+wNXb7yET26/B/40/UBFAFGC+JM+Cd2p57rS4hpnGP/HVPihvx6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxgZIOZJPqbZJHkOt6elgbz43Ypr/GIaVlr85fRaovM=;
 b=dniDbD6yb6dpk68gdUb7Dl03Q325yb+aGKVJ+eydjRSqvQWSnpvFmTvU4e1qNOjzjVFlDVdVIkVBPZLolc7ze9NZmvPXH0vzWLSBBMGMIrvcFutZfw3My9QnCAeI/ju8NlQ4rCTaKALZszg/T3W0IbweaiIOMlKiQt2mOkylGAsBvrtigqHU2hhBNVeMK5JLhqAlfyQOOaeK0cCtM30g4UeioXH75c0chTo3kugf7mVQAYjJbYlRqC8qK7YSpUE4AA8z4/Byz+/qbpZohXXmHlcY4iHXD5atbRS6dORvqS9XBEn0Exg6KyXp5RSPX6xY1XNuozVehNtD1cazvI0Iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxgZIOZJPqbZJHkOt6elgbz43Ypr/GIaVlr85fRaovM=;
 b=POxno3+9ea89GUJTAik1Rx6fufkPZK9K9C7Z8R3ah18Nvm7OC0ie0KyiTjf+PkavYq8E3+K2jEqtX3/Cs4wIFrJ8yCyvZ6rpM2TH+eMjSAi7aNabBfDHpEdFZ0gPE/F+/zMk9uniGOOhtqkNdsoPN2O+k92f41xKYYzRdeSCrgU=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PA4PR04MB7885.eurprd04.prod.outlook.com (2603:10a6:102:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18; Thu, 24 Mar
 2022 19:09:05 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f090:8a7e:c1e1:3d8e]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f090:8a7e:c1e1:3d8e%3]) with mapi id 15.20.5102.019; Thu, 24 Mar 2022
 19:09:05 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>, "Z.Q. Hou" <zhiqiang.hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Topic: [RFC PATCH devicetree 00/10] Do something about ls-extirq
 interrupt-map breakage
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4CAAAYSAICdm7aAgAADHQCAAANtgIAACSeAgAARYgA=
Date:   Thu, 24 Mar 2022 19:09:05 +0000
Message-ID: <20220324190904.boo2izjc3mym2wkh@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org> <20220324171041.t5yoocinj6gizcc7@skbuf>
 <87lewz5kr5.wl-maz@kernel.org> <20220324173405.nusk6247ouvek46y@skbuf>
 <87k0cj5io4.wl-maz@kernel.org>
In-Reply-To: <87k0cj5io4.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fcc42c2-5494-4611-6378-08da0dc9c40f
x-ms-traffictypediagnostic: PA4PR04MB7885:EE_
x-microsoft-antispam-prvs: <PA4PR04MB7885FDE3039F77ACC2D80AC8E0199@PA4PR04MB7885.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0KGoUD3UJsU8X5rm5C2rvDbdyZ7rmq3Skg1f/rgZxhKe6/jwFPZcazb1ttqx1OdVfYRtkakrDtKAp2WDYf3KRIk5FW2Gx+qhJqI3dBvtQ9NLbs4ETYurRi5lXfWHQQRGUbl7U12rG6rgPsXa5yT7S/CCGxxyRlNKNTt8S0FXG+h31lzdsymlbfpZRqGm1olGyhb99cR7bi0sVgD3NCKKVg3Pg2vlfeO3p3qjLBJVqKNp/oyHjUXtDW7QVQQX+r/hKiGFJy2x0yRVG6QWEipRBc/gLzlNUCYfHzuJ70zV0AxyvTGawf4Z8Is00sLFUSHhb3hi53DimHQUDcVPe5EwH0DnvgtAEblzoyU2TglzPfQvQmWdgbRcB4YYk1Vm+Rxn24coeMFGSJ3kcRg7YHp2lwnTZLHTVJPmz0Q07DTlrJssM3rC5pS/gVfvqTfBCdM/ooS9ql23+vcEdJpm1mUwOIyxQLU/FhejKeGXuHI8SE+yO6WFKox178Vuh1hFOUdImJawLBKiy72B72jokXxvwae/3gjCivlQafOZfy5T6zcFL0vleOroWBIXJjvJGkfH8wA9BjTxVyt0up86H+LtxD6mO6tdz828J10t0HX6MlPZHjAmc8nQSa0yU7RSqqicG+wgMAipNx1VyACw2Jf31UjF3iDsxKK55i30QjCM10/gwiyYH8ax7QVI+Pn3QXx8Pj6oB3PwxB9grj5X8RMv6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(33716001)(86362001)(54906003)(316002)(6916009)(8936002)(2906002)(122000001)(76116006)(66946007)(38100700002)(5660300002)(44832011)(8676002)(38070700005)(66556008)(64756008)(66476007)(4326008)(186003)(66446008)(6512007)(26005)(83380400001)(1076003)(6486002)(9686003)(6506007)(508600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WdgyX/BYGLvs9MttU5659kGJ0BbmZoIMwV2eus7+nEDqlI7WzJrfBHhqUCyW?=
 =?us-ascii?Q?cNh35hmS/Ryem6hIBE6jYehjXI6yEUUIz3mRf4ganUIP4aKsE99slnhiZKl8?=
 =?us-ascii?Q?4XJnH+dLEYJNtnUFhi8P2uKzlbivBxwux1t2swebwhSEpHJZH2m560lYaiM1?=
 =?us-ascii?Q?22ocRCN3dDXJ1n4TeE7xL/CFIdXC7Dy0Ri+B6oC0T12M8mlTZduyAmblpjRS?=
 =?us-ascii?Q?xuUsF/9XVtBoqP78jCUIxu0clAqT0zr0aVZUT+RhVzWslJHuXoEJDCFpxzgh?=
 =?us-ascii?Q?ZsR6jZNdvjSfsBrfOHx16memXKs7QQ4cm/SRDJvWW7VFk2kftbyLS3IV7LUQ?=
 =?us-ascii?Q?uhV36pZuTzYSDDxVhgYLdJBmAcslmDsoXawiugFMRT9SVlxr0ww02mPcLG6J?=
 =?us-ascii?Q?GNErEP9cPuqxUWGVIrlA/ejLjDXZ5vGei8PfJyNtN9OMJiI8dZXLgSZI69bG?=
 =?us-ascii?Q?2ODZkA6yIlgWnxbNfwjPUafo4uAyPfe4LquSUKJ7n4iF03ITubB5us9KXJmy?=
 =?us-ascii?Q?18ZZzEQc36xW4a0POt+fKxUc9UVmJm8Vx/W26pQtHWE+iTkOnnm8uxf7XTvz?=
 =?us-ascii?Q?rsPp6mRMsewFWYVrBL9ODPzJ8PSYPN3dsHltIdm40yh0suxV+x93Cl9IJXdf?=
 =?us-ascii?Q?FrC3qGM2YfGp1pWmDSwkajPfx5IJXCKRfBsPKucfZEFgNxYFRY/Vg4basSxG?=
 =?us-ascii?Q?s3as5uqDhFeqemlgfV8l8Dvw1TjtcjGOUqZv72xzWBu2+8gd3+6MkvKWYevz?=
 =?us-ascii?Q?QWBqyDpqOYtONF+DWmdsBDYKilwOqweNcAU3cOD7HwZBccMJo7P0MSw8L1sG?=
 =?us-ascii?Q?XuQQqGBqDXmqDHzNb1uL5aH2349E3n9Z09amp4fnddZcSRi5ight/+wsEsnr?=
 =?us-ascii?Q?hJsIhSbW/oFVZpSblGr0P99AE/sZylbwgw2aOZ4ydaMVJH86B2k2qbnGv9bl?=
 =?us-ascii?Q?7xnHnmfSqiTY7eQ5mwgbLdy5q/EeJ7p0qfw7Y4f44Omyv3TfTqAgUU0an+t8?=
 =?us-ascii?Q?o5Wdn3N69ynchJjXPIbLzrNjQQmjWMZRDNMhdEm6Una8dVRzw3+CrpBA8NsH?=
 =?us-ascii?Q?SPGDpgmlMRJmE3JcVyU7zEufqwRFdb0kq1DO8OZXcwKnlVeoPWBOZFdSJUSK?=
 =?us-ascii?Q?kFPNd/82G5zKmMNxWcEZT9aDnqPUr0zEvdIpLCLavDMz58ziM4bNCF6+uGYe?=
 =?us-ascii?Q?mhj4KrANusx0l6gTripbImBD8Gg7JsjUxbDqQShyRLpsZnECv0Dc5wMiKPfw?=
 =?us-ascii?Q?Zlk2OfbIv2YWgYUxM2c2cANuXrD/h6FnBHbBgTlCIhvMSm9QmWqAbkz2v9Xm?=
 =?us-ascii?Q?p1F2eNtyA72jh/AkN/kLa8SZQdE/n8evTea4EU2Nwx2xjFN0srbOF3a8UIZS?=
 =?us-ascii?Q?uGoaRWqh9ODblc9MpUoVSyiT7zQ2ZLTe4ou9+BIz52Hj+6DquG/SkLs0SLYB?=
 =?us-ascii?Q?lfk2bUCMhxLvJkE7c4qTngKAD5h2gTlTHfyJS1p6bvU6MhYiAJL4VBx4CM6d?=
 =?us-ascii?Q?dMbbH+QROhNoFTwLOF1GCXzSGf7zwQVAxhEmfjRaNhMGUg3g5Kf1VatzJJWI?=
 =?us-ascii?Q?4Mih2+tBg+tLa2Z1WCarDGHdcMC8GhIidrUXvcgBH1PooE6OZM1hgt/nTUyN?=
 =?us-ascii?Q?F/4UD15YAAn/i/IXVhKYx04tqka/QcsTttm6VElaxeJPFoUU3V0lek2PyFTE?=
 =?us-ascii?Q?LExqvtHzGq0IKbuKGSn1hQa4dmylJCGvdw8kNvoIqraUt5e9qLb1oFDDtFeT?=
 =?us-ascii?Q?lhyZu6aS65qJYY6MbLhKkdGW534xbME=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A717D3C3ADEB242B058C277FE6E21E7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fcc42c2-5494-4611-6378-08da0dc9c40f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 19:09:05.4183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YsuBSI+mb4HpMJ0x+6miMeqRkB22rH/SLXCC0zUu4BBBYiocdhSuWMXiPcYxMMlmvXZlwnTCi5M2BCNLnz82vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:06:51PM +0000, Marc Zyngier wrote:
> > I was just raising this as what I thought would be a simple and
> > non-controversial counter example to your remark "If you change somethi=
ng,
> > you *must* guarantee forward *and* backward compatibility."
>=20
> If you change something *in the binding*, which was implicit in the
> context, and makes no sense out of context.
>=20
> > Practically speaking, what has happened is that the board DT appeared i=
n
> > kernel N, the ls-extirq driver in kernel N+1, and the DT was updated to
> > enable PHY interrupts in kernel N+2. That DT update practically broke
> > kernel N from running correctly on DTs taken from kernel N+2 onwards.
> > This is the observable behavior, we can find as many justifications for
> > it as we wish.
>=20
> Well, you can also argue that the DT was broken at N and N+1 for not
> describing the HW correctly and completely. No binding has changed
> here. Your DT was incomplete, and someone fixed it for you.
>=20
> We can argue this things forever and a half. I've laid down the ground
> rules for the stuff I maintain. If you're not happy with this, you can
> fix it by either removing the NXP hardware from the tree, or taking
> over from me as the irqchip maintainer. I'd be perfectly happy with
> any (and even more, with both) of these outcomes.

Ok, my intention wasn't to inflame you even though the way in which I
presented the problem might have suggested otherwise.

With my developer hat I still don't agree with you even with the
additional clarification you've made that you were referring only to
bindings and not to any and all DT changes. The reason being that the DT
blob is a whole, and it doesn't matter if there's a regression because
of a binding change or something else, you still need to be prepared to
update it, sometimes in lockstep with the kernel, like it or not.

But as a user, I just wanted to get an opinion from you what can we do
to deal better with this situation: optional interrupt provided by
device with missing driver, which of_irq_get() doesn't seem to understand.
There are more angles to this than just "new DT with old kernel". It can
also be new kernel, but ls-extirq driver disabled, and I still see that
as a kernel <-> DT compatibility concern.=
