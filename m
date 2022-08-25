Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F135A0CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbiHYJc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240358AbiHYJcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:32:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57339DB47;
        Thu, 25 Aug 2022 02:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVDT9MNr7Q8uycETdbSXJOw5dxU3IsKNm5kp1096R4Cb90KU4wHI6IKZWFuiXCmZTysUf2VmPBWzx+hTUZXGfSD5hFLXZwZkr+rBou1NfaFvIzgjeG4r03/ImzYnT1sKjKXEAiSuaZKPSqGf6Kz74Dh1RnJ4miyMx7vFB+iaEmOMPImNnh5CDodOSVOtg6iJ1mPV4X9NfnnGO2HizG7jn8YgY45VW6bPZ3bzuXuJnNL+mKXLwLErfwXWwUgSitLmBXpjoaCWEeEL99syvMjl7Sq9xGnDOWOAw355RoP4hNEeXa7PtcFO9jSyD+3T2ptFpCDr6d7Awqkwdez6U/YCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLWaUz/6nzNcM5IfPNqzSxXaawGnWSq+8+3nLgLaPvY=;
 b=kByY1TmtyRIF0AJalCHCcYimkChMSJdSMLdxdIkyQyAz4PMOJo0Q6bIyRtmxzBuDhbprjMAwbf+e+03LXl2rRqU7fMHfQ+CwEd7qsN/XJQSvjYxTZm1KTCuAtuTsMLcGV5b14aTExusZXa4/4+Pqzx9YmgBlfuVCcLUCJ785gcbN2zDe3m1W7afpTbXKhV8lUetqUo5GreSM/ChYw4l/I/6TbGxt5Jeyep4QHvDeb82a6rGE3HS48Px5CjToaRSZqUGd+m7g8yOOGnLzNVEwPR8s9BRulvPHIVCuXDEBua07Rj75btZAleDj7l4e/wQUaKhY5rQk8wr/iEACwZca/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLWaUz/6nzNcM5IfPNqzSxXaawGnWSq+8+3nLgLaPvY=;
 b=Mhf99rSN4hi8KnqJ+TtAL3vEJZOwKcC23tL7f/sFa/9my7TC2d81/G0RBBQFseK5aLGetXDzKSSGJvONjikcb104xKgUkz8LDPiX2yqFG4HCELCNxBojd9WIMWy5nFyA8Ox9ben7bVtccT8KFJvGDkuCNIEgYwcupxp6gS9Oq5Tf5FFcci34CB5LfMYkllvtkqEX5/DrsboSMVwInS5YsGpswoe3rKlJOIuvSOUU/l6arkBkQBqGU2p9mIsZHugbVpKFhogCnyXjyKISG+JrvUt4QUGdbu/8wWeBGV6xbfhEa0SpOhNxFzFFmv6HeSKa5wrM3PN5cy7Jt+Kkae/6sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VI1PR10MB1823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:2e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 09:32:13 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 09:32:13 +0000
Date:   Thu, 25 Aug 2022 11:32:03 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        simon.guinot@sequanux.org
Subject: Re: [PATCH v5 1/5] gpio-f7188x: Add GPIO support for Nuvoton
 NCT6116
Message-ID: <20220825113203.4e14f4d5@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75Vf6agD-G1Ey1UgUvWnub4Q8-ysx3OMV14dR3ed5FRX=Vw@mail.gmail.com>
References: <20220824140347.1842-1-henning.schild@siemens.com>
        <20220824140347.1842-2-henning.schild@siemens.com>
        <CAHp75Vf6agD-G1Ey1UgUvWnub4Q8-ysx3OMV14dR3ed5FRX=Vw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:610:51::22) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 916d73f9-2ae3-4db0-c3f4-08da867cb0e6
