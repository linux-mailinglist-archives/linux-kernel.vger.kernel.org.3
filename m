Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB685AE409
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiIFJW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiIFJW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:22:26 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2127.outbound.protection.outlook.com [40.107.20.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6E4606A7;
        Tue,  6 Sep 2022 02:22:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7GsPD6YAeLDcvMAQQ21WRjokmY/oqaCpbnp52LxBbBT2/zP8PA88UHOqFaly5Y7m34CDr38kTGn+G4B/05jH6qgUlWYZlvUqwOAxq57p/XYLPGk5+52ZloQbZ64OwquzoT+lLNCZYfUwKY4YyglLhn1VCAkwI2n+dNyhQ9bSf7pjAXGQ9UCredLL1eDuCQuu1chTfH80viFHmnPBCINNA9LttApKseWFDTlNMuDsQ7uAMYugaFSt3LD+6rcy7TAJZucR6vBfYWmO4WFWnM2vyVPftC32GQ5Dlq2XtYK30nZ5tpKusipIP0gb0TwqKIEWM3taYYrwRfMbpSvBfymzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DjbLY5KyzSAJsnI13GEpruI8CM2jG+1/QrvtWwkQBE=;
 b=dGPVhagHk42SvMRoEyibXe0v+wKEFvgvqbCVFP8HotJf1ucZ/E/H3xd9wG3A0avvZfUsk/ezAoOPzuwClLKd+wWh7vc8Q2kYTTzu2g4n4HpGNYruvWVSytm9zY7dYQq2VI7JmrtYMvgzfiuJ7T1WAls912jVZxzhTN52DRndMvCSnlynjp16uuFvwAJjk9a9Ckx1WK17nr7tEcOgQhdaSHET6Qd+XIdcUlr91hIhh4asvP3XIvyX9aIuxoIas2qj6GkSpgy3r5KEyQCAC/iSxg7lRwQXrtVQseyyfww+/tXTXnFCzKBP5bzdJj5R25dfXZuK9OtSJ+25U/wLDzO4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DjbLY5KyzSAJsnI13GEpruI8CM2jG+1/QrvtWwkQBE=;
 b=D6bpYdBkYHbNRgWJq20qNxcsemMj5+lDpA8z7PR+mFWV1L0OtG4nsZkPbT9wbR6tJlUmIJXuTtH8BbwEiWHvY68xwxxFXbe++xvFNhBbsSyNm7hJ3nczHW0Zwo3bEMrCauSL1H85sIsMg75ssIRWHkshF0P+AFJUnua5EoICbws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:3e::13) by
 GV1P190MB1995.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:5a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.14; Tue, 6 Sep 2022 09:22:21 +0000
Received: from DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::cc27:42a0:f08a:1015]) by DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 ([fe80::cc27:42a0:f08a:1015%7]) with mapi id 15.20.5588.010; Tue, 6 Sep 2022
 09:22:20 +0000
Date:   Tue, 6 Sep 2022 12:22:16 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, iommu@lists.linux.dev,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Fix 2G limitation on AC5 SoC
Message-ID: <20220906092216.GA485@plvision.eu>
References: <20220808122652.GA6599@plvision.eu>
 <3f96b382-aede-1f52-33cb-5f95715bdf59@intel.com>
 <3d16ebad-ea6c-555e-2481-ca5fb08a6c66@arm.com>
 <20220816205129.GA6438@plvision.eu>
 <94888b3b-8f54-367d-c6b4-5ebfeeafe4c4@arm.com>
 <20220817160730.GA17202@plvision.eu>
 <80d2538c-bac4-cc4f-85ae-352fcf86321d@arm.com>
 <20220818120740.GA21548@plvision.eu>
 <YwHOCHmKaf7yfgOD@infradead.org>
 <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b88438d-1bb0-e980-b4db-1f8663dc6042@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: FR0P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::16) To DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:6:3e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f13cd4-d9ca-4761-8ebd-08da8fe94cba
