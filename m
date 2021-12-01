Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900A2464758
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhLAGsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:48:40 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40362 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLAGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:48:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 964151FD58;
        Wed,  1 Dec 2021 06:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638341116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMhHLjMDal40aoJPgixW4AZWOZicKmK6zULWZcT34w0=;
        b=bR1Haya9j6KKtmezsJOqIuJOv84iymar9dU0waJJV++gGLOprPsuiEZzQkfA/07SyDIk1G
        NDmy8nfp5NJFHkrfbP6QNJiCptL9hEqNHH6/2pe+04PXFZryo15STKTPApf9hmB0j2LZfc
        srNqY2A/nVCapYP/9l6IpXvmL6RucmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638341116;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMhHLjMDal40aoJPgixW4AZWOZicKmK6zULWZcT34w0=;
        b=Zyy9lQ9v6ZSkldI9XKKBzbi46QYKGNM+XzDlCooLFbF0YzO2PDR/jOk88xwrCz67eyyV+L
        gW5/wwlPC9nK4TDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6977113425;
        Wed,  1 Dec 2021 06:45:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dzxkGPwZp2F4CAAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 06:45:16 +0000
Subject: Re: [PATCH v2 3/3] blk-crypto: show crypto capabilities in sysfs
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <20211130040306.148925-1-ebiggers@kernel.org>
 <20211130040306.148925-4-ebiggers@kernel.org>
 <8745aed7-d4b6-eb8d-60ad-f4d768d62a62@suse.de>
 <YaXVXU77yvKUyVwg@sol.localdomain>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ea5db68e-8d2b-b242-bf81-9fce29cdde83@suse.de>
Date:   Wed, 1 Dec 2021 07:45:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YaXVXU77yvKUyVwg@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 8:40 AM, Eric Biggers wrote:
> On Tue, Nov 30, 2021 at 07:49:54AM +0100, Hannes Reinecke wrote:
>>>     - "modes" is a sub-subdirectory, since there may be multiple supported
>>>       crypto modes, and sysfs is supposed to have one value per file.
>>>
>> Why do you have a sub-directory here?
>>  From what I can see, that subdirectory just contains the supported modes, so
>> wouldn't it be easier to create individual files like 'mode_<modename>'
>> instead of a subdirectory?
> 
> It is a group of attributes, so it makes sense to group them together rather
> than put them all in the parent directory alongside other attributes.  It also
> allows the use of proper names like "AES-256-XTS" rather than weird names like
> "mode_AES-256-XTS" or "mode_aes_256_xts".
> 
Right.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
