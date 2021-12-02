Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5D4664E1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358387AbhLBOHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:07:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:53644 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346972AbhLBOHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:07:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 63898CE22F9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80C2C00446;
        Thu,  2 Dec 2021 14:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638453855;
        bh=5v11wuwoWmcBaHc5VRNqR3MfF8jXLA5MgIqvuA5C/UM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tgSj4VgQZ8YFojjMD128a/fjnqh4u4zKL6lc+xauUDAYNp3p1p6ZfBfjoCRvYWUif
         sya/XFZ52eFnLz5qhdLGqoToZ7W8j2CUDPGbUmcjo4mRaSSk9OH3Zfpb3vkvHTEVUt
         0ZkKawR/S97teDiKIVbR/IoADenvFkeRFDOBf5Uu4PRoimS3rLyvXIFiDN8jMkRg7o
         JNDo05Z1sHfukPbMiofWgcowXu0HfFc8QQdZ2oQbVB4X60e4u36SoIhEC6Y1HDrzx6
         HwkMOhTt/WkQt45ma6GZjI2Bj6WnNuhNy27ZeaAoSQRXrDFkYibJmNm56Y1Dq+bLOV
         5l+BKzAjSPVyA==
Message-ID: <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
Date:   Thu, 2 Dec 2021 22:04:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <YahIf3UlhuxJT1O4@sol.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/2 12:15, Eric Biggers wrote:
> On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
>> Why not relocating this check before f2fs_map_blocks()?

Wait, it supports DIO in multi-device image after commit 	71f2c8206202 
("f2fs: multidevice: support direct IO"), how about
checking with f2fs_allow_multi_device_dio()?

Thanks,

>>
>> Thanks,
>>
>>> +		iomap->bdev = inode->i_sb->s_bdev;
> 
> Are you talking about the check for !f2fs_is_multi_device()?  It could go in
> either location, but I think it makes the most sense to have it right before the
> line that uses 'inode->i_sb->s_bdev', since that is the place which makes the
> assumption that the filesystem has only one block device.
> 
> - Eric
> 
