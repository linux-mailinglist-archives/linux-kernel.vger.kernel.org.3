Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B73567193
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGEOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiGEOxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:53:01 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30080.outbound.protection.outlook.com [40.107.3.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE56E13F07;
        Tue,  5 Jul 2022 07:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hL1gG+38Y++VjgH4rivN+1JQKSFcsGITRiyUqx9Lh/MwFqi5YEjnhwyHoMlat7zG4RQBTHxZ5KrvqSD9VLB7UetS/K27tn1gJuHmG3LH5UC8lvuh3jBnCVfMhMeZ8Zv2L/veFxQm43px12EUgmP+/edQSSLDofNWdaRJj/aG7rFtgWRAVwM8u82UxkaTDozC5QwTBC1B+2/0LtA3TDGa51jtoHkrDnBQ47pypeoF3t7ciQ+6h914izCjS2fKhiIIlsqGLez36tqvpAgCLSxQdOVykZEPiTG4ZZyXYGC/JSRIISmZLB7qOjj4SOMqUSL2tFlFNdHkR23u2ApIp2xwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRQMhbLwZkLaO83701u0uevCtn2dRM8BYPHF3++C6PM=;
 b=IbrHDPcbzHnq9CS2oD+6158VEhGpujJSRHLLcvi6DXoOqfNwuaTUy3PXQmjDdWm/F7M/WpJxoy9Xbd9i82G1771EGLU+j8Gr9u6j4MmaB5WMBCEUlIbP/FQilQbFMekb3a1vJdrZsZQoGbtanJrl1lPjSYbz/qctI7717yD51dCKe10LxkyC2vjTkubqVa222TRU7afb+A14mZGB+PFLfZ3VwivvTCFfANOOmKWttGKlodYOgbbry9pF92iWwMDwqTuip4JskgtI71lhGcn8xZ5KYIuM6OvlOAS/9CLuJFEZqOSREQD7FaJoU7/W8Hz1QHILSvKMPNn9TxyjieIDhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRQMhbLwZkLaO83701u0uevCtn2dRM8BYPHF3++C6PM=;
 b=LNsT4k2OXIQu91ICE2nU/DscvQ37hAi+lCqixsyLgIbFGVbLFu/ydFg0MvH+tMdhRG44aLcb3KkV2cMGgC3xkJA9Y96iYe3Exs6MrtH1XAXnn9+sOTjFeddPwGYc9xCoT8M8IIwgkEU6vTjCpp2BPaSLd+0V4piAmIniFjk8Sig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AM6PR04MB5335.eurprd04.prod.outlook.com (2603:10a6:209:4d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 14:52:56 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 14:52:56 +0000
Date:   Tue, 5 Jul 2022 09:52:49 -0500
From:   Han Xu <han.xu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, Bough Chen <haibo.chen@nxp.com>,
        ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        singh.kuldeep87k@gmail.com, tudor.ambarus@microchip.com,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, festevam@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Message-ID: <20220705145226.tarpvub6bh67tj63@umbrella>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
 <1657012303-6464-7-git-send-email-haibo.chen@nxp.com>
 <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
 <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6bdb70-ae96-4c4c-d3ba-08da5e960c04
X-MS-TrafficTypeDiagnostic: AM6PR04MB5335:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5iqDlLR5Y07n9j0oaJhNiR6IsLbEeXQArTtClg3iE9EGc6zO+wAcohPY41uj/25nvYnD28hBVBWDLg9d66a93VtnvjmADL2FPs9pkInsKkoGdoFtaj9/Dca+/uoZaXj1iH35e5TfYuHH6tBKmh+4zapjd5UeVBpVkgmUlugScTpCRCnGuzS0CL5NVRQUoiWe40RRXe0LmOQir9yUucDaQJa+MGbCsgWn12bzteKQgNgsHfvTq16dPBoH6AXaIRPR9EK2g3vrjloR7QIpL36vqmi65EN8KKoTwwLXU3V+0QSG6X/kXwPZasyiX18Mk6mRuw+DF6XQDpLgb4emVqk3ZeU57EDu5Bbs8BsXvK4OzXlaksedG7UlqLop7VlmtW7/xu+gcM7I5hn9HRRwBTayXnMdOG3+DA1U+gCu545OiFel6jyie6jHNOovEsDM2+QA0AT5cfX0KMbKtDyEcLr9d+UKmrvYIiBU1Pr/SNRWAPdr1TdgOO1jAKsS1QVY0te6862Eivsgs3/HAr8bfHfDgLGid6zVjuxZJ1CcKU4OJf8/eJDv3O+coeMUI1saww/iJa8V+X/emDXmx8znoM8h0KsuNE5/iuVOLEg3SO3/u5dusky7zwrQXsscOR7ALCy9zovsjGrvoWw/1no33xl0lgpZduTfojK10lPUE1SFnVqSAtVGqv64mWngI24jz0U1sUREcJJ1Yd7gDBhKN+6DE0X9Qmppe6vXXst+xlmttr0RxZijNloO/F9dD+Cvlp+XyPOeG9d0jYkjKI1niu+hHdAojvdINgspumjeqioERAN6Jc7yR4jrMInUKkyq3Zq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(39860400002)(346002)(396003)(366004)(136003)(54906003)(316002)(6512007)(52116002)(53546011)(6916009)(41300700001)(4326008)(478600001)(6486002)(26005)(6506007)(9686003)(33716001)(8676002)(66476007)(66946007)(2906002)(66556008)(6666004)(44832011)(38100700002)(38350700002)(5660300002)(86362001)(7416002)(1076003)(186003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?37Gp29kpAH/6Dpy6XFP7Pg5EDtA5FoyHKy5+aNJWV6ItyZXRwEFeQi4RLbBR?=
 =?us-ascii?Q?Yok6koZGB1lFIFNoVxZ14SLA8z6/9kKcZs3sGENKjP3lFWW3PDiIiFbeNiNB?=
 =?us-ascii?Q?wGV2ZNGgq/mHzdUdETfJPp7qmt9GaGdBst4rSQxmRx7V8LhukFDqDLuLnNPy?=
 =?us-ascii?Q?Vn8Hh3J2XdPfXIJ74sEF2S8VRilDOrGjCWCOIJw65hGAqgXG0FWsyZE557ed?=
 =?us-ascii?Q?XexTCKGD06dhjpNIIaXkuRmHWWz90OwMBxWgkkwdu2covUN7IqKwqELacviN?=
 =?us-ascii?Q?hdUGGMojWcBy1LVK+btU7XZDUJ2DgDv73+KejPvoe8N7Ds9kbsJjJrsUN93y?=
 =?us-ascii?Q?WpcCOUl1BlQKqcjJxsotJGeu+owRtm3w2Wav3CgVanmdg+L51+NBEhDy+n4m?=
 =?us-ascii?Q?eH2eabtuPGiB3iSlkY1iBkLImsWB8snft3NrSnduGGsrg43uY+iGhp9adtLJ?=
 =?us-ascii?Q?aLpO7twGsXrLaN2n3jRypvM6n2m468DB3ojGCRwSMwXmkKaz15wdybQuNkqP?=
 =?us-ascii?Q?TcdrclwojzYKm3QDA0FheXBCy+B54S+0jXpHG6Cyiy1O0G0ayxicDj9PccNj?=
 =?us-ascii?Q?EdXikygodtX+ocBeak7PasNZwgiAqIKxTLtrlctkuuYXOIxYJv6pauVESG6v?=
 =?us-ascii?Q?Q+roq2QMt4PC16FiZeObsrtk+UVlWdB3axbfEnHP8lOZxDikJRgel4iQmDqQ?=
 =?us-ascii?Q?ZxpL6nAv+upyrPd1NJlA3o/3eMw4PC04a6gySdlXZLUjShonAzUy4LL2pITy?=
 =?us-ascii?Q?C2MmLL2msHjk9ZzhQUVPZFsj4eJcyrkzjmkqzUhFHcfnSqmZTxH4/11sqb6t?=
 =?us-ascii?Q?EjT/9HRbIiZk2gSZ4kgdo+Rj2CjTDsvkHY7f6CejpSpTW4A1YxCT+Gw4D32v?=
 =?us-ascii?Q?h/qNkags76+Zir6zpIrQRIIBKhOBsRqxxzYi8PIoriPrs5HNDBnJuWBcEX1c?=
 =?us-ascii?Q?lDSjl7iNpfDtE10zX2+5Asi4EgF46asegxFLyyF24iMEZ3L0l8GmBYC8OCPD?=
 =?us-ascii?Q?g4zWcTyarSpgQoam5YvQ57wiEcRp7InHwVtl5d5Do0YBe9YXXhiS9U2A+eLO?=
 =?us-ascii?Q?FUShpN6WB4mrnPuLlPifaKq/J/4s9q6xc/R+Ypi/kZfk12OEbIWVjHRKolBl?=
 =?us-ascii?Q?lk/LP26jwMQSQcclgFSDnwAa7L+0hOXOBLwG3xhYBCernU+AftaW0+NXSr59?=
 =?us-ascii?Q?1tUyGbnan91rjlPfOhCgCwPitqVKCKx6HEEDXu4OSc0zseEKX0hAzdgf7ANh?=
 =?us-ascii?Q?qYYAXcZ2WJUUrC3FpAuT4lUwHVrsD3wa+b88nANH6Q9aVmjNPeM/Drgf3mbf?=
 =?us-ascii?Q?gyHhZpS4ARNgLlFGSsEBNWdTiNWLAeO/BbE7meB2qouAZkLZzjNtChe+rulc?=
 =?us-ascii?Q?GdaCT0hZHKBEdxotRdJd2I91ySYXR+scHZuqNZ/dEPmeoDekhmJAdxI9GBos?=
 =?us-ascii?Q?hknClZ6T8JPO6PUVaPjbb4v0lgdoRCwTAjvjbcXXEP3N8G/b+r0QscOtxEmP?=
 =?us-ascii?Q?tTgs/FhIApAW4MR8Ykorp8nN4IiKuZmT4tEZIKAyH/PRrarz/lYUcL6wK5J0?=
 =?us-ascii?Q?RlkfTQnMriHPTYW4Vok=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6bdb70-ae96-4c4c-d3ba-08da5e960c04
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:52:56.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlVIuD5RCAE4g8z4iTuX3W896mZ42iHhthdSwl/yIm36fYyX4h4Y0gyMD6bA+6HI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5335
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/05 04:12PM, Krzysztof Kozlowski wrote:
> On 05/07/2022 16:06, Michael Walle wrote:
> > 
> >>>
> >>> I think you could use here clock cycles or clock phase, but then it 
> >>> has to be obvious
> >>> it is that unit.
> >>
> >> Hi Krzysztof,
> >>
> >> Let me clarify it, in the document a term "delay cell" was used to
> >> descript this register bit. Each delay cell equals "1/32 clock phase",
> >> so the unit of delay cell is clock phase. The value user need set in
> >> DT just number to define how many delay cells needed.
> > 
> > Then should the unit be "-degrees" and the possible range 0-180?
> 
> Thanks. We don't have it documented currently, but the unit seems
> reasonable.

IMO, use the unit "-degrees" makes it more complicate. Personaly I would
calculate how many clock cycle delay needed, such as 1/4 clock cycle or half
clock cycle. Using degree brings extra calculation.

The granularity of the clock phase change is 1/32 of 180 degree, but the range
0-180 make people feel it can be set in any degree in range.

If I describe all details of the relation between "nxp,fspi-dll-slvdly" and
"delay cell" in patch v2, do you think it's clear for users?

> 
> Best regards,
> Krzysztof
