Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5584DA2A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351155AbiCOSst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347480AbiCOSsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:48:47 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50754E390
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:47:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h63so4306357iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cIPs2FR2ApyCopO+HLMBaqkZDQxu1F/Xt97YZpRqbvQ=;
        b=mwMzvQstbyUqHMwavpoz/YeHSRNIQfWFTHo3Jz8ugO4WJQ4rc8TasuNrTwcze88TYi
         KB21PnA9aW1wgJsehUFFud68M2IZJL+kiRR4BpYP14mYwdGxe2OCqlAvHmjSWS5Fq+HW
         d810xykST7Zhv6y0yiY7hbWmiDlnB4ICa4COhB0EJ1iTRY3ET8cgU+UNvB8hG+PrlNzs
         QlV6E9OHeTUQh+QbUsNlOpUVPgJnkfWZwEXlcySYzzg9kniXJDyh2670qKmQLG8MnmDe
         CIfoS1GKkMg/DKGvRxHau2Nc5nzVKr4jikc0BRB5hBxd/N/MLSnHr1lyyh48KO22bUl3
         Pd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cIPs2FR2ApyCopO+HLMBaqkZDQxu1F/Xt97YZpRqbvQ=;
        b=nba75hNZIqbXo6DzQZE6vq//d7nXjT3TIOoZYtQ/DrHFpY01lmVvGGWZ3OLUqLQ1V3
         WMbTK/8yof3owS+XFuASz1/Pte9gliteESYevaaCBcV6hhiZ41WfYa9Easyz0xGNqzAo
         Arf3E5KrZ9sy7AJIzCejUJQxwhmWPJiXfxepVLv3iq7xMW829f91J6cz12CYStxXIJZZ
         0JcqW+IHgWfFgyccjw189r1IQ7EfBRs6/GyFzjaz3dVlDJHvKAalWSTeZeyX1KmyzRW0
         cKaEz12J7M+c6Cld3yRMufh+qGhBBHi5KdCldPVJYrYAm4snr9Q7SlO094qU8r+QUrOw
         kMSw==
X-Gm-Message-State: AOAM533x0hr/nYx4kxs5aBtdAC0yJGsDvzH8fNNfnFju4YZ/DpjwiHey
        ZDb8mT52ZAZpi/7stPQdbqrnbQ==
X-Google-Smtp-Source: ABdhPJycAQ7BbvL2ovGL5p618ppCCbLknLrruCnerQ0/nEraueDPerJPVuQUiaVbprg9Q2YdMZvJrQ==
X-Received: by 2002:a05:6638:4115:b0:319:d141:3db with SMTP id ay21-20020a056638411500b00319d14103dbmr19569856jab.26.1647370054025;
        Tue, 15 Mar 2022 11:47:34 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e0215c400b002c5fdff3087sm11673740ilu.29.2022.03.15.11.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 11:47:33 -0700 (PDT)
Message-ID: <1b7a45ff-31d4-4b5a-81e2-a35e7cb0b471@kernel.dk>
Date:   Tue, 15 Mar 2022 12:47:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] pata_parport: add driver (PARIDE replacement)
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312144415.20010-1-linux@zary.sk>
 <f8c176d4-74f0-3e4f-446f-2a5f8ace3b28@kernel.dk>
 <8f32b2ed-13d6-c357-e417-b86a57a285db@opensource.wdc.com>
 <202203151944.44834.linux@zary.sk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <202203151944.44834.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:44 PM, Ondrej Zary wrote:
