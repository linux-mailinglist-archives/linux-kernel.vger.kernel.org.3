Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66533481629
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhL2TIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:08:47 -0500
Received: from mail-bn8nam11on2122.outbound.protection.outlook.com ([40.107.236.122]:26081
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229958AbhL2TIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:08:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1mIWcNx6Z0b685MhfI5L7wTOqmQvBTwYNeZqUHIk7fj/UfG1ZE3MitsrQ7kMiKt2z89KbHPKodulEo2yc/7LCo8bPImq9ryvrGwvU5N5SMiH9cn+sxjjcs/fXIckLpaIYqQMHy1kw6hyBXmG495tCdro9LdO/SK63z6SHRmnlM+3m9z65bacVNLpHDChBBn0JA6JaTakIigrkeoREmlMaZY9Xpbj4IXN2RPR1ioxj6XyPOvq0LnRmlG/bx16M8w3S8zFi8vezhKxjKFEUR3QE9EceDDxCRp9yJYhYZGjUCpQCu5lRlQtwUHb+fNRSBRBlDSSzjg9MLhSkqQxNG/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlJT+FOCSdJOl7cRZLqFeGJSSe3pbbAk1Ftt9L18TWQ=;
 b=f5RUguGykiZIhOy9+SIxXC4+2stVu4D2hzZmj4QkUYLxU2nKb4DcUmWFUiXdHlGqkePjmlktWdVR4sJr6SRq4fYWO5jRhtEpOlZgaXad2O+KK9eRb0DXAWh4SObSRQSHawUiXo/zPCtPSVuWTnbdLwsP/+er361wohcawL4tRqoMstNc3EgKse9iKaDfMcghTaP7VpcbWB3r3841tgGQT4MR1XJ8GViTlNHzIFDtB0DzljP3h8pJlapEMfQX0gAKAkSSWzSkDhU9hvTYPFmokDR/d/LHL/5boSvmxyP8LAmezyeJPMIUVW7kL7kMrP5BVuLF7+mPWG4WuF5FWY/HDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlJT+FOCSdJOl7cRZLqFeGJSSe3pbbAk1Ftt9L18TWQ=;
 b=aS9IZ/jeRKqmVSLJszy9tqwZtpoCQFwK8PGthTg+yqxm7Vd9uEg8p+2/866htQTrrBTKzvofbWoKk+SArAFfoANgsgnioJnaxsf8+SPTlYOYpIGjSUIh5CX7Qg+H/tYWbPzPF2TWiffOZvf04+vm6PdOZ3ImjlLPesiv0GPAv0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MWHPR10MB1279.namprd10.prod.outlook.com
 (2603:10b6:301:7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Wed, 29 Dec
 2021 19:08:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::2d52:2a96:7e6c:460f%4]) with mapi id 15.20.4844.014; Wed, 29 Dec 2021
 19:08:42 +0000
Date:   Wed, 29 Dec 2021 11:08:37 -0800
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        UNGLinuxDriver@microchip.com,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>
Subject: Re: [PATCH v1 pinctrl-next 0/1] add blink and activity functions to
 SGPIO
Message-ID: <20211229190837.GA1252561@euler>
References: <20211229003729.618079-1-colin.foster@in-advantage.com>
 <YcwqznBTLZgNcU7o@lunn.ch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcwqznBTLZgNcU7o@lunn.ch>
