Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE90E56706F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiGEOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiGEOJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52E26D7;
        Tue,  5 Jul 2022 07:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5c/aRHialt+QV1HKJ3YyB+RSkEljSEsyjIPBjJJBMNEGFrDKtbQqyZsCoqPxOVSg4OruiwHCsHLZ67oKyGfsgBPXFX+ZUu4b/0Bvb1W7c1xdmTHA40F+4294nNQSkIfyIYQSyWA0807BvTHgCqmpeg8ejLP8aY47pV+xc7shQxw1XEo7g0ovcnbNQ4Ox926IzeFdcmqODZXssRvILAdmE9jmY5H0PeGQC+GPkSHgmx03md6kwk3t1tBdQxSWxajQpLkebpAv2f/pN0ugsS6Bgu94dZ3OFBR/6ATVwbLywvkpsp0i3wKVC6wxJseCxyMJ6eZgfbY1ag2FVBoEXEqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxZ9bRRqRpMwrxomIuu0LON4WUAoQJF/ZQOHjnwn6xw=;
 b=EL2Lfr9ItRu9BY5ERHctdC8VRkI8mUpxQiGnSjpYfwTR1yvG8Mj/P4wJ/q0XKdXHUW5mZtP1qiUulMWF+O/SNCAbMuio4MQjwcQul/DVYHxIuXzCDrw8/899MxPAI8DRBng7jemDRvFcgLxWoZ7PQawNNfwbRKBORpdDKUlhJc7ilDInLAqmtQqWQtdW8QinM5OKZj+EfCgMYj9zCnhiMb4QcsTV/rdGz8+zIQGxK4ZmiWgaShn3AS7nFYclIfmxFRVa3UtXofgOzHndHjdKJNLk6I+ddtUNLD7euDPXFoznF7D6w4iYlmtG8b9XpHZVi5HblhPvged4SmgyHNORaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxZ9bRRqRpMwrxomIuu0LON4WUAoQJF/ZQOHjnwn6xw=;
 b=eKl4MB5VZRl22OSNx5FnJSt8NSag/G2Dqyh71RvAwZtUwDM3BdaEsSu2PFRTe2CXncsMQSfDl6G3natGp0cp450jCkSQGDMBHG5WrbiEV5fyO6OWWspx6j67QMPkZ3OnlewJzNfXepBXS+xquxI+gHp85oddNKx7pWJG6FhuSjE=
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DU2PR04MB8821.eurprd04.prod.outlook.com (2603:10a6:10:2e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 14:00:37 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 14:00:37 +0000
From:   Han Xu <han.xu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bough Chen <haibo.chen@nxp.com>,
        "ashish.kumar@nxp.com" <ashish.kumar@nxp.com>,
        "yogeshgaur.83@gmail.com" <yogeshgaur.83@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "singh.kuldeep87k@gmail.com" <singh.kuldeep87k@gmail.com>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
Subject: RE: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Thread-Topic: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Thread-Index: AQHYkFF0qJujufsOTUOD0eIhHoBTUq1viBIAgAALOQCAAAJgAIAAKZ1ggAAGgYCAAAdCYA==
Date:   Tue, 5 Jul 2022 14:00:37 +0000
Message-ID: <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
In-Reply-To: <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5fd2f1a-8373-4ad0-2e9a-08da5e8ebd16
x-ms-traffictypediagnostic: DU2PR04MB8821:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8RXgbY41TitZjIVrt7QCyBSirAyuTUX/WD5uiq7JVG6N282Wbi5OTHVQgPRWoQyknTwR5At/9I7paPsAU8Pr122NihwFaZAt12pwswc1sJNhWMOWKflp7m2DTViqPWgnVqWT0bkLx/jJ+kI0FEe+sqKXZgZILuKDSEWdYEqssGpNC/IgkjnjRrQaaeggMbh9H3RELiqUdo9+8Yc7WVI8yRz7RYKD9kIu65f6/BqkjpQyV7NiEPUfg0drQ+DscXu60XXyKfXUXwpYqIhy41ph5UbitMPsAVc2nuidorAB6xvIhVf22aoeYhlls4QNbHL6MeL+GV8oQi6smT5tKPH4K7saW9rSLjCv109ND3OEM1w0x01N2IlSOGvsQiAnRBY15wMgtBLv3QnAHX8k6x4mZX6pzuV6EGucUyO5WFYqlJTrNbhK9d5Ot11vysniDceA5AM/q0Gp2VrcKAkaWwBJnDusH1nne6x2g939OF2e7KOlGxowOnX0SLwrGRQInfJfwVKCASFpLfrgMhyCLHm7G31DBef/wRpFNqOy0pHkPGNjSEoCR+STugQdHpc6cQDtK7AIBQ1yI62l5bydKQQ0+jL0wQal86omMyh/V/Ji3CBsSHk07jdVf9q65rszEErHg1+g7PuTR/gAJ7nrd4Lrbw1UWkvICXNaPdPDjVJ4t1M04l/ql+kpQAY40XTpvp5FcRdmYylnUwsFZrbQk/sg+qWI/V+K8GKFyTwAykG6DhNnkRuY3rLWUP7vgqKf5/TdNKpD2y1Y0d4DdiVC8FCctMPs3PDJ+ueXnAGzUoNnt80YYz7TJ2hYBOhs6vWtcXXwofD//X2XiwQtHNEXqSBpVETClKzheWW4r5BNHvGlYTs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(110136005)(33656002)(86362001)(54906003)(52536014)(316002)(55016003)(38100700002)(71200400001)(2906002)(8936002)(55236004)(478600001)(6506007)(66556008)(7696005)(66476007)(9686003)(64756008)(26005)(66446008)(4326008)(38070700005)(921005)(83380400001)(45080400002)(7416002)(66946007)(76116006)(41300700001)(186003)(8676002)(122000001)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vJgDtwWxtyN0I6VWpHsG+BDes+WIBHtppQFkf0gTDf0D2Euef52QfDbCqc62?=
 =?us-ascii?Q?O7iRxaL0P81PFq3mUyIFI2KEqoWQpxTaifaavYOPYKVSyJ3PCcRdWGNKkeva?=
 =?us-ascii?Q?jnc9ApprbB1BfhHYzIXDZ5ehUEN1db3AN0j18GSp28LWnOxSbmDoD7y8zCrr?=
 =?us-ascii?Q?sThDoAdILo1alRF/NDpDQf5eyCxP3vRybuh4+o/aWxQ9jpSxdd09+WTlw06g?=
 =?us-ascii?Q?olUG0FFP9DAYbPfQZXQplgZpGyYDyjjFOkJkw1XoY/z1dG6auSzRG4yIxd9W?=
 =?us-ascii?Q?jUX5BGqzXQ8uRkPfa+AAkYKtVEBw40Azy+dBl/FVsctik45b/eSz29U+Pw/l?=
 =?us-ascii?Q?WR0v1X3G4il2AtYi0ZwKx35UEushUVVE6k+NV7WWccOK7sr+CLKECtnOAdZG?=
 =?us-ascii?Q?GA4NF/tzAJVOrNo1D56FA5dzWWkkSoLwcXmXhg/hUazSTx/nFKFofMbtQyda?=
 =?us-ascii?Q?ZjKxKObHZE/bCb70/lXaBCe8n4FI9luhTWVsNkH/nnJpPlO38O12JKP/vHTi?=
 =?us-ascii?Q?obBhcmt3eB6W0BkBLP5Y2zbHFydWo1EB3dGT1oxc3chWcTvjrOU64MBe2yae?=
 =?us-ascii?Q?IUIlZUZ3ZNeGunzyDQfIYDehbKcqFoD26Den7KO7WNT/OW9LONzU8mdX3VTm?=
 =?us-ascii?Q?/S6PpgQYYUeIe4yGQkXjw67uy0+3r92/Fb47JgzAAXqwZSX8xNyor/ZybPX8?=
 =?us-ascii?Q?Gs5p3VmwYni/D1BZu+59E+gTmTO4vcleTsPHI9ZkbiLZXIvdzstLH/S23Gp6?=
 =?us-ascii?Q?6x5fnE5lya7M+YxJ8SxBOcEBu+QAhlQOG8Y/DqbkmhxMe21kiapCckJirwLY?=
 =?us-ascii?Q?PlJ4SY0vNuebsA03HjioDAkMC+/YbrhBWPfSxatWUncUbpMvWWv/wVoAmJnd?=
 =?us-ascii?Q?OshGyX7yPscDTFqQCYgGeMk1m+oLqpsmQI4xYFP6j88FheSNGLHcYE6YJx4/?=
 =?us-ascii?Q?VDsAkmB9LuVDyEnOsdBz/qGkR4P9ygHHfFkfIqYTu0T7qiSx2TuUe5HKM1cD?=
 =?us-ascii?Q?v5iY/dTTa3N6s/hXj15w6Gd/mB3ZeSnIpNGoFrxqpfE0o1sqDOXf0HMy58VK?=
 =?us-ascii?Q?2xHGtpHfyjDbHC1hf28EWY2jYQeAfbeJEGSuPHfdmV5M648PHRzddVm2WSa6?=
 =?us-ascii?Q?dMt6Nivkg8hlaM86nPE/xDIx5Mxx8+/ixpBKD9yu+kt9yp7x+3hdX5Ah4mAx?=
 =?us-ascii?Q?PmZRCAOh6MfJ7gr6G/wDNI3cUM5b/ngkDzcEVYkzPYfGIzdbrOg6EhfFT8jL?=
 =?us-ascii?Q?Ru3vZZ+1LxfkCnvwbqrfRZx2jtABcVq84N+lAzjUwAUMQz3vTKZEdQBypFNm?=
 =?us-ascii?Q?YrKmR0wHkFTRA21LE9ep5FjZ+FgGJnll4w/i36a+7s2l2jXO11IuU9hnPYjo?=
 =?us-ascii?Q?nnmXRJ2kuS78G1kcmOaJsoGTHzeuEghm5S3P+gWCD67LPagS/SpB6eo+cnQW?=
 =?us-ascii?Q?l6KiySzBGQkIWq2wIIhDNMXyZI2P971u4wysasG7Goyq0v2w7eEQFM5CKYmJ?=
 =?us-ascii?Q?XDd9ceadowp13kaqALgfhGl+jjfxRyg2ISIgUWmzGHWpN+FH3A1FCXbHeZZc?=
 =?us-ascii?Q?BhakO19Q3+YtMbPomek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fd2f1a-8373-4ad0-2e9a-08da5e8ebd16
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 14:00:37.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCwaOY20+9RpApNwbl/jfdpVrk8jRvU4ldeBc9payoShnsE3sLN4N4HWXWF5Ps+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8821
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>Sent: Tuesday, July 5, 2022 8:29 AM
>To: Han Xu <han.xu@nxp.com>; Bough Chen <haibo.chen@nxp.com>;
>ashish.kumar@nxp.com; yogeshgaur.83@gmail.com; broonie@kernel.org;
>robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>singh.kuldeep87k@gmail.com; tudor.ambarus@microchip.com; p.yadav@ti.com;
>michael@walle.cc; miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.c=
om;
>shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de
>Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
>devicetree@vger.kernel.org; linux-mtd@lists.infradead.org; festevam@gmail.=
com;
>dl-linux-imx <linux-imx@nxp.com>; linux-arm-kernel@lists.infradead.org;
>zhengxunli@mxic.com.tw
>Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new prope=
rty
>nxp,fspi-dll-slvdly
>
>On 05/07/2022 15:19, Han Xu wrote:
>>>>>> +  nxp,fspi-dll-slvdly:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description: |
>>>>>> +      Specify the DLL slave line delay value.
>>>>>
>>>>> What are the units?
>>>>
>>>> Do you mean here need to give more detail explain about this properity=
?
>>>>
>>>> How about change like this?
>>>>    Specify the DLL slave line delay value. The delay target for slave =
delay line is:
>>> ((nxp,fspi-dll-slvdly+1) * 1/32 * clock cycle of reference clock (seria=
l root clock).
>>>
>>> This would be good.
>>>
>>>> The range of this value is 0~16.
>>>
>>> This needs to go to schema instead as "maximum: 16".
>>>
>>> But still the question is - what are the units used in this "delay"? ms=
? us?
>>
>> HI Krzysztof,
>>
>> According to the formula, the range should be 0~15, 16 should do nothing=
 or no
>delay.
>
>Sure, just add some constraint.
>
>>
>> The unit should be clock phase. In other words, the delay can be in rang=
e of
>1/32~1/2 clock cycle.
>
>So we probably misunderstood each other... looking at the driver it also e=
xplains
>the confusing. You encoded here register value which is pretty often wrong
>approach.
>
>This should be instead meaningful value for the user of the bindings, so u=
sually
>using one of property units:
>https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub=
.com
>%2Fdevicetree-org%2Fdt-
>schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fproperty-
>units.yaml&amp;data=3D05%7C01%7Chan.xu%40nxp.com%7C0ffe3d706e064f14382
>108da5e8a5add%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379262
>45564450475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
>2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DQ4
>SfVnBN%2BQ0vYKJzRf%2FXZkCA1WGyPV9doFcb%2BLSKx4w%3D&amp;reserved=3D0
>
>I think you could use here clock cycles or clock phase, but then it has to=
 be obvious
>it is that unit.

Hi Krzysztof,=20

Let me clarify it, in the document a term "delay cell" was used to descript=
 this register bit. Each delay cell equals "1/32 clock phase", so the unit =
of delay cell is clock phase. The value user need set in DT just number to =
define how many delay cells needed.

>
>Best regards,
>Krzysztof
