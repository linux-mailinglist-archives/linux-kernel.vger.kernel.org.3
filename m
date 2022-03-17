Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA94DC5F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiCQMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiCQMqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:46:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E027EF7F5E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647521084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMMzKWFseA5pvZnvZFNeWATrNWxH9U0hOpDhOpSAHMA=;
        b=BeV4UdvHsaNXjLfUXTpgT/A3H4YoPsGb08PYrLkVJI9AMjRbbsgUjiiwszZ8TEJtJcuhXA
        dEXU2gNoj85L4fmih6bWyliWvBvUAV3SfwBDS0EivgWRgyML6PQjBxIzDgp1RCwpcyIK6v
        EMmrHG4++qS2pDJv5pkkPKRtJQorQOs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-N71vfJhyNWuA85IINCGVwg-1; Thu, 17 Mar 2022 08:44:43 -0400
X-MC-Unique: N71vfJhyNWuA85IINCGVwg-1
Received: by mail-pj1-f72.google.com with SMTP id lp2-20020a17090b4a8200b001bc449ecbceso6223531pjb.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qMMzKWFseA5pvZnvZFNeWATrNWxH9U0hOpDhOpSAHMA=;
        b=VwAVEO37WokLBu7MtKIhzlhNS/ieS6Ag+F6bnRQHbiKKk/qNn0epn/G7Sjxmh6DrE7
         BPzY3UbZuSRlyaEiGAm9HbmJWyQ0SLwUT6DE32AXY/1vm4cOk2D1AOd+mrasvuHMaYFL
         conH6c4akhms2lyWny9zTY4NcYAJyWxgxYC1nosXhMKq94yx4lScqczmRVvIEVCmX2V3
         +l1oLzt01XFJiwlXyoYuqBldhXq4xrCbqXPtytqZJVuR+mRppaO3k2zgNPiyRq1h7TCs
         lV0ubHcMkXXb9DMyRoAQX1R72//CkuI9kvyXMMONkR2UR7N/0ZAGoGCBcZXCG7FA6cRb
         GEcQ==
X-Gm-Message-State: AOAM531douc5oid6fE0Dfd77WUVv4cTrJMFo/NSDH51pqhUrTR++pcLO
        1TCI5Qdo2Sjr/ye8YqrdfO/BjIDFH/HK02uhWbGU0FZ4GbTaPMGf4qU6tSZJ6ReiK8xczR786vc
        JnkqXhw5W77h+GhXzbT53oRXO9EUjUCHfb52bs+ZKFqFqdHVoWsQdqUTHwrVHHlEjjzvRzhR3wg
        ==
X-Received: by 2002:a17:903:18b:b0:151:efb5:778 with SMTP id z11-20020a170903018b00b00151efb50778mr4910761plg.45.1647521081654;
        Thu, 17 Mar 2022 05:44:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIgTyejXrAySnL1Eq9BOZqMWOd0RvmJOndJCN1VReO/UPbivuId+iGemQGSvzVIZFxqWS8og==
X-Received: by 2002:a17:903:18b:b0:151:efb5:778 with SMTP id z11-20020a170903018b00b00151efb50778mr4910728plg.45.1647521081288;
        Thu, 17 Mar 2022 05:44:41 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o5-20020a655bc5000000b00372f7ecfcecsm5207974pgr.37.2022.03.17.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 05:44:40 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] ceph: add support for snapshot names
 encryption
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
Cc:     Ilya Dryomov <idryomov@gmail.com>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <20220315161959.19453-1-lhenriques@suse.de>
 <5b53e812-d49b-45f0-1219-3dbc96febbc1@redhat.com>
 <329abedd9d9938de95bf4f5600acdcd6a846e6be.camel@kernel.org>
 <3c8b78c4-5392-b81c-e76f-64fcce4f3c0f@redhat.com>
 <87wngshlzb.fsf@brahms.olymp>
 <c2f494b61674e63985e4e2a0fb3b6c503e17334b.camel@kernel.org>
 <a4d26edc-a65f-27e2-2ea9-ef43f364eb9b@redhat.com>
 <93ac97c750456fe77d33f432629bad209dc14e81.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <83db0781-2e9a-55e1-fb0b-ee0923f0b11a@redhat.com>
Date:   Thu, 17 Mar 2022 20:44:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <93ac97c750456fe77d33f432629bad209dc14e81.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/22 8:41 PM, Jeff Layton wrote:
> On Thu, 2022-03-17 at 20:31 +0800, Xiubo Li wrote:
>> On 3/17/22 8:01 PM, Jeff Layton wrote:
>>> On Thu, 2022-03-17 at 11:11 +0000, Luís Henriques wrote:
>>>> Xiubo Li <xiubli@redhat.com> writes:
>>>>
>>>>> On 3/17/22 6:01 PM, Jeff Layton wrote:
>>>>>> I'm not sure we want to worry about .snap directories here since they
>>>>>> aren't "real". IIRC, snaps are inherited from parents too, so you could
>>>>>> do something like
>>>>>>
>>>>>>        mkdir dir1
>>>>>>        mkdir dir1/.snap/snap1
>>>>>>        mkdir dir1/dir2
>>>>>>        fscrypt encrypt dir1/dir2
>>>>>>
>>>>>> There should be nothing to prevent encrypting dir2, but I'm pretty sure
>>>>>> dir2/.snap will not be empty at that point.
>>>>> If we don't take care of this. Then we don't know which snapshots should do
>>>>> encrypt/dencrypt and which shouldn't when building the path in lookup and when
>>>>> reading the snapdir ?
>>>> In my patchset (which I plan to send a new revision later today, I think I
>>>> still need to rebase it) this is handled by using the *real* snapshot
>>>> parent inode.  If we're decrypting/encrypting a name for a snapshot that
>>>> starts with a '_' character, we first find the parent inode for that
>>>> snapshot and only do the operation if that parent is encrypted.
>>>>
>>>> In the other email I suggested that we could prevent enabling encryption
>>>> in a directory when there are snapshots above in the hierarchy.  But now
>>>> that I think more about it, it won't solve any problem because you could
>>>> create those snapshots later and then you would still need to handle these
>>>> (non-encrypted) "_name_xxxx" snapshots anyway.
>>>>
>>> Yeah, that sounds about right.
>>>
>>> What happens if you don't have the snapshot parent's inode in cache?
>>> That can happen if you (e.g.) are running NFS over ceph, or if you get
>>> crafty with name_to_handle_at() and open_by_handle_at().
>>>
>>> Do we have to do a LOOKUPINO in that case or does the trace contain that
>>> info? If it doesn't then that could really suck in a big hierarchy if
>>> there are a lot of different snapshot parent inodes to hunt down.
>>>
>>> I think this is a case where the client just doesn't have complete
>>> control over the dentry name. It may be better to just not encrypt them
>>> if it's too ugly.
>>>
>>> Another idea might be to just use the same parent inode (maybe the
>>> root?) for all snapshot names. It's not as secure, but it's probably
>>> better than nothing.
>> Does it allow to have different keys for the subdirs in the hierarchy ?
>>   From my test it doesn't.
>>
> No. Once you set a key on directory you can't set another on a subtree
> of it.
If so. Yeah, I think your approach mentioned above is the best.
>> If so we can always use the same oldest ancestor in the hierarchy, who
>> has encryption key, to encyrpt/decrypt all the .snap in the hierarchy,
>> then just need to lookup oldest ancestor inode only once.
>>
Just like this.

-- Xiubo

> That's a possibility.

