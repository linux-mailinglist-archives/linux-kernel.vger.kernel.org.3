Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91005313E9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbiEWPea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiEWPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DA534EA1F
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653320062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kS62TLggA7d4kYtFghh4t0qh5AGp4VCERVELUWHCR+g=;
        b=W4GD3miMzr9zByIqtaxf1ybzRQJM6jBUnxwXfBy6SFHVaMCCPUBeXVKQDMJpwQR6xcW/Ch
        q9rZdFcYMAHmrMzDr0QZClUgaGWZdMIi9yTS5usT0Hxo1GmucMNJnfm+I7ULDroAb8aTQB
        ggV0ATSSm8fLndxbyxWpYots026I7Jc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-tBKQHMkoOhWhcAWLdCvFiA-1; Mon, 23 May 2022 11:34:20 -0400
X-MC-Unique: tBKQHMkoOhWhcAWLdCvFiA-1
Received: by mail-wm1-f71.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so5810829wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kS62TLggA7d4kYtFghh4t0qh5AGp4VCERVELUWHCR+g=;
        b=itQsZqW/zgnygqXcueE9g0LqzjKlaDsfpHHz5OLLGqiiiuRtWYX2VYA9O9r6hiMSBS
         eOWBAe7sWKhJTe1Ki10HWPboZY/ctqOHK+7KpnswROXu9NC11+YBdnw6Ekn1hzzHwfXR
         wkO8G4gLhZkMJbOagl/+e4ue6xYCMZYrXYF0aCzDHpFi6EqkQJQi7QMSxeHBSOuval80
         +QR1Fvp7gNfuwlq7s6FiSLWzEFA2nBfc8kM8ayCX3X2il+MQSy31SDpyfc56Qxz8U1fP
         ueFJ+Nc0UWkGeHKbCmzbwdbhSdc/gTJfu1eIoQzm/NsmS8xYGpLFj12aSnNvD8bqwd+9
         B3LA==
X-Gm-Message-State: AOAM531lADmi2VmtGUd5OfKP85pNsnoiB7ok/+8PS3FEkbmCaZlmOfxu
        5G16hdvoVIh+eQ8J5ZIjj69Hh4jkS2FhVNgeSb91hCG8cogF725YPfphVVEY2v4FSsKGuVNqfYl
        mOW5+MebKj3+WmyAOxkc7nas5
X-Received: by 2002:a05:600c:4f4f:b0:394:97e1:ca99 with SMTP id m15-20020a05600c4f4f00b0039497e1ca99mr20705463wmq.143.1653320059459;
        Mon, 23 May 2022 08:34:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzohqvE3SaiMrjQcvbmhmEhj8s9YdHQ62Q3d5eMEn1Q2BwSSrKw1AK1OS7G4qtFk3qcqbotHw==
X-Received: by 2002:a05:600c:4f4f:b0:394:97e1:ca99 with SMTP id m15-20020a05600c4f4f00b0039497e1ca99mr20705438wmq.143.1653320059170;
        Mon, 23 May 2022 08:34:19 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f25-20020a7bc8d9000000b0039748be12dbsm3883414wml.47.2022.05.23.08.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 08:34:18 -0700 (PDT)
Message-ID: <6a6ca822-ac6a-8484-0bc8-aaa1dce3d8ef@redhat.com>
Date:   Mon, 23 May 2022 17:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 2/3] fat: add renameat2 RENAME_EXCHANGE flag support
Content-Language: en-US
To:     Colin Walters <walters@verbum.org>, linux-kernel@vger.kernel.org
Cc:     Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <20220519092343.2776414-1-javierm@redhat.com>
 <20220519092343.2776414-3-javierm@redhat.com>
 <7963aad6-203c-4da4-ba9f-cf716d350121@www.fastmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <7963aad6-203c-4da4-ba9f-cf716d350121@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Colin,

Thanks for your feedback.

