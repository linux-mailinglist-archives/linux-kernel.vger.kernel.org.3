Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F6D58A936
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiHEKHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiHEKHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 06:07:01 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20060.outbound.protection.outlook.com [40.107.2.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7606715E;
        Fri,  5 Aug 2022 03:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHPysnsO5NG18bF9KJXaUtNSPAoRKbac4nnlQYYmQYiSI0QKf4N1WYJqYnA64SSS4GgS9gR3N3De2TMHoO4+scaQZ/7OLih9Il1lFUyc1VMU2vVB7pgIGeKZw3BdXZJqaHRQMArZ5lIkHSswPlzFTR2CsCxBV198nNQml24Y+h8MM4vNwnVw5IrghY7CLNYY7l+3LRV4/5sKH0xP3QGFpKwtFCjuoRd7wl1Y6K+bfBPQudktQxJ0MRZ6gKwfwA1SYPrFdQeRzZXsA46w8FjXasrtnptL/ydWHDAV7h17QVHRyrJ+KuFb4FLkIsHOu4NK7uXmmNlGROWsEcFnX23EWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zFM+OunDiSc7560Syte2Tu2PvPlxe9207snQOd8X7c=;
 b=oVL/QB+9EncsYuF9I1DJ/JOOG72DG4la7GzCvUENFc+E9abRBplT7+uJUeFh5oGlmpd6cdi0wI0BWJzvViEcJdToZOyhHKUCSRd2beDmC8NRzpoT11UiDmbCQrla/TCdfxbpXJNpPK2OoSYkHIOkL2ifC+UOLaJbfgyamT0o4xfS4ARnLZ3QOoLxJsORd+mEf/TNlCK/hnevecZ9Tw34K/a0GwfdFVxm4OLBIYVJ06pf20xuKVaGxx+W3uQ5vc3ToBzBp+5t5VLSfxiz0Cvtkx+ZdSWsaTCfzNh33/9xZgF1eD3lSwJEMV4rUduB85x4ew5ZUzqUcMv+3BNADgH41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zFM+OunDiSc7560Syte2Tu2PvPlxe9207snQOd8X7c=;
 b=sDKyTQbQkWuNePNcFDpzMF8IcY1ldljxitZdd37niNjWLNxV8DoSsq2JIzkZV3nGrYxgmNjxn4gjo7pzvVaB81oOLMJfXWNc4hIIiSbH1zn/DA42MArMlJG4exIW6RJeznruwgBV0nSiGBqUGQQp5IE9tZ8MBEDaCr6J0kyUKn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR04MB5215.eurprd04.prod.outlook.com (2603:10a6:803:59::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 10:06:56 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 10:06:56 +0000
Message-ID: <dbafe424aa9b4cdb79397476c1c4085ea2f0d242.camel@nxp.com>
Subject: Re: [PATCH v3 1/3] drivers: bus: simple-pm-bus: Populate simple MFD
 child devices
From:   Liu Ying <victor.liu@nxp.com>
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Fri, 05 Aug 2022 18:06:46 +0800
In-Reply-To: <CAGETcx94De-wofRjtPgNxa+YQoU3+j+we+4K9Evm=vtzhopX8g@mail.gmail.com>
References: <20220804061133.4110734-1-victor.liu@nxp.com>
         <20220804061133.4110734-2-victor.liu@nxp.com>
         <CAL_Jsq+B5PMOmZO4hz5DyEsA4V=UkrNn-6b58h8VbcPa2iaQ1g@mail.gmail.com>
         <CAGETcx94De-wofRjtPgNxa+YQoU3+j+we+4K9Evm=vtzhopX8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ed44829-6f75-4d89-0676-08da76ca3a8e
X-MS-TrafficTypeDiagnostic: VI1PR04MB5215:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUkg45XjjzOXSpmFpa8DEXLrTSS8IME87Dx3Z5rFKE/X51QsUxuvAdIfaah77vv7KAmT+tmWgLxCW0jA3JPQcpszhnxxAIq84ZoRtgniAshXQJkPIGqYwKRIEwfnDqf/Cfv7BXU0BMBwokc2Z2AbdpFDz/tBthJYoRI3ow0gWyFoJnsKZMPiruG4aG86euN/exTz2Jp5zTmnw/n7hl3D/F/qiI0AW9WuSeB59oelNcwIJOGi2zZnJ8QUYDW81kKUa2KScr+UAULFWUV7tkzmRs8vFW5gb/wwNd3trfrddX8/+qKqAXQRdE3dI5N/Tr+hCLe+REASGzgoR4axdaVVU6f2bRxRxtf4aF5SyKAzH7W7GfUI1ezlid/+EzelCfIVCK+38vM9cfoSb8XbJq/x3PVMnr9IUoq/t1B3/gXiaRFxJff6x7Dk/OX/FOGO9WOSIEMSI/1s0tdJy+gzu7yfLgQxHCxC6l7VqU4z3QBGttTDmH5emUBTV82l3vnR0micsgGWf44Gs/e6RiEJILRWuzwjyT9fFUfcmtN6nZ+2KK1Bp98cSRkSme44fv56Z+ObSfoews3mOX9/CQTsCLmpaVFBsZSS0XVMPrqfarsT8d42ar7RMyn5pgtWBjuaSJiQJ8oRfdwWO0YSsvU6A3LybhH/PJIUPypxdmNp5exbFbdAKLDv9vnhzbyhl+1eoabgG1grfgXURKW2SshW5RfeCO45f/mrzhCpXYQ2HGhbW9GR1jQarpRPBz7mps2OjCa1bxdAWQCNP1DO964ZeUbnjJ94mnG6CcXDFmVv+/KvKrmAjg8pTM/qKd8K+E6y0bRe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(83380400001)(86362001)(38350700002)(38100700002)(4326008)(66946007)(110136005)(54906003)(66556008)(2906002)(66476007)(8676002)(316002)(5660300002)(53546011)(8936002)(7416002)(2616005)(26005)(6666004)(52116002)(6506007)(6512007)(186003)(41300700001)(36756003)(6486002)(478600001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0JhaG5qMm9WM0FwUnhLenVUc2lhNktwSUh4aDdJYzd5MFZZV2trZ1JGTDZH?=
 =?utf-8?B?ZjB6ZXkvdUxCVkplZ0JtbDNxWGRYTHl0a2xRZmh4UHFRYWpyaUdCTWNrY2JK?=
 =?utf-8?B?djVTOUIvVnpLUGpleVQ5NTBsQmRDK1J4T3kvMVF1REl6VyttRi9RWkRZQncr?=
 =?utf-8?B?N0xsd25rTHh4ZnIwbzlFRTFUK0lQYTVUODhrbXVoK2daU0ZyM3BUUjFPQUlt?=
 =?utf-8?B?dmdFemV5V2p3UHcwUFJkR21Lc1NyMjllYmcwUXNlMmN1cERXWTY2VmpvVEQ3?=
 =?utf-8?B?SGgvaTFrcDN4WGpYMWoxSlI4eWxTVHF5MkFRazRIR1lFRFdPUFllUkpXRFBu?=
 =?utf-8?B?QWxUSnpKOXBLT3p4clUxWmdlY2dWZFNhWHdVbnRjd01JNmVlakdTSEgvVXd3?=
 =?utf-8?B?K3FreGxxUWk3RFcySGJwdThpRllXa3dZVENaL1RaZlNLYWo4Qm5wbUhVU0VW?=
 =?utf-8?B?RlR5TEN2SEg4aGVUZFFiV25WNFc5N09RajlkL01YVGVtQXFOMDIwRDNVK3dY?=
 =?utf-8?B?RmsrRXdvQTl0NlZWL3RveTJIN2o4eGNHL0pVSDU5NkN1ZURLS3RMcFYyUHQ5?=
 =?utf-8?B?QnVzcngxcW9YV3o0bXAvZ3JhUkpSTkpTWUt6elFFdWpBVGFmRHlucjl1QU5E?=
 =?utf-8?B?WmNDT3JEeEdQdDFyMHJNRDdBTmtZK0FtRmo4ZVliRlZtazBHM2k1L1VYOWlp?=
 =?utf-8?B?YXRnVmtaamtObitXcnVLSElVR3Z6MkM5dWxXN2xOU3p1RnoyTlVvWDNnTG1C?=
 =?utf-8?B?bksyUk03ejNaN3JvTmhWUisvN1FGSDgrYm5Sb0sxdmt6Z1hGTlBuMGowWmxU?=
 =?utf-8?B?SjFma0VBdVZidnd4ajBXOWhmUkRaeGdmbFdWQ29GQ1BERGZ0cHMraDN3TGVm?=
 =?utf-8?B?SndpSHUvbXB5dlhnV1RwMnJYaU9Ob3ppSlRaVlk2a1ZlNjJCcHF2Nm1yMzNU?=
 =?utf-8?B?TGEyK3dKWXc5aWlDTFdLUFNoQVRtRVZFMXhEd05wYXVOQmRQYnZ5VjlVQ09B?=
 =?utf-8?B?UWE2ZDFzZUk3T0tPSGNPcG45cWVDaWUvcGtDMkd0eENsTHIwakZTcSsvQXI0?=
 =?utf-8?B?QzA4cXRESlFmUGVwM1BxcVd3TWR3VXorWVVEeWxIWC9MRjUzdHhNdFlOSGw5?=
 =?utf-8?B?NDdXUG1iY3laempVekRFbWdZY1VIdGNldG13bXhFdVBFU0N0eFFZUnB6VWgr?=
 =?utf-8?B?RzgwRkZFdnlJVnZvUFBhVTNTQzlZU0tsU0oramFpa01ZUjh2NlRDQTlTOFd2?=
 =?utf-8?B?M2FweEFJL3FMdEFSTG5ObWYvL3FPQ1loeU5WMlFSOTVEa2dGK2k5MzVGSTNs?=
 =?utf-8?B?bmRCWktDenJCL0NsZ1NSNmh0d0RXYTVkSEYwM2VPSEp6TTVzczBtOEpvTUtX?=
 =?utf-8?B?SUYrUEVvMTk2TGhOT3BUWnREMHVtaTdzNm1KTXBwdld2RWtySU1YUFZhV0RC?=
 =?utf-8?B?SnN6OVFjbWZPemVJZ3pkU09XamFVb2pOL1FGRE1kTmJZTDhKbGl4S09ZZDAz?=
 =?utf-8?B?Qm5hQ1B0akpaejlQNld2Tlg4WExIekx5MDBkZ0tYZVJMbWN6cTJiV3JLd0lD?=
 =?utf-8?B?b09UcTZnZWJ5MEMzUExzZi81VTJDeFNEcTNqVmJlbCtSL09tR1FjemZ0Q1Nv?=
 =?utf-8?B?cjI3VTBOeDZQbHJnUzZKK3dyY09JWGttUTFkWVFHd2FuWmNqYlllS0ZTdzZO?=
 =?utf-8?B?eTVSRzlPWnpzd3dhRWsyV2tValZQaW1LWm83ZjBWeVJtdnphT0lmc0ZrclBS?=
 =?utf-8?B?NTlVeUJLRkxwOUxUUVRuQzVCYlBHWDEzTDZqMVBzN3VMdDI3cnNwcEV5eFNk?=
 =?utf-8?B?OTlFVDk1ZHBheDNnNFUvRnk5VXBWakpIbUdCdCtPbmpOWFpPNW5iYnoxTTJx?=
 =?utf-8?B?MUNZWUhRZEszNWt2UWFTWnBaRmZkV1FIUGhsMTJwZEJuandhd0JJNlBlYmFJ?=
 =?utf-8?B?RCt1dGFwU0FQNjBuY2xtSjZOdlhoVkhKZ2Z2dTBwUkc0aDJrZVB4ZkYxWXl5?=
 =?utf-8?B?MnhEVEdSdVVUUzM5WU5wMjE4WitTNnhESGRIWVpSdFRnQmZpeTdGRHhTT045?=
 =?utf-8?B?RnBVQWh3UmRqR2xkd0VoMmhUZTJLT0ZWRHR5MkVOeXVzWXF1dS9LbE1zMXJq?=
 =?utf-8?Q?TIQewi3bA6sY0mleG8fsk4kAz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed44829-6f75-4d89-0676-08da76ca3a8e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 10:06:56.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mi9mz4ELcvUse4r1/D2vK979wmoI0anAltP8VMzCMYTVP9duMXoJ5DcgJrP1rT679UhbPs7pOcg7UmRw8hr6/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-08-04 at 11:26 -0700, Saravana Kannan wrote:
> On Thu, Aug 4, 2022 at 5:18 AM Rob Herring <robh+dt@kernel.org>
> wrote:
> > 
> > On Thu, Aug 4, 2022 at 12:10 AM Liu Ying <victor.liu@nxp.com>
> > wrote:
> > > 
> > > There could be simple MFD device(s) connected to a simple PM bus
> > > as child
> > > node(s), like Freescale i.MX8qxp pixel link MSI bus. Add a child
> > > match
> > > table as an argument to of_platform_populate() function call to
> > > specify
> > > the simple MFD devices so that they can be populated.
> > 
> > There could be a simple-bus under it as well. You should just use
> > of_platform_default_populate() instead.
> 
> I'm confused why we even need this patch. Wouldn't this driver
> automatically probe simple-mfd buses and populate its child devices?
> We already have it in simple_pm_bus_of_match.

First of all, this driver doesn't populate simple-mfd bus's child
devices because "ONLY_BUS" is set in simple_pm_bus_of_match[] for
simple-mfd. 

The device tree I'm working with is something like this:

bus@560000000 {
	compatible = "fsl,aips-bus", "simple-bus";
	...

	bus@562000000 {
		compatible = "fsl,imx8qm-display-pixel-link-msi-bus", "simple-
pm-bus";
		...

		syscon@56241000 {
			compatible = "fsl,imx8qm-lvds-csr", "syscon", "simple-mfd";
			...

			syscon_child {};
		};

		/* more regular mmap devices */
	};
};

IIUC, default buses listed in of_default_bus_match_table[], including
simple-bus and simple-mfd, are populated by
of_platform_default_populate() in a recursive fashion, when
of_platform_default_populate_init() is called.  However, simple-pm-bus
is not listed in that table.  So, bus@562000000 (simple-pm-bus) is the
last one to be populated successfully and syscon@56241000 (simple-mfd)
is not populated (recursion stops).

Then, this patch adds a match table to populate syscon@56241000 (simple
-mfd) _and_ it's child nodes when bus@562000000 (simple-pm-bus) is
probed.  of_platform_populate() will populate syscon@56241000 (simple-
mfd) and it's child devices (sycon_child) together. Hence, sycon_child
devices will be probed ok.

The problem is that syscon@56241000 (simple-mfd) fails to be probed
with return code -ENODEV as "ONLY_BUS" is set and "simple-mfd" is the
3rd compatible string. Even if it's probed ok, syscon@56241000 (simple-
mfd) is not power managed, which means syscon_child devices' PM
operations won't be propagated to bus@562000000 (simple-pm-bus) (?). 
Anyway, somehow, syscon_child devices do work, based on my test.
With regard to PM, simple-bus is the same if it sits at simple-mfd's
place.  So, maybe, simple-mfd and simple-bus should be power managed as
well?  Or, simple-pm-bus should have no simple-mfd and simple-bus child
nodes at all? 

> 
> I'm wondering if you are trying to workaround the behavior of having
> "ONLY_BUS" set in simple_pm_bus_of_match for "simple-mfd". Have you
> tried deleting that field and see if it does what you want?

Without this patch, deleting "ONLY_BUS" works for me, as syscon_child
devices are populated when syscon@56241000 (simple-mfd) is probed.
Deleting "ONLY_BUS" may make simple-mfd a power managed device. Is it a
right thing to do?

Regards,
Liu Ying

> 
> And we wouldn't need to use of_platform_default_populate() because
> this driver would take care of doing that recursively. Especially
> when
> you need the clocks and power domain to be able to access the child
> devices, you want the driver to probe and do that at each level
> before
> automatically recursively adding all the grand-children devices.
> 
> -Saravana
> 
> > 
> > > 
> > > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > > ---
> > > v1->v3:
> > > * No change.
> > > 
> > >  drivers/bus/simple-pm-bus.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-
> > > bus.c
> > > index 6b8d6257ed8a..ff5f8ca5c024 100644
> > > --- a/drivers/bus/simple-pm-bus.c
> > > +++ b/drivers/bus/simple-pm-bus.c
> > > @@ -13,6 +13,11 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > > 
> > > +static const struct of_device_id simple_pm_bus_child_matches[] =
> > > {
> > > +       { .compatible = "simple-mfd", },
> > > +       {}
> > > +};
> > > +
> > >  static int simple_pm_bus_probe(struct platform_device *pdev)
> > >  {
> > >         const struct device *dev = &pdev->dev;
> > > @@ -49,7 +54,7 @@ static int simple_pm_bus_probe(struct
> > > platform_device *pdev)
> > >         pm_runtime_enable(&pdev->dev);
> > > 
> > >         if (np)
> > > -               of_platform_populate(np, NULL, lookup, &pdev-
> > > >dev);
> > > +               of_platform_populate(np,
> > > simple_pm_bus_child_matches, lookup, &pdev->dev);
> > > 
> > >         return 0;
> > >  }
> > > --
> > > 2.25.1
> > > 

