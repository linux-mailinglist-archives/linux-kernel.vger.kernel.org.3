Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF824E6D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 06:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358337AbiCYFVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 01:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCYFVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 01:21:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6145F8C4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 22:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDaDxO5mlzjNskJ1fN2gw4En1HJR/4bWY1g/hhFcuzbV195yYhHu+IKSAyUYVXBvLqI/kGcfzdVpSq+1AC71lgBxU18xc8XNBal/tGYZWLfRLByumoi/trIGt80Z8gGbYcbsEtdL+EEzhAEQjg4bDW4C0gpJWxHtzqdiOVoL9vQfuP+R3EPHfR5z8HRi+eNuBvOjeCQUSCoO9q4WiXlMum3T+8VVB91QYgCUJrzDJQALsLGOaEhP/yqSQBThU2PjEDFaporsQCIVU3Q/S2T3PwIwLNj93yF9QmtFyPsvT+84DmYhXrVkzzq7MQG7pms/HooWLhOcA3WX75QThIf/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGat2fFRYBiNO3mMVWA3BDTHwv2ytB2KxKZIbYbtwO4=;
 b=csClD2PI0HfXTDX1UuXS+MTNoidVF9ojNBpCNCg/MeKfAMWR/i47//xNA1czSLaLnMTe3uUrJ0ppzdwSUQCFu0pQv0fP7uU3u1K1UfL4biioKsUZn3rZflk/uJJS0/hQdnECVN9dj1VnDepommjTHAMGq6ITOaPgs06l/YJovFiVg+o7X/v5AZUGHVTuzD8441HEgJVShS0eGNu0+BOpEhGhQP2sAW03bKWi8Anj7mhhd7Lz0df3sC0R3AigCQXWXQNEbOc26mucm0eUbv/xa7POdkPvT+PqsY9SdyoaDhZYh8ysNL1Ac+pmTSiPo7jZUk8Sx5xpfxpuNHdcxwxqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGat2fFRYBiNO3mMVWA3BDTHwv2ytB2KxKZIbYbtwO4=;
 b=ZHxc1RtNxUO0QO9S1Ox6Hvipzz27BkBJyOw7Ca3povJ/9w/53nqDjukfG+am/6TNMaMaaI7S0kYoTBas6O/M3Ni2v9sl6Uat/w8S2XA0pk8oalCJwAA9tIk0rgjFn1/7I2VPpD+cr+25UeRWwxtCiQgGrE7u0vLdQfzaxi2MS4ZyQKnHB+n27dMeB5h87IRhTppq1ab4af5UJn+aeBZ2YeDyJy5kyHPMLSLvWFHHAGeAY5EdpcjyA4FGbHD0pwZRkHG6vhJXQSJ1tuwi+HVu6pTY4YxsoABxuzFIaSqSrbtjLBC6I87Kt9hWBqZKr8n/k7oD2S30D9cvSGbZL2GXAQ==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by SL2PR06MB3195.apcprd06.prod.outlook.com (2603:1096:100:30::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 05:19:29 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::50b3:3961:b238:2961]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::50b3:3961:b238:2961%3]) with mapi id 15.20.5081.024; Fri, 25 Mar 2022
 05:19:29 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     BMC-SW <BMC-SW@aspeedtech.com>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
Thread-Topic: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
Thread-Index: AQHYPk6X/gp4j3CjFkmzjAiFuEXVMazM6OoAgAKo2eA=
Date:   Fri, 25 Mar 2022 05:19:29 +0000
Message-ID: <HK0PR06MB3380636B12959660E04403CDF21A9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20220323004009.943298-1-ryan_chen@aspeedtech.com>
 <20220323004009.943298-3-ryan_chen@aspeedtech.com> <YjsUjB7vr1scHPVy@lunn.ch>