X-MS-TrafficTypeDiagnostic: GV1P190MB1995:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSKcgkoS7viG+Ra7znNJS2jreYG404m5NYqjx0TWetvdjd4BoaSNARu3dkrvs86Fb+JZWquVyR8jLCQccZ8slyE4gD1eWU8nGhcBvk9v6Cif00RDRFtvONuTnkP1ZijrSMCej07GOuZ6JZtftiWj6QJKcizpmhmvyEnx8GSbPFYkeEMpEcUNRXdyWOYWqGm4D7yLjRjsWArXXsArIMckfo8T4HCDB9hVWfip30slZTfZhNNL2vrYHYM7L3Jrpv1ewsMQCLNCDwGImk7VXoTWQ6UJN9rQyidlUrOvxSaH2HZf3vLmt5rimhIj9xSl58zsC2CNguuelqFjeptDIGFyaO6lc0AK0fSYVYjE4isvGoZAdpNtFLcZ95J8NMdmgbXwOYa5ka0kbVy/P9T9u4r8oW+fslY5jWCh+Iqsc1zUdxT4e//xjmyKthRq9SbwA2jFzvzGmtPdnHoipOsDAsh2abLGJybttvNaS+fnmsH+hVyfdB5S1cVClO0Uk74BeLVg/8h2pzpnI8byXBZQTp4ZVZE9gtx4pLj3XlS7brTC6CD/P7eY0z2xlT4Q0aV40dhdPGGNZV1YbWVXtYGEHzTxukxDPtLGEr0vN+bcWkR511pzbkIh/vmwLwKXBnI6wre9wyNmiS8iwpltVIqN0qGfQakNwB9aNXoHTCSKTFusbNH4cmvzQz6nqXhnzqVzoNnIIaCAwyb79dcHpB34FWBpJWRFBxTvlB17zC4rCrVMx7QPUkgATlgfH1tiHG2shJvw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6P190MB0310.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(34036004)(346002)(136003)(396003)(39830400003)(376002)(6512007)(38100700002)(8676002)(38350700002)(66946007)(316002)(66476007)(66556008)(4326008)(54906003)(6916009)(44832011)(8936002)(5660300002)(6506007)(7416002)(2616005)(1076003)(186003)(41300700001)(33656002)(508600001)(6486002)(36756003)(53546011)(26005)(52116002)(2906002)(41320700001)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I146paHRL58snbj6+KD+qZwAdKE+q6zfMAfs0k9geG/oqK9cP0MBpTNyhCTJ?=
 =?us-ascii?Q?UzwOuyiKa5NijKrWs7e290dp9RerSC+i/grzwsLSieX7xr63rEF6S8QXtw5e?=
 =?us-ascii?Q?anrUIMybU0QbpoIaeSvTTkAPIhY793WcYxxnkkWoACN4ErIAgmZB0RbABF6p?=
 =?us-ascii?Q?hmvBVSfM2pqtQWSjOcgdSZl12zVEaVUsGVli67rmsgKLN4rrMudiX5AhjKUv?=
 =?us-ascii?Q?U6eTWZriQdMjcqU2Q9zGtA0liozUaNGZZXq+gDeZtHXzrVAzUyMQyEIhbJmc?=
 =?us-ascii?Q?oTyy88BM3r6onlpyTtF96QFSPEil2/RsRW4Uio7NJfnzp8BLJoaa+7v6Y0n4?=
 =?us-ascii?Q?Th+CEvmYbcExKGPY9LAiRQXGswsSZsMij/CamYolP4bgYeMiFCUX1kASXlFz?=
 =?us-ascii?Q?ya7Yy4sjtrL7dLs2IltU9olk3gGFzi7z7gEgMLoJF7qkiFGyo7asUA2dVn1C?=
 =?us-ascii?Q?JyMtdBh+rIClOeBxlL1Q4TrLPDeroTXHqqVwg9CeM2hawfxBdB1YHSuDzc1T?=
 =?us-ascii?Q?JzUeq7fw2zRakJ6H2qG9J80CTMhuebgO3cvpDfvl4C4fyOcLtM06cEPZjDym?=
 =?us-ascii?Q?OPTSyXBkAt50J5Hc+MJuQT3H5+BevLEhvNHwq4TrIQwAz/sl2yUdUouwITtv?=
 =?us-ascii?Q?jlpt4N9+QC1ZWWE2HxgpLRL7ABcIxztd56IgZhKI0tR3vAYzxOXYzDStuLuz?=
 =?us-ascii?Q?zxLXHqU0x0FsSahldOmosI5EFftc/TSMIL2C19iuqEjhBGfymE5VpzhEd2uv?=
 =?us-ascii?Q?a9LIy/knNCgGYeyPnSc8GEJNN5rONwXxVBd94IgH0bUMOGVPasiM1c8DVdZ0?=
 =?us-ascii?Q?K2lJzQEKrOjclL+sX8YabLteiJ33fmtz7QTSJuUtWEhI74Ia672EH2OoTSee?=
 =?us-ascii?Q?kaKLYQvGgRx+blmyqL3GSaTwWtZ4gQrAT9QL8HMllMpkI7vPPj/GpmZQd/CJ?=
 =?us-ascii?Q?YSf6OfHk1I4ub+fGwOf7jkaJoCjnv9RVRtO5mmenT4wv+SGqvsR9qyAMQqFi?=
 =?us-ascii?Q?eNm359wOgc9QDI6mBs5YlKgQ0yFSQX5JDwEQ3GV1kQsXbCxjIemvRGjqIBZy?=
 =?us-ascii?Q?BrFTXbi6T6Beg4NJvp2Fz/Vvo+v6wNY5fHtl6BptEFHto9FeZ4W2CYuJsvaZ?=
 =?us-ascii?Q?ApOD5RCUOy2qXHFVOqoJasw/wllvIPrSCrFdTQOsTfq30jCoeqH1t6Q1ssA1?=
 =?us-ascii?Q?TQf0rum7U83U0uXT0qWgxmqyySJcSRDfRX5T7Y+aKlwl5qYn+E6aI94WF+Uu?=
 =?us-ascii?Q?6C2lh9/c8YAa43Y31h32qOIVNq7TclhMuIgykEgVejKEoPbyY33LCEmvSuYJ?=
 =?us-ascii?Q?LNJZm58WqMf58qXhBOM+Mxw4tWaSkzYumCTvBHfZml4nNaYfAzfVSjPAx1xW?=
 =?us-ascii?Q?bZR6qdKqLQqxMFnw0YccmYkuS4XpHhbQfgcChHrsMKq+FKzgPkojpLPQGqJm?=
 =?us-ascii?Q?YCFSWP7HeGVXfpeV+70CkdTGcGuEz4J7Gt0TcRsjMlIoSX4q03Aloynk/iJZ?=
 =?us-ascii?Q?GpbfnEjeD0TgmxdqPbvAFL2MkD8LVykSvd39OPcritPz260/GGYZ2rzH887M?=
 =?us-ascii?Q?mQaMDCwngjgoI0EOGram92TbAUiYUK6jF3fAJ09E9l0GAwLAtKCmXh+gReOF?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f13cd4-d9ca-4761-8ebd-08da8fe94cba
