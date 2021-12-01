Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E3D464A46
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbhLAJDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:03:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45492 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbhLAJDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:03:47 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 664D0212B8;
        Wed,  1 Dec 2021 09:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638349225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvU9WOqQxuHtnAuEXjV4GD1n4RLlFIXDYVXvgUC7354=;
        b=1o3oGHPAOuUL4G7Vy+shm75HBgD+KsWoecUT6MIOS7ieR9j6A56puG7phFrfrBDvgX/WLZ
        JhnZNALK4+qhJrhc0D0K6Mklv9LiKQ09QCJcmddxInIWN9exXlyoWPWxu67JliT/J670co
        V+eT8R35rjCi+ulkfXc2haMYdMQRd4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638349225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvU9WOqQxuHtnAuEXjV4GD1n4RLlFIXDYVXvgUC7354=;
        b=ytoiF+w1Q5Bqi7iRUcq2kUzl4qToaIU1QEUc15cRA5pTr7AUJ2meaXtOp9g59HmhHli7tu
        yHI4az2CbJ6VxLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5819413BAA;
        Wed,  1 Dec 2021 09:00:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sv5AFak5p2EYOwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 09:00:25 +0000
Subject: Re: [PATCH 0/7] docs: consolidate sysfs-block into Documentation/ABI/
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211201084524.25660-1-ebiggers@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <91d14cdc-643c-58a8-37b7-af9d20747d2b@suse.de>
Date:   Wed, 1 Dec 2021 10:00:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211201084524.25660-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/21 9:45 AM, Eric Biggers wrote:
> This series consolidates the documentation for /sys/block/<disk>/queue/
> into Documentation/ABI/, where it is supposed to go (as per Greg KH:
> https://lore.kernel.org/r/YaXXpEAwVGTLjp1e@kroah.com).
> 
> This series also updates MAINTAINERS to associate the block
> documentation with the block layer.
> 
> This series applies to linux-block/for-next.
> 
> Eric Biggers (7):
>   docs: sysfs-block: sort alphabetically
>   docs: sysfs-block: add contact for nomerges
>   docs: sysfs-block: fill in missing documentation from queue-sysfs.rst
>   docs: sysfs-block: document stable_writes
>   docs: sysfs-block: document virt_boundary_mask
>   docs: block: remove queue-sysfs.rst
>   MAINTAINERS: add entries for block layer documentation
> 
>  Documentation/ABI/testing/sysfs-block | 766 ++++++++++++++++++--------
>  Documentation/block/index.rst         |   1 -
>  Documentation/block/queue-sysfs.rst   | 321 -----------
>  MAINTAINERS                           |   2 +
>  4 files changed, 545 insertions(+), 545 deletions(-)
>  delete mode 100644 Documentation/block/queue-sysfs.rst
> 
> 
> base-commit: c2626d30f312afc341158e07bf088f5a23b4eeeb
> 
Yay.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
