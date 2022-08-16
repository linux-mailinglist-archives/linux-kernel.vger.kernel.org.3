Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842CC596167
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiHPRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiHPRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1E4816B5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660672031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dj1tyTPGam6HV0rJ+pvzk7Sxt5XXudoZurS6UEBOfd8=;
        b=BRkDpEScQ07Z2oO1hwFLkMyP/kSRxe3MtaDLUkJg0sy2hMiBFNwnUQERiAW6KbGl7klwAU
        zJkyNHa9rukWjx+efVpzBYnGCyJ92CMEHahsEA6OGnsgVS4+JEiefGcCnILDaB+9fjwgdG
        SF/GMJdETRB9bMZDeIpxeHwbmipjwpM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-478-0ig2Rfh5PhG0lMNH0gLTRA-1; Tue, 16 Aug 2022 13:47:10 -0400
X-MC-Unique: 0ig2Rfh5PhG0lMNH0gLTRA-1
Received: by mail-qt1-f199.google.com with SMTP id b10-20020a05622a020a00b003437e336ca7so8207114qtx.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=dj1tyTPGam6HV0rJ+pvzk7Sxt5XXudoZurS6UEBOfd8=;
        b=7rWcs8fLgUJRgTF0nHds/hh4u5dHB5of6bTcHeyB5DTsE+ydKec6nTbFHE69qNZI1w
         FPpfJOr5/+QeOZwNFIqiCcsTkuRJyVUjckSNDY7W1XknYhtfLnheGVzl3urCO3004LQf
         pzZVz9CT14OsdthfxEKDJjL8O7DpykX67OO8ObSwgPzOesd3h3HRZekei9Njl68EFmNY
         fK1f0qUgDfc67lvU2sp3bzDqwFmOjT4gkeaw57Ns3FvVD9FcDWbDzpmXuBTGlqyhXUkl
         buf5j45pNr1JXJHDJgmSFdGEo7NMg28ogtUljCFlqV6fxzk40xQM5gPuEscyzM2x97hQ
         BhsQ==
X-Gm-Message-State: ACgBeo1wvVWOTbMHtnYg168oTD+ttt9YB3566AjdCPfvXGWm0tzs8H26
        9k+5TljJWPHbd8a6q7jkWlcAjeD214bdxzysLYFtYt5CLBtksBN3Ti+9Gs44vS1KkxEhlPbZTNz
        puVTP2kmp+W3WeZHirD7oOIQW
X-Received: by 2002:a05:622a:48f:b0:343:6db4:d3b1 with SMTP id p15-20020a05622a048f00b003436db4d3b1mr18670714qtx.202.1660672029631;
        Tue, 16 Aug 2022 10:47:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4CGS0h5qnYtWm8VGu9WljKt+S7Po/0MxXNws8lS+BhDcUz0su3oTtsN4AaftcVXNOu0jgH3Q==
X-Received: by 2002:a05:622a:48f:b0:343:6db4:d3b1 with SMTP id p15-20020a05622a048f00b003436db4d3b1mr18670696qtx.202.1660672029345;
        Tue, 16 Aug 2022 10:47:09 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id s14-20020a05620a254e00b0069fe1dfbeffsm11710245qko.92.2022.08.16.10.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 10:47:09 -0700 (PDT)
Message-ID: <3d76f4c3-916a-9abe-745f-e2781fad1b24@redhat.com>
Date:   Tue, 16 Aug 2022 13:47:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH net v3 2/2] bonding: 802.3ad: fix no transmission of
 LACPDUs
Content-Language: en-US
From:   Jonathan Toppins <jtoppins@redhat.com>
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     netdev@vger.kernel.org, liuhangbin@gmail.com,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <cover.1660572700.git.jtoppins@redhat.com>
 <0639f1e3d366c5098d561a947fd416fa5277e7f4.1660572700.git.jtoppins@redhat.com>
 <17000.1660655501@famine> <3d55690a-8932-4560-4267-ab28816fdb47@redhat.com>
