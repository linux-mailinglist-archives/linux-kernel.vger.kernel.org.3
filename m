Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF015A9A7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiIAOfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiIAOe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:34:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D5C11A14;
        Thu,  1 Sep 2022 07:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+WPS5u5aI06/Mvq46AlvcF6A0rD+QOOAFGbkFVxwc3MKsgExaTERKfFZNxonml3LtW74m5gwPnxVXN4jU/+hkFAoS70JQHgrlyBYwRwtMIx7BcVJ7uKDOVF6Np77UGhevqt4PUeXcQa2u8DBEP2XCcIyBNwqDAvllXpeVx/1nWjlBZGRxzzVd6qsU9D0CFFYWUdUB8Zx3U2ZL3WAMCyY84yOcy6tQtwLGsgOnujx2VGW+Emq5XDAJUDk3Ma4LSAjvyvX1UxWdxdQb0y2ku3aLld52Mf2Bwq/Dm0jO6e5McrfHAjg/Ee80Fu+eXOKq5xc4sq7J02mKl7rnNUSJJu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ECNy1jbrk1WJs/JepucBIDx4S83zjefsvWJvW5pbgo=;
 b=eLPOvIERf1EbZUxTfX7o50WIkSzJSmD/NIc//KYayW2r4VnYWkG/KiLbqA0qkj4njCSeHRB+n+w19TvbvFIa8JN7wof9DqVNGDLtP3ojGQCdXXjUpLqhqz8S79MWIH9JwqAT+dFv66j8hNGEvhacfAZ2B8b1r729/26v3kZo8MpjXdmOcDNG+SRUFfQF0E6xzKxtV1Hw5F5EAsOf3L66xLFq/NFL8BMntKatdi6tqOlNHrfKJ4gdgIAfWzmWg/Ldk+8WkxED3KDnHKqll+5hhUiYtRp+l1HSgkIiLUzffqiai1uNlyirkcZSA5ZedrtfVvs5P25oiV3a44VxGSDffA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ECNy1jbrk1WJs/JepucBIDx4S83zjefsvWJvW5pbgo=;
 b=M0YisIFYJfKX3EOkJRVwhNEy0eroKJa/6FvudhPwfPyahgXYs3/5Ap5GQvSh/KIunGSgoxLTQbXWKWvSiALmsvYol0IIkk2SDy8HK06PWL41BWYFqikBGISEw5nAxa4nuoTomlC+NdMWoWTh+dEcZQoxm9Ad63+1XCrqh0bjMvjeWQT0wtnRyWazvid6YbP7FcJEspzhQODxG3pXPldvxwkcS/jris/KSoS1wFTFj+5LrkSRN6Uj6Dz3BCIyo03IL3UO0MWv+bWRnqOHMLtPDO0PfQs8pEf9CI3OUhimcVAC/lh9gMPM2hawchz+sZFCAen0dU71X6UISQw2FiROGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 14:34:56 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 14:34:56 +0000
Date:   Thu, 1 Sep 2022 11:34:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, borntraeger@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iommu/s390: Fix race with release_device ops
Message-ID: <YxDDD2DF9KFDQ+Yk@nvidia.com>
References: <20220831201236.77595-1-mjrosato@linux.ibm.com>
 <20220831201236.77595-2-mjrosato@linux.ibm.com>
 <9887e2f4-3f3d-137d-dad7-59dab5f98aab@linux.ibm.com>
 <52d3fe0b86bdc04fdbf3aae095b2f71f4ea12d44.camel@linux.ibm.com>
 <e01e6ef2-ba45-7433-5fe4-a6806dac3af9@arm.com>
 <8b561ad3023fc146ba0779cbd8fff14d6409c6aa.camel@linux.ibm.com>
 <3e402947-61f9-b7e8-1414-fde006257b6f@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e402947-61f9-b7e8-1414-fde006257b6f@arm.com>
