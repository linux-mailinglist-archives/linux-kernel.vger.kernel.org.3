Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5222254D8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346959AbiFPDIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357844AbiFPDIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:08:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2046.outbound.protection.outlook.com [40.107.20.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0187580FB;
        Wed, 15 Jun 2022 20:08:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3HncfOZb567nQLEqdiSJHJ78AhF0yT2C+ve0Q6AY8SI10nWKX+yiWnNNVu/151tOED4SxevgM5aY9ezRXBJwtAoLFP1vCs5p1Kcrc9wom3qpdL5TBoojRMq5r+xCvhWGht3RjDmlYshYbE/OwABZZuUEwWpoLRtnkQsJuyJuHn5ZtKfJf7777pU+IWsqDbfK8T+g7loXEDc9vD/EVOcHU6iQmBOBP6u+K+ggVwsceQamvXd82EJbvVJcgm9qpyhisOVd/yalRE11dE9J0LGpNebWT2TS8dOEbHFSy5oPWNGGqFBRQRu6w6i3+Bc9KT+Tk+STqWNL8Btzy0ejVDKzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbhZk3kuYchZauX4sR9nY4A+we4csk9h5vSxpMnNcAI=;
 b=QayU63uME/ZToOnPG+O5ANdkbcTrBF2AeZ/0/86E5zVPUXT9XoieyKxFQL1tdyA7stQJG+ZA3F7ajBmaJeyu2Igble/sa0UakGKQIXidY4Ul5d+2sz9A2SHGcmWMesfguAhxkCcKli3p5WD6UKmurRUJ4nKSkaVGXM2xk8LohnMS0MuOzXiKLgqqjMIp86IXI2yk7KW6n74mI2wMXBnCWDYNFqKXAWEflxpBSYp1/c8e7abvdFdUtxr3kdAgbYvyhSNLRMFbbZksdmnthrkvCKimeLXvyJLuUk3pI5tHTCthxdPhb+1yym+JHgP+6hcxyg5KssduWfSjoZJQWDuRuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbhZk3kuYchZauX4sR9nY4A+we4csk9h5vSxpMnNcAI=;
 b=D6oM9GEw0Uu4ioLB8w1L5skdCLcNM5HGod0joYdy6HIS4kRHCIizk2g3pMT6luw+WmiuSkyKizB4+aEYAv9s5DfQDYnGgXyJcxezjTNTQHGeQjvKbkryZMd68YDf6zE9YCeQYLPuKdoDdG9NOl8cOPbUDhmlTr7fhi7Yqbqrvho=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2237.eurprd04.prod.outlook.com (2603:10a6:800:27::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 16 Jun
 2022 03:08:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 03:08:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Topic: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
Thread-Index: AQHYaboGz7v8csTJX0uCaklNTdvzCK1P+z+wgAEi0ACAAGqYYA==
Date:   Thu, 16 Jun 2022 03:08:29 +0000
Message-ID: <DU0PR04MB9417D99BFE5F9AC1C0F8DCFF88AC9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
 <DU0PR04MB941740BC9C2C5B205985CAB588AD9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220615204450.GA1257609@p14s>
In-Reply-To: <20220615204450.GA1257609@p14s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d19d40e-5091-4566-0e61-08da4f457d10
x-ms-traffictypediagnostic: VI1PR0401MB2237:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB223780FB0C1A28E8EAF85DF988AC9@VI1PR0401MB2237.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LhIYS73bDSeXpQBHYsXW+arPlpX91RRxiurTgvcXtL+nG/qY2lKpx+LxaYDkGdpf4amxn6D5lXm/cAF40voY9dT7gy2SIgg3iddi0eFzqsWN9sAZKqyPcuASzSC6qHa7GeC9twBQMymFSnEJoV6POQ2PaRUjSP9wcyFUNPofnNwI0gPFufu+T/woI9C2D+Oc8gQTcNctqBSEEGevkSjdXMReIbFcjfiNoKadb77fWQtSzD6YZZXrSHobiO5zKQSSJLo6aCSdgUw7fbtmkOeQMyIAO6r3MfGMeLmviF+aOtfi/WLxwxnplUEWbMbIikkWIGWVh+xF6M6YLTFWkiY1pGZ4jlpSGgT9vvjyLPRHB5Nun2BJVbySuqrnUw7xT5DUF12pKwUY5UBAhZzpbsCDA4rO7p5CQeCdSCGeB40XFLaY/q1d7JmM41XJobw/NeFJBoqpc1D+HDwCPKl1n+CHTN6muLV4pKX9L5wbS4oLDRqr9UxpMazMS3Jw3QrSIu9eThBqgOJ8Cal5PKVeDjEGzw6Ml3YOLPdzfEVgm8JkMkeNFYGiTk83LCnvLYHnlQN/0MSeV1N7RUBBuL6IUTzjc/omCopl2VfPv2kMqnriZbaS+9BhWMIRH1JVv+AG29Uz9J8qzSifPkcz3eQESsPb4/duVo0X7mEgKnupiGvwuXwHyPxjbS2V1oecgdCVn2/waoKeWh3btpJSsE4rkRtEZTJqY9JmV/457qjC0RSXHJc7y/7g1EH1E2J8LNRG71icBZyBAGTevsE6581EGtSh7MeDhKOJjyYzU/RQ7bGMNzY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(76116006)(66446008)(66946007)(66476007)(66556008)(64756008)(8676002)(4326008)(2906002)(38070700005)(38100700002)(52536014)(122000001)(7416002)(5660300002)(44832011)(8936002)(186003)(45080400002)(966005)(508600001)(86362001)(26005)(9686003)(7696005)(6506007)(54906003)(316002)(71200400001)(83380400001)(6916009)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fIVkKzjz0rX8lsnvyeEULA8Ae8cLRQAQQKhR9+spf+zkennTCigOnu8qB2Kt?=
 =?us-ascii?Q?6YbInmcYjq0Q2RKqmSiL1WtlHfA6VV6sXtaCe2TvAxoppgLYvJoAxIDHoYUD?=
 =?us-ascii?Q?ak+fOmxJmixg2BYsFC7imgnhj2tSfBtc+MdQLXdKU8Bpill5loEsY11wAGo7?=
 =?us-ascii?Q?mrHtBI85wIKNWpSo4XImUdIThqBVHcsIZf2hXzNjIiIQHC4tx+fW2CBFWhMV?=
 =?us-ascii?Q?NWayNgB5sQHSCpUEnGz/lBYnAjzURyIgV2npPzhRuEdfEpoSteYLsW4F1DLL?=
 =?us-ascii?Q?vUQJqfeR9hryS3Grgv+oY00DneChEyqLB233G4GZEAJmxoHy5nf1eZTCOCKY?=
 =?us-ascii?Q?6jdKASNldq7KTCq2UCJVXuaeZlaL3L2uvZ8N61JebXVZ7g0u07nwg9k3GDjO?=
 =?us-ascii?Q?V9XtJ88e5LOvY96wTTmFEZVRx1bP4nga4+db8g5MVi1Ie4+UdEl6YA06C8P1?=
 =?us-ascii?Q?/FJ3l/AK60deLtJjQf/svS3Csb7HgdaoYpqfsvWSe3M6g4vynXxsvZifFqlg?=
 =?us-ascii?Q?vp0Nw1zjlHyXdb/oXicstIJ9+QvYxUnaYTSplXaZbOvfGLKx7fO+EqS/GO5Y?=
 =?us-ascii?Q?9UZYgpq2cnj3AY5kHoCC7livzDJUSuk6cWADdgNLC3aYp3e3jBU+cQax4sCh?=
 =?us-ascii?Q?vvGc/sBmtrHIzFQeTnXeN7uOISiDfIYef/ISFCJa9jVNxR/Mrhfrr1cHyuZE?=
 =?us-ascii?Q?4wIYcHr8GasZ8GjR8sg4yICxEvn53jhVGTDJuU06sl8l/bb5i80ME2sX8J9w?=
 =?us-ascii?Q?1a4cvdNmcrWtNal9UkBxkTJFCAMrN0lhsHjiX1GCFuRT/O4itgYEL2nJXBAb?=
 =?us-ascii?Q?Fzq5FqTOoa2KdrEyP6tcX3sWGNcCBeMAy9ZjZisipl8g4Kbg6V7kvJfH2HEy?=
 =?us-ascii?Q?yasWDJYh7fdBCrQ0FNDtreKxTMM/MvU6FOwGMtKmyf049CJzMCH66rcWp/Fn?=
 =?us-ascii?Q?8GVai8aPJC0qc94lQ3C9W7kt+qb/lgPwDQUUxJXqhM+Z2lYt/cBD6zQ8Z0Uh?=
 =?us-ascii?Q?WoxNKkPMaAFArUfiSZzTQw1PWLMBtIEwqP4AtxvuGh2Dk+q4tJ9yW4TwcO3H?=
 =?us-ascii?Q?tPBx/86aKpoYj0kmRQW1PGCEWkoTmpPw2Y60jBvYs1mDTuHbYyeT7T7z5Hks?=
 =?us-ascii?Q?YFcTvl9L86TGXfz3h2I5veXnsmRoaJ906oGST4XmxlnYx237Gs3QAPMm/+yC?=
 =?us-ascii?Q?4/4pZVlbyjUr+pQd9x8X47X68b9rD0+is6YDCQpuKDGAXtlOYiIOjGobq/9E?=
 =?us-ascii?Q?SXixV9eZVrnSsllW5b/EGHcbLgK1Egfpc07eOkAMymulJTcWd53zYXAYjBt9?=
 =?us-ascii?Q?dU/bJJVLt2f4WFkchNSNCuh3TpUn75ZCOm/3kyITFsCitZ1iX4WY7Lo+9sEJ?=
 =?us-ascii?Q?yEj3lFBhayZNNZAeBqn44hcolrzlH0xqSqznJ13IW8zFucI/g424WniYd5Ys?=
 =?us-ascii?Q?CHaJT4FP/pUvaOi4AF7ON7y0lwmupzx0YKbOsjhukgRYL92L/4xil6sVZeOz?=
 =?us-ascii?Q?NUkvNzw383n9iX1efJb8uwnNt5ecEleu7sV60bboww4kRy75g9dvhk1G+tKX?=
 =?us-ascii?Q?Ej8zmcOugdaY7aRFim3mdUphh/YRbCUEiYAB2bVffx2mkUcwiQmqPydjMdub?=
 =?us-ascii?Q?3JjvvY9cRtdw7sCPovG9NMOeQB1qjZSY4pPf2Mw5D1zLNODWCwKuUdnExuSu?=
 =?us-ascii?Q?hs7idMjZ43BCg4IGBmHYl0esQopHdcOs6yrCoQtpVpdsIiIO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d19d40e-5091-4566-0e61-08da4f457d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 03:08:29.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jy25VhmrWg3msJsmPsEpR/lmjZ2II2Zysf2CNrpUkbRrev3ZXAeawMBYE+/pX7HZrQBUzw0D9itCA9tnPn+bWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2237
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
>=20
> On Wed, Jun 15, 2022 at 03:24:03AM +0000, Peng Fan wrote:
> > Bjorn, Mathieu
> >
> > > Subject: [PATCH V3 0/6] remoteproc: imx_rproc: support i.MX8QM/QXP
> >
> > Please give a look on this patchset if possible.
>=20
> Your pathset is currently 3rd from the top in my queue.  As such I will l=
ikely get
> to it in the next couple of weeks but as usual, I can't make any guarante=
es on
> that front.

Thanks, just hope could land in this in next tree, and catch next release.

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> >
> > Thanks,
> > Peng.
> >
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > V3:
> > >  Drop the dependency in V2.
> > >  Tested on i.MX8QM/8MM
> > >  Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer  Dro=
p 'reg'
> > > property Per remoteproc maintainer  Drop mcore self recovery, until
> > > we land in common framework support.
> > >
> > > V2:
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
a
> > >
> tchwork.kernel.org%2Fproject%2Flinux-remoteproc%2Fcover%2F2022030910
> > >
> 21&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cff2ee8dad882403ab39f
> 08da4
> > >
> f0fe8fc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379092269
> 99668
> > >
> 234%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJB
> > >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DSEnpWxX1
> mTgDMPe
> > > GSGk%2FP6xJyWaTT529oh2SLTFK%2FjU%3D&amp;reserved=3D0
> > > 18.8131-1-peng.fan@oss.nxp.com/
> > >  Depends on
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
a
> > > tchwork.kernel.org%2Fproject%2Flinux-remoteproc%2Flist%2F%3Fseries%3
> > >
> D621311&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cff2ee8dad882403
> ab39f
> > >
> 08da4f0fe8fc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63790
> 92269
> > >
> 99668234%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> 2luMzI
> > >
> iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D%2F0f
> xhWEg
> > > %2FyqMhovh8UCaig%2FnN6FGYR06FeOtMOpGXb0%3D&amp;reserved=3D0
> > >  Tested on i.MX8QXP/QM/8MP
> > >  Addressed Mathieu's comments
> > >  Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency
> > > patchset Move V1 patch 4/9 out to
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
a
> > >
> tchwork.kernel.org%2Fproject%2Flinux-remoteproc%2Fpatch%2F2022030806
> > >
> 57&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cff2ee8dad882403ab39f
> 08da4
> > >
> f0fe8fc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379092269
> 99668
> > >
> 234%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJB
> > >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3D25SCYuuYHi
> ZX9Mo
> > > Z%2FSFpyDTEXg8IzIzTNv%2FwQt2h%2BKM%3D&amp;reserved=3D0
> > > 54.3355-1-peng.fan@oss.nxp.com/
> > >  Update commit log
> > >  Drop magic number to get entry address from device tree in patch
> > > 4/6
> > >
> > > The V1 patchset:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fp=
a
> > >
> tchwork.kernel.org%2Fproject%2Flinux-remoteproc%2Fpatch%2F2022011103
> > >
> 33&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7Cff2ee8dad882403ab39f
> 08da4
> > >
> f0fe8fc%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379092269
> 99668
> > >
> 234%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> iLCJB
> > >
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DC9LrnuMK7
> xob%2B
> > > zQP%2BifyGQxSH0YRbuJl6dsDc56Bliw%3D&amp;reserved=3D0
> > > 33.403448-4-peng.fan@oss.nxp.com/
> > >
> > > Peng Fan (6):
> > >   dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
> > >   dt-bindings: remoteproc: imx_rproc: support i.MX8QM
> > >   remoteproc: imx_rproc: support attaching to i.MX8QXP M4
> > >   remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QX=
P
> > >   remoteproc: imx_rproc: support i.MX8QM
> > >   remoteproc: imx_rproc: request mbox channel later
> > >
> > >  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 ++
> > >  drivers/remoteproc/imx_rproc.c                | 222
> > > +++++++++++++++++-
> > >  2 files changed, 231 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.25.1
> >
