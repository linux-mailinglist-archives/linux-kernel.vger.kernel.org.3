Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F756737D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiGEPwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiGEPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:51:48 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF351E3CF;
        Tue,  5 Jul 2022 08:50:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaFOGMI6+RvSN33pShQYA0bZ8U6MGBLp5RH5QDba1q7qmnOoCTqoGl2xB6KkzTDYmhxW8aFDK7Ao0q+2UX6B61TvZAZWlFzoyiFhfvsBlmY0W3QUo6W2LyheSRV/ymT3ALflkuzGmEIYDs1DN4f1T+ljK2vyyES9HyPAnjppTjwjvi/3RmDagbKBBet723rYV+tkDf6fxuseWOVZT+OvM9OwfS6MovUIC9ufZcebsBnBxSPzVto+cpfkfeVtGsDawctoOGsO9L0SP+K1ueIsMN25wFFEMoel20HPBJLj6HnIPgINlWITu03aB6IqIcatx1exf1CprYYSXmxaUJvoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew1u1ODITEMy6g8Dy8clqRvrkYxspm6QD3C86Cx7Vxk=;
 b=Vv5mYGbwQKsAkxh3cd/rD+CTxVm2tSje++2KC6+6EXw2VaFOVbcitKO3qkvwDa8CDehaHm+P0MGmkhehODqyX2yGZdq0uQYXmoKwU/mjaireZNSohvv1VMQh3yv0v4vrAYfxzj5yrqAIYrKWfCZ9emzqQQvbegVyurvq95tLyBuOXaJzr7pNTyqyjiAGEYGCLTqaYJgNV5XUR7IFGq+KNXmnpkl/jQ50A3iiUr60XorYzCabW+uFOA57I3aI9o4DwhGPT6LM3TPOPPEqyFuQ9lowAfW5gbIRjJ4dJeD3qXx7AQYHmbr3GA5ksOOhTAKOuTOOpe6yrPoU/hIcxWlZwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew1u1ODITEMy6g8Dy8clqRvrkYxspm6QD3C86Cx7Vxk=;
 b=krhq+vuXj0HDzCI0LyxfKiShAuG0OQQdzH1W0+U7fpKsKciVkvKvGIzvxkM2Cjl2giXtuKtiUXeKfExOqB+l8WY+pbOLOtVrBfX5W8y7mdlVyqlob9LLlxM0kyNvZlbdDuG3uwbNpC10kYPsNfIB77WlwC64SP4MVD1lPqmWJ2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by DB7PR04MB4442.eurprd04.prod.outlook.com (2603:10a6:5:35::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Tue, 5 Jul
 2022 15:50:38 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::5c49:dd85:a8d0:2907%3]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 15:50:38 +0000
Date:   Tue, 5 Jul 2022 10:50:31 -0500
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
Message-ID: <20220705155031.zk36jsq4q2ac2ow4@umbrella>
References: <ef676df1-77e0-b8ee-3950-97eade8ddd5b@linaro.org>
 <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
 <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
 <20220705145226.tarpvub6bh67tj63@umbrella>
 <0bd271e9-8d9b-7388-2d9b-65cc39a54f8c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd271e9-8d9b-7388-2d9b-65cc39a54f8c@linaro.org>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b41f85-7619-4b19-8dca-08da5e9e1b2d
