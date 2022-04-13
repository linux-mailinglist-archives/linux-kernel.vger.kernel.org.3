Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BDE4FFEE6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiDMTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbiDMTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:14:04 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50041.outbound.protection.outlook.com [40.107.5.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A84888D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBqyUUjNyhgZjRb/2sM+cWJkWVTYBa7Q3YwfLJAMCOtUT1LL2nfBlum3hQBl7ccphaw1VwuJxRHj47V1K98N6OPKEAmcenJuP5HuwITbKxY/IrXbgnJkA/6evAJTgWze3hxhEX1tPHhOhtY5iFguVet8HvV6hv7zU2wT7d+NXUOzyFo9lmPNeARuILrL8G39k5a4CKv2oWYIbQEVGt/WVJwKt335Ep8bAXVdcZ4SvMynj6mVPXfWUCDqDNUYeEz7BAAmv9s8F/NfmepZFTkX2rwoPaW0l3veFdLJHAo0w65wrarUHMqIibu/Bc/4FbjKzuIaxABjzZnxXioQR7Iuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIluowPKVxSvQ40HDxi45aCB+3/b1FTZlXwMfZqrxGg=;
 b=QZ57nW/HgoDTz6JqiOC9ZfyCv4DkZu0bQDWLrY2bBOPAr0vvWinEwyNzwf/HbQbPek1wZE0LOa/AMBBNAXLOnEU4kZ6kdXEBo0Mw4+udB48UNYvjIQZciUO78PXSej82h7WToDQYW03eFKz4uguDLTJWx8fDeKkNLz5gAZ8wkMEXGEWH/4NTN86hBsdchxUMtrvzu9LDN0ZJ7ObkDV1+v3GTLW0rLBTU2nG9J0IzkClQ1A8etNCziDqGUzGWUwhyDwWaDFKt0QS4A8RW9gwaHH+Oqpjju6FLut+bJ/SoTW0dzqvfngN1L0tACtFIQbTZUTP96ahoVEu40lkaZzohug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIluowPKVxSvQ40HDxi45aCB+3/b1FTZlXwMfZqrxGg=;
 b=lCpsB7Ok4h6gtRgEZnSOch/gPmB1rFg4csZfwREfA6IN3gYE70XgeYBWIB198yGyng8IOMAuEKrwUAu0epuqnHs9D1MBDd31IDIwpMWxOLLETRTb8v81hByxTPNTHdEkziWASsVK7w/gpPaKOHdo3EEIJ8u88aaz55xFco5VLrg=
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com (2603:10a6:10:2e0::13)
 by AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 19:10:33 +0000
Received: from DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8]) by DU2PR04MB8949.eurprd04.prod.outlook.com
 ([fe80::a074:1c67:a763:25b8%9]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 19:10:33 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Vladimir Oltean <olteanv@gmail.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm nodes
Thread-Topic: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm
 nodes
Thread-Index: AQHX8M2Qp2fR5PuKkEeWcFzMp8XOI6zuxrMAgAAZn+CAAAU2gIAABtXg
Date:   Wed, 13 Apr 2022 19:10:32 +0000
Message-ID: <DU2PR04MB89497E16D2E9A01BF763D92B8FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
References: <20211214093240.23320-1-leoyang.li@nxp.com>
 <20211214093240.23320-4-leoyang.li@nxp.com>
 <20220413163306.hp5qyxxgdlekczet@skbuf>
 <DU2PR04MB894984A336667EF01DF709988FEC9@DU2PR04MB8949.eurprd04.prod.outlook.com>
 <20220413182327.lbemqze46eq7ulfn@skbuf>
In-Reply-To: <20220413182327.lbemqze46eq7ulfn@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67ccc736-8997-41b1-2c69-08da1d81487b
x-ms-traffictypediagnostic: AS4PR04MB9550:EE_
x-microsoft-antispam-prvs: <AS4PR04MB95504B866656EC1D8C5C575F8FEC9@AS4PR04MB9550.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6tGFeU8gS14b2FpzTznM/O9I0IEJ4yyng1oy9ixMKukYpaU3kGAs6ummcZ+Jmw8l303TOtAbkd5NksNDZlYRcw7E/hE/35MJquhU25xcLHY1Yx2AetAoWv+TauF4eVxtoiqFTiT0Ys2X7XJkL+bTql7jlyIxVvvGRpDSrDsjJG1XuIo09UjjQdoMiISJIjC/5rO6JzUh8l+YpEPUsjq2HBaQSb0fEgZsXQLOMb4z7NyfSaW88tcL3jZ32zx4VFVoewZsd+piJkkxLuLC/hOJZqaBYIVHR/4O0ftzsYVNV2wboUd5S26Dmv1S5au4i4Aevig8nj0zhjh5yammzZ61BtGOZGefBOjXx3J06VDtVpDUXlwrV7FjN4Ks1CeS059CANTsgoOc/xB8gAm7G+Onn0uhDtQyvQARVVjGlW+LW4qjaDUzw6c6uhGVzyROysB86gAs2eghOIuEp5YW6FoQmymPeocPM48WtoXcHue7UuG/GTWdZb7IhIFvby37vIpb8L3wk2/uYimSh7gCg9DQ5m64L80oEWiacXjx4iVkYgcYvq9Nbz6GC/igTT9nHHG6l44eGaTAcPxGsR5KV3srGF2zJFeXf7Im10UDxtb2o0j3F+qPdG1hgnJfeEjaCiQdJYPhbybfABwcDPWfITBfbKdnYupDz8MoXxvItLeJ2aovNmL2tgdQNCBKXX9RSlNVofVffwHmkbTRm5f5+ODjMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8949.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66476007)(5660300002)(66946007)(66446008)(53546011)(86362001)(2906002)(66556008)(38070700005)(64756008)(33656002)(26005)(122000001)(8936002)(52536014)(4326008)(76116006)(8676002)(316002)(6916009)(83380400001)(508600001)(55016003)(6506007)(55236004)(9686003)(7696005)(71200400001)(186003)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vgywZujoGJQFpitU0sTgeG24vfQzroGDv1K8Xj+S8uenfnWV96pdRl/bYFSw?=
 =?us-ascii?Q?uHHUy6GrgDduthhSXcEaKycvRSOTq9QRKpcc4qTNm59KL33Y5x5tgQYCnt2W?=
 =?us-ascii?Q?I3JkLYB801TWHDT00gMUdOr2HFxpMHL8dMaDedTvKqTs1gP0gMKht+j5yB/h?=
 =?us-ascii?Q?81DzY5vi9cvvMMnaUtSJ3SvWTtXYJmEg9EbbgIttF2ef0UtHSyu42L+peVsz?=
 =?us-ascii?Q?aKeFWJRjbGqQO1rl0l3jHirLdnxjr0rnCec8qXi9/R6EafDWYc0+1z6d/IRK?=
 =?us-ascii?Q?CpXpsb612QC41Eu5tIEgzD+9FiyiHAwrtlwNoqWwIfcQ3qTFm0XNMa9i0oo+?=
 =?us-ascii?Q?4NBDU1erokwCGEUus1Go+oGQB/7TwqeFHOdGbvdei9OTQuPm0EKaXFP6b3kg?=
 =?us-ascii?Q?+J2N0W8sm+i0G6sKQAtP222+md/hKDE3yYpPzkmrySmlFDsrQ4y0hAPvfhKP?=
 =?us-ascii?Q?PYQc3GhcgMETCceut/ClHFFA+/nbKX0iZw5ClvlF8F7oDj0Uzf0jrcPANoRJ?=
 =?us-ascii?Q?6SElM+3pMS2Hg0DR8clicPyDKoW6Q8tbrVbKQ6aeHWUXPxv7h+wDeuxtPppc?=
 =?us-ascii?Q?m9F/5/FyY0VjVJfNCzAQIPDvf1KaEXqLpgwEiuo1GVF8hdgeYWgznWZK8CmZ?=
 =?us-ascii?Q?+aRVeWMchcn1zoOgaZpTQT0OzWDrplRYRRJGjge38LsCuTGxudvxAUMdH8Zg?=
 =?us-ascii?Q?XGwIe9uQhsW9aWwlQdIt91zhMrvSp8E4yAbEydWhwo45wINvg9dtpXVcoiLL?=
 =?us-ascii?Q?1C0s5nwH2TciMGwfe/NmU+XKTwYn3xEhsB9/GJzTkg0hHGSDJgHOefh27Spf?=
 =?us-ascii?Q?K+s8HxHgrpzPRLZgjBtPN9gLTMearJF7WVEpV6kK8Zs6ejWV6aB3B+4LmzwG?=
 =?us-ascii?Q?FRgsjZ0S3Vnf1YFVPUlVyg1HJ5SMYdjRo9BLrw6MeCDzcnACJgBlanYwhpAt?=
 =?us-ascii?Q?ChFtRbkRTdH8B1T1Yvw73umAwh8k0ZpDliXdvUFE7vfDdc5jSM7Kp2vYKtxw?=
 =?us-ascii?Q?bQDZXvJjuNITvM7o8MI5d589YjNGeehqXxNzmYb+f0DLNrG42+roZfZTQ/Ea?=
 =?us-ascii?Q?ESe0bm++m8B5vixp38GSwMvdaGPh2PMocfLUHh6d3Og7BF1eh5vGgQBbho3R?=
 =?us-ascii?Q?9FzfL5RiXGXfYa9K7VXXS4cY5yg/fJ6sMKZEruCI50kgV5JocUWFXWM97pT6?=
 =?us-ascii?Q?3QvnCTvkfmqb6fQpuiHgMNnGuSlsA4hmAf+lCsNmhdfVoA24DMz2e7bYO+Qr?=
 =?us-ascii?Q?XUSAvMwFWksraWRPo2o58QV5Iquinrzoh+JlHUilYZobwE8FLyoAhznNh1uN?=
 =?us-ascii?Q?Nqwe3WHo0skU7ypvV86UUwNSfOQ46r0DBaMVYMlNjJjWYC8Jky/zaPXBRExG?=
 =?us-ascii?Q?FcnxQ2UZ2DQer4IpCQkLei7WnAx9clV2FS20lcLTRebYbGQtfFjNqUE9eRqV?=
 =?us-ascii?Q?UEsGgRQkyu40tV1qnba3sf+OQR02MlW3C+tw2qukIj4UpFD6JJWy1CNbdNn2?=
 =?us-ascii?Q?hXH8bxjzb7Ozy8ixC47nKp2dLedKB4tJZLFOUxX2eF+UFs3b3I/jqiRz+3QQ?=
 =?us-ascii?Q?RB8LvcjDElrkyCYF1fv6KrWY4Z5bW+wqkPqJ8JcWlOnCPY2ECB8uunGre7ur?=
 =?us-ascii?Q?DeNHjZrZKFUcGDvHsQunGyZHEXYqlrEahOs+xWoy0p4nOtfvnk9JlQfQGlmU?=
 =?us-ascii?Q?Ei2euuOUuUJbhgDLhZpgithx9fLVHZVuxWvfBw30p6tqPKkNwOILeuiwgzfg?=
 =?us-ascii?Q?W66+p00CXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8949.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ccc736-8997-41b1-2c69-08da1d81487b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 19:10:32.9427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v25rVTY1tmNOmhyyYfXOdc1oMZb4bi3XzuzOmaigRsUutY6BCZZ9py41HLghYXaL8QdoMOhkjhM6ucXFOaTuNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9550
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vladimir Oltean <olteanv@gmail.com>
> Sent: Wednesday, April 13, 2022 1:23 PM
> To: Leo Li <leoyang.li@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Biwen Li
> <biwen.li@nxp.com>
> Subject: Re: [PATCH v3 3/8] arm64: dts: ls1028a: add flextimer based pwm
> nodes
>=20
> On Wed, Apr 13, 2022 at 06:07:20PM +0000, Leo Li wrote:
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1210.21-1219.5:
> > > Warning
> > > (unique_unit_address): /soc/pwm@2800000: duplicate unit-address
> > > (also used in node /soc/timer@2800000)
> > > arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi:1221.21-1230.5:
> > > Warning
> > > (unique_unit_address): /soc/pwm@2810000: duplicate unit-address
> > > (also used in node /soc/timer@2810000)
> >
> > Well, this is similar situation as pcie.  The flextimer controller can
> > be used as timer, PWM or alarm.  We have separate drivers and bindings
> > for these modes which resulted in different nodes for the same
> > controller.
>=20
> I think the mfd framework can address the situation where multiple driver=
s,
> with multiple functionalities, want access to the same memory region?

I know mfd is used for device providing multiple functions at the same time=
.  I'm not sure if it can help dealing with the one function at a time scen=
ario.

Regards,
Leo
