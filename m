Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8B539102
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbiEaMqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 08:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344366AbiEaMqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 08:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAB41703CD
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654001169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Zn6MLya70ZcU9iC+dkrQ2V0ybC8+tbIlIVRcQTszCI=;
        b=fBbBu4T+Rnf7z+vu8cIbu/8pVVptQnT+o5+O9XLI0QxsqTowe5hjaIocZmFGkO6j/3fa9i
        b8WXfXZW31hJ5dyuekDkqy03fqC+M7sZqkXXOv5lFlcrBZHX0FdCUEk17kzgdcWpvU7cTf
        lLC1BYVueYZsSDwDgMZkIARd4e05Pkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-4_4enrFjPFOWqDYWfimTIQ-1; Tue, 31 May 2022 08:46:07 -0400
X-MC-Unique: 4_4enrFjPFOWqDYWfimTIQ-1
Received: by mail-wm1-f72.google.com with SMTP id o32-20020a05600c512000b0039c1c56e757so337249wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 05:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1Zn6MLya70ZcU9iC+dkrQ2V0ybC8+tbIlIVRcQTszCI=;
        b=K+AdBiOCwDzf8w99HWiWyP3PHJu3+f/2ScQgGQm2IRM++ngafAZ2OUiFsN7dRLxaBq
         FbvOTFmubBr+WTO79ONNqjTB3Apc166LvJxTVwEIm4zXXTcZA9ikhpKJ5MYHBYMsos1y
         hnbVyvev7YkWURxwAeVYnAoRHsikbCLiP+55y12brGfESxvaX1kM6MXIhlmCvdmCj6Iy
         2qGlK6CjB1YWKu5/M6CSWRbTViUxFnWs/Hb1xT2svmW0f8apFIGPou8snJ0KDZaPnpXt
         SQ8UAvmIFD8vfo+FTdi0rEbHi7N1uxw79IyXWn8un0gIldVyT6olwYYLoc84mx0wkQ8k
         pRIg==
X-Gm-Message-State: AOAM530a5QDjAX4v8+KTzkCto40w6T7OB+0LRUHy3iZPeUXUSi/7c8FJ
        Upcn1s2rQMf11IMWM39LhgWx0okOiPeXAuIiYh+zoevuLytxgGGbWIWOJRNKyYJAMuulQLea9pJ
        qaMxiyyZJDL6b7O/l1JVgR1Nw
X-Received: by 2002:adf:d18a:0:b0:210:414:ec4 with SMTP id v10-20020adfd18a000000b0021004140ec4mr13462709wrc.250.1654001166687;
        Tue, 31 May 2022 05:46:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1kiw481mMFAa3d4us5T2AirnJ+Rhn03hcvbb2cyLHAPEG9vGa9hCuyTE0lJO+6bKRJ4oNlA==
X-Received: by 2002:adf:d18a:0:b0:210:414:ec4 with SMTP id v10-20020adfd18a000000b0021004140ec4mr13462695wrc.250.1654001166471;
        Tue, 31 May 2022 05:46:06 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d62c2000000b00210335f7aaesm5793107wrv.35.2022.05.31.05.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 05:46:06 -0700 (PDT)
Message-ID: <cbd99278-89ff-0742-a4cb-99723c397e6c@redhat.com>
Date:   Tue, 31 May 2022 14:46:05 +0200
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
 <0ca7d264-2522-c820-d26e-19b6685d5016@redhat.com>
 <87czftq3g6.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87czftq3g6.fsf@mail.parknet.co.jp>
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

On 5/31/22 14:41, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>>> Main purpose of me is to consolidate helpers with vfat_rename(), and
>>> tweak coding style to use existent fat codes.
>>>
>>
>> Indeed. What do you think of the following plan for v4 ?
>>
>> 1) Keep patch "fat: add a vfat_rename2() and make existing .rename callback a helper"
>>    as the first patch of the series.
>> 2) Add a patch #2 with your authorship that adds the helper and use them in the
>>    vfat_rename() function.
>> 3) Make this patch "fat: add renameat2 RENAME_EXCHANGE flag support" to be patch #3
>>    and use the helpers introduced in patch #2.
>> 4) Make patch #4 to not only add a test for RENAME_EXCHANGE but also for renameat()
>>    and renameat2(..., RENAME_NOREPLACE). That way it will also cover your changes in
>>    patch #2.
> 
> I don't care much about it because whole is not big (in short, I'm ok
> with even one patch), so the point is the patches should be able to
> bisect easily if separated.
>

Yes, git bisect-ability is why I mentioned that we could do it in separate patches
but I'll integrate your changes now and see what approach I take depending on how
the code looks then.
 
>>>> +	/* update inode version and timestamps */
>>>> +	inode_inc_iversion(old_inode);
>>>> +	inode_inc_iversion(new_inode);
>>>
>>> Why do we need to update iversion of those inodes? I couldn't get intent
>>> of this.
>>>
>>
>> To be honest, I wasn't sure about this either but I saw that the implementation
>> of RENAME_EXCHANGE in other filesystems did. For example btrfs_rename_exchange().
> 
> Ok. If I'm not overlooking, it looks like only btrfs. Please remove
> those inode_inc_iversion() for {new,old}_inode.
>

Sure.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

