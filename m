Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471194B86B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiBPLcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:32:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiBPLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:32:51 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A7E1EC66;
        Wed, 16 Feb 2022 03:32:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0E1A51F383;
        Wed, 16 Feb 2022 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645011158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9+Yeu3hCssm1DnX2Utx6ifmH+5dNqbEfg/BNDzwuCA=;
        b=f1mvO8mWa3qxAfrnnn6xUDrWm874NLgzMvkb2j0LcnYdJi4/euhFVy6ZATEMSUG63cQnuM
        4KbxJZT/ji3a9Xqj76fnc5fWmm+4KnRYQgsMsFZ34hpF/DFyPksP4mXeBxNTHn/F9fT9Xh
        XnmkwuEjt+lQwP6wAuXcm6yO27lKoCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645011158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L9+Yeu3hCssm1DnX2Utx6ifmH+5dNqbEfg/BNDzwuCA=;
        b=LpPtYjywAl6GtaWQhWHeHae1Khkxa4osg1FlKgLj5P+SMNBNI86w1+TTeuvkjI1GHfteN6
        3Ey5pPGoItBljaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3D0D13AF3;
        Wed, 16 Feb 2022 11:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D9hXN9XgDGIcMQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 16 Feb 2022 11:32:37 +0000
Message-ID: <ccca97fb-0dab-0a8f-d2ac-247ba160288d@suse.de>
Date:   Wed, 16 Feb 2022 12:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     =?UTF-8?Q?Markus_Bl=c3=b6chl?= <Markus.Bloechl@ipetronik.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
References: <20220214095107.3t5en5a3tosaeoo6@ipetronik.com>
 <20220215191731.GB25076@lst.de>
 <20220216111841.jaunxn6blouzjleg@ipetronik.com>
From:   Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC PATCH] nvme: prevent hang on surprise removal of NVMe disk
In-Reply-To: <20220216111841.jaunxn6blouzjleg@ipetronik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 12:18, Markus Blöchl wrote:
> On Tue, Feb 15, 2022 at 08:17:31PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 14, 2022 at 10:51:07AM +0100, Markus Blöchl wrote:
>>> After the surprise removal of a mounted NVMe disk the pciehp task
>>> reliably hangs forever with a trace similar to this one:
>>
>> Do you have a specific reproducer? At least with doing a
>>
>> echo 1 > /sys/.../remove
>>
>> while running fsx on a file system I can't actually reproduce it.
> 
> We built our own enclosures with a custom connector to plug the disks.
> 
> So an external enclosure for thunderbolt is probably very similar.
> (or just ripping an unscrewed NVMe out of the M.2 ...)
> 
> But as already suggested, qemu might also be very useful here as it also
> allows us to test multiple namespaces and multipath I/O, if you/someone
> wants to check those too (hotplug with multipath I/O really scares me).
> 
Nothing to be scared of.
I've tested this extensively in the run up to commit 5396fdac56d8 
("nvme: fix refcounting imbalance when all paths are down") which,
incidentally, is something you need if you want to test things.

Let me see if I can dig up the testbed.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
