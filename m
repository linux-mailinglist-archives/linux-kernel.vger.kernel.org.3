Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC75A18C9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbiHYS1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiHYS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:27:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593D30563;
        Thu, 25 Aug 2022 11:27:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSO5wd6ZE7fwmOVhmMCXaMmVJOeMr1UX0YAIMuHF2OnwxoSP1oMQrvFBz4mR4tKHkdmfuEh58QpW2+qXxlhyACY84JWboLrCEU+yWk7iPY4b3S0CB9PRexmE9RQxmzD6RYXBivd/jf9hmNMAsEaEWCG0C+6VpMh/UXexAkHRRHpKbf4w/f0O87H0Zt2CKR/E+W6Yu5kNL0Ryk8LcY4D4kZTqCF0Y+/w9xp7fzTZXEk02Nml1e22v2W0dn2AE+jWCXGVoZ/z53i0+94bdB2wQ1lYd1xjH1dO9qzU0akTTwrRy9rslxKzSdAF9ZTZpJaT2PbvWdQtgzzJCRybcWUnCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+u3ZIgxGP3OtmZ4WY/FBgJCgP6eKBotxkQiCynm29k=;
 b=h5lS94iOQzKWpVETN0qFDxF3nkdEkfhQuE6tzauaRXsrvLE1+xEKpC1FpXHQR2ki3CD1ATG+X8+pnVh/32ELgNcEw12Lj7giJX/sqEADKhfy5xc51mRiR2bIqnddnajZNX044gXAuRMm5GV8gBDSXe6gw3+0KeU/NxOVwT9HEIzYB++9p5oNdVmCNvvW9zZQxkO7gJIagjytUac2+jajqw5BSfkJ7VEpx1EBi/hweQPtLY6XEi3LHRXtTfFowCTsR2/RrOnIgnrfYATrLJy2Q8oiM8ht/On/utbQcjnSUxPbC4WDhURUQon05iMiMqE60a1wu0RJv63dzJxVstrxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+u3ZIgxGP3OtmZ4WY/FBgJCgP6eKBotxkQiCynm29k=;
 b=xeJZNVn6ZcESAKJyJL0oNVNoDDX7sv90z/nsoVHnort6pg22CaLoz6kn8ukFCqGbaV4UgVUltyp09M20v5qguR0rXvqDSHF5rQcGNYnmFEVq4qr4BwA1n1sXdevs2So9cy58HFwzhQgC3Icf0H88aO7BJ3U3sL9Y3IQb3QJBkKsZvvqI9USuj+p91s2Ucke+SpTQ55b9o8f3SvRGa/3t9uIa56P5i2uPTyAFECMd6tJwh/30L6GvZhMLxPn8wogjnpIADeiLcMY/Sz/reVqWNtoP6KUYZC+mFrMm8gx4udnMK7H14ARuKo7bJNNRXkRSCLtqZWNZ0JBkULU5cmo18w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by AM7PR10MB3606.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 18:27:34 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::75ee:d5d2:6b1d:150b%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 18:27:34 +0000
Date:   Thu, 25 Aug 2022 20:27:30 +0200
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
Subject: Re: [PATCH v6 5/7] leds: simatic-ipc-leds-gpio: add new model 227G
Message-ID: <20220825202730.21ab8088@md1za8fc.ad001.siemens.net>
In-Reply-To: <CAHp75Vd7jrPUb0bOdySDLmJQCdo6qieBaDVkTjf=u7R+Jyiv+g@mail.gmail.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
        <20220825104422.14156-6-henning.schild@siemens.com>
        <20220825193340.058fd4c5@md1za8fc.ad001.siemens.net>
        <CAHp75Vd7jrPUb0bOdySDLmJQCdo6qieBaDVkTjf=u7R+Jyiv+g@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::17) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f81e399-6a00-451d-271a-08da86c77aa1
