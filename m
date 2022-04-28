Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC5512919
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 03:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240940AbiD1BxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiD1BxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 21:53:18 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2378299;
        Wed, 27 Apr 2022 18:50:04 -0700 (PDT)
Subject: Re: [PATCH v2 01/12] md/raid5: Factor out ahead_of_reshape() function
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651110603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CbEtAZGkNZAuchq7NKoeV3cKOWr84klzGpqBcsQxcMs=;
        b=Ip/L+IwlDHTIEdN3OQ3EUG0N8t0/OI25xdagAIH29JcrdPWX9JxzlXmDLlhiVaLWUOy/FU
        UDjdyrUBaWkaz7D9MWPfnUc/SC/GBGUs9REjEYdwsP+iN3ogsSi7jrkoe5GS+CXFpnNzrS
        Wrj9xFAOB75rr554/hsktaAeLILDEC4=
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220420195425.34911-1-logang@deltatee.com>
 <20220420195425.34911-2-logang@deltatee.com>
 <2a6d5554-4f71-6476-6d14-031da52005f5@linux.dev>
 <fe7f6d8a-8c66-3e90-1c52-140fe9d4cf1a@deltatee.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <19d88098-7e52-38de-ceb7-a68debfbbd10@linux.dev>
Date:   Thu, 28 Apr 2022 09:49:56 +0800
MIME-Version: 1.0
In-Reply-To: <fe7f6d8a-8c66-3e90-1c52-140fe9d4cf1a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/22 12:07 AM, Logan Gunthorpe wrote:
>
> On 2022-04-26 19:28, Guoqing Jiang wrote:
>>>    +static bool ahead_of_reshape(struct mddev *mddev, sector_t sector,
>>> +                 sector_t reshape_sector)
>>> +{
>>> +    if (mddev->reshape_backwards)
>>> +        return sector < reshape_sector;
>>> +    else
>>> +        return sector >= reshape_sector;
>>> +}
>> I think it can be an inline function.
> Marking static functions in C files as inline is not recommended. GCC
> will inline it, if it is appropriate.
>
> https://yarchive.net/comp/linux/inline.html
> https://www.kernel.org/doc/local/inline.html

Thanks for the link, then I suppose those can be deleted

linux> grep "static inline" drivers/md/md.h -r
static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sectors,
static inline int __must_check mddev_lock(struct mddev *mddev)
static inline void mddev_lock_nointr(struct mddev *mddev)
static inline int mddev_trylock(struct mddev *mddev)
static inline int mddev_is_locked(struct mddev *mddev)
static inline void md_sync_acct(struct block_device *bdev, unsigned long 
nr_sectors)
static inline void md_sync_acct_bio(struct bio *bio, unsigned long 
nr_sectors)
static inline struct kernfs_node *sysfs_get_dirent_safe(struct 
kernfs_node *sd, char *name)
static inline void sysfs_notify_dirent_safe(struct kernfs_node *sd)
static inline char * mdname (struct mddev * mddev)
static inline int sysfs_link_rdev(struct mddev *mddev, struct md_rdev *rdev)
static inline void sysfs_unlink_rdev(struct mddev *mddev, struct md_rdev 
*rdev)
static inline void safe_put_page(struct page *p)
static inline bool is_mddev_broken(struct md_rdev *rdev, const char 
*md_type)
static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev 
*mddev)
static inline int mddev_is_clustered(struct mddev *mddev)
static inline void mddev_clear_unsupported_flags(struct mddev *mddev,
static inline void mddev_check_write_zeroes(struct mddev *mddev, struct 
bio *bio)

Thanks,
Guoqing
