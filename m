Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9BF56907A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiGFRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGFRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:17:06 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27F2A71F;
        Wed,  6 Jul 2022 10:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nG+EcWBlg/UNR3Z+IfUh1pF8WGgaILHrytPhxwszQef+Eb9jYdBSQygUw8ZVnHe1tgBd8wZofqC9uQsc1msL7FT1MQQn+IfU325nYpgALsEojtFU1YMdHf9/8y1q3hsY0c/emTlGYTForK/ofb/yy4QncA9wl54B82+fVz6rxiATbLFw8SBi6UO33m8vhUj6l5n2+asyWFpLfdXI8YIuNJ4CRRf1C6urox/V36U+FQ2i46zsOKRsgAd9Pw2ZoVCcEjZo9Av/9wWvvMNuSpgJj2D1XmGvakRE63cCUfiJHSjWczQCnTZf5WxtS09yTaGnZDSw/pvI37FzhyLaQ6Dj3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHri1r0IcveZ3f0a12y8puGLF9qLGxYF5DnDu5a73pk=;
 b=blIOBrhbjwX4+tVTk68HC0H7eAxc5PLLSFqKO4SHngaB/Hcg5vpjsgaqNME8vZPju9mWtMjRNiMTbDPg0Z/ajD5+UEfIh+qgywMaVscdcUuA79R2VnsBfngaeq28b2Sr4VN1ecfmXqA8JDeY6a2oiatCnfKiqWHMvUC4ySrBtBQPor1BJLjH0kVkvqvIezcVs62WaSZ/wjGy720Pq3kYQhIDkV7HxgqrDF01hCujDHeyIZlHyhzLWktblnNA2qgU3R/75olGh6yGBCyf7O53UT3umrKF7nhrk12r02cILG1BNVPRWHnOeYmKqbaQe5wFR+ixA3rUWhPZnbHZTrQySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHri1r0IcveZ3f0a12y8puGLF9qLGxYF5DnDu5a73pk=;
 b=DUqaferrPUOe9qIuzCUZs1N+1eNmFdR7TMBPMFxDmnF0JuNYq8KpZnFLNoqV+LzD9f5fsYTDml5+hJJCMuHsJfvWNVvTW0TsL1xW18CNM88mpHfd4oFWzPWaCml69hp+vOU5ixiYfqEN9HTrpQIrebCjdFjC26i9DZu3k3AsTrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 17:17:01 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 17:17:00 +0000
Date:   Wed, 6 Jul 2022 20:16:49 +0300
From:   Viorel Suman <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v7 09/15] dt-bindings: firmware: Add fsl,scu yaml file
Message-ID: <20220706171649.gz7x4avjcmho2soh@fsr-ub1664-116>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
 <20220704161541.943696-10-viorel.suman@oss.nxp.com>
 <20220706143658.GA4191302-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706143658.GA4191302-robh@kernel.org>
X-ClientProxiedBy: AM0PR03CA0031.eurprd03.prod.outlook.com
 (2603:10a6:208:14::44) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8ada079-cb2d-4e76-e815-08da5f73567b
