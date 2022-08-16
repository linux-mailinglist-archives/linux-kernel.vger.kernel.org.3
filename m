Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1602C59527A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiHPGYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiHPGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:23:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2117.outbound.protection.outlook.com [40.107.93.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77B7180B5F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ri6RgunLXuY41CfAFLttG1MOxqHps0SRezmVP+e0FRszoyiRdr2+cVdQhXzH38+7FQfDPVPf6aj8rMVi6FkEok93PMNIijBXf92xraVLQLCH3v4M62kMuLLt3kKma/VkXoOIYwFHN7yP+mJClUpkdhzsMYEtbwKHClhNozHE0CQzk3REpVOxg1d4bkERp5MUKw9jIFXeJkIUsnGIxmp81C8iQdtpIY0iQs3VGgKI2Ii1NpTHvRMif/Ljd4rrp+ZZR/HO1V3j4cCNeN94mhSP09sVDnfesZwtG7IMsFWrcwz9edHie9DTUyGt/yyuMDmi2d/HE95S0r1QU3N/7n0hJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKYhxuf0HMMsStJEN0QuEQTPyVFI4isgFRoijk5GeWk=;
 b=gBtiKyxwjH2qMAd135jdW+1trjFWqriCc41J8J+c56ZgPj5nsUxJX8V0wgTUdR5qzDlswOWGT//9cpQpiiFPmR8aH6Cq9bczPJni9/uW4xNJf6yA7DgVDpBJVD1P35DDR1MCOxAiCCnOlqaQNPcoJC2mDLH0P6s9UHsrSuYu31G/1Z/ufePKZ4iZA/OOepZWSrIiwEV8vmNtYrFizaTXoSjRqCVzx4sEE7NuYtCWV4eEQ7RHnzJwgPsRY8EIOv5X5ASkel3bSXLJIhmYJMwrg3cQTnp59edYqDxECekgSzYhZkR8qr0oZV1j6QeQkXONzOu5tXL/fbhz/L7IVqSGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKYhxuf0HMMsStJEN0QuEQTPyVFI4isgFRoijk5GeWk=;
 b=evYCEF+YnoBTUzBTBb0BUWIUqOWaPT3otY9TIrZLWoAILuHBbGx7H7W8iDyoVnu11cvaZ2YyW0RIBoWe5F65FghTzPAOn0ETfZ8qC90QksgUZPD+YU8PHkwAPJ4rOS681IwTqbHcLZbcQ12M0eSmHQBM4g4BXBEIhtNWLjx+s68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BYAPR10MB2776.namprd10.prod.outlook.com
 (2603:10b6:a03:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Tue, 16 Aug
 2022 00:28:00 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.027; Tue, 16 Aug 2022
 00:27:59 +0000
Date:   Mon, 15 Aug 2022 17:27:56 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Len Brown <len.brown@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: boot stuck at starting kernel, due to __genpd_dev_pm_attach?
Message-ID: <YvrkjH6/FpIzyAv+@euler>
References: <Yvpd2pwUJGp7R+YE@euler>
 <20220815182307.GA4658@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815182307.GA4658@duo.ucw.cz>
X-ClientProxiedBy: BYAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::31) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42445d89-672a-493f-aca0-08da7f1e2c37
X-MS-TrafficTypeDiagnostic: BYAPR10MB2776:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0u5ZXVIwwsu1i6Hvej7VAOtqfJFnNyM5h4adBNFXOtlflN8mR6om0wFTrHXxIEUwIgrRcr78rBayEgWFrKilUF/Eqfnh+zc5SkjQS8Pm9DZ6rRTmhFvDKxmHBIk2W78sqQcefwwLqZIi+0tf7xJl5A+YvXQttLnrKTZrwjY73sqE1DzpG65hnb1kNNUOs9YyPlWbfR8ANK+8Ymk9FWV6QvmEcOnJ+QRfdIaE8Y/CrnUu/G1nRN8XXKkpi80+uqhExatLa0Mrc/e5GAtgHubgipQ3DOCSCtXyikLj/bJv8QMyAWIiWoFd+V7awKFLPJ6MKlF4sxSjJ+m5bV+v2HNWbhHEcrMs9jgPV3gUdH1RUtNolRfDRSa1JUlIXQCQiOtRnu4eRayX1yYfBbHA1HkZpyTxqV09jjf/ptisSd3ipICzp1QQFTBxfbLgCk4LGs338AzN3jXpLNAvT1uWiuBBtLXg5x3AV8dCIat9h32UVEaCNe/Y4j0pRcbgTEAysdRD8O+Xhk7M+1b/QvesIIMO8vZSysU0Cb2dWt9uh12sWqP4fjUelbsVbR1zCi00citFiosuKmIRs/d1yOW2W5B1NBBYET9pUx7BIlAzWjRysZLmUUpubtnTQceEosy4L4yMTbuyPsxN1ui+4zXQPOcDEyyGo/zooKhdzBjapneZ9ckWSLXOdxc+KyCxPpqecuyLC1LYjCXrOC7jb226TTsJ0up8xQakIfWYaBhVx+wsKOGR5z6N0rfwo+NCkchV2o99
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39830400003)(376002)(396003)(346002)(366004)(9686003)(316002)(6916009)(54906003)(6512007)(6666004)(478600001)(41300700001)(6506007)(26005)(6486002)(66946007)(86362001)(8936002)(66556008)(33716001)(66476007)(2906002)(8676002)(4326008)(44832011)(5660300002)(186003)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/7T+Icg0zc6Zsl33mXYL6qeqZ5FW5zrfoUnPFAW4Tx4mFNv8dHBHRJi/GI0t?=
 =?us-ascii?Q?7VESbkGZX6rNwHGz4aMjyntpSjlCWhHXuq2CyFUbvzm20ZWw5ChkWefDHVYA?=
 =?us-ascii?Q?/o+B48Tvi1D7oVhedXrXISPlEAQogr5QRb+h+ru0om+aDUoNN6JT9sOai/N2?=
 =?us-ascii?Q?LFZO9uiY1JffnqyTnGxv1Dv1isnKEqaqnb9vnK3DaRZJM+ChVwUmftkxrPPP?=
 =?us-ascii?Q?7kM5CG2QFdghdHX7F7uKSkIwSmIOeGNat8E1ZyoaMsFI+CJAGgEyxsGt8CBi?=
 =?us-ascii?Q?ftzFUZRPicRG8AYLMuNaEgdJFBFk021d7Lh8KMNUT06MEFxhdrIy7/ctWmmt?=
 =?us-ascii?Q?/iitWjkxktGdWmVMDaN2GN8Ha1oc+Rcld+ZafZ5BLBJ03ircJfMh7iYZ08oH?=
 =?us-ascii?Q?RMdiI9CFMiF6MwGqMJLLq24RgMbssPxP+YnkgHXOOeut1MPQ0d3hvIDf1Ujh?=
 =?us-ascii?Q?RxqA6BQWk8xiM1dqpGiJtI4RrQ7TpoV5uLbaFNKd3g2SjH9E/YyTpfADS2tG?=
 =?us-ascii?Q?qoOtllu4dAT3X2ZvExtFXL13cj1a0prRlw6RDnY3NOHB/6K+AOgqOdlIDBsr?=
 =?us-ascii?Q?B7qMn6PFMYYaidwD/l27e6foC3rmyYr1YTK0tBnZ473hMaunvx35TjXOg+U0?=
 =?us-ascii?Q?66iCTrVAS55gdBfXXJtARmpodt/U61oeThMNZECnxOsXwXljr3z2sstTN3eI?=
 =?us-ascii?Q?2WRybCHTOm0GnajsUVZRGA8rQQx6t10Tv/iq0VSsvqhS1bLdC67xBhMRaZBE?=
 =?us-ascii?Q?D5XuSnZ48y5HvJDz4OytHTAnMHCPDWNXww1/3KPl3cm8kynfTshrgPDzXEge?=
 =?us-ascii?Q?yybzu4ha5BZN7ZTY1C4VLUPXW6OWFE27kllwcTlPCh9LVhaJrvYaP6/2IW4W?=
 =?us-ascii?Q?Z5T/4yJNkpfYprTPQnpA1frjnbLwrTUqGRP8VmLlH6lwC9CKAJLbtD9ByIpq?=
 =?us-ascii?Q?Avg9A7NCAApJakvu/bGni6a1W1faeyDFkrcOeMFRJyxISRhsXFqQs5KiiuHV?=
 =?us-ascii?Q?4GdqG1ivhvoGp3FOxTUaqvn8nTji0Bn6eo9N83RZ2XwRxG6GxR6S3CS8Crjy?=
 =?us-ascii?Q?ytERGGCLcn1PUHs4hBUJYxj6Xx22hh9dt/dv0j/7HJ7MqphBTJomFttqFLls?=
 =?us-ascii?Q?byO49xb5QPqW7/+Wm+XqQjwIRTJCi4EH+qwVMqIVMfScbtZzqJdx4hikJ51I?=
 =?us-ascii?Q?e/5tUsm6VUu1KX4siFgVkvx/p21qmN88sQiMjg2aLHxtRK0z7Se0FWzs4k+y?=
 =?us-ascii?Q?yWpzNscInGnXBMPykS7ry5scWPVZqMjqz+cY2cTgTROn4jjFSzrxtBoJOetp?=
 =?us-ascii?Q?QehCLhYRPXKLB70dSuAxec380vioC3nDgS58NIQ0dO4p/Ixzt5x9Bwn/0wBj?=
 =?us-ascii?Q?NFZPf7nGHr2C4GPtKKYmux/8uQKvUZ7i1ho9srVByYz7d0KntwKk9ZRgyx1w?=
 =?us-ascii?Q?QK8hbYsI9tlcSJinNj+UjuRelu+3gnYMMToP8KVNyB0S77qWHYT1eXJRMErt?=
 =?us-ascii?Q?LOgLRkUncKkv+xXcWDhzWtTHLhxwDkCyBDIPaa6b8KHxqMhoF8+9c2TMbfO9?=
 =?us-ascii?Q?/TRA78tRxWv8JcUG7FloMx+3mlW9hcGEK2OCUOt/NVjcedBEHHl72BpLBlVc?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42445d89-672a-493f-aca0-08da7f1e2c37
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 00:27:59.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baq4CnTZGWBA3NZXuwgqkrFY4KDH/5tsE57yaDAI1AbwK67aCjmkyFwALhp9bmwCcPozG8tLU9bjBsFlVgnsfat37RKmKOJkb0biR5YJojM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2776
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 08:23:07PM +0200, Pavel Machek wrote:
> Hi!
> 
> > You might have already gotten this report, but I tried running v6.0-rc1
> > on my BeagleBone Black and it gets stuck right after "Starting kernel
> > ..." from U-Boot.
> > 
> > A bisect pointed me to commit 5a46079a9645 ("PM: domains: Delete usage
> > of driver_deferred_probe_check_state()").
> > 
> > I don't have much more detail than that, other than I'm using the
> > in-tree am335x-boneblack.dts device tree and I believe I had tested with
> > the multi-v7-defconfig for this verification. I'm happy to test anything
> > that might offer more information.
> 
> Well, standart next step is reverting 5a46079a9645 on top of v6.0-rc1,
> and if it starts working, either you get fix in your inbox, or you ask
> Linus to revert :-).

I was able to revert 5a46079a9645 and 9cbffc7a5956 and successfully boot
v6.0-rc1 on the Beaglebone Black.

I still don't know whether the root cause is the patch, or perhaps an
invalid boneblack DTS. I'll try and dig to get more info about what
might be failing. But I do think anyone using a Beaglebone will have
this issue, and I also think I'm not the only using the BBB.

> 
> Best regards,
> 								Pavel
> -- 
> People of Russia, stop Putin before his war on Ukraine escalates.


