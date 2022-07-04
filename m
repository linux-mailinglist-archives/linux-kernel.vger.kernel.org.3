Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744C5656C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiGDNO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiGDNOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:14:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAC1DF2A;
        Mon,  4 Jul 2022 06:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDOAHgpbp9uYVzi19FXHWJ2W8PNxgJujx5SP39fIeDqmPcBYR7hnoA3cHnNSfCVr1Mm7tEDI9NALxRWssX52UVSaHLl8TN+YMGhn7uQAoz/c2GDdqGNXI12c+MwMVl9vUkxKo3VymBSzR8YcOgAiiUWpDvitv+wO/UyOz7l8AD3aYsukQNwfF/nVtFxzdH3akTQLQz9X6h0SYIE2LFvqKB2MlGyRZQ+D7RulDVtN2faVJk9DObWvpz1D34jzirEgdEU9KdPDy3IiqDeNh+4HDjJxWBMN5tyDOHljRlTUCswGhSn8P+poDDB8AOc5e4SiUh0Q+1A9UIE6UPgvx/Xhfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7DOz78T7C7U15Y4t+BHaIgU1b4exagMO2bFf9maHovs=;
 b=VKYWU1GoS0FKhTYe0V8DgCpB8pCSdheLtwj58yZObZDhTaCkh+19QdmOAodzRDSd49iZPWKiMmevsW0txiDdNHtncIhce7ca8j2jD4biZPLTjLDTr0V2fbhJTrPuqbSLKankX3Q1Igxl/EJOKhh68fQi5uqzrP4WqV3H+1iGwpbxYsNC4K9v/iBY3KklPQJf+oduF4Aj85yEwtN++GouLOTx9+vyRiiDXx6UDr0QKIH5QGIM9MnjCyroo7VGmZA2bLPxMjaoJ5JFummQR2CiJGAfdeiiWqBYzqsKRRrcU2tSQWHb57dbJ+uVz/uyzC0IOH/mck19Fc5Q9tPywRHz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DOz78T7C7U15Y4t+BHaIgU1b4exagMO2bFf9maHovs=;
 b=uR01kKMf6/hzaubObnO3yCKwhRCJjC4lI70fPTb2UNb4dZufpB960TSMguPM/K5CWx2G8O7vXiJBFOUEEQFGEaFpYaGM9kMDTDLD8CW0cuWcewBZM9uWwc+Tzd/6oFOGqy9l473xUmH4gZHKEjxPDMJxLL3AjA3B5TIQpIyolukBI05rKlwbWaQSGpPABYwJKPq2SZ+3YoAv6ELA0i0V90guB4xWHW3fpmHePT8ErnQHNesiWPoeYCTQ83dz7gZtuuHfJR9HYAo1Hny2fa9U8JQOL0nOjsbUmTxcwB2JkQEvIXIvgdNICrbEeRhDJwpmbTo5e0JlGlVJ+e/rpvHeMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM6PR10MB3384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e2::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:14:33 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b925:3d3d:8f5f:c4d9]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b925:3d3d:8f5f:c4d9%9]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:14:33 +0000