X-MS-TrafficTypeDiagnostic: AM9PR04MB8940:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+ePcq0AOhfEGvn4PvUxH3TQ2vKqbZVAp4saW/85dG3zFnM3EgrNkHNmbqqGWUHA3o3zpjNY6PZgn53AeZP2SxAtkVJ7Wc5nSQVDj3RSWcNZrfPpwnggao9k6dzcRNI4ISnOLCxxsZHrq40oG4cs9DwczNStVAvvkjfjM8wW4aki6lxQFnqPD9QfP8CEk6zFJfrGtaXu3PQOboVl7cG2cGSU5Ey0NRpafwf3rTdgIvJ5EHJhwqn8PpDwKErCUzfWxS3AWP/sC8e55UQhjK/8rCHEpEsKh6qhsKrxlLjqeU8jnZt+gbmRBUZCICPEe2WaL/QrKi/daaBQkHcUp0Qi9MJdrmbBuHrEUg6toTd9ryFu6dPIOR1ENDhdrgdcHaEynYXkGE7EuWwF1ya0zSwWYxmb6rzI0x0178oUsq7LjvuDEv7it/tVPQpyAviCDKa3EQjD7hMe/4VWk8eGAz+mffeL97PO7lvk2RxhVw218vB2rv5rjAscWDFHJao1X9k4RhXKdjDr/sc86eEkz2uP0R+Kp0lQbJQIPArs/gGQzHxxE3d0UNxQ3iSWlQ+Gvwc02rc6g0hk4p5YuHkbugNsiWuzfrTGj680agN9WAjjC/qi5GYetf3JoXck5254C23FaeKOJyWfCzNSEVNoonqDV/14nq0GVq5Xr/KgUdrTA/P/2lG8/ATXshI6I3lwJanS2mMdVYoLPa/zKY9Ja40tV+XfTYgZaoIFFCtoAQH69BR5lfCWC66U51N8JXos1ALBPzOJXugI0/8RpZSDzddj7mLXpHoB/8q1dLfo1/Sb4co9ymKGS8esDzWljydq4rpObTLAGZ/bLv6NjKxgsY0EQYzB+nspQg6SrFjCzK6SVrjn8YZRYHfOksaJj0hqjwtg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(8936002)(966005)(478600001)(7406005)(86362001)(7416002)(83380400001)(6486002)(44832011)(5660300002)(186003)(316002)(54906003)(1076003)(6916009)(9686003)(33716001)(6512007)(2906002)(38350700002)(6506007)(38100700002)(26005)(41300700001)(52116002)(53546011)(66946007)(4326008)(8676002)(6666004)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?res+EsbQ8Zt/9XaeZHij9dIr11y0VU17UvsNoMam7Hsd/OO7fdVD6Hvuejt+?=
 =?us-ascii?Q?8EBrqLFbx1VZ/sUipPRDkZZS4QS988jpPZuQbkagAaJttdEaWX/AgNZkWQP3?=
 =?us-ascii?Q?1b/Bp2p4RcoeQ1MBdiJrlTmSJqggMvS5Vxov/08B7Ejii2lny9cjR84t67bc?=
 =?us-ascii?Q?OX/iz5HZlwHkIS56zEOZxew92eAdWRhrkFu26Xg2BaKKLFx/53yCo/tcB5RG?=
 =?us-ascii?Q?V6epzdPVlE2L1ZZiPdxqjqVPyMs7r+8nxh9sQuN71BgAUtJadz+V6A9bz29P?=
 =?us-ascii?Q?XyGmoYi2/I2b7z1kl3G8+RkZMGQDFvu1ddg8R62PjUZWaiqnI06PVRxE9epZ?=
 =?us-ascii?Q?qPctaTY74cPCj2mSOwkvLbJamZNGjrjPcr4qQ5lo04xAK4asb5W+w90pE/4i?=
 =?us-ascii?Q?5f1HIb/LiBxqJgSSCYQH1yFXwdrYtVc4favfLyjh/ouiy9HWrnvZwJLD5IfO?=
 =?us-ascii?Q?ejtl44l2W7UkaBQiObT4B2gZssS0odax8qulIHTRBmPKtz13Boe/ipEDfRx7?=
 =?us-ascii?Q?p7vFVBAah0LHU2IIstC2QVFYlc2wIG08tCefBMJHKiy3AgdQIJOqmM4omUUC?=
 =?us-ascii?Q?I/9+aHkfphkN7ApbQrT5AR+DfI2ocEVYV94/jAuVR/CuVFPXSIVRo/RXTCvn?=
 =?us-ascii?Q?YyGj70OlWpDgqBs1l8enQJ+usfoeUs9sEVXwwqWKpKUI4tTLofhTkMqdwvb6?=
 =?us-ascii?Q?spHfBYI9XZ7rPJNxbDT5wHRXv6FXXwL+zy7l+gB2EepZPmqbr+T0+VGRfGpY?=
 =?us-ascii?Q?MgBr4mYKjkBa02Zyx2GLgLu5XKTLliXyAVE5sXabRRCVCsIWg2YAibaF4ab2?=
 =?us-ascii?Q?1mFI9eeFggUVDaUYKqd88LA5PEvUfCaQmL4+g8Ole2LNtKcWRNyaAL9nP+od?=
 =?us-ascii?Q?YW2XmHn/n8P5TBlMATHvCg4rUe7j0zghmDCM1BV31HOaj0aZDS1rsQ+jmQHg?=
 =?us-ascii?Q?4+nYC3ThBJBA0MIoRv7UJmp4FNmGdrCSjYg3VL+6CZQ4PpcnI9EonjnGqGWN?=
 =?us-ascii?Q?p1CekzzUk8RRr3hTb9n6Iz2M5ZbL699cxS19cyhOrK0xmveCyuIX8WmjDmU5?=
 =?us-ascii?Q?fhoSXTVLBtylHvoRdE9/crATdp6PTsBHukZ34jyU0V/3+G6earRqksjjPQVI?=
 =?us-ascii?Q?WjN5n6c7Fe66KoGQx/QMEebW/Kf0SOeaWBsQ/pZsI121ii4gwUgE/0CaTFr5?=
 =?us-ascii?Q?a60+QFF9hAeNWzx105Hv/fOHOowJGnKAB/HI6Z4GZHTF93GLqh4qSzKEsG9v?=
 =?us-ascii?Q?IB69/MEUvmOZRMzeSNz+fdUTn1A6I+DVyvFBO39HEHrVpuNQTvV5P/huIea0?=
 =?us-ascii?Q?8MFBWX+EoCP8kJFifYb792/4mk/x86xRh5AnhSxSgZEhS1CyEUwsG56zu/Gd?=
 =?us-ascii?Q?ZDuRROSM11ydMbG5hdjd82vhGF4Dc9KzJ8mTYplHjTZo6FQwSHbqIZtzumrw?=
 =?us-ascii?Q?qOMu7nDz8VqagsmoWenDIsYlzGI4/kYiCvzp0B3EMOASME4LofqcbbBlPkZJ?=
 =?us-ascii?Q?hNnyZURnw/Dn99MQk/hZWlzwQwS9oeyPohj9oboLOnYxBV9wIaIj8+KCZ5h5?=
 =?us-ascii?Q?aX7lXFX9RDBs7LjpwSw+i38pSliWQTwb7RHk0YQ1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ada079-cb2d-4e76-e815-08da5f73567b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 17:17:00.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgE04gGSQeE5e9zBOt0SAyYhuMGqOwbPONudLULv7xNBGzsQBzCPQ5xv9pwOaGD2n6p7ihxdPKcExp26cmtPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-06 08:36:58, Rob Herring wrote:
