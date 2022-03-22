Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3921E4E3D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiCVLb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiCVLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 07:31:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B982D3B;
        Tue, 22 Mar 2022 04:30:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0F35210F2;
        Tue, 22 Mar 2022 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1647948623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fQn/kN2kD/05uJ7tYAqw+5hume5Xh0ejNwO9M3AYNQ=;
        b=lhMdySVNeRYjPbMaYV5J07pKoxb5EKZYT0H/ygWBZwVhf6zuXmnOaNrVtzqE2mapmGYwMJ
        8QZ5pcuQcYPHcJMRRl+O9iQfvrLa9cdxci7ggu4gAPaI02blIp9UMyqlVaYABF7dFrnGqO
        7H7yTH2uELrhh0ZeURa+sYDPASm+NP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1647948623;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fQn/kN2kD/05uJ7tYAqw+5hume5Xh0ejNwO9M3AYNQ=;
        b=c5b51+IIHqkotckGR7BMW1D8/C6gwVIUawPDPnJBmJCbT8KTjeROgyPVmAIryyk+LKqazO
        1NOEu8fJcsxtwtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAC4A133B6;
        Tue, 22 Mar 2022 11:30:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fv4zLU+zOWJGSQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 22 Mar 2022 11:30:23 +0000
Message-ID: <1537235d-ac22-6914-4b31-4482e9536098@suse.de>
Date:   Tue, 22 Mar 2022 12:30:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
        ming.lei@redhat.com
Cc:     chenxiang66@hisilicon.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com, beanhuo@micron.com
References: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC 00/11] blk-mq/libata/scsi: SCSI driver tagging
 improvements
In-Reply-To: <1647945585-197349-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/22 11:39, John Garry wrote:
> Currently SCSI low-level drivers are required to manage tags for commands
> which do not come via the block layer - libata internal commands would be
> an example of one of these.
> 
> There was some work to provide "reserved commands" support in such series
> as https://lore.kernel.org/linux-scsi/20211125151048.103910-1-hare@suse.de/
> 
> This was based on allocating a request for the lifetime of the "internal"
> command.
> 
> This series tries to solve that problem by not just allocating the request
> but also sending it through the block layer, that being the normal flow
> for a request. We need to do this as we may only poll completion of
> requests through the block layer, so would need to do this for poll queue
> support.
> 
> There is still scope to allocate commands just to get a tag as token as
> that may suit some other scenarios, but it's not what we do here.
> 
> This series extends blk-mq to support a request queue having a custom set
> of ops. In addition SCSI core code adds support for these type of requests.
> 
> This series does not include SCSI core handling for enabling reserved
> tags per tagset, but that would be easy to add.
> 
> Based on mkp-scsi 5.18/scsi-staging @ 66daf3e6b993
> 
> Please consider as an RFC for now. I think that the libata change has the
> largest scope for improvement...
> 

Grand seeing that someone is taking it up. Thanks for doing this!

But:
Allocating a queue for every request (eg in patch 3) is overkill. If we 
want to go that route we should be allocating the queue upfront (eg when 
creating the device itself), and then just referencing it.

However, can't say I like this approach. I've been playing around with 
supporting internal commands, and really found two constraints really 
annoying:

- The tagset supports only _one_ set of payload via
   blk_mq_rq_(to,from)_pdu().
This requires each request to be of the same type, and with that making
it really hard for re-purposing the request for internal usage. In the
end I settled by just keeping it and skipping the SCSI command field.
If we could have a distinct PDU type for internal commands I guess 
things would be easier.

- The number of reserved commands is static.
With that it's getting really hard using reserved commands with 
low-queue depth devices like ATA; we only have 31 commands to work with, 
and setting one or two aside for TMF is really making a difference 
performance wise. It would be _awesome_ if we could allocate reserved 
commands dynamically (ie just marking a command as 'reserved' once 
allocated).
Sure, it won't have the same guarantees as 'real' reserved commands, but 
in most cases we don't actually need that.

Maybe these are some lines we could investigate?
Hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
