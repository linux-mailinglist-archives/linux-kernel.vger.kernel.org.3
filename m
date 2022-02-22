Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C044BF484
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiBVJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 04:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiBVJQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:16:36 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10077.outbound.protection.outlook.com [40.107.1.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524EEAC79;
        Tue, 22 Feb 2022 01:16:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx4aZIpanI4zgG0KVVAZh3nvfiUMixMVZaWrAl+QHxmLd5zLIpjK8AgXHY499OpHA/nnOpQ4bg3v3vqMdbNI8gLF9BszRRAuC97tXkIqsvwHnUzfYtP5vgZXoVPrnBXGRSGpUXyVNuxikPvZN6zqFuY8V5ecZtJ6hJ+w+OWkYA4TzmA54CDUmPE2GkQAb2lJ5zGVBhfOWYqHzJfDEniuwoSSpTT45fJgsOO2RC8XLdxK6WaDuE2pyw37EQQNRaq7k00RdzIQPLOltmpg7KA9iEscl+O7TZBDaruQV5MmiLQKwif4XnhBvVPNCkzZBmjfCdy9xxl1y5hek5ZKeINT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cnYTrZ1sPBHYAT9c4PXFZCCHMDwzpiKhzDBKj64ASyc=;
 b=fZDF9QyrekC6abUxcbmrgjO78oxUQhaF9CBZiWnT/TgM6lXy9Vk+BLV7IxT4r8KsyW+ixr6jiglY67oPW2sokE20wUeljClh19tRiY97BZdBPXq1PdPf1uFP0FxFqM9gTabXetiJLaZ9QwOS1aFrjqqVacx0FJo2kaj7CqC3kUbZooC226mjw6aLszv1HOseSyztoAP9oOs2TKuy63zEy3zOVGmpBeDRsNlEHQCP/73mcK3UnxrpIiZy1x3xAmjsrU7OJq0q0r4udMaQLFfdTafJuZGVF1DPqfrNra5gY2u8djKVVSWIHpHieRJuUUFDQ2Jp+phhZ2sdbeMGmjIlKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnYTrZ1sPBHYAT9c4PXFZCCHMDwzpiKhzDBKj64ASyc=;
 b=rAKaPgbLZWIFgGovT2HDB7HYoFhR+cy43KYNtkWjyJ+abfr7qoXlp6BM9VGN5he9SMPk6uurmYgqwjW8yTSB/hDjop2FYiv1zp40DPLhLrxK0KmjnHvfaAJ3umTUpA/El8ekEjiFCd05QgzF02JLGST+MwyL0BT700YbjGIVglM=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Tue, 22 Feb
 2022 09:16:06 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acd3:e31b:a13e:b0db%6]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 09:16:05 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: RE: [PATCH] Input: da9063 - Use devm_delayed_work_autocancel()
