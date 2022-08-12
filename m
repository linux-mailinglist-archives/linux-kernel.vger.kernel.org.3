Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A18590D3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiHLIOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiHLIOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:14:00 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB6CA8328;
        Fri, 12 Aug 2022 01:13:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aqi1pYDlbks0AFo9sN8uHmrRZQQnZrGabHhkhFLQGv6oOskgZhql0547KNzUWv2UgzFHBBq9zx5yavhKthW4s86lbn4QJmE+wZQ+cCxLpc1YUUJgKbe1U0peFHN+pBdwAiX9YI2TkAJVZklg6pRC5fvoJbNC1Dib9cO6W0koXp9V7AlBABDfu/lfUt672Wbf8xA2P6f4cXGmNQDkFV54hqklV8/55w7aFOg+1UQm+/ZjWBfI8DXZ5AnY/4wESnRP8uSOEFvt7qNyex7TZXZ3/0jdFJVUpPc539mWCPedQzOWEqV6840AGQSow1J8KsCn3pt01o5VOk/2xOFL5am6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOnV7Cs3Yw7a8zUFT+xUGraX941EPUc1fBlp2Ts2Q9Q=;
 b=BjSF3FFkGILA3YEa7eolv9UokcS9Ub4Kps+pmneCToc9KhNzdraL+QxHB80ylFfyS/TJcGdWL0CI8+Iqhn7DBHIBhQdjlF/AjHxyevqO3//kJ6y+1wTjwASGvJQbqXzQ25CJ55rg1pzhni1PczjMDTIiW7t4F+yhMFxLfZ3dTjEsZ6Ks+W9bs6m4Lr/ShpjVT0wwla4D3mEktgT8tmRx1VNnZjBNzrhG18lE6HjsH/l2ZNh5WLR5SiLUNd8FwL0ehDsv6q1ooxk9tNialVEFpi3UibMGj6+smVHLcSS7uCZgcL+X0cgOa6pjGeuTjxWjfH3UjlDgiwX1cIR8whaD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOnV7Cs3Yw7a8zUFT+xUGraX941EPUc1fBlp2Ts2Q9Q=;
 b=IZrzvAZcYa62fLBR2MlU7gNOspap7EqpkKoZ2I+eA6ucBSWN7mMTcYihjtd5gck80ywJ568eXOSKxFaHVqFJM0fOXUEoo/UB7bBW106JXh6K5XfmkpogJP9z0fAjBWV/mHzLo01EGFh2xxI07+C90INxsYG5vkee1TCKFPeVSSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by DB8PR04MB5657.eurprd04.prod.outlook.com (2603:10a6:10:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 12 Aug
 2022 08:13:55 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.022; Fri, 12 Aug 2022
 08:13:55 +0000
Message-ID: <9349e633a64a2275857b2c08731e40721e5af82b.camel@nxp.com>
Subject: Re: [PATCH v3 2/3] drivers: bus: simple-pm-bus: Use clocks
From:   Liu Ying <victor.liu@nxp.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Date:   Fri, 12 Aug 2022 16:13:41 +0800
In-Reply-To: <CAMuHMdVDutP57NRt-wvti=LeWFLit36WdKZW7L5gtifTW=zkkw@mail.gmail.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
         <20220804061133.4110734-3-victor.liu@nxp.com>
         <CAMuHMdVDutP57NRt-wvti=LeWFLit36WdKZW7L5gtifTW=zkkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8730cd7-5344-4b40-bb0d-08da7c3a9993
X-MS-TrafficTypeDiagnostic: DB8PR04MB5657:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5oNpfipDiYrdKVXNa/bt9bISHBKyDPum60L8GFu+HH342YhiV3VXmIUpoHo9trGjj6YzZ1hCtHVG6fAcQGlGN9PMUUleX5lQF6/QYQaweyZBO9IgCHsYYIxOe4SB3V/m1usRQTPRCSo3yYal5dNoSt3yiAvmuLXn+3UDMNTsC7dajPsgTn5EfaGU8njeTcECBm/XRwiW/OriMh3JUDh3/KTFZmXNdwbupbaL+hynjCrCJgmT9YPOATTXKRBtf91ffttaTi6Qi7oApBG14TsqMrEC8UBN71dXxXUxbYN0nsx2sTaHrMK2+j08VV1FKAILUsOr6/liA7oq4O1dJeMc8TQ3K8rKn80NpF4JNOBRD6OgDMYeLU1Lvig7E3urAXt3s84HYZWL0GO8Hwnw4vFmczSGbhdIsyt6edxjyFd08rY0WKoBMxJMT4l+QAVyy+vco7P1FE8AxJwCDxTfL9W3vifxuM3oyZzOwvYtizdtlFKhnfAITKQ0QbC8MJCZT1pZmzsuKgX0/hsjhE70Gq0MmREaP6cwDn3z9iRjeb6FbfCobngTDkQJeYtQnSd4V7Zg3oNJRgIrw8iySq6AM9G5TK8+QcaS9ggf80Mk1k43uJg52AYjalzDClMjcoXkPsoIV1DqeNLV8gUrxsoXIExA0AQFTuLP/hRCa3yw/1fCLZb+HBWqgspruzcSyLQTPBpQdlmP8nNF2SjloWHhSOOSYdQgv0J2qXXdG7wDQZ5IauN7p4Gh49yhOgpZsx+JUU2wvmznblpNNXUMHYr1X/3EQ4mfPrGrSozCpa9NoIDovwVAQvDpIf3iIEQCuVfmNLb9fhEVSwjAWWcxJZ/qXa+TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(66556008)(4326008)(8676002)(83380400001)(41300700001)(6666004)(6916009)(66946007)(2906002)(316002)(2616005)(54906003)(36756003)(186003)(38350700002)(38100700002)(66476007)(26005)(6512007)(86362001)(8936002)(52116002)(478600001)(6506007)(5660300002)(6486002)(53546011)(7416002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWFxdGx0QVlHcUNJN0p6d3lhRng0ZWRSSHVVd1gyNXdTRmxyeXRuV0JreTRn?=
 =?utf-8?B?SlNjamREeHlVUVdSVUZiTlFhRGpiQ2ZaMHI2NHdQRnlnWnFXYjljZ3FWanR0?=
 =?utf-8?B?L2xXRnlLUzVpaUNTRXRHdTRqMGRrMmxUWVhiTTRFTWVRNXZWaWpjeUpYNTZq?=
 =?utf-8?B?R1ZmUlBvMEw5MWgxdHAvdWJ2MnJ6alhBV1VEZW4ybXduZ2o2Q1VmZVA2a2ZE?=
 =?utf-8?B?KzUvNDFwZENqbU81YTRnV1lOV3F2MW1hNVFxUFhGVXVFYUdRSUNRUlNDSnNt?=
 =?utf-8?B?QVpzRURzMEpKMU90Tlo0SVdRMVpzQzlGWU8rNGZEcmJsZmtnTzNuTGMzOGFD?=
 =?utf-8?B?VC95TUIwcFFvQUhJbDkvZ3FPekRER1hTaVMvMjZMRnhPNnlvOXZBYzM4Q3hp?=
 =?utf-8?B?WGFJWHJUOTIzZmtxUlBqdXdXMERtR0JjTHJZT3dMU2hwcGdkNklqUDJOWjBm?=
 =?utf-8?B?SnlGT3hkWnQraXZ6Uk9zV1VqRGliV2xvc2NLeTJmU080SlRaQ2t0bkQ5VzRq?=
 =?utf-8?B?YVlJTm1uWnlZQnQxMkM3eGlwRWNLSHhWMkVoRGwwRmM5V2VVN1R2N0Z0RFZJ?=
 =?utf-8?B?MkhUS05YOXBPbVRNUXVXaXRudFlST3VJK1cvZTZucVlUbzgzcHZxaDBmdkRH?=
 =?utf-8?B?NTh5SGxOZjdJUG5kZVRXeHdpTTNPWUJiVUZ5YVBRSmVZaHllclRNZXhGY1Y3?=
 =?utf-8?B?VmY2OFFOeVM5amN3WlJBT0pkUktjNGhMTW0xUmFIdi93RU1LL3IvK040d0ZI?=
 =?utf-8?B?VENLZ0xBNDFvTnd4d0pIUGthcmRuTGk4elVRbHVuSUNOazhDeStHVmJIOHJ4?=
 =?utf-8?B?S0xOSWR5TDBqZTFLTW14c2dGRk1qSXpVWWptclJSYkhvelB1dWJJcEhKQUhG?=
 =?utf-8?B?L0RueFFSa0IrZ3VTSUdLS1JtMEw4aEc5M25YNWR2T0VtWmdSdkJzNStEZkpw?=
 =?utf-8?B?MXFja1pHQitNK3JaS0pOQThlcDBBcWpsSldVSWlKN05VVXZDRmFId3lLWklU?=
 =?utf-8?B?ZFNoYkIzNzRybmZYNjNWcHdqYnA3R0E2dENnQkV2SzE2V2IxOTl5Y0NybEFj?=
 =?utf-8?B?V0tRTWttYUk0TmM0YUhvS3lHTjVDVjBUaFErN2hNQTRuOWN1czgzNk1SQjE0?=
 =?utf-8?B?dHdLLzhibWd3S1k0UWQ2b2x6YzMrN1I5UjR1bDJ6Yzh3OEdvU0xXQlVuUy9P?=
 =?utf-8?B?eHRtZ2d6Y0JpOWQ4ald0cjkvN3kzdExXaG00SDFLUERva0dCRTRab1JEdGYw?=
 =?utf-8?B?YUFxNTdRVGpSQ0t5N2p1RUZka2VUeU02bHpYM1lUZ1ZIRTNpQXpBZ3NTV2oz?=
 =?utf-8?B?OGRuMWhkTjVMMjBtSUJWWXVMOXpQeXlOemhhTXY2ZXZqWXFVbUgvaHk4Nkc2?=
 =?utf-8?B?YU1Ta2I2dVdUeURWblBSQlVWT0pjZHBXTzI2T3dSN3N6TVM3T3hDU29IUHRD?=
 =?utf-8?B?NFFrY1lJTXY2cEtGK05zMFRCYTVEZmVxSE1qVnNPclZReHpUdHo1Tk5aU0xy?=
 =?utf-8?B?dTZ0ejdIazRweCsrQlZOcWFGbFI2dEo2UVVDd215YUFXaENDUHR6eS9paEZi?=
 =?utf-8?B?K0NoUjd2OWRubkdRYlZ0T1pEem45U0dHN2xqWm5EcENiL2pLK3BtUDNyR1NP?=
 =?utf-8?B?bXJQRWpmRXUwSy8zNmR1QUxhL1I0T3pBSGdnbTZydHQrZVJKY0lZOHNBeU1n?=
 =?utf-8?B?WVVWRG51ZStCcEhaT1NDMUNtaUZobUhsZ0VVSndFa0FVZVlUUnBXc1hDUjlw?=
 =?utf-8?B?U2ZqMm54TzBRa3NVWTFKcEM1UGJoRlRmV2k2N1BwZUp2WTE1bFhFZzYyclhD?=
 =?utf-8?B?c28vanhrTWtCd284dENIRjlmTWxJTWpEdTBDV2EzK0ZMNytKQ3RZRm5PNGFa?=
 =?utf-8?B?blE4OVZndHM1N0VKY1E5bWJ3LzhRSTlNbFhiQWxXNmNtQmxjRkpSQlhRRVJF?=
 =?utf-8?B?UCtXUjN3NGo4aHVUVHp6Um5QVXZrTGxXeVBxMGR6M0NMTXVWTEVwbGFRVUxy?=
 =?utf-8?B?MkdOWnVIV08wM1MyZm10MXMxSmE0ZFk4WlNxRks0ZFYwSGpiekxDYUo4MVdR?=
 =?utf-8?B?aktJbGpueDNzbEJGT0tRMHdXUkhoaGNsRThOUDcyK1VRRUFJWkI2TzEzR3U2?=
 =?utf-8?Q?1lU0jb/y2nXzP9ilFEfp7xY4s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8730cd7-5344-4b40-bb0d-08da7c3a9993
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 08:13:55.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lHCi0YufJSSMBTihJEck3+hg8cYrhl9PVLznVA04qb9VHVCg+wA3PZI8KPi48fAo74+7chwhHHmiFGTgdc6rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-11 at 14:34 +0200, Geert Uytterhoeven wrote:
> Hi Liu,

Hi Geert,

> 
> On Thu, Aug 4, 2022 at 8:10 AM Liu Ying <victor.liu@nxp.com> wrote:
> > Simple Power-Managed bus controller may need functional clock(s)
> > to be enabled before child devices connected to the bus can be
> > accessed.  Get the clock(s) as a bulk and enable/disable the
> > clock(s) when the bus is being power managed.
> > 
> > One example is that Freescale i.MX8qxp pixel link MSI bus
> > controller
> > needs MSI clock and AHB clock to be enabled before accessing child
> > devices.
> > 
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> 
> Thanks for your patch!

Thanks for the review.

> 
> > --- a/drivers/bus/simple-pm-bus.c
> > +++ b/drivers/bus/simple-pm-bus.c
> > @@ -8,11 +8,17 @@
> >   * for more details.
> >   */
> > 
> > +#include <linux/clk.h>
> >  #include <linux/module.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > 
> > +struct simple_pm_bus {
> > +       struct clk_bulk_data *clks;
> > +       int num_clks;
> > +};
> > +
> >  static const struct of_device_id simple_pm_bus_child_matches[] = {
> >         { .compatible = "simple-mfd", },
> >         {}
> > @@ -24,6 +30,7 @@ static int simple_pm_bus_probe(struct
> > platform_device *pdev)
> >         const struct of_dev_auxdata *lookup =
> > dev_get_platdata(dev);
> >         struct device_node *np = dev->of_node;
> >         const struct of_device_id *match;
> > +       struct simple_pm_bus *bus;
> > 
> >         /*
> >          * Allow user to use driver_override to bind this driver to
> > a
> > @@ -49,6 +56,16 @@ static int simple_pm_bus_probe(struct
> > platform_device *pdev)
> >                         return -ENODEV;
> >         }
> > 
> > +       bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
> > +       if (!bus)
> > +               return -ENOMEM;
> > +
> > +       bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus-
> > > clks);
> > 
> > +       if (bus->num_clks < 0)
> > +               return dev_err_probe(&pdev->dev, bus->num_clks,
> > "failed to get clocks\n");
> > +
> > +       dev_set_drvdata(&pdev->dev, bus);
> > +
> >         dev_dbg(&pdev->dev, "%s\n", __func__);
> > 
> >         pm_runtime_enable(&pdev->dev);
> 
> While I agree this patch has merits on its own[*], I am wondering
> if you really need it for your use case.
> 
> In "[PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
> link MSI bus binding", I see your bus has both "clocks" and
> "power-domains" properties.  Perhaps your PM Domain can be a clock
> domain, too (i.e. setting GENPD_FLAG_PM_CLK and providing
> generic_pm_domain.{at,de}tach_dev() callbacks), thus handing clock
> handling over to Runtime PM?

It looks like most(if not all) PM domains can be clock domains with
GENPD_FLAG_PM_CLK and generic_pm_domain.{at,de}tach_dev() callbacks
set. So, technically, my PM domain(scu-pd.c) can be a clock domain with
all those set and a special check for "simple-pm-bus" in the
{at,de}tach_dev callbacks.  But, I'm not sure if it is appropriate to
do that. How do we determine clocks should be managed by PM domains or
device drivers? Technically, both would work...

> 
> [*] The simple-pm-bus DT bindings state:
> 
>       clocks: true
>         # Functional clocks
>         # Required if power-domains is absent, optional otherwise
> 
>       power-domains:
>         # Required if clocks is absent, optional otherwise
>         minItems: 1
> 
> While "power-domains" (+ "clocks" in case of a clock domain) is
> handled through Runtime PM, the current driver indeed does not handle
> "clocks" in the absence of the "power-domains" property.  It looks

Right.

> like all existing users that use "clocks" rely on the PM Domain being
> a clock domain.

"renesas,bsc" seems to be one of the users.

> 
> With your patch, the clocks might be controlled twice: once
> explicitly,
> through clk_bulk_*(), and a second time implicitly, through Runtime
> PM.
> While this works fine to do clock enable counters, it looks
> suboptimal
> to me.  This could be avoided by making the new explicit clock code
> depend on the absence of the "power-domains" property, but that would
> break users that have both a PM Domain which is not a clock domain,
> and clocks.  So we may have no other option.

Hmm, I'm not sure if there are really users that have both a PM domain
which is not a clock domain and clocks, given that a PM domain can sort
of always be a clock domain by setting that GENPD flag and those
callbacks.  So, what do you suggest? Keep the patch as-is? Or, maybe,
make my PM domain additionally be a clock domain?

Regards,
Liu Ying

