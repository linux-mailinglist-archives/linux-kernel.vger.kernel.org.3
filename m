Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB25910BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiHLMZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 08:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiHLMZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 08:25:36 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60063.outbound.protection.outlook.com [40.107.6.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860BE1F2C2;
        Fri, 12 Aug 2022 05:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ze3+9p9+ZWXX/wUAyTM9QZvfXd+Q/uYflBLmtaHp5vFTdD4dXcxATq8aRd6IQCwuONjQPFQvVwN4YK5AuT/cWPFk4wsJWTWIch+TJpzQ4iFUe+5JpZuee1SffZs/bu/5d8o37Syl4NCmASCPgzmGKzBNoQwfnnVhwc7UiYxMjh0mU/cBZaa/oAkGaPsNjis9HJNbW9CF42p5LMka+9cEF5AKG4RIuthsH6gktSXZU7HnEWmSAY7vDHr5j4sAdUZ9kYk6afLq40trf8wuy6DcTpnYcFbEGIteRKy5zUD9hqPgxDjk5OKraumlvhDzBd2rI4zGSCgRdOcZadHml9RVQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4r6EmfJUPPLyDst99tB1kiLYfDnw/3KSlFEjYYrBzrA=;
 b=DAFWSXIQ/JdDfG8Mm3V0JxJt+TozEE/iknievk2/PkITL8RMdRwBvgoRfZoCrCkz9qkI+CL9Vxvq0DjmGKVVhWHQNUpTVbjjmCt5Yc2n7WLgn+O4Xbu2R93eaFjARChxKyZ72oO5CFVwwRaiIUeGVHqVerE8qrfjkuE/asduEcJ0MeZPpwsp8tHZBcrLurlXnKdXe6oIYu4FUPNQSxWz+NsOofDDKHzl7P8SV9ZePH0GZBgbnI/+Xptf7tYNrMjboK3vqpAR50e2XpA122PiqqLn3oHTVKc3/SGQQbTG+Nbo9CcCFoDGcYa3mQrrF3DZl5+RbfbrHisswaNIgmQ/ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r6EmfJUPPLyDst99tB1kiLYfDnw/3KSlFEjYYrBzrA=;
 b=NBrnGJ/N27Pv6iSjN1lsdaSYFj9H4IEHaSZZ2wqNE8b+Fjn7lJX76Eyqd0JhNUYKcBlXOZLhQaoVOBTrx2U6bt/jwnJ7EjXzvPlkjkycoNIK0asyqVowtUs2/rAuER9JRsnHv9KHC0bP2AS9f0xZAkkLd1hyLR+sHouXZT3yunE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by HE1PR0401MB2665.eurprd04.prod.outlook.com (2603:10a6:3:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Fri, 12 Aug
 2022 12:25:32 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%6]) with mapi id 15.20.5504.022; Fri, 12 Aug 2022
 12:25:31 +0000