X-ClientProxiedBy: BL1PR13CA0308.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7557f5ec-28f9-441d-ff58-08da8c2723b8
X-MS-TrafficTypeDiagnostic: SA1PR12MB7126:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YQWxhKg7oSFUrk7Jzg3zlY11daqV7CT1c6GDHDdh/KTZzrAuwBlHUXiPxfiHxhnqL+y6Yd5SJrU+e1f4pZt8Yc/D08MU+RTswGDiJGNrADWTvBRIJYxYeZCtRC/2NYYegmyR02/QIXBIyWGmgX/5eGWEckLH6U4E3CNo8iyk0E5UmmSCuUlK3wMrrSndqnSDrej/BgqPWw7AUPXbdyV7AUNH/Eb3eEiqTNTtlOMlktzEP7Uv1eysf1riU7Gt6PHAyI1ynGlHrMOQSClICoS5HpXvOX22CK70NuNybRHH13v/kIWH2zkeuKa2lac0WHU+PCpyARtl46qQakZdMEw54tJCLUOwJRJSAl7AwBBFA+Ueann9+2xF7EjSd0SQo0UFp30mitcsIRFlIeV24iJqC0XeO8bCWa37E1C4QbyB41I+hwpwRqt9IZm3EOJmUY3oorFyRkb6YKQ/bwZ5HDLnka4iBlJtITU/pT12HC6q3HWUZW2oB9rcImglaSo3FuYo6i9/cAqlQSgi9I1LVwhjEdczzxUyATl4cYVJT+m8mfQil8tJ+7gHNkNKqn62R2UiCdcFmZeR6Rkwl7/REXFGiMYxjYTc1OtmroolrqbSzTwvnX1GT3arhPAG+OLDKxyQBZUDxtUfXtCGdwx0C1lpq+cDiqExzGKAXLMvYtDJPzG2lF6tpzH8DnAlDVJIYpLQWNJ3A+yompYw6EAwYXnZ4MlZ5tKWJzDFVL8YDodnIRLddnnZGDyyunYO5dZeDpr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(6512007)(83380400001)(186003)(6506007)(26005)(7416002)(2616005)(38100700002)(2906002)(316002)(8936002)(36756003)(4744005)(54906003)(86362001)(4326008)(41300700001)(478600001)(66556008)(6916009)(8676002)(6486002)(66476007)(5660300002)(66946007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dDZlEvXRDsKCXFP6ftkEMdAEK+kxfnDJbNIoja/hsDWxe++HomRyXLZDGynQ?=
 =?us-ascii?Q?90F4DZsuVeAjEd30F0G2hfdwX5MzDTdjG2wu6ToJBKoobDYrOHXLGYeqayBz?=
 =?us-ascii?Q?naGX9K0Mw4V2aK9iBrhXvwLxl7AZRce+kPBqc6+ILa2W5zqRpElu37p8/rmI?=
 =?us-ascii?Q?cUWTgfZvaxTH8/IYmQeTqb0KK6ZfSgbWTnwNSppsyKlkfr3KFc+DzbmKwAzL?=
 =?us-ascii?Q?VlRu8Kfp7ynUg2zYP77MIjfm0/QWOAzEJrWfB+Z90tasUH8Qv4jwfVNnufh8?=
 =?us-ascii?Q?vai7UP6CE2SiwsvRW/l65iemVvl8GLc/oMLLTsN0xfACiwe+/wYHxBJps1Fh?=
 =?us-ascii?Q?SvNK6/Fy7+E6hBC00kA46Abav9HgNUX+fbPWJgfUpwqNUM/eKqC4L6PDRoFD?=
 =?us-ascii?Q?XqsbxCjK50udnR+qHI65oM6/mNrJptLfH1r9hf+m9YPJWeB/TAZpd1Ak9RzS?=
 =?us-ascii?Q?3Ou/R6Gpwgphkn9/CZuGKrQ+yvckFy/MQe0b0M5cwFlXly/6JV0Xj3pw4Xw7?=
 =?us-ascii?Q?rmoG0LERLwF2x2KHcZpnl2YpKQB3IwPGcXl0hh0mHXfPypkQtQ6aOZdFzWAt?=
 =?us-ascii?Q?K+678ORiUT/dNx8QyeFk693U8QMBUYSo3rXVt0LT2kyXhtB4xqoSxEQKLg+j?=
 =?us-ascii?Q?3NEA4+4Bapk0OA0V6w5OMLh4LDTkDCVjddCl0IvmKMmBmAkkkNj6mhldwU/8?=
 =?us-ascii?Q?2KnPfHktxF6yWZXYcQ18u3Wsc3WLHWlXcaGButB5AsrWc3gvEgNccZpiAsZe?=
 =?us-ascii?Q?FdQQZ2IwhgK0D1dAYOiHa+cUSKsBhG+Wj4zuf755LT/QcW2RRjL6wTX3Q91p?=
 =?us-ascii?Q?T3ALC1jYxHeIZLn5JRyMlNcZS7B6Qk+Jl6eqjgEASyYvKB7uqK1+uSgmAKYI?=
 =?us-ascii?Q?kVfZjiOOlC48AcsLDMciKSpasvtvmFf1623ndtYNzmFcJgE6nQ4IsGh+sPrN?=
 =?us-ascii?Q?dJyUNne2dDa2UCNTs7LOu8L12fh+mf0GeHt1iTXx/ikaACvtSg4ZqqMxHvn4?=
 =?us-ascii?Q?U9J1p296rr+k0Ootvv7M3HcI5TvkUAcLJAvRoC4rk4EygYf3C6bghVYVmmMT?=
 =?us-ascii?Q?eRZSznfSq0ZSB/UZhb9WiORZSC2u4cuWVzoccKk6zqhvyU0pmDerdNCv2O57?=
 =?us-ascii?Q?ntGjKzXpDHhhf9eRihsqcd9R+f8XhAOSQNsxeOo+EPe6TFq1M+nvPnl5C1li?=
 =?us-ascii?Q?jcDJFNtgd4kksBc/GViKnJRHfBffnxVcY87LyYCGzwqMCop34XIWt0IjRTHf?=
 =?us-ascii?Q?TZSohcaSW6zW+zh9PypJD1IrKCcEbVx7wTi3CIjJha03Bnp1cOAb3Q/Hp/Da?=
 =?us-ascii?Q?dEjitB1LKiWpqQhd6B9WUrdaE1QDSlr7kTFUynexhFkqS0qGV/Z5fyrIaR69?=
 =?us-ascii?Q?Or1i4OK38kADauNthPLB95Y0Z/G270h4hm4Co1AiuH6ASVSMUHpxnW0rkQgO?=
 =?us-ascii?Q?WCfYt8uXXgXwefORzt6e6KGKNEKczvT2crvSnR2rM37J0t++pRF9NKjsdsGp?=
 =?us-ascii?Q?dkuoWeYyJThuxvAzbNo8z3i7PRHoXkGGwI0TDrlS8N6S/SiREl4YaWceD/VE?=
 =?us-ascii?Q?XSLVcKxTSVAuNntZl4JSFDJyV0qKq7KUU43xQeKO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7557f5ec-28f9-441d-ff58-08da8c2723b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 14:34:55.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lZ7Xn0Cz6+CcOxMO36wpDVtxlhWg0btKw0jeDHOB0N5AIQPGyUIkoz1XrKk+KFN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 03:29:16PM +0100, Robin Murphy wrote:

> Right, the next step would be to bridge that gap to iommu-dma to dump the
> flush queue when IOVA allocation failure implies we've reached the
> "rollover" point, and perhaps not use the timer at all. By that point a
> dedicated domain type, or at least some definite internal flag, for this
> alternate behaviour seems like the logical way to go.

At least on this direction, I've been thinking it would be nice to
replace the domain type _FQ with a flag inside the domain, maybe the
ops, saying how the domain wants the common DMA API to operate. If it
wants FQ mode or other tuning parameters

Jason
