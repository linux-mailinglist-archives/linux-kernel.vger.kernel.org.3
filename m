Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231144D7B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiCNHYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiCNHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:24:29 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8866278;
        Mon, 14 Mar 2022 00:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTUMVRSINK4rd1aOa9pBvFKKotk82VZxlKmplIFboetG21zFoL5t/Oc1hUwNc4Slt6SWgWyJudXPI3nY7FOhAFNF35yT4oO30A0lacxhzze1ufr2upeP7DMXGiYc0WmC5ezuGYL9/wijUn4TPrjq4gRE444GVxgs7zklzFyi093r/WEWwXfeLZYAiJZAVWbfQ0cOsmiPpjvLW3e3v9/Tfl8pU/XOqRyPDIJazCsCOAt3bqNvZQJogkHJgyShz0PhEpyhu8reY9hdZbA0YChGITJUCb9EdT3ZHesQSYUbcRGjFHlRG028/BWceu9Wx3G5AuQmYOFQlgVV8WMz2rNQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LAaI1r4R/LTBMNHvpJw9XnmMqerGT0Xp5md0NzO+tU=;
 b=JFsHVgX8194189Bfulrx+ztCD+7yC6MWXOwolNT2mQN4JtKsPtiRm7us9wuQteGjrf/j5MaBOoT7x/g+LzilMQiCQ19348zhSP51CcFFi3KtPd1DmSIU/jWeTCC842HfvbWrrH2pUNaj1GZCksp7dEufkve9ZE58ko8rUx4KNnFQfP68sxjdPIztSSvyhZ1XIDyxMi0x3RNx2X+4zu2ksJrVnC0goES2tpti5qjpZvIjSM5Y6eFe5ii+hGBz6tTgeJ2aYnHnrX9guiIz+qup0XkDcD7lywf/k+gm08cOyKXBrlodfhMpLQthmm/yMlx1K4ZwrhWrF/4IWFbYppSoTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LAaI1r4R/LTBMNHvpJw9XnmMqerGT0Xp5md0NzO+tU=;
 b=doETIEh9Myf/wkbUsrm5P2jiqd6p4/WTrQs3aPhIzh5rcQ95CjhHDS5c/UeS/fUIOmgpN2olImTf78kcQriIW1MKa059ufj+fhK9Xt9UOs/+ka8I32XY28+F0sJ+nuQOI1BwZyGyGW1xIzJewsB6SJHjDifVOTRIuR/bta6zMys=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7600.eurprd04.prod.outlook.com (2603:10a6:102:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 07:23:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 07:23:15 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] remoteproc: introduce rproc features
Thread-Topic: [PATCH V2 1/2] remoteproc: introduce rproc features
Thread-Index: AQHYMrLhi+XOsBLFaUS/YtMFoPaB36y6ha0AgAP8F1A=
Date:   Mon, 14 Mar 2022 07:23:15 +0000
Message-ID: <DU0PR04MB941787400EF3FDD90AE41634880F9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220308064821.2154-1-peng.fan@oss.nxp.com>
 <YiuUWmWvRARTHjOL@builder.lan>
