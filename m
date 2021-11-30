Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE2462D02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 07:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238760AbhK3GsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 01:48:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37904 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhK3GsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 01:48:09 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 576EF212C9;
        Tue, 30 Nov 2021 06:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638254689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIrJrwu6mtk0BDgR7zkaee1NDn/ZFLS0hy1OLwSG4Rg=;
        b=WSBReyOKu7QVr9mpu2QD1ub9uiDTyiazMkCZTh1iuTk5wqX440z6wpys8oeHugOjR8qTC0
        Rhc1M2BUGhdPfZfYI7WyALsvQhE2LTkqgvSMGON+5090W40RWRwacUXvSVsC1DRJi7SxQk
        03R0slqLEplJLYz+mcn8OyCtIXdaFEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638254689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIrJrwu6mtk0BDgR7zkaee1NDn/ZFLS0hy1OLwSG4Rg=;
        b=Mcp6ALkX0Re/huK7Y5Ib3OsIrP89BpLfFVE5WWnTX2kWpdJojX3qzotPKrFKHJh0eldB9k
        Z3LnugfJnGDF0ZDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 250F313BA9;
        Tue, 30 Nov 2021 06:44:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2RnaBWHIpWF9UwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 30 Nov 2021 06:44:49 +0000
Subject: Re: [PATCH v2 1/3] block: simplify calling convention of
 elv_unregister_queue()
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-2-ebiggers@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4f32d799-6e24-dddb-2d46-97bc2579fe57@suse.de>
Date:   Tue, 30 Nov 2021 07:44:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211130040306.148925-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 5:03 AM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make elv_unregister_queue() a no-op if q->elevator is NULL or is not
> registered.
> 
> This simplifies the existing callers, as well as the future caller in
> the error path of blk_register_queue().
> 
> Also don't bother checking whether q is NULL, since it never is.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   block/blk-sysfs.c | 3 +--
>   block/elevator.c  | 8 ++++----
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
