Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3B84E7E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiCYTaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiCYT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:29:50 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20058.outbound.protection.outlook.com [40.107.2.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EB01F1D34;
        Fri, 25 Mar 2022 12:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7YC8Wan8QPuuwoXcQA9225cg4rdF+JBfzT6qzQ4oqYc2jPhX+VtCTpcUzK4XCe/YFlaSziowfP9get6RRWycoMpmdFNz0WI+JQ3mf7Q8d57ogNNbDvWYXD1mT139tl7D8+nCZ6MzWLAjMwnJbinh3FFkSabV9t6dKah/fvSsMenQcsWR+CU9y3rtI1gVc5QOt7dEel4GYJrWCjJLPbRg3bDgEDig5h0YLYEhF/HQnQFWXXBtF7JFhiuYuagrr4jH3+DLM0ENgPnFoyFPdeZkeajR7gpjMuvensoCu8b2pFx0oELpUmuXPrmO/NqSbXnRPOh0VFZaDZ1sgs1sMSDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flzoxfqDO/op6ckouLUJ1v6oz26uio+1mjSHxxhQWec=;
 b=T6psEVebsc6i27+idxZJETIFmU4jluEsb+LLaGJzDSeThGbjEmvI/3rkAbZ4a+ArlDFbkf0raqXUoS8VDi/C3WG3J1zayKX71BRzDGHHWxvanH9u5wh5Lit/uEbb2mqrXBWu+HLhK5uyahWRHFSnBRi+ZpJXRjszMe1bLFd8UWHfUzIX0Edt0umFBcrEU5bICdfW0MPx9UI5hQflsACyPLb3YiYHmm0Wk3xAJQhG8tyhHrNvmXQLnKpdYSHy9NOFh9kMYsMF8cVItSUoWBI4hbKUpNABtYXl29q5IInvwsBTyigiEaD6B484ClIjjmmJRW6s3j3EBveFM3zz/CaLvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flzoxfqDO/op6ckouLUJ1v6oz26uio+1mjSHxxhQWec=;
 b=CkyEBLStYr1+RFoi+Zt5ncHugK22iUR2R8Jl1KfXVbDjCuleANBy79IiieUQz+oNrymJtRvA/eQtzvnjY6TRB2m7wGgFmJaFrxxSdKm6Ha5p9FaS/uS3JjaUqYxgdPIwkDv6uv/s1IW+LMZEnKg2bNYL8lAGwNMDom4cpQI2l7M=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by DB7PR04MB5338.eurprd04.prod.outlook.com (2603:10a6:5:21::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 17:54:38 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f090:8a7e:c1e1:3d8e]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::f090:8a7e:c1e1:3d8e%3]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 17:54:38 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Marc Zyngier <maz@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Thread-Index: AQHX8ItO3xtQxxPJV0yONti9mp5846wxrpCAgAASv4CAAAYSAICdm7aAgAADHQCAAANtgIAACSeAgAARYgCAAQJ8gIAAewyA
Date:   Fri, 25 Mar 2022 17:54:37 +0000
Message-ID: <20220325175437.xb4wcfia2c3dgk2v@skbuf>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
 <87ilvrk1r0.wl-maz@kernel.org> <20211214095853.4emzycaxkuqr4tun@skbuf>
 <87czlzjxmz.wl-maz@kernel.org> <20220324171041.t5yoocinj6gizcc7@skbuf>
 <87lewz5kr5.wl-maz@kernel.org> <20220324173405.nusk6247ouvek46y@skbuf>
 <87k0cj5io4.wl-maz@kernel.org> <20220324190904.boo2izjc3mym2wkh@skbuf>
 <5ae774b7-f888-f201-d77d-0ab0cf0faed3@arm.com>