Thread-Topic: [PATCH] Input: da9063 - Use devm_delayed_work_autocancel()
Thread-Index: AQHYJO0QGNMFl2HB0kWDeB8U5zES16yfS7fw
Date:   Tue, 22 Feb 2022 09:16:05 +0000
Message-ID: <DB9PR10MB465217CFCA83F9CB7DAE4738803B9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <a76ac3f4c7aee205395b89b5b3f587e30a48df96.1645205312.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <a76ac3f4c7aee205395b89b5b3f587e30a48df96.1645205312.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7684b5bc-3bea-42ad-3ba0-08d9f5e3f497
x-ms-traffictypediagnostic: DB8PR10MB3530:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB8PR10MB3530579CF816A08629F14CD6A73B9@DB8PR10MB3530.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qu67b/Omb1hB02TVwF+r7zsEtu9fYT2cS/rEwlqOKmyrJrI+5sxFYVuoLbnApgXblZmCHth9O4yaVJ9YrgNIfDznjqbcmi/JZrJeSSCnG6OiKiJFVq8zQDTpncNDXckX+5T6d3ZAgylXsPNxTL65ZFUOI+Lu1hqvuPvCnkyojj0BYDJ6U7ztq9/KK10HxY4pHN+UAucdNC9nB9fiXLDqQm782f+27tyMs9o5IpOq7oEsEO1pjogt9Zy1soEi1+tHaBLw3SHBkp3vL/EVbN52CTP92Pjuco6fDf8lQbsQjX6BMD7FyhtfR10fkto2AC9scOtLym5/jz7Ga/lDRBXH3j9DeGE3hfYnSGKj6UhvsLxP4cJNiatZUrE67iMSSS96GKScrW2Xa/gZf6nlsKg7X5B/3Z+/cydbPDqGSd5ZBcNCX9G4P5HOadFMV6Ee0rAqjCxNyJCg1dcnElpVzx9MFJuPVv5ferwS+c3IVvFYqssqBVmRgruv61zUFVf3+eMaM+0/38wHkRskjx+7MzpUdmRhbKH+BgQ23l7oSY37F54CUIhjkUkQhsAEVoDcfBGF0R5027jh4XibrcNZkXq+JWsMrORsD2P5NfrJLgtDrC7gw8Q9LxZaTHyoRcBGout23jlA5wgJiF7rg0J0UIfM74iyxw8Dq7l/nLPXNRdMPuJqG8suKspnL3oycoOVSCmKmbjzZJhk8u4xG3zHURmG9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(71200400001)(33656002)(6506007)(7696005)(38070700005)(508600001)(53546011)(55016003)(55236004)(2906002)(38100700002)(54906003)(5660300002)(52536014)(8936002)(64756008)(186003)(558084003)(8676002)(66946007)(4326008)(110136005)(26005)(316002)(122000001)(86362001)(76116006)(66556008)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z4iw7BzszHKO9bgJwDHOmU2OjyqiwXbpH1Q+TVDiCADHfBhYnGtw771owr05?=
 =?us-ascii?Q?G/JbXkgExjmCwLhMArZl/Ebg3kGXIS+qxgBZWh1evzm0gbbOnBHhHi15eGkv?=
 =?us-ascii?Q?4rd472pojEReU3jeHVjJ7wE8EWMkDUNCGK7sMlRnuppuDoSUG3xlpizlgjMs?=
 =?us-ascii?Q?tMIKP6MzeJskjbIa1puv1zIxVP6JnqNtAri6Tz6RuA2CdpBwaU5bDiePVtg8?=
 =?us-ascii?Q?Z1PLXcYKLjcBozBFlqTwXjSmy95FLPiER3mn2FNJAxa9H11LiHiB9lvXtQGd?=
 =?us-ascii?Q?bJXQ6ybfpSEBWRom+TmVeZ6N78vT+FhjLRvdJsrzCOEuTwjefYzBuaDJoZMS?=
 =?us-ascii?Q?3HI9fr1cYRoj3E1415ow3dOuBCsALGpTAe+URVnYz6y49P/Sg8r81utko/69?=
 =?us-ascii?Q?CPyBAK1QXElGo0Z7yYyR5SixCb6PsM3CUYKGNEbAcGAti8784BgEB8KLSRvo?=
 =?us-ascii?Q?0nWIJipTswu+YFHvRfMfuyVTJZOk+YWVnc4mrkdlVrTMWTBXGEJBUPjzupZd?=
 =?us-ascii?Q?22J/d3dOsy/og+49fSQR03zJxTufUA8f3XgoDm4ghHLRuv40FmcXOT4qrzpH?=
 =?us-ascii?Q?hsSFYtSyQxGqMfAMCr7JO/g9cZmmJLh+tdkckPcVfYhLtUT1j6MeB5AoqP+y?=
 =?us-ascii?Q?KR/EfhB/QDbjEV0w0uhYn8WQmN6+Q+OG5mcsdWHs4X10EmLB7wMyp+EOTS75?=
 =?us-ascii?Q?4gykTJ7mnoyxXKa/jxkC3BKFaqfh9diJeapbochG5Ba0teEhZn9mwIZHvSIu?=
 =?us-ascii?Q?sdijmyxWVtniEW/UZ275tuoTeHMWKiYVp9JL4XdttQzpH2A8QXRtYI71tHXJ?=
 =?us-ascii?Q?iE/Hh2KcvtJ4+UC5/lpqiW1VG+jGDuv6xPQMrDxEA+Gi/izxhQWghlnXtv8Y?=
 =?us-ascii?Q?QWYzEAM7lU54kX6gY6Dsj450o/exVUFcKCs8Vyh3uVaThGDpjSGeGq9NM4Us?=
 =?us-ascii?Q?yOEhCij2RVxIJe6OWZNb1sbw69oA9WJiAMUwshhJlNU5wlA3VSA6gABXG49p?=
 =?us-ascii?Q?VNEXzDKys2G6g+jrCMFIDhDjvpYKLLUuMUHE5+nz9UheJ3uvcQpn+npzk+da?=
 =?us-ascii?Q?7FPlxfd1OosHe3gkr3pgFB/ezD6MdhkigNWf+hB/AXVB7XEyX0EppwbUAtnZ?=
 =?us-ascii?Q?TzIzF5ZMhyjYZpYiz9+IZDQsXWkRyu5IZlHPL7kphQf6z547w9D70N/CrZ8C?=
 =?us-ascii?Q?/jekx6L+hT+z1Jl956YYaDMbyXWjuIrB0aFIbcuS2Xsj2AFl824jCmDzPj12?=
 =?us-ascii?Q?SKaR0ulN2POwrhCHpNEbZ6r2O5QH6uujNsUuZbUpPFPRpUBWUrBbfKWLxLSu?=
 =?us-ascii?Q?efXE+EpUhMdRQobFNFWGCGvSWk5l/XXMrvObvCP2XJS+ZZcPJdgFqxqFNBzL?=
 =?us-ascii?Q?BEAjb80WhiNhF3VlSS3I372VMKQqLI5fmXqbEfv8NliLKKTB2wyaxxWG23N5?=
 =?us-ascii?Q?y5tTYsvfpNUDdF+5q+b1EqZhtxv1KyBmA0BupvtSjdLNKi8Ut/4GHGeJwiGR?=
 =?us-ascii?Q?9pZWXfv2BfQYIo5edFWukb1QHv48hBZVNpcdciDevW1JU7rqhAHyA8YN/zPu?=
 =?us-ascii?Q?fY5NXJhTt8a0EaQr4m9vJU1qKKNWHp7sD+XIvVh1g/C5BUZau+PzRUPPyruW?=
 =?us-ascii?Q?U63kgvXG/ETocPwCOQbbbbK5tDpoX65/WN+pr3DpZe81JCW90auwDx9Uij0J?=
 =?us-ascii?Q?bES87Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7684b5bc-3bea-42ad-3ba0-08d9f5e3f497
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 09:16:05.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+8RF2v+RkbqCT/Yo3Ls1HVcJ3AjSdRa7TyuH8HGKSWLfTqObMeHD8GQfgOY4W3uRgC4qCHEZQ5px870BVanRpzfoGRJMhPHoRDtDhxUWtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3530
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 February 2022 17:29, Christophe JAILLET wrote:

> Use devm_delayed_work_autocancel() instead of hand-writing it.
> This saves a few lines of code.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