X-MS-TrafficTypeDiagnostic: AM7PR10MB3606:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB0JKSGtTgoaF0lL0wp3dV8j4DnUivTzA6eNETNiGOQupTx66rLCVC76kD1NW1jcnzl6h8sOOJrYRNkF8FFMYgNU7EoHfFqSwh7kAxYMRxOzSuysowEWZ+ORhW9VuDJ7zwk3ALYWjlilqpiKQl52ueMJBajPyaRUQr2wYuLTCRg9+Nk7Oa57HJJ8Qo6danQlAoVPJvx8fSVXnzhRPwRnwtRlhoAJMtyOBeMkRReXmM7HFBmbtU4zbcEYFx5F8w5fNbQKv/0g5W17yUDC4Fve7Jbf7XfQ/3/eg8SGiBZ6xWwCPtosza6r/74Z2om/5XfRMOa33fZdXLbhJJ96qPQNRfzuHQh1gR/p749D7hbAq43pC8w8VSErQ53fswyhdmtD3c+TvSRc4aa1QPrUKDEERZWQe13c3tz8PYDIOLNlBc10jtEh3dxoM8Z7Sklt3oXZXc2fabaSliYNnccytNtrApcUCpyZatTvFrf17ZG0hGmH3bwIul0cNZ0726H99BZ0VkJDmbWB2k428Ewb+4cwB+z3MCLKSo2OAdI8ts68MBFc/q39fvwxr9JSeA7Kg/nGGr3Az/Tco9Mz+Asyhldnd41h/R3RtFTk0NAQgJuj8JWqB/wKNVeUlssfquRVGY/zpCDx7LoyCDHco9udczbFU5bTMfQxtFAuPl/39aJpEIqvNpQHRvsj9B+mzY4COJ+d1TkoUrkKhUNqHtNLUS1sSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66476007)(82960400001)(66556008)(66946007)(4326008)(8676002)(86362001)(38100700002)(186003)(9686003)(478600001)(53546011)(6512007)(6506007)(6666004)(44832011)(6486002)(83380400001)(1076003)(7416002)(316002)(54906003)(6916009)(41300700001)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ckFUClj5qPo0zrkRND2Ip4ZLsf9IRLuRAUTa88dfAYD69oYVvSb/ZYdoiugZ?=
 =?us-ascii?Q?o4YeHy3c6POGoDrbqB1udveZYL1iArFhAzu/paoJRvB+r2FlJl4KTjlKpqw2?=
 =?us-ascii?Q?JH5DK3+iQoQXJeaboSx4GtH+bGt2sA+8RoAFza9IV4FBdzZEKEe8wS1ykukk?=
 =?us-ascii?Q?GUZUu3RiHz8UTfEDpEb6R0Vw2woiJV5H/vhWiP1Txmi1xyTLTut/Esbz5DsV?=
 =?us-ascii?Q?Qpd0v4ZCdWGV6UonX5pD/viOj6HMscJ3t/JFUm2toCTDABW+9VgdqOlzSmot?=
 =?us-ascii?Q?m8jdkw+IWkW8Mb+fySzuZYqHpwncU9/nSOVTC44sl3r0bgv/vMnV/ecLpJKp?=
 =?us-ascii?Q?zDGbx1V0GwjxnkZ2GoIupFGloEYht8NtRxt3ZXlPL0mOhH3+PjLL3XSogGq+?=
 =?us-ascii?Q?PrUqrzs/bt1gggdkHZVNcl4bASSkkPmkAxWiWd6nyPL6FkAZ6aKgxftKFc2g?=
 =?us-ascii?Q?W8dUwOzIzKO5SiDjszHsFfKozkPkZryglsNj5g+OLaPVdzHSHVSzP+KIUIcL?=
 =?us-ascii?Q?pqRf7iJHHfPtyXY3vAInRhWNNeyE2dHmK6l0t1/ymi2BB4rRcIGK42Rh/Vn2?=
 =?us-ascii?Q?MeUXYgJJgntu7ndzigDFNEHZql7jOLCq3lIrBPjZdDRdmR9JWrHHffG+PEPh?=
 =?us-ascii?Q?xk3UQ5coWTOwcE4jUzVRpLWlLeLMBbqFYXkxU4gvtTnxWXKezWw9axpnY1QV?=
 =?us-ascii?Q?87xa/rGvwNKxNZ/1rUkKZvYYZg3O31OAOQM24UiLwBWQ3SESgsvUy4Gs/8+9?=
 =?us-ascii?Q?s9gvfq83wzz34PFU7D/nw9Lh9ra9SWxVbHFKi0028XOTqmT4RaMtClJZtFHX?=
 =?us-ascii?Q?EANACXiBkR1XJmm7QghOZO2gzRsQfS2JFxFTMBxIpQ2ckNsJQ8ZM8kRYnD6C?=
 =?us-ascii?Q?/Yv/cetb8IzocTcZ1vlNxXRqnc2E2DedmaDoY6e5Lw0FXYkBtoXRT00WXXkz?=
 =?us-ascii?Q?8pIv24CoUK5uEOmhcpO+xhApdXYi03elCGK3R/sv/7iD3cJIetIih98yBNR1?=
 =?us-ascii?Q?t8h9OOld9MMh3zJMxVhCWAg8ZBznLgKUJVK95drNt7KibrP6/WYZZGSqTNZa?=
 =?us-ascii?Q?x/N5c83tI4PXDhjQrAf+EtyGxCPhPIkdzu5tOhsDZN0ADcuNkZOcqltiABmS?=
 =?us-ascii?Q?KPUvtJ9gMWf00vMwZ4LVbPoIAsxn2sNLVKtyc9lEQHRbdom2eD32eLk5fqP0?=
 =?us-ascii?Q?y/xrGpGnxM+PCUGDeSOH86J1ag4Pckk50W9F9JrDllqvYeo/Rydp39+GpN/F?=
 =?us-ascii?Q?dAfDSfOPGHlD+EhGIIqHQvpbYA1cSae/ynBWdnE/paDXtcWQl7A/oVMtCKdu?=
 =?us-ascii?Q?oa1RbqO+joLF6y2SC0LlZn/BrZQWv08qthtdackAq4Jv+mYw0ubBjYF7y/fC?=
 =?us-ascii?Q?00z8zweSXmchujw2Y3tHUGG4Q+/dOeqxqAIKwMUH6KPPMeniBaNP8ZU4m/qx?=
 =?us-ascii?Q?CrQbsDY5pzHrQ4QLCPvqDAkOu3mfpfSL81b2Sy5WyugFdXjXcMbHOTNul/HU?=
 =?us-ascii?Q?a/XxscmQc0Ua8oqyAJUjZh1YWEHaoVfYTWpxTwf7dwJOrUl8+v22FtWODv4K?=
 =?us-ascii?Q?+FwRt1FqRxGNK4uNgnkngQ5gixiUENz8KmL7mfDea5/EdnduqByk3rimc4qh?=
 =?us-ascii?Q?2964og9iZZQ/vobBjUVrPLU86ZfNmCz9K2KEPorzErZMSvydHS21h/N3oXiN?=
 =?us-ascii?Q?6HiS8Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f81e399-6a00-451d-271a-08da86c77aa1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 18:27:34.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrpL0glr2QH5KQnlK+siWOVOlLMOrhs4eF3zrScB/M8rdyo/dLq/IbIdyErtwTuXHI9agsbI9mzFR+zoV48bcxxAB5CO+BYJ1wSNKcEER3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3606
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

