Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACB584C63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiG2HH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiG2HHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:07:24 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2042.outbound.protection.outlook.com [40.107.104.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F2B9FD6;
        Fri, 29 Jul 2022 00:07:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7EyhdbI2BbQtOReQpFZ4x2yBNXaEV9NiDW87rruvVN73F7KVqwFJFCIC2s8mqsPSyuZFz+ZxFwfGAz1I3Pd/TLbMo3RjT7QPfz42thbooKw9OcizPRTCS9XeZPfgf7MogZaxLziK3+k1zocTSX0zjgtk7tnoBUJf6dIuEVXtjqS94nTUkxLdFtX60Qy0inDzBwvRXgDjUosoX+vj+yH8h0GXP00EFIRvuKey9uTYU2BT49SA/hfyUpYIg8LHrj/CLrfBQI++epvsiBuf6ZGrC7jlj2iIV+DpvIC/nt51VUipZGf5bjd5UqMSib0b52NHy8/DyYQCB9Yfb1lp3098Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj/V7poE6T6iYcLbbvm7pv/Lp2WkqRWpvqd5LFfUsJo=;
 b=He3xVhn1+KX06Fs21QLm9AB748Vigs1pDVyMIpFKJlFD6Rqacp5+moMuePtBXUwBW7DsiF/UOexscbhJbTpwkMMWS3Llx+LhXnUZkflZuGDi74/30h5QCRoeTcfcvIR0vf5pqC4owYZgweOcE1/1Eh6LRSFSbxyZY/o9ArW5/ed3iuDjdkpT8ou+j21Yt3v2lQEnKtCw/qrqo6qNquYSaXdfKtUd5rsqMHah/3wKsntPfRt1qnZ9T7WecNf38HsqQPzQZsjKDIgjnfAbzMVB7LOmKSzfQcll9fCA6YhoEQfrEXvmAmUlrRyYOxlLqCpjY63JnJlPWlW8xIikpBrxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj/V7poE6T6iYcLbbvm7pv/Lp2WkqRWpvqd5LFfUsJo=;
 b=Sup/TfayqlkUy8aYQ+v4re6Ll8/GepnjzUGcNfjh6wmK3e3X+UJjqFR3KQSx5ffZ0yS/p7vCRmKmSrSMA1wWDf0uI8XhwVh/lyXaO9R8KwFF5mXrhqExJawUQv99rDGsw79TmUNXUz8j4qNmu5AMnY4s+mtiTvlwA3Z2ApF258wbIrMkneh4i7pbmzXDiWUtIDkPq4NqSgDm3dYQqChgJ6zQI2cmN3WI2Egm0i7OSJDextkmvk7cHL2xc5qa3hk4J/1eokHCQmrq8KEaVTZezW5cpjVxqJH0LjR70+eX4/CGkSZZXLSuk8xZ7LRiT0GgEC0IMjcdxDA3USrxa/wgaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by PAXPR10MB4656.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:15b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 07:07:18 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 07:07:18 +0000
Date:   Fri, 29 Jul 2022 09:07:08 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Cc:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/4] add support for another simatic board
Message-ID: <20220729090708.43d2658a@md1za8fc.ad001.siemens.net>
In-Reply-To: <20220728155652.29516-1-henning.schild@siemens.com>
References: <20220728155652.29516-1-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0373.namprd03.prod.outlook.com
 (2603:10b6:610:119::7) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f163528-2606-4d1b-6f81-08da7130f958
