Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E4C567113
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiGEObO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbiGEObL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:31:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE44221BC;
        Tue,  5 Jul 2022 07:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsrmnRL17YVz4XtuRu3WIGlYhnuShpOSTiDAQxul1veo6zRUMTQkxDcygTsNnZBvKPJeneIPnKzLZ6DzaaztevVoKPsAjRZRX4pjY9+h+SnbGFv0GRVi7W3QwRsD5sQqz/59bwSx3OIoXXm8NaWjV8K/QPm4Otk6inU8eGh03zl6QsbI7avNC0vWFSp6ANgCK+0/s0Ens4tf1YY4+DdHZQcJu029NYZIRh+UXz2lfUfI8DjP3HdAEOkUGRuX39VcYZpLSUtjXXt7gn36zxQDOZgcebuLgi7IyNPWW5ue/FCeW1a7LehUgpK2cViSeowiFq7OO0AqJPh9TTOea/HGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGsMazPhNFLMMuStJlkFzTH9aGLRBUC4C1Tdwog5Y3c=;
 b=Y/EMJrM3k8Pf5qMVMDz2WbSoXeVcDPRBRG+PDJu8KKd71ke2wnANTd+JAlupuMk0NSZxBNESiw5GFZVzR4GFrL0hYoaBktF22V+LkZCjutxiiRWH/est9pcGyuEPh9DV3B20GLS410QoUrvK/jC9xT/ak2DZV4kImgTMbKq3ClZXmR7yKs7jhCjYQM4PVk2v+eWVCv/fLh+OWLLtmgbbNQnNLg/C/fWuC38YX+DELdg6ArYY6xs0qPMu7Z2Ll8RbX8iPLrQ1gTNsdV0/ebmw1pbtnt+WIDmtDfE5fmpa3hfunlxBLRYB+8Ps8Zf5bzlDTF3aNI4ujY6RnIASQSxblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGsMazPhNFLMMuStJlkFzTH9aGLRBUC4C1Tdwog5Y3c=;
 b=ppVgW4BAPxYzBn0DL4s9AuMdno/hf5wTcuqL8KlxiocQNZ9JMRfbHHd5EWAl9d3UDMbiUnMzugC9rNL72aIY1sF9y7WLgrKQdGbLP+DlTD9rAmckKMslJWD549E4Suxekc7kZDeZKTTPkHYC6utTdCiUQooV2B55s6PNrpJRQu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM8PR04MB7857.eurprd04.prod.outlook.com (2603:10a6:20b:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 14:31:07 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 14:31:07 +0000
Date:   Tue, 5 Jul 2022 09:31:00 -0500
From:   Han Xu <han.xu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bough Chen <haibo.chen@nxp.com>,
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
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhengxunli@mxic.com.tw" <zhengxunli@mxic.com.tw>
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Message-ID: <20220705143100.kkyjzllastptaoqe@umbrella>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <777026d0-578c-500f-7da4-0e81fc211df2@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777026d0-578c-500f-7da4-0e81fc211df2@linaro.org>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bdb9048-7fd6-48b7-1a3e-08da5e92ff71
X-MS-TrafficTypeDiagnostic: AM8PR04MB7857:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvDgr4uJ9dJ7aPQ9/9N1g+0HvDEUc3GU/dlEho7jul0FiZgKV9vFfRqt0rFUHpXfLNjkYH/mZS/acdQmJtzOXknv9PxiPYDfepRVcGR/vqDsnyl3g7XD/eETT20eKUhYbLd5JAXVUvOjZQSfLsi3oB1igriyIJ8S06ESXlHCunig8FZlruKpzUpWZZzvowGnPedkXIKicnaL9DJwjWzPt2PNcUw3KjPmgy1jaFy6laY/XLKOtjPngeUrhNG1nHuGluYGZhaFOvNupPfPDMl5bEIXyaYO1Gon3LhBTNwUvPnBnMeTAg1D4jX+Isbqs4PbciBQJa2hMzkZ8b6GNoe7D9y6RrdGisehiGF07onlqggjQIEeC1BXF9RUGVw1yOdkbjy7xkUcSGZ8mrnpx4rH4Gqo34WyuDoDmvwMieBOMncVDGeRL0E9tlXBy7rzSOQHWH/td/vBJ7uehfrLcKbQY65shvlnDZkZekjYuDPi07eqj/gQ9l2MoRMMRI0WrPqX4PMC7QHtN6npbEMKoposSf9eiGVCAioqAtJli2r9Q4sFHhKEdgXBoIfMZHOEgI8Jj8+GHoi/N2LUtvHjqc7XxXiLJK1NMUekpO3Cl+5LaVYSax/Tkf8XyYTp1zfoLYmefdpR6SIBgvtqJVF2GPSqmVL2MJRbnbxb8NeA1A2rz3m6ypejZE5GiK9jXxZg2lKpecbp1Dk7Euh+pmcqJQ6hQlQ7/qTxkwq4awBMyhvBFERSgOIBSzle8/9maZf9gZenPHx7Uv3oL9vVjP2jgaXz3gUpV5pM8oCHkkcoeZdEQVpe2kML7FPUDBoB3Ap8RUdD0MYvBUlPCvHtsSo9rIC7T+x5a/xmuM1SiulXY29Qgo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(9686003)(6486002)(966005)(86362001)(53546011)(6512007)(26005)(316002)(33716001)(66946007)(66476007)(4326008)(8676002)(6666004)(45080400002)(6916009)(54906003)(478600001)(66556008)(52116002)(41300700001)(6506007)(186003)(1076003)(83380400001)(38350700002)(7416002)(8936002)(44832011)(2906002)(3716004)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jYzRCuqIYCE7yp3AzYvFsqv4A3zNcjk9RCTTYAS6JFyVGgSGmcvUrFSrLr2Y?=
 =?us-ascii?Q?Y9nYoPrS9GMDfZo0BaOWJaFqf2hfskuMtXGFxIdbZ8i4Pai9JqafEs1yJOrM?=
 =?us-ascii?Q?xeuA3/GjFunJAhTXFys8jUEqS1WdtNBhb6UDHUeDAZGUvd8se5MRvdT5kFAA?=
 =?us-ascii?Q?au9SuP4UDZ67G4o56OKd0XefmG+e5jWjYU6LT28vSNRwx8KToxBiu8W/sVdT?=
 =?us-ascii?Q?iIk+nQJvaoDxVvPduusvwFUHIZN7Ocb/sv1EkSfPAcN3Z5DUgen5e/dLaF7y?=
 =?us-ascii?Q?v+YFuKilE9J9hohjEHSqjlZZmKY2wGfuFpHqdKM0KLMzWKUEPGi6QDoZ2Ged?=
 =?us-ascii?Q?LtLRsPJngp7dNVu3imTRw3MwNm0Yil0DWMwMmV0eoV4HMC3tbrHSL/AOj6/f?=
 =?us-ascii?Q?bCEtYAOdz/WaoxNXW/g41aUBHiXn56IPqY3vtE6SdNEQyOMb/Ifw4/jizS1L?=
 =?us-ascii?Q?U0N+D0YgGsKTyjUHlzhTaRqXvlJmYHp0ReRfBQnzMXQRrrwGjyBehVwrG0KX?=
 =?us-ascii?Q?nt7NMwSuT/Px0ZAi7N5dzHuy2bYz+CMxd2r5jLRmnICetcb+GtWJLYBNu2tZ?=
 =?us-ascii?Q?XCo3PjScPv5WCIi2dTNzCLtu4sOz8gVcAx7oplNt7zBjOOCa/1WSYx2sGknt?=
 =?us-ascii?Q?jlf/n2nGUOwAFDZT5wVdO5jJyBdFABXGuTnbxAQpSw24kyomZCBSo8FE8qHw?=
 =?us-ascii?Q?Pd8UUQjv8+D18hLv9Hr8h1VRjg6UbDp2WWluIkYPi0DVpcfoELJJZblmLbY9?=
 =?us-ascii?Q?GJpK+RLxycSGyfE1atJDa/6P2Wq8Iy13NplNG7E2cC5PiqZLhiCoqdTcVanL?=
 =?us-ascii?Q?JcFh9lqJZgN78fSZLPnfjKcmwpzm2XlIkreThJr0EApdR5tgLI/xIZTBAwhd?=
 =?us-ascii?Q?w+XDsX4BgMZiMJ2JWoLGqSAQFXQsTj6Vl8B7Wl9tFlh1AKLJF/QEDnTKgZOH?=
 =?us-ascii?Q?4DynhiApFWPUwjveAwu6aa5FLI3nnd5w3Y1D7z//VsH0MeerwHfT8p2DMOUt?=
 =?us-ascii?Q?OdTLNuBFAVJr6fwPe4w7Xu3nZrNHLIcdQ9XynEOEOKkl9GcaVhd8Gmu4oxOE?=
 =?us-ascii?Q?7G52Oy4iBYNvwUpqciazVJFaIy0Rn6fuAbvhb74M/3YKmlAgihG9PrHH/0ZQ?=
 =?us-ascii?Q?5TrNq+C0LlrhmmnxuujlmWXrfXi8pKN2rvKQHJRJw+Tc1yLBy5ktPzlt4X2Z?=
 =?us-ascii?Q?3CU35314gjNs7r7YyNHtdkBVH4187RiDrbeStGZSfRx08Tv1l7/lG/XUyYqf?=
 =?us-ascii?Q?25B3yzFyzf+6bMOsHrzIGbfKtTTRrxIiJFUIr4DX92ph9oix8H5fRSzgLhgz?=
 =?us-ascii?Q?g4Fhe6mHO2QEip+t8SlwYTcTQJJYvR9Rq+oTUUmXECe9kOhkTb80sv5ROwiU?=
 =?us-ascii?Q?nH3X0+RoNhxrIn0j33BlxmIes5v/3kc5AmQZP/aZiyDCdKVwN7ICbYwP+mUt?=
 =?us-ascii?Q?7kfTLp+khGS8ADoBVZV7O9U2UOoVRSyoq6rM1IfaiFqmTow2m76yCdPxQ0cH?=
 =?us-ascii?Q?B46W+2/vUj5ZD1f0TC2qXTZNvDP7nerrhIAPzSi0vJmNg6KZnvpSp7CNs/fm?=
 =?us-ascii?Q?oUbbHm1w2gGk0I+6HGHf7gCw2eHKkC4dARfVoqZy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdb9048-7fd6-48b7-1a3e-08da5e92ff71
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:31:07.4246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJ5zFiB35dBN/G9zDPAW8WSU+91C7cPyHzl5eggXO0APnAq2ytrCViFWGWTYVUmk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7857
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/05 04:03PM, Krzysztof Kozlowski wrote:
> On 05/07/2022 16:00, Han Xu wrote:
> >> So we probably misunderstood each other... looking at the driver it also explains
> >> the confusing. You encoded here register value which is pretty often wrong
> >> approach.
> >>
> >> This should be instead meaningful value for the user of the bindings, so usually
> >> using one of property units:
> >> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F&amp;data=05%7C01%7Chan.xu%40nxp.com%7C8b8e3e6291c24579020308da5e8f2916%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637926266207468995%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=KHgjKLX7M8CYfJoWqpVhNdZc%2FlZhZxp6CuaPTUYgwE8%3D&amp;reserved=0
> >> %2Fdevicetree-org%2Fdt-
> >> schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fproperty-
> >> units.yaml&amp;data=05%7C01%7Chan.xu%40nxp.com%7C0ffe3d706e064f14382
> >> 108da5e8a5add%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6379262
> >> 45564450475%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
> >> 2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Q4
> >> SfVnBN%2BQ0vYKJzRf%2FXZkCA1WGyPV9doFcb%2BLSKx4w%3D&amp;reserved=0
> >>
> >> I think you could use here clock cycles or clock phase, but then it has to be obvious
> >> it is that unit.
> > 
> > Hi Krzysztof, 
> > 
> > Let me clarify it, in the document a term "delay cell" was used to descript this register bit. 
> 
> Which document? The bindings (I cannot find it there)? Commit msg?

The SoC Reference Manual.

> 
> > Each delay cell equals "1/32 clock phase", so the unit of delay cell is clock phase. The value user need set in DT just number to define how many delay cells needed.
> 
> Your bindings did not say this at all.

I will explain all details in v2 patch.

> 
> Best regards,
> Krzysztof
