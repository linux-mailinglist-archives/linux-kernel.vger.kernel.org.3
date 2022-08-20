Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CC59AD65
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 13:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344814AbiHTLIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 07:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiHTLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 07:08:35 -0400
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB991F2E0;
        Sat, 20 Aug 2022 04:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=JTIrzLLUmtdNk3vpLdYF+nCt0ZHai5j4nKsZ+Ta8gs4=; b=IIFOZTkhtU1A+ykBm9ttZA1mgI
        TqLV11CIqsdftIqo7hKm34Kl8HF5hmQhXwokPE1khGEl2YsqczLQJMVltQ3+BZM0OQy6e73hey5/C
        i5P+ZTmBrQpsj3bdUDpFAHpm3V4casSwWY3tZpkzQTM5FLWauUvQOA0O30jmwWg9GS2ZgIL0D/2f0
        hTd3/E56EaOf332F/38IhOQJ3povc8ghEDcxZCtsTjWEk/mZI1OKLQ1/w64zF1kkzKphA8bsYt93g
        oSiJnL4BrmW7r1RHOhplpMXUwAL9cmkm8vdFKq7ItRnN9GSLXXcu4yAn/r0kRvO7gMDcs2jzfSHW9
        igq8tFYw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1oPML7-000F9j-2f; Sat, 20 Aug 2022 13:08:29 +0200
Received: from [2001:a61:2a3c:f01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1oPML6-000Wqg-T8; Sat, 20 Aug 2022 13:08:28 +0200
Message-ID: <ff2bc13c-f66f-03f3-fc01-c4f962f7b694@metafoo.de>
Date:   Sat, 20 Aug 2022 13:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] iio: buffer: Silence lock nesting splat
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     kernel@axis.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Rosin <peda@axentia.se>
References: <20220816080828.1218667-1-vincent.whitchurch@axis.com>
 <20220820120640.6d1b928d@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20220820120640.6d1b928d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.6/26633/Sat Aug 20 09:52:13 2022)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/22 13:06, Jonathan Cameron wrote:
> On Tue, 16 Aug 2022 10:08:28 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
>
>> If an IIO driver uses callbacks from another IIO driver and calls
>> iio_channel_start_all_cb() from one of its buffer setup ops, then
>> lockdep complains due to the lock nesting, as in the below example with
>> lmp91000.  Since the locks are being taken on different IIO devices,
>> there is no actual deadlock, so add lock nesting annotation to silence
>> the spurious warning.
>>
>>   ============================================
>>   WARNING: possible recursive locking detected
>>   6.0.0-rc1+ #10 Not tainted
>>   --------------------------------------------
>>   python3/23 is trying to acquire lock:
>>   0000000064c944c0 (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers+0x62/0x180
>>
>>   but task is already holding lock:
>>   00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
>>
>>   other info that might help us debug this:
>>    Possible unsafe locking scenario:
>>
>>          CPU0
>>          ----
>>     lock(&indio_dev->mlock);
>>     lock(&indio_dev->mlock);
>>
>>    *** DEADLOCK ***
>>
>>    May be due to missing lock nesting notation
>>
>>   5 locks held by python3/23:
>>    #0: 00000000636b5420 (sb_writers#5){.+.+}-{0:0}, at: ksys_write+0x67/0x100
>>    #1: 0000000064c19280 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x13a/0x270
>>    #2: 0000000064c3d9e0 (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x149/0x270
>>    #3: 00000000636b64c0 (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store+0x4d/0x100
>>    #4: 0000000064c945c8 (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers+0x4f/0x180
>>
>>   stack backtrace:
>>   CPU: 0 PID: 23 Comm: python3 Not tainted 6.0.0-rc1+ #10
>>   Call Trace:
>>    dump_stack+0x1a/0x1c
>>    __lock_acquire.cold+0x407/0x42d
>>    lock_acquire+0x1ed/0x310
>>    __mutex_lock+0x72/0xde0
>>    mutex_lock_nested+0x1d/0x20
>>    iio_update_buffers+0x62/0x180
>>    iio_channel_start_all_cb+0x1c/0x20 [industrialio_buffer_cb]
>>    lmp91000_buffer_postenable+0x1b/0x20 [lmp91000]
>>    __iio_update_buffers+0x50b/0xd80
>>    enable_store+0x81/0x100
>>    dev_attr_store+0xf/0x20
>>    sysfs_kf_write+0x4c/0x70
>>    kernfs_fop_write_iter+0x179/0x270
>>    new_sync_write+0x99/0x120
>>    vfs_write+0x2c1/0x470
>>    ksys_write+0x67/0x100
>>    sys_write+0x10/0x20
>>
>> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> I'm wondering if this is sufficient.
> At first glance there are a whole bunch of other possible cases of this.
> Any consumer driver that calls iio_device_claim_direct_mode() would be a
> problem - though I'm not sure any do?
>
> I'm not sure I properly understand lockdep notations, but I thought the
> point was we needed to define a hierarchy?  To do that here we need
> an IIO driver that is a consumer to somehow let the IIO core know that
> and mark all calls to the locks appropriately.  This gets trickier
> as we allow 3+ levels of IIO drivers calling into each other.
>
> We should also think about how to prevent recursion if there are 3
> IIO drivers involved.

There are two different approaches for this kind of nested locking. One 
is to use mutex_lock_nested(). This works if there is a strict 
hierarchy. The I2C framework for example has a function to determine the 
position of a I2C mux in the hierarchy and uses that for locking. See 
https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L1151.

I'm not sure this directly translates to IIO since the 
consumers/producers don't have to be a in strict hierarchy.  And if it 
is a complex graph it can be difficult to figure out the right level for 
mutex_lock_nested().

The other method is to mark each mutex as its own class. lockdep does 
the lock checking based on the lock class and by default the same mutex 
of different instances is considered the same class to keep the resource 
requirements for the checker lower.

Regmap for example does this. See 
https://elixir.bootlin.com/linux/latest/source/drivers/base/regmap/regmap.c#L795.

This could be a solution for IIO with the downside how the additional 
work for the checker. But as long as there are only a few IIO devices 
per system that should be OK. We could also only set the per device lock 
class if in kernel consumers are enabled.


