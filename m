Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE06E4E1EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbiCUBqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbiCUBqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 387CF5F45
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647827120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mrGOJLeYO4kxv1PcAb4WwM1yZJ2NAcruFxRY/Piqipk=;
        b=ZrJ6IF+muhmAN6fKnVMSWlwzJz+zm9Ha985R9oNw93rUnWcxXXQZsBeiUU/lHqXy0mRkeB
        C0xOZBcpAFXSgnIXbD27T+LiC8Ehp1RN7mKTjTEd6FUcJ9NkGeoZPJKL0QGLgehnA56Jqz
        4CIL0ONyADLJ3bmulvE1JZn23ZgCwAE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-EKdlQwU1PSWgwAApJ67MaA-1; Sun, 20 Mar 2022 21:45:18 -0400
X-MC-Unique: EKdlQwU1PSWgwAApJ67MaA-1
Received: by mail-pl1-f199.google.com with SMTP id n17-20020a170902f61100b001538c882549so4963087plg.18
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mrGOJLeYO4kxv1PcAb4WwM1yZJ2NAcruFxRY/Piqipk=;
        b=zxKVfb3Huuuzx9LoMNGf93nPmyCgj5BL3hfyptuv2N7zBi8fb6Wad2EdaBuAAhX9FE
         9SG6VtAggZvTEjQvBfmw+TKZuF8e3R5JN4tEgVvnCP4E6DWXIS+JafbcO6r29S2b980N
         cK85fzRufDdCgkCco+381v+d8hjdn+r+wQ9JdwT5v4nFnF+PuwWVE3Bm6zRor7yhT9BW
         hLyNL8TAPFxtZ66qRbB+Hvj9fxdZ9/4coxjLQguO95PMhgh/F1BFp9hjMdvQ8bE6zP2O
         9p+kiwajuPxdAhKuGdup1/jc8qJ5Jc08YLnDDCeBVCQC0idfn9Gz3puy9B1qBmMSvPLy
         oAGg==
X-Gm-Message-State: AOAM531isX0Uqvl0jNBr/8SkQpRxnQklpcBT6v3ntUtJ2JuGyyk1UWau
        +Ki+4M3kEZHveVG/cV6xr6TGGMVl/o/6nKVmpN0bGYd2tIUlL57yX+MUxQBOT9Enl5lkmLE1SML
        V4k3s2AyaesxlNv2GU2vK/y8w
X-Received: by 2002:a17:903:404b:b0:154:297b:7125 with SMTP id n11-20020a170903404b00b00154297b7125mr9676478pla.11.1647827117632;
        Sun, 20 Mar 2022 18:45:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysQCPDHeU47c8jpQLkfUpZf+9xpLC0+nNHh3e0J3hAwhF8jvdr0t58bH/P0+tdQeNlmTwPDw==
X-Received: by 2002:a17:903:404b:b0:154:297b:7125 with SMTP id n11-20020a170903404b00b00154297b7125mr9676460pla.11.1647827117312;
        Sun, 20 Mar 2022 18:45:17 -0700 (PDT)
Received: from localhost ([240e:3a1:2e5:800:f995:6136:f760:a3d0])
        by smtp.gmail.com with ESMTPSA id o65-20020a17090a0a4700b001bef5cffea7sm18971387pjo.0.2022.03.20.18.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 18:45:16 -0700 (PDT)
Date:   Mon, 21 Mar 2022 09:41:50 +0800
From:   Coiby Xu <coxu@redhat.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     kexec@lists.infradead.org, Milan Broz <gmazyland@gmail.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
        Mike Snitzer <snitzer@redhat.com>, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/4] Support kdump with LUKS encryption by reusing LUKS
 master key
Message-ID: <20220321014150.w6wux5azabweu7dr@Rk>
References: <20220318103423.286410-1-coxu@redhat.com>
 <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c06a21cc-e1c1-e627-f908-ebc2a041e29a@igalia.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 05:13:21PM -0300, Guilherme G. Piccoli wrote:
>On 18/03/2022 07:34, Coiby Xu wrote:
>> [...]
>> Based on Milan's feedback [1] on Kairui's ideas to support kdump with
>> LUKS encryption, this patch set addresses the above issues by
>>  1) first saving the LUKS master key to kexec when opening the encrypted
>>     device
>>  2) then saving the master key to the reserved memory for kdump when
>>     loading kdump kernel image.
>>
>> So the LUKS master key never leaves the kernel space and once the key has
>> been saved to the reserved memory for kdump, it would be wiped
>> immediately. If there is no security concern with this approach or any
>> other concern, I will drop the following assumptions made for this RFC
>> version in v1,
>>  - only x86 is supported
>>  - there is only one LUKS device for the system
>>
>> to extend the support to other architectures including POWER, ARM and
>> s390x and address the case of multiple LUKS devices. Any feedback will be
>> appreciated, thanks!
>>
>
>Hi Coiby, thanks for the very interesting work!

Hi Guilherme,

I'm glad this work interests you and thanks for sharing your thoughts!

>I confess I didn't review the code as I have not much experience in
>dm-crypt/key management, but I have a generic question related with the
>motivation of the patch set.
>
>My understanding is that one (the main?) motivation of this series would
>be to protect the saved memory (vmcore) from being read by some
>"unauthorized" entity - in order to achieve this goal, it is hereby
>proposed to allow kdump kernel to access a memory-saved key and with
>that, mount an encrypted volume, saving the vmcore over there correct?

>
>So, what if instead of playing with the volume key, users with this
>concern address that by reserving some *unencrypted partition* for
>saving the vmcore, but then *encrypt the vmcore* itself! So, instead of
>requiring saving a full-volume key, mount everything, risk data
>corruption if something goes bad...we just have makedumpfile encrypting
>the vmcore with some preloaded key (which might be saved inside the
>kdump minimal intird, for example), and saving the encrypted file into a
>clear/unencrypted volume? This way we also prevent excessive memory
>consumption during kdump due to the lvm/dm-userspace paraphernalia usage.

I believe some users have security concern for where to save vmcore.
This use case exactly fits your description and your proposed solution
shall be good for this type of users. But I think many more users may
just choose to encrypt the hard drive when installing the system and
they would naturally expect kdump to work for the case of full disk
encryption. So your proposed solution may not address the latter case 
where there is a much large user base.

>
>Does it make sense or am I being silly or missing something?
>Cheers,
>
>
>Guilherme
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec
>

-- 
Best regards,
Coiby

