Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6B8596DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbiHQLtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHQLth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:49:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC40431DDB;
        Wed, 17 Aug 2022 04:49:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 03383201A5;
        Wed, 17 Aug 2022 11:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660736975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9RL09tmr+tZ/vOLgcQWE7dEd6UbM48lh2YL7kdzrPE=;
        b=uFSF63luGP6k4L62bGGz9O9wwUCMkPIloV/HHaYo4ejUcxqNAxNOym5E4RrwRYO7vE0QUg
        H7zpbQ2064mnsuH7VRgr+tT/iDIxTsMEd8Vb9l+ZFSiq2LuDxGim9pbn3cUe8NgRtL826R
        wt0C22VB8Q2t5EW72u2uqFxl7Q5bc2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660736975;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9RL09tmr+tZ/vOLgcQWE7dEd6UbM48lh2YL7kdzrPE=;
        b=NU8RqFlDPKncfp8HT7v1NrsqZLXRpHospMMRHoNgoiOLLTyksBEJeCxhoyz10vULPNNL26
        LrZwiqyUw+jknQAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C1D292C178;
        Wed, 17 Aug 2022 11:49:34 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E18F8A066B; Wed, 17 Aug 2022 13:49:33 +0200 (CEST)
Date:   Wed, 17 Aug 2022 13:49:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Holger =?utf-8?Q?Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <20220817114933.66c4g4xjsi4df2tg@quack3>
References: <cb1521d5-8b07-48d8-8b88-ca078828cf69@www.fastmail.com>
 <ad78a32c-7790-4e21-be9f-81c5848a4953@www.fastmail.com>
 <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-08-22 11:52:54, Holger Hoffstätte wrote:
> On 2022-08-16 17:34, Chris Murphy wrote:
> > 
> > On Tue, Aug 16, 2022, at 11:25 AM, Nikolay Borisov wrote:
> > > How about changing the scheduler either mq-deadline or noop, just
> > > to see if this is also reproducible with a different scheduler. I
> > > guess noop would imply the blk cgroup controller is going to be
> > > disabled
> > 
> > I already reported on that: always happens with bfq within an hour or
> > less. Doesn't happen with mq-deadline for ~25+ hours. Does happen
> > with bfq with the above patches removed. Does happen with
> > cgroup.disabled=io set.
> > 
> > Sounds to me like it's something bfq depends on and is somehow
> > becoming perturbed in a way that mq-deadline does not, and has
> > changed between 5.11 and 5.12. I have no idea what's under bfq that
> > matches this description.
> 
> Chris, just a shot in the dark but can you try the patch from
> 
> https://lore.kernel.org/linux-block/20220803121504.212071-1-yukuai1@huaweicloud.com/
> 
> on top of something more recent than 5.12? Ideally 5.19 where it applies
> cleanly.
> 
> No guarantees, I just remembered this patch and your problem sounds like
> a lost wakeup. Maybe BFQ just drives the sbitmap in a way that triggers the
> symptom.

Yes, symptoms look similar and it happens for devices with shared tagsets
(which megaraid sas is) but that problem usually appeared when there are
lots of LUNs sharing the tagset so that number of tags available per LUN
was rather low. Not sure if that is the case here but probably that patch
is worth a try.

Another thing worth trying is to compile the kernel without
CONFIG_BFQ_GROUP_IOSCHED. That will essentially disable cgroup support in
BFQ so we will see whether the problem may be cgroup related or not.

Another interesting thing might be to dump
/sys/kernel/debug/block/<device>/hctx*/{sched_tags,sched_tags_bitmap,tags,tags_bitmap}
as the system is hanging. That should tell us whether tags are in fact in
use or not when processes are blocking waiting for tags.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
