Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAD0462D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbhK3GtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:49:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37930 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhK3GtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:49:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 276F4212C6;
        Tue, 30 Nov 2021 06:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638254758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3A/LpTQO6wAmVg/00VkkkuYuU/LEB4wL0Asx60DQ/4=;
        b=RpY19WUf5VHMxBlED/my/OzHFCIpYjNC7+93pIkbw/mTTFy78+rzDT9U4WYlO/1jxED4K6
        twA2DsGOAgj6kkx5mUnFfFgOi+o9dH8fpX840k+LygbrpuFqvrlkWvfS+iCv4o9drSZ+Jy
        /ebs7E6FiBwsOaiZFSijqFE2Vf8p7u8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638254758;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y3A/LpTQO6wAmVg/00VkkkuYuU/LEB4wL0Asx60DQ/4=;
        b=OAij2cosM9LxlO9MdfJOanaq2MjYgytpk6ZmPqY/dc5eWmqQRoBYI+g0U+v40lLdirB+Kq
        3ORyOS0BX4b502DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F01F913BA9;
        Tue, 30 Nov 2021 06:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AgSpOaXIpWH3UwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 30 Nov 2021 06:45:57 +0000
Subject: Re: [PATCH v2 2/3] block: don't delete queue kobject before its
 children
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-3-ebiggers@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <63ab4f9d-86e6-363c-bbd0-a03c51bf3011@suse.de>
Date:   Tue, 30 Nov 2021 07:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211130040306.148925-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 5:03 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> kobjects aren't supposed to be deleted before their child kobjects are
> deleted.  Apparently this is usually benign; however, a WARN will be
> triggered if one of the child kobjects has a named attribute group:
> 
>      sysfs group 'modes' not found for kobject 'crypto'
>      WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:278 sysfs_remove_group+0x72/0x80
>      ...
>      Call Trace:
>        sysfs_remove_groups+0x29/0x40 fs/sysfs/group.c:312
>        __kobject_del+0x20/0x80 lib/kobject.c:611
>        kobject_cleanup+0xa4/0x140 lib/kobject.c:696
>        kobject_release lib/kobject.c:736 [inline]
>        kref_put include/linux/kref.h:65 [inline]
>        kobject_put+0x53/0x70 lib/kobject.c:753
>        blk_crypto_sysfs_unregister+0x10/0x20 block/blk-crypto-sysfs.c:159
>        blk_unregister_queue+0xb0/0x110 block/blk-sysfs.c:962
>        del_gendisk+0x117/0x250 block/genhd.c:610
> 
> Fix this by moving the kobject_del() and the corresponding
> kobject_uevent() to the correct place.
> 
> Fixes: 2c2086afc2b8 ("block: Protect less code with sysfs_lock in blk_{un,}register_queue()")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   block/blk-sysfs.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
