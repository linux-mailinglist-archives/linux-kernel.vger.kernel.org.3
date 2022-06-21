Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518E4552F99
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348178AbiFUKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiFUKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:21:35 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B5228733;
        Tue, 21 Jun 2022 03:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPMBtHqPeFzVCeQH0YfIS0w9egf8RqRI2hdjr2wtbtYPlTxVDqyR5O/6TVaoO4hgu/oEdnK7h05NTZl4SP1ZXeX8ftzMH/vUZfm7LoRU1Ru3Eo+mE/m/ixBcBemPPVpfXoRCSEVbwtQBZ5a+ZvIN9El7WDlxnmZSL7KHANK0YJ5Vqo9eaGvpIZk/nHdFmq+TehXoDxtNdbVdVoOnEJV+iXvN/R05sBMzEwN/B6LAaRl8bwF9NTtKzEUnMIAL8l0mHhWgxUGaewUFbTKEwOzTstNCPNqf7154KMjbTsM5eD1/suK8QZ5SHGOxQxV6L2sekSv/Effc3MQwm5WqpylICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91BOQ61aoS06OnxSM7W4cwaypow+WtqgdPfmXHUfKpI=;
 b=b+7XuTikMkVP0nLosnCWCgO2OcxK8jQAexVAHg4Nk1xJGlJpbgfvE9HJAse0KJr7m+/M89HjIJMwWICPo/ca+zNh2Z076x9K967KX6oZgYK2F5rai+Sfw3wTPZTSwU5FERArUeTpqgg/4dVhQVntSz8fE5FgO3vUL2gL2ucf5Yq9/EFk6f5s0mSHdnlIdOET8FP6wdcN6k2y6qFSsQuYGUpFlkUL8RB9mSOKMsKsLYlnjipwwzdN/IG9Iu9THYnLJg3uY37Jsve9BM4K6rJZQw5TQAKkeb5FPoCkRc45e2gijhc4ubBwuNzYP8hKRjZIPrt7qxD05VByC29IDOPyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91BOQ61aoS06OnxSM7W4cwaypow+WtqgdPfmXHUfKpI=;
 b=g86HBhYKw+gF2LPzkcBF9FbGv+/ETgsBfqkFpDmjJwVA1NxsE8F9h7jiaMrmE/k4uLZvD+NEEHLg2cwda56jvEafa3KKCI9e2VOh9xLCvsa42k+UNV52UR+zdHZHNEZXGIB29HEGUQkQx75QqXb35SR4e8+9GvzxusntgO+eBXc=
Received: from BY5PR12MB4902.namprd12.prod.outlook.com (2603:10b6:a03:1dd::9)
 by MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17; Tue, 21 Jun
 2022 10:21:30 +0000
