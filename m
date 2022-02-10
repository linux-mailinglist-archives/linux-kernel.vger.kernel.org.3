Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465AD4B17AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245668AbiBJVgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:36:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245429AbiBJVgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:36:38 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7698B26DF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:36:38 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id p63so9072866iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jISv2sd7M+VGGWYHc7AMvBHEJbhlhhpLfU1b+J7OE3Y=;
        b=S6tgd4/+f1shugVBQbimIlzTmJdvI5eGxO7+DNCwN8VGdq+Ha2GJzIi8pVTs+c5Wzk
         6w9yMcwgebHlwWMiLmHqikiisn74QLoAis4KIifvJ1RCYO425QxGE89SXud3mIfljN5i
         XSVrshuGp8f0avBqbxCdf/DonSTSZbYQAU5JI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jISv2sd7M+VGGWYHc7AMvBHEJbhlhhpLfU1b+J7OE3Y=;
        b=ngaHn2wB4+jCtAGPYPN+yZ2Jziu58AOvm0x/abXX5JZvTiErUsXQamcbmxqaWajngI
         LYtljF1PswZrMM+Lw4YAFUT8lNWUjR+zXDKlcyRxHRMz7YCzjKfbmBR/IASG0GB6rHWp
         /d27bvUC7exQfWrstZwMAbFKyT5uif45IdXK0gO3BoGNOXgJIrs73FAIQNLSS3B3E2Ql
         JdYrrrGdnEqSGHasxo9cYBnrtixcxnz//CILC4QcJGuV7TznimrN3JU7Kh7G9Fra7eRe
         CK38Xd8fgB8qj/0cdMeJoDzacqmdBxDoG4/2iCuo2/+UxuTa/DIKNJHmoNUm+IzAwpA3
         1KJw==
X-Gm-Message-State: AOAM5335ldewb+d8aCeivbhrceYPGNI8xZ/7DXN2Ds0xPUe7//GbK9vO
        0gKwcbkJO63DJe0+kzKghRlVaw==
X-Google-Smtp-Source: ABdhPJz+VMFC+XfveESzcl1fhZU4kNFuh4neT8NKOj1ob1N95YkY58ueb4yAIvJJy7vbugALukp2fg==
X-Received: by 2002:a02:7346:: with SMTP id a6mr5038215jae.299.1644528997801;
        Thu, 10 Feb 2022 13:36:37 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id p11sm13281429iov.38.2022.02.10.13.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 13:36:37 -0800 (PST)
Subject: Re: [PATCH v2] selftests/seccomp: Fix seccomp failure by adding
 missing headers
To:     Kees Cook <keescook@chromium.org>,
        Sherry Yang <sherry.yang@oracle.com>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        christian@brauner.io, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210203049.67249-1-sherry.yang@oracle.com>
 <202202101316.E38FEAFBCA@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <2e3d93a2-51ae-cef1-b251-c28ecc386dad@linuxfoundation.org>
Date:   Thu, 10 Feb 2022 14:36:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <202202101316.E38FEAFBCA@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/22 2:16 PM, Kees Cook wrote:
> On Thu, Feb 10, 2022 at 12:30:49PM -0800, Sherry Yang wrote:
>> seccomp_bpf failed on tests 47 global.user_notification_filter_empty
>> and 48 global.user_notification_filter_empty_threaded when it's
>> tested on updated kernel but with old kernel headers. Because old
>> kernel headers don't have definition of macro __NR_clone3 which is
>> required for these two tests. Since under selftests/, we can install
>> headers once for all tests (the default INSTALL_HDR_PATH is
>> usr/include), fix it by adding usr/include to the list of directories
>> to be searched. Use "-isystem" to indicate it's a system directory as
>> the real kernel headers directories are.
>>
>> Signed-off-by: Sherry Yang <sherry.yang@oracle.com>
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Thank you. I will queue this up for rc5.

thanks,
-- Shuah
