Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE05659FD10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiHXOSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238549AbiHXOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:18:05 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FAD99240;
        Wed, 24 Aug 2022 07:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f50x/6NpI6RYkVRZ3QANdmwt5wSJwez+hxQmarpuTYCg1uQ+BCt+VBfufdB+MlybsSWjZ/FvDWErjYuFuuvKqOXo650V7QfX/QOF17ClavpFHP7A6FksfWTlithjTYgefGyxZSudfyxKBRWukj5fxINFstTb9qmYDsDM9LUZeo8YNUL9q7LLE/NCLri2XQME9AQkWCM47hU4ZUZumgAsLCkpQ79QOwVPihQNCKS6CKXHLfkLf2l15wD4YVFJN+aBfs6l4wH0GG6Ud3OMf6irVgKLZjhP17CsmpIwQQDiRrIzzq37Y7gXznjVGOxBWNEMMV+5VRisQB8WFiPgBetLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKdtAoghSeZqmxBj6qq+lx/rbpp7xq7CrIF0S2M9I84=;
 b=Q7a2xYZCExLTgFd/FtJ94D9P6HtiiJ1xLWXifEeevXKFiceNJwBBwq9M1nxuzOKVqfbl/u2eT3HEwHF+XZNZERut8fHWK4NwDK74C0+4K9h1m4BKwRYIjjfVxr4VYsqveGA8u7joiisdkkbmvPciPAbZBujkyiQyxWuCQUKwOUe22CTvjOTt/QYah7Xu09+dLx3Mq+hcJYW9EUze0T0uNrlRDKm/SBYO/5Fma/3LPN6EruiE5ZQ9tmXwcy8KilQTNqHbG3JmGdoR86g3cjfbOpfq1NKWUeee22hvr36+NPcIDQ0gwAZB0CDHWikcJdq6z+ZwbHD7zf4r+x9iYapbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKdtAoghSeZqmxBj6qq+lx/rbpp7xq7CrIF0S2M9I84=;
 b=ubXx65vK0r+R4IRuTVg1Z2lEcVXcFdnqQRUXeWX41QIKhzWd4WWQGbGPQG6C3MTsks7+xFeZ4/4yjFVsoIkDZmxlVeMuyOhFb5c7zulxdCoUsyuZM00WzoGS3WUb6CeeiE/qUUkiKYbz/6ATCKAq/PeG2BW8vJQA9jKByj89ecySFuY73gAtVAgA7ke3RbrD8RCsV9zIvz+wvq5tM/LRVOgVbMPIy3vpQQ5LigWoksLiIVLmXTfkHj5oHI7esPSlyMnzfGGl1vfMdtj0gznv8t8aXy9lde/R8OM8cco5k4ZnATEZhtXVUbsyBaIwgaFE3y26yRqWJx0CTD2vl2dtog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM6PR10MB2216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Wed, 24 Aug
 2022 14:18:01 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%3]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 14:18:01 +0000
Date:   Wed, 24 Aug 2022 16:17:57 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     simon.guinot@sequanux.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>, Mark Gross <markgross@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
Subject: Re: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220824161757.4ca3bb97@md1za8fc.ad001.siemens.net>
In-Reply-To: <a001efb5-95a3-d89d-32bd-557b6f11bb80@redhat.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
        <20220823102344.17624-2-henning.schild@siemens.com>
        <YwToilxquEZGqzQD@smile.fi.intel.com>
        <20220823165459.143e1c30@md1za8fc.ad001.siemens.net>
        <YwYjXzsSHNe+J3aO@76cbfcf04d45>
        <20220824155038.5aa19495@md1za8fc.ad001.siemens.net>
        <a001efb5-95a3-d89d-32bd-557b6f11bb80@redhat.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0712.eurprd06.prod.outlook.com
 (2603:10a6:20b:49f::18) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 891837c7-0a86-41c2-7e07-08da85db73b1
