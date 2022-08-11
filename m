Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103EC590672
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiHKSe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiHKSez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:34:55 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20082.outbound.protection.outlook.com [40.107.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259F98586;
        Thu, 11 Aug 2022 11:34:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFBFw5eQA7UQqVaxJhoDQTfQ61UWvtJ/9JuenZR4WrKYTe8l/3Zn1lj2SVo+LG1rriiZIhYbpR7V1abtwMHJtKWJGs0pXvFs3aE2OXpFMciW2J5YY+hFKcALxRAuAOzp+Wkjs8j5BcAxgeH3ciowBUY5ILbhWudFOR5NGmJyDsQutkI5ryq7HQOf5aQmAp3RWg3jQLbHQtAdK6vpK4yV5dhPpKNCEw4+OwfpjxK2irZ2I4up/2ARAI2YpdDNc5y6Etc/PTEy/sEfpTve8iOHqa0qVCZ5vm1+58I/XJvea7+qj4vr5ozJk+FNlupap/pOG2M+GfWxiNFzLD2pMR7Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD/JjZh5rWSU0g3eMHpPmpmuvnqV6iG1/JRVkiZGcvc=;
 b=HV/U2vkbwY/YVNkVVoIqVeRipbVo+ausILjeSJzA0YdyH4lBs8fv3DRtUDGzvwXTs/7UH5/AjX6WAxkOLzDW5YrT5mLFFFnx0yKBLsmfKPTmriVLPvr8/0fn/QqPz3c4PGEsRCQ0AU8hkKQLxFyDwLpx1nTMEOELchdNzJ6L+hZZarY0SgTKRUN9w2aZBXtmqFDE94qE5yuO7qp3sNeKZIWxOZ0gJ+EcPznS60FvZwuqqwgdZRWe+TzL9DoHzIieF8jDAktk4YdslvsgPoCXLlNeSV6SoNeUdjqkuQAvDiepiacdbmqQVJYWPEB6k2wZ6rDWudtvREbDYNt1OYdArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD/JjZh5rWSU0g3eMHpPmpmuvnqV6iG1/JRVkiZGcvc=;
 b=kJ/Wa5m6NksZeM4NcywMKeOPm4gLEGD1Rv+ODvkIS02cqlUBUT2J1mmbEOr4wutRzVjCMEkTYFZ8IWe2xmunEhniE3Ff+5hX05HLCJFV6xURzx0wia3O9d+SFjOu3MkpEVXyq16gmxD5nefnAwbPMfTpA3QPaNWALVTKivjpccX/WzmLJ+5JxcOiyE52dt0gcWApXmGFkqZSjo15364xzDq8wDunhTJOkDC4HwmD2Xitkjb9sr3ZzxX0ceVc3v2voHQvjMdM1Tn5lnRNYhe1dHxFHxyMuKXem4ju9Y6JOiO0pIE+2RnzDR/PXH81UUIeGvqC7P3uaU2VhkjDVv0VpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB5260.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:33a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Thu, 11 Aug
 2022 18:34:51 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 18:34:51 +0000
Date:   Thu, 11 Aug 2022 20:34:47 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>
Subject: Re: [PATCH v3 0/4] add support for another simatic board
Message-ID: <20220811203447.5c21e5ea@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220811153908.31283-1-henning.schild@siemens.com>
References: <20220811153908.31283-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31728d12-5bc1-47b0-692b-08da7bc82d49
X-MS-TrafficTypeDiagnostic: DB9PR10MB5260:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cTPgYc11WBAyvJBcPYFIyUdHl/pF5/YUDvtj3Xp8nAVT/6JTlTaPuYGmSRuxgPkCbHcEo1dVC8GTcLo7TuD0/pkmHkUUKRc+FdSrg/bqmBlAgXgmz5+ls+vpfVzzUglMJH/BwNBtmj+nS6gfFN26h60i4w63J+6fyTNYTv/+/1UfE1NTu4F0K2K/HU6TPx32tmPgXkyYCnSkoT1ORv9kaSLclYnQan/4Pixbn9EFjr9MIIu3nOdo1JvGMWhVa9yw8yH4wG7d4/vwL/2y2GUInp8E0QUDDpqxJsdgQ7/YsoMH5clAKfN833itoavNRablSrixG9e+ckxeS8KrlVcT3VyWIh1x6llNlzbq5qLx4b0l+0QcSnDl30ucMX3pM7JZmWu2aDG+P+8ces+9ArhA5OOdFBalfHHKOyae4f5jTeEFcAYyT5fADO9fJTlk9el4LZdmpr3pM1u0hdpJuNxuma3CNxWNxVEltiPVR2nCGcFRzR4LhxQzWU+39T7sIXgLpgI4ujZJxdNm5V+LQeJjlcBVnvo3ljxlRMVFCJrpOl9OMtxv7UOHzOe1symi1LJoNy7BJYFm4dNNkXMNDChLgOPbPVNDIfqUz4zo01U+2hPef2Nca4OHHNSsCzseOrUfYTVGpmEOzQde2QKccJVe16QTp4ugrdvM5gjs6z/XCe/IpeaPbyD4L95xR6GPPSaxM0NwqUkMy2AzJxfsMZprYEW5o5tINGhVy6i/Skkaq5dZmlFxO0LlyAtslCwj1MfC3ROZ2fHuELxrSzhuNJsZ2dMK3qJpLRfO0OHaGPsVbRQUcBW/IjAMQquUlIP5LxOI8AkNs7B7gz0SkVvqAA7Awg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(38100700002)(6506007)(6512007)(6666004)(41300700001)(921005)(6486002)(9686003)(86362001)(83380400001)(478600001)(1076003)(82960400001)(8936002)(66946007)(7416002)(4326008)(2906002)(8676002)(66476007)(44832011)(5660300002)(316002)(66556008)(186003)(54906003)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQI17egK+QN3vYIDe//rCS8J4QYoFwPNyCIUI/zOA4fwnveX8IMd5BLXsdq/?=
 =?us-ascii?Q?bN3oBQc+ma8NugQfHVhAbMgoqoagaaalEVAdQc7GmMU9lhIvCu6Y61FM0ugt?=
 =?us-ascii?Q?MjLs+rDynIkbUSINXXoieRULwDpl0zQ6RWDm0zue1IezDK9cdqhoDWOsJX6y?=
 =?us-ascii?Q?9gxMYuSx71iSVqMdw/OnvYxU/RrUp1exCnoOnIC7CKo4u4G7IhZ8ipbEtanC?=
 =?us-ascii?Q?7pnh/2v+WqzexwClQP+tY7jFLOaRvhVeNW06yv4e1o7I5pe2leyUgcvtcFuO?=
 =?us-ascii?Q?h0vvzhaTmKWGsKGH4TvvXCCc3eiF8ERrHWWtxFWXhwKHMy9GRo3KtY0ojF0+?=
 =?us-ascii?Q?h2gU4l01DUjKFmWf3R6oE8MaGeMn7gQGIsv7/1ZfvkTeUafvWZpOOXmW4QlA?=
 =?us-ascii?Q?C8bGVe9R4e+ZyoPNEklwKODJsFIokaKKbgtT3s/qy8NJ8dT9LGC1yxVuZfej?=
 =?us-ascii?Q?A8Y2NcPWXbIlmfOC7Psfj1cgZYgMuvYNyH9NplWOj2d+eiq4plCqgAx3MdEs?=
 =?us-ascii?Q?WKfGq3gHtbEnabWgGVj3JKPMM6wyqgywdKc8G27zDqXD248/iaisaS8B9hAL?=
 =?us-ascii?Q?SFj+33nZteNZRkO+GJGbPl1RUM8CLm56lYkeirblNRu2X7HxjvFpWaBgN+tT?=
 =?us-ascii?Q?MxYPGx8PMOgfrY0UnUqq/wOxUj8DbJnn+8t51p5Gg+ScTfu7HWh1XIfw/JJp?=
 =?us-ascii?Q?QXIbuXi46L0FkMg5dWkkH+kvxV8jY8Cx8WI8eAhM8z827qcC87NYYNMrURld?=
 =?us-ascii?Q?p742ZI8h21wMFAdlqOBlh7r0gsOLGuZIUhzaN3eaScBZXzvmvYMJtuy7pIzy?=
 =?us-ascii?Q?QfwrUXCXuDEsQ7otzFnJ3jsNCQ2jNR6SdRUsqluDA9bcFgi3t/9S5ZHQV06H?=
 =?us-ascii?Q?xIws7wi2Kz69tfCesVo0NDj98cYVKjbfvtIjW/dbMGztCfYY6zwUPMtRKJ4x?=
 =?us-ascii?Q?rxeuawWC3U0oA2tAq5ALu5UXLNesVXf+m9pL/OlfCyCu7KT8RifoKPi7lWfo?=
 =?us-ascii?Q?idFC4RUHREW6wEFbRykL3Ib7m4nlYiFOwmd1eTZKd0TuKdQHtOAiNumi0TC+?=
 =?us-ascii?Q?3y9kf4nohHW+vMVJsjvgdC1E8FSanbXB2pB3/nj7pEg59XRqtu7+Q+B2Xa2E?=
 =?us-ascii?Q?KD7QtHwKgjI2aNcHwmFz59V53TNhmPU9mdGhTXVFdXzdPi0LoLwvMc+ijS2G?=
 =?us-ascii?Q?+mxShN1KL1FEPRgPxysQouWyDUh3IF6I665GazAEtSK36U0GRuNR0vPH86LC?=
 =?us-ascii?Q?KVDhlrspEMmgkCEQmjYW+rhmhrSbB5BWxLSbuoZtAi3iVGJJ8+/89yE+8YSd?=
 =?us-ascii?Q?aY3aBayNs+DdvrKEIbkgtZNdDIdYWS5Iwn2J+KDpecuGZ5K6+ypExR2KKIFx?=
 =?us-ascii?Q?90BzvX0Holo4hBHYEjCc5wQaWisghI/U7+y+ZE8/bOsJ2LEjZ/3heRKKivae?=
 =?us-ascii?Q?emF/fcm7TQJR6P3B64/U0snvcM2IqJdwGMXcXuAskGwWHIhQp/UJS2Jp6ac2?=
 =?us-ascii?Q?3OOH6BlHHD/+LKTuY4TV66snbpWaFSKTZAkFWxM9AfV+iSET4HuDCRRf3KqA?=
 =?us-ascii?Q?VjSSCSGrC4sWn9aX7o6qBG+j+LitUSABxfMdjtLkcA9wGNydKMPRDJIYlHa6?=
 =?us-ascii?Q?nbD0qZUAWWv9UJ0deFTyd9MocitY0sOEFszpPGuVFmcJA3I9/nLSRsqvY5+j?=
 =?us-ascii?Q?gujDww=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31728d12-5bc1-47b0-692b-08da7bc82d49
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 18:34:51.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SL8J6smg8OGRzBuBh1hdoWLPg+Wnglj2KqspFjTqAMBQRCWw1r85OFh+MH0t/0K8wDoTIjOCD6f9/l+JoexAVex5UrVUrcpckyxi6/SLWIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5260
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, 11 Aug 2022 17:39:04 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> changes since v2: (p1 only)
>   - rename macros that change behavior
>   - use chip type not device id in the macros
>   - reorder defines a bit
> 
> changes since v1:
>   - remove unused define
>   - fix bug where (base + 2) was used as second data bit
>   - add macros for "inverted" and "single data bit"
> 
> This series first enables a SuperIO GPIO driver to support a chip from
> the vendor Nuvoton, the driver is for Fintek devices but those just
> are very similar. And in watchdog and hwmon subsystems these SuperIO
> drivers also share code and are sometimes called a family.
> 
> In another step the individual banks receive a label to tell them
> apart, a step which potentially changes an interface to legacy users
> that might rely on all banks having the same label, or an exact
> label. But since a later patch wants to use GPIO_LOOKUP unique labels
> are needed and i decided to assign them for all supported chips.
> 
> In a following patch the Simatic GPIO LED driver is extended to
> provide LEDs in case that SuperIO GPIO driver can be loaded.
> 
> Last but not least the watchdog module of that same SuperIO gets
> loaded on a best effort basis.
> 
> Note similar patches have appreared before as
>   "[PATCH v3 0/1] add device driver for Nuvoton SIO gpio function"
> The main difference here is that i added chip support to an existing
> driver instead of creating a new one. And that i actually propose all
> patches and do not just have the LED patch for Simatic as an example.
> Also note that the patches are based on
>   "[PATCH v6 00/12] platform/x86: introduce p2sb_bar() helper"

patches 1 and 2 are independent of those other patches and they add
value on their own, i would be happy if they got picked while waiting
for these other ones.

Henning

> 
> Henning Schild (4):
>   gpio-f7188x: Add GPIO support for Nuvoton NCT6116
>   gpio-f7188x: use unique labels for banks/chips
>   leds: simatic-ipc-leds-gpio: add new model 227G
>   platform/x86: simatic-ipc: enable watchdog for 227G
> 
>  drivers/gpio/gpio-f7188x.c                    | 193
> ++++++++++-------- drivers/leds/simple/simatic-ipc-leds-gpio.c   |
> 42 +++- drivers/platform/x86/simatic-ipc.c            |   7 +-
>  .../platform_data/x86/simatic-ipc-base.h      |   1 +
>  include/linux/platform_data/x86/simatic-ipc.h |   1 +
>  5 files changed, 157 insertions(+), 87 deletions(-)
> 

