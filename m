Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC98E590E50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbiHLJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235949AbiHLJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:43:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB7A4B10;
        Fri, 12 Aug 2022 02:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFBYrdxvsOsnfecMJrTkqTz0e2UgCFhVUgOqST6en7xHbi8W5VMFepreIh95b+F8LSb0gp+TZMSDEwm/jCcDYHkiQHSU5TMgzTX9g9FT+11DtIrcngM5R/Iv4/e8ArFXXDUEA9pcPmT+yDZVTIXJAlABzzwSTmJjaK/N4NfEF2pvUrHcZjkBjBgRVkXGohctqjVNWBLDffMPjwVTLypIw6lWCPDkJC1I6MlwxsA1pzlpEegxXM7PxzHX+Lh2OioyqSp4yFQNI86MpyyvE9fg/gIhPz07FaUB6QTR7aUQCVTLZATkXbfOLkXjmrUpupLdbzkuu9h4cBre4Ayr16jMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zhpa3/Owwzeu2gpR2s0xFBmLa4HtwiQWKEuDcElNdU=;
 b=GcyHILg5u2AaxiT5lptJxLCnUAhvETdYUJWhEL0PtZZbNyXtlimx/uMa3BHd/TSUSJH5mHIJuR595zhJtnXeOs03my6sQaVnwnwqLMLHSyWKQBHb63jGCc+1NFG5B+LcS/jGXCu303NcqOCkOTrn3pobp11qIiUkKipjikXst3pN2isq4VPxrw9Ugd3WJKS2brZMV00J7qIT1+qi2cI60j+SR2O0SApZDeYo5HUbvkZ+pjFXcxR3eKAyjI3oIv93HzXwS+Kv5jtcHDZo9eLSoQz/D3t/91pKUclEelCtXyOM6f1tUv+XQmIB+Akpg5Kqo0tQUB4jDnr3ZVC/jX2KOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zhpa3/Owwzeu2gpR2s0xFBmLa4HtwiQWKEuDcElNdU=;
 b=eNfmFyugx9MR1HqrcWP1CNrrZL38abRKtlNNowlZ9r3sWxWu3PjrGz7B/coSiRI5rqjs9voyTJ31kmAdzdcyoYfRk5IISwwVf83aqxeY2/OvSP+DgnNCErrpkmvt4wfKTNV/JCefGIn9hMOdzNicb6tjK/Wi2sEq1j0ZODRXbcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM5PR0402MB2897.eurprd04.prod.outlook.com (2603:10a6:203:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 09:43:07 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.022; Fri, 12 Aug 2022
 09:43:06 +0000
Message-ID: <d7345c93a245f69c97b560c8acebd1ef79e4f628.camel@nxp.com>
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
Date:   Fri, 12 Aug 2022 17:42:56 +0800
In-Reply-To: <CAMuHMdX0pHm4QjHNvwADeJ3ngxcHv0k39hdDbZa+xUATAb2=9g@mail.gmail.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
         <20220804061133.4110734-3-victor.liu@nxp.com>
         <CAMuHMdVDutP57NRt-wvti=LeWFLit36WdKZW7L5gtifTW=zkkw@mail.gmail.com>
         <9349e633a64a2275857b2c08731e40721e5af82b.camel@nxp.com>
         <CAMuHMdX0pHm4QjHNvwADeJ3ngxcHv0k39hdDbZa+xUATAb2=9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 446541f2-03cd-4e80-391b-08da7c470f4a
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2897:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3NstdlyMnylgqtmGGi5u2aHo7F13c1Q30mjdMr+c3FAeBerODuaQvlJ+DFgJn0IcFIsi9jotdUrEkaOZbs9FhSNzELwMh5kxbzy37Jz7cRLATr6LIL/AjGFNIYoRL9Iu6z7x8ZuhWz6O5hfgmt6JZVEXwHLIObvzjQzTQun3Mtq/PgD9ZJ3ZQucPVyrDd9iRcR9foeAnE3OaeID9gC7Al1S8RjTv/RS7t6/32egZztpjytPsXc84fSYGwqz4YpVUa/S5/iRvZd1NacFEHqTvkWIxWKjJRQLqlDapuAScDA1DYVMP2hSqrnffrMG+Vswy3VtKi/uNutZLXJye+HrAqmGViT3jTXMcf+wBgmX8g+M2qq9kEE91DAsU/D+Yp3vl/IW8ftmQ4tbvtu1LCDrHKi/uDZdQknp9wk0xiOkwHeiRbJ70wZ5AdpcXbUZgIHrgXecKHElukOZQ95bIhvPO7tcDc3z6bTjLqrI2Yg+621KOatfrvddeTW0oLNGVvd8L6kO6IQSAESeLe7pTBZGuyqnNkwbKlZYcq0DtaIlfovt4XL2GQTy47UJZQ9PyXsU7aBE1EpzhHBVLGaa97MsA1NXXVU9AT8MioXaeoJz22VqqPtc0Ry1VYnMUZkaneeOC8YdHmHZloyL9LLCxmMdeVUzapWZQVVM5MqelffWqc8q1fuGS119hb65kO/MR25iYTeHP4bW0JVQwkXye31mHc5qZ1ebKNXd6JPW4r92dPK2G5bovj3b2gmS8YXJgh7yyYOPG7UUIUuPk89OMF/7P5IchRAZiqVrR8vLzfI0dWqzHQoRJM5yFrMKhSIOx6XCwZAWTtsabis2kEibTdZXZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(54906003)(6916009)(41300700001)(6512007)(26005)(186003)(2616005)(2906002)(6666004)(66556008)(66476007)(4326008)(8676002)(38350700002)(66946007)(38100700002)(86362001)(316002)(6486002)(83380400001)(6506007)(53546011)(52116002)(478600001)(8936002)(5660300002)(7416002)(36756003)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWk1SlhrMGhWNXI0SzBjQVRkcTRFYzJXZWJpcHVjaERrTmhnSUVuVFBMOEpO?=
 =?utf-8?B?NUdwOC9URURFMFFMZjBrSnUyUHQvdEt6dWRTWFpJbldVUXkvL2ZYZXlscW43?=
 =?utf-8?B?ZHJKeHVvb09tY3dOVGpLb0pCaUJPR3lLM1NSampJTzJldTdSUksydUlyZUZS?=
 =?utf-8?B?Nmp2SUcyeWpxMXBhdEpUUUdBdDJaejBpY3Z6NWw3d1k1QjAxSjd2SEFyenRE?=
 =?utf-8?B?ellWczlESEVYVnBZSW91RHRtNTFTMzBWRzdDOXgrQWJBeGlWZVorb2hZejVP?=
 =?utf-8?B?d3pWMHpGRjRGVmNJMnlsN2tjM01Fc0pOd1lPdjFUWi9xcE5FWlBTVEpsa2w5?=
 =?utf-8?B?dXBrZzlwb04wZ2h5RElneXR2VXJ6bnhmNTJQZTVtaGdsT2R1a3l6TmtadEJQ?=
 =?utf-8?B?bmJ5RVZjVXpxOG1yNDlKWWlUZ1Bwb2c4TnEwR1A0MWZRb0dCdUo3anduMk1y?=
 =?utf-8?B?YlFETzNMN1lWcVZ3T21LeTZlT1h1dFJ0Ny9Yd2JiYXpmUTVNeG1Fc1ZvZ3FQ?=
 =?utf-8?B?WDk4d01iNzdyaWUrbEVDU0xZTWF1S1ZXT1FNajhXYkNSMTJhaGk5RHJRMDZw?=
 =?utf-8?B?bGRWNzkrNVdOTTlxYlJ5Ky8xQjR1UXlYRGd3aHU2VC9NNkhjdHVzY3U3dXdx?=
 =?utf-8?B?K05OTnZ6MzV3bzV1aVR6cXJRRG5WVEErWnZWNmlVQVM2YTBoL2s3U0J1L1pN?=
 =?utf-8?B?K1lCQ0ZaekpQMGRORlFwNzJFZ3ZPbFpHa24xdThFT0I0aXZDLzQ2QXVGVmtQ?=
 =?utf-8?B?emtRcVNIU3V6Q3Y2MUg0STJRdEFiM3lxVERNbzI5bTFjVkxMbXhjMVlrUjQy?=
 =?utf-8?B?THQ5SDRkdzFYNXJUUXcxaDUxdmRVaXUwWk1QUW5xL2pLem92VXBzV1UydmZL?=
 =?utf-8?B?TVJlb21ST2hOcmxMKzJyejBWd3F4WExhME15MGI3Yi9lenY1Nyt2Sm5PNDNr?=
 =?utf-8?B?cjBUaWhnUkJCMk1nZ1dRYmo0MEtPTncveHlwazlyU3lsVFMySzUvYWRkVEdn?=
 =?utf-8?B?K1V2ek1qV3M3T3BDQ0Y5Zk1Bb2l0aGl4ZGIvQXBDaE1MaHc2L2lRd3FWNEVT?=
 =?utf-8?B?Ym5aeU15cnlVVmVnamVzU1dSNWEwK0ZTMkZOVXdmR3pYYmQ1OXlRZ2thNHhx?=
 =?utf-8?B?clI1NmpKUk56cjJVWEdUUVkycEVBbHN5UG5HWm9OUG5rcVhkMHNwTVpmRHk2?=
 =?utf-8?B?RFRLbnFCVGxYekJlcmRGcjQ5VUF2cjMyYnBid2xGN0t6S0x3aDZ6MFdGd3Zy?=
 =?utf-8?B?TDFEaXNhOW55N2lNWEpKVkZrQTdNVlJmeld5Z3BpdG5MVmo0bUdaK25mODBs?=
 =?utf-8?B?bVpPbFd5cFRoZWRHcllmYnFyb3hZTjQ5UlZEL0lGYU42Tkg4Rms4N3pmTHpw?=
 =?utf-8?B?OSt6bmp6VkEvWEpWdGUrcVlyUWxWenpjajk1K1hoYk54bSt4N3E4UjY0Z0Fp?=
 =?utf-8?B?K3o1UzJ6UzVTMjIrSnpRem5ab2JPSTBNdEVtb0psL0xFU1ZGRlE2enBtSW5W?=
 =?utf-8?B?ZGpZZEpJMlNZZXM0ZG42TUFHcnZMaG9ndFJVdHdFUUd4dGEzZTFITERueENr?=
 =?utf-8?B?eHdFODJidEJna25LVTBJcVcxNU9wcURERVAzY3Q5NFhPdm9adUd6RGhhSm1H?=
 =?utf-8?B?ODNld3dXdTQydlNCdUw1NXNleHA3d1dJaWtxM0VuQit2anpaSVROeHlUckFD?=
 =?utf-8?B?VDNLZ1JrUXZURDhYdi93VUpjVmt3U3RLeXljL3FaMjNvcDZOa1JidjBISGFN?=
 =?utf-8?B?bndMdmlRb1hWRjlMaU9kVGc1RU9KV3NRdnE4V0trTkZrSS8xTk41NUpnNDRq?=
 =?utf-8?B?UkVGSHN5NGlVN2RFRHBteUo1VnBWcUthbHhmNUlEazUvcU50bGczaFJaSVcy?=
 =?utf-8?B?ZUZ3UWVHY3ZiMGJIQXFxTnBZZ0Urd1VtVGhreDNCbXgwUjhzT3NOY2FuRVJS?=
 =?utf-8?B?YUw2cEcxdVZtUGlhUzVlNHRVOHpqOWMzclJQd2VrcklUbVlQTUMxbHdSclpx?=
 =?utf-8?B?KzMrV1QyRm1CTmc3ZElsVnlsTTNScCttT1puMzFPN1owcUNWZjVTWGFyY2Mr?=
 =?utf-8?B?cUsxalJadUFwZE1jSFRNWDUyR2NxaFM1d0l4TWlFQ3dSSW10VXNGK1RhOVo2?=
 =?utf-8?Q?qE0/oqYfAbUSKpRyXFtd4WCGk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446541f2-03cd-4e80-391b-08da7c470f4a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 09:43:06.8797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MN6nLF0mZNC0ovyf0nPvMmAxAsACklILsNYYD87Tr0YfFlMPh8iZFdBgIPU0FNg1jU/kXQT4FF/7eeUKDN71fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2897
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Fri, 2022-08-12 at 10:58 +0200, Geert Uytterhoeven wrote:
> On Fri, Aug 12, 2022 at 10:13 AM Liu Ying <victor.liu@nxp.com> wrote:
> > On Thu, 2022-08-11 at 14:34 +0200, Geert Uytterhoeven wrote:
> > > On Thu, Aug 4, 2022 at 8:10 AM Liu Ying <victor.liu@nxp.com>
> > > wrote:
> > > > Simple Power-Managed bus controller may need functional
> > > > clock(s)
> > > > to be enabled before child devices connected to the bus can be
> > > > accessed.  Get the clock(s) as a bulk and enable/disable the
> > > > clock(s) when the bus is being power managed.
> > > > 
> > > > One example is that Freescale i.MX8qxp pixel link MSI bus
> > > > controller
> > > > needs MSI clock and AHB clock to be enabled before accessing
> > > > child
> > > > devices.
> > > > 
> > > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > 
> > > Thanks for your patch!
> > 
> > Thanks for the review.
> > 
> > > 
> > > > --- a/drivers/bus/simple-pm-bus.c
> > > > +++ b/drivers/bus/simple-pm-bus.c
> > > > @@ -8,11 +8,17 @@
> > > >   * for more details.
> > > >   */
> > > > 
> > > > +#include <linux/clk.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/of_platform.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/pm_runtime.h>
> > > > 
> > > > +struct simple_pm_bus {
> > > > +       struct clk_bulk_data *clks;
> > > > +       int num_clks;
> > > > +};
> > > > +
> > > >  static const struct of_device_id simple_pm_bus_child_matches[]
> > > > = {
> > > >         { .compatible = "simple-mfd", },
> > > >         {}
> > > > @@ -24,6 +30,7 @@ static int simple_pm_bus_probe(struct
> > > > platform_device *pdev)
> > > >         const struct of_dev_auxdata *lookup =
> > > > dev_get_platdata(dev);
> > > >         struct device_node *np = dev->of_node;
> > > >         const struct of_device_id *match;
> > > > +       struct simple_pm_bus *bus;
> > > > 
> > > >         /*
> > > >          * Allow user to use driver_override to bind this
> > > > driver to
> > > > a
> > > > @@ -49,6 +56,16 @@ static int simple_pm_bus_probe(struct
> > > > platform_device *pdev)
> > > >                         return -ENODEV;
> > > >         }
> > > > 
> > > > +       bus = devm_kzalloc(&pdev->dev, sizeof(*bus),
> > > > GFP_KERNEL);
> > > > +       if (!bus)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       bus->num_clks = devm_clk_bulk_get_all(&pdev->dev, &bus-
> > > > > clks);
> > > > 
> > > > +       if (bus->num_clks < 0)
> > > > +               return dev_err_probe(&pdev->dev, bus->num_clks,
> > > > "failed to get clocks\n");
> > > > +
> > > > +       dev_set_drvdata(&pdev->dev, bus);
> > > > +
> > > >         dev_dbg(&pdev->dev, "%s\n", __func__);
> > > > 
> > > >         pm_runtime_enable(&pdev->dev);
> > > 
> > > While I agree this patch has merits on its own[*], I am wondering
> > > if you really need it for your use case.
> > > 
> > > In "[PATCH v3 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel
> > > link MSI bus binding", I see your bus has both "clocks" and
> > > "power-domains" properties.  Perhaps your PM Domain can be a
> > > clock
> > > domain, too (i.e. setting GENPD_FLAG_PM_CLK and providing
> > > generic_pm_domain.{at,de}tach_dev() callbacks), thus handing
> > > clock
> > > handling over to Runtime PM?
> > 
> > It looks like most(if not all) PM domains can be clock domains with
> > GENPD_FLAG_PM_CLK and generic_pm_domain.{at,de}tach_dev() callbacks
> > set. So, technically, my PM domain(scu-pd.c) can be a clock domain
> > with
> > all those set and a special check for "simple-pm-bus" in the
> > {at,de}tach_dev callbacks.  But, I'm not sure if it is appropriate
> > to
> > do that. How do we determine clocks should be managed by PM domains
> > or
> > device drivers? Technically, both would work...
> 
> It depends on the hardware topology: is there really a clock domain
> (i.e. lots of consumer modules are clocked by a single clock
>  controller and can be power-managed that way), or is it just a
>  coincidence that your bus has clocks.

It's just a coincidence that my bus has the two clocks.

> 
> E.g. drivers/clk/renesas/renesas-cpg-mssr.c:cpg_mssr_attach_dev()
> looks for clocks from the right clock provider and of the right type.

Ok, I see the function.

> 
> > > [*] The simple-pm-bus DT bindings state:
> > > 
> > >       clocks: true
> > >         # Functional clocks
> > >         # Required if power-domains is absent, optional otherwise
> > > 
> > >       power-domains:
> > >         # Required if clocks is absent, optional otherwise
> > >         minItems: 1
> > > 
> > > While "power-domains" (+ "clocks" in case of a clock domain) is
> > > handled through Runtime PM, the current driver indeed does not
> > > handle
> > > "clocks" in the absence of the "power-domains" property.  It
> > > looks
> > 
> > Right.
> > 
> > > like all existing users that use "clocks" rely on the PM Domain
> > > being
> > > a clock domain.
> > 
> > "renesas,bsc" seems to be one of the users.
> 
> Yes it is. And it doesn't need a special driver, as it just relies
> on Runtime PM controlling both the power area and the clocks through
> the PM Domain.

Yes, I see.

> 
> > > With your patch, the clocks might be controlled twice: once
> > > explicitly,
> > > through clk_bulk_*(), and a second time implicitly, through
> > > Runtime
> > > PM.
> > > While this works fine to do clock enable counters, it looks
> > > suboptimal
> > > to me.  This could be avoided by making the new explicit clock
> > > code
> > > depend on the absence of the "power-domains" property, but that
> > > would
> > > break users that have both a PM Domain which is not a clock
> > > domain,
> > > and clocks.  So we may have no other option.
> > 
> > Hmm, I'm not sure if there are really users that have both a PM
> > domain
> > which is not a clock domain and clocks, given that a PM domain can
> > sort
> > of always be a clock domain by setting that GENPD flag and those
> > callbacks.  So, what do you suggest? Keep the patch as-is? Or,
> > maybe,
> > make my PM domain additionally be a clock domain?
> 
> It depends. Is "dc0_disp_ctrl_link_mst0_lpcg" a clock controller that
> controls the clock inputs to multiple modules? Based on the name, it
> seems to be used only for display-related clocks, while "pd" controls
> power to various modules, not limited to display?
> Hence you may want to keep your patch as-is.

"dc0_disp_ctrl_link_mst0_lpcg" only controls the clock inputs to my
bus, not multiple modules.  "<&pd IMX_SC_R_DC_0>" controls power to all
modules in Display Controller Subsystem, including display controller
engines, irq controller, clock controllers and this MSI bus.

Hmm, based on your information, it looks like I need to keep the patch
as-is, as the clocks are only for the bus. If that's the case, may I
add your 'Reviewed-by' tag or sth like that on this patch that when I
send v4?

> 
> Renesas R-Car SoCs have separate power area and clock controllers,
> too, but they apply to most/all devices.  Hence we moduled this as
> a single PM Domain (also because "power-domains" (used to) support
> only a single provider), through a close integration of the power
> area and clock drivers.

Thanks for the information.

Liu Ying