X-MS-TrafficTypeDiagnostic: VI1PR10MB1823:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9wwuXb2XgSfEYYSqHY6BnYThK+XbLhNTzNrTEQtgr2iZ3HTVLm63gnLcFbpUz2wxPsr+8agUvPAEnkLZwtBIz0kZQbkqqSer6RNMQ3DNIM93DwnlcqKDjyf4WijbU/9qdc/nFwH91b360kd9qGRQrPPEWEpbhb5cI2zAOB9GxZa188ljGx5WGDHWl9vuEKo9avDyI2rqds1q3Bxm1ES7Vu4xDLBiTpU9JC0q7XCWePkwFxZqLq9RAqPVE8xZM3YPkIg/Zhj6k+adoBmZnY+kjDpNaPOCEvZAESIMuAAH3aY+cUsNOCTMVeEYi3W5RKL+CVk/w8s13ThhoUvMIMEoDdctwyAJE7eWyyLK11MicJZmuXoYvDneskoR907yrFzCxxIrcR61cMgMSOtsJaISs9I479GQyFiAPFM/EO8rcxuacXNoJo9E5N+oyWVFdbbHBuebVP2hmvfdZykPHhHQPCNHA7osFssB00G2tL3mW8aMt06S8qBinMZiDNNW0L/sXrz5zB2gfZCUrh1XmVdiWhMEuQ6Y9L3xiizHWPK93c02fXVZ/U3FZVU/6kf05wiceutGCpen1SzPK75HBHrtzCtdo9maJHSyunuxjMo8hk9o5Osl+XBCLaUN4RDpVuA5ILIDiQCLU0eXxNbAuLQKNoa0HSrf7F483KmQdYwkXrwz1SkzBB3vbK9DWFcLElxLGIl/+HBNrhkEb0qggS6CpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(53546011)(6506007)(41300700001)(478600001)(6666004)(26005)(6512007)(6486002)(9686003)(2906002)(4326008)(66556008)(66476007)(86362001)(82960400001)(54906003)(8676002)(316002)(6916009)(38100700002)(1076003)(186003)(8936002)(66946007)(44832011)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uOhXeu4sNZUBE+yU2js5MkXid8kReR+AZwCXuQMxKSGxCb2MQHg6Hg8NssmU?=
 =?us-ascii?Q?JD1zyAZNjrjP2mqdeQU6nCJ8097c+Q8F57yCs79BeGFXMkDRmjdTs9xYvDEs?=
 =?us-ascii?Q?x/LTGjzoBqzq2ZnKsUV1VP8cqxVhySAN+xMmUzpJ6FZFBfdG/P/OVEKYIR2o?=
 =?us-ascii?Q?I6iK7W8hRj75b2Vkkhm76Ov70vcJiQF9bJ4AC7FQ2a4oxXLujltMXn7R6M5g?=
 =?us-ascii?Q?08piW9a7Yh5sQArNp9sGUTYcpubQmfRJOaRlmO8l9X8vF8VQ7K5H5frxrF9O?=
 =?us-ascii?Q?UWYwf/CORjQBVWuZBV3PoLbp6QtdBpU8CDnz+fZZB1rAnamjbQAGPm8Oz7YF?=
 =?us-ascii?Q?GWr0Rp1PscY8zMKAtNm8f6tAUX3WU4+aGd99EOjZ9h8LhzYChv+S2YqHBGsz?=
 =?us-ascii?Q?zu9EjoHCDkypGfNrVhSw2u7P3nhnOe2nGlLXPPnqIORth1qJBK3LAvguywco?=
 =?us-ascii?Q?jFx6EWzH7pCxlEy0IT25ZKKSTPH3jcLxFHpE3tvAJ2t6iLZAatR4BQPqN9ng?=
 =?us-ascii?Q?/shiuwoVn5PcPbRd+KEm6wa/SbPeHBNAd1y1+iW1oe2Ofra/sdth/f3twaeP?=
 =?us-ascii?Q?QIUt854yTcBxdlnhWMyF4n7ieP6wPYMnmTZtkUv05FHN+C1ZNbPyTnPPm+0i?=
 =?us-ascii?Q?IKnPo/0sEFQV5RrOR9QP2W13R99gFwIQ2K0aL0nhM1WIgS/cKaQI1mYNxoiT?=
 =?us-ascii?Q?dupe1BKo1ui/GntgOg2qTJ4fnklYXaAAkpFSYBOqzV+tRWxaShN16ywsGrxy?=
 =?us-ascii?Q?fpQrteP82WCqvkwNKwhgTEncZ9NsZ2gmGUOTLdRADZQ4eJ+dc4S++BeS+79h?=
 =?us-ascii?Q?l1Gl/qdHKXoutQegifVTKXiSIMd0njCjdgGt5IaTrohKqse9sb8nIo3CUquX?=
 =?us-ascii?Q?9UwSqSfYUdbusO4lctrADU1xrsFmLVbbgQDV4pvuM0jQ1lrOaaS14scA1TDJ?=
 =?us-ascii?Q?mn9e7kCaORa4EAHf/upJ8J3J19K9nQ46k6o0FmK+gNj2gYNpRcGxrfiZdQEH?=
 =?us-ascii?Q?nSLbyjVh9KcefzReXBK1qMkTvp2H4LevNoK6VT68HIziud9j2VFjljNKIISM?=
 =?us-ascii?Q?C0H+olOqUdR2e44fCf/X9HhpzkWaBiqCtB2yuGIorPMZHqJD0/uLnvE5tZnM?=
 =?us-ascii?Q?4GUpi99GoIfQ0bTQxSYjbVRUg5I6w2jXEB6lri8Khml1ddGL3j8tZ9c9EGQe?=
 =?us-ascii?Q?Gb7gb99Vq1VyaER9KpfiiGx4xF/xB0UvJj/buGn0B3g1Fs2Ck2KgM2OklA2W?=
 =?us-ascii?Q?hT89+uVNceuQ36uMpv1ne55bvxMcaxZgTL0nWsPRyic3CFeHBBrM/F6RO8bx?=
 =?us-ascii?Q?QonhMSPvbckkK92AlcQycVhTm1k1GHS9iP5Tef+YjqPBDHgOQgREsYo5Eqv1?=
 =?us-ascii?Q?U8GhYPJMOgls0P/GUX+BDaIb3Wzhs50rDut1Yg8SV2XY59DrL/rhFyqdPEva?=
 =?us-ascii?Q?cGUd8lAJa1maL9HD97245ulF2UXipU2MT+A4ToJZLe3zO7I7wAme00KmdAP1?=
 =?us-ascii?Q?zN7APVUtb+diHIgsxfp1BTj2ARwB7VZPjaZKcECFeTxtJ+OP1TvEVNKngaRm?=
 =?us-ascii?Q?pa6dVforw3MLGbiqJ3s3v6jNfU5ocO2WjiIga+XOysj4zSC0e28OlzcGDLcu?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916d73f9-2ae3-4db0-c3f4-08da867cb0e6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 09:32:13.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boQaq2hf5jaBeClO31iNVORPTLcYutZwVB7LVXyPEbY5F2IojwQ5CfRP5xLrxVbtAANUJeO08Qcfft+Gom6i0iAmfry4+rdztBw8fQe6tCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1823
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

