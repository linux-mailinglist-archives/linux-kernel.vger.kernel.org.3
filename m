Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7538654301C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiFHMSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbiFHMSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 151503207F0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 05:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654690731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6e94wVFgyA3yMZPhP+FJ+85je68iLfycTawkAGztOtg=;
        b=aQYX7HWTEvHXSvAW92RWYa4sQl7rrzCQkjzmUoQx7hn/Et8EPhDU7jQ+loIT/9nn5IkB2A
        5qgxFYlv+4D7F/o/XbablId2x/z19+SOv+lmEAn9aNUZCNhl2lPdtkwOlXkV8Fho0LEIEi
        mDKHoMC8z+urPCYVXIGvoLKJsFFLv0g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632--HEtOzmCNqaoa6MSFmhM0w-1; Wed, 08 Jun 2022 08:18:50 -0400
X-MC-Unique: -HEtOzmCNqaoa6MSFmhM0w-1
Received: by mail-wm1-f69.google.com with SMTP id az7-20020a05600c600700b0039c3ed7fa89so8548898wmb.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 05:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6e94wVFgyA3yMZPhP+FJ+85je68iLfycTawkAGztOtg=;
        b=7CxSjkeXxK4+31+vYCfADtwCPY0Rm/GJGWuRuuI94kc0BA9bLnjcCx4IeXXVRgg13x
         AMIiIfBGg1QErElG7AropNqSIhKdDWe6X6ludaWjCmK0/u1VVV3pAFegFQdJFFepP+XK
         +FTh4Fk1SQ2/Io+Fc2n869y34iL8KA0F+QzvdKLxwXNJxGjPfqZYPh11w7Jq0+KgEp7s
         22Qa9onixi56bDwXI+O40fpZVvooCLpgF0x5KmMDjnflzhHOfudnzTyI3GOV6sF9xQhd
         dNLmf29HR0JHVnnm0p/untlCYfbZI2S+eYZwZqdt+aF5xneF9Cb7QwvCKqsgIHU85tAH
         PrNQ==
X-Gm-Message-State: AOAM532NVs63vPShEs+eGUjCX/JCaaEJoxjNwbcassZpiq/uRUHFW7ov
        Ct17XHGxXUEdRoPIDSSEK1MaV0gmrHjYFqVDEpfgD0YDh7oZJi2j0986RuZcfZh4JYHZxWCX+e+
        MBzQ/aSDnEX6sUGSSQIIhZynb
X-Received: by 2002:a05:600c:4e8b:b0:39c:35da:c196 with SMTP id f11-20020a05600c4e8b00b0039c35dac196mr31236071wmq.200.1654690728855;
        Wed, 08 Jun 2022 05:18:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKUxTQwltHZUhBCsdirrX5JANqio6gOoNAJeUeNfmkGtUsUbNdzy4rsk8+LhAjlPx9DVh8qw==
X-Received: by 2002:a05:600c:4e8b:b0:39c:35da:c196 with SMTP id f11-20020a05600c4e8b00b0039c35dac196mr31236048wmq.200.1654690728527;
        Wed, 08 Jun 2022 05:18:48 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b0039c60e33702sm2706173wmq.16.2022.06.08.05.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 05:18:48 -0700 (PDT)
Message-ID: <7758b6ff-5c20-0c11-dc2f-dceb5e8e3799@redhat.com>
Date:   Wed, 8 Jun 2022 14:18:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 0/4] fat: add support for the renameat2 RENAME_EXCHANGE
 flag
Content-Language: en-US
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Lennart Poettering <lennart@poettering.net>,
        linux-kernel@vger.kernel.org, Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20220601173204.1372569-1-javierm@redhat.com>
 <05bfb010-6b00-edb1-0e28-889a2ff71503@redhat.com>
 <87ilpbtrsm.fsf@mail.parknet.co.jp>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <87ilpbtrsm.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 11:42, OGAWA Hirofumi wrote:
> Javier Martinez Canillas <javierm@redhat.com> writes:
> 
>> Hello OGAWA,
>>
>> On 6/1/22 19:32, Javier Martinez Canillas wrote:
>>> Hello,
>>>
>>> The series adds support for the renameat2 system call RENAME_EXCHANGE flag
>>> (which allows to atomically replace two paths) to the vfat filesystem code.
>>>
>>> There are many use cases for this, but we are particularly interested in
>>> making possible for vfat filesystems to be part of OSTree [0] deployments.
>>>
>>> Currently OSTree relies on symbolic links to make the deployment updates
>>> an atomic transactional operation. But RENAME_EXCHANGE could be used [1]
>>> to achieve a similar level of robustness when using a vfat filesystem.
>>>
>>> Patch #1 is just a preparatory patch to introduce the RENAME_EXCHANGE
>>> support, patch #2 moves some code blocks in vfat_rename() to a set of
>>> helper functions, that can be reused by tvfat_rename_exchange() that's
>>> added by patch #3 and finally patch #4 adds some kselftests to test it.
>>>
>>
>> I think that addressed all the issues you pointed out in v3, please let me
>> know if there's anything else that is needed for this patch series.
>>
>> Would these be merged by you or should I ping someone else? I'm not
>> that familiar with how filesystem patches make into the mainline tree.
> 
> Sorry, it is just the my issue. I was traveling latest week, so is not
> reviewing yet. I'll do soon.
> 

Sure, there's no rush. I just wanted to confirm that. Thanks a lot!

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