In-Reply-To: <YiuUWmWvRARTHjOL@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8da0aa28-d237-43f7-d518-08da058b813e
x-ms-traffictypediagnostic: PA4PR04MB7600:EE_
x-microsoft-antispam-prvs: <PA4PR04MB760020613E1C247959F00F4C880F9@PA4PR04MB7600.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 60EwaL3hwvIxswUbFO41vWwPFWUqX+lTm640Ti/KiB/SgTlCpIDu0NAZ8Tz22PFcrzi5E7ynGhzc3wV5K3vg32Rp3SoJLkCgIzzJsGJCNbU91YwusULuqlJcB4bM/4/rGfNkHRXLn9MRiM4IKgVfurfqlqt9ywPD8FY4CKoz/20/KRu5sexeE0IFKyEO6DctI9SoPT1L91g9EcCSpI25H+hCUA0Cxv3MlP7Ot31imqnzRhEpwczP/tZlVIZfv+z8UKKKWOCQErSMhHv5ZC5MpmPDZyLo+0kpao6gRWlL819lP2xEPWFSiCQ4+yXBZxxGHEvDLITTZyLTFUwHDF7FJPZXNURQb2f4Sqi83iEQl9fBp7SOG6uEyv/yaVNVZvmGzYg9LwEK+BS2OqI5OKuMITF2h4v3efRjrIvfGFyjrVFlK1kGCV5mjqaCf8JIltExn3bSw5jKQuIDZoahiPquqMHeXAjJlPM6PGojv9Hmwmtk70Km86MvrTEtYMGu7OmIm0Sa/wAdZkqZI7gWtVGdMIVXOVv7/Y7zvVZvsz03R8Uh4OwiKHibHOp7k76d/qWA4GScSjNZOOqf+kzD280s15rKolMDNnv9JhJgr71teM5uPTBDzwW6Gt6MND7u2XOsiAA0EitXqRM35bvutGb6e4eM0eSgFUWV6bMXszN92855ge6omH67kT409xnGZlO0WcH/7Ppy2Ul/6O9iahvq/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(26005)(7696005)(71200400001)(83380400001)(44832011)(186003)(54906003)(5660300002)(110136005)(86362001)(8936002)(2906002)(9686003)(38070700005)(122000001)(52536014)(76116006)(55016003)(38100700002)(33656002)(498600001)(66446008)(66946007)(66556008)(66476007)(8676002)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RkXFQQDCbDtm8QKiTb8bFF7RLLwcUw0TbQEz2QaN9/UobGoaZNWysffuBzeU?=
 =?us-ascii?Q?VTwXMl6QAEm4eremCfLbMNl49osSDjWeNjX8JQtDqfF8q55/yBDGQqOTgzgG?=
 =?us-ascii?Q?Jak6i2rFPEk21wsPrGNw6GASSJH1DnuSheby6SjM9SEPILsCR8+TGRJyS5Ez?=
 =?us-ascii?Q?lyEoZqhkVAIzuHkz7ug2vBYOHdJIND66QaMjM69uDxNc6SPAphfsispDaaMK?=
 =?us-ascii?Q?GhD923fhMOcN6FRzP/4OKpaXnBh9leUag1uHJ5HEu6bZ2sVOUqdOu3DPjAYr?=
 =?us-ascii?Q?gqb53n5hSg1HQ4nBdNXSYE/DQqnwF38uZsXbjh07D3pDQ4eL9IlXIwkLiGTT?=
 =?us-ascii?Q?c5xp+S3bigJRpMwVLI8IRQAi323cAk02+KQ/nSXQvczFAP1JoLOOLOU9kPn1?=
 =?us-ascii?Q?0vq5b0auLOa6K01LFBsYXN8Q5mqPzDW5aapxNm4/Pp9mQOkWZDXE49hIFpP8?=
 =?us-ascii?Q?zKBo4BEq27eS51DNZgvT9PP9ZMi8d//PUlTROZAZCfswc0RImPTGtiiPSUgT?=
 =?us-ascii?Q?MgcCA1fTf+LnPRqK75Xgs+RmJo9bzVHvwLxOEO3zN5Lti36djo/Xwg2T6h4m?=
 =?us-ascii?Q?P5ZV1U+pCAPEaQGW2KeP1DRbefy7xoSBj2bPiq+8wGB4RHZr+eCwWdMFDuZ5?=
 =?us-ascii?Q?nUtVpnPw0tTMOErPe4YscD5UV4RINt6a/aIiXLV8hqTg5x20QQdrIKr7pVH+?=
 =?us-ascii?Q?CBIzhgIKKxrVnNXhRjRoWXuvrqmbcWNUorNZa/WIRSmWJC2aVVmpqQWZGWLM?=
 =?us-ascii?Q?xzgACT4ozJ8oV2CrKLwijC3NKQ1yoMF60oD+EWtA34jN34aF2CaFZCV+E7Q5?=
 =?us-ascii?Q?VarFGVQ5FX0J24Vl0hfUzlzDz8atNUnsR2r2UScI9KNp5aT6fprEOcz0mSnF?=
 =?us-ascii?Q?I0YJOOwzSxpKu7E1wajWjIEuqO9sALzVjrB/vCSP0QmDHtjZxHnuUTdZjzSs?=
 =?us-ascii?Q?YhgPvpFbEFc8keX2VfEz14GFu+NjIEPLPTehdu1jv3GJn1VUtHrOb5diChoW?=
 =?us-ascii?Q?ToSEF/huvRxKhMeBmePZpX3bLwZYy2JGGIYdNGynrbQRtWwg6Ylx2U1LLV9r?=
 =?us-ascii?Q?9EXLx3rI/wd3bU3woaidO0N3jkBCdlGgZFPqvSUQ0RDpyix2GYBHfZBAWZKU?=
 =?us-ascii?Q?mU3w8z0//I7QjHO3fhZBEV5vBsT6Dj3PjgAeKUyFz5UWezdTV5ewpb+XU8Xt?=
 =?us-ascii?Q?TiN3UEgAaZkbnCGnwOxF/Y3U9z3vmitMp6sq+LsETHluyNi3+9WGoP+BE/m4?=
 =?us-ascii?Q?cX5m0s/ora4ZglmzmYgOrSsS56Wa57r7U3VS9lA1WlrQo/+p5f1+krZKjPgO?=
 =?us-ascii?Q?pf8G7ypUALqbdk6KrQar0qf4cvafI/xVdoN1bRn+hiD/yU7ygHrNRmHAMr5B?=
 =?us-ascii?Q?YcL3PD0SD6rRF13qCBIc9IcOPuyhyLp3bCCYirSBIcFE04al8/KNrMxketzE?=
 =?us-ascii?Q?SNZttrR4gt4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da0aa28-d237-43f7-d518-08da058b813e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 07:23:15.2693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWEW8JRand0Rz+tR+DlohX0Ey4Y1pmBbokT8O2FlEzZlka79FmYR4lfu91aGAPOhwolfoJBXYCdwHIJwlX2lmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 1/2] remoteproc: introduce rproc features
