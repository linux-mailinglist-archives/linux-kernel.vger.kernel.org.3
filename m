Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98846560A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiF2TYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiF2TYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:24:31 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17A33631B;
        Wed, 29 Jun 2022 12:24:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSZe/P9o0YnbDOAS5OtBf7VCaJRNXDhpCXEYdyUnMjvRyTkHfAuidB1dT8ExbcGmxtZUMtfc7QgpCklNKZT/O01C6FqFxMOEZKQby6saS4RlF3fIGegsVApOqfuLJqglmGysT4AmTKbQCO+Mm2qgO9nY8RtFPvA8dfcVrWS8BzrOtEyhz7oFFE9RXCPXNJQnXA/VePOHGk3z9x7VvfMlh2QRMsihOfO857nhJcQmpHixW4aaQzZvHft8+D/W9c44suXNGe3By/02OAkN6VvBMANmcxOVGM/5JPqUirVNN42z83p75SuagL10LYmiNHnd89bgABXSOUKTEOPtJvy7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrPNrkqb/gaalzQsFdrX5fe27mln7v0jkepiAOoMfkU=;
 b=oaHrXIrhBv2RWIrYYwcKJffYB0gifTfe6TYShrDLt3xzFRAe4aD4Dg37v1XSDmc9cAx4noULdhrgZ4OBXEWw7kiyL5B2ECJE1LqeYPUs8bBvfJi9FPY7KUZgd0euBbnDfAxs1Dp/r7QTqtONI4eu8h6ZuNK2df3q4TwM5FXBQMy3WHfPEmBs3wgeCoXfQHhi7Z3Emw3CPb6VBSbO/g3G0l1mut8EkB8PjrtHQIZz74PSoT8biLyTNOTETIRFfwcP5RStTkZvM6CUkYWrjV6E5h6C9zJEEBhRUVugA7CJtV+gVOaS+nAfNEx3Nd7kB/8UUVH6dvs1Jyr8Y4N03Jah6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrPNrkqb/gaalzQsFdrX5fe27mln7v0jkepiAOoMfkU=;
 b=lqRLs2m1GOYgH2pK7yvhNzlKUpOa1ZS/WnxBXNn7Fqsz21Z/ODI8lz13qkXZpyKbZKWXSJkV7D72pEhzE+QgTOay1MCcL4Q0hpBcCqqbNVN8LU/i0GGT5R52zNN7kg+JfroRrDzS2w0sJqEsEiNfo8MDNMWOY7f7pl7db/mIWtmQH0VLG7jDCCBGtOMZnC1uYHL1tcnju2iyaEUEOPCLx1lKls9JSqXxdEKTThvOYNpEkxtEZ/npcNM4v1GzTlyAxcK3F4DIwJUKidwcTYQoJhY4z1+VYR02Mm/Or7ud6bBVYGJsRTg8Xb/DRT9JNGphjRwZvLmEH2tde0P7jbXhsA==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by CY4PR12MB1830.namprd12.prod.outlook.com (2603:10b6:903:127::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 19:24:26 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::45a7:d9:1cdd:3e9b%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 19:24:26 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Tom Rix <trix@redhat.com>, "sre@kernel.org" <sre@kernel.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] power: reset: pwr-mlxbf: change rst_pwr_hid and
 low_pwr_hid from global to local variables
Thread-Topic: [PATCH] power: reset: pwr-mlxbf: change rst_pwr_hid and
 low_pwr_hid from global to local variables
