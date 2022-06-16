Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40A454E5A7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbiFPPER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377764AbiFPPEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:04:14 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554CE3EABE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:04:11 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1011df6971aso2217270fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zoPzQU7tFCHKbazE96n62nKhOYL6lpl30iCKAfHWF3k=;
        b=hzB+iWkLegyX/YVU4Z4Uk20/fD5mQ12Bb87V6Eh8E5BihrifNpR/2Kid3c5IL3kULj
         /Kav66ARa+qN/N67YFml7VO4vjU3H+d51tIoMenFO1qIG1cNa0TEMy6orpmxvFp0gMGw
         /kiER4gc6alC0Jl/FnyoXaEN+XA94MiTxlaik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zoPzQU7tFCHKbazE96n62nKhOYL6lpl30iCKAfHWF3k=;
        b=BleaRndOe5rqSHkGLyuMj5El9UY/U1LaKFfVcRV3s6FXuPpRqTeLzRkkBidaDLxD5y
         YQjXehfPs5nnC3fMrZJIl7/m4eBYQRri6BtLQKB/LBrmb0+4w3EvsqSaaP1URkpSU9hZ
         SEQdYZstUxcLCvu7jpFLFYGqreYyq0e7SC3y2XDuw5JCnGGJ/n25UtWwBZ0dmJhLLLUb
         Msv0CdqBoZKrzXx0LTdEAySrIF8S1qCqXQg+A5C3UDudshx6b/D7seUb0s6pZXkOovAz
         3syklN0OyPnQU5f9LQLDTq+3k9t9POG0xVIg9RxvYcMvdBVGkPLKPYiISEihC+wYhoMw
         dB/A==
X-Gm-Message-State: AJIora/n4dKUoPvQDeJ3/XlO055/Dynib2VG0NldpoAiwa9AVO9s+aN3
        WRUb847+FE4c6hDb7gWibDq7Eg==
X-Google-Smtp-Source: AGRyM1t/ql2JMv1ewpAojMoM3/cs4LVSN9IuvwaxwKyqaHE21iNNhZqbPJBxqQN/Cljh9oFWXsyihg==
X-Received: by 2002:a05:6870:c181:b0:f1:ea2f:f7f7 with SMTP id h1-20020a056870c18100b000f1ea2ff7f7mr8618905oad.18.1655391849854;
        Thu, 16 Jun 2022 08:04:09 -0700 (PDT)
Received: from [192.168.0.41] ([184.4.90.121])
        by smtp.gmail.com with ESMTPSA id n5-20020a4ab345000000b0035eb4e5a6d6sm1098587ooo.44.2022.06.16.08.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 08:04:08 -0700 (PDT)
Message-ID: <9fe9cd9f-1ded-a179-8ded-5fde8960a586@cloudflare.com>
Date:   Thu, 16 Jun 2022 10:04:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3] cred: Propagate security_prepare_creds() error code
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>,
        Ignat Korchagin <ignat@cloudflare.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, serge@hallyn.com, amir73il@gmail.com,
        kernel-team <kernel-team@cloudflare.com>,
        Jeff Moyer <jmoyer@redhat.com>
References: <20220608150942.776446-1-fred@cloudflare.com>
 <87tu8oze94.fsf@email.froward.int.ebiederm.org>
 <e1b62234-9b8a-e7c2-2946-5ef9f6f23a08@cloudflare.com>
 <87y1xzyhub.fsf@email.froward.int.ebiederm.org>
 <859cb593-9e96-5846-2191-6613677b07c5@cloudflare.com>
 <87o7yvxl4x.fsf@email.froward.int.ebiederm.org>
 <9ed91f15-420c-3db6-8b3b-85438b02bf97@cloudflare.com>
 <20220615103031.qkzae4xr34wysj4b@wittgenstein>
 <CAHC9VhR8yPHZb2sCu4JGgXOSs7rudm=9opB+-LsG6_Lta9466A@mail.gmail.com>
 <CALrw=nGZtrNYn+CV+Q_w-2=Va_9m3C8PDvvPtd01d0tS=2NMWQ@mail.gmail.com>
 <CAHC9VhRSzXeAZmBdNSAFEh=6XR57ecO7Ov+6BV9b0xVN1YR_Qw@mail.gmail.com>
 <1c4b1c0d-12f6-6e9e-a6a3-cdce7418110c@schaufler-ca.com>
From:   Frederick Lawler <fred@cloudflare.com>
In-Reply-To: <1c4b1c0d-12f6-6e9e-a6a3-cdce7418110c@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 10:55 AM, Casey Schaufler wrote:
> On 6/15/2022 8:33 AM, Paul Moore wrote:
>> On Wed, Jun 15, 2022 at 11:06 AM Ignat Korchagin 
>> <ignat@cloudflare.com> wrote:
>>> On Wed, Jun 15, 2022 at 3:14 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Jun 15, 2022 at 6:30 AM Christian Brauner 
>>>> <brauner@kernel.org> wrote:
>> ...
>>
>>>>> Fwiw, from this commit it wasn't very clear what you wanted to achieve
>>>>> with this. It might be worth considering adding a new security hook 
>>>>> for
>>>>> this. Within msft it recently came up SELinux might have an 
>>>>> interest in
>>>>> something like this as well.
>>>> Just to clarify things a bit, I believe SELinux would have an interest
>>>> in a LSM hook capable of implementing an access control point for user
>>>> namespaces regardless of Microsoft's current needs.  I suspect due to
>>>> the security relevant nature of user namespaces most other LSMs would
>>>> be interested as well; it seems like a well crafted hook would be
>>>> welcome by most folks I think.
>>> Just to get the full picture: is there actually a good reason not to
>>> make this hook support this scenario? I understand it was not
>>> originally intended for this, but it is well positioned in the code,
>>> covers multiple subsystems (not only user namespaces), doesn't require
>>> changing the LSM interface and it already does the job - just the
>>> kernel internals need to respect the error code better. What bad
>>> things can happen if we extend its use case to not only allocate
>>> resources in LSMs?
>> My concern is that the security_prepare_creds() hook, while only
>> called from two different functions, ends up being called for a
>> variety of different uses (look at the prepare_creds() and
>> perpare_kernel_cred() callers) and I think it would be a challenge to
>> identify the proper calling context in the LSM hook implementation
>> given the current hook parameters.  One might be able to modify the
>> hook to pass the necessary information, but I don't think that would
>> be any cleaner than adding a userns specific hook.  I'm also guessing
>> that the modified security_prepare_creds() hook implementations would
>> also be more likely to encounter future maintenance issues as
>> overriding credentials in the kernel seems only to be increasing, and
>> each future caller would risk using the modified hook wrong by passing
>> the wrong context and triggering the wrong behavior in the LSM.
> 
> We don't usually have hooks that do both attribute management and
> access control. Some people seem excessively concerned about "cluttering"
> calling code with security_something() instances, but for the most
> part I think we're past that. I agree that making security_prepare_creds()
> multi-purpose is a bad idea. Shared cred management isn't simple, and
> adding access checks there is only going to make it worse.
> 

Sounds like we've reached the conclusion not to proceed with a v4 of 
this patch. I'll pivot to propose a new hook instead.

Thanks for the feedback everyone :)

Fred
