Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD424E9095
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbiC1I4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236266AbiC1I4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:56:40 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130083.outbound.protection.outlook.com [40.107.13.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEF1B7AF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:55:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2sSKHsErCG6ZFt6shBXSfeeuOLMZAZC9ZWp/7VQ+xVnWw/JJH8m+5V3UuAC4vwxEniD9/ot9VzvZJYRjLpWgZ9rB1pbE2Ghm46+d0GPb6GxSy27pXvIHNwhcCAdL9i8GK7IUc3Swz777N67JggASv9vYIeRGzPaxdolwiDvcH9KWsmBLBotxMSipYXa5n/AXDh4bRGtLq+xYGd2/haXNlrHToSPQVhlGzfvQBK8IlOOSyyICzoqg0uN/yepx4BiRqHQGEkSquwnNBGJoY0QPa534ytWwELMoEg+lVJQsQIDwaZL9u9YnSv2ajodDXKxUq7rqAnbW7L8Nlt0u+5wTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vczWXBeykREz1AW/ZRyyTxC1EwlqCiE74p7qhh9uvpE=;
 b=IFtQsuBDCcd5hSIp7ONpE676TxZ7xv/cMhoQ1i7H5j0p0YIFPum7ky3tWBD2+HEiHgxBbCzfu2KAndGUat4vamGC24dTEgm4l9NYE3FGsqzzY7NFcewFw4nZJ0j4CYvhghVGwBQBbqr2XL96h9S7e5StBcMRrIkgnyFEKF+ySXLlBCEWm1EXQi0NQYJHEk5nS2E5sGcs+IDzxcQYaUtX3vn1L62mdspBpL+fJECckbVThEfrnr71zm+Sg/rDBSyXGIf6la45Wmqi9p248LWfe3w+vWWppbFsh39e2nr+1RUr713FGRbeSWHjRe2cjNi6lCuoraD5wD9IxocDg6L4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vczWXBeykREz1AW/ZRyyTxC1EwlqCiE74p7qhh9uvpE=;
 b=dq6uMrORe/z0t/a0xs0j95endUn8gMT8DCe80GnrEqjPevSU2i50fX04lgagjLLaMTHCQ1kgSNq8xw1Rv+e3TduYL5HvMp7geINREDFtqmW5wmO1M2TmF/LTEwnzX7wnQmiy2Wau7jMt/resQG5rZL6C0BTGHMRloCrZeCSdp3Y=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4457.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 08:54:54 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a030:858e:5c4b:c5ab]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a030:858e:5c4b:c5ab%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:54:54 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Stephen Kitt <steve@sk2.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da7218: use i2c_match_id and simple i2c probe