Date:   Mon, 4 Jul 2022 15:14:31 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 0/1] add device driver for Nuvoton SIO gpio function
Message-ID: <20220704151431.31d2cbbb@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220704130602.12307-1-henning.schild@siemens.com>
References: <20220704130602.12307-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ecbeabf1-94d9-4409-a3bb-08da5dbf2339
X-MS-TrafficTypeDiagnostic: AM6PR10MB3384:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6RiJhvxIYscWHMdKNRMndwkqRE2Oy/vO7GZLy1t3HSvXgzLHywEytgrct95ZReg9741tJiNg3VBgMKgXg8mdgfNXxecmQ2NRBbY7FGjaAoEhaaEZhXoM3p0+XEhBSLF2RD0GEU9tqsLOEnTX2hKXZ6vC2CDktFs2h3FPF5DhjS+Bvvsi4BUR8RH/kwi9k7dqOPEzEDOTqrbl3vw4feap6hI5DvZblmPvpTkLXO58rq75jfZeAwT7XDDralyxU/1eN0cM9Pt+8HzXwYAxwZZXeIQ2A/sFGJ1EbM+UG/LJFG4mZOwp1gpFp8V1XZAgpNT1nA6Xofgxj4odzHpNaiyOdpa2k3OPneDBvHOHrmBFMRYX+dAPwWmcjnlcW5sjTWG3b/j+nZyzJ3hB+LO6VRtvt/mlY4aUWX0d7aulmvuyB/ksv9SHhecGpRztClBQbJ8D8R1kQ65wrv9J04ug4xzkuoLvoVoNAqRSuevZ1zYz94enOiM19hr+yFt9tpVKCNlM0kYzfcqNFSDmjm27LDzCzjPGWBSGe2ib0mxEf1o+9hrEwuFO4i8anOVLdi9G20uLzflKaG9yOMCP49o1IrtpqSoKbk0W09V82KlDdRB01MXNvmJGPhiu7Ce5C/LSc9cWh902wRYL+C/Bk4zNv4pNfdKXmn4EwW9ru9uKzq3CLsSI+6QLwTdaYgCTYbUkFiQrVhSzcHCeys2QH9lMoyxAH7O5Tc6jpc8KB4WPBgiGYid2pOXU5loIwQsAWxgEsuslBtmFhCIVEiPlUmYr5PwGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(2906002)(9686003)(6512007)(26005)(6506007)(82960400001)(41300700001)(1076003)(186003)(38100700002)(8936002)(86362001)(83380400001)(110136005)(5660300002)(44832011)(316002)(4326008)(66476007)(478600001)(66556008)(66946007)(6486002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EFFY/hifngb8riQsweO2gvrpqn9dROkawa1E+hzxWhIniEhOlRvLuTIgTxDe?=
 =?us-ascii?Q?SizsDyva8MFv6BtTzmaQSDw/+BOTsutr7zOt9pg+EG1UtdogNjD40H0Ox8OR?=
 =?us-ascii?Q?M02c8Uyc3MKl3aaM7fNEGCaWAajy/aG1g8S4W2Qm7LbfcxrK7+JIVAHj3Xid?=
 =?us-ascii?Q?xV9j742X9SnmpM/hJyDeK30WlartPulUKAbWh0cRgqZXlNspsAl49UKFQMsa?=
 =?us-ascii?Q?EFz7Q022IAe2GgE26cEhVSutkbYAkTW4pvn6CVGGaAE328cX59TvGBpZv/Lm?=
 =?us-ascii?Q?uzjTyv//e3kQmk+SHSsS7HS9WXTd1EXRluFcVlysj9/TjhX6cAiiSULGPjha?=
 =?us-ascii?Q?dQ3uBIrX01kssTLKM3xQdBEfcZrc7V4MeWMInBYAjj+9k0XzINGyzeUQTSn/?=
 =?us-ascii?Q?Zkoz+LK4vzdwNlxmUvFPq42SfpM3Py3vLYE+j4HEW5TjJcOsvYLUw10I6TOw?=
 =?us-ascii?Q?un8PPDvsFHNsHWWCm4DgpjGmjmBUYdXp5ZePSB4y9U9Bd07lJuFHegPU1iwF?=
 =?us-ascii?Q?k7HVUh6HpcvPEVsl+ZF00foXSd+cIdYvRxlrUC+Xp2V6PvWUzCuLRFmizxHE?=
 =?us-ascii?Q?UvxwEz71Wj4FXhEI10yPQs2xon81kiWm5uu8swH5kaG0LDhLQZzN4/afvhoP?=
 =?us-ascii?Q?vn9/LfDI9P4RKGRBKBrk91eJkE6xbprpyMq6p5wpMo+lKd3wxFFBVTC6N4TY?=
 =?us-ascii?Q?eTP5qWgEnbgD9y7Im6yDbXebUQ8aAL8pAdYzt8vDB2wC/lb24JvaOUkMgmRs?=
 =?us-ascii?Q?po+BbGUxAAVQxH5Mlpur9VhTAsvGar/OOhotFLxeGooi70xCtt+ruXZmEb/e?=
 =?us-ascii?Q?/ZWFwCkNC077Rhbs3Ma06dtIywmmfmns+qbd//J/v5gopEDpjrjbZS1eIp9P?=
 =?us-ascii?Q?anEp8NMX5TDb4qTqVFI2ilDpHOS0QcslET9ZxC/Ah8cdWhOTUMpueUK6w0iw?=
 =?us-ascii?Q?eiN9gJZuQYPHWQg3TwFKIlkrz4dbckKlq2n4cleRw6dSOAxkTIOnDkjAEyRu?=
 =?us-ascii?Q?cjp45XrupbeXGi3MOnPsaYMNmObUnoBWHnr1un4o984YiZoNDwFIL4CF/zXd?=
 =?us-ascii?Q?CQYmTO6msGCf8y4w7kAGI0PsmuxKMp5XRORAcaXApuPNwxisxcG3dt0SA/Be?=
 =?us-ascii?Q?Bzo3dVvg28u5ZoHZqhNgcloVDes7XoQkB3LN8jFrBCI6y/TKgUBc3jLZHMuh?=
 =?us-ascii?Q?zI1ogDBJcHW8oC6Y2NmtSsdnCx4VlemB71zdyqn7jvnvVL8bfiwAzXCeMuTb?=
 =?us-ascii?Q?Fjkz2dLMpXtRQWid5ONRRUZtEMQvGXOBpnoT0gjfZmPt0VWr2fh943sFSWDB?=
 =?us-ascii?Q?Ad6ogB4CXTYJGWqjESoZcYlbYDKfeW/5zEqi5jibZqmoYTLzo9WsHG/DKLpB?=
 =?us-ascii?Q?X4Hs9kcJi1Ze2Ftue/Q50GEp85AKrv6IpRO9dTbibxqUekxtpSIfr3irz2BZ?=
 =?us-ascii?Q?HDpFLXd02OhzaLyQCmlV4xNb7oNbMEr5v0pSVM2va4ofUGipr0Yrqv/2gq0F?=
 =?us-ascii?Q?f6qTebiUxF+H/WKA3Bf4arbG4VtTJQuB+jE7wZa595/qxWqrislvXZILtpfh?=
 =?us-ascii?Q?V0uuRC8ozB+sdgLQci2XNCcBVLbQiM35MIKilfuHuXxl+0d0sQFw4Jk8vvHz?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbeabf1-94d9-4409-a3bb-08da5dbf2339
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:14:33.8712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNJsp+EujTxM01xJ45w+5KRTzfGP8t06GZ7aXh6GNEfr+hJJ6/nvZ3Dr8Tsspmk7+WQUkNcHr9RR74Iwhi/61Sr20xkAAryNf+DdJSQsjas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3384
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, 4 Jul 2022 15:06:01 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> changes since v1:
>  - implement get_direction function
>  - style changes requested in review

I guess in terms of style there is more that could be done. Thanks Andy
for the suggestions so far. But i would also like to hear from the
subsystem maintainers what they think in general. Polishing this one to
look much different than similar drivers might in the end do more harm
than use.

regards,
Henning

> 
> This adds gpio support for several Super IO chips from Nuvoton. The
> driver was originally developed by Nuvoton and i am just contributing
> it on behalf, because other patches i will send later will require
> access to the gpios. The driver is valid on its own.
> 
> The driver supports several chips, of which i only managed to test one
> but did not want to drop the others.
> 
> I hope the original authors will help with the testing and addressing
> review feedback. The changes i did so far mainly are inspired by
> similar drivers and some just concern coding style. If more has to be
> done and the original authors do not jump in, we might start off with
> just that one chip i can test and add the others later on.
> 
> Henning Schild (1):
>   gpio: nct6116d: add new driver for several Nuvoton super io chips
> 
>  drivers/gpio/Kconfig         |   9 +
>  drivers/gpio/Makefile        |   1 +
>  drivers/gpio/gpio-nct6116d.c | 412
> +++++++++++++++++++++++++++++++++++ 3 files changed, 422 insertions(+)
>  create mode 100644 drivers/gpio/gpio-nct6116d.c
> 