Am Thu, 25 Aug 2022 21:03:53 +0300
schrieb Andy Shevchenko <andy.shevchenko@gmail.com>:

> On Thu, Aug 25, 2022 at 8:51 PM Henning Schild
> <henning.schild@siemens.com> wrote:
> > Am Thu, 25 Aug 2022 12:44:20 +0200
> > schrieb Henning Schild <henning.schild@siemens.com>:  
> 
> ...
> 
> > Concerning these two tables from above i have a question i need to
> > find an answer for for maintaining the out-of-tree modules of these
> > drivers.
> >
> > When getting the drivers into the kernel i had to rename the leds
> > but in out-of-tree i would like to keep the old names and just
> > equip their setters/getters with a deprecation warning. Just to
> > give existing users time to slowly adopt the upstream name change
> > if i can.
> >
> > In the open-coded way i just defined each LED twice and added a
> > strcmp
> > + pr_warn. With the "leds-gpio" version i still fail to find a
> > solution which does not get me into -EBUSY. So i already fail at
> > the second definition of the legacy name, not even had a chance to
> > think about how to smuggle in my deprecation warning.
> >
> > I know out-of-tree is not a concern to people here, but someone
> > might have an answer anyhow.  
> 
> Yes, we (upstream) don't care about out-of-tree stuff. But I think
> what you are asking for is kinda an alias. Maybe you simply can create
> a module that will wait for the led appearing (by notify that adds a
> device or alike) and create an alias by sysfs symlink (IIRC there are
> kernel APIs for that)? It will be another out-of-tree module that you
> may drop whenever is time.

Thanks! That sounds like a very good idea indeed. Would also keep the
code free of #ifdef and reduce the maint effort for the out-of-tree. I
was trying udev earlier but failed. Will give such a symlink driver a
try.
Might be hard to get the deprecation warning into each access, but will
have to resort to probe-time instead of access-time.

regards,
Henning 