In-Reply-To: <3d55690a-8932-4560-4267-ab28816fdb47@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/22 09:41, Jonathan Toppins wrote:
> On 8/16/22 09:11, Jay Vosburgh wrote:
>> Jonathan Toppins <jtoppins@redhat.com> wrote:
>>
>>> This is caused by the global variable ad_ticks_per_sec being zero as
>>> demonstrated by the reproducer script discussed below. This causes
>>> all timer values in __ad_timer_to_ticks to be zero, resulting
>>> in the periodic timer to never fire.
>>>
>>> To reproduce:
>>> Run the script in
>>> `tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh` 
>>> which
>>> puts bonding into a state where it never transmits LACPDUs.
>>>
>>> line 44: ip link add fbond type bond mode 4 miimon 200 \
>>>             xmit_hash_policy 1 ad_actor_sys_prio 65535 lacp_rate fast
>>> setting bond param: ad_actor_sys_prio
>>> given:
>>>     params.ad_actor_system = 0
>>> call stack:
>>>     bond_option_ad_actor_sys_prio()
>>>     -> bond_3ad_update_ad_actor_settings()
>>>        -> set ad.system.sys_priority = bond->params.ad_actor_sys_prio
>>>        -> ad.system.sys_mac_addr = bond->dev->dev_addr; because
>>>             params.ad_actor_system == 0
>>> results:
>>>      ad.system.sys_mac_addr = bond->dev->dev_addr
>>>
>>> line 48: ip link set fbond address 52:54:00:3B:7C:A6
>>> setting bond MAC addr
>>> call stack:
>>>     bond->dev->dev_addr = new_mac
>>>
>>> line 52: ip link set fbond type bond ad_actor_sys_prio 65535
>>> setting bond param: ad_actor_sys_prio
>>> given:
>>>     params.ad_actor_system = 0
>>> call stack:
>>>     bond_option_ad_actor_sys_prio()
>>>     -> bond_3ad_update_ad_actor_settings()
>>>        -> set ad.system.sys_priority = bond->params.ad_actor_sys_prio
>>>        -> ad.system.sys_mac_addr = bond->dev->dev_addr; because
>>>             params.ad_actor_system == 0
>>> results:
>>>      ad.system.sys_mac_addr = bond->dev->dev_addr
>>>
>>> line 60: ip link set veth1-bond down master fbond
>>> given:
>>>     params.ad_actor_system = 0
>>>     params.mode = BOND_MODE_8023AD
>>>     ad.system.sys_mac_addr == bond->dev->dev_addr
>>> call stack:
>>>     bond_enslave
>>>     -> bond_3ad_initialize(); because first slave
>>>        -> if ad.system.sys_mac_addr != bond->dev->dev_addr
>>>           return
>>> results:
>>>      Nothing is run in bond_3ad_initialize() because dev_add equals
>>>      sys_mac_addr leaving the global ad_ticks_per_sec zero as it is
>>>      never initialized anywhere else.
>>>
>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
>>> ---
>>>
>>> Notes:
>>>     v2:
>>>      * split this fix from the reproducer
>>>     v3:
>>>      * rebased to latest net/master
>>>
>>> drivers/net/bonding/bond_3ad.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_3ad.c 
>>> b/drivers/net/bonding/bond_3ad.c
>>> index d7fb33c078e8..957d30db6f95 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -84,7 +84,8 @@ enum ad_link_speed_type {
>>> static const u8 null_mac_addr[ETH_ALEN + 2] __long_aligned = {
>>>     0, 0, 0, 0, 0, 0
>>> };
>>> -static u16 ad_ticks_per_sec;
>>> +
>>> +static u16 ad_ticks_per_sec = 1000 / AD_TIMER_INTERVAL;
>>> static const int ad_delta_in_ticks = (AD_TIMER_INTERVAL * HZ) / 1000;
>>
>>     I still feel like this is kind of a hack, as it's not really
>> fixing bond_3ad_initialize to actually work (which is the real problem
>> as I understand it).  If it's ok to skip all that for this case, then
>> why do we ever need to call bond_3ad_initialize?
>>
> 
> The way it is currently written you still need to call 
> bond_3ad_initialize() just not for setting the tick resolution. The 
> issue here is ad_ticks_per_sec is used in several places to calculate 
> timer periods, __ad_timer_to_ticks(), for various timers in the 802.3ad 
> protocol. And if this variable, ad_ticks_per_sec, is left uninitialized 
> all of these timer periods go to zero. Since the value passed in 
> bond_3ad_initialize() is an immediate value I simply moved it off of the 
> call stack and set the static global variable instead.
> 
> To fix bond_3ad_initialize(), probably something like the below is 
> needed, but I do not understand why the guard if check was placed in 
> bond_3ad_initialize().

I looked at the history of the if guard in bond_3ad_initialize and it 
has existed since the creation of the git tree. It appears since commit 
5ee14e6d336f ("bonding: 3ad: apply ad_actor settings changes 
immediately") the if guard is no longer needed and removing the if guard 
would also fix the problem, I have not tested yet.

I think this patch series can be accepted as-is because, it does fix the 
issue as demonstrated by the kselftest accompanying the series and is 
the smallest change to fix the issue.

Further, I don't see why we want to set the file-scoped variable, 
ad_ticks_per_sec, inside bond_3ad_initialize() as ad_ticks_per_sec is 
utilized across all bonds. It seems like ad_ticks_per_sec should be 
changed to a const and set at the top of the file. I see no value in 
passing the value as an unnamed constant on the stack when 
bond_3ad_initialize is called. These changes however could be done in 
the net-next tree as follow-on cleanup patches.

Jay, how would you like to proceed?

[...]

Thanks,
-Jon

