Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7281151B50E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiEEBMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiEEBMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:12:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9564F49263;
        Wed,  4 May 2022 18:08:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cf1FzmjyId4qV2HDUqAEJk73rcQ4I5sjNQydLof3EzW4YAPnOkL6RkKTKoiBFfNVwX41GDWl+zWDowwDHzB0yCPquk7RDdVKEwwlcOW1LcQBell4kRDSzYTMWdTcoRxGIucIXEtOTz4OcUfY+lmqih7CLRt3S8iv28dNPiT6nWQaEWek55lQ8IqQhBsVyS2v+o6sskmLpDGTtGomJbbwfH3Rl2QdeJ5ss4znPYywdDtt/JJ8zEiTeDQepgCOhjON+quy+N8CLlCfexzv7J6oIn+tLiCHmrEmynqA58dnW5a3F+VZvUgNC/NbbQ2QbpI9MWOhaKmg5gu+HneznCoYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahucBHgU3i65+gAUw+dbvqg+JAKEm5Ficssd99+5zOk=;
 b=LP6diCyljt71yKvPVt5X0PGrfCOP7U5218C0GCEnw/kabZh7d8aWEe6AdMJzbhjdlaUE2SNIkrk29Er/XugT05wxa7bXU3mzM0BTbV/5VcarZfbJiqY9El2CtI65uAGJE0V2fJh4qjAX4FkqzJL2tnshlHFPjiiY8mQTcl3kRzLfmls4752uhXSc6Ko0Y1e34SlDfJctnyLOa4uwr716748sk1EIytquGUIEqT7sKsfGBb3FsWhrWU9DkIqykKaDjdeeKrnja8qrVAJKidfLEtl35lEqMtbW2XTSCDbBkbqjTDz4wjrzWnn36JTXsil77sQ1FIdD3edk6QJXOZ/QCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahucBHgU3i65+gAUw+dbvqg+JAKEm5Ficssd99+5zOk=;
 b=RwGuI30dOhTW/WaKTwQ5AYdu3ZLqS7xaXY8dwP/uHanojQEeKfmkEhoaCtgixMaBNtAUGjqBZc8NgrlLJavQ1gP7QM9ljSD2Qi9R72spFxau7WGV1SaDjaS5lC5hIarsgdXgjEucJE7750+YOnlbJM85YbCI32ZEY1MZlJ8JpczLqO55Iy+awtL+9sHfc7lI81fOEDN8rUisAJz0JbtrJthm7eKeCUhkjNkWxsFn+mOii6GP8dvSI943IZr4DxoA6k8ltCNEBmqfRDjtpndS+6pvfsdVlAbIFSuan+0D/ZqiDLkc2fefosWtLvbznaMFEaU+fRXbwZNpa8YB/4C/Tg==
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 01:08:25 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::f51e:2bba:e1ff:e7f0]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::f51e:2bba:e1ff:e7f0%7]) with mapi id 15.20.5206.025; Thu, 5 May 2022
 01:08:25 +0000
From:   Stephen Warren <swarren@nvidia.com>
To:     Rob Herring <robh@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 14/14] dt-bindings: reset: Convert to yaml
Thread-Topic: [PATCH 14/14] dt-bindings: reset: Convert to yaml
Thread-Index: AQHYSpaIh9ucOZgHh0OebwRy4ISjLqzk4BaAgCrByiA=
Date:   Thu, 5 May 2022 01:08:25 +0000
Message-ID: <BY5PR12MB55444E24360883E7AD731E77C6C29@BY5PR12MB5544.namprd12.prod.outlook.com>
References: <20220407154338.4190674-1-p.zabel@pengutronix.de>
 <20220407154338.4190674-14-p.zabel@pengutronix.de>
 <Yk9DtXO/yUIO45gN@robh.at.kernel.org>
