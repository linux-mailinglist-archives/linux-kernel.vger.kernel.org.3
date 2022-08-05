Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8E58AAC0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbiHEMUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiHEMTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 08:19:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2068.outbound.protection.outlook.com [40.107.104.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE0B7968B;
        Fri,  5 Aug 2022 05:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4QCFDImeflhud5vcu1AnsBfm3mC/MYQ8y990mivSA0E+jA90vfChjEF+KrgBLEu3e1YMuqAymeUz3S7pWMqDiUoVgV4CuPWiPKt3e3hKWZ6VhkKJFPV2/oaZsyVvzYFE10hWDNa+jiHdpTIcDUaJMWsn5iIXhkpQ/4dvis3qiTppin4x/Ev+gdiLLhdbdx8nUr1+WmsdwZBHujls3bqjyTiORwib4ZpIJ9KkbwgEAmCCECZOKZcAbnLzc0ycmHrGY++ix/iPaIvmupSC2m4DPkLG+rI1Sv1Uwcr4T+Iv68P7JLYaa39s76P3SafIeDwiD48IvrmMXsUexkfFmlh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGVdzudzkh5NRGvvOywo/nDKt8SzE3W3Mj7/KVYH1Vs=;
 b=cF50HF3n5gFdzWJq4N6yEljF9fHiDI3QXmXIboGj/rYO73NNzMofoaaEN+L/HCed2icUga0E7aU1xP61HD927cGmyvtiuz09CFTljuT1C8zkxygz0FMX3MjlYliSgf3yzVTZLUtrlh79CFRwVeqx58mXDiV6uhpWK5mTi9azJXeEn9n7tq927hjRL4BEHncvrPpWBqNt065D/bJj/erihqN8E7V5zRISGgEdwCSRi2E2thkvp84Ghqip3R8NNLE5wMBHF4seQ/4+6yDMz6F/W9Z11fERNoQwDhvwf5sCqfLyKTB2ZIEmgXZpN81WOZ6QEndkA50IgrKQdY90ExqGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGVdzudzkh5NRGvvOywo/nDKt8SzE3W3Mj7/KVYH1Vs=;
 b=ATq4sDSlDPCPftJQeOOHMCd/RF2Qxqzzy+cedA/ClmaYhVKIpgGR1dwzzSoZNogdslqm7b4NcTRcG+BkYZQ6GmaiunfKkmT9TwnV7ctK1CmHMr9PYIL3vSYLdszk4nJaRDuPGSxnVfnwXve8vSviAl+wqZ0f9gNCNQqbHMWH5+Del427iJSIKRECgm7RxrYUycdQar/ezR3hHztz/xJEil6D1bk1yLw4mc7FFEzZ9JHU3zxUbOqqB+Elcd5cB1GPx2sOfq/7bGZNTdFJQDwNu7eoPiqYgpIAkNSrxw8OX7nM2tl12EfAD9WDXJUQkBnf0KP5+tzpIjU1OxR2AkT5SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB6692.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 12:19:28 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5504.014; Fri, 5 Aug 2022
 12:19:28 +0000
Date:   Fri, 5 Aug 2022 14:19:20 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] leds: simatic-ipc-leds-gpio: make sure we have the GPIO
 providing driver
Message-ID: <20220805141920.78967d15@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220805120343.5027-1-henning.schild@siemens.com>
References: <20220805120343.5027-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0054.namprd13.prod.outlook.com
 (2603:10b6:610:b2::29) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc924669-8dff-4bc1-f252-08da76dcbe23