Message-ID: <16d50def88afcde1b7323d83e5c9a84d7df0c666.camel@nxp.com>
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
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Date:   Fri, 12 Aug 2022 20:25:20 +0800
In-Reply-To: <CAMuHMdWLJ4t0GVXNWONwcSWuEBV6EuGTm4a2fumA_8dpD7TQuA@mail.gmail.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
         <20220804061133.4110734-3-victor.liu@nxp.com>
         <CAMuHMdWLJ4t0GVXNWONwcSWuEBV6EuGTm4a2fumA_8dpD7TQuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0101.apcprd02.prod.outlook.com
 (2603:1096:4:92::17) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1fb1f5b-e609-4120-ed29-08da7c5dbf77
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2665:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2C9oWJ9k6lgvbrTU2bu+OVlsrg7r5XBukkuDDpPXTzrT4rMUmS+B+iVvVcjocm+r4kToZ2WexWKGP3TIXf2BLMN1/1h4GdsN6yILj1yfu4wfQLTa6D4T0FwGkqI/aPqKQa0LV9k61zWkSZ3vhylXg8fOVRiUkU4NP0SajIIBmwMFgE+QSHa7rMaFq5PogIFFba7UgWdUQfd+ZoSVw/IQvJF4YzILjwM7GAl969+py+qFO0dYBnk7zAG49pINUQUxdJOc6HeSYb3M4aQlb68efEBTbY7Xy6HS+vc/D8ww9uJxu59yPT/ABLJdoWzq/w+tKY936RtY91mtegKZMGJ2xybFTKpeXWURfAb/NBgDkN0DaMLMyGr04+KNd41sOaH7naPoYHK9Srjd7rDlP520X5kIcdNJo/DdxYyvMBVwhVASYWXRBc3kqoN7E1FWYzoKnwMNH6wad4hh0fwNAya5bD0zqsaCcifcRWD/RnFos2ju6O0jwRlanFFfb9rtbV4lDbbSxKAXSpBNZZFJ6tB4Wul0cEyr29DfenjvFmME2NUh81sOiTs/umarYFRTsPZY7qT9jRWzGHHuAYDfeU3WVythB6DpVQjHIMtpCk6tXi1P85Uk/RUZZut0lTQ72Yfgg8JRKxpVte8gK+VVXDQNwOXP4OQlt9fAwfh1U0a2aAZXTLaLK0/OfsfJ6N8sstqxCeHEsFEYhISqtURW5iruDxtPQXA5xW9YRD6HsNhMZpBaoU4Rbfa4IcKFG5zO1hgVru+xTI7LmEcTmbCajPlw1MhIqhF/4MwXT7ihQ+5JonbbusVqGSdyhopGxNArvzU7HvrAF3QZWH32kDPQ0QnEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(66946007)(5660300002)(7416002)(8936002)(66556008)(4326008)(66476007)(8676002)(2906002)(86362001)(54906003)(6916009)(36756003)(316002)(6486002)(38100700002)(38350700002)(478600001)(41300700001)(26005)(6666004)(6512007)(52116002)(6506007)(2616005)(186003)(53546011)(83380400001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjI1UUJHaW5LME03TWJPK050dk9KbkV1SUhpNlk3K2JoZFRzd0lyK25xL29t?=
 =?utf-8?B?V0ZSQmNSNzl6NXdiN3o3ZGwzYlh3OHVvTE5EYlZhTE1VYWxpYXY4OGZHWlA0?=
 =?utf-8?B?WkpKTEQ3SXFwL2JTanBmMVY0ay9VQ1R6WDNiMHVJK3hWV0V0aE5oOGtMWVZl?=
 =?utf-8?B?UERYVXJOdXpKR296c2owL2VqOUJRcGluOVBoaHZzd3lPMGtKVmp0OXdJOVJV?=
 =?utf-8?B?aHZlKzVVYWRxbkI3ellMcDl5TXZla0M2Z0dHYU9lTmNLTndLKzVCL1pRT29v?=
 =?utf-8?B?UktKQjZ0UE01Y1dDZkhady9hUGV2MjVyZEhzYkRReGYrWFBvSi9vOVJmOThv?=
 =?utf-8?B?aC95VXFMcDFrVnBORjI2RC9OcTVDR0NDZjczMFk1bXo2S0NYUjduMjQ2Rmpi?=
 =?utf-8?B?TjVUNzloNjFITnQ4T2U5em04cmFaTk13YXViSTJqTEEweHkxbmJWdlNudjdr?=
 =?utf-8?B?QTFDMk1KSTI2WUhIRmdlTnl4ZXo3bXRKTXQwcEZ0bDlYRmxteHZYTG9XZlIz?=
 =?utf-8?B?MDk1cVJDRnVTRDJZd2ptc0hTMGQvbnZUbzByRWIxeENEeVg3MDRmbmMwOGEv?=
 =?utf-8?B?NitrZmpaUVIzcnFPR24zenRZcUtReVpHaW44aG1OdjhZSUtkUFlSSmZ1SWNp?=
 =?utf-8?B?Ym51TCtCUldrcmdoczZHS2pBL0c4c0dUWlNobTRPTHp4UzNIQlR2c3J5MmZn?=
 =?utf-8?B?T0pvTTRDb1VCYzg3aW1GRHN1Z0pwaVRlcVUyUWlyYnhQcTcrVDc5TGNGalBw?=
 =?utf-8?B?NnhtUWlCdWxCWlZhc0xWTlJWcU5Rb3BuWXFCOVZ5aHFwL3lpRCtIZGJRK2E1?=
 =?utf-8?B?K2VKSWY0aFkxSzlLYXB4bVFibSt0L0E2Tkc1ODhqQ3dMckZYcEFGN1NiYWlQ?=
 =?utf-8?B?dHdVWTBnd3NmY1lJNWV0MzYwK2FwUHd4TDNrSWRLQmxxLzQ1SDFlY2JIZUk4?=
 =?utf-8?B?Wk5VZGRvWmcyRVpWMXg2R2FIRU00NjBwNGV1d1dRK1V1dERkTXZpQXJIVi9Q?=
 =?utf-8?B?N1lCUHNqRGpML0xTdDVVVHRQdFNmYUdPTW5ENU8xdTZjUmcvakxwWklsUk5y?=
 =?utf-8?B?UHA3Yi9GWkdabDVML1hhTTdLdmdmYmpXK1Blanc1eEZSb2Y0eXlLWFdkVVJW?=
 =?utf-8?B?eGJTeVdhdkUycXJJVEJMV3d5SW5YQWpsWEY4cS9rektZc1NyUytaald5YzlE?=
 =?utf-8?B?SU1XOXlyNUdKVEsxdnFwY0RJci91SmJrUFhqb2I3YVk3NzhDaUdQRzEzeVZt?=
 =?utf-8?B?c3RMRUdrUHgwL2FCMmpueHlyTGg5ajE4ZHVJcFFUN205YWZWL3ZjOTByaHJp?=
 =?utf-8?B?WHArS0JXWHhtWHowNDVMZSt0eFBPMGtDKytvSlhNTktVN1RTbU0wK3dtT2tH?=
 =?utf-8?B?MVRWRDZEVE1CNnF4Q1JvdEdnSU41SnJvWXdmdXgvZEN6R1pKSEVRdndzY0o3?=
 =?utf-8?B?WEpYNERUdDFLU2MzMzdSbmQ2djhiTGZNTW0ybXlRR3hxc0l0SUJTRTlyMTJW?=
 =?utf-8?B?L1g4cTkyZjhHanQ2LzduV0RuaE1FaEswcFdScGZwZGc0TUVmR3pHSDJKZjF4?=
 =?utf-8?B?dGkzWXJiL2tnbHhRc3JUYWovMmpCcFhzK2dCTGJab1V3SHh2RlJGQVhPR2c0?=
 =?utf-8?B?TVFoOU5uNjdqbjlMdzJneVFkelpZb0FhTjd6OG1PYjJSVkRMTGFLVzNEK2ZV?=
 =?utf-8?B?anBweXNXZkJmeW9XUlFGNmQ4TStPR2llWC9uZmNvMmNkYi9pMXc3bGZONEVn?=
 =?utf-8?B?Q3Z4aHgzRkY3OUZlclI3MFk5bVQzeUZHYnMvdG9aTG1EVTFxZE9PVFNJK1Vi?=
 =?utf-8?B?QjY5ZUcvT2tPcHc1K0w4SGdobmpQQm9rZWtlUTdtZExKSTcxdG85WHdOVnJ3?=
 =?utf-8?B?ODZzSXZ4L3M5ZSt4eEdldUJkY2o3aHZlUUxnbFk0UFExa1pzRytXRlVOaVQw?=
 =?utf-8?B?MDNzN2QrckJ2Ujl0L1VXeGROTmNwMDZxbHErbUFYZVlsM0pocDdXaUx2Wk5S?=
 =?utf-8?B?d2prQVYyUmM4eHp0VHFTa09Dcm9RU283emthRHBWem1nTkw5cUYvN2FLRVpK?=
 =?utf-8?B?OGM0MzhsV2lkZGlIZ05NQTVPOHZ5aG9hZlQ0bVdkYTFVSXFhdEdwWnVjSW9v?=
 =?utf-8?Q?adf/hKU5tr+KvQJNhP+exQewb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb1f5b-e609-4120-ed29-08da7c5dbf77
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 12:25:31.7456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sIO01JEi+HkZm0Opdd7HYehSBG+yfbNxA7iDJFXCHDzdwsqiSW/cwU9URrWHPfEHvcXAC97D7ogBu9l6xSpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2665
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

On Fri, 2022-08-12 at 11:49 +0200, Geert Uytterhoeven wrote:
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
> > ---
> > v1->v3:
> > * No change.
> 
> Thanks for your patch!
> 
> > --- a/drivers/bus/simple-pm-bus.c
> > +++ b/drivers/bus/simple-pm-bus.c
> > @@ -72,6 +89,42 @@ static int simple_pm_bus_remove(struct
> > platform_device *pdev)
> >         return 0;
> >  }
> > 
> > +static int simple_pm_bus_runtime_suspend(struct device *dev)
> > +{
> > +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> > +
> > +       if (!bus)
> > +               return 0;
> 
> Can this really happen?

Good question. Should not happen in any cases. pm_runtime_init() sets 
runtime_status to RPM_SUSPENDED and needs_force_resume to 0, so
simple_pm_bus_runtime_{suspend,resume} are only called for
simple-pm-bus, not the others. Unless I miss something, I would remove
the check here and ...

> 
> > +
> > +       clk_bulk_disable_unprepare(bus->num_clks, bus->clks);
> > +
> > +       return 0;
> > +}
> > +
> > +static int simple_pm_bus_runtime_resume(struct device *dev)
> > +{
> > +       struct simple_pm_bus *bus = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       if (!bus)
> > +               return 0;
> 
> Likewise.

... here.

> 
> > +
> > +       ret = clk_bulk_prepare_enable(bus->num_clks, bus->clks);
> > +       if (ret) {
> > +               dev_err(dev, "failed to enable clocks: %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> 
> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks,
Liu Ying

