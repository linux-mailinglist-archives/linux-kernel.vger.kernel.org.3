Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3768B598585
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiHRONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245717AbiHRONS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:13:18 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC61BEF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZW903DVKQkUINnpVZ2Jmzqs66BnfiMbZUvEMO7v+1xYmSDoX+WhBjcOlVFT8E8f1Si5wlRHhtiCvJZiEs7j4AP5WqjbxrWMJ80kOG+fJryg8b57p2mqajL1+DABV51ryzUe+FNTbfw+69xROOMAYSKu1nJ7iRaaW17RIJ+6h52gOGPJnGo8Sp51FllmpI6Sz22b5CBWncHDgkUDCr60Zxdgz+UuLPy1GbozSwp3gsEd0+U4wLkFlSv9lLQ+KnjDDcKL4xuOIfndvyHTLywEqewtIgj1r9aADeI5inqIxkIH8UiDrvaeJjB0AP4iWMzf7JGVrQnKSlzWNzUoqL6tcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NT0Xf+QI8Zgjrg9RLHEaJU1FR1IMBVIlWP2h9LZEefc=;
 b=RloFAVl62/eBsrNfrX4MyAzRbPNh+MKSGcMuvBDI+lx5+DCvLUHgeazsfyl4dwwXpWOI04ZKUraB+a2giJ0E/2Q9/wwe4G4SuFt9bfRuWkEN9kors/zDflyAsi1Aubc1NpBu+pwhYoQ20pLAplijudoi/LLVAs2/5GxFows7PvRpHNJ5KNl82FbTbUZl8DpgIqidFFgvOS7jaExUKhXz7FXD209+CVO30g7ftEV216VnRhGVLjqB6ORoOjGjAFqOv9rRQU/XNqKdh3LCAraMo0INzhxPw85HiL6DcSwdRp7v65u+cwNPRTC40sI7zcPOo8cupYTUkvmFpjKHPMCwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT0Xf+QI8Zgjrg9RLHEaJU1FR1IMBVIlWP2h9LZEefc=;
 b=Am+4shNf87lTKp/yYR2izXnp5qcqnu9cinRt1D4FSrP/JbRSioxLN3qG+lYhXUhEpD7vaCYxJhLD4l/KyTT2vfbqIBgM3W/1AgHk9SnblZ/HFuksYAH4t8FjE4fXDydETNACZeiIbOMOY3m/ky9iuU0A89gqlCXn+zp2UpYM/a0=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PA4PR04MB7904.eurprd04.prod.outlook.com (2603:10a6:102:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 14:13:13 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5525.011; Thu, 18 Aug 2022
 14:13:13 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Topic: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Index: AQHYopBXddIttVt6zkGyOalTC33MGK201CiA
Date:   Thu, 18 Aug 2022 14:13:13 +0000
Message-ID: <20220818141309.ifl3kddmxojqc2jl@skbuf>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
In-Reply-To: <20220728144254.175385-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09dd29bb-a011-42bb-7b17-08da8123c995
x-ms-traffictypediagnostic: PA4PR04MB7904:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aFTB2q1kSOcREtocF+cJBf7wAnjDOyNpxOa2s35+JIxy+Jiv5DdeblEdjxG6wmlZuUv2p2mx4lz933LK5LwF1BCmcFkTuSx6tNcEbnoH7UIOsvnQBnfpUt2U1wnrnFJT+rBNrtJsk+lyAhBWkexexID9rWO1iuLK1mzT0N1uivK6H8f9QMpyWCHel4V6due85rsa4hz9FFKxiUrQom/eN62FExORRl8I5BEzY7S1rmGtH5wiIyYHJC1RUW7EPEWNLScoEVQhN8Y0vLfkY2RNkAtYJnYr4tzZDSQASR3TwqFozATixrfbEeBVvIVpNKCXQXOBYEKiUB0bys1uZYk5z38AhZ2YrQSCIMsRviiZ+LB5+ced0Al3WQdbfjf8MqCHBdOUttGAc/9SJPwWA2nT/K6sfwkT9bY8GHyCY5xM3Fkz61bgINPvDDrIGpO/g7rixHw2DOsn+WGczS593K6tVCMtkhdcozpWr4j/svIUUVucoTQ+n744U0YztmIVc7FdKJ3vF6wjig2WkWQwpK1cJS5wJsVA49hobz1GVHlbPKXrkftnug4u68UpS5X8I2rJ6UhPS7lN+5x9rIOpZgsvSmPzcw529Gi3XGX2QiIj6BBp5ZO4sNmCmFkfqeZUOXpcj8eYB1HQHGLmy0WOE6JyhniHl7Wq5B1+grxksaOjrL+VwK10TEcuvMXGPj3adIhrmzeYFaolGVjRgW6JI4yEZ0wfc/MN41gRl0bjkqc892qfKEmDLW7IULvH6U5OQlaS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(6486002)(38070700005)(76116006)(4326008)(44832011)(83380400001)(2906002)(8676002)(66556008)(8936002)(66476007)(5660300002)(66946007)(54906003)(64756008)(6512007)(41300700001)(71200400001)(1076003)(26005)(33716001)(66446008)(186003)(38100700002)(9686003)(122000001)(6506007)(6916009)(91956017)(316002)(478600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lc2Zm1FZnFZsZsiWHwjQBNCnqJmUaaUitEJ0eRKT90ItMrOmawRWTDBqEAVo?=
 =?us-ascii?Q?rPf8nziHFI3Igv7lopmrI4GXuCg6sxOXzUhEV1tH7IzuhCBymYdietLAqHYa?=
 =?us-ascii?Q?gTGNWzEHS1b2JyQyMonKYT9dbVDFdJ2FehcBzzfZ4hU2QGouDwgJyCXAbuux?=
 =?us-ascii?Q?AZWidyjYMCr/DZTaq7q24DQF7OJGdcNlTdomGVpS2RGcqdALvsGNKspp3IVW?=
 =?us-ascii?Q?0kPEaAEvMuTGuKdJkuDd22x9ahpdjq3YIma4DByXjklB3hl32G94isHGpq/l?=
 =?us-ascii?Q?Zgm8Ronz2UStoyQfXV2O55/IFVnmiq+F1nzlXx6meul68xzzu4aDToQCayEq?=
 =?us-ascii?Q?w0ydEUARS36nXWTSZcE5+tdrQyM4o0ZzWuixuIB0eSLoLywR04mPF0AcrvJO?=
 =?us-ascii?Q?sglwvhyp5w09FmWQH/c0WZIxaYGjoTBRaR3so481GOeL80ikkY34oPBMGj82?=
 =?us-ascii?Q?1e8Sqdh1dcrD2+VIMJ2hv5jY6OhhvvojLnQaRl7V6m9hqIvCJOtN6ntqU8a0?=
 =?us-ascii?Q?AZmGZ5Nr8CTCDkVj48T1kVjWODJ7He+/xXNnAjT9OkKv5ffuAOVc+VA0WXWa?=
 =?us-ascii?Q?rbWcCT99Q/JQM67HatswoCbav3RbrcAYV4qdsuYMHxYIRXPaDQ1muugbXJ+n?=
 =?us-ascii?Q?am18eIW7MmBmeiyK9UJ59i3FnG/MtimE541QydTE7A16IbicXUsOiW8WeIsL?=
 =?us-ascii?Q?92OugbIzSFnErLweoN8+unMJLbS9YculZM0C+I/H3vy1qr39oxSxvIsniljo?=
 =?us-ascii?Q?MAW8CjTECYRRcNeqNhpMipidapNwhxhPvUmN80rdMhQ25ZzFWr52L/pQfh/u?=
 =?us-ascii?Q?IF1P1M+vBE7TcjmyZFJmLRjKbYjOV8PQmcdoA7U/65eNfhSqrjJbp50zYdLM?=
 =?us-ascii?Q?g1RshisoIXl81meZKHqGGNnjERnVo6H14y0H6Sv0Orn7rqPaqZMJg183EqrO?=
 =?us-ascii?Q?O7uZJ435DasMSvYoBpIhpQrCevDAkeYsF6Y8/aAM5Mt0cbalClWK/MilmSzC?=
 =?us-ascii?Q?3X4FUG3vvAn3uEhKmWRayMlP2huCqvOY03HodnCwlLsQwBXVMqN9lChL03Va?=
 =?us-ascii?Q?ApO7zM7FjnzyUL74dHHrK4d6O5B70gC8DnhMjhNelMpgC2gCNgl39z1Mihrt?=
 =?us-ascii?Q?m5aO8ZetYPzXbGnTW8D+nDr+mQAJ7cYuSbh+Khd22Vu1Hf5netUA7UPPIYWy?=
 =?us-ascii?Q?TvaBcvGrzLbzjzLgBuhoS+gbDaQalpl4OC35ZlV9ox9bapGWHt1xvm0YmgM8?=
 =?us-ascii?Q?9TwWO8z08vztDVy/dSQqNsn1qACvMiHT+PrjAAFKXR6FiLPtnea3vrp0Xowy?=
 =?us-ascii?Q?vS8ENgrNhTbVeaQwwhwU+OxKranTzICvUnbtS/eS8Td8VaeH9DnemUc2AGRB?=
 =?us-ascii?Q?TG6yio8swgGETjgvsdrFTzFgglg8FOCPRNLdGXTf1SoBkKQMMyk1LtqAe6ua?=
 =?us-ascii?Q?n0n3YOGlXQE32d4GpH3VUwz6t1Mm82qpEj1iHyGA3iLwX7E/ze6tEqMmw6F1?=
 =?us-ascii?Q?k1iB7Ew5uNEapMOij/wWfeU/+HlaWxosDnKF3G4bQkGCERCUkGv13shrtixz?=
 =?us-ascii?Q?p2e/dGyMlGGXPIhdoyhM2ycHFGg39OdJ0DplZV+T1BM3y6REHamz3tuja01D?=
 =?us-ascii?Q?0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <606E61399BF8AD48A82A091CF8545209@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09dd29bb-a011-42bb-7b17-08da8123c995
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 14:13:13.1576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vdyF6juNWY2YJhvujSrQ+aL6VNoh/64ygbEI3O+6xkiDgf3wl6LmxGThpezVs8mQpY+utz69KtoavPahmRyp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7904
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 28, 2022 at 05:42:54PM +0300, Vladimir Oltean wrote:
> The irqchip->irq_set_type method is called by __irq_set_trigger() under
> the desc->lock raw spinlock.
>=20
> The ls-extirq implementation, ls_extirq_irq_set_type(), uses an MMIO
> regmap created by of_syscon_register(), which uses plain spinlocks
> (the kind that are sleepable on RT).
>=20
> Therefore, this is an invalid locking scheme for which we get a kernel
> splat stating just that ("[ BUG: Invalid wait context ]"), because the
> context in which the plain spinlock may sleep is atomic due to the raw
> spinlock. We need to go raw spinlocks all the way.
>=20
> Make this driver ioremap its INTPCR register on its own, and stop
> relying on syscon to provide a regmap. Since the regmap we got from
> syscon belonged to the parent and the newly ioremapped region belongs
> just to us, the offset to the INTPCR register is now 0, because of the
> address translation that takes place through the device tree.
>=20
> One complication, due to the fact that this driver uses IRQCHIP_DECLARE
> rather than traditional platform devices with probe and remove methods,
> is that we cannot use devres, so we need to implement a full-blown
> cleanup procedure on the error path.
>=20
> Fixes: 0dcd9f872769 ("irqchip: Add support for Layerscape external interr=
upt lines")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

Just checking in on this patch to make sure it hasn't been forgotten.=
