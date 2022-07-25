Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA857FF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbiGYMzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiGYMzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:55:14 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10139.outbound.protection.outlook.com [40.107.1.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C9F2644;
        Mon, 25 Jul 2022 05:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEnzi5HBBXzxShinqbmL3GjlLowhIQ+sxywnYyyg0B6sY8DW6DwGuj/CQOIJUgBPVE3Fs0GyjamURXRDyYkcsE5iZctn78fr8Uoa0s7HBLgKRmtRoHRkTpuPVV+ejJgNQLWEjsezXNdptw1Je+DgAgbdxyic5RY7nljz8Bsp93XLEwAOq9ohd1kOOXAIyoCfSDI3vRYDxt6mrvYS4LDWla4PRV4dnpjL4DLgFwjpWW0RMpBfHUYPR0tEuWQNZMM4+3BsPTvmLXrHnn+KCAzYgPOHhc+EppwDIzOrTyFIsBIaINHxKgTlwgLa2n5fACFgJ0H8rI6iC5u5+o1fytGXBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTtvwJGbMHjZ9h6MsKY+NI7KsJgz8BGDZofxihDri4A=;
 b=iV3iSTNnBIGn/0NkF85TDrzHuflcsZg14jx6hC0u+Vi1XKdALy1MfuX7nyOu4cmvtx8qddV7ORlYx6w4jrfo6lRWH7iXKLhwBRaSmaiBoqZxNKdHxHIhkNhBa0dNvzgPMsE8K1RQXF+So/GcFUBjbz4NNHGQoYk2mHSs7hN5DZ+syhvp+IP2hww5/R1Nsd43k9n/MU6Xz5WiZJ0YwF7cR3pe9QuafMZkqzfARsr6AcUeNu/6kznK9E60Yxc5CAX7vdDrMzcau3whQXvGutwlgZSmqQ6WfCXmatm6h56KLHL3OHfNZKdfnSlVahWiSmDfVDapivYbxkTE9CmPwV7+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTtvwJGbMHjZ9h6MsKY+NI7KsJgz8BGDZofxihDri4A=;
 b=dfp+m3LGCzLXadhAruuY8afOxiK3q1s7/ZJ/dWBPx+p+RzBaPDicZdnM06IQEmsewyoutgY7bw371ZUgLzf3bskZ1d5VlzWIjLLralnWZrULX01q62COkdBHnEDDt2FCuk4Xo3BT3wd83nbsuV6WXlWlDJzBuBcxq/ulVwPK+zw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM5P190MB0563.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:1c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 12:55:09 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::5488:868f:fe1e:ab76%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 12:55:08 +0000
Date:   Mon, 25 Jul 2022 15:55:05 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, Noam <lnoam@marvell.com>
Subject: Re: [PATCH 4/7] spi: a3700: support BE for AC5 SPI driver
Message-ID: <20220725125505.GB5304@plvision.eu>
References: <20220723102237.10281-1-vadym.kochan@plvision.eu>
 <YtxL2kjJhJ6IhVDA@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtxL2kjJhJ6IhVDA@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6b4274-2946-4770-b71b-08da6e3ce752
X-MS-TrafficTypeDiagnostic: AM5P190MB0563:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMsJ7HRLc5a5EyyIKL1PjCFrxHqzvpxkHDoX8VBEc+2ou5AF04EcleapfRXLxgHwf0wwwjI0FrXtRMhynCjtv+EX8qRXGcw+4+NxgCsrHoQPJJ+EpNry4z/4z4O8VDE0fIxG/72IFqdlJtu7iC3YA8Z7m8fUULz/1rYCDpXqR/HXoFbYGFXBxo0Wo60R+3AkCLNVEYs62kFRTnsad9FVU45YX2m2+IzID4ooHX/9ig+ekDuUjtbpRpNthYohOxPHwZf0A/ejmmb97/Iz74BRsjYx2gYhyhNtQzOrEel+nBvHkrCz46Cse2JklEcbT6BU5mcM4ERB1lZaYIllpg9Aht1eVjTFtUzd0ACg9HT1j0Xtmn0j33PxzjCsxOZl6okUEH7v2799urwZkQyZ6sPUEP7N6K6sdkGwxAlp8MdvIaB2qpot3FNchK5Ce2U97jCb5J5Jygeg28qZh27ggsy73ypn1jbxQ+7hT9FmWEYG3JAolRNwVscPqr2rNdSh3Tots7tHGjJlDEivAxRj0+Sz9woVKhos899uN7qBIOXTpvClgLkg5Uy2fuIxwVI4fcHwUX6thidqezqKv0vZ/k+ARzR+96X7ghWJs8XAsgI1Ho8YTDQuKBQsPbfq3QpO1CgtO9HoYgNgIXZMia7BgRZUmgAMWjxbyTjfbzvYOhg9GoGnDQ1InG/Gpim/814XZpCt0HgzXuZvS1NOKXpPxkWO5ge023NkAXxC2nw/1q5Y1tXqgDn0hnIMkK2x5jkHoxyT1WQc2o8TiAwgjoLSJdqr/MgquFeh7aYaQHn7W9gQtS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39830400003)(396003)(346002)(316002)(6916009)(186003)(5660300002)(4326008)(6666004)(66556008)(52116002)(41300700001)(8676002)(1076003)(38350700002)(66946007)(6512007)(26005)(38100700002)(6486002)(33656002)(2616005)(54906003)(2906002)(36756003)(8936002)(6506007)(44832011)(66476007)(86362001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EsOR+yBvm5QRzETb9p3QqFDXaEVh9fkW4WPKVSDIzDmbmZgpKOlEELlqG2f9?=
 =?us-ascii?Q?e/BcCvV3IA9owmzAnBStVoOF4r7O4UNKJXmtiD/fOsqlhSgd7YFHKbI4OHtS?=
 =?us-ascii?Q?poTryRn4PsxrL+RouzN29wuiMpCUkzhIYrBh8D2KZdm2x45uCGz2LJGYWOQe?=
 =?us-ascii?Q?MQM8hC5gFV0d3rxW8fP6zvF6WNJwzQElaZzlU0T2zaZp5Rj/mu+85rGQjIFO?=
 =?us-ascii?Q?6zj8DHl7r/xiG+11HZEjWO6c8ghNMupNswd7kb2A+EIf/oyfY85/iLEeGcgc?=
 =?us-ascii?Q?CPIjyj1heRT5xuPGU/QrjYNp4QqFU0vu0shk0zdPsysUt7StV/XOPthgX0/H?=
 =?us-ascii?Q?d0FQaNjijEbt/OcrhpPqDr6vtwjMSl5Y/lSQhXufwvigh0Y5XuRbupJbob04?=
 =?us-ascii?Q?LE2N4KXSr/ykGVZnKw64/4RBXsjixgyL4W6o1h12Dl76LNCVZd8XNvg+fRXC?=
 =?us-ascii?Q?qw5bh5cwi23TXiw0gP9VQ/1fPtjgbnHFJ9FT4ULTHHm+RoTzq5jRiYAH8GO7?=
 =?us-ascii?Q?xVSodhBFANXXoD+4cM7LDr2O/SGm00/sACMwZmnkdcWX3lthDINA0o644D+x?=
 =?us-ascii?Q?0HZhQzPVRGydV0xB5F81nMfQN2gO96BlK/H17SiTga7R3CP38oy1GoCI17ex?=
 =?us-ascii?Q?hSOKTKd7umzUZIZ281bS2emvNmy+nOHSb2HNf6RazzBhhof/yQSJGlpRQ0SR?=
 =?us-ascii?Q?MeQC34OHef+1hTBbUSP9oVz2xrzdUwT3O2c9BsyNUhmUpewHz5KySpMeKJWE?=
 =?us-ascii?Q?5jrgYfJgJBTCZHY+baFAAr9wyu7xglhvnvaBzL5ewzxu1MMoT1wVa3PE2JSA?=
 =?us-ascii?Q?xJa2DpY8MwUEvZ2plG4P3l/1OwAMkp45SDYIkuJtRAcdVIKMk1MgHvXtC3ju?=
 =?us-ascii?Q?ktwNB9e42XN6UoVfkdzMbVjFiO0GTxVGBRdFI6Ob1iDv3cBmwWngcqPvyYWn?=
 =?us-ascii?Q?XEMDuE+KnX5jwTn/0u5iA0JXcbazvtiiNsJMPSloavmRGnLVYzuWmDnH98yI?=
 =?us-ascii?Q?1nnu+xWTFdNaaOH68IZUpxTfGJJELffrmCI41bdHasufvkh1sR8Js0Qqk1TB?=
 =?us-ascii?Q?1HEG6BFfsIx5WYrA3D965wt+hJoM1dLWLuF407JOjYBqW+B4yOMAXZOlYohc?=
 =?us-ascii?Q?asIghLYBdVZQhhbwWpliCk/Mmquln/4st56zeWRxQckh6dTvZ5eh08OFp9ty?=
 =?us-ascii?Q?ukNxSAaCwI3MdaiRELFkx3jqeGLW+G6tEjsS1Xo4ZlEjqObrnMTJBe6L8QWD?=
 =?us-ascii?Q?XJrgtz916jlN4k7bJy3TVDCwjb8bH+yzZJ/n+yX0f2R4BaA8fNG+sLHeSsyJ?=
 =?us-ascii?Q?tJdzPzO9XeUiznl/XEOURDfnHlDn6lwEZP0mAE49SqxqWcgimC3TuG/BUeJD?=
 =?us-ascii?Q?mJUfAqKNw1u0lbVb+9vMMd9Sr8ReBIuq8PWibTCDRjvQ08Ht1oljs8HA2UqL?=
 =?us-ascii?Q?XQxK8FothUmWRuelPpJ+f8fQlrPeKaG7SyPcEpUoSLAWOffnUpfE0r3ZuokU?=
 =?us-ascii?Q?dk0DrootSam+vlcEObSfu8UY3Jb/jo+CQ/zAJvGgs9krDVtFJtGBnv27aJin?=
 =?us-ascii?Q?uCb+/y/gRTn3a2p+8Vips9VazmXsL2SDCLF8BM01cYrb8etguBm2+TRWdG9V?=
 =?us-ascii?Q?yw=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6b4274-2946-4770-b71b-08da6e3ce752
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 12:55:08.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wwogK5tZMIPKINED8VUY4Bplc7vUGGR9u40gP5qHmlnZfPEuyr7/TRzoybt9vMPfRqnCAtbjL7I/YROPjAOOztmehC0p1TeIWZyy5flK+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P190MB0563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Sat, Jul 23, 2022 at 08:28:26PM +0100, Mark Brown wrote:
> On Sat, Jul 23, 2022 at 01:22:37PM +0300, Vadym Kochan wrote:
> > From: Noam <lnoam@marvell.com>
> > 
> > Tested-by: Raz Adashi <raza@marvell.com>
> > Reviewed-by: Raz Adashi <raza@marvell.com>
> > Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> > ---
> 
> There's no signoff here from Noam or anyone else at Marvell...
> 

Will fix it.

> You've not copied me on the rest of the series so I've no idea what's
> going on with dependencies.  When sending a patch series it is important
> to ensure that all the various maintainers understand what the
> relationship between the patches as the expecation is that there will be
> interdependencies.  Either copy everyone on the whole series or at least
> copy them on the cover letter and explain what's going on.  If there are
> no strong interdependencies then it's generally simplest to just send
> the patches separately to avoid any possible confusion.

Sorry, I picked it from locally generated series, I will send it as
a separate patch because there are no dependencies on other patches.

Thanks!