In-Reply-To: <Yk9DtXO/yUIO45gN@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b25f4692-93fa-44f9-7ab2-08da2e33c182
x-ms-traffictypediagnostic: CY5PR12MB6057:EE_
x-microsoft-antispam-prvs: <CY5PR12MB6057F683DEDFDD200A639548C6C29@CY5PR12MB6057.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: toYRqEHi5YU+8V48UdqqnZPmL24kIJFfRy1mJzWxAdwBslKSGJe58D4QohEE3buabL/fmpHcmn2Mn0R6gEdybCH+OUPgP/XNHcA9WAv5CYotqL4ppCxKUKnaKaDDZ1WaPuNpEJ9RzCfqiswCzSGPkZNVIU/oHk+rCs9W1232BGuLIGjG0NUcVL45i3EhK5IaBR99iy6hylE1BnBxlLcy6YkYBAjxejaSlYha908J6A57lQMQeVHpi/vjbcvvfrtyjb17bALE1yhFHmtD4AM9e86TAifFMEievrMoCsLlhG8sUiZk0gT20kFRHsQ951MgYjHyfwRXA7PWGqkTbu/klema7hiHvT2ObMSEJ/Nl3TmLrN+z773aai7kfauG/xQLz4xjiEbGU7Lh3j/TK+ur0syGXJij42eQFsc8SDDY3GT5g0wMTpOpHxsY3jtqidUm5LfuBOsgyFlz9H3uRh1I3dJTq15ZEDVVjuMgKa0WpJYcSzw0g29HwW7lkRZSY0XlIZ+RR1T9HMYwS4GurCpIiexfy0cJlfZy1F2jd1KT7hjYU2uh4U1gcsqstz0fqEQgoW1SkDji7OU9dNvt93lMrrc4CbEbw+KB5iAaHgOtVLjgv+8rgEEHLT7H8JVS34EUVgzjzEg1GGGCStaituj9D4cZqBY6YkIMDIvVVahKT7jUAOgINEMYRG5tpR83XaaZ2jbLHbbO0mXsImX5ys89KNAVE5qJ1GowBpqzxhbGfLVwXCSOa8Qsz4qqNdUJB3Pm4nE7IbjVWgkfzuv+LweaCdaNnDOobA/NTyfEvnkD8hg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB5544.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38070700005)(38100700002)(45080400002)(966005)(5660300002)(122000001)(52536014)(508600001)(66946007)(64756008)(66446008)(66476007)(66556008)(86362001)(4326008)(26005)(9686003)(8676002)(6506007)(110136005)(54906003)(316002)(76116006)(7696005)(186003)(55016003)(71200400001)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BLy1kys/B+J3trT3w3fCjSDVN3JIHb89HowGqdPdeUjCwEavva7Iarm8C3GJ?=
 =?us-ascii?Q?1fiScdDxCYGE2vUAc7IE0uVvE/Az5uEBZjyh6tnLOD7X6mGNy39B1LU1WCds?=
 =?us-ascii?Q?n6YfuSB2Aag0pgQL6Uwc0oRResEX7X7NnO8WQ4t5344jMKld7uuNvpPlaaOK?=
 =?us-ascii?Q?UmPu5QuPbP2xAd1pi4O/C4Ac377Oz70tbe/DxdNvs+zv720hDK4n8wRGcVlR?=
 =?us-ascii?Q?dFtv9RX0hDAY/FAnDzVYcOCLPOpPVElG78LgoNyUwKHLr6Zdc8Uivpve7DIY?=
 =?us-ascii?Q?ARlg3o7SWx+i8Bgl3c5xEfZZTOxO+Klmy2bjyUCmhzJ5CKDPYAsn86HlES3t?=
 =?us-ascii?Q?cUYg4Egr5OWorJKmjeNLMuagFjdgX+nBR+7c0UtzmDouDZOYIZlcjik9GPt/?=
 =?us-ascii?Q?aw9noLREksTibYtsKKc925uqjUT9Xyyr7F9zl01C6gLF8KCHgPS/+BlCghKf?=
 =?us-ascii?Q?S3iwqLxi7soi2iqtuFzKHAZ1pnsoRqy3g8ONdqC50fx/AdppM3NNEjZFYD/O?=
 =?us-ascii?Q?Hb68vmMBVvIw8q8zF+Jme0iRFr+XW6jfh6/LZqW1VSvf9zpm2Dl0w0oI1tGz?=
 =?us-ascii?Q?oWIU5Gm1bNMCZa6e+N/4Id1xgqTeirJ5ie4zP7QS0di6awFv6AUfig28xSpL?=
 =?us-ascii?Q?DH8He99pa95zbp+blHEz0ASFpKO5DhuXeMbTrxKQSEDmIa6qPaS+qyPdTUbM?=
 =?us-ascii?Q?6xVHY7ArnVCTxdVoGxGyax3QSO+x1UeQkVWYDNNva21+IKbxnKOjLUcBDsm6?=
 =?us-ascii?Q?T2UXvyKlblml4kS8jkgdVFEPH2kW4xYXo4QsBCjjs2c4rrHCRjO9/l9C8zLh?=
 =?us-ascii?Q?b3hM6ACu304duhrwaZ0Uk04EdYPHbmnYC0rAEXINmP6jL9ZYTKdYzflzeEK9?=
 =?us-ascii?Q?Oj68eKdw1y9VrWutUqa3yyu8LxmSc42Dn+Y1smUWg2AC697/96GJsvYaU0Vz?=
 =?us-ascii?Q?/SV9ewyQFECZ7ciS+4m8u8KTPzGyTjpCoURO05ZkVmDpXFjGFbQqHH9b3aOy?=
 =?us-ascii?Q?TMlPf3QzVTyMiaxgqfvmyeMYDmyeJXQO4rRmgIyTqMk18a8X5jWKoPwtGlzu?=
 =?us-ascii?Q?+63WWpO4/SRkydLncD06MwKl2IEKhjfxJuUQGIXrrLOZOZ6uD9mDAZwnxZqS?=
 =?us-ascii?Q?HhB41prssJYpJwKHsD9mSnIC+EINCNXLE4yVYF9opd64tiKg7NLHd/Jh4/5X?=
 =?us-ascii?Q?oavq3AYqnpCMcwyeGu6kqoaJ02fev39ooWFeAvRoshXVXTRGx9veHzBHuQCX?=
 =?us-ascii?Q?bfB8FSPLOqCpZrCNoYXXKa0BWvyRuVC9PZytcp/PezET3Q00OSQQPph1CCK8?=
 =?us-ascii?Q?NZ0S3JXN+k2hln4LpRm6PNqaCl9xh2ec7pwAJ8Q9YNqA4VzAt3wlVaLxO9C/?=
 =?us-ascii?Q?f43IpLmjQwdmAt2OaLiOn1/QEiu00BZl5gQxZ39GtDktxOfbOTW4w37eY8mM?=
 =?us-ascii?Q?u797ESP4NDtn6Mgg8LPUWjJzNYngz7aL1jEKhQltH1WqstWultt48a6Pdh7+?=
 =?us-ascii?Q?l3S1Lierd5+g3RXUTKKw9Mxe0duWtBc2HLBfRMHcAufTMRRbGVvA96TWUH32?=
 =?us-ascii?Q?50+BdfdPhKH96ywgeo6tKexHWqXK3/OxhMaFfL1GUqXX8jAevbKE/1VTonJ0?=
 =?us-ascii?Q?sNhsb6EWrW2AD93o0B+hl1TMHqDRLTyu8V29xl61YvOhMqtlyeY62vktvRjB?=
 =?us-ascii?Q?xGSjIEWGA8LOOMMyzbRqCTsJWaWoU1AWvsWIwKiqGcelWKJCtJFIho8VjM9M?=
 =?us-ascii?Q?mI+PsMllMQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25f4692-93fa-44f9-7ab2-08da2e33c182
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2022 01:08:25.0797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/XObAAuBaAFF/kbdhtUkmqhPntTFffRkVERKSW/1dNOErwZjJJbp7T7bKIx6uhdLGRF0tAeIKUEAlVRFvmkwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> wrote at Thursday, April 7, 2022 2:04 PM:
> On Thu, Apr 07, 2022 at 05:43:38PM +0200, Philipp Zabel wrote:
> > Convert the common reset controller and reset consumer device tree
> > bindings to YAML schema.
>
> In general, common bindings should go in DT schema repo:
>
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/re=
set/reset.yaml
>
> Though part of the issue is dtschema is dual licensed and all the=20
> exsting text is GPL2, so permission to relicense is needed. That's why=20
> the schemas are just the schema and little description ATM. Shouldn't=20
> be too hard here with Stephen/NVIDIA being the only copyright holder.

All the work I did for NVIDIA should be (c) NVIDIA, i.e.:

# Copyright (c) 2012, NVIDIA CORPORATION & AFFILIATES. All rights reserved.

I have checked with NVIDIA legal etc, and NVIDIA gives permission to
relicense any file they hold copyright on within the
Documentation/devicetree/bindings directory of the Linux kernel source
tree to MIT-only, e.g. for inclusion into the new dtschema repository.

Separately, I give permission for the same; some of the files I
added/edited in that directory were part of my job (generally Tegra
related) and so covered by NVIDIA copyright, whereas others were part of
personal work (generally Raspberry-Pi related).

My apologies if Outlook/Exchange mangle this email.

--=20
nvpublic