Thread-Index: AQHYi+1dkd+5sUNCQkiyjnmcbkLhla1mw6tQ
Date:   Wed, 29 Jun 2022 19:24:26 +0000
Message-ID: <CH2PR12MB3895F8945F37BA4F48A39559D7BB9@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <20220629192045.4107237-1-trix@redhat.com>
In-Reply-To: <20220629192045.4107237-1-trix@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9bed6a0-3589-44a4-fce9-08da5a04fae0
x-ms-traffictypediagnostic: CY4PR12MB1830:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Za1gR63rSVU6vXDjxxNVoteM5H3fO6VG0x9w31ad2gkiP1fVZqxp+F6Ou5lJ+AWXOxvGA72pfm2U07lL7nr+jlfRPX9KUmIiHCs/lButL/a7CoDkGdGDPEr2ua6xPa1Jy1e3CTUKDF/OCDjeSkqWts0f5+xPCSbotZs7Y36+5buaJ22B2lT6VJzxp1OTctqHgQi8TNLf+uWf+/V0uz5JkCt7yXUWQ3gQExXdAjYw067vol7umQJ8EX2XkYhlzAkqogggIRsmOhaE/KPm534EOEw2+XcJt09/jyoOBHzEP/2os8UGHRPkOvfT83wxG3RJexoYA9h7zGwIUhnagj745PabLTFKeLNV+I4l57ajJBQa/FmpNi+FElzMqh9c9qpENV8JdNJZqZbjjYmWFOW1FwTIYiP3GdZgqQ9S0itJ3GDo8w8+s4JBiwalnLT1BlI3/x68FY3NxilRz4CrrXpZ3dBjNwBzHybzR8mvfFTDY44Gn0AwjlLMIPZr//HBkm4y1jKZ/QsfyWFVHqB/acW6lYzV7IUrEbpT+TPTbEx3rnpkP96QKbnBNFMwXT8wZ9eN5XrlbcivQu1y2qXToljPudIa5G3b1tFPSHJN1149s3976dfUgt20J4FRcFkiZlQNPMYVmr8caW/WSdPTBawaYfY9n4HvT8Yw4mYom1jvjYVkYPXLsRQbyTh+CvwI+b9PJxsH9QfrUR4H4LrbyTRJPwKRPoVoA08/PzrKpPT3jkKeIQLvDkCbsWHgjnq2GJoO9qRLK3yh9PupEOy5dsaki3CXFQTLXBXcxgWGyCbqq+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(9686003)(41300700001)(38070700005)(7696005)(122000001)(71200400001)(110136005)(2906002)(26005)(53546011)(478600001)(54906003)(33656002)(6506007)(76116006)(83380400001)(66476007)(86362001)(316002)(52536014)(186003)(66556008)(66946007)(4326008)(8676002)(66446008)(5660300002)(38100700002)(64756008)(8936002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?STQISoDWCkR1oOE996fAnTBCFyZK8jGS7r9upVzehzGmGWlsZ0f94B6Aptsy?=
 =?us-ascii?Q?c/LshpQ3WND2ieJugbmRntVNvacB+7rocqAY77rex2dbmFtnrIeaXTImMKSx?=
 =?us-ascii?Q?eM1ofABKfPrc+Oq69UAcSo2NcV9FAonSGVWCgn6XUlCUC73M3qmrLhS4rjCO?=
 =?us-ascii?Q?1VWxKIJxhQ+5pxVhIbbYUflWfK11PfSoNrh5MaXAqjGzK9KIEEGCgyVI05Wt?=
 =?us-ascii?Q?LRZ88CQ++HSmesUps5WjgPYr31cWVIVo9XkZ69ebQgwA/NL1nf7J1qkksfgg?=
 =?us-ascii?Q?5fcZkczHMVWlWsfdP52w+opWodKz7+VHzLGYJgeRqpozVbolM73AFdQfl+R8?=
 =?us-ascii?Q?/UaIh2S0Pxykm9f5iANyyV6/QJjTwwjL0ldQhIDfBpl/LyiN9hA0cvrAwAbZ?=
 =?us-ascii?Q?LPbyV6refxDyEE9esRdkwVEkB8/+WsSF5p+wFnO5oApJ3fkPffnRV4HVrSlL?=
 =?us-ascii?Q?QTgX/GNoftcBopzTbVXVju2NZIqXwhbeIE5WIuDG/i1yJhb9B4uJRRSrLxmT?=
 =?us-ascii?Q?bOlp1K5OZtQjWwlQX5dYR8eEXyO07kaptoYvczoetoqtAjkiPtgLkETimxbC?=
 =?us-ascii?Q?ZEe6UPHqjpq8tmHead3TymgLeSqpXvXz8K7l7T81vN/lRvrfNHGc02db7xoh?=
 =?us-ascii?Q?/128fmhY2Y/l9FED6RATtvI8goLfJuLIuefJR+xmBXL6H4VezdNhf5N3uiM5?=
 =?us-ascii?Q?/66X9SZDh5K75ShXQ/9C0aMi4Nhk38LfKb/XQ2NbIIZiGpn65rfvxyTkMq/Z?=
 =?us-ascii?Q?03ghWI6ya7HyCxHJoxc5Zby/zbYMKhJLlvdybHan2Q/ssK0z1Z4Nx3/WedTr?=
 =?us-ascii?Q?ACkPibFBSx/+De/64MKJO0CTfWtiL5gYphIktyk0+GtdIbuMpWBtYORXn9Fm?=
 =?us-ascii?Q?3yAuBRpe9Djd/LDQZu1f3neWLNgi4tVeQ2nsutAEIITIzun0mV8auXOZD8Q9?=
 =?us-ascii?Q?bcfNAWcCFJjF7JlVb6tw603/RQw+YTWn++Cbu0rmNMEQfO1Ug/sH8lWR3PUa?=
 =?us-ascii?Q?lOMNh1mVSS2T6OsHDmt6WYY1zxdXaUfbHQs09egIQ7/D2KNDYiuIdh+tyLm3?=
 =?us-ascii?Q?uifZgMjjxKwiOgTkWL9/VBVIbOAkKpGCxycmvEp3MSZ05VN/fvXSS0pPlNHs?=
 =?us-ascii?Q?NkB+wEJxISwVv6Qn7pg8wtP+RvxWsKhKwIu1ceyHSP8ZW6iZ4X7IQ4wMlhrB?=
 =?us-ascii?Q?O+jIVKIT70ywxWHK1I/y2W+Co4ZsJ+baDjZlFKVWD1TKwZIrEz3KwLJSPdSs?=
 =?us-ascii?Q?HbdOlkDbrU7QlYx4rnDj/2uS00bgy/dvIKIo3HfDs9MRIuu72d9MmnHqOzx0?=
 =?us-ascii?Q?AdOPWBVXGUbBnXEDypgpKSTH89g3dRtRf/jrXg8QZ8zdLTq/KaB5xjVDoKZu?=
 =?us-ascii?Q?22x7zZVKIuq1vPSKq4q2fzEo//zBx2Ck/pJQo/yqBAHnemOTtsNfVOoUob5Q?=
 =?us-ascii?Q?yUQGa5etUOJzw2oNdgmw2v9zLk5kZVouSLAyTonjFSx4EhGk5f71r8QhvjDm?=
 =?us-ascii?Q?M6qgs/15bucX6UkbGhg1aJq+4GdXw9InFhmV5Ba65Llb89kMmf3PSwJ8OCBF?=
 =?us-ascii?Q?ppiXOw59KU5jETAFaHA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9bed6a0-3589-44a4-fce9-08da5a04fae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 19:24:26.1295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfSkeM/OIR2olEX9Pt5dQKbDtvvWz8HVxlOE8FWzEIBobS14Ndh1WtKQ2Lc5sw9tPqFAoJ7RHMkThONdQ2a25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1830
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Asmaa Mnebhi <asmaa@nvidia.com>