Received: from BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::59c7:d947:6370:7de6]) by BY5PR12MB4902.namprd12.prod.outlook.com
 ([fe80::59c7:d947:6370:7de6%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 10:21:30 +0000
From:   "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
CC:     "Simek, Michal" <michal.simek@amd.com>,
        "Neeli, Srinivas" <srinivas.neeli@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v2] gpio: xilinx: add missing blank line after
 declarations
Thread-Topic: [PATCH v2] gpio: xilinx: add missing blank line after
 declarations
Thread-Index: AQHYXhPga0uHdz+LKEm62rkF/51F2K1Z9MUg
Date:   Tue, 21 Jun 2022 10:21:30 +0000
Message-ID: <BY5PR12MB49023428EF7364CF9EFDD80481B39@BY5PR12MB4902.namprd12.prod.outlook.com>
References: <20220502110040.12225-1-shubhrajyoti.datta@xilinx.com>
In-Reply-To: <20220502110040.12225-1-shubhrajyoti.datta@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-21T10:21:25Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=24a3f90b-e941-4ee8-b795-1406f13f2bf6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c55828e-c61c-47ca-1231-08da536fcec9
x-ms-traffictypediagnostic: MN2PR12MB2861:EE_
x-microsoft-antispam-prvs: <MN2PR12MB2861A5338ED0327E0A10EE6681B39@MN2PR12MB2861.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqS6fxGVqAcvyfBWhL/rs24zSYkf4lALJY8AKad42zmCPge4O39tKBRNm4no17yw1lyBf6qS+NbP9AdZ/1/bZuidq92Z5ha3K56ZMRJlxc4oVzd8UH9MYLfJac/nDMePAp2MU/Crin+l4FgZ086cNZXsX4VZVaggCdUnrGt0201rFIRk4y9GMK3ZPuu2a4Ooktt5FOJls1T22LWzHDhsO6NNdMkCqPewg49+/v307eXhqZPGRAkqWOor2NZo1I82ryURTrnzOyRQNvWKGDq2lR4PRsKopTHukZgVax2rwK1xo1oVz/kdVC4/rNANfg5HXz4ANWw34RNpbS9q/lPjLgRZaGfEOCaRrC2/mw5o4Dp+scDh5CHAzIrU36haqpT3ofgSJWcJ1V1JWYZh216cCu5knFwkJhDX5WsNR2adEi0OHGslFHPpabC8yurtWtvWLQlbG9GEMFfalWuNFQHu6Yv/lRgd91zlzpbjH9zRhCLoYt4HCD/29EjXtNmqds8qlnIqB5E65PGkGeCiXeukOAxqAMnyH1x3jIqJ2JaYS96WIRl+eoGLcW8zrTkh2+JbOCjKPunRDPtaTA6S0GGly1n/C2AwH2vqYMDSWlhk8sgGX/LJkMnCSHng7X7D9ZQQihAZF8GHAm/II9bvpmKiSM+KxomICY2YntdbxpGgU3rHeGBGq2zl96YrYSq6BFgdExnYGkoeSEcWe9J1j3O8p961FKpGvSfxFgX8fXSHwV5tcUKeLyew4U0RW7Di0kc9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(4326008)(66476007)(316002)(64756008)(450100002)(186003)(107886003)(66446008)(86362001)(478600001)(76116006)(83380400001)(66946007)(52536014)(2906002)(66556008)(38070700005)(4744005)(5660300002)(38100700002)(110136005)(41300700001)(9686003)(122000001)(8676002)(71200400001)(26005)(8936002)(6506007)(53546011)(33656002)(7696005)(54906003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D+bV8bIxu1xD6cHM+9Ju9o9q2gYKzbvcaU6JqYE6yulgsHH4e5OU14UY+Dmx?=
 =?us-ascii?Q?AMzUl4SSjCs6EaBdk8/maGl1RNKQ2/VzFIl94j2elzHs1XQLL7gClKKEsfVl?=
 =?us-ascii?Q?fcua3EkNdbUZf+TwCO6rvOYyuqiC4RffuJtiL1LvnrrtE++qxdgmWB+4CaaR?=
 =?us-ascii?Q?mSVXAN4d/pc0uFchxeDg2D352Q/9VeSugJWRzUdUmQHA7cgr22bDdbstXOPr?=
 =?us-ascii?Q?2g0rWOwk2XenzuvvoM13M2gp1xbOCHfZXKHLz2vZwr8B4wYBQ0SQ5RVHH8Kl?=
 =?us-ascii?Q?Ld2BH4RrDPQES+DMDalcK9F82DxqzIWPgemT/S5J7ayvjPgJMby06DtDzydX?=
 =?us-ascii?Q?4Y3Xh5j5SWOgNZDAdtwa/ib8qi7jBL2eaECgoX0hmxbTVIE7mQvGVPesuy/N?=
 =?us-ascii?Q?ffVJXj3B15iptdwYpqtrEf0UWMchHhw7sT+yM9h+iD1fbT5eOZ6nt+fmpRoC?=
 =?us-ascii?Q?684bjy+alChtex6MSUBb10A2qEHAPjfquaMyfyeJMMTU9FNPajsA8M5c5LhE?=
 =?us-ascii?Q?IY4D4okO/CKccZpAsFMz+u1x2NDDiMgfZHzXLSC0s/Phg64JhgH8ltcnwaKq?=
 =?us-ascii?Q?V3YFKQmU2eIkj8zGz2pFJd2dmGBHafiN0/+7WYSPp+xPmaVblS3aC2kjRodM?=
 =?us-ascii?Q?ZODEDki3pSC36tcpEVf37lPTXIvLYuzXbgGVlq5g2DPrJBsWk5s8Eo1bfaY8?=
 =?us-ascii?Q?YtPMGp0btK9C26z+D54wk+elUEA5i52EQncGRdVk0lTkzgohgl1E7OkLJHNy?=
 =?us-ascii?Q?3csYh1y5IJgHgyDWkJVBUKFWkYOTTj7fOQjsEU/5A6IFzL99V7RvmIXmCY9i?=
 =?us-ascii?Q?cBhnc3wSJpUiBzIUoV6AwUzXKDGpeuG8eDp39orKXtauA/pPFSxvJYm1W5GX?=
 =?us-ascii?Q?YjYaSALYwJxi6AJTgvBYmOu7CFF53ZXqEmFTwcWyOyyLpAVxkx2VGJKzxbYy?=
 =?us-ascii?Q?2NK7yghYKwvLZcHlcN95xcVWN42WMefolTbApRxwjAtems5IFCWVEokJmKrs?=
 =?us-ascii?Q?Sqaytbg3QgsvdEk/t5XpJNnPnJHobtBfh13i0d6x8uw4FfSHkR2TVz7m2UCd?=
 =?us-ascii?Q?jinxl4NpyAOVHAXPcuSMDO64Qoa9jIJqJUqPznboCzzJ5OfYhzn+eDaLOoVs?=
 =?us-ascii?Q?4p3M979QyJL2t4Nf7D1Swmas4SQPi8IjSEMIjXu78No91ZrZYUto9sh7/x93?=
 =?us-ascii?Q?X2Z4agsRucDSK4ndzz/FeMlF7PCmGgJLDKsgQ8abjgbZTxdzSuPGL1XpKc3W?=
 =?us-ascii?Q?ehBb+2WN3lWKxxKHa+KMD1I4RfVukg7YFl6elkO0IXFpUJ73cA+xVq9H9l6N?=
 =?us-ascii?Q?hxlv4fohYk9Lm/Bhg8vBg/l7AEprlTe6O/jmiqMZPJcMweg6T/vlDoBeRIn/?=
 =?us-ascii?Q?ud6sV8faxhufCNFLhXS1IvJ0vOwu9/zx3O1nEc3CmYScG/ebRsSyH8LIET45?=
 =?us-ascii?Q?xLvEUPz4KhVX8B+Y1pUxGwZgRmJ0qjPDIawe25bghgXEz/EZ7wd1F5oXcFM9?=
 =?us-ascii?Q?WFtGirW8VJXXZ8FXlsqAoWeveTljtzHeL7XbcuOLJHvhs1tRLihqUriTIXUS?=
 =?us-ascii?Q?pwH8XeUyaw5ulVyLqPeyrsdqVx+901MhNBexzeIr4oTtKfK4X+iz4I5GYs7+?=
 =?us-ascii?Q?SQcsx02RWSssRcOdOfGhAMs8GT3v27OOTSVtvcC+6W0b7SDWyMQCt+690Brj?=
 =?us-ascii?Q?DjYiEOUhypmv1D3vpvc1P9xGD37/LTu1XRXPWuTjZ4e45HxY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c55828e-c61c-47ca-1231-08da536fcec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 10:21:30.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OixrgltrFt5WPRRp0mT7kZ3gsemd0FGA9C6cGeTPWU5WwLf3Q0blZHOmSHKFgsvd16+mnhO023md5a2MEGKPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only - General]



> -----Original Message-----
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Sent: Monday, May 2, 2022 4:31 PM
> To: linux-gpio@vger.kernel.org
> Cc: Michal Simek <michals@xilinx.com>; Srinivas Neeli <sneeli@xilinx.com>=
;
> linux-kernel@vger.kernel.org; git <git@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>
> Subject: [PATCH v2] gpio: xilinx: add missing blank line after declaratio=
ns
>=20
> Add a missing blank line. No functional changes.
>=20
> WARNING: Missing a blank line after declarations
> 128: FILE: drivers/gpio/gpio-xilinx.c:120:
> +       void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, b=
it / 32);
> +       xgpio_set_value32(a, bit, xgpio_readreg(addr));
>=20
> WARNING: Missing a blank line after declarations
> 136: FILE: drivers/gpio/gpio-xilinx.c:126:
> +       void __iomem *addr =3D chip->regs + reg + xgpio_regoffset(chip, b=
it / 32);
> +       xgpio_writereg(addr, xgpio_get_value32(a, bit));
>=20
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
If there are no further comments can it be merged.