X-MS-Exchange-CrossTenant-AuthSource: DB6P190MB0310.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 09:22:20.4886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAGr1Ymx6S4gYofLAkbe2A9Er5A/rh76wylifhTqVbK+L8cCgyElQJyTNiZzZMo3qipXd0BPCY5SXw0e3C6/Rb+v1DA1ibpEIYgc6nFzT/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1995
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, Aug 22, 2022 at 11:06:43AM +0100, Robin Murphy wrote:
> On 2022-08-21 07:17, Christoph Hellwig wrote:
> > On Thu, Aug 18, 2022 at 03:07:40PM +0300, Vadym Kochan wrote:
> > > It works with the following changes:
> > > 
> > >      #1 dma-ranges = <0x0 0x0 0x2 0x0 0x0 0x80000000>;
> > > 
> > >      #3 swiotlb="force"
> > > 
> > > Is it OK to force the memory allocation from the start for the swiotlb ?
> > 
> > It should be ok, but isn't really optimal.
> > 
> > I wonder if we should just allow DT to specify the swiotlb buffer
> > location.  Basically have yet another RESERVEDMEM_OF_DECLARE variant
> > for it, which shouldn't be all that much work except for figuring
> > out the interaction with the various kernel command line options.
> 
> We already have all the information we need in the DT (and ACPI), the arm64
> init code just needs to do a better job of interpreting it properly. I'll
> see what I can come up with once I've finished what I'm currently tied up
> in.
> 
> Thanks,
> Robin.

Can I help you with something ?

Thanks,