Am Wed, 24 Aug 2022 18:59:17 +0300
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Wed, Aug 24, 2022 at 5:04 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> >
> > Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
> > very similar to the ones from Fintek. In other subsystems they also
> > share drivers and are called a family of drivers.
> >
> > For the GPIO subsystem the only difference is that the direction
> > bit is reversed and that there is only one data bit per pin. On the
> > SuperIO level the logical device is another one.
> >
> > On a chip level we do not have a manufacturer ID to check and also
> > no revision.  
> 
> ...
> 
> > +#define gpio_dir_invert(type)  ((type) == nct6116d)
> > +#define gpio_data_single(type) ((type) == nct6116d)  
> 
> What you are trying to do here is to put GPIO maintainers / heavy
> contributors on a minefield (basically moving your job to their
> shoulders). Please, provide a proper namespace and not gpio_ one. I'm
> talking in my "GPIO heavy contributor" hat on.

No i was trying to avoid having to touch those other 4 existing macros,
touching lines that checkpatch.pl and you will pick on again. Adding
the prefixes just to those new ones would be inconsistent and also not
nice.

> With that fixed I can survive w/o pr_fmt() being in this patch. If you
> are going to address this, you may add my tag in a new version.

It is a bit unfortunate that you seem to be surprised where i said i
was going to not address this. And once the new series comes insist on
another round ... which involves testing and what not.

But hey, i will send a v6 with style refactoring patches and test it
all over again.

Thanks everyone for the review, i hope that next version will be
acceptable and not open new discussion with the new patches coming.

regards,
Henning
