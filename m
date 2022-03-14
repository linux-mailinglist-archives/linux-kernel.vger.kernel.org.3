Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7F4D8843
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbiCNPic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242586AbiCNPi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:38:29 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF2443F8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaYyoyp5vt5rUvqZ4wMe5Nvye9Gn8xEsVDRFsTHD+UaHf8xYvh7slVfm6vs7dsKGgYcLy9Rw1pHHsAXWZF6AkRt4G2RuxARJScQ+L1v3LmYJKUL2RqNDVfcwcH8z14S2/uK4cqphiwUvzHtctuze/68wIRvZbV5WHiLbBHWG++1GgTBCy+VYav5Z5uhmcpmg/Kf1QnFyq3z3dMH0gQfL5C8LlXqrrAW30asuP4S3UKqq0gUFdI1qcPtOOrhTUTPCFpsZLvoq271Knu5kkOuOiXCfgsTMrLmHs2DXs/mIX6SVqM7+l34KoRU3FkZDe1Vepbz5IpLR60K9K2/HtPfJBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OM+auBcicxYp7AeEgJnX6PTZ49IlD4iKqvEATYUEZxk=;
 b=EmQcA0uK22sR0NKymPxTdf6grerK72TC58W6O0gr/OVfTTXV0zUBvsYKgVRqbQrY5WLz6PqVNLyx4JmRE2V1fJZI5Mmv0mQ8eTFBEM2uowzZlVNAuDeZaJiDLOU/jPEE0ftAaug4kUgJ29NURLAS6TxD99y6Ui8ig/OyFjxOneRGRIfXoysp4C7xfCuPYI4/O4jzwdo1NEoOlMzM0Je3OtY/byt24LveveUwxW0aKoVSj8licxk6u3sFDpGbnpgG3Ktf5irP+k60Jd3hrpWDFr1hVJiM691Bn8IeG6NFnPLK3ZsesjG3B2m9HKPvrDLZbQH0Ps9hpsNIhuRr/JoYJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OM+auBcicxYp7AeEgJnX6PTZ49IlD4iKqvEATYUEZxk=;
 b=M4KkawXjfvgstbSxorTVvyqJHix+yTJ8m1qv6vdqswF/RU3u+cnWr0prynsxi+mmkD8wWq3OiD1lzQWH+3prQ8NxaPDJth4Tnr8XWLpZqurI8VUKXHN+h9bp3a53b1qh3R96XheMVSJ6XQSVKgF7IHFst6CKBKV7JZMMlt5DfYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by SJ0PR10MB5440.namprd10.prod.outlook.com
 (2603:10b6:a03:3bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 15:37:15 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::7c:dc80:7f24:67c5%6]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 15:37:15 +0000
Date:   Mon, 14 Mar 2022 08:37:14 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v1 2/2] regmap: allow a defined reg_base to be added to
 every address
Message-ID: <20220314153714.GA10772@COLIN-DESKTOP1.localdomain>
References: <20220313224524.399947-1-colin.foster@in-advantage.com>
 <20220313224524.399947-3-colin.foster@in-advantage.com>
 <Yi78tDT3t7mcGtEn@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi78tDT3t7mcGtEn@sirena.org.uk>
