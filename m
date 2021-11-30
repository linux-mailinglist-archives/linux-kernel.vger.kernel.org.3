Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A996B462D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 08:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238994AbhK3HRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 02:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhK3HRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 02:17:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9186DC061574;
        Mon, 29 Nov 2021 23:13:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC20DCE17F3;
        Tue, 30 Nov 2021 07:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350DBC53FC1;
        Tue, 30 Nov 2021 07:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638256421;
        bh=yxjJWBzEG4lH4KkmrvIfKelb/QABtOCYFRxeeCh7FaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ssbYfAYaXyhzUsOTZIr0z7VN9//jo+wu/hFK79E+m/WBG3LMDpEU6Xqk330BeBzaO
         pfNPaBQo1sP1U2KwVfOcJbmvILIuD6jCroAdBZKFDjfv9XBclSnMC8h6OBsHDSazhT
         xJcuSgVLWkCKODQwL2KCVZ48H+tL1BaIpmKZE8UE=
Date:   Tue, 30 Nov 2021 08:13:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 3/3] blk-crypto: show crypto capabilities in sysfs
Message-ID: <YaXPIYHg8Xnk1Lbh@kroah.com>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130040306.148925-4-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 08:03:06PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add sysfs files that expose the inline encryption capabilities of
> request queues:
> 
> 	/sys/class/block/$disk/queue/crypto/max_dun_bits
> 	/sys/class/block/$disk/queue/crypto/modes/$mode
> 	/sys/class/block/$disk/queue/crypto/num_keyslots
> 
> Userspace can use these new files to decide what encryption settings to
> use, or whether to use inline encryption at all.  This also brings the
> crypto capabilities in line with the other queue properties, which are
> already discoverable via the queue directory in sysfs.
> 
> Design notes:
> 
>   - Place the new files in a new subdirectory "crypto" to group them
>     together and to avoid complicating the main "queue" directory.  This
>     also makes it possible to replace "crypto" with a symlink later if
>     we ever make the blk_crypto_profiles into real kobjects (see below).
> 
>   - It was necessary to define a new kobject that corresponds to the
>     crypto subdirectory.  For now, this kobject just contains a pointer
>     to the blk_crypto_profile.  Note that multiple queues (and hence
>     multiple such kobjects) may refer to the same blk_crypto_profile.
> 
>     An alternative design would more closely match the current kernel
>     data structures: the blk_crypto_profile could be a kobject itself,
>     located directly under the host controller device's kobject, while
>     /sys/class/block/$disk/queue/crypto would be a symlink to it.
> 
>     I decided not to do that for now because it would require a lot more
>     changes, such as no longer embedding blk_crypto_profile in other
>     structures, and also because I'm not sure we can rule out moving the
>     crypto capabilities into 'struct queue_limits' in the future.  (Even
>     if multiple queues share the same crypto engine, maybe the supported
>     data unit sizes could differ due to other queue properties.)  It
>     would also still be possible to switch to that design later without
>     breaking userspace, by replacing the directory with a symlink.
> 
>   - Use "max_dun_bits" instead of "max_dun_bytes".  Currently, the
>     kernel internally stores this value in bytes, but that's an
>     implementation detail.  It probably makes more sense to talk about
>     this value in bits, and choosing bits is more future-proof.
> 
>   - "modes" is a sub-subdirectory, since there may be multiple supported
>     crypto modes, and sysfs is supposed to have one value per file.
> 
>   - Each mode had to be named.  The crypto API names like "xts(aes)" are
>     not appropriate because they don't specify the key size.  Therefore,
>     I assigned new names.  The exact names chosen are arbitrary, but
>     they happen to match the names used in log messages in fs/crypto/.
> 
>   - The "num_keyslots" file is a bit different from the others in that
>     it is only useful to know for performance reasons.  However, it's
>     included as it can still be useful.  For example, a user might not
>     want to use inline encryption if there aren't very many keyslots.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/block/queue-sysfs.rst |  30 +++++

Same objection as before.  Please add these to Documentation/ABI/
otherwise when running 'scripts/get_abi undefined' will show these new
sysfs files you are adding as having no documentation :(

thanks,

greg k-h