> On Mon, Jul 04, 2022 at 07:15:35PM +0300, Viorel Suman (OSS) wrote:
> > From: Abel Vesa <abel.vesa@nxp.com>

[...]

> > diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > new file mode 100644
> > index 000000000000..c1f5b727352e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> > @@ -0,0 +1,160 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NXP i.MX System Controller Firmware (SCFW)
> > +
> > +maintainers:
> > +  - Dong Aisheng <aisheng.dong@nxp.com>
> > +
> > +description: System Controller Device Node
> 
> The formatting here is not maintained unless you use a literal block 
> ('|'). But I would just drop this first line.
> 

Thank you for review, will update in the following version.

> > +  The System Controller Firmware (SCFW) is a low-level system function
> > +  which runs on a dedicated Cortex-M core to provide power, clock, and
> > +  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> > +  (QM, QP), and i.MX8QX (QXP, DX).
> > +  The AP communicates with the SC using a multi-ported MU module found
> > +  in the LSIO subsystem. The current definition of this MU module provides
> > +  5 remote AP connections to the SC to support up to 5 execution environments
> > +  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
> > +  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
> > +  using the MSI bus.
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx-scu
> > +
> > +  clock-controller:
> > +    description:
> > +      Clock controller node that provides the clocks controlled by the SCU
> > +    $ref: /schemas/clock/fsl,scu-clk.yaml
> > +
> > +  ocotp:
> > +    description:
> > +      OCOTP controller node provided by the SCU
> > +    $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
> > +
> > +  keys:
> > +    description:
> > +      Keys provided by the SCU
> > +    $ref: /schemas/input/fsl,scu-key.yaml
> > +
> > +  mboxes:
> > +    description: |
> > +      List of phandle of 4 MU channels for tx, 4 MU channels for
> > +      rx, and 1 optional MU channel for general interrupt.
> > +      All MU channels must be in the same MU instance.
> > +      Cross instances are not allowed. The MU instance can only
> > +      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> > +      to make sure use the one which is not conflict with other
> > +      execution environments. e.g. ATF.
> > +    minItems: 1
> > +    maxItems: 10
> 
> Based on the description, shouldn't this be:
> 
> minItems: 8
> maxItems: 9
>

