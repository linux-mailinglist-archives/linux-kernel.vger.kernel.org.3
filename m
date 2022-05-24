Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900425323CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiEXHOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbiEXHOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:14:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6065D5DA;
        Tue, 24 May 2022 00:14:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB95F1F8B8;
        Tue, 24 May 2022 07:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653376452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0j+eGyIExxw/xCWRVi02HB4i2K9lQe+UZypWJ7Vo34=;
        b=NcY9en9mfR0ufFWjwKCLJCZhg2UJx0dSnuukRvQ9/GZsd1X6RwoZ4D/v3xSy05H7SG/SKs
        ijz/enAnj7z8V3y/g4iBc/2Yrl/6ih05ucelgpEuecPccuhWXle8TAkzTvDEjKrjbsIRu8
        Y+qzyAFx1JY1y94ObP8u0HeMiHkg1ks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653376452;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0j+eGyIExxw/xCWRVi02HB4i2K9lQe+UZypWJ7Vo34=;
        b=U2qG3aZqBm+6MXLn1ccnhetjs3ksEvlga9okE/jR3YPr4H7ATlUUkR6iPgmWHAjZaF+oTH
        x38VoXDTKmUE4sCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A61113ADF;
        Tue, 24 May 2022 07:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eUf7GMSFjGL1QQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 24 May 2022 07:14:12 +0000
Message-ID: <83ef402e-1cff-a675-eab6-9fac9bb7565d@suse.de>
Date:   Tue, 24 May 2022 09:14:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 2/7] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk, hch@lst.de,
        snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
        Johannes.Thumshirn@wdc.com
Cc:     linux-nvme@lists.infradead.org, dm-devel@redhat.com,
        dsterba@suse.com, jiangbo.365@bytedance.com,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com,
        linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161606eucas1p2676c4d47f9fcb145f69b29db1f04fe6e@eucas1p2.samsung.com>
 <20220523161601.58078-3-p.raghav@samsung.com>
 <a7a409dc-4cf3-7096-50f6-7f794d4a0b9b@suse.de>
 <214e0c82-ce20-ba0f-77bd-21f3b83fd1f1@samsung.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <214e0c82-ce20-ba0f-77bd-21f3b83fd1f1@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/22 09:10, Pankaj Raghav wrote:
> On 5/24/22 07:19, Hannes Reinecke wrote:
> 
>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>>> index c4e4c7071b7b..f5c7a41032ba 100644
>>> --- a/include/linux/blkdev.h
>>> +++ b/include/linux/blkdev.h
>>> @@ -676,6 +676,21 @@ static inline unsigned int
>>> blk_queue_zone_no(struct request_queue *q,
>>>        return div64_u64(sector, zone_sectors);
>>>    }
>>>    +static inline bool blk_queue_is_zone_start(struct request_queue *q,
>>> sector_t sec)
>>> +{
>>> +    sector_t zone_sectors = blk_queue_zone_sectors(q);
>>> +    u64 remainder = 0;
>>> +
>>> +    if (!blk_queue_is_zoned(q))
>>> +        return false;
>>> +
>>
>> Not sure if we need this here; surely blk_queue_zone_sectors() will
>> already barf, and none of the callers did this check.
>>
> I totally agree with you but all the other blk_queue_* functions had
> this defensive check and I didn't want to break that pattern:
> 
Ah, fair enough.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
