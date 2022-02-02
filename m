Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08744A7613
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345955AbiBBQib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:38:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53302 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiBBQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:38:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5BD071F387;
        Wed,  2 Feb 2022 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643819908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1UflJiT/C+aLCGaPFrCtnXw6syIU85V9VqllgoyNsQ=;
        b=puI/AdpQ/jspQcK3mXAqRUwhDRtHt1MSPBzzy8N1Mifk+8scPd3zOn7xXDLF0P4jalWpeb
        3zwY+UlTQjuUbb+X5lykpgnY7ikIqin5+iKBeSeAhsHoiLtY6dwohtEa+d1kt2pdGnoc9k
        d+VpKvXPETRjviF2CwXpqYJ7fdzdStE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643819908;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1UflJiT/C+aLCGaPFrCtnXw6syIU85V9VqllgoyNsQ=;
        b=4grxMtf5PsW9idScRI3PE3js7l6vQVXkZjy99aCei5I5HHh9Wy0iCDyXXx0hHR6VbI79sQ
        fHfUdD3zucB26NAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2A4913E99;
        Wed,  2 Feb 2022 16:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +AUgL4Oz+mHsNwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 02 Feb 2022 16:38:27 +0000
Message-ID: <c2294974-38a5-1900-2af7-10d317493b63@suse.de>
Date:   Wed, 2 Feb 2022 17:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv2 7/7] nvme: add support for enhanced metadata
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        martin.petersen@oracle.com, colyli@suse.de
References: <20220201190128.3075065-1-kbusch@kernel.org>
 <20220201190128.3075065-8-kbusch@kernel.org>
 <aaf56d4b-8554-e677-119e-9d23c921fe0a@suse.de>
 <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220202154131.GA3077632@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 16:41, Keith Busch wrote:
> On Wed, Feb 02, 2022 at 02:28:53PM +0100, Hannes Reinecke wrote:
>> On 2/1/22 20:01, Keith Busch wrote:
[ .. ]
>>> @@ -3104,7 +3218,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
>>>    	if (ret < 0)
>>>    		return ret;
>>> -	ret = nvme_configure_acre(ctrl);
>>> +	ret = nvme_configure_host_options(ctrl);
>>>    	if (ret < 0)
>>>    		return ret;
>>
>> This could be made into a separate patch, is it's not directly related to PI
>> support. >
> Well, the driver can't read the new PI formats without enabling host
> supported features for it. Enabling the feature tells the controller
> we're going to check for it, so I don't think we could reasonably split
> this part into a prep patch from the part that sets up the PI formats.

Actually I was thinking about a patch renaming 'nvme_configure_acre' 
into 'nvme_configure_host_options', as _this_ really is independent.
When mixed together with the PI stuff it's hard to track down from the 
commit message when it got changed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
