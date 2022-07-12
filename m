Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1757570C33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiGKUx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGKUxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:53:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2113.outbound.protection.outlook.com [40.107.93.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1A42BB15;
        Mon, 11 Jul 2022 13:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWpPqWBs9mTZg3SvMaNkp01k4/XiDcFTboQRdP/N05OIb0Kek6URyZDvxjV13pZSrlTCZB0oWOFb2X4dUHxhKze8yOdlEibNnolbKdUSvcEzjjqY0vQ6EcyVy/rmWb0KFKzJ9Rm9D3I1fowXKJhM0DLOtdGzloKeqxmGSAGJvaq5JgXuh4l0c63rLsBfSTkHgalX2Fc3KLSdJDVj0Cx+thP0K+H3zfrSlht4ICdYy43QbWAcs7aNU6YzUyZdXN/gr6Wax2UomtW0V0/m8TeBDMkYrVyy5yK9UPM9fQ0FdzUeaVlcajfjmmVznpQI7vKLh249oDph06gyE6Oam2Lp/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OATIkOerd69rra8pkpf2mDh6rNGzn+PxnkjD+XdTVg=;
 b=Fu+AI6epJusJUWXBBjTuENMCjwHx0Li+NRv6s3RdvkY4Do3kjtEuGz1jx+f//vxMj5BhvmQCfyKwSrDbH0wQ5Euxy+eqD0JWCGUlUdPHvlYiNXcJFbjqXXVpAeSMIO2/mC8CzqY9jgJWTWYaSFxfJ2+n2iNZehTJl5JZweBDvTaR0v1tcuMkqFbIfaBPdzPDUvjbX40K6dPh6JOUagqLJbVJLKbLFUldeUK7LfaHC99dIFyH3qc+GE/F1s3cHRvbmE3/Di3XRs8HydQ/Yo9iijH1UEEP+i6th7jisbd9NlCJOrwX04GZ7vNiz2Cvr+Bg27ePiMVhDZRvPg0LdNhocQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OATIkOerd69rra8pkpf2mDh6rNGzn+PxnkjD+XdTVg=;
 b=UO1qgMUUuMvdm3M/F+jn8SmjNywZqlZNT91EsX/eChPaa9yCbwY4EdpeHbLHpHtbwWgKWDpOS90i2F/6B9qEnqkSXRMDpDmPZ89Kab/LPohqsLrX+LjWCTPwVs3hsB3lo3wdr5GbVnpiF8AOVKm34U+V2IVVi1hfRKkHeXIa0Qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by DM6PR10MB2874.namprd10.prod.outlook.com
 (2603:10b6:5:64::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Mon, 11 Jul
 2022 20:53:51 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::712f:6916:3431:e74e%6]) with mapi id 15.20.5395.020; Mon, 11 Jul 2022
 20:53:50 +0000