X-MS-TrafficTypeDiagnostic: DB9PR10MB6692:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMmrk8/wIvBILPPp8dZc3FC3PXj8JeL4eb0t6FwF0IN1fo37bhIwpvxx/Ode25G8YgJC/1ynF+upCWRKn55zd+zi2gyE6teamHqQnZH6mwcmsD0doWSbRyP//HAEKOPUb8GptvZeo9izKis2PZztXnZMoCbFz8BquwNwLpNOWaqbb4LBHLneNca+wd+ftLqdr0MjSpNAk8Tn2OZ9/NYvoz5wtUPK2/Njf2Ukf1TWDjJvwPUBaNN9bMKn3DtfCGv11y5eBgjrx1T6Cv3Ca8bmksNrwxVntXIMU4MAXFw1ZSDGyB4pKbzSzGzKtnhGspz/qZGB7tZUO1IC/EyUS4G7beAUYVfU29fsvgblkwLSOdl0ntQGknhqGB2Fkd1LKVYJrLY9TPpb+Rowafmxqn4UixTInwX7yEh5jKXTSCEyMjqhN57vMrHHxO0qzRMJYNKouKtv8aNGWYs8ptnfTn/kKI2Ck04mrgOOmOaZf1V2fhHlKxfrRDwHdN0aTfptilnIokoaNTrFmPh4+z5eNdxz6a9wNPnxGSWq5TtJ2e0i6nJftu8fvZbD6ORBaU1Pf0hzypMFEjrnwuOxZu6ymf2xG8INcHfNjEY4N2tyBIf7Q9l5lxGTkEruegfGY4MTsmut2pk+ZbwbW4/oYm0rRw4AwTLzc7A7aAKdfOqCtSBmQGvGC7zT2wHVcrgLkkHon0yVFDCLnRAVWi9sjOLgQjar7WuhwxhU6xVlTAyEB6WUudM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(66476007)(8676002)(478600001)(6486002)(316002)(82960400001)(110136005)(186003)(66556008)(1076003)(66946007)(83380400001)(41300700001)(6666004)(6512007)(38100700002)(9686003)(6506007)(26005)(8936002)(2906002)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z0QpeNjXDf627/7g7ScMvI59fmc45tnjA1e8T90HNJkVSPv7q9+SCKGy60Mt?=
 =?us-ascii?Q?gI6he30WOIfoU9MsvzPujh1il7TdcLc6o0xkxPmZ4cTYHK1ALzNmwwRoCMpj?=
 =?us-ascii?Q?c2kA10o5LtH5qvkFox8vBI9P0nXpFkR9fzOacPmhOARZWRerwyN2juh8Qz2a?=
 =?us-ascii?Q?IvsH/DoAAlqEPRJi94lKhOxv4ZEH4p9DagpscGU6JnP2NV4kmJAfL3vXA5Pa?=
 =?us-ascii?Q?SkjyX5sHck+BPEF05yE/IUY45Wslix0TQIbp6irvli+yPgwbcjYZX2UquQ5j?=
 =?us-ascii?Q?+Evtb9lxQFv7Sh8pjcPIneVdPhFk/tRHnL7SGhiwjxisQot1CnSFCVoRDWSM?=
 =?us-ascii?Q?vx+lldz4ibZPEAKCyXaRFlw9nRojM67NEqg45cKJUmII3bI9G+HJ/nUysGUB?=
 =?us-ascii?Q?ahUGCWT/KHNs4VbZtxe9FymxBu07h/mLw6hTEuG82mrg5ArJwNwclA1eAlTu?=
 =?us-ascii?Q?LAt4v9nwvzLO/MnEORRtvtrXitkMU37HsIDwkTmfyq63MorAEhEmtRbZ9LVS?=
 =?us-ascii?Q?ikrxqMGTxuXcxHDWJpDdsF4RYUvxEt4itMxqwWMtKQdpAPPTacH9l8OLIYwQ?=
 =?us-ascii?Q?h72r21BeoDQkdeXRmtmHqfv6Ql4+EiPehhXeDeXUwEkkpbW4MB852L4ENHVa?=
 =?us-ascii?Q?WLApBf7MR589yyTb9fS0cdyudSyngho8pXG/AfsBHwOkS3b6mrIoLFpbiAZF?=
 =?us-ascii?Q?RzgGki/9PvsYCHvH1kKwbrA9x/1ufKPbfwVWWFZIAnQLBpATqid1nosUIAWQ?=
 =?us-ascii?Q?KsxxoucBrB3sh7OcVZrPS7P0mHEWc/MFZ+pHgixwRBP3fOKjNx4frm7PMPOY?=
 =?us-ascii?Q?68uytDBXotNVKmUWvUiCVHVwMp97Rrb8Wvox0ZeaHczKoqoFt0WYx3O8sVoN?=
 =?us-ascii?Q?vwMJN7dKbxzWMcjI4l067SU2lleQLvBo37c61DesXnhQDChF3C2h4GqDAzrl?=
 =?us-ascii?Q?/Z4L/FHCh5PGM6gzeS36v0fe0d2qacqWaIJMbkWUeueqAp2giucbFuGhNzgE?=
 =?us-ascii?Q?EkdzAeXjL7Ay4IRXgU0nMdnt/ySBoCjVXqHLWJj2QgkdCq/Q2e5F92r09Hul?=
 =?us-ascii?Q?9pZ8gQPOK9dk3b3SyjRS3Ezr8AE5dqom57wro3vM9Z3h0w13DdJ6dYdjNcYn?=
 =?us-ascii?Q?6YS+Fn02e6ThtdmNqDsTbUudP9y61zW/TPX/Ij2A2YHnyBiGwy165D7O5GgE?=
 =?us-ascii?Q?7ZjjzFZjH8XRsHQ2MXZ3UTwFOJY/uVfomx1ky4WdCpHcm+0fOFzjmCPoAcJi?=
 =?us-ascii?Q?I/Hvx2S2magu6L/xCH6E0KG/Pkbz0tLR1kzYhUVz1FKpc44Xwe/Z4SnSrLU4?=
 =?us-ascii?Q?B1uM9vKgl5I1vyG2wE5rfYNP5oSIUiZrlJtqGjOW/ix3padFpSCGDihByipO?=
 =?us-ascii?Q?TpwdlrDMXx8AMVoo26EM0gIDb7F3nyoPVoDFxPcIQMwNQuHdOgp7apxC81dQ?=
 =?us-ascii?Q?Hf+RCp+08GDteA2VOFLW2fVTswH6z1sYj+CMkHolzBrcx8XUJlDKnPkXGShb?=
 =?us-ascii?Q?iT2SRgLDZXEHYvnutuWlJzmPooImOI15DehWxmAj+H3+zoXd9AI8aPG2TKPF?=
 =?us-ascii?Q?F6as2PKsfPEP+lUJy2RVTYJk0jDNLT5tzw89C+lDLhpDJATSpnkAqQdCQQXW?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc924669-8dff-4bc1-f252-08da76dcbe23
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 12:19:28.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QvO6xDSuJ54y9WwMzdOUEZxan7YLDqxLklJiazIw/MpoVMclNrb0b01MO4Z3RLu2KIjbrJ8hW81ilFMdAmpxMUehw5PVRVmmunIViX0yKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6692
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies on top of
"[PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper"

