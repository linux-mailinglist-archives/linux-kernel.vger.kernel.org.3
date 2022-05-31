Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4B53906E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbiEaMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344151AbiEaMPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C6E986FF
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653999306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uobJn9br2pmyrlhooRHaIeohn31rEn/SyxjNYRcdyGM=;
        b=C2AUSDezq9iKM49oGCPrPJXRU6mMj1nWc/ZLF9QLJWgx8anYPsOAt5jLK/GBKmTfjNyeid
        kAjPy5rECV2/W2Smc2xjs7Kd5JNBUcIwz4rKG1I5TURvqMCIskS6/NnG8QBPQ6lVHsiLxT
        iM8kbb+K4aq9AbtIBNfM9ZNIWP0M8yk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-7z6m3Kc4NZCsqijZBLX3yw-1; Tue, 31 May 2022 08:15:05 -0400
X-MC-Unique: 7z6m3Kc4NZCsqijZBLX3yw-1
Received: by mail-wm1-f72.google.com with SMTP id o23-20020a05600c511700b0039743cd8093so1196867wms.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uobJn9br2pmyrlhooRHaIeohn31rEn/SyxjNYRcdyGM=;
        b=0yGUJgH09yPENYTS/YgzX9Tq2bfmx0VMdmrtYoD9yuoVgpomnIvD+H/p9suCkrA4CA
         As2CsLrp4W9yeD9kUgCVHu6iY/3TVQb7/JVxUMs3LLUlo9E0R/SmbBXYJVEK9JL1Duuk
         yfcTzz2IRo8s269bJvAtCl/qk1hDuq6H1lfuuq/r5U0TqB6qLB+p+7u6a+vsYyWRUe3D
         SiJm+33HSPrx8WXC+qBCk++XmQ1RmDNOGugStlBEEoxTrnavAlMvM/H8x+HXFKGitYR4
         VSRFnOzMgmd0GH3zxXek4/3FsteT6Fl9G6L/B1o1L+Hv6B7E772d0frWvhbBustg1rtp
         wqxw==
X-Gm-Message-State: AOAM531iPe1O1KP5XXBuGYZqaUPS92hf8ohnD1B2cNQW8P1tJzo6B1aE
        1S6lqRzYjjidPLEdSULt7vPfuHlynOeA6EdQavzbOK4y3+8U2Bwp6i+3JF3zUh3c0DcC5yx9563
        Sa9tuP/nEvWVBINqWmPvu0LSh
X-Received: by 2002:a05:600c:190d:b0:394:8241:6454 with SMTP id j13-20020a05600c190d00b0039482416454mr23677381wmq.198.1653999304427;
        Tue, 31 May 2022 05:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPw+MnjvE4Pc+da7FNOd5kxrbnSrtH04dSueibN30pk6NTXhJZZS/2cnQ8/x+fKeocqnmGWw==
X-Received: by 2002:a05:600c:190d:b0:394:8241:6454 with SMTP id j13-20020a05600c190d00b0039482416454mr23677357wmq.198.1653999304124;
        Tue, 31 May 2022 05:15:04 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b0039756cdc8e1sm2113919wms.37.2022.05.31.05.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 05:15:03 -0700 (PDT)
Message-ID: <0ca7d264-2522-c820-d26e-19b6685d5016@redhat.com>
Date:   Tue, 31 May 2022 14:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v3 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org,
        Christian Kellner <ckellner@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Chung-Chiang Cheng <cccheng@synology.com>
References: <20220526134119.242182-1-javierm@redhat.com>
 <20220526134119.242182-3-javierm@redhat.com>
 <87ilpmows4.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87ilpmows4.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello OGAWA,

Thanks a lot for your feedback and comments.

On 5/31/22 11:51, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>> The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
>> but is currently not supported by the Linux vfat filesystem driver.
>>
>> Add a vfat_rename_exchange() helper function that implements this support.
>>
>> The super block lock is acquired during the operation to ensure atomicity,
>> and in the error path actions made are reversed also with the mutex held.
>>
>> It makes the operation as transactional as possible, within the limitation
>> impossed by vfat due not having a journal with logs to replay.
> 
> I tweaked your patch (tested only slightly), can you review and merge to
> this patch if ok?
>

Your changes make a lot of sense to me and from a quick glance they look OK
to me. I'll look at them in more detail when merging the changes for a v4.
 
> Main purpose of me is to consolidate helpers with vfat_rename(), and
> tweak coding style to use existent fat codes.
>

Indeed. What do you think of the following plan for v4 ?

1) Keep patch "fat: add a vfat_rename2() and make existing .rename callback a helper"
   as the first patch of the series.
2) Add a patch #2 with your authorship that adds the helper and use them in the
   vfat_rename() function.
3) Make this patch "fat: add renameat2 RENAME_EXCHANGE flag support" to be patch #3
   and use the helpers introduced in patch #2.
4) Make patch #4 to not only add a test for RENAME_EXCHANGE but also for renameat()
   and renameat2(..., RENAME_NOREPLACE). That way it will also cover your changes in
   patch #2.

>> +	if (old_dir != new_dir) {
>> +		err = vfat_get_dotdot_info(old_inode, &old_dotdot_bh, &old_dotdot_de);
>> +		if (err)
>> +			goto out;
>> +
>> +		err = vfat_get_dotdot_info(new_inode, &new_dotdot_bh, &new_dotdot_de);
>> +		if (err)
>> +			goto out;
> 
> This should not return -ENOENT here. I tweaked to return -EIO in my patch.
>

Got it. I'm OK with that.

>> +	/* update inode version and timestamps */
>> +	inode_inc_iversion(old_inode);
>> +	inode_inc_iversion(new_inode);
> 
> Why do we need to update iversion of those inodes? I couldn't get intent
> of this.
>

To be honest, I wasn't sure about this either but I saw that the implementation
of RENAME_EXCHANGE in other filesystems did. For example btrfs_rename_exchange().
 
>> +error_new_dotdot:
>> +	/* data cluster is shared, serious corruption */
> 
> Sharing data cluster would happen here only if one inode success to sync
> and another one failed. Then so I/O error, we would not be able to do
> much for it.
>

I see. Thanks for the clarification.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

