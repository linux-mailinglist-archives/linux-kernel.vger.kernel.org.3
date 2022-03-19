Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E514DE4C6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 01:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiCSAPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 20:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiCSAPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 20:15:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2106.outbound.protection.outlook.com [40.107.244.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C56B1AAA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 17:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irgT5UD5lhHYnGSGRz5JCYA/QP9Jp0TEpNKrJOsWzdxTszhEkYJhzDu0b/jFlLhtS3BDHe6Ipi6143F/lTfEoH6x9RliQ+/3bnjBrJ5oguI1sgH8sEeXzXts41fqJJNcJO70cmR60olTR/tl4O4/aV262kyEaMFrDcBss4R8fk8H/MfQLP756iM5GeZS3DyGUTV9gsvREb1jTm5kdp7Q94M901NBPEFyxJDBBtjxYcvowJu2hAlapXoIpaJPJMki6gKoqtD6cfjQLSa9447pUrsdZ34ECBDpiA8xUxsVDNMEYpx7qpbem8hq3LNN+fiK/nc9jUa2MvcitM2ifSySeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bChZcUfjWxTsOMQxlF7+vi/ow8ydqnXNAZ8UyNgtEI=;
 b=b5Hc+lLI+VtBH7V+bWh7xOIqwvLsNrQ8VOEGa4Iu9roV0v9/z/OSfMzPPd2CW6tc4aCE+k4MIO5gpiYviizyfq/ZGaANh3F9pbwOONh5g6SLbrylwZOTbBM/RzMG0LS3VQYjIf80/jScKIEAr7U+Jd9++hh84bKYlgBQAV0mUGs0lCM69UxBZyrVtJzDtEeE9xeE8caz9mo+ZePk3yFOTC+ECQ5FJH4cEObuAm65xWhHCqmbXJTgLbi0LOtCETwP5Z5F5xTgqQS0KnLWyQ8I60oVrUM8aV45flapRpSFsaQCZ0+SQp6F1L//EOVwWUZCkrOjS0UsSH05rQfeSJyggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bChZcUfjWxTsOMQxlF7+vi/ow8ydqnXNAZ8UyNgtEI=;
 b=GjJIMyFH5Gy1SdMiGI3DZAmF+TQFKu54oIHO01PD2tecU1XLzRLEfHK35ZVnyBF3xmZmjZoRzEeYa2mFAdWt7QHP1DEk/ekrNh/vcpfdyB1skA41ng1S/pD2nEbQJUiq7aZF70FPqFzVkaDYk8wGbDRDiwfV0vcM90b9eQ7G7M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by MWHPR1001MB2221.namprd10.prod.outlook.com
 (2603:10b6:301:2c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 19 Mar
 2022 00:13:58 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5081.018; Sat, 19 Mar 2022
 00:13:58 +0000
Date:   Fri, 18 Mar 2022 17:13:55 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v1 0/2] Add more detailed regmap formatting capabilities
Message-ID: <20220319001355.GB929848@euler>
References: <20220313224524.399947-1-colin.foster@in-advantage.com>
 <164763707425.2336513.17062085835683897138.b4-ty@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164763707425.2336513.17062085835683897138.b4-ty@kernel.org>
X-ClientProxiedBy: MWHPR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:301:2::17) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dee18448-8ac1-4980-15d6-08da093d5ca9
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2221:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22211522AE07991217575547A4149@MWHPR1001MB2221.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MF4ukUS1o+9Ry5uDwB//JuEVoKwb4m9vUxKX7fb9+sUElWge4WmA9i+CfebIWPC8oIoDoVdGjMiRkCLB1rUCp6IlgR91diAeK4UBTbn8HsS/5iOItLO27GOFoQT6ZFyAPhJxfpN1BMqGu0g2FQJLD/2CXWwi3gkJPPrQ/ORRFqTUrsGJQMYJ29hFB4j1R0ypJJaw+OPqlpGLviCIeiHAA7Sr/6HDCoH7aW9CHznBSFrNaHcoKvH2MsSVX6IcUv3dCJWFxqxXKioZDw+cuTMEJUhz9ZacYa0GzDDJbXRAJ1pjttOjO0uAzh+yNhooQeQ/4A+mZv8oCAsuck6uaIuSJq5tgjH9FE/KykRvB/yIpZKa9vZ6HElXy/+vCCDXitgxynUw8jjVBogq+afWME52xfMR2sL8hLOTQE3KU1bLkRGrLXDb8WmQ7gGpid/HsGgiFx5zWdpooRCl+bNG17Fm/mMbdP4aBnADExEHNYxfmiZW68CrD08MkpEEb+RkJ1cByqiPj8Kb2F+/zmNIEKt7q3c60QFXsXYYIfbtiFqXOFV932ZM604znp0EYH41E1rhsjgGrarWfrgWE8MIRbw0CdVer4xwJY30MO2hZVdoBg70X8/valLQ+KYFI44nGnWNzq5S/eKQ3+eTKVCs4ergUAGjl7qA1gsyqIg7w+IJJi1jG0jq+rXQo8c/lTHTMQJAXY0Z+COv4+HIWqgP5PwO8X4fzudRhFRXB2habovjYG0uyTO1S2yiaCI0gbBwpqX4Ivmo6o9OURsr6srk1B4TdJnVaSqC90vEo5uJDtndo1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(39840400004)(346002)(366004)(136003)(396003)(376002)(66476007)(4326008)(86362001)(44832011)(2906002)(52116002)(9686003)(33656002)(6486002)(316002)(38350700002)(8676002)(66556008)(54906003)(66946007)(38100700002)(6916009)(6512007)(1076003)(83380400001)(5660300002)(508600001)(966005)(8936002)(26005)(6506007)(6666004)(33716001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qb7w24rLApevRi6XfMaDVEppzBJnocMqxykPdwjzxO8IsGsEmaggjEwKOr9L?=
 =?us-ascii?Q?tCWBvAPdo3AkaszF/BZG4NCv4oHcUVrPoVhdwiFUJZuLyjYZk4QOV4SfZOp8?=
 =?us-ascii?Q?6xMSJ6iy2MRfeO57O6zoNSzKcE9jEBKpYCOg0jpta/+YHtwaYhClsZlJhblv?=
 =?us-ascii?Q?o/FMAdNzVfjLJoEsHHusqVgiJ/pf5nh+A+PT6tzYiQxFtmIlnUS+5uz40nxv?=
 =?us-ascii?Q?9IJN62ITeqPAmtzDYllj+3iNoge8GZI0S/vag4ki6i8VmvUtNL9hLkIxbof1?=
 =?us-ascii?Q?5hop0/s8yrQgUcuMWIyuuHNjwY+Z436nOu33o7xWaZcnIXCLDashYaJfvbDv?=
 =?us-ascii?Q?x9enJRMiaJgSJpr9OQSgXNtjHMrJduisa4/BwMJoakvOoyyqAukTGh/KM44i?=
 =?us-ascii?Q?V1nozg69g36tyAzArnr8Vruw9qbUxI9Yw2+WyagsUzUcG7eAXdaiBtOjjE0F?=
 =?us-ascii?Q?1KKAn+bDyvjwzu5Bx2lpwke3kOSnPzKEtRZm8cbFLSBk8Cl+VjYsJxhOyedk?=
 =?us-ascii?Q?ceAEmaGr1K6Nr+0S5zRrPkfRQzuKOKjY66D2EIOXwFJNRBwO/EX0nXKLUzzm?=
 =?us-ascii?Q?3xLmi19OxxxxD+UkWjUj98yt7YBmQoFgG0v9sulRdCsugfw5BlIhRpxuaj+Y?=
 =?us-ascii?Q?0wS3rd1GS3H8a91AfTdV3rKyFepRP2olZ94SCzToNz3w3vROX5SrT12AFr7c?=
 =?us-ascii?Q?MwsmDOygwP+qQibxg+ZUpkWWq3+PkaECg7YkdDeDq95g7POWVq9P5A72PqY9?=
 =?us-ascii?Q?cYMusBFcDcN1pXeDQtIu79V6lcxg3olNn9xl4ERScNWLrt3sepq1cg0k6qGD?=
 =?us-ascii?Q?WUms5PEnIZoZ7YLCR+rUA2mCDPAcKtxQ73LIA88LQfgVwTLzr8Rh0egnI1hK?=
 =?us-ascii?Q?udjoCADASSdWTm1vnMizj7njj4bOwY9DEesbRh7oiaf576UoMsNboDqygCRj?=
 =?us-ascii?Q?RnzsawAA6Q5bkkwa/ayHokCUL8PKn+k60lFM/5tp42WLaUu+4T4h0870aUr7?=
 =?us-ascii?Q?JIB/bYkbE5ysNEr94CYhXuCqNzEZjJB0F83XpefPRLmJqRhAM1+ssk75Ymj+?=
 =?us-ascii?Q?A2zMztHrG8h33zZNJABJJ43GJkho0PbRAsorEU2ehjhvTHqCMYkhqD32ruPu?=
 =?us-ascii?Q?7c2TWqJmXsRMFqaIjhRCgFdLDHJQOtiUiHDLzs50mH4XU4Sz0d41Ft+CuwW9?=
 =?us-ascii?Q?OXn2PdvTsx1rIyA+g4nV/PVHjn6QFvrJBShk4CmBhr8reZK+fk1TOHeh54Vk?=
 =?us-ascii?Q?xJWVzTkNIhEoxNaS8h7B1kWbcHv2JCS6nt4IocsNpkKIS9kynZx95zY2R/wy?=
 =?us-ascii?Q?iSC0itIW3P2N2vgQtAMF5D0IaOEH4cmpdCP7pz4fU0UXVrBaYUvnENVmibgP?=
 =?us-ascii?Q?6OVBe6WC/4mYt/h+PLfstntEhN4a1fEg0vXi7DW5wWpA50kvVzbjcCz1KqwN?=
 =?us-ascii?Q?vHfjGDEjGRaGIScJKKMv6Nln404yD3K+oS3bL/190FvD7dKVlHMAYxggzFG7?=
 =?us-ascii?Q?9v2PIYRtLwz++lE=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee18448-8ac1-4980-15d6-08da093d5ca9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 00:13:58.0305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCmyB9UbdNYQPZq/juq5ngOORWMlSEOlkWcOiDfXn2JX6/VO42sitdyEz/70rV+f4aznjwT9bsmMnmgL7lLPGxLQiQbXPO5iM1eDIHhrvxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2221
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 08:57:54PM +0000, Mark Brown wrote:
> On Sun, 13 Mar 2022 15:45:22 -0700, Colin Foster wrote:
> > The Ocelot chips (specifically the VSC7512 I'm using) have a method of
> > accessing their registers internally via MMIO, or externally via SPI.
> > When accessing these registers externally, a 24-bit address is used and
> > downshifted by two. The manual references it as:
> > 
> > SI_ADDR = (REG_ADDR & 0x00FFFFFF) >> 2;
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
> 
> Thanks!
> 
> [1/2] regmap: add configurable downshift for addresses
>       commit: 86fc59ef818beb0e1945d17f8e734898baba7e4e
> [2/2] regmap: allow a defined reg_base to be added to every address
>       commit: 0074f3f2b1e43d3cedd97e47fb6980db6d2ba79e
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

Thanks Mark! Based on your initial feedback I wasn't expecting patch 1
to be applied and was expecting to have to work around it (which could
be done) but I don't think patch 2 could have been reasonably worked
around. Hopefully these are patches that nobody notices... unless they
need them too :-D

> 
> Thanks,
> Mark
