Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE25397E1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiEaUP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344224AbiEaUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:15:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23198089;
        Tue, 31 May 2022 13:15:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F372B81644;
        Tue, 31 May 2022 20:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB84C385A9;
        Tue, 31 May 2022 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654028122;
        bh=BFanbqOhtsJfdsE0t1WgCWXCbNVZbf6rMzjnBDejGko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTExhv82IFTfAX9On7K7/OBjqiJbZE6iPiLVuvD4xx82SDjLP9P74u8VjQUVFAjYl
         ipwq3tQzLRu4WCAoOB9JIjZvP0W8r6gnw6qcSNx7RiF1RvUBlur0Axirx9QoHRO4xQ
         mIa5TUL/xyxubDp51oQbQjoddfa2708yaXR7QhTbDyXUch3iGCMttd33LEyVHbjjT9
         gq98XIBn/tlCG0GYwnLfHur6a6GxGG911xMwSm8K4GCtR51UsL7NzWgvbXkVlJGppV
         og6hGBkGa9DhTnwHtJ5GGoTvNVvSzmeqXzaqVn+W2rpE3QZ9cgjwzIA2RaKx8qJWFD
         Xo/D5sYinC2bg==
Date:   Tue, 31 May 2022 13:15:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] f2fs: add sysfs entry to avoid FUA
Message-ID: <YpZ3WI/Vjgk/CwFE@google.com>
References: <20220527205955.3251982-1-jaegeuk@kernel.org>
 <YpFDw3mQjN1LBd2j@gmail.com>
 <YpF1gPrQY3UFsgwC@google.com>
 <YpGtDhV7V7gDk430@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpGtDhV7V7gDk430@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27, Christoph Hellwig wrote:
> On Fri, May 27, 2022 at 06:06:08PM -0700, Jaegeuk Kim wrote:
> > I think there's still some benefit to use FUA such as small chunk writes
> > for checkpoint.
> 
> Did you measure if there is?  Because some SSDs basically implemented
> FUA as an implied flush after the write, in which case it would not
> really help there either (but also not hurt).
> 
> But as the previous two maintainers already said - this needs quirking
> at the driver layer, not in the submitter.

Thanks, I indeed measured this using UFS, and it turned out cache_flush
is better than FUA all the time like this. Hence, I posted a quirk [1].

Write(us/KB)	4	64	256	1024	2048
FUA		873.792	754.604	995.624	1011.67	1067.99
CACHE_FLUSH	824.703	712.98	800.307	1019.5	1037.37

[1] https://lore.kernel.org/linux-scsi/20220531201053.3300018-1-jaegeuk@kernel.org/T/#u