Actually the description should be updated - there is a series sent by Abel
adding the support for i.MX8 DXL - it has just 1 MU channel for rx, 1 - for tx,
and 1 optional for general interrupt. An approach would be to add a structure
which will include two options - one for 8..9, another for 2..3.
Hopefully I'll be able to define a generic one.

> > +
> > +  mbox-names:
> > +    description:
> > +      include "gip3" if want to support general MU interrupt.
> 
> What are all the other names? Needs to be a schema, not freeform text.

Right, ok.

> > +    minItems: 1
> > +    maxItems: 10
> > +
> > +  pinctrl:
> > +    description:
> > +      Pin controller provided by the SCU
> > +    $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
> > +
> > +  power-controller:
> > +    description: |
> > +      Power domains controller node that provides the power domains
> > +      controlled by the SCU
> > +    $ref: /schemas/power/fsl,scu-pd.yaml
> > +
> > +  rtc:
> > +    description:
> > +      RTC controller provided by the SCU
> > +    $ref: /schemas/rtc/fsl,scu-rtc.yaml
> > +
> > +  thermal-sensor:
> > +    description:
> > +      Thermal sensor provided by the SCU
> > +    $ref: /schemas/thermal/fsl,scu-thermal.yaml
> > +
> > +  watchdog:
> > +    description:
> > +      Watchdog controller provided by the SCU
> > +    $ref: /schemas/watchdog/fsl,scu-wdt.yaml
> > +
> > +required:
> > +  - compatible
> > +  - mbox-names
> > +  - mboxes
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/firmware/imx/rsrc.h>
> > +    #include <dt-bindings/input/input.h>
> > +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> > +
> > +    firmware {
> > +        system-controller {
> > +            compatible = "fsl,imx-scu";
> > +            mbox-names = "tx0", "tx1", "tx2", "tx3",
> > +                         "rx0", "rx1", "rx2", "rx3",
> > +                         "gip3";
> > +            mboxes = <&lsio_mu1 0 0 &lsio_mu1 0 1 &lsio_mu1 0 2 &lsio_mu1 0 3
> > +                      &lsio_mu1 1 0 &lsio_mu1 1 1 &lsio_mu1 1 2 &lsio_mu1 1 3
> > +                      &lsio_mu1 3 3>;
> > +
> > +            clock-controller {
> > +                compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> > +                #clock-cells = <2>;
> > +            };
> > +
> > +            pinctrl {
> > +                compatible = "fsl,imx8qxp-iomuxc";
> > +
> > +                pinctrl_lpuart0: lpuart0grp {
> > +                    fsl,pins = <
> > +                        IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
> > +                        IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
> > +                    >;
> > +                };
> > +            };
> > +
> > +            ocotp {
> > +                compatible = "fsl,imx8qxp-scu-ocotp";
> > +                #address-cells = <1>;
> > +                #size-cells = <1>;
> > +
> > +                fec_mac0: mac@2c4 {
> > +                    reg = <0x2c4 6>;
> > +                };
> > +            };
> > +
> > +            power-controller {
> > +                compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> > +                #power-domain-cells = <1>;
> > +            };
> > +
> > +            rtc {
> > +                compatible = "fsl,imx8qxp-sc-rtc";
> > +            };
> > +
> > +            keys {
> > +                compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
> > +                linux,keycodes = <KEY_POWER>;
> > +            };
> > +
> > +            watchdog {
> > +                compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> > +                timeout-sec = <60>;
> > +            };
> > +
> > +            thermal-sensor {
> > +                compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> > +                #thermal-sensor-cells = <1>;
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.25.1
> > 
> > 