>=20
> On Tue 08 Mar 00:48 CST 2022, Peng Fan (OSS) wrote:
>=20
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > remote processor may support:
> >  - firmware recovery with help from main processor
> >  - self recovery without help from main processor
> >  - iommu
> >  - etc
> >
> > Introduce rproc features could simplify code to avoid adding more bool
> > flags and let us optimize current code.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  New
> >
> >  include/linux/remoteproc.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>=20
> This is the API that other parts of the kernel use to interact with a str=
uct rproc,
> what feature flags do you have a need for other parts of the kernel to be=
 able
> to query?

I no need other parts of kernel to query rproc features.
In my V1 patch to support i.MX8QM/QXP self recovery, I introduced a new boo=
l
in "struct rproc", but it is not preferred. So I think to use a enum flag, =
after
looking into struct rproc, I see the possibility to use one API rproc_has_f=
eature
to simplify code, such as move has_iommu into=20
rproc_has_feature(rproc, RPROC_FEAT_IOMMU), and in future, when need to
add new flag/capability of rproc, we could reuse the rproc_has_feature API.

>=20
> > index 93a1d0050fbc..51edaf80692c 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -417,6 +417,7 @@ struct rproc_ops {
> >   *			has attached to it
> >   * @RPROC_DETACHED:	device has been booted by another entity and
> waiting
> >   *			for the core to attach to it
> > + * @RPROC_CRASHED_ATTACH_RECOVERY: device has crashed and self
> > + recovery
>=20
> This seems to belong in the other patch...

I'll move this to patch 2/2

>=20
> >   * @RPROC_LAST:		just keep this one at the end
> >   *
> >   * Please note that the values of these states are used as indices @@
> > -489,6 +490,11 @@ struct rproc_dump_segment {
> >  	loff_t offset;
> >  };
> >
> > +enum rproc_features {
> > +	RPROC_FEAT_ATTACH_RECOVERY =3D 0,
>=20
> No need to specify that this is bit 0, and the enum will do that for you.

sure

>=20
> > +	RPROC_MAX_FEATURES =3D 32,
>=20
> You're using DECLARE_BITMAP() so why 32?

Just wanna to limit max features to one int, I may mis use this,
will fix in new version.

Thanks,
Peng.

>=20
> Regards,
> Bjorn
>=20
> > +};
> > +
> >  /**
> >   * struct rproc - represents a physical remote processor device
> >   * @node: list node of this rproc object @@ -530,6 +536,7 @@ struct
> > rproc_dump_segment {
> >   * @elf_machine: firmware ELF machine
> >   * @cdev: character device of the rproc
> >   * @cdev_put_on_release: flag to indicate if remoteproc should be
> > shutdown on @char_dev release
> > + * @features: indicate remoteproc features
> >   */
> >  struct rproc {
> >  	struct list_head node;
> > @@ -570,8 +577,19 @@ struct rproc {
> >  	u16 elf_machine;
> >  	struct cdev cdev;
> >  	bool cdev_put_on_release;
> > +	DECLARE_BITMAP(features, RPROC_MAX_FEATURES);
> >  };
> >
> > +static inline bool rproc_has_feature(struct rproc *rproc, unsigned
> > +int feature) {
> > +	return test_bit(feature, rproc->features); }
> > +
> > +static inline void rproc_set_feature(struct rproc *rproc, unsigned
> > +int feature) {
> > +	set_bit(feature, rproc->features);
> > +}
> > +
> >  /**
> >   * struct rproc_subdev - subdevice tied to a remoteproc
> >   * @node: list node related to the rproc subdevs list
> > --
> > 2.30.0
> >