Thread-Topic: [PATCH] ASoC: da7218: use i2c_match_id and simple i2c probe
Thread-Index: AQHYQGx4PWtBUaC+hk2gPXQepgy19KzUghrA
Date:   Mon, 28 Mar 2022 08:54:54 +0000
Message-ID: <DB9PR10MB4652ECB57D0BFE28209AD2B5801D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20220325171904.1223539-1-steve@sk2.org>
In-Reply-To: <20220325171904.1223539-1-steve@sk2.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456b013e-6472-4dab-9255-08da1098a0c2
x-ms-traffictypediagnostic: DB9PR10MB4457:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB9PR10MB4457A32BB26121A334D5F1D3A71D9@DB9PR10MB4457.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXhf/2pgLuoNfEfiMZv3BowSwijvDi1F2tzjn7VNt+d8Ik2sv6gLGTGxwguWalRmpWTZIU2v48wYKZgWkj/czQKT6DUviK2MUypxawB9qWufgCk9f+8+0WRBzeEZ/pMLP5wC/dHoNCBO440JpYjmiy0eaC9ictpss/UFljxZs6yLbVS0IWCUHGcyrdHsXZRJul+fvLyMxGAF89MeSYSmW17/mbsFEhk1btCDj+X3TEmjUGjly40ZmTNDTNAN+I/01lGv6E3g7KO23GYS6HRYjjL2XqUXFt3TdbWuZcFIX6N7unRD4plRj6ksLINJmO8xZn9zOdQl1uZWsNotHuVp8NdLdxsyDUClKdZhiD8yOwZREgp4pQX6sSZ7bFXthPEQasbHe8Wp6Hf3CjgqxEpcPRh5nK/+GhPKK1gnCfKy4xXhtfQIlP3A+GOI8eidww4DMVEF0keQySTFji1W1ef46MKzVVd+Pj0nGuS2G2QXwcNm/zA54kkweQGftbinD05xxQwbi2HeQehDHP23yIC3k5KBpSmYStLwD9SQ1xvrdxH2FIjvEt+wpl2zkmXDxncHOqDuijU0URCmdhjmYL44m65Z5y4BhkzFOay8A0wwJRMJb0Rz6/bFK1wT7HUbavMgUg4kGmjJLsfGUGjZhSaTJD9sna5ZcFj/zhAx4EdTiPUIcbPYj25SvyuyZOqBU8q7ZIGMOpRVtw/0WyEmFdNdbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(8936002)(508600001)(55236004)(53546011)(66476007)(66556008)(38070700005)(4326008)(86362001)(71200400001)(4744005)(6506007)(7696005)(52536014)(2906002)(38100700002)(186003)(66446008)(64756008)(26005)(55016003)(66946007)(8676002)(316002)(76116006)(122000001)(33656002)(110136005)(5660300002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wKotoWT/vHWaLVgqWR3qzvIZdG+ebLpsFUrof8+VZ+Mpq7MFCOfLnBsudrgq?=
 =?us-ascii?Q?CjUuGGNdUT5BO4Hz13AsE9AQC3CX+vt7x5GQkRBF9+9SE2JgGOBz3uOE9EHV?=
 =?us-ascii?Q?3H4aFrBO54+31qJDfmkb0mHMq/0S5NjNDx67eoQPUBALqTyjAqlaH8oYzC5B?=
 =?us-ascii?Q?cy4HcUiS1J1Qh+bIkr3BAXKSGanSCLLRLJJtxbBU9iE4/P0z6r3SUgFGaPDq?=
 =?us-ascii?Q?t8DzEfHK6CnS1wjx1z96xfGDOiba2cw58PltSZpCWpJweaNk1H1GznsurJ3e?=
 =?us-ascii?Q?GWkoRFF64OWIxKvaVfcFsL/NSjMNSzXjtqNL33874A6VWgaht90oJZVAtwIW?=
 =?us-ascii?Q?+RsBX7Ajs7MskYsnFeTPwYVQs+9n7sUE5nm0Hw6ffJywJeoGHRpOyCUPyMwL?=
 =?us-ascii?Q?00+OFeDk9oBF2A5Kf/MyTOMnqxWJerayMkqVpJ9AidWPTduFZ9v6TGL9qDJA?=
 =?us-ascii?Q?HnHeTxxDy4c81fHwYRLBkhaZsa4i7169zyN+2Jq+LHu/a5GfeD2ngLlpECHG?=
 =?us-ascii?Q?X++ukN5pAdI1QCjKsKlnFpHnpmBF4Xz1OaUk/ofFS+Fx5XQPLe+xJw7QzAbr?=
 =?us-ascii?Q?bH/dFITyRAQ0/KO5Nh7bULWtU2Zv+oEvIUTqkAUy/PlOeEUYVtOqhkY1CdcL?=
 =?us-ascii?Q?ldCI6l2cTr183nNIBHWG/WITiwHS14joXXtHQ+Gdt8uTbTf/G8tmLs9eBc2c?=
 =?us-ascii?Q?wR5OW7aw/gSjSICbwxckb3YpRcsnki5LEWF20bBRnxyR2STMpDFAf/6ZvSHI?=
 =?us-ascii?Q?zHEgzhYOUeHvUCIPi3/s9LN+fB9fhXEPoNcc+yazptoyss8BIPK9QbYJ60Qt?=
 =?us-ascii?Q?SKUlNV3kL2STMBfHDRqVnQtezLH1/VtUjBgvZkOCsYnz4JocwMg3M31jPqbT?=
 =?us-ascii?Q?p3V787KkrTUgOtCZwKPL+kyKjsVGxmPXYhdoe2jNMekV5PI879+66Z1Ixo3N?=
 =?us-ascii?Q?jJe4Mui3lSS5Er6kjeOElHsMp6WY3HFy6kAblS/Gj3AHXoZxZugvZKm3dMR3?=
 =?us-ascii?Q?6UsPTSh+jBRLhEyaFcFT/kpVrLqVNWQkMHUWN18n/kHSuRJ+KWjnDJs5bxq8?=
 =?us-ascii?Q?8+Wd4Aw9AWxCALdwNXvUOCWR5ANR88AHxnV0xD82j7OjKEGYQs2qd+XP855t?=
 =?us-ascii?Q?XGYN15nC6bJehKNbmY71KPfLwUHxzbuqcy15IwWhzkvMwCkOJlb3rhNd56Uq?=
 =?us-ascii?Q?+mClfSYVq6K8zozMvHDqieuo94JdnNvxiJCTQnyZm/7jC84zFiU+5uhbAYw6?=
 =?us-ascii?Q?e41vgOyrKUngjD9nhdb7npTWogAXFOkSLIhdsisIwUzL5WeShuY/b56HJNLF?=
 =?us-ascii?Q?RABg1mGSx71CEdju1Z2bK1VQMVW9fGUenVFsKcau3XXAuX0i3h8aZ/+Tqwor?=
 =?us-ascii?Q?KUM0pGzFy4KoA7N93oEmAIWonVa98bVoGWyyD3PR0j7nvyXi3oLfJtL/ZMrh?=
 =?us-ascii?Q?9odz328QCVDPbUFPfgtlA94x4qdU9rVeEz/EAP5EVsZd3XaUuZbext1tZv5x?=
 =?us-ascii?Q?hz8CFEmyqyJ2qHzJF8nSjk+0bNjjnse7Uy8rJfRUbw2s8gB6S/3Ok+mU7CPp?=
 =?us-ascii?Q?vQhDZjA24aLEtFkkPzHiSkHW2Kgwb1dr8WJl5oiRssmzAP9J0JNdvbQcShbp?=
 =?us-ascii?Q?xXlvjE+GfYICSTMr6H9eIGo1MGJpiBJt47kecTKtX617EMFo1ubBRSRParZd?=
 =?us-ascii?Q?QcweDq2CbfL0fOkZYgZuQVG6hrJIHHnsLlPHiTe+H263gf9Hr7WnRBtu5JDT?=
 =?us-ascii?Q?alKU5wUnVlps0zbkwcPDL/TaQLisb9s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 456b013e-6472-4dab-9255-08da1098a0c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:54:54.3276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDjZKurdTcOFUhGcjYqnI+HAwVwUOrIEhGcOtWazDK3SWS/by0lBKv1ALR3C4vSbzWsVlOcbP9FE4pJ/qRcHUP2I2ZkGpkRgBNC5/BBsLK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4457
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 March 2022 17:19, Stephen Kitt wrote:

> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> This patch follows the model set by da7218_of_get_id().
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
