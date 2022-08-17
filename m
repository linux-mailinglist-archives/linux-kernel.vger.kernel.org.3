Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F26597437
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiHQQbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbiHQQbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:31:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F3DECC;
        Wed, 17 Aug 2022 09:31:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6557D1F9EA;
        Wed, 17 Aug 2022 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660753860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38RIYwPJSBj+njOW8lX/s5pnoWS5wLKDA4I+GoOrolk=;
        b=xfV9Rckhj+asO11u/UkJKQhXnXgELLDbOaNOBGVBMjk7NQMkYiqAYBX1o0OagqPFrRF70e
        YmU04ZaQ5rKQ5VMKMsgUMKHd5iolqgsutkWwp3WFUJqX5qu3mmGVpMW3hOJYfO7y7/JYgV
        u7qmDwcS2qhlSR6voHEKX1ZT3wyKkHg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660753860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=38RIYwPJSBj+njOW8lX/s5pnoWS5wLKDA4I+GoOrolk=;
        b=bxE6BSRzRcXaMkPBdHgvifBPkiUT/7wcRlKEu8w1ntaybjmj/C1jUfyxcVWyuuCVZastXU
        CE8wYBxP5M0Yt7Dw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E3DB22C177;
        Wed, 17 Aug 2022 16:30:59 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3682CA066B; Wed, 17 Aug 2022 18:30:59 +0200 (CEST)
Date:   Wed, 17 Aug 2022 18:30:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Jan Kara <jack@suse.cz>,
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: stalling IO regression since linux 5.12, through 5.18
Message-ID: <20220817163059.kigrvdfmxfswmhls@quack3>
References: <e36fe80f-a33b-4750-b593-3108ba169611@www.fastmail.com>
 <CAEzrpqe3rRTvH=s+-aXTtupn-XaCxe0=KUe_iQfEyHWp-pXb5w@mail.gmail.com>
 <d48c7e95-e21e-dcdc-a776-8ae7bed566cb@kernel.dk>
 <61e5ccda-a527-4fea-9850-91095ffa91c4@www.fastmail.com>
 <4995baed-c561-421d-ba3e-3a75d6a738a3@www.fastmail.com>
 <dcd8beea-d2d9-e692-6e5d-c96b2d29dfd1@suse.com>
 <2b8a38fa-f15f-45e8-8caa-61c5f8cd52de@www.fastmail.com>
 <7c830487-95a6-b008-920b-8bc4a318f10a@applied-asynchrony.com>
 <20220817114933.66c4g4xjsi4df2tg@quack3>
 <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a141ae-56a7-4dcd-b75a-04be4b276b3a@www.fastmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-08-22 11:09:26, Chris Murphy wrote:
> 
> 
> On Wed, Aug 17, 2022, at 7:49 AM, Jan Kara wrote:
> 
> >
> > Another thing worth trying is to compile the kernel without
> > CONFIG_BFQ_GROUP_IOSCHED. That will essentially disable cgroup support in
> > BFQ so we will see whether the problem may be cgroup related or not.
> 
> The problem happens with a 5.12.0 kernel built without
> CONFIG_BFQ_GROUP_IOSCHED.

Thanks for testing! Just to answer your previous question: This is
different from cgroup.disable=io because BFQ takes different code paths. So
this makes it even less likely this is some obscure BFQ bug. Why BFQ could
be different here from mq-deadline is that it artificially reduces device
queue depth (it sets shallow_depth when allocating new tags) and maybe that
triggers some bug in request tag allocation.

BTW, are you sure the first problematic kernel is 5.12? Because support for
shared tagsets was added to megaraid_sas driver in 5.11 (5.11-rc3 in
particular - commit 81e7eb5bf08f3 ("Revert "Revert "scsi: megaraid_sas:
Added support for shared host tagset for cpuhotplug"")) and that is one
candidate I'd expect to start to trigger issues. BTW that may be an
interesting thing to try: Can you boot with
"megaraid_sas.host_tagset_enable = 0" kernel option and see whether the
issue reproduces?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
