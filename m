Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E546F5AE511
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiIFKLj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Sep 2022 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiIFKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:11:35 -0400
Received: from de-smtp-delivery-113.mimecast.com (de-smtp-delivery-113.mimecast.com [194.104.111.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046C326C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:11:33 -0700 (PDT)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2111.outbound.protection.outlook.com [104.47.22.111]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-54-8ipGG-8tNcKaQQcKb3yxGw-1; Tue, 06 Sep 2022 12:11:28 +0200
X-MC-Unique: 8ipGG-8tNcKaQQcKb3yxGw-1
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GVAP278MB0906.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:55::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Tue, 6 Sep 2022 10:11:27 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::6c6d:333:ab23:3f5b%2]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 10:11:27 +0000
Date:   Tue, 6 Sep 2022 12:11:26 +0200
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: switch to using gpiod API
Message-ID: <20220906101126.GA8061@francesco-nb.int.toradex.com>
References: <YxbUO7WM0TbUBatv@google.com>
In-Reply-To: <YxbUO7WM0TbUBatv@google.com>
X-ClientProxiedBy: ZR0P278CA0005.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::15) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba1a3756-333f-458a-b19d-08da8ff028f0
X-MS-TrafficTypeDiagnostic: GVAP278MB0906:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0
X-Microsoft-Antispam-Message-Info: iUxjzJBt5i2dUyCdoaWoIoUJwnoENqKMNzjoKd0XXdE/XWPofCqd0Drg4Mf0k2M6iWZuHBVwZZtlakaJI+lW2hW7w1k5yueE+yJVltr+9pYzaDtI/CvgLQ7D+QjxtOT6JGYOm/Dz725AkH4IlKwxUWkjjvxn4KzzEVN1OWDtIuRxQGAFNk1IYanWweKCmGZ0lmSB2UBJ/jOA2OeNoHDSverbpQWdgeIUecxzhGqGwinarhYG8RUXHnuy8eVDfB5G/sG1APxupJWvVjMrJ5DKQ1aYNeFgnB2rSnR/cPBLe1gJ/Id1NkAVdvhY5ukqavtHjIFjSfxC+Nq1vp0FRzrOaoumJGJvgxRnFb8Df2bycvnpIEFfVLuVti0eiUXGPwScDCP1xqK1Ax/uIcVaMlJixi69PvtSB0BjyqibKY9u0ughJLNvojRzAihRKgL+Jr9w2RM4UOdPhOOwJU9A3J1sC5Cv5xRYdWFMy+5POFsZDzF3ApF0SXAyofvYwFY/3Tqo7d6vUt34YB2n2pa3aBWXFdOtiq1kFAx73Z6vYXL5qp3wPbj2jdblHUlUZPDjiIcU6YPE4picTGESJMLNH7Mcgl77EVgvYYEP9/SlJe54WMPwYsFiYC1AmlZD0f0roX5ss3bf0Pvh7KuUcdbDv0fzs6xbwITK5FUAspnzMauKsxz204GMSbrMyVVwVctc255BRjJo2Z2q/Hk8K9gtvokwhNZddFfcY43k23z0lQ65tP2jAnUlcPqSCQUjzv1yBSmLChobHE1PUCmy23Snv1IHXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39840400004)(376002)(346002)(396003)(366004)(38100700002)(6512007)(6486002)(1076003)(41300700001)(186003)(86362001)(478600001)(6506007)(38350700002)(83380400001)(52116002)(26005)(4326008)(66946007)(66556008)(8676002)(66476007)(2906002)(54906003)(6916009)(316002)(33656002)(8936002)(5660300002)(44832011)(4744005);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RV/YK+EmYG61kyIk+XkQ+en/iHw7uIPxEI+kAt58IK0bxXHWizeQ3xrx9Tp1?=
 =?us-ascii?Q?1p4a5i3/IFwvru23Y8TDo7v+FLEkW8rVqWZs5qzsFSERiguzUlY7nXA3BeRr?=
 =?us-ascii?Q?yhErlnsfy1uYPzD0m5XNFmFh4oWQRdWmtyNJkmpMekT/SRiohZ6xsW8FxvGF?=
 =?us-ascii?Q?C7VP5Vk/d23eu5hsgQ07ylIW9YZ3oClhuKG78TX8Kjnc3MKuGRfrsvgtHIXO?=
 =?us-ascii?Q?IkigOJBLGCsjlDxV9OGdG7SXRfuJ8Gie76iiykJKRvo5WBUhYJ7gI2Bt7qI1?=
 =?us-ascii?Q?D9pbcmYXXb6mPtPNARvaeYcnPiTw2txDlBkzWXBGU/Ja+NHdVqZ9lUXVrEoH?=
 =?us-ascii?Q?ZaZKu7MKH3HChXKpn9tRZDSDvPYeQo6V+MY19d1/TQSA/NvutC4/ClKcXHqU?=
 =?us-ascii?Q?EIHC+IlqcN9maB11Ur3tF+SaN8mFVnFnOMoOjfhrMOGa/7ZbXkEoovhRzD7T?=
 =?us-ascii?Q?FQynNlWjBriorVklVyHVH+PU+dtjEqXKa9aMZC21K/CHq8hiwaK0bSukL3GR?=
 =?us-ascii?Q?pUElAz+t7dE3+sJIlUIg6j2spfCxt25zBNjyWo/MeSZ4xzi8j5hLyzX5AFt7?=
 =?us-ascii?Q?nIphuEfdeORsdon/ZU/X9EVuluogPiFKxe8ZaRr4ftK8pqSLdzpChNqTnhuv?=
 =?us-ascii?Q?E57VXESgKutUm4alhGt2ZbgwCPhyfTVxCG5MQBdyQxaybrI5ObX5mQDlvRIN?=
 =?us-ascii?Q?Tnfsch9vykaOd6foU3yC9xE+k65YIQlmJBCea2aoNCp+omnqLd/68e9NcxUi?=
 =?us-ascii?Q?zcUtIjwGnuXJX8MxgbE4xY0SyCUQE8rwy36BtCwW47dDHh6bWzqC8GB1Kbip?=
 =?us-ascii?Q?3aRq6Own4lJptoi0zwf/Z13jFymAQIC9Unp/CdMa/ZewLaBvVy5vMKwXENOB?=
 =?us-ascii?Q?HOPFACbvVjsCBOPThmX+U3dPMPrPDsLMRrZTj8HJaU5FfwdmjJd6JMVRf16W?=
 =?us-ascii?Q?qIC0WeSWNwiKMneRjjtv97PNq6VT4XvDdkgatpmOtoBeqqS9bJW6yHGOF1qY?=
 =?us-ascii?Q?u1pE4EbGQ97EcA7B+X12XXAlKE32BY3TkYOdb60Y/d98402qb/8XHI0DmiTf?=
 =?us-ascii?Q?JzdKMz/eHhWnC2um/Ap99J2Mz6zSCDMnzi5kmVeJTUF+YP/z1Vihr74Z5e6+?=
 =?us-ascii?Q?ziv1qVDb9nFPstmi80BuQh1l/9sRZoSd5V63pkKJpINOBwBIQTK9Lx0TU5Oo?=
 =?us-ascii?Q?v3iXEczUHIRWdLWm5CeaHwHM67ulV2ALCAYP9Ar7tLz1Mjrl12bs2smXB56y?=
 =?us-ascii?Q?iPOParQiKX1/srfgF7Qfw8UXY4EPoTILKrm3X1A/3X5S47ZenMDsjxM4ZFOG?=
 =?us-ascii?Q?+oYVE9K/SlhwvLbslL9LEfaMxEst4YskKHVNzf1971Xu5vZLxv4YzIk4IVzD?=
 =?us-ascii?Q?r4cuehzK5nwK8WUOWp38UZo9Nfh0nfDNz86TqrvSIkMVPXD+X0vInct2qqeD?=
 =?us-ascii?Q?GTPmuYvJrOWKbsPr24Ui8bjVXwSsupdf9jobWLcTZO5eb1VFGHu4/gqAnGsX?=
 =?us-ascii?Q?4z+Yp4yMzS1MRppInno3rM/97rkY/Cpc6wL28/S86/BgBsbLyfkCLyEMf2ZO?=
 =?us-ascii?Q?CoQTD6lmtM1FnZX4kUvEbFrbSKZA+vlRlUj2f6+OoKcf86ZBb65RQBchQc4k?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1a3756-333f-458a-b19d-08da8ff028f0
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 10:11:26.9537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WOumnhx2BH6bA0fxYcb3IxkDMny6FgdHeNkIpt0heRWx0MBnEbNtX3OS0jjMXPwLae2aO9IKnQ0O/2Nx6z+6aBvO33k6uWdr88f4j2aVNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0906
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:01:47PM -0700, Dmitry Torokhov wrote:
> This patch switches the driver away from legacy gpio/of_gpio API to
> gpiod API, and removes use of of_get_named_gpio_flags() which I want to
> make private to gpiolib.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/stmpe.c | 36 +++++++++++++-----------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
> index 987e251d90ae..0c4f74197d3e 100644
> --- a/drivers/mfd/stmpe.c
> +++ b/drivers/mfd/stmpe.c
> @@ -8,14 +8,13 @@
>   */
>  

<snip>

> -	pdata->irq_gpio = of_get_named_gpio_flags(np, "irq-gpio", 0,
<snip>
> +	irq_gpio = devm_gpiod_get_optional(ci->dev, "irq", GPIOD_ASIS);
isn't this changing from irq-gpio to irq-gpios property name?

in the DTS files we do have something like that:

 irq-gpio = <&gpio TEGRA_GPIO(V, 0) IRQ_TYPE_LEVEL_LOW>;


Francesco