X-ClientProxiedBy: MW4PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:303:dd::34) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 085d1df8-dba0-497f-43ad-08d9cafea10d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1279:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1279FE01A2CF4FA2D339B277A4449@MWHPR10MB1279.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpDnoZfPtpJrAJ/tFxMi/JuaVl0nEwCi5e85t216jKY89KVfsyAgUwm6SSAJ6CAhT0lp2L1BuBu62OTqq2fAgw8n0Uqm8zxr0lY3coqSTXuhAzgW2gAwX9wY38CgTfA6tP4Z9obKAiN/IT6UcnchJK686tHPhPjWfjs3Adrh2TNPpu68A0hhk+jdlLXd1xuhs8fgjZibX3G5Erwgkdpwy537n0+6/RGdaqBZgm3G3pzZ+9n69mWTwUV7OJsoljLHuTGI96tNfMA2MdUPRHDFprJuhu7JfyPATz9Ah0ElacUsElc3osAoQkYjtcG5FJPsrtKh0cJJFBWBMZzm1MXS8GCU/F9euXY0sSjq+T0LJCLMW2sc5X0KXmnQc5kp6uM1be3SBQZAWS4wkrq0iVjw+08NdtYKdkQi7FBhl59wbPtBDAzABPsc5kGRhPMqCnDUZKy00f6VKUUToHkbtJNs2ozzUjIolB515EyW5zEmqxy4ZUbLUfLhCmUpD+zhQI7Gs8c5eNzGTu+pf4r+TL62RJufbKyBF62YT8rGC1TJEByHBC5VAFM13OeC4gDCxegD1P8aippd76ayN2S/7IsmarlCTgv37arSl5SelcLYVlCkEqtHj+bZURGlFVvS3cXDFA5sXttP3bE7M8hssNOrKrrlD1w6QZVIwMERqzFanaEDv/Kkh7aFzAxuNoX9ADUe8jre7I7swEN1nE7tEjsr+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(346002)(396003)(42606007)(39830400003)(366004)(136003)(1076003)(86362001)(6506007)(9686003)(6666004)(186003)(6512007)(6486002)(6916009)(54906003)(4326008)(26005)(52116002)(5660300002)(38100700002)(2906002)(33656002)(38350700002)(8676002)(83380400001)(66556008)(66476007)(66946007)(44832011)(508600001)(316002)(8936002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bwqgdOfhETUGBaaHLfGMsV2IMxsede3TBBccjEQZ82Fn6MAXJ+SAFdddmzwY?=
 =?us-ascii?Q?N/Rymnpx5KX25SjxDsl4sffCx69wvYCyGLQV6F8p7CcQmg8T95buA2Lu9C5V?=
 =?us-ascii?Q?NgkVIX/lJ3AVx+a6WxLh6h+JR2ujaPbC1Bkiepy9xaKC0guKrq+Jtul/byEc?=
 =?us-ascii?Q?Hi8RqWJZlPgW7QWFVuFrKMPUPaFhMj9A2jIuXkGmB8Y02F7iDJ8+3F0OetV8?=
 =?us-ascii?Q?TqkIY18NTXMGhm1ilpYfJQ6mWb0BTlVQ6Ke/xAoISXg7oUg9MCorCTC7TvQz?=
 =?us-ascii?Q?q86seF7ME3RXv6S2uNpZECT3t087/Bl1ANSTEAJLPCZsX0vsbZXqGRa89oc+?=
 =?us-ascii?Q?a7pdLO51UWD+IjDX2LPsOzacf6EW6+dz6QKWKPJiMoHgDkcWYN+tbVgtYasK?=
 =?us-ascii?Q?d3nMqdeAJjZ0QVwsmZEBBhtfJkV6Lk+n3exPcNOJXAdRlGBRDPiE3cix+F12?=
 =?us-ascii?Q?cQjdQJsyuGfhJ6Ntd9OcrQP4Ff7uhIUqhcxdkiH2xw/Ir2khs9iRQz9D30Wr?=
 =?us-ascii?Q?pA4R7tJfTdJPnOlCP8RCmivsGcX0fpvOOdjGQaEfYSnpCT4zGwKnitFWN9Re?=
 =?us-ascii?Q?tcBhe+/npfWpXYgH3gW2GBIYh4kjjG7GhJdX+ITdcYSNwwpYPhn9DNOwKF24?=
 =?us-ascii?Q?Dagx81773OTYmHpEVFepZGg57Hitn+uuoNvKo0aJewIdnlOODWRCO39Bs877?=
 =?us-ascii?Q?eQLRxVJvcLNSs2LAKpAEqSO7xX0daDkGcx7UWCBbZ5he94SIsmT13M61CDvK?=
 =?us-ascii?Q?XTfPLiZdOnDE+IZC0q7wjgP+2A19v82RfW/6TOpL3vPCeIVulK08ymHi9LIV?=
 =?us-ascii?Q?VO/2C4BaKyhO3BCx9PxdAjUpHec9rPdfhOLOoj0ryTmIkTfy09/rrKZG8CBs?=
 =?us-ascii?Q?yOPnHK/RA9JxYlcUWszZRIfyy17cjcPo1f0iYWQBisZumyq6670i/1d8mET1?=
 =?us-ascii?Q?Ka/S4z3m+UUNdVywe/+LUoDBTmZR+FsMY0cqC38rZ6s6Y+am6wPygmjUcA+p?=
 =?us-ascii?Q?SwyhsHmSd8mqJzed2/zVY6zIjqdy8l4SzL8lnMl4Q7b/nkipoRCrrOAVRWEI?=
 =?us-ascii?Q?PkAdIIDEbzwE0MXHjLr30g+JOqEJnG998gq33KiyjFCt3ysMJ7+BbjnmTIat?=
 =?us-ascii?Q?mIMej/ExCaaxctEPwgDVws5tPK1ZcSKSjp5uabpR9/5s1jvOWqn73RI5U57l?=
 =?us-ascii?Q?8fxER4cW2jcSZJEtuYicab1r9Ij1VmICp5ZvH6+r8PjotPxvPEcRae09VIVl?=
 =?us-ascii?Q?EO3AczRhEB3CUBaUaBtFWwHQ7kmcCFgKlzchreoUcbzPkvTkbqfm4zF08hcP?=
 =?us-ascii?Q?91izeDwFhbpzNApdwIOQo+6URByWOybBE6z/dMQVw2L78GgF9Z+GA5p+8qaE?=
 =?us-ascii?Q?dnRf31D1w7rpFGJIspzTPDiwZqPQMdPfNjzee+ivQpEO6/gPayGUfp/19yZS?=
 =?us-ascii?Q?fUg756jBS8kcKSCcKjIK5VwNk8w9uUOVd4HXgIYfmxVRwziZF6ZjP/jFbA9T?=
 =?us-ascii?Q?qqjrNcl0upnRyyxaMTK5be3KEt3L/VW0JScBPnNqjTg6cMYjXuRoA4i9Fq/T?=
 =?us-ascii?Q?AfPet+UA5OuKrJ8WsEJ+MK5YA/mLqTnD2QX7wF1hg6j+uhKA8R3s1Omr17m1?=
 =?us-ascii?Q?6hpdTFOmCte7EKdShM8/f7hiy/FlAspdCP25Dn7ub9gvS/Jo9v3v84u3MU3U?=
 =?us-ascii?Q?x0Dejqkj+bqjnJdSwIOFV8I409w=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 085d1df8-dba0-497f-43ad-08d9cafea10d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2021 19:08:42.5890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u9zrMr/748/8dM+XP/dimJO+r7JcNffLI1t2Ee7sZ3W5xw1a6PFx1ahelTolZFBoV0FUxQtc+b0l4viwBlFQpPLn0GRi/dB8gKhHXV1fFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1279
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 10:30:54AM +0100, Andrew Lunn wrote:
> On Tue, Dec 28, 2021 at 04:37:28PM -0800, Colin Foster wrote:
> > Expose a debugfs / devicetree interface for Microsemi SGPIO controllers.
> > By writing values of 2-5, the SGPIO pins can be configured for either
> > automatic blinking or activity.
> > 
> > The implementation is modeled after the code in
> > /drivers/pinctrl/pinctrl-ocelot.c.
> > 
> > I have only tested this with currently out-of-tree patches for the
> > VSC7512 that I hope to get in soon. They are not needed for VSC7513 /
> > VSC7514, SPARX5, or LUTON - but I don't have any hardware to test.
> > 
> > Of note: the 7512 chip has a discrepancy between the datasheet and the
> > registers. The datahseet claims 20Hz blink default frequency, the
> > registers claim 5 Hz default frequency for BMODE_0. I override the
> > OCELOT registers to correct for this. I don't know if that is needed for
> > LUTON or SPARX, but having two blink modes at the same frequency isn't
> > beneficial. As such, I make the blink modes match the 5Hz / 20Hz for the
> > two modes.
> > 
> > Tested with VSC7512 by way of:
> > echo SGPIO_O_p1b0 {blink0,blink1,activity0,activity1} > 
> > /sys/kernel/debug/pinctrl/pinctrl-sgpio-pinctrl-sgpio-output/pinmux-select
> 
> Hi Colin
> 
> Since this is an LED, you should be using the Linux LED interface in
> /sys/class/leds. See Documentation/leds/leds-class.rst. It includes a
> way to make an LED blink, using hardware.

Hi Andrew,

With the static LEDs that is exactly how I have them configured. I was
happy when they all "just worked" when I tied them to the phy activity.
My thanks to all those who did this hard work before me!

I have noticed an issue in my setup where using a heartbeat trigger on
any of the outputs causes a kernel bug "scheduling while atomic." It
seems to be trying to interrupt spi_sync... Sorry, I'm getting off
track, and I'll deal with that in time. Luckily it is very reproducable!

> 
> Activity is another story. I assume you mean Ethernet frame Rx and Tx?
> For that you should wait until the Ethernet LED offload code
> eventually lands.

I've been following those threads a little bit. Seemingly a few emails
between August and November. I suspect it'll require at least some version 
of this patch, but it is probably best to wait and see where that lands
first. Thanks!

> 
> 	   Andrew