X-ClientProxiedBy: MWHPR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:300:6c::21) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb8c9898-f973-4e35-397b-08da05d0840f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5440:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5440927FB2F6C6CD64B61129A40F9@SJ0PR10MB5440.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TB5w2D3WjC/BjtOb+8gF4yryT89KjMA7BRBGBV0fbEn3a+b6ib6EAsEwcBS9J4jafM/wMElZqVb9uabEqZF0k0dXtE3KxZt0FSwxWlWPLHreZ9+tkvZMWJSYbIEWOyWMReaGpOUhECm81xspPHp9J8Vk41FC11g6GuSHOM1HULiXtttVpQVA/LqfTfXR72awlaLDN0j/2R3VTuYvISeWOdivBD4IfwuqcA5de/VraADqrioXnytyvPHiLvYQPo9/ryqznRBYMWBFHtzyCy+JuG2axibBcySHFeDSLVCZIx6jqojCNh4188GT3+bWIqMSyrNm80jIjMdVk748SVApeCDb8/mZCUVvXbtpiT4Mj1vjhyEob6sh+fdQFzGnXk8Ar0KRmOsWHnLr07A999/Ky+nZ5P9jTxkLAmDCncS9h2QWNaW3302ilw0d5CNtQZMBFIDHm/C8aBN+4rZSdB52kveGMK1st8OsOptOrKIpFfHJehxIqi4naOXLn13Urctw8O1NVObGy4HqL9Ix0OGkSvBes3+HzsSZjmrR7w/ohyce1pIXItp3U4JEGbqDaw3hGpW5phk+9IYUdKsdyagqG5PoXyl6htFerE8JiuHc9c1h9RvrSObARwlO2MXG/WYW2b4mwU3aVOSgKiFCQ6vOSs0v+b+qJr5QxwmYINa7jieUVUe32WcKWW8mZSxM6piKw8eRUgeV3Og7BSlDtQ10Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(366004)(39830400003)(136003)(346002)(396003)(5660300002)(6512007)(9686003)(33656002)(2906002)(83380400001)(44832011)(8936002)(4326008)(66556008)(66476007)(26005)(186003)(8676002)(38350700002)(38100700002)(66946007)(52116002)(6506007)(86362001)(316002)(54906003)(1076003)(6916009)(6486002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uE+I1xGE6GWprCRvAoVVhzTLT/Eb3W+QiawqvUlTJ2YhPIF69HSSahzwtb9f?=
 =?us-ascii?Q?cN9wrWoWSn6O0KZhUiQNZkd5LJMdmmZd6ONPB5hvdA/6f4BQ94Q0Ju4ITwJ4?=
 =?us-ascii?Q?IJLlybO+9MJITQEAUN5ceWpyC1PP+ZioFJjfbDIrIJXkmjDhxL+kCpIz3FeR?=
 =?us-ascii?Q?Mc1ELa8LWEFrrX0DR77nqxpq+YCIRCDZy6YXKen6kVy0AS18R0ToWE7oR9Pm?=
 =?us-ascii?Q?PyBGJ6KuMteaRl4H0/dFX8JxEyNkIwfNBuMpJD8glMoJ8E/IobHY0doT5M6O?=
 =?us-ascii?Q?nXh+YU+O/bd1BuPC+/Y+1mHqRSqXDE32ZeOhHvEw7mJNMXod6o2ciEOZPyc+?=
 =?us-ascii?Q?kVI8EUfeNAJP3C2kHjr/LfxpUtgPjboH79V5JIdXpvXP+cOeaJeEOogMM6eO?=
 =?us-ascii?Q?V9ZuTCHDJaFGpHxYGkbHzcT8k8TgADibokfIj4DH0ngT7OUQ0W7xty/RrgM2?=
 =?us-ascii?Q?GeQTNKP4wxy6ZoF4SMRSEEEVbhJgQd/pVA6vVqdomb9gSay9AfUlnqM1rG+s?=
 =?us-ascii?Q?/0gdlMw/+8u1PPtnmugw7Q3QP89nmu1xdJPYMrtdM+jJnOroe6lBkbu5fo5e?=
 =?us-ascii?Q?wRxRHGDTduui0MN1yD4iCn7zYYUYrE4Hoyjo/71scUOzXgjjdRmyQlblviG0?=
 =?us-ascii?Q?1hOpBlOgW5o7w+9e2cJPywHRsyQZ3dFcQj/44NVD8BXlntJZ8HpL8x9/1raD?=
 =?us-ascii?Q?s+B9Y+E4wqfY2m3TEiV7E9dHJLf0Yy5QEa39r8fB+CTkGi+Y8HNtrVHx31ef?=
 =?us-ascii?Q?IFdIfxGIkmlEm075b02jUHHmDoQYcomixACHcT2VzlYyt29hBaDNTK9J+e2u?=
 =?us-ascii?Q?B+ofJppqQHju3cnyVWYFCV9+fqZX8LX2Je6WMpaCIW55JUIJyu4h2nIQ6nCH?=
 =?us-ascii?Q?0WjHphxH0BaXpszUsThUV4iElRmpZXugJ3VeiRGdjGgP4Z/XU8g9OvbUNhGQ?=
 =?us-ascii?Q?TW6tIAyooBIYrQOSplTBKRCIsX20K+ZkTSH7u9o2z7zt/rei5wDln6apg7qh?=
 =?us-ascii?Q?Ov8P4btWDjItn8RwvehsP0brM3qbi/Xjh3LnlMzVhSpfsLs1N/23uFOd0fso?=
 =?us-ascii?Q?SRo7ZDvxl2uEddAwPM5RSRiAJwwgAVyDc6fvmbT1y5YhPWY0JNf0cBCeldbi?=
 =?us-ascii?Q?WhwGfrsw5lYbS86+C6s5sM9r1iFA+QNB/5WEg6CJRkJpx3I+GuYvy8t7uZXb?=
 =?us-ascii?Q?NdVeyCeqZbW1WJMt2FFYqNELnRtCLTvwxcpPWktYoWbkpK+ahijKHc6A5/z9?=
 =?us-ascii?Q?oAmSjDb8vVQHzxSt9cyTKXiDYY6X/swrYM3sDxYFbdQLmQ+bqdA0TNNP6bUc?=
 =?us-ascii?Q?E5ygx9EDTq8qgNB31B6U/DsBA3x/h/nfYum5zbcwG/7Q5hgKFxOhsXnupaO3?=
 =?us-ascii?Q?4sbw0EWFT/LUlDDqyQJzF3B3RjHxVh4Ad5ob6mlc/GV0mXJSpjdCkBHhAl+9?=
 =?us-ascii?Q?WCoxI1G/hTznrFUp/mf8UJcWAog76gdFYbkOxMS9VPmd2Cxa+1g//w=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8c9898-f973-4e35-397b-08da05d0840f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 15:37:15.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HsjLEZeffKEaCRC8o7Qtn2n0SU0O0nRfZLum1EY6AJpXOq4jPgEugXl+hs+/nAEZcOtr5IZ2gG54qVvKjFU5gUBJQ5UA8+6OoAroCpgrb24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5440
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 08:28:36AM +0000, Mark Brown wrote:
> On Sun, Mar 13, 2022 at 03:45:24PM -0700, Colin Foster wrote:
> 
> > There's an inconsistency that arises when a register set can be accessed
> > internally via MMIO, or externally via SPI. The VSC7514 chip allows both
> > modes of operation. When internally accessed, the system utilizes __iomem,
> > devm_ioremap_resource, and devm_regmap_init_mmio.
> 
> > For SPI it isn't possible to utilize memory-mapped IO. To properly operate,
> > the resource base must be added to the register before every operation.
> 
> The problem here isn't the mixed buses, the problem is that the hardware
> designers have for some unknown reason decided to not use the same
> register addresses on the two buses which just seems pointlessly
> unhelpful.

That is true for the address downshift. But the resource start
seemingly still needs to be addressed somewhere. Currently that is
contained on a per-regmap basis inside my WIP drivers/mfd/ocelot-spi.c.
But that falls apart as soon as regmap_bus gets involved, as I'm finding
out.

So would it make sense to keep this patch, drop the downshift, and
re-define the offsets / stride to match the modified address space?

> 
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> >  drivers/base/regmap/internal.h | 1 +
> >  drivers/base/regmap/regmap.c   | 6 ++++++
> >  include/linux/regmap.h         | 3 +++
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> > index 88f710e7ce31..b4df36c7b17d 100644
> > --- a/drivers/base/regmap/internal.h
> > +++ b/drivers/base/regmap/internal.h
> > @@ -63,6 +63,7 @@ struct regmap {
> >  	regmap_unlock unlock;
> >  	void *lock_arg; /* This is passed to lock/unlock functions */
> >  	gfp_t alloc_flags;
> > +	unsigned int reg_base;
> >  
> >  	struct device *dev; /* Device we do I/O on */
> >  	void *work_buf;     /* Scratch buffer used to format I/O */
> > diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> > index 1c7c6d6361af..5e12f7cb5147 100644
> > --- a/drivers/base/regmap/regmap.c
> > +++ b/drivers/base/regmap/regmap.c
> > @@ -821,6 +821,8 @@ struct regmap *__regmap_init(struct device *dev,
> >  	else
> >  		map->alloc_flags = GFP_KERNEL;
> >  
> > +	map->reg_base = config->reg_base;
> > +
> >  	map->format.reg_bytes = DIV_ROUND_UP(config->reg_bits, 8);
> >  	map->format.pad_bytes = config->pad_bits / 8;
> >  	map->format.reg_downshift = config->reg_downshift;
> > @@ -1736,6 +1738,7 @@ static int _regmap_raw_write_impl(struct regmap *map, unsigned int reg,
> >  			return ret;
> >  	}
> >  
> > +	reg += map->reg_base;
> >  	reg >>= map->format.reg_downshift;
> >  	map->format.format_reg(map->work_buf, reg, map->reg_shift);
> >  	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
> > @@ -1907,6 +1910,7 @@ static int _regmap_bus_formatted_write(void *context, unsigned int reg,
> >  			return ret;
> >  	}
> >  
> > +	reg += map->reg_base;
> >  	reg >>= map->format.reg_downshift;
> >  	map->format.format_write(map, reg, val);
> >  
> > @@ -2349,6 +2353,7 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
> >  		unsigned int reg = regs[i].reg;
> >  		unsigned int val = regs[i].def;
> >  		trace_regmap_hw_write_start(map, reg, 1);
> > +		reg += map->reg_base;
> >  		reg >>= map->format.reg_downshift;
> >  		map->format.format_reg(u8, reg, map->reg_shift);
> >  		u8 += reg_bytes + pad_bytes;
> > @@ -2677,6 +2682,7 @@ static int _regmap_raw_read(struct regmap *map, unsigned int reg, void *val,
> >  			return ret;
> >  	}
> >  
> > +	reg += map->reg_base;
> >  	reg >>= map->format.reg_downshift;
> >  	map->format.format_reg(map->work_buf, reg, map->reg_shift);
> >  	regmap_set_work_buf_flag_mask(map, map->format.reg_bytes,
> > diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> > index 40fb9399add6..de81a94d7b30 100644
> > --- a/include/linux/regmap.h
> > +++ b/include/linux/regmap.h
> > @@ -239,6 +239,8 @@ typedef void (*regmap_unlock)(void *);
> >   *              used.
> >   * @reg_downshift: The number of bits to downshift the register before
> >   *		   performing any operations.
> > + * @reg_base: Value to be added to every register address before performing any
> > + *	      operation.
> >   * @pad_bits: Number of bits of padding between register and value.
> >   * @val_bits: Number of bits in a register value, mandatory.
> >   *
> > @@ -363,6 +365,7 @@ struct regmap_config {
> >  	int reg_bits;
> >  	int reg_stride;
> >  	int reg_downshift;
> > +	unsigned int reg_base;
> >  	int pad_bits;
> >  	int val_bits;
> >  
> > -- 
> > 2.25.1
> > 


