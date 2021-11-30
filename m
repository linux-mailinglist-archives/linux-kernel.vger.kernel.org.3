Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDDA462D17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbhK3GxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:53:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:48196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbhK3GxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:53:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6A8DD1FD2F;
        Tue, 30 Nov 2021 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638254995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPMSjAKUvWrxkyumPjAUQRt3wWFJYgrlV6wdEOiht/I=;
        b=PGJVRHICcc8IILBvJDuzDgZwDz6Qkh7yf850L7I7o31/zrc3I6oqwcOO8p6d5ZNbc69cHs
        U9T1FZuLMXt7tX/lB3+VD+UniOqFlU4YPlsmIfAYxLajulZeGdgM8BAW0KDymcmSHJsiiY
        9heMsTkTuBAeVFI1dNoO/ZExDPR++Rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638254995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPMSjAKUvWrxkyumPjAUQRt3wWFJYgrlV6wdEOiht/I=;
        b=QRRkhJfYi+SD5N2gnL0qDMxV97N76RaXiOZP5vBVQRhhBl52qQST9LwQSFlaodnRSmOnqe
        3xa+H9bPzh4LA5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D6D713BA9;
        Tue, 30 Nov 2021 06:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id u30XApPJpWEWVQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 30 Nov 2021 06:49:55 +0000
Subject: Re: [PATCH v2 3/3] blk-crypto: show crypto capabilities in sysfs
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-4-ebiggers@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <8745aed7-d4b6-eb8d-60ad-f4d768d62a62@suse.de>
Date:   Tue, 30 Nov 2021 07:49:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211130040306.148925-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 5:03 AM, Eric Biggers wrote:
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
>    - Place the new files in a new subdirectory "crypto" to group them
>      together and to avoid complicating the main "queue" directory.  This
>      also makes it possible to replace "crypto" with a symlink later if
>      we ever make the blk_crypto_profiles into real kobjects (see below).
> 
>    - It was necessary to define a new kobject that corresponds to the
>      crypto subdirectory.  For now, this kobject just contains a pointer
>      to the blk_crypto_profile.  Note that multiple queues (and hence
>      multiple such kobjects) may refer to the same blk_crypto_profile.
> 
>      An alternative design would more closely match the current kernel
>      data structures: the blk_crypto_profile could be a kobject itself,
>      located directly under the host controller device's kobject, while
>      /sys/class/block/$disk/queue/crypto would be a symlink to it.
> 
>      I decided not to do that for now because it would require a lot more
>      changes, such as no longer embedding blk_crypto_profile in other
>      structures, and also because I'm not sure we can rule out moving the
>      crypto capabilities into 'struct queue_limits' in the future.  (Even
>      if multiple queues share the same crypto engine, maybe the supported
>      data unit sizes could differ due to other queue properties.)  It
>      would also still be possible to switch to that design later without
>      breaking userspace, by replacing the directory with a symlink.
> 
>    - Use "max_dun_bits" instead of "max_dun_bytes".  Currently, the
>      kernel internally stores this value in bytes, but that's an
>      implementation detail.  It probably makes more sense to talk about
>      this value in bits, and choosing bits is more future-proof.
> 
>    - "modes" is a sub-subdirectory, since there may be multiple supported
>      crypto modes, and sysfs is supposed to have one value per file.
> 
Why do you have a sub-directory here?
 From what I can see, that subdirectory just contains the supported 
modes, so wouldn't it be easier to create individual files like 
'mode_<modename>' instead of a subdirectory?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