-----Original Message-----
From: Tom Rix <trix@redhat.com>=20
Sent: Wednesday, June 29, 2022 3:21 PM
To: sre@kernel.org; Asmaa Mnebhi <asmaa@nvidia.com>
Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Tom Rix <trix@r=
edhat.com>
Subject: [PATCH] power: reset: pwr-mlxbf: change rst_pwr_hid and low_pwr_hi=
d from global to local variables

sparse reports
drivers/power/reset/pwr-mlxbf.c:19:12: warning: symbol 'rst_pwr_hid' was no=
t declared. Should it be static?
drivers/power/reset/pwr-mlxbf.c:20:12: warning: symbol 'low_pwr_hid' was no=
t declared. Should it be static?

Both rst_pwr_hid and low_pwr_hid are only used in a single function so they=
 should be local variables.

Fixes: a4c0094fcf76 ("power: reset: pwr-mlxbf: add BlueField SoC power cont=
rol driver")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/reset/pwr-mlxbf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/reset/pwr-mlxbf.c b/drivers/power/reset/pwr-mlxb=
f.c index 1c4904c0e1f5..12dedf841a44 100644
--- a/drivers/power/reset/pwr-mlxbf.c
+++ b/drivers/power/reset/pwr-mlxbf.c
@@ -16,9 +16,6 @@
 #include <linux/reboot.h>
 #include <linux/types.h>
=20
-const char *rst_pwr_hid =3D "MLNXBF24";
-const char *low_pwr_hid =3D "MLNXBF29";
-
 struct pwr_mlxbf {
 	struct work_struct send_work;
 	const char *hid;
@@ -31,6 +28,8 @@ static void pwr_mlxbf_send_work(struct work_struct *work)
=20
 static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)  {
+	const char *rst_pwr_hid =3D "MLNXBF24";
+	const char *low_pwr_hid =3D "MLNXBF29";
 	struct pwr_mlxbf *priv =3D ptr;
=20
 	if (!strncmp(priv->hid, rst_pwr_hid, 8))
--
2.27.0

