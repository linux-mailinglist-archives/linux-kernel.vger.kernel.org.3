Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30B8580F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiGZJDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 05:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiGZJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 05:03:35 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50042.outbound.protection.outlook.com [40.107.5.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1690029C97;
        Tue, 26 Jul 2022 02:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPc1RSMfUWwaXRjsY4/gNs1y4jzzLK8a22OYAu8E2qmdU8o7MvwGHb6BZzrWTKN6UBE93FggOaL7hh07+dyhU1cIcMj7xS95s5bCvu9bNuVkzRcwnT4wzgApZ9+ssx5Gw0Cvlbtw27bXzh1ClIGcnKwnfifY2H6fbaXv4YQ6iHNCBcKk5hwBynS5jb9rb9hGuhrZOR4vb9f9789Q4MnhQzLwjf747ExUEGoOF7AEkKprLsW4YnJ4ky4o3U06cQgWBeqXO/lV9xdxnorZPiXq26UoOthmXan/EOCdVBD61Da0xMYK8uItAPssEq7IgsWtPDsg2ok1UT0aIYbFkg1BOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wau0w05hbdX+JLGjaxb1elcRmhmSjsxh5th55onSxLo=;
 b=Ny8qGWge2WruwpNzyTXoeKNQXnAMtJDITnimcdZpQaT4TuSgGlgseEBcgZnJ9Wyd5uHoWEfYQzhXHZrsWLB8Juy98dA4rfoWPwcOPHBqQlfsJJ/b8640b1Chs4ul3OdzN3I7mXiXX5kRwmY83Bnzhz9BTwbgBcj2HXW3kODjcB1zlmP2FCJIXeH4JJMiLR+BOZ5AU7JV8X31haeqZWj1K/zWs/NyC2l++GW4kLJO1gxuE7WvAjXNj1G/LI0mVuROdH1cnMhirVdUUXJtY5uAtVcsPPaRfsxLSAweVImtXnux0xlWsfS8jz4DNV50o/5FCVo1FVUuPp1/dY5OVXVXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wau0w05hbdX+JLGjaxb1elcRmhmSjsxh5th55onSxLo=;
 b=anzz3W5WMjZpg5tYsdi6o9CReDh5c/kfHhpaf+Uv046uYaM/EnA/86eS30eNwomr2toD0OyRAb26h/i4lMAdQR7Ss4I57zVt1pPDTo6k7mS0tBc7N2vZGgEof0MyFdxBVzY+X+OL8i1s8//IvjaWbAFStN+esY9Ie+647Pr2jt8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8443.eurprd04.prod.outlook.com (2603:10a6:102:1da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Tue, 26 Jul
 2022 09:03:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 09:03:32 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
Thread-Topic: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
Thread-Index: AQHYnnhx6HQy9b/Z1UqXbelGtR85J62Ph3EAgADX9WA=
Date:   Tue, 26 Jul 2022 09:03:32 +0000
Message-ID: <DU0PR04MB94171571EAF51759531AB7E888949@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
 <20220725200740.GA2610621-robh@kernel.org>
In-Reply-To: <20220725200740.GA2610621-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9651435b-cce8-4a2a-5324-08da6ee5b70e
x-ms-traffictypediagnostic: PAXPR04MB8443:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RfXh7BJYImiUg2fUif5m+31OrJM7KGFoDoxNvQu/mviBHfnx3A6kgTpS5LSTCvo2Yc0ny4thaHwsZS5uxVIEnhhYCNKBBjZGcTsnvkMN9iGUrn5A+V6AN0nJ4KCYqJ/Y4ZqdLnQU2EDtMu0VdtWDVQM0oEmn9oncJyGqdcYzMFpvUmQ6Q4Fg8pDp/gccumbRiUr2dLFHsvqyhEMljvRKFks2Ef4SqkLroioZ/zKZfpZGiZAzH3NdjMr8sENefWz3XT8mGt3YU2bGqzBWiBAsfEOB97OOb22+FJDetOHVpxXsR2UOtbUMVjsx01U4tsP3Gos8lC3PBZXmJSiGmqSsjQ60w7w9RmPmr5twKF6QDwdwKoFr5VQiE02ZTUhJLbvQMvgPLspY9BUpUkwF+BVyeeSob69/6o3lONPq+13JAoj4sxc8yZkb82+G7pzVdt8Ww/XzZx/nVmTcwQt/ypeeuVcKkxxnc0/O77h9FNbOVhasx5YPnEM6bn9hERENLhxi56l2t6A0bFraZnKc9vuwckwFYwJZ4pV5MKkBpQ3Hky0jz1L7+gGuFeFtPck6KKNefWLYgVf7nUcL4u6ROlHT2K5y6kYe5Af//I+Ow+5i9HIMJjamykYQ+btzpUxzW35sB/UT07LPUzgHQSORTcaTGmWU/yfM5F1D6l5lAS9iKdby19D8KPO8+L1hdOahI2d59dS3IQFJaLTPUdOThGVM3rzfrMx6oh77D8xcTkwwCyugyRVkjsxUYKhljvYqPBaDyqlRc6TVmyotvFXcHIuGk/FbpVIYovxyNcnniciMv5X4ewfrG1rXZRBQxHlMT3kb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(122000001)(38070700005)(33656002)(86362001)(38100700002)(52536014)(478600001)(8936002)(7416002)(44832011)(4744005)(316002)(5660300002)(54906003)(110136005)(66476007)(66556008)(66946007)(76116006)(71200400001)(8676002)(4326008)(186003)(83380400001)(66446008)(64756008)(6506007)(41300700001)(2906002)(55016003)(26005)(9686003)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XB9fOYvBbVOQNOvvQovJFl7P+SgVgFMAUtnvc/VjvrY2AeBvFv6bfYVwqQvn?=
 =?us-ascii?Q?mj7PjLYENmFTRwtNBMndFVuMFeJRI3zbwBkmGToS1tPQSEeCU42dCgN5Vcqi?=
 =?us-ascii?Q?5N3oeudYCUJysjfLUBiY1FsvJW6L4Hbf8/RiZ6iIuHMb0RZWhY0XnAJVPnwq?=
 =?us-ascii?Q?8kA6KpLO9k7kn1PjKjmk9FQiYsMsVFlpxdjilsemm+FageCnGZGD4ffIRf/y?=
 =?us-ascii?Q?niqiN2dPxHwJt0BpRuochWdAaudUCkBQ4E+Vu85IBAw9tZOJE1wEJYsSAKgn?=
 =?us-ascii?Q?s4/MeCDIFV4NBH6j81F76k5md0DL/5gro0i0XuC+3k96QIOzD5PjIfIicY8x?=
 =?us-ascii?Q?CGQ1x/aBeiaZUqxmv+iihrW37ZNeAVrdzh9rRUiIak0L8oB9jkvheGCWE/wW?=
 =?us-ascii?Q?78TOX1LzK2u7thza9EyT8VfODi6V0k8quUdcMWZq/6QceU/mnQf0fOb0jf6l?=
 =?us-ascii?Q?hxH0KvLV+NH7GEU0usj9aCeG09yiWDKVy00D8adFT77vvm5AqvfSQraNXkx5?=
 =?us-ascii?Q?tJA+Dby7JhkiYmJuEMxd0WNxKAdi9hBrmPQfDKCL0EszTYql7O0QdhxKHoyI?=
 =?us-ascii?Q?N+EdAZ3Gaoyyw5RfQUqe5v2Ax54HIhxnW7PgFhmGot+fyRaz2y1cDUiAbhJX?=
 =?us-ascii?Q?HjpR0+ai7xjmqyq9qc9hG9CIABPbTlM0iCBmW1RMBfoCm84JO30e737Kg3TR?=
 =?us-ascii?Q?ZiA66cefUxOJZ9nBu9u6UmrplexAEa6MV301f5m8xGaaJN7OrnZODs0VYY6a?=
 =?us-ascii?Q?jJWhxXlLvjTtJgHVQ4l3gVI9HoRM0f1Od0Zq6SfndBbXNl1LBH+L+4SeVrps?=
 =?us-ascii?Q?OeTbem5QwrtlRRtkW5gVNI8CjULvvkuYCNfGEIl0owYjKBIyI7Tq7MzmJbtT?=
 =?us-ascii?Q?V0t9wvQYIDYKyUYz1wHagrWbDUMUSrNB56HAxHIXZLxBZCC1gbn0UxUCF5TB?=
 =?us-ascii?Q?58n4d9kOwMcaUOVwFDg5/jW4MrpLVls024a7lrKxx0I3bYjYas8HHKRaZ3I0?=
 =?us-ascii?Q?+/eHtqwo13TTe1+EF6Gph3cpvAR6sklV8qlcEkC93hJF/o81JYFPOFOMwe7E?=
 =?us-ascii?Q?sDb+7QhBFb8xTxe/q6+bNPT1BdauI98QZaSt+luJgTl3IHPfXdFKTnIN8OOJ?=
 =?us-ascii?Q?85N5yGzK/2zq+5Y0vPSsRf++keE/GQBqlE+aaGB3AHKQICa1XsecvkZe4WF+?=
 =?us-ascii?Q?SByPk2V9MiGq/0y+sytqJshxQ0HzKM8GVf59998wZ0NQULVMrNTWrDrkJdRh?=
 =?us-ascii?Q?9fR3AxgrBThJKYwZmArDojTqZhFviklewrfftgktkQthUsAUpMB9oBMf/HT6?=
 =?us-ascii?Q?lnwIKokguzKSbKIZ/KxKZw97Df8puypICzcM0woUgadfrshmcmvqNYfY46Mm?=
 =?us-ascii?Q?2EYV4ROwWWOXTeQmIG7YEfQFbHzG3DMZ4Hk2Kp+PELjYqAC2H5wa8RS51NVK?=
 =?us-ascii?Q?MNqsTISwG80YEIcemUx8w2yiHvb2eE3HrpWTvUsnquw1ylzlrbUerfK9DqOQ?=
 =?us-ascii?Q?EFQFyLLCu04ukBeuqSgccWU8TG/CgGpNbPjjqjTyG/YKBXtFPxfOLDY3phS0?=
 =?us-ascii?Q?zt9gsEMtoWIi6yacyK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9651435b-cce8-4a2a-5324-08da6ee5b70e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 09:03:32.3457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kN63893SD1m9r6UMSRrYTj4feMqvg6bFucu4YkU7k/sWiHArZSGe5DGQujyjpkE4Gu85urkJus4CSVtwMO9ORQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8443
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/9] dt-bindings: pinctrl: imx: use minItems
>=20
> On Sat, Jul 23, 2022 at 05:43:26PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > There are many warnings when do dtbs_check: fsl,pins are too long, so
> > add minItems to address that.
>=20
> A single cell is not valid though, right?
>=20
> This particular property is problematic because each entry depending on t=
he
> platform has different number of cells (5, 6, etc.). A single cell (minIt=
ems: 1)
> is not valid though, right?

I thought no maxItems means no limitation on maxItems (:
Then I should add maxItems.
>=20
> There's a fix in dtschema min branch which should fix the warnings.
> Unfortunately, it just strips any bounds checking.

ok, let me update dtschema to rerun the dtbs_check.
Thanks,
Peng.
>=20
> Rob