> On Tuesday 15 March 2022 05:22:47 Damien Le Moal wrote:
>> On 3/15/22 05:29, Jens Axboe wrote:
>>> On 3/14/22 2:25 PM, Ondrej Zary wrote:
>>>> On Monday 14 March 2022 00:19:30 Jens Axboe wrote:
>>>>> On 3/13/22 1:15 PM, Ondrej Zary wrote:
>>>>>> On Saturday 12 March 2022 15:44:15 Ondrej Zary wrote:
>>>>>>> The pata_parport is a libata-based replacement of the old PARIDE
>>>>>>> subsystem - driver for parallel port IDE devices.
>>>>>>> It uses the original paride low-level protocol drivers but does not
>>>>>>> need the high-level drivers (pd, pcd, pf, pt, pg). The IDE devices
>>>>>>> behind parallel port adapters are handled by the ATA layer.
>>>>>>>
>>>>>>> This will allow paride and its high-level drivers to be removed.
>>>>>>>
>>>>>>> paride and pata_parport are mutually exclusive because the compiled
>>>>>>> protocol drivers are incompatible.
>>>>>>>
>>>>>>> Tested with Imation SuperDisk LS-120 and HP C4381A (both use EPAT
>>>>>>> chip).
>>>>>>>
>>>>>>> Note: EPP-32 mode is buggy in EPAT - and also in all other protocol
>>>>>>> drivers - they don't handle non-multiple-of-4 block transfers
>>>>>>> correctly. This causes problems with LS-120 drive.
>>>>>>> There is also another bug in EPAT: EPP modes don't work unless a 4-bit
>>>>>>> or 8-bit mode is used first (probably some initialization missing?).
>>>>>>> Once the device is initialized, EPP works until power cycle.
>>>>>>>
>>>>>>> So after device power on, you have to:
>>>>>>> echo "parport0 epat 0" >/sys/bus/pata_parport/new_device
>>>>>>> echo pata_parport.0 >/sys/bus/pata_parport/delete_device
>>>>>>> echo "parport0 epat 4" >/sys/bus/pata_parport/new_device
>>>>>>> (autoprobe will initialize correctly as it tries the slowest modes
>>>>>>> first but you'll get the broken EPP-32 mode)
>>>>>>
>>>>>> Found a bug - the same device can be registered multiple times. Fix
>>>>>> will be in v2. But this revealed a bigger problem: pi_connect can
>>>>>> sleep (uses parport_claim_or_block) and libata does not like that. Any
>>>>>> ideas how to fix this?
>>>>>
>>>>> I think you'd need two things here:
>>>>>
>>>>> - The blk-mq queue should be registered with BLK_MQ_F_BLOCKING, which
>>>>>   will allow blocking off the queue_rq path.
>>>>
>>>> My knowledge about blk-mq is exactly zero. After grepping the code, I
>>>> guess that BLK_MQ_F_BLOCKING should be used by the block device
>>>> drivers - sd and sr?
>>>
>>> The controller would set
>>>
>>> ->needs_blocking_queue_rq = true;
>>>
>>> or something, and we'd default to false. And if that is set, when the
>>> blk-mq queue is created, then we'd set BLK_MQ_F_BLOCKING upon creation
>>> if that flag is true.
>>>
>>> That's the block layer side. Then in libata you'd need to ensure that
>>> you check that same setting and invoke ata_qc_issue() appropriately.
>>>
>>> Very top level stuff, there might be more things lurking below. But
>>> you'll probably find them as you test this stuff...
>>
>> Yes, the ata_port spinlock being held when calling ata_qc_issue() is
>> mandatory. But since I am assuming that all the IDE devices connected to
>> this adapter are QD=1 maximum, there can only be only one command in
>> flight. So it may be OK to release that lock before calling pi_connect()
>> and retake it right after it. libsas actually does something similar
>> (for no good reasons in that case though).
>>
>> Jens point remain though that since pi_connect() can sleep, marking the
>> device queue with BLK_MQ_F_BLOCKING is mandatory.
>  
> Something like this? Requires Mike's SCSI BLK_MQ_F_BLOCKING patch:
> https://lore.kernel.org/all/20220308003957.123312-2-michael.christie%40oracle.com/
> 
> #define PATA_PARPORT_SHT(drv_name)      \
>         ATA_PIO_SHT(drv_name),          \
>         .queuecommand_blocks    = true,
> 
> static void pi_connect(struct ata_port *ap)
> {
> 	struct pi_adapter *pi = ap->host->private_data;
> 
> 	del_timer_sync(&pi->timer);
> 	if (!pi->claimed) {
> 		bool locked = spin_is_locked(ap->lock);
> 		pi->claimed = true;
> 		if (locked)
> 			spin_unlock(ap->lock);
> 		parport_claim_or_block(pi->pardev);
> 		if (locked)
> 			spin_lock(ap->lock);
> 		pi->proto->connect(pi);
> 	}
> }
> 
> spin_is_locked is needed because the lock is not always held. It seems
> to work - no more stack traces after device double registration (only
> ATA errors but that's expected).

That's a very bad paradigm. What if it is locked, but the caller isn't
the one that locked it? Would be better to either make the locking state
consistent, or provide an unlocked variant (if feasible, doesn't always
work if it's a provided helper already in a struct of ops), or even
resorting to passing in locking state as a last resort.

-- 
Jens Axboe