Date:   Mon, 11 Jul 2022 20:53:42 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, kavyasree.kotagiri@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com, michael@walle.cc,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 1/2] pinctrl: ocelot: Fix pincfg for lan966x
Message-ID: <YszwRgsrcgmY789d@COLIN-DESKTOP1.localdomain>
References: <20220711192113.3522664-1-horatiu.vultur@microchip.com>
 <20220711192113.3522664-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711192113.3522664-2-horatiu.vultur@microchip.com>
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f0916c6-ffd2-4634-fb49-08da637f7548
X-MS-TrafficTypeDiagnostic: DM6PR10MB2874:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w4HBrwTktbbmClIcPc4X14NuLE32LwY2sCLkYy85rX9QwgeTGayBXbAElUoBuLyr2QSiM3e8MfjMszBURcoXEGefViyiqQOIP5WN/nPErW4+kEm17u63lr9cgyqQYSJZHp48WEfSndS8rYs5D645gjeezmaqx+Nbnsabd62cfl4CyZS0czhH4Y/A8cW53SpgZja6pbP9qRTreFbo1Kadf+x0o9KlNXZ9XOHsmZ+1D9iTIZ1h8axyFM/hN4wAb3+Qo2JihDM0w1DGVffO2fpccw1VDdYCpee2b+BiliMmXCwLlabmyhoZUL+BOJhV+aBMsj/tAyUUToY94n6yoGIlHJY7TaeIO6I+1sVGZ8DetMwr/OZIi+8YcmnVSpyUIFTQwINiDQXLGA6z6I8LVjCcfFb+YyXq4xEPtbM2TGA4YNYcGo77ISOlki99CqfBLfObviH/mpIYQOJCcMQ7icdmN4qHbeFbKNCZYNLLxapRTOkHdf1sxhfyUdJa8I6wOd5WV++oK+RpQNxBxbuh7iR+9EtkGPFq61EVrjLZnDkimvFBdVDZBGcKLSlOQbUgi/MBfV4n8dISyvxRm0RnDHzU3fVQ5NeVk9vsQbzP+w3MIfUk5pxx6S00J4MHNUurVi63mL5WZW+lSYSSZDUiwf8EyyX13srjXvH/3or4iL21ELjkLMDQ0GteiZjiLK+gKpApYxEiF4PbunREDm29M/a2BzdfknSL5iQnEpuujxdeyGlMQgaerns5hPBEW/wfcCtYNXZwGx+Y1zWohn95VI63Cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39830400003)(396003)(136003)(346002)(376002)(38100700002)(2906002)(478600001)(44832011)(6916009)(6486002)(7416002)(186003)(316002)(5660300002)(9686003)(41300700001)(6666004)(8936002)(6512007)(66476007)(8676002)(66946007)(66556008)(4326008)(26005)(86362001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pebWjV+bXWxB6p0iUI9gaj9HMET610FTgr2mj7N0//YWC2zto4wL18flu15S?=
 =?us-ascii?Q?aJAy9H6LXAO0xyUkxwrt3OxYWDg98gmEUGlFdJoyW1MlaKrboEI12yxSI+2o?=
 =?us-ascii?Q?RQgT5RvCCGzfzyEC4hAhwrR/KFg2CAHDMSeQ2x5zyhvsjzmGgb5aJwx3QzKn?=
 =?us-ascii?Q?ZkR+GbNK6Ox567I1RWokj1JB/WmUxRxLJvYPG1YRo5to66gActjMxM/0+Unu?=
 =?us-ascii?Q?Oz0E1nKky+WELqe67YfcT21kT67ZSXdzp2F5c3O8AuluxnucR+kKnzfl59v4?=
 =?us-ascii?Q?i8xG5xvatTve86ENNzGVIU7OUuG6WEYE0yWwYw3acfTkEmvMzoHCt9yWrWOP?=
 =?us-ascii?Q?TrzmUCi9PT/kigkl5+kbmdCv/sXTPf3mwZjkIz/drfQhXP5UJVp7cvl5Nx5b?=
 =?us-ascii?Q?8BuZy9sUfM9PFpQRWuy+LvyGA7Ou8qTN2nLye3ozaIOI6O183qvDAiFYdJTg?=
 =?us-ascii?Q?NP7EUIHRZYFMzlj0qv2K9qJzdTbqzT6aJ5Spf1iDLwMXCGw3hpRIMMdZvdGS?=
 =?us-ascii?Q?vqkaFXv6fgE3/neOnGFPCROZD2DQSvpJqbV/2QhyoqPekDKdPw4R8a69XiZO?=
 =?us-ascii?Q?XkX4yeKu0clgoI+MTYDqv7nyeb26mMnfq8JJTWwOX9g6v+nVZzlwIe16G7BR?=
 =?us-ascii?Q?Qgi+p5HCsX6oBu1wKMcbANLw+DrR/aTzRwGSsAkpLVYJj6vVbT+NejNKkVfy?=
 =?us-ascii?Q?PtJa8vy7yHvJxdHU93i3vBt4IOyB2XVkLzhrdFz81+Q1uKxAwgRru22aNkmC?=
 =?us-ascii?Q?Nf95kiTobZlziIpEaHYnYKwDjiRAl8P9nxY1R6En/AoXfcWaC3KKq7KSzlrZ?=
 =?us-ascii?Q?+qfeK+c94fPb/gvDUh25GgS8kG9KwZpI6zC4lN/OxyWm7Sy4oOSV0Gs0UBKo?=
 =?us-ascii?Q?ZBPeCVQNY2TjrRZI62YsAljThGjDGw/RrIqTcbTivB4NX1woSSBU+XicdAS0?=
 =?us-ascii?Q?GVZ9hUssga5XUOxGdSYk53F21Syefb/Bhl5Rc6CBzEJ+/SUhSIwQkeBWMJt/?=
 =?us-ascii?Q?CPumxeFLi0zvyMriW9xzuviwRywz+sx546rF1HL5K7/EewVeChXi7lQrR7Rc?=
 =?us-ascii?Q?XBRF1uegWpEiwl3JKNXLSFSHkfoOsjVMoHYRZDCJ0zQ49ZtA9HC0nYzrq2y3?=
 =?us-ascii?Q?I1r64bXNemrRGxnew0YLJhrfKGwvlHsQXXsLxVBXzI2jI4wdfelxK13lXCR8?=
 =?us-ascii?Q?Q0zgvKNtL+1c1+BRmhnuJQasYDC+0mrmdzJrkLmKQ8EhfZZpWFeSNsPQ9b+a?=
 =?us-ascii?Q?uieYOfCZiJAZBush/OjWr1N/L3Kim+GhtCcnsRQYhx8djQ2fzAiKDRbyGiCV?=
 =?us-ascii?Q?TykhhXIQMxs27trXTG9OrJZjFlUZCE09M9sClQRxdvNe7cVcFpDxodUJp3Fa?=
 =?us-ascii?Q?05CLyKvFX9ihsTN9Yb9ZeaXRZyR+Xl9SJB0IZuhtizGUNEMmcIR5TN2Px3bp?=
 =?us-ascii?Q?0iJUH6up124CafvzLB7zx35vOtc9pJqWvmt0Zv6e1ExYQ3EBdmd+3/Q6ik9M?=
 =?us-ascii?Q?BG9ntU5rUeXYomMY/if+dZWpxIuMLgeFpBfslHqzbniHmk/KZK4CbgFP+1yp?=
 =?us-ascii?Q?rdgXAG2oMCfQc9ZlU0OaqX8UW3W7moWV7ZmzVxb93sEr5aU+oDRU6fuSSIn8?=
 =?us-ascii?Q?dMuB1SGYWn/TV5K9fC3X0as=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0916c6-ffd2-4634-fb49-08da637f7548
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 20:53:50.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: artGChHcQVihKRYgA1YtWDHSm9y++1RyCNfNxgEhEW3p68GCcd9RGWvlktLqmq8oLn8DV1qIhKw6grXd3vcKHqX6QqTv6FF15rILbBJZ4GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2874
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 09:21:12PM +0200, Horatiu Vultur wrote:
> +
>  struct ocelot_pinctrl {
>  	struct device *dev;
>  	struct pinctrl_dev *pctl;
> @@ -328,10 +329,16 @@ struct ocelot_pinctrl {
>  	struct regmap *map;
>  	struct regmap *pincfg;
>  	struct pinctrl_desc *desc;
> +	struct ocelot_pincfg_data *pincfg_data;

I'm curious as to why desc and pincfg_data can't be const. [[ checks ]]
devm_pinctrl_register needs it - which is good enough for me.

But can pincfg_data be const? That way you could do:

const struct ocelot_pincfg_data *pincfg_data;

...

info->pincfg_data = &data->pincfg_data; 


No need for another devm_kmemdup here then:

> -	info->desc = (struct pinctrl_desc *)device_get_match_data(dev);
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	info->desc = devm_kmemdup(dev, &data->desc,
> +				  sizeof(struct pinctrl_desc), GFP_KERNEL);
> +	info->pincfg_data = devm_kmemdup(dev, &data->pincfg_data,
> +					 sizeof(struct ocelot_match_data),
> +					 GFP_KERNEL);
>  
>  	reset = devm_reset_control_get_optional_shared(dev, "switch");
>  	if (IS_ERR(reset))
> -- 
> 2.33.0
> 