X-MS-TrafficTypeDiagnostic: AM6PR10MB2216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLrFS0jQEpReTl17szKXuI/ynP3Z7HgcQyLfbUDNdSekGJdmBMqUc41wIcF7agmBgctKGJz75ajKHOK33PbX9M7XmRUyWgdVxvZPq4dk8/QGlej3Zm5kbuBergGNU5qJBVhO/V5aKWRc678rKox1Mlmcb6rVUQwcHZrdx+02v/kYGYIa+aDPVgJycfxgFy116LfNrocNr1UxK36BWcZ4AYnojt9sUcuyhngLOxtaiF34G6r+VnEODRj48rJirH4BiDN8v/I98LnTgU7bxAXPbToTIQH3whZLj4iwnCnM5W1j8FEv52rntxp8kjp3Hhbea4JhbkzYduuDOLgQsivv1pgvZuHKIIhnKxzqt21R2vHMBw7ujRdR0/3imbW8SSxQEWmEy//UFxpjV8kIztBk14YBx3roXjz+HkC73F2GJPNv6H6saOZO6HYAfYuSkbo2s5DCw5Ki+e9wRaoOgB7fE2ldEYlAY/VG2X3E3XsVK27rrfvkNwB0/acr7ixhn/4zA11SfFVYD4ifnkiY/ITzkhsQCyUBcq+vV+5RuIXkSmXvt2R0kuR5gNQIAispJrHD8DlYk4jvkNn8QhSqW5sAndUaWobbgJC/V56CX4KuwSVSR8HxNufZDFQ3K3mb6g3G6f/NMjr+pACyUH+vb1ba2bVh2IMMCGUuSzBjRT2mBS2S4pcYXJmPDdnAia+pCC4DTmOe6lwIQVsjM+4+TepWPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(86362001)(186003)(1076003)(38100700002)(82960400001)(8936002)(66556008)(4326008)(66946007)(8676002)(9686003)(53546011)(5660300002)(44832011)(7416002)(6506007)(2906002)(41300700001)(6666004)(316002)(6512007)(26005)(6916009)(6486002)(54906003)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r1Lh/a7CdBGY/Ku1JxZY5387pYJ+5Hk2rqqFB+HpPPSds7u+rGxBl+UPclSm?=
 =?us-ascii?Q?f/DSv8l52TC6a2mUIc4eKKckgJnjB9QaId7dTLyQF+83ogk6F5LGPgUIkAVi?=
 =?us-ascii?Q?eFQZBGKIrFQkh+2yXVe0zU2fh2KT7o0xv0b8gAZTkfp7H+lL5OIikBrGZHnA?=
 =?us-ascii?Q?e9K9HqB9LFPaJ8kRL+e/1pdsXQIVDsLrDid1Qy+ttatnJHDHE7FPhjpek6//?=
 =?us-ascii?Q?flBCxZdAFME9MbTzXzAxhaR0cXwTaYUIeeFJYjPehmfc7TZ1LJr0uEjywVAG?=
 =?us-ascii?Q?MispFTnFIO86wBjhQ266p97p8NXZI3UqCafqLtrFIxsR8YgRy/N7w9hgAUxB?=
 =?us-ascii?Q?OB1IKsA/fHAIeb9lUWopDGbvNNKyWC4F4AI07eCQ9c9599rcaZzOGj2+8oWh?=
 =?us-ascii?Q?xXlOsk9kdugvjieF9gp0pOc/ySr79Ds2XLjO0gMci9KGiQKMEPL0g/mvfiRz?=
 =?us-ascii?Q?NUzypYR7aVNrUKF9Yp74m63/q9FAKS+A7hOVmLVBf7MvCyRteuR8fIdtD+gu?=
 =?us-ascii?Q?B0Rlloc1cezPvELMB1r7uFDPtyq1s2Tcwk8e12d6EPsmvDGYFw6N9R93r0PB?=
 =?us-ascii?Q?3GxjAoG309VnUtuWoYipuymK8pESfZyKMdqujSoq1XX6u17ORNEdyH8XG4Y2?=
 =?us-ascii?Q?bC5lD0kno/01UCE20y3ZRA3Oclt6cDuwrrWjspATUIfp/UAWDnGhyl+AUr58?=
 =?us-ascii?Q?9/NnldYoAuS3jCO/kdDzUP6T1Fowt7IJ1VwngjjbiEzlUH3UwTjBA0dic3i2?=
 =?us-ascii?Q?VcHo+9X4Bc4eQgNCa917IObOJqMafiKx10Pu9jyFETZEy7tnqgvN93E+Kvz2?=
 =?us-ascii?Q?IBVOhiVHVoGt/ZBIp2hBbXPuFpLH+hDDepXbpftwqhTXSZ8+IWvavP92+NU3?=
 =?us-ascii?Q?9Ts1F3eXQ89IvsEm6mNRxyRYG6rJ3E9EDYU1WAwXHc7+SqFzWo6ArpmQxaR1?=
 =?us-ascii?Q?ELh+LxZNExEJ0/3S19GGCr8DfCJt1zKPuxdYwaKZIe/4nI4owHftuE75Fd1j?=
 =?us-ascii?Q?l77vZKk4oFWl+rIrRs0ScOkBEzCZxmbNiTwqrp+ZqXJ2FvEDdCZsIMlDyB9f?=
 =?us-ascii?Q?E5wrQVvQL0K9WmeEoNHkiFuvLSJ3Pqy4TzU3Jn0bSZOawo9Dxpf56IBYwNq7?=
 =?us-ascii?Q?s3Xch4VM8LKYHTqdEDx4EXPhsXq5RNrxZRiAkxcCb+jZePyNjr11AJlrRguo?=
 =?us-ascii?Q?NqBhh3Ah3PYRsvO+LbYomoJv/zPLGI1q+EzJIv7yET47yr8iq2rTo2MjqmoR?=
 =?us-ascii?Q?6cP2p7wM/6bfjFI/Nyk/fl0J4ZY+CmnDS1UTxc31YTm83GH8CGUuSLW6G0aL?=
 =?us-ascii?Q?J4Z9+g8kqejEhmeNOiRlDP11FlVD0p7mocG1OqCyi7Brm3JpARMd70xCBIug?=
 =?us-ascii?Q?Xh5Hw6jIryxshvLNsrRjqppUUSmJTLNMit7AKu9NQDZ/BxGydjASdgysDkTQ?=
 =?us-ascii?Q?B4UyheY2KjcreHWrCess8tNXFiVkvJhauP8Mpfsjad5tpfu5ixsGAqg/Np9K?=
 =?us-ascii?Q?60k1hdzp1X1AjAp7tCzfaquwRVmtwc1NLfsgWtEBgZnACZlVoaXaBLxKnnmz?=
 =?us-ascii?Q?It8nZIvCRbjkRau2AYP7RYd6FSbF/LpAsGViYXP7KLkX/DNgT7VMJs1mmsgi?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891837c7-0a86-41c2-7e07-08da85db73b1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:18:01.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swUKA20+pmmaxLA7h1X5oKdTCTn7X9i3LbE9Hmi+0yJV3WAXG7bLTmV17EP4r7nIKZdkrG9YRTniLHd4FyrbmoEsw7MHe2OH9KDvSzsRTPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2216
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wed, 24 Aug 2022 15:54:28 +0200
schrieb Hans de Goede <hdegoede@redhat.com>:

