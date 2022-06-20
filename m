Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0335510EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 09:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbiFTHDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 03:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiFTHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 03:03:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007AF75;
        Mon, 20 Jun 2022 00:03:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DEC921BDE;
        Mon, 20 Jun 2022 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655708630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H0q16aW3kW6fA8kDkHl20jQtDM1dBpQuVhUTEIizdo=;
        b=V6T2dTKjkLceY7I3m7AS1zeyrKzHlkZ9INvM0Kls8dGXwdzOWLJiriTPp1yCJ2hStCsu6M
        uUWC3J9mWoZtlwC6iI7jCuOe7sM9AnutT5bxhYMgXgqoPwIDXF3x0bn93baPeEi+ehyGBs
        P30bghw/ONtNOd8pDUAWXDdjEsrgRi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655708630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H0q16aW3kW6fA8kDkHl20jQtDM1dBpQuVhUTEIizdo=;
        b=BsrLKLG69OQGGSXaQr7EPXGS0C1nG9EcaAGRKyp3XBa7WM9yvgZbXaLu2GJ2mOJw590uk1
        hE8/X9o0CKKP84Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA17D134CA;
        Mon, 20 Jun 2022 07:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zmdkKtQbsGKtegAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 07:03:48 +0000
Message-ID: <2ea41701-8be5-f981-d178-0d8e703962e0@suse.de>
Date:   Mon, 20 Jun 2022 09:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC v2 03/18] scsi: core: Implement reserved command
 handling
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, martin.petersen@oracle.com, brking@us.ibm.com,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        chenxiang66@hisilicon.com
References: <1654770559-101375-1-git-send-email-john.garry@huawei.com>
 <1654770559-101375-4-git-send-email-john.garry@huawei.com>
 <b4a0ede5-95a3-4388-e808-7627b5484d01@opensource.wdc.com>
 <88d192b5-741b-7104-7f72-0178aa18bafb@suse.de>
 <20220620062828.GA10753@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220620062828.GA10753@lst.de>
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

On 6/20/22 08:28, Christoph Hellwig wrote:
> On Mon, Jun 20, 2022 at 08:24:24AM +0200, Hannes Reinecke wrote:
>> So my idea for SATA is simply _not_ to use reserved tags.
>> Any TMF functions (or the equivalent thereof) should always be sent as
>> non-NCQ commands. And when doing so we're back to QD=1 on SATA anyway, so
>> there _must_ be tags available. Consequently the main reason for having
>> reserved tags (namely to guarantee that tags are available for TMF) doesn't
>> apply here.
> 
> At least in the non-elevator case (which includes all passthrough I/O)
> request have tags assigned as soon as they are allocated.  So, we
> absolutely can have all tags allocated and then need to do a TMF.

SATA internals may come to the rescue here; if there's an error all NCQ 
commands are aborted. So we'll get at least one command tag back.
As for the command duration limits I'm still waiting for clarification
from Damien if we can reuse tags there.

But I do agree it's ugly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
