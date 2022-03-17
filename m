Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D124DC5DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiCQMc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCQMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9A421E1132
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647520298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaOCXf24oWYbRv8MZqakanoQAYIqE6xVP77qrDYKtYI=;
        b=QmF00YsXIyLe4U+MAkQjA8ThUQ1GS0ACUaXtbWO0cp9DThYPD2JxBHei4gHcwx58QpzTQi
        7o/+1F+e+TrziGZe7IU6HjLDXz4ue3E8K8h3/CDejQKYKsDz5JHCytJk0zh5istfzNr0Ff
        czTpg9lDLCbULQg/AzUqLkF1czKXm40=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Pzve7InLNzyX8wDMZ-OBOg-1; Thu, 17 Mar 2022 08:31:37 -0400
X-MC-Unique: Pzve7InLNzyX8wDMZ-OBOg-1
Received: by mail-pf1-f200.google.com with SMTP id w68-20020a62dd47000000b004f6aa5e4824so3451817pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UaOCXf24oWYbRv8MZqakanoQAYIqE6xVP77qrDYKtYI=;
        b=2YO3MKGCOst0KyjNIvL/ZhfSVDVtrGj+IZoQMeiaHQtWVnK9Tdcf6a6tr2kLycBD/N
         M1lHw7f9mWX5LQxLdV2MEP/7sZGWYctYll6aNDC6EnnT8x9skrNVcklPsWp/PS1dgC3L
         RJM6ylIwpScMEhiJdlqDTqLx24vpxpeHGqd699+D9DTe872ybpBYV4xhvHkeQxh7V+MA
         WVXm86IYIHWPpB8c+yQ/KIJpdGSnhkqse/d/3ufvZ4JA1MdB4v0IA5zNRYObbH2ZkpMG
         +I2PPiWQE4hs+0NIeaiViE3ASf/5LQkD6kfQo69PMIkRNf75hVKIs3b2kguHt5qwZ5UM
         1LPQ==
X-Gm-Message-State: AOAM530rsDogCi2t0RJhA52b0VoMR3sl9HYlD8K4UoVfyUJtGr2Xv+Ii
        IhklEci9f/jh9MrGs07nmXJ/Ch9OmKwtztBRTlDCvj0hwDoq7ot1Y6W6GNJLMxxFbT1dy9mhKfn
        hewxzdeMMX3zFyfbOveLZO31lE/ZR3j7DMbhnPR1wlXIzaT5qeeE4OKAPLSDWcw1ndSZACadYWg
        ==
X-Received: by 2002:a17:90b:3143:b0:1bf:8187:3689 with SMTP id ip3-20020a17090b314300b001bf81873689mr5033523pjb.184.1647520296204;
        Thu, 17 Mar 2022 05:31:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvBacSbBegebtK1P3W+e9X2It5K6R38wFE2UZ18fAbbih712B2obDUkKCk5xd4zbFBtmXRJA==
X-Received: by 2002:a17:90b:3143:b0:1bf:8187:3689 with SMTP id ip3-20020a17090b314300b001bf81873689mr5033481pjb.184.1647520295811;
        Thu, 17 Mar 2022 05:31:35 -0700 (PDT)
Received: from [10.72.12.110] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm9133093pjq.17.2022.03.17.05.31.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 05:31:34 -0700 (PDT)
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
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <a4d26edc-a65f-27e2-2ea9-ef43f364eb9b@redhat.com>
Date:   Thu, 17 Mar 2022 20:31:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c2f494b61674e63985e4e2a0fb3b6c503e17334b.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/22 8:01 PM, Jeff Layton wrote:
> On Thu, 2022-03-17 at 11:11 +0000, Luís Henriques wrote:
>> Xiubo Li <xiubli@redhat.com> writes:
>>
>>> On 3/17/22 6:01 PM, Jeff Layton wrote:
>>>> I'm not sure we want to worry about .snap directories here since they
>>>> aren't "real". IIRC, snaps are inherited from parents too, so you could
>>>> do something like
>>>>
>>>>       mkdir dir1
>>>>       mkdir dir1/.snap/snap1
>>>>       mkdir dir1/dir2
>>>>       fscrypt encrypt dir1/dir2
>>>>
>>>> There should be nothing to prevent encrypting dir2, but I'm pretty sure
>>>> dir2/.snap will not be empty at that point.
>>> If we don't take care of this. Then we don't know which snapshots should do
>>> encrypt/dencrypt and which shouldn't when building the path in lookup and when
>>> reading the snapdir ?
>> In my patchset (which I plan to send a new revision later today, I think I
>> still need to rebase it) this is handled by using the *real* snapshot
>> parent inode.  If we're decrypting/encrypting a name for a snapshot that
>> starts with a '_' character, we first find the parent inode for that
>> snapshot and only do the operation if that parent is encrypted.
>>
>> In the other email I suggested that we could prevent enabling encryption
>> in a directory when there are snapshots above in the hierarchy.  But now
>> that I think more about it, it won't solve any problem because you could
>> create those snapshots later and then you would still need to handle these
>> (non-encrypted) "_name_xxxx" snapshots anyway.
>>
> Yeah, that sounds about right.
>
> What happens if you don't have the snapshot parent's inode in cache?
> That can happen if you (e.g.) are running NFS over ceph, or if you get
> crafty with name_to_handle_at() and open_by_handle_at().
>
> Do we have to do a LOOKUPINO in that case or does the trace contain that
> info? If it doesn't then that could really suck in a big hierarchy if
> there are a lot of different snapshot parent inodes to hunt down.
>
> I think this is a case where the client just doesn't have complete
> control over the dentry name. It may be better to just not encrypt them
> if it's too ugly.
>
> Another idea might be to just use the same parent inode (maybe the
> root?) for all snapshot names. It's not as secure, but it's probably
> better than nothing.

Does it allow to have different keys for the subdirs in the hierarchy ? 
 From my test it doesn't.

If so we can always use the same oldest ancestor in the hierarchy, who 
has encryption key, to encyrpt/decrypt all the .snap in the hierarchy, 
then just need to lookup oldest ancestor inode only once.

-- Xiubo


