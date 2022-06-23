Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB8557A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiFWMmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiFWMmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6938A49F22
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655988164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWwkfqx+2pau0Yo1yhaT7OU66Th1izKSwu4bPw3yKq4=;
        b=Hp33u71NNvj3BsQ8K5VR4mfP04OkbqbYKS3xjD0fPI0MuXNhT4O7Nr3bJ3HUSksjf1ZCwU
        oVPz4EukS4KRXUAD9QXVJtue7VSN9r6KoQrKiaMh3eXDCT9yMexne1+s+zXbJFgwg9oxWm
        dNBnJ0QnmYPOzayCnRqVQb+OWDDfEvc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-0izitOWQPNaH248zeKoP7Q-1; Thu, 23 Jun 2022 08:42:41 -0400
X-MC-Unique: 0izitOWQPNaH248zeKoP7Q-1
Received: by mail-ed1-f69.google.com with SMTP id z20-20020a05640235d400b0042dfc1c0e80so15626159edc.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=fWwkfqx+2pau0Yo1yhaT7OU66Th1izKSwu4bPw3yKq4=;
        b=NXYugvsWoCWR2hLHm+BB2j0W3lpmze0EpmR5Q6KZhD3ERFhlbnlDcoe3R3fILDKwlx
         dXBdTJ2mZB1i6Xe0xjHwZmtB5z9vSZFQC7TAx/BuYu85TFHeraMRni/4rTS2Q0TGBKkO
         wNW3AOmqqitwup3mz/acuxYpLXWsHShx0/2hPpvHMnniY4snopGxB8g66qU0Q6q1plzX
         QR1VX4+haiXqetatnnLmANbFq/Uq+oJP8Ag/WHk8j+kvE7wx79HDz1g9BeIqUUrP16or
         CxjvyVvs/M5jn8owE0m1sQKMEIhirDupKe6aj+a5+yBCNdunM1sOnXdvuS9cvjWxMBQB
         wvKA==
X-Gm-Message-State: AJIora9zgk5WGs3XNSWuuyWSbtjrg8MqgUsQ54xxr3vI5jR2V0y6tUZR
        fgRcsFcMLQ1TkGY9kWTmlsIrCQQgzAOd5nmVi+Z9qfg5x0bcU6xTvWx9lQxgYCitrgU+YKsUFtF
        Ojk3BFwG/vcJYCKywdq3bFEry
X-Received: by 2002:a17:907:3da0:b0:722:df7b:1d23 with SMTP id he32-20020a1709073da000b00722df7b1d23mr7876440ejc.574.1655988160076;
        Thu, 23 Jun 2022 05:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vKidTTw8S2936VqAQIkrHcwfcBYKJd7yoM5gbKteHtOyqrcIQA0aynTgd5AMq6TNq7w0RwLw==
X-Received: by 2002:a17:907:3da0:b0:722:df7b:1d23 with SMTP id he32-20020a1709073da000b00722df7b1d23mr7876419ejc.574.1655988159842;
        Thu, 23 Jun 2022 05:42:39 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id c1-20020a17090618a100b00718e4e64b7bsm10824013ejf.79.2022.06.23.05.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 05:42:39 -0700 (PDT)
Message-ID: <a387ad62-4f96-c226-d062-5e1905ef1aee@redhat.com>
Date:   Thu, 23 Jun 2022 14:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=whUJTQuLorG=pRv1XAe_=9oWrVFkYb26q87fhkqDs5zcQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: some apparently valid objtool clang warnings
In-Reply-To: <CAHk-=whUJTQuLorG=pRv1XAe_=9oWrVFkYb26q87fhkqDs5zcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 6:58 PM Linus Torvalds <torvalds@linux-foundation.org> wrote:
> In particular, the
>
>   call to __ubsan_handle_load_invalid_value() with UACCESS enabled
>
> warnings tend to be a real sign that somebody is doing something very
> wrong inside a user access region, and kvm seems to be buggy here.
> In particular, kvm does
>
>   #define emulator_try_cmpxchg_user(t, ptr, old, new) \
>         (__try_cmpxchg_user((t __user *)(ptr), (t *)(old), *(t
> *)(new), efault ## t))
>
> and look at that third argument: "*(t *)(new)". It is doing a pointer
> dereference [...] inside the __uaccess_begin_nospec()/__uaccess_end()
> region [...] and *both* of those lines are buggy, since they both do 
> memory accesses that are not to user space [...] We also do have that
>
>         if (unlikely(!success))
>                 *_old = __old;
>
> inside __try_cmpxchg_user_asm after the actual asm that also seems
> buggy and wrong for the exact same reason - it shouldn't be done
> within the STAC region.
>
> Comments? I think those old/new things should be moved out one macro
> level, and be done inside __try_cmpxchg_user() itself, outside the
> uaccess region.
>
> That may require some games for the end-game where we do that "assign
> the _old value", and maybe the __uaccess_end needs to be moved into
> the success case. But it would be good to do this right. No?

Yes, I agree that __try_cmpxchg_user should look more like this:

  /* "Returns" 0 on success, 1 on failure, -EFAULT if the access faults. */
  #define __try_cmpxchg_user(_ptr, _oldp, _nval, _label)	({		\
  	int __ret = -EFAULT;						\
+	__typeof__(_ptr) __ptr = (_ptr);				\
+	__typeof__(_ptr) __pold = (__typeof__(_ptr))(_oldp);		\
+	__typeof__(*(_ptr)) __old = *__pold;				\
+	__typeof__(*(_ptr)) __new = (_nval);				\
  	__uaccess_begin_nospec();					\
-	__ret = !unsafe_try_cmpxchg_user(_ptr, _oldp, _nval, _label);	\
+	__ret = !____try_cmpxchg_user(__ptr, __old, __new, _label);	\
  _label:									\
  	__uaccess_end();						\
+	if (unlikely(!__result))					\
+		*__pold = __old;						\
  	__ret;								\
  							})
(where I have renamed unsafe_try_cmpxchg_user because it doesn't
anymore write to *_pold; it's not a full try_cmpxchg).  I'll
clean up the rest of the macros and send it out as a patch.

Paolo