In-Reply-To: <5ae774b7-f888-f201-d77d-0ab0cf0faed3@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 057623f9-aa73-4eef-8577-08da0e8887ad
x-ms-traffictypediagnostic: DB7PR04MB5338:EE_
x-microsoft-antispam-prvs: <DB7PR04MB533869B8E6B6722791CF693FE01A9@DB7PR04MB5338.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0CnbsVp0uQkBe7eMkCQgyXFqbiMQ54c8mE4NCWIGyFAYFEhSwsRhxM1lD2CSMNlGQoiCDAHdhM163jKqSrqeXLJyXttFBMGajMfhJ9VdH0cq/z12mZoi+LKfRC9Ab71yLJ4ElQvYTz79vUKoyDEwY3I0dF7ZCa27oXqyMDFDy1BGH2VizYNTC3tOoK1pQjdrjG+ymJh/xdJDpwR0JQjuPa6zW+yCpeYNeRFLF8+J8UBpDT+HJTotm+RpFe6MjwsB3AgfxBDrCta7vmKG0yW/tGUZrva8JBijlf18Iyr/iehuQh2mWv7MrRBsp73dTCggvAMJFrEhM9jI8hKh1PTMeUkfeLMh7bjlSBFLoUq0Zs9EAh6dyExIKf3I5nnqsvzgPMdOBHy3tbcSB04CgD2Cj8BmzvBgOd4VtQalKKxogVIOps4ZyITJoIB4eDpDaEwL+Y4TLR/14C1KZOvqNgJsnl2jKGbDHoqGp4hb7KcxYaPuXgpKD585p/YI1k820KyrJKI1HZBpwLhQVnf/3/QuXgZjDAUFCEnlv2v1pYrSHvt0rjbfZ7hwcohCZGlxvjO8lXVWfSHoM3WfVkTM5/jehPg9TW5G+00JrFPxFMpvVZsgPzWjT6k3xa6FcMZ06zBybPtj/0R7IBFFG7q9gf6ODlHmZGweh6dkUJp6sbxM3e+WasKs4JMU0oi2NRzbfj4KzFCLsKc9VSrXoIvfbuk/Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(6486002)(6512007)(508600001)(76116006)(9686003)(66476007)(1076003)(66446008)(86362001)(26005)(186003)(54906003)(33716001)(8936002)(5660300002)(44832011)(38100700002)(122000001)(6916009)(8676002)(38070700005)(71200400001)(64756008)(4326008)(66556008)(53546011)(83380400001)(6506007)(316002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qN5W1vJWxKN0oDkXNsZ75Q4s1y030/7aL1YA7WzS6eo/H8tRaNJONyefB2OB?=
 =?us-ascii?Q?8dO+Zc4BfbnFcKigXH9JumZMFX8uMAhVitCwStbwFfl1hugntwJS5seNCwkD?=
 =?us-ascii?Q?ZOGFkdT88cELaa5O4Eh/Rn3bpWsQerzye5qtZNrPR8MGT+VNCxPxKy9dxZev?=
 =?us-ascii?Q?n7JcJhIGw/ivxNl6PwJj6Anb4c9ww/T3JN9AyBHPCscytZEFM95ecke0cFbv?=
 =?us-ascii?Q?CYCSGIE/9m/R/rO2Gwdj17kjIRnp6XHS2c40yGy2GuL7X1S1lv61O2b+/5tt?=
 =?us-ascii?Q?Ik+IYCz2talZpsRQZONbu5Ht+YJeg1Svy5fIYy0gayGiPgSZ6CRqkXJKrNMC?=
 =?us-ascii?Q?GzN2NdxT3Dh3AFdHcJ41Rc+QD4jIHWH1YqXKdsGlO6oNdzSnvSWvMFrtyyuc?=
 =?us-ascii?Q?ImeFGkVUhdxyoJRnuShgpYah8mW6Hek+DIfE2AddXism3I70h0FWeyQ7Hx2e?=
 =?us-ascii?Q?gt66M/bX9gID2HjkMps2PYqATpgboojJuulrGqg+0fDgWYz4Ev0NXCylTVnk?=
 =?us-ascii?Q?Lv+MRdd7BTI8CoWbvoFA7wteXC3ic4Y3NOLxO3CS4QKui9yGHkCdFyivngfE?=
 =?us-ascii?Q?yq3J5cYANFHa84nalwPKZnvPBonkwl4B3zdLfX+A8/ZFEnea5fdjJVliG2Ol?=
 =?us-ascii?Q?JFMSy8WRj+jtYAngtVcb4KRqA/YuNZ80YSkLN52pUfCtbrAQ4qGrnsR9qlDs?=
 =?us-ascii?Q?aG1WeLXg65QsR4R+gfa4xurBrGVpTtKMRRVUyjDNlzW6KgDFvq1NYGbrPls8?=
 =?us-ascii?Q?QN0CWG86WGaWsdIHd2Wt0oFrX0r92Ghp85h7glarssWuQEkdx09rciEjylyr?=
 =?us-ascii?Q?q0ROi0RB1KOCldTwzXRu9igVVXZkG2mo7Lz13s0u337mU0fokdKbwPH90/jK?=
 =?us-ascii?Q?zkX5pGrah9FEv+Q8UIQECCrxKBJNUP2MA4rHapQDJwRx8XJwNhh6BtbFGZP2?=
 =?us-ascii?Q?Gp8jgtwZ7icSy7LHsBSoc8/yIRUygmopwpV9EQb+mzPUgz2jEfYGtxcSQoZD?=
 =?us-ascii?Q?/8UNmbPJsHEkyehzW67xMEFX/i9wJA2YUCJpHC9zqxWJxI4DEeXChuydmd2b?=
 =?us-ascii?Q?sPILBLB0gLVlRLVgcVjmwvZiuBccoGMjXEoE1iZI7ofg8wGPaUno8BuB0Tkz?=
 =?us-ascii?Q?lq4/B54AQfC+AqpOlk1Hlr+eU8kJIymy/9NqxlSEBFOmbVaIgQcc7VeuabTR?=
 =?us-ascii?Q?BdpP5RUNUTnG3BGcT+O9Q1n9VWc9ExgV399feYzvXc0VlKFUJ+4TYtz+0gXs?=
 =?us-ascii?Q?x22VySc+VVHdkqXPg0jPpn47SprgWl3RG+zjIW5FMx7w6Ys9h65mxnu/UPBd?=
 =?us-ascii?Q?P5mv7KTlVVNXklzpn5sXeyYPbibcpO7pfnfnNY9cSVm0cSXirySJQwmwDM8/?=
 =?us-ascii?Q?Wx9Nh0BiKqyBq6lxX3hkaK2842u0FaafsQncJvGIgigNCQ9Z2gQCPpPEh2eH?=
 =?us-ascii?Q?fMG1e+iCMnMMfCQFipYfLpJaw4ZJK8Yptxs7IinkUrG1cA1ettl6dg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5C40AEA7D6C2C4EACDEE04DC5903793@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057623f9-aa73-4eef-8577-08da0e8887ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 17:54:37.7233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1KyQcY5OLJ2LjJkEE1cx0ybTj9ztjZ7EzMOLxjnx/jbxlV49zL3Yq+Ibx/BpNNJvzDg6nvIvWwDXqTB656mMjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:34:13AM +0000, Robin Murphy wrote:
> On 2022-03-24 19:09, Vladimir Oltean wrote:
> > On Thu, Mar 24, 2022 at 06:06:51PM +0000, Marc Zyngier wrote:
> > > > I was just raising this as what I thought would be a simple and
> > > > non-controversial counter example to your remark "If you change som=
ething,
> > > > you *must* guarantee forward *and* backward compatibility."
> > >=20
> > > If you change something *in the binding*, which was implicit in the
> > > context, and makes no sense out of context.
> > >=20
> > > > Practically speaking, what has happened is that the board DT appear=
ed in
> > > > kernel N, the ls-extirq driver in kernel N+1, and the DT was update=
d to
> > > > enable PHY interrupts in kernel N+2. That DT update practically bro=
ke
> > > > kernel N from running correctly on DTs taken from kernel N+2 onward=
s.
> > > > This is the observable behavior, we can find as many justifications=
 for
> > > > it as we wish.
> > >=20
> > > Well, you can also argue that the DT was broken at N and N+1 for not
> > > describing the HW correctly and completely. No binding has changed
> > > here. Your DT was incomplete, and someone fixed it for you.
> > >=20
> > > We can argue this things forever and a half. I've laid down the groun=
d
> > > rules for the stuff I maintain. If you're not happy with this, you ca=
n
> > > fix it by either removing the NXP hardware from the tree, or taking
> > > over from me as the irqchip maintainer. I'd be perfectly happy with
> > > any (and even more, with both) of these outcomes.
> >=20
> > Ok, my intention wasn't to inflame you even though the way in which I
> > presented the problem might have suggested otherwise.
> >=20
> > With my developer hat I still don't agree with you even with the
> > additional clarification you've made that you were referring only to
> > bindings and not to any and all DT changes. The reason being that the D=
T
> > blob is a whole, and it doesn't matter if there's a regression because
> > of a binding change or something else, you still need to be prepared to
> > update it, sometimes in lockstep with the kernel, like it or not.
> >=20
> > But as a user, I just wanted to get an opinion from you what can we do
> > to deal better with this situation: optional interrupt provided by
> > device with missing driver, which of_irq_get() doesn't seem to understa=
nd.
>=20
> FWIW, of_irq_get() absolutely understands how to handle a missing IRQ
> provider driver; it returns -EPROBE_DEFER. If a caller considers the IRQ
> optional, then it's up to that caller to decide how long to keep waiting =
for
> the provider to appear until giving up and carrying on without it. If you=
r
> phy driver is making the dumb decision to wait for ever for something whi=
ch
> isn't critical, then you're free to fix it, or perhaps even propose for
> of_irq_get() to opt in to the driver_deferred_probe_check_state() mechani=
sm
> if you believe it's a sufficiently general case.

Thanks, I really needed that suggestion, at the moment I made this
change which seems to do what I want when I force-disable the ls-extirq
driver (which in turn simulates an unwritten driver from an old kernel):

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.=
c
index 1becb1a731f6..1c1584fca632 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -43,6 +43,11 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *m=
dio,
 	int rc;
=20
 	rc =3D fwnode_irq_get(child, 0);
+	/* Don't wait forever if the IRQ provider doesn't become available,
+	 * just fall back to poll mode
+	 */
+	if (rc =3D=3D -EPROBE_DEFER)
+		rc =3D driver_deferred_probe_check_state(&phy->mdio.dev);
 	if (rc =3D=3D -EPROBE_DEFER)
 		return rc;
=20

The trickier part seems to be to adjust this change for older kernels
where the MDIO bus code calls of_irq_get() directly, and not get
regressions in. That, plus I need to understand what changes in behavior
when the irqchip driver is built as module and the MDIO bus driver is
built-in, and the "driver_deferred_probe_timeout" kernel boot parameter
has the default value of 0.

> If a new DT with an additional new property (either on an existing machin=
e,
> or on a completely new machine which has the property from the start)
> exposes a bug in a driver, that's unfortunate, but it is entirely irrelev=
ant
> to the ABI implications of changing the interpretation of an existing
> property.
>=20
> Robin.

Agree, but I'd like to at least be shot down for a point I _am_ trying
to make, not for one I am not.

When I resumed this discussion I wasn't really focused on the patch set
that proposed to change some DT bindings. That was a bad idea, I abandoned
it, issue was solved (more or less) through other means, end of story.

Instead I focused on one of the arguments that Marc brought, that being
able to roll back kernel independently of firmware is important.
As a realist, I can't help but remark that this is effectively a non-goal.
There is always a risk that old kernels are caught off guard by DT
changes which they aren't prepared to handle, and even if I was aware of
the fact that I'm making a breaking change for old kernels when I'm
adding the 'interrupts-extended' property to the PHY (which I wasn't),
I'd still do it 10 out of 10 times.
I guess I'll always treat the 'old kernel works with new DT blob' case
as a pleasant surprise rather than the inviolable norm that Marc is
trying to make it sound like. Mentality difference between NXP/Marvell
vs Socionext aside, I really don't see how you can systematically avoid
these issues, so it's just a losing game to try to claim that every
firmware blob should work with every kernel, for the simple reason that
you can't change the past.

As to whether this has any implication on the point you and Marc are
trying to make, that the firmware ABI contract shouldn't change,
maybe not, probably not, especially if there are alternatives. But bring
a more solid argument to the table. Changing DT bindings is not off the
table _because_ old kernels will stop working with new DT blobs.=
