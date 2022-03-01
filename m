Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BEE4C81A1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 04:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiCADas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 22:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCADar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 22:30:47 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4E86E8D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 19:30:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E55E219A6;
        Tue,  1 Mar 2022 03:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646105405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amRql2OSifwDnMAJL8/238tLYYm1geBZTyNb+J/J5JA=;
        b=GkO1RUbcIRDbBCTKpoHK/XgB7T7pycbqRlZiHjWMyYPtQz799SdXOGArNfPTKDenlvaNhe
        tp9AZqw7DYsgL9qhnkeDPnVx11SCEjUk77K1volH2Jf5FVwH1+37p9awpQcEb6uioG8Oby
        d9KUd9rbWXvJ5ZlaShDoKUu8d7v1A+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646105405;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amRql2OSifwDnMAJL8/238tLYYm1geBZTyNb+J/J5JA=;
        b=b/8i+0AkMC/6pODT8F8eIhKH9YDMyi22Q5LdsklgO2aNjgkeJ6fH0yV1kbm0v7Z/chzSQ/
        Q9XAh8o+OFVO8BAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71B9513AF5;
        Tue,  1 Mar 2022 03:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cBklDTyTHWJ3aQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 01 Mar 2022 03:30:04 +0000
Date:   Tue, 1 Mar 2022 00:30:01 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: trigger disk activity LED
Message-ID: <20220301033001.tozk6cakdznww6wi@cyberdelia>
References: <20220227234258.24619-1-ematsumiya@suse.de>
 <20220228092215.GA8549@lst.de>
 <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <36cfd242-6bb0-0af6-0faf-946c79baa378@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/28, Jens Axboe wrote:
>On 2/28/22 2:22 AM, Christoph Hellwig wrote:
>> I don't think we should add code to the absolutel fast path for
>> blinkenlights.
>
>Agree. It'd be a lot better to put the cost on the led trigger
>side, and not need anything in the fast path for block devices.
>Monitor disk stats, or something like that.

There's been at least 4 attempts to do so, as far as I'm aware (one of
them being mine). All got rejected due to the complexity it introduced,
that's how I ended up with this one-liner.

Performance-wise, I'm understand the problems, but according to ftrace,
ledtrig_disk_activity() adds an average of 0.2us overhead, whether an
LED is assigned or not. Is that really unacceptable?

If so, would introducing a CONFIG_NVME_LED (default =n) and wrap that
call around it make it better? Then at least there's a chance to inform
users that desires this feature about performance costs.


Cheers,

Enzo