where it could also be squashed into p12.

Am Fri, 5 Aug 2022 14:03:43 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> If we register a "leds-gpio" platform device for GPIO pins that do not
> exist we get a -EPROBE_DEFER and the probe will be tried again later.
> If there is not driver to provide that pin we will poll forever and
> also create a lot of log messages.

When i did build a kernel without PINCTRL_BROXTON and booted that, i
quickly filled up my disk with gigabytes of log messages from
"leds-gpio".
 
> So check if that GPIO driver is configured, if so it will come up
> eventually. If not we exit our probe function early and do not even
> bother registering the "leds-gpio". This method was chosen over
> "Kconfig depends" since this way we can add support for more devices
> and GPIO backends more easily without "depends"ing on all GPIO
> backends.

The series "[PATCH 0/4] add support for another simatic board" shows
how a second board would be added, using 

	if (!IS_ENABLED(CONFIG_GPIO_F7188X))
		return -ENODEV;

I am not too happy with the solution. But it is better than "depends"
because we do not need to build all possible GPIO providers if we want
a minimal kernel for a board, while having all simatic gpio based
boards in one led driver.

And we will anyhow need to "name the provider" in case it does not
auto-probe. Also to be seen in that other series where we

	request_module("gpio-f7188x");

regards,
Henning

> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c index
> 4c9e663a90ba..0c96ba98e338 100644 ---
> a/drivers/leds/simple/simatic-ipc-leds-gpio.c +++
> b/drivers/leds/simple/simatic-ipc-leds-gpio.c @@ -57,6 +57,8 @@
> static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
> struct gpio_desc *gpiod; int err;
>  
> +	if (!IS_ENABLED(CONFIG_PINCTRL_BROXTON))
> +		return -ENODEV;
>  	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
>  	simatic_leds_pdev = platform_device_register_resndata(NULL,
>  		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,