X-MS-TrafficTypeDiagnostic: PAXPR10MB4656:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rvSk6L80uLUuhveN4CLTztAvlgKnZOQv+EEfeul7ApE254jLb1w0JXntJUQAozKznVvKvQQjX1FU9daTYP5I4+QGkiV/Ikx1ZnNcEKE0BCDjd85lfl9wjbkKP78XPAZ5/HuuAhglbYh8XIuNRWmxmPo4OhRHQFAZg32ZCZDAclp0YMRF9clqxgfXlirdydKgf83e2vFBV/wKYm3KlpFl84MAAUguCe5JP2sc8SXWCChQSs/4fwzglcCieVmFiOvsoOU2GHpuidTg7rvWHWjEX85dn6rlcwctRRsPf7ujRXc7j853z7gLj8kayJ035+TYAWJM7l17yZT1kzYpjO1PDjeb4Oy2ZSTCHD259h/wTHWDBKmL5fVoYcjekxtCSehCvOX7FIPvXc5zYS9oqVTXpJcB8qB6BdCXh2K1WRNbTgjIUuMWHkmrGnk1cXa0uoMXi9Dub5DFrDOWTO0yloDc+QVprIqw5V8M78FcvYJyV9Bow7b9NFknfjacn4cdQWOfUsbbwu2su7RJYSYPu+Lr+weMnKmYiY5UYN5iM0XvIf/Q3PKIro9uceu7bzcHvTAI6qPXqbUOEMpRBleSJKMQc+MhFknS1B5xSUzmmMVdev+m+JnVVEXDr++A96lVspo7LAkpFThIIneAcGzaOAYK0kqqawWNR6rwYcjIj3YHlHRJ8g6JvqBwmQfjV127CA1ZwV31qeSijvCDiw81oeGT2wwqJUBuOHPquhwwcIoZlw1KwyiSIgYsHoPk9RBw+06
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(366004)(186003)(110136005)(54906003)(44832011)(82960400001)(5660300002)(1076003)(83380400001)(9686003)(6512007)(6506007)(316002)(2906002)(38100700002)(6666004)(41300700001)(6486002)(86362001)(478600001)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iapEYOSIaRWQytjVhHKOkfGwbVr8QRXTmcaD4cVkPoUMHW0bSqQZfCh5BgdK?=
 =?us-ascii?Q?TNLezY1MyEEjVW12TCQsBKqWbGU7E8vi249tOue1qdyYVDnp1NYLh/UXDsCs?=
 =?us-ascii?Q?2TcJb03XonARzqHOvOYps0WTVeu/d5PWmTNO80ISIC/rTez3zESwC+7DwwXK?=
 =?us-ascii?Q?wdW+UDIkqoP2yhfqCdvtT1KMki/mudFwi+LzP7LhXMmjQhDExLCy87AYFJ08?=
 =?us-ascii?Q?UBx3xKJbBSuG4/uDzy/a9jdM6vKYEdKh1PdIMLVPA4KOyeflW8GGmwAcMuzQ?=
 =?us-ascii?Q?n8/ckrZQldHQpiVLQ07ItUrn5lcaJV+ZPwB7WtfyPbsgsH1+DDMwgEcncjUJ?=
 =?us-ascii?Q?uwzsVQRjSOXbCavyE6DHBGMvanrpj8SrZ5w8ZSPrEqkd6gGYreAPvHEX0QT5?=
 =?us-ascii?Q?MSt2SzDI5sTMbt06aWitogPcRKrOLrNcio9KsgnWhnoLo5HwxpDN0GisDe4x?=
 =?us-ascii?Q?2+3PbNstY7mt+BXXqzv/x9Xp6sWDFZ+9MqDP8Jw01h/Bsv8+kEX0kNcZ7/iH?=
 =?us-ascii?Q?FhhgMBSzEtoqQK5ECZM+hVAp54y/W0cvoKLO6aXWtIUs9cDkNh8JTvYp7TTE?=
 =?us-ascii?Q?szvxVTK6GNVfOIr4LyeP6k3YuuYwtYpqfSZHxNFWKgzpjIKGjo4HoHn5qv0E?=
 =?us-ascii?Q?MPu6QtjFb9tVfOSwco2S3rs0GUghORiJsbdKFlkQx3pgpyafAkBJlApj5PcT?=
 =?us-ascii?Q?GrM57WfQtsntQaZ6RKQAeq3+9aZPAlMqcER75POkvk0t1AmsReiUELackWK4?=
 =?us-ascii?Q?9R641qePoWOG1T1ZLrShRrIyhLNjk09sJIRxOmTLgfQqjlaDfoGFUXuSo2P2?=
 =?us-ascii?Q?TZTYmmxPI5Jy0GrInQm1iKe8yFU+Ru44gBT+7/1nndavjFiENd0itCJ1htw3?=
 =?us-ascii?Q?SuaqQiKQMvoANDDH9SMVhuUYlpMA60+3Gzx90QKaBDwoTT2ut8iAS7F/cQTu?=
 =?us-ascii?Q?Eqx5vhIxiGD/YDUyRGjltJS42OYNDNBATVZGGz02uh8aOx5lL3hqYLsfsbp5?=
 =?us-ascii?Q?0ViQgREmQ7Kon9StKgG41fZrOk9dCz6a6AZ52tVQVwfnf4zc4uE6SAlajUaC?=
 =?us-ascii?Q?kQf45zo34a/G2Peh/oHsdfYX/zqrW8C7Bt65KxrMuC8Wa04UBqy5p6RhDaxr?=
 =?us-ascii?Q?o71jd9t0PZqzVRlj/KdmaruU7P7RM1cV2iGtDMN/h659UL9uSKerS3LSvQpm?=
 =?us-ascii?Q?94YEZIj/q9Und24xxzj1gwXDFnVjmcF2DdQVYVsqkfoSZvGFYZLjO+uP0gn2?=
 =?us-ascii?Q?pfkEcf+400TunD1hor2VVA1SVggkrNT9NZj5Cn9qZN3DpYp45h+Ja3Mx/nXy?=
 =?us-ascii?Q?Q7DE+sS0f2S+GWnKqlhsy5HwVcAFvFiYvf4qIOBN/con9Kj6l8Srtag52NaD?=
 =?us-ascii?Q?0YAX/D7Dff/+18HQ2/T2hITBDbeNp6HOBZvR9k2AHx/uOicq/0A0EuB2dheA?=
 =?us-ascii?Q?fCHCIvDtVegI1yE0c+GpXi9Qi8I6NFc5xH2oR9MCdaXvZNENUAH9eyXqfWJI?=
 =?us-ascii?Q?LGx3blCkTkEbFkIdNVXfTK+hF1yttBW2A34lvPT7tzmx0XAyHNM6JMTzWfLW?=
 =?us-ascii?Q?s7F7fH3xqY1pw90m6Yp9zRqOI++uHhuqvTv52c2jnnnROSKsQMnyAflv+d2r?=
 =?us-ascii?Q?voYEga7PIi119Tz7PLEI23nvUxWaAgfgtxzx7smbdf+BDwd8SpjJ7r9jyTvY?=
 =?us-ascii?Q?aZtjiA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f163528-2606-4d1b-6f81-08da7130f958
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 07:07:18.4986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 861yADOPEglKzc/lHnf3fkMeIM9BpRlfa0KZTlgmZR0ogbbkBxXqICR4t946YfC1haJxAJnc4xpGNlsazMYizOC4pjtu1RZhnGUkoEa0/ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4656
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to send this series to a wider audience, somehow i messed that
up and might have to send again. Maybe the v5, and if there is no
changes i might send again as v4.

Henning

Am Thu, 28 Jul 2022 17:56:48 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

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
> 
> Henning Schild (4):
>   gpio-f7188x: Add GPIO support for Nuvoton NCT6116
>   gpio-f7188x: use unique labels for banks/chips
>   leds: simatic-ipc-leds-gpio: add new model 227G
>   platform/x86: simatic-ipc: enable watchdog for 227G
> 
>  drivers/gpio/gpio-f7188x.c                    | 192
> +++++++++++------- drivers/leds/simple/simatic-ipc-leds-gpio.c   |
> 42 +++- drivers/platform/x86/simatic-ipc.c            |   7 +-
>  .../platform_data/x86/simatic-ipc-base.h      |   1 +
>  include/linux/platform_data/x86/simatic-ipc.h |   1 +
>  5 files changed, 158 insertions(+), 85 deletions(-)
> 