> Hi Henning,
> 
> On 8/24/22 15:50, Henning Schild wrote:
> > Am Wed, 24 Aug 2022 15:10:55 +0200
> > schrieb simon.guinot@sequanux.org:
> >   
> >> On Tue, Aug 23, 2022 at 04:54:59PM +0200, Henning Schild wrote:  
> >>> Am Tue, 23 Aug 2022 17:47:38 +0300
> >>> schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:    
> >>
> >> Hi Andy,
> >>
> >> Thanks for this new version. It is looking good to me.
> >>  
> >>>     
> >>>> On Tue, Aug 23, 2022 at 12:23:40PM +0200, Henning Schild wrote:
> >>>>   
> >>>>> Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO
> >>>>> chips are very similar to the ones from Fintek. In other
> >>>>> subsystems they also share drivers and are called a family of
> >>>>> drivers.
> >>>>>
> >>>>> For the GPIO subsystem the only difference is that the direction
> >>>>> bit is reversed and that there is only one data bit per pin. On
> >>>>> the SuperIO level the logical device is another one.
> >>>>>
> >>>>> On a chip level we do not have a manufacturer ID to check and
> >>>>> also no revision.      
> >>>>
> >>>> ...
> >>>>     
> >>>>> - * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882,
> >>>>> F71889 and F81866
> >>>>> + * GPIO driver for Fintek and Nuvoton Super-I/O chips      
> >>>>
> >>>> I'm not sure it's good idea to drop it from here. It means reader
> >>>> has to get this info in a hard way.
> >>>>
> >>>> ...    
> >>>
> >>> Let us see what others say. I wanted to keep this in line with
> >>> what Kconfig says and the oneliner in the Kconfig was getting
> >>> pretty longish. Hence i decided to shorten that. Other drivers
> >>> also seem to not list all the possible chips in many places, it
> >>> is all maint effort when a new chips is added and the list is in
> >>> like 5 places.    
> >>
> >> I agree with you that we can drop this line. It was already
> >> incomplete and the information is quite readable a few lines below
> >> in both the define list and the chip enumeration.
> >>  
> >>>     
> >>>>> +#define gpio_dir_invert(type)	((type) == nct6116d)
> >>>>> +#define gpio_data_single(type)	((type) == nct6116d)
> >>>>>  
> >>>>
> >>>> What's prevents us to add a proper prefix to these? I don't like
> >>>> the idea of them having "gpio" prefix.
> >>>>
> >>>> ...
> >>>>     
> >>>>> +		pr_info(DRVNAME ": Unsupported device
> >>>>> 0x%04x\n", devid);
> >>>>> +			pr_debug(DRVNAME ": Not a Fintek
> >>>>> device at 0x%08x\n", addr);
> >>>>> +	pr_info(DRVNAME ": Found %s at %#x\n",
> >>>>> +		pr_info(DRVNAME ":   revision %d\n",      
> >>>>
> >>>> Can we, please, utilize pr_fmt()?
> >>>>     
> >>>>> +			(int)superio_inb(addr,
> >>>>> SIO_FINTEK_DEVREV));      
> >>>>
> >>>> Explicit casting in printf() means wrong specifier in 99% of
> >>>> cases.   
> >>>
> >>> For all the other comments i will wait for a second opinion. I
> >>> specifically did not change existing code for more than the
> >>> functional changes needed. And a bit of checkpatch.pl fixing.
> >>> Beautification could be done on the way but would only cause
> >>> inconsistency. That driver is what it is, if someone wants to
> >>> overhaul the style ... that should be another patch. One likely
> >>> not coming from me.    
> >>
> >> About the int cast, I think you can drop it while you are updating
> >> this line. It is unneeded.  
> > 
> > Ok two voices for doing that one fix along the way. I will send a v5
> > and hope nobody insists on me fixing the other findings in code i
> > never wrote.  
> 
> You did not write it, but you are using it to do hw-enablement for
> your company's products. So being asked to also some touch-ups
> left and right while you are at it really is not unexpected IMHO.

Sure thing. Dropping a few characters from a line i touch anyhow is
easy enough. But i.e a refactoring to pr_fmt would feel like asking too
much in my book. That feels like work of the author or maintainer.

In fact i am just doing the homework of what i think should have long
been done by Nuvoton.

I hope that v5 will be acceptable.

Henning 

> Regards,
> 
> Hans
> 