X-MS-TrafficTypeDiagnostic: DB7PR04MB4442:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeH28k31DTubtUw2pOoFxIk1qgHeBXEe1GEHyQAmi2uIIFkKa5NSUqdXR3Inod3moePwvOn/ui5EeRCcjkAei7hkWtISvn6UjRkr82ZAnybWZuuwczKe1XarcUP08jwqP0BCsyvCNbmXHA9cagws04qOMqvp8NlGIJ9F0CO6+Ivx2Sn2EMjNE4wGTBZ5Si0t9Vu4JyCFFKw1SCFX7N9qYMDY5KP36Jxs9zlwrA8Gtkt1s5b5ta/c1hTfBNh+dEFfsh9pIGmuTvxi7r/2MFbzfzhKufdcKcgnLNNV5JHgKJx9aDa2V+JTLmrF98jDYd7vncyD0fSTVBqAJNKQiJNdidzh5iGZYwN3GfVkVv0A0xyLj3nKIhInHXdLM44+oX962MVgQUp2LKpJcpkXZxb6hfcYWIe7tkW9/LIAvgFR7mg2PcEQOo2kbOeTynvTFz8W/nD3HNDposNDxcz1hewR5/ZN+K85551v84m7qO6Rl1qAMXaFq9vdur1NWDwegyPqukOj/nySYpZVdrvjUdKOINBoMip9pTvpN52ORJQV4UjX12q4KeGaTf06oYE8wwXwM1VpzfXgCsSZjjy4r4ySqLRdEPPTriNvts9ZD0L9IasV+9IKidwgZvusk8OxZVkTEUNWsnQNFEwb1cw/ZGmwkeZgIrsh7S4IDSBmZBfI+JXY2QmfaNTLp+KfakjpjEDEo4afFXHcxc1MKih9I0Bd9rQUkR4om4S+rIKA8yQbbSOWkQw3aqaudwM9RX1ycqXA/V5C8dH0Q2tfeMb2MYUbDpDARellR9/XQRs7pdeQrBd1CuAy9gX8EBOqCABK+Uj1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(9686003)(6486002)(86362001)(53546011)(6512007)(26005)(316002)(33716001)(66946007)(66476007)(4326008)(8676002)(6666004)(6916009)(54906003)(478600001)(66556008)(52116002)(41300700001)(6506007)(186003)(1076003)(83380400001)(38350700002)(7416002)(8936002)(44832011)(2906002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izpXDcYcb5pnfdx9miKPYlPfaDhoxXFXBQ+GryqtXb1aU4FUdMLsLvkrCKg+?=
 =?us-ascii?Q?84JEwpWAkOgRICT0ETg7fLDfoKcgpFYmAY5hwNKeJc414hnm88KE/3kqNP59?=
 =?us-ascii?Q?LEJ44JRTdkSFLMYR9z9nu0S2Q86STCI0POKONoBBWQT5JH3XrlW0Yn/ktToc?=
 =?us-ascii?Q?5OvXFzGmEGJosanqSZhphQUp/THhjHe8yb+p9Wls1CrlCS4TnWJ1wrhOg1eG?=
 =?us-ascii?Q?5lgNQ78Muypk0kG06redSwae8qs/ELkBaOmY0XjickO+DkW2lqPGjy2yCaC9?=
 =?us-ascii?Q?iOlv1y74jc8r9JW3GoUZKG4s9BRJ8JT7Wpi3OHKtjQOQgt2swp/j1d7vvhFU?=
 =?us-ascii?Q?qtFnmopLzIyqDkYCOrZzgtCH7zJ6gKrWLBVQJoGpkZAdI2hCKsHk0tdbCjIB?=
 =?us-ascii?Q?ioHzXcGj2OTLIpI6dqW1NdYWIAZqXvv4FyB8EJCME/1+2WqR8ZuOnnrIBt6n?=
 =?us-ascii?Q?7bchuNRfq/Gw9hvSLwtT+WKtHW6rIh8YSrXVoJz6/NJswAFhejUbaDVXsN8w?=
 =?us-ascii?Q?KtqWNXEGZlj2EAHSCVwwDW6iSZTym8miCu4EmjVSYrhI85qpBcYFOmkDfpjX?=
 =?us-ascii?Q?pOhNVBLf+u9AlTH/ZsYJRRRQNYvcHoPgapFxHjp5pi8BETitK95CByKq9Eq5?=
 =?us-ascii?Q?5/g+h9UvY9lAk7IxG8ggOp+QLXKEy55RsxII8/zMfYObpnujJ0oaluutFjQn?=
 =?us-ascii?Q?D+m2Y5C9oXt2mc9q1ngicT5uBbwhTM8rpIVWb2FszFRNqiGX5tLhyj0hEAXq?=
 =?us-ascii?Q?cSNlqsN5QD3AhYIU80yfIO45B667c9cFd0u1aJdJtSRrEpRK7axfYpBx2Y2K?=
 =?us-ascii?Q?MtwOfdazSshrdh+KX9AgINk/NnFqdNeJC60mDMk03UizTwO4jh+YQxogyAC0?=
 =?us-ascii?Q?KPPel/EiZqImqT6is8vIF/biy5FPBBykO1z+I/Hcl76HU6BInOS9OHuzhaDg?=
 =?us-ascii?Q?HbLNUbL8op8anYng6hyYxsPjcr8TEBBOvzht59xCUu8nFJbLENIfsclxCbVb?=
 =?us-ascii?Q?+b8XhtdcvS5MDOhNxdisS6zV+wmdJFCAGIQzBZzaMtmvbT18OTXMW3ptqVN0?=
 =?us-ascii?Q?rTqbtfeFmgYtaelBNf5qC/DDvGbMgrB0dnl56t1ypmz88gCDN7fOqrTg1kJ9?=
 =?us-ascii?Q?G12fAQBWSTGlfldykC69Zr+5tRPS4IBt+xW07q8tPKu1bhm02qJbUADpcpoC?=
 =?us-ascii?Q?ykq6bRRV5cXz1Tf6phMwsb3nZb/aAZ9s35Hzj6iSiPFBMOOEJo9oy2pKWbsi?=
 =?us-ascii?Q?bQZr3UmppsR2kkX9BmhAYpKJC0+WkRqn5mTh2rPapLMFBAm+OvewAJLgkYNw?=
 =?us-ascii?Q?Iute7873BqxNtqNO5Pyc0FgpTIrZWL3yOM+oZhIkSg0rhsHLnwUsDvpN4r/p?=
 =?us-ascii?Q?XcwNHmY7nwknYiSLpnMkgJhJuQKmELFshPsdLjDGMdCEg9jaErCGhUo6yIrz?=
 =?us-ascii?Q?Pq/9XEI7CXWxzmh7qrLO6gWt85aTZlgzGf272/2F9hQFNPMvNf5hM2TNizwl?=
 =?us-ascii?Q?cGlCDOckJCaBGwwkXZ6SPuqNCyoc1BTiuITWAGhGn0HXiyGejHx6GCVcTlLC?=
 =?us-ascii?Q?raEJZ2zvKvG6/ErNzFpqTSEBNAPO6RqZ95E2Npxg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b41f85-7619-4b19-8dca-08da5e9e1b2d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 15:50:38.2820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7beKaNqnieQRfX/zz8df9Cb7yVA9J3OpwIcH0aGNfYL+6j4k2yySazGJ+GM2bwTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4442
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/05 05:38PM, Krzysztof Kozlowski wrote:
> On 05/07/2022 16:52, Han Xu wrote:
> > On 22/07/05 04:12PM, Krzysztof Kozlowski wrote:
> >> On 05/07/2022 16:06, Michael Walle wrote:
> >>>
> >>>>>
> >>>>> I think you could use here clock cycles or clock phase, but then it 
> >>>>> has to be obvious
> >>>>> it is that unit.
> >>>>
> >>>> Hi Krzysztof,
> >>>>
> >>>> Let me clarify it, in the document a term "delay cell" was used to
> >>>> descript this register bit. Each delay cell equals "1/32 clock phase",
> >>>> so the unit of delay cell is clock phase. The value user need set in
> >>>> DT just number to define how many delay cells needed.
> >>>
> >>> Then should the unit be "-degrees" and the possible range 0-180?
> >>
> >> Thanks. We don't have it documented currently, but the unit seems
> >> reasonable.
> > 
> > IMO, use the unit "-degrees" makes it more complicate. Personaly I would
> > calculate how many clock cycle delay needed, such as 1/4 clock cycle or half
> > clock cycle. Using degree brings extra calculation.
> 
> And what if the next device uses a bit different divider? Like 1/16?
> This is why we have standard units so people won't push register values
> into the bindings.
> 
> > 
> > The granularity of the clock phase change is 1/32 of 180 degree, but the range
> > 0-180 make people feel it can be set in any degree in range.
> 
> Yes, because that's how the bindings are being written - allowing any
> reasonable value, not register-specific value, to be used because it is
> the most flexible, hardware-independent and allows further customization
> of bindings (e.g. new devices). Embedding device programming model into
> the bindings contradicts it.
> 
> Second, nothing stops you from narrowing the acceptable values with an
> enum. This still allows extension. Your 1/32 does not.
> 
> > 
> > If I describe all details of the relation between "nxp,fspi-dll-slvdly" and
> > "delay cell" in patch v2, do you think it's clear for users?
> 
> 1/32 could be a nice unit, but degrees is better. Just like uV is better
> than 1/32 of V. Like 1 us is better than 1/32 of ms.
> 
> Do you see  in the bindings many other values like time, potential,
> current or power described in 1/32 units?

That make sense. I will use degree as the unit and round to register proper
value in driver as Michael suggested. Thanks for all comments.

> 
> Best regards,
> Krzysztof