In-Reply-To: <YjsUjB7vr1scHPVy@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d2cf7a5-57ba-4d86-2f7a-08da0e1f09a4
x-ms-traffictypediagnostic: SL2PR06MB3195:EE_
x-microsoft-antispam-prvs: <SL2PR06MB3195C4A5C9DE73679B2034E7F21A9@SL2PR06MB3195.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spxkaJL2nVSOtBDI3qCWiuju3M6EeHAwyIH43fOmiu33xBrE8fOFfmMuvynsjbUXsnMyApsmLwPuHuEOCa9lM68dRT2JJedIW2CJ2K93CZHt9wo1UJLF827NR6W8mQBHmV1loyef53Jf/FE+1BWFkyAYpNHHWg1O2+g17Y587mXjQLfUD+8wbHP6kYUXVBPvyM04r0MlHKrylbv8qDokASgIItM/uZlAzPzBFlIa87r01n2jVDI+GPXwaoSG3TuO26YxAcCAqiy6toMpKG5Qg3cB6SitDHQ6HAZhR3Fmvr1VP9dohv3KJ/DasH/b2nUYWPmAGm2aM6Ajxj2y4qzoXzRTFeMFl2nOhBCQYndWpl1y8lHPamgMswsI9SgG62dg2v0Mdb81nB3Vsh2yGnrGw74WH3Q0Rd2MTnJg4PGOPCEorpQbIvyr673VDrH0Zl84raJ8UYaw7H8DKzOmW2Y1ZjiHC34Hy1uuVU6Db5jhBKUNyXPQ1KaM3jDnVXswStztJDLLpfcK7jTIagc5ytXbCzijRb+TZnUuXF5drbc0LvQclN9OwGb4D7WIN5WdWjmU9OJi2e6RexpTo2ZwWmTl+5kOXbiMrjFXGb2d+72fiiyVFxFI/JpZlqFoqASrFEUKb0+4RuwI8WB+7wSfIjhJKrDboxRGN2JYYoZwBYJ9LbBVFUODm8/keSLCckuqIWVliOfpQsJzBHYrjTXqhvMMrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(366004)(39850400004)(136003)(346002)(86362001)(122000001)(55016003)(2906002)(38100700002)(66476007)(83380400001)(26005)(71200400001)(6916009)(316002)(54906003)(508600001)(186003)(76116006)(4326008)(53546011)(6506007)(8676002)(66446008)(66946007)(38070700005)(8936002)(5660300002)(52536014)(33656002)(9686003)(66556008)(7696005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XPKhv9rpSVTm58/3PHhXLQjYsja1lOpwkPFCHuSGQpNUi/DwQ6eBsvMhL+S4?=
 =?us-ascii?Q?rSeOPKaQs+4AuTEH65JQ+FY5Z8Y2AZPJlnGQKm67rfNHd/JX4s8AC8msKnDJ?=
 =?us-ascii?Q?UCVRuo5vLJkdQDrRzXP6GMThPlSRo+2FQFvHEeEs6IBR1jxepYy/2llgh3+s?=
 =?us-ascii?Q?NdnlCgVjdCMxsUaFNCXEwoZZ7igl68/bLMZJzE1zaIs0nnr4qBgzE8QM1vBm?=
 =?us-ascii?Q?Gqsc/Ictd+eH+u4ij0QqpyG07tn7a4Wbr9aPG16+Qlbdfb3AOAMMXnmwYXon?=
 =?us-ascii?Q?ez0nD8rzRhfnLp6WjPIlUgHRtsRO7biFRmXlkcPr4ZIEWcRTfgXsBV3n/9BW?=
 =?us-ascii?Q?SUdZbXW7JcJLCg/wRtZcIBKYxednNy1SdpQCUf2Lu8S8z02vWmuA6x9Gvydm?=
 =?us-ascii?Q?rctViqPHr7L32TvBjEE533ZdSWrBw3BH2FTQWWlAPaQT+VcxF0FJF/I0PCam?=
 =?us-ascii?Q?6QDAei79wGTLYRXJbWO4tHSN3P9kmO1WxzofUgdblAX6qbfCWlg8V065+unc?=
 =?us-ascii?Q?QAH3sK+WQKRr/7nhWL8Axr923SwOmS08YnGU/apA28Fnlpw0XIhpc3ASXk3g?=
 =?us-ascii?Q?FD8I6+V4/kA0J3YVF6dn/P5hKQ3nquEf6h5Zy+/xqVPHQadgGBrv4LEutMZE?=
 =?us-ascii?Q?FeTnvRZuPqR8GIjYN6bXYvH4pYrJMnkgt0aIr+8SZa9nThFile9QX3T5t/Jj?=
 =?us-ascii?Q?NmqzyxtdTiX1SDuTZ7L/8r3yXyCkAI52VXnYSE6pgA3xwsVIAQFBbgSNMnJR?=
 =?us-ascii?Q?Hq8A7Zc+EPQGFY71FgCC3UOs975vETFmAdcRNFXGLCAzVFMA87ooASrxcNNr?=
 =?us-ascii?Q?uNs5piXy4cAhfiO8ivtN5LbkSNN/0hy5reCVR8dkr7QtHnsS6i2gH7ScQVjR?=
 =?us-ascii?Q?P9t7UkvqGdiymVFr7Vpz+1IRYY96MNCPGDeG3QWhddoFqQOHuGWNr4tZyIhy?=
 =?us-ascii?Q?523HonEmo9KuYUSQlEipf/l6vmGph58fnJXJNsMnyt/iHJsdHY39fNDbmyYs?=
 =?us-ascii?Q?SWl4EDth7uwF3ZmpegT9ZjCQ62cOQ3D5t3C75NMBVN3En2mnPufaDldjURKk?=
 =?us-ascii?Q?Lis+OPeRQXUna3TpDTmgLaKWKjSe5bezs3iQ5NN3OqqUFdn7yGj7Xsy5srsl?=
 =?us-ascii?Q?fOm21/J2lgBTPiK1La3qFp3EqrKDdRWasAtcCwq2lEi9B628eIQt+Q92mZa0?=
 =?us-ascii?Q?QTaTkwYsV2V4m8LinTFqc87726SYenYmaTUOJKQIvI4BdiWtlzuX64834b9f?=
 =?us-ascii?Q?8S7eJhvI6R0Q/X2x7X9aZMtw278BJb3xM6pAA0W6WyMgI/rb6YuXUgdYhri0?=
 =?us-ascii?Q?bPcGaLkynDpQ3WcjOqL/KVr6HtF7RmmjacE4Rt5iELuwrduRtY7uV1laloCW?=
 =?us-ascii?Q?qtysvQ0WorBCaogiyK8zAkQf8G9KKG16xw+syRLGTmbchgTemf9e1H75M/1d?=
 =?us-ascii?Q?24T8it6TFZ+wZjY8QgcnOQNRCVPMrzMjzW+Bd+L/kNGRR9jrcu5BPg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2cf7a5-57ba-4d86-2f7a-08da0e1f09a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 05:19:29.3782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ksraMRAN/gcJ8e60X/6ylope/9E8ZZrYEra9hfpsrlmLAjUPjsJXgj4ioLiR2ElEH3rj6onyOzuXgCjOzzhlS1AVRLSWaT7+ODW8uKXWfuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3195
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, March 23, 2022 8:38 PM
> To: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: BMC-SW <BMC-SW@aspeedtech.com>; Rob Herring
> <robh+dt@kernel.org>; Joel Stanley <joel@jms.id.au>; Andrew Jeffery
> <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
> linux-arm-kernel@lists.infradead.org; linux-aspeed@lists.ozlabs.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
> driver
>=20
> On Wed, Mar 23, 2022 at 08:40:09AM +0800, ryan_chen wrote:
> > Add i2c new register mode driver to support AST2600 i2c new register
> > set. AST2600 i2c controller have legacy and new register mode. The new
> > register mode have global register support 4 base clock for scl clock
> > selection, and new clock divider mode. And i2c new register mode have
> > separate register set to control i2c master and slave.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/i2c/busses/Kconfig                 |   11 +
> >  drivers/i2c/busses/Makefile                |    1 +
> >  drivers/i2c/busses/aspeed-i2c-new-global.c |   91 ++
> >  drivers/i2c/busses/aspeed-i2c-new-global.h |   19 +
> >  drivers/i2c/busses/i2c-new-aspeed.c        | 1698
> ++++++++++++++++++++
>=20
> I always find it funny when somebody uses 'new'. What is the next version
> going to be called? 'even-newer', and the version after that 'really-real=
ly-new'?
>=20
> > +static const struct of_device_id aspeed_new_i2c_bus_of_table[] =3D {
> > +	{
> > +		.compatible =3D "aspeed,ast2600-i2c-bus",
> > +	},
>=20
> Given this compatible string, why not call it i2c-aspeed-2600.c, and remo=
ve
> 'new' everywhere.
>=20
Yes, I struggle the naming, but the next generation ast2700 still used.
The name "i2c-aspeed-2600.c" may not adaptable.=20
Or How about name it to i2c-aspeed-package.c due to this is major feature
For this new i2c controller design?

Ryan