On 5/23/22 12:40, Colin Walters wrote:
> On Thu, May 19, 2022, at 5:23 AM, Javier Martinez Canillas wrote:
>> The renameat2 RENAME_EXCHANGE flag allows to atomically exchange two paths
>> but is currently not supported by the Linux vfat filesystem driver.
>>
>> Add a vfat_rename_exchange() helper function that implements this support.
>>
>> The super block lock is acquired during the operation to ensure atomicity,
>> and in the error path actions made are reversed also with the mutex held,
>> making the whole operation transactional.
> 
> Transactional with respect to the mounted kernel, but AIUI because vfat does not have journaling, the semantics on hard failure are...unspecified?  Is it possible for example we could see no file at all in the destination path?
>

That's correct, it's transactional within the constraints imposed by vfat.
That is, there's no journal replay that would be done if something gets
corrupted in the filesystem.

But I believe that's also true with any journaled filesystem and GRUB too?
Since GRUB doesn't mount filesystems but just attempt to read it without
trying to do any journal replay. Even if is able to detect that something
is wrong with the filesystem, it just tries in an best effort basis, i.e:

https://git.savannah.gnu.org/cgit/grub.git/commit/?id=777276063e2

About the semantics for a hard failure, that's not documented in the man
page for the renameat(2) system call but what most filesystems do AFAICT
is revert the operation if possible and print an error.

I don't think that not having a file at all at destination is a possible
outcome of a failure since the function does a detach, attach and sync
and only the sync can fail.

If the sync fails, then the detach/attach are reverted and another sync
is attempted. If this succeeds, then the old state would be preserved
and if it fails, then no sync was made so it should be good too I think.

But I'm not a filesystem expert so maybe someone else more familiar with
vfat and filesystems in general could chime in.

> This relates to https://github.com/ostreedev/ostree/issues/1951
> 
> TL;DR I'd been thinking that in order to have things be maximally robust we need to:
> 
> 1. Write new desired bootloader config
> 2. fsync it
> 3. fsync containing directory (I guess for vfat really, syncfs())
> 4. remove old config, syncfs()
>

Yes, I've seen that issue before but I (wrongly) understood that it was a
way to workaround the lack of renameat2(..., RENAME_EXCHANGE) in vfat. On
a second read I see that you also mention the journaled fs writes vs no
replay in the bootloader issue that I mentioned above. So it makes sense
to do the two phase commit even for journaled filesystems.
 
> And here the bootloader would know to prefer the "new" file if it exists, and to delete the old one if it's still present on the next boot.
>

This is the disadvantage of this approach, that then we will need to make
all bootloaders aware of the two phase commit as well. I'm OK with that but
then I believe that we should document the expectations clearly as a part
of the https://systemd.io/BOOT_LOADER_SPECIFICATION/.

Anyways, I don't think this is the place to discuss this though and we should
just focus on the actual kernel patches :) 
 
> (Now obviously this is a small patch which will surely be generally useful, e.g. for tools that operate on things like mounted USB sticks, being able to do an atomic exchange at least from the running kernel PoV is just as useful as it is on other "regular" (and journaled) mounted filesystems)
>

Agreed. I think that it wouldn't hurt to have this implementation in vfat.
 
> So assuming we have this, I guess the flow could be:
> 
> 1. rename_exchange(old, new)
> 2. syncfs()
>

Correct. In fact, Alex pointed me out that I should do sync in the test too
before checking that the rename succeeded. I was mostly interested that the
logic worked even if only the in-memory representation or page cache was
used. But I've added a `sudo sync -f "${MNT_PATH}"` for the next iteration.
 
> ?  But that's assuming that the implementation of this doesn't e.g. have any "holes" where in theory we could flush an intermediate state.
> 

Ogawa said that didn't fully review it yet but gave useful feedback that I
will also address in the next version. As said, is my first contribution to
a filesystem driver so it would be good if people with more experience can
let me know if there are holes in the implementation.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

