Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7141C5510A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiFTGpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbiFTGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:45:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85497290;
        Sun, 19 Jun 2022 23:45:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4240D21AD6;
        Mon, 20 Jun 2022 06:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655707501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXzUs7aND+WcNPka9rMh1NXEt0XQ9KtO1VtTnU/Ibkg=;
        b=QGRQznqZPoLlT7Q42m1yxxMos3LLsXjBmprFxloHaod5FQzgFbX/v93lK35gPi6nstteSB
        RHbLt9xj6c7DIMpLH+WYLFAqtsnjnvp62DwXwjDiAXakzNSg0NpjuCpcWEz2e/LSjm24dP
        sfA89WtvE72ZrTAEVh+IAD5wTNmdhkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655707501;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PXzUs7aND+WcNPka9rMh1NXEt0XQ9KtO1VtTnU/Ibkg=;
        b=DrzhHe0sKXfkV8FRJZhOqsnumB9YAkE3jbUD95Mv8Y9qxCObFqyssVMxRXkR13X08ezpdj
        27Ayypg5OI8k7rBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3136134CA;
        Mon, 20 Jun 2022 06:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nwApOmwXsGK+cQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:45:00 +0000
Message-ID: <543fcfb2-6baf-1b19-d0f5-83979090db31@suse.de>
Date:   Mon, 20 Jun 2022 08:45:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <7f80f3b6-84f6-de48-4e69-4562c96e62c5@huawei.com>
 <e4b108ba-cbc9-5237-f873-2fcea94f2b85@opensource.wdc.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <e4b108ba-cbc9-5237-f873-2fcea94f2b85@opensource.wdc.com>
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

On 6/13/22 11:06, Damien Le Moal wrote:
> On 6/13/22 17:25, John Garry wrote:
[ .. ]
>>
>> We may have 32 regular tags and 1 reserved tag for SATA.
> 
> Right. But that is the messy part though. That extra 1 tag is actually not
> a tag since all internal commands are non-NCQ commands that do not need a
> tag...
> 
> I am working on command duration limits support currently. This feature
> set has a new horrendous "improvement": a command can be aborted by the
> device if it fails its duration limit, but the abort is done with a good
> status + sense data available bit set so that the device queue is not
> aborted entirely like with a regular NCQ command error.
> 
> For such aborted commands, the command sense data is set to
> "COMPLETED/DATA UNAVAILABLE". In this case, the host needs to go read the
> new "successful NCQ sense data log" to check that the command sense is
> indeed "COMPLETED/DATA UNAVAILABLE". And to go read that log page without
> stalling the device queue, we would need an internal NCQ (queuable) command.
> 
> Currently, that is not possible to do cleanly as there are no guarantees
> we can get a free tag (there is a race between block layer tag allocation
> and libata internal tag counting). So a reserved tag for that would be
> nice. We would end up with 31 IO tags at most + 1 reserved tag for NCQ
> commands + ATA_TAG_INTERNAL for non-NCQ. That last one would be rendered
> rather useless. But that also means that we kind-of go back to the days
> when Linux showed ATA drives max QD of 31...
> 
> I am still struggling with this particular use case and trying to make it
> fit with your series. Trying out different things right now.
> 
Hmm. Struggling on how that is supposed to work in general.
As we're reading from a log to get the sense information I guess that 
log is organized by tag index. Meaning we have to keep hold of the tag 
which generated that error.
Q1: Can we (re-) use that tag to read the log information?
Q2: What do you do if all 32 command generate such an error?

But really, this sounds no different from the 'classical' request sense 
handling in SCSI ML. Have you considered just run with that an map 
'REQUEST SENSE' on your new NCQ Get Log page command?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
