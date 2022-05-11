Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00C6523387
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbiEKM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242905AbiEKM7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42959231CBC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652273951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P3pmuNFV/ptflpHqQQDwwf4tEA/mscwqGqx/YTI6DC4=;
        b=Tt5laQ6f4IiXIiALiYDVI9PwOt6mrAB92You5QpaXucen7sD7VMrYjrfZtlZ7+mKu6u/7X
        +MN5pQydPUXRwLltFTIkVhyMEzC31cCZtbdDoauYKoPruonfEnX3SczU70RLiOfhW+ulUT
        1KGm76PuSsKRLQb+9TrRLbABLxlYwpk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-313--URbmy-pNvSJKyANZ0e4OA-1; Wed, 11 May 2022 08:59:10 -0400
X-MC-Unique: -URbmy-pNvSJKyANZ0e4OA-1
Received: by mail-qt1-f197.google.com with SMTP id w21-20020a05622a135500b002f3b801f51eso1476952qtk.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=P3pmuNFV/ptflpHqQQDwwf4tEA/mscwqGqx/YTI6DC4=;
        b=GPAfHlkrBfJU6QfSKJ3mbTWou0Q5svOR2cTCYKLPXGvxrhQXgcgGYPXMCU773lOKKF
         YXWo0pmsNANNo/babMgJ7ug4+akCSx2BS2IQ/3tbIbpAgyyhm4MlABhOmXHN+HsQ/mG9
         eZtEiYH3/V5pZulrlutgvsQtqBzaOMF+WK8N+IX6V4SmLqEYfCOpUNsfA2ahCkwfoIdB
         N55EOfHto31A/RdwYqLlCREqTygy6cJAWKg1nhugSSqoF80aaWD6Zzc8lGvj2GPAoS9u
         LpNCfjpTwre7YqNeJvVklaxBnXYCsZtoMN+lE/D5QuZFCvUMKbo4XCXBv4r4R+3WT5sI
         I1Pg==
X-Gm-Message-State: AOAM531GrPmmXOZ0vQ+KFgJwbxM9WHrbNjvcu9vFx8gabPq8lUnbj5aA
        c0L6o01Yugu27E4HZKhaSzdt3ZW/wxH3QhvIewU8TqgWNuSQ2RqgW2JIVLZAFXZGaeRcnM4+CKx
        QfwNa4rQvvyzHl5h4GrND8jnq
X-Received: by 2002:a05:620a:2412:b0:6a0:5f8e:c050 with SMTP id d18-20020a05620a241200b006a05f8ec050mr13739693qkn.462.1652273949357;
        Wed, 11 May 2022 05:59:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI9z5WG7k9Nn2llTyyAOt4aUQjwE2gb23qqkGrh6jwCoQSAYhq0zfpk66qWA9cYV8vY6Vjmw==
X-Received: by 2002:a05:620a:2412:b0:6a0:5f8e:c050 with SMTP id d18-20020a05620a241200b006a05f8ec050mr13739677qkn.462.1652273949082;
        Wed, 11 May 2022 05:59:09 -0700 (PDT)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id bk29-20020a05620a1a1d00b0069fca79fa3asm1244537qkb.62.2022.05.11.05.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:59:08 -0700 (PDT)
Message-ID: <f6a4a5ccb126053534bebe4b070fc1384839e919.camel@redhat.com>
Subject: Re: [PATCH 2/2] random: add fork_event sysctl for polling VM forks
From:   Simo Sorce <simo@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Graf <graf@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Torben Hansen <htorben@amazon.co.uk>,
        Jann Horn <jannh@google.com>
Date:   Wed, 11 May 2022 08:59:07 -0400
In-Reply-To: <YnsO1JGQm5FEkbJt@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
         <20220502140602.130373-2-Jason@zx2c4.com>
         <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
         <YnsO1JGQm5FEkbJt@zx2c4.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, 2022-05-11 at 03:18 +0200, Jason A. Donenfeld wrote:
> My proposal here is made with nonce reuse in mind, for things like
> session keys that use sequential nonces.

Although this makes sense the problem is that changing applications to
do the right thing based on which situation they are in will never be
done right or soon enough. So I would focus on a solution that makes
the CSPRNGs in crypto libraries safe.

> A different issue is random nonces. For these, it seems like a call to
> getrandom() for each nonce is probably the best bet. But it sounds like
> you're interested in a userspace RNG, akin to OpenBSD's arc4random(3). I
> hope you saw these threads:
> 
> - https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
> - https://lore.kernel.org/lkml/Yh4+9+UpanJWAIyZ@zx2c4.com/
> - https://lore.kernel.org/lkml/CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com/

4c does sound like a decent solution, it is semantically identical to
an epoch vmgenid, all the library needs to do is to create such a mmap
region, stick a value on  it, verify it is not zero after computing the
next random value but before returning it to the caller.
This reduces the race to a very small window when the machine is frozen
right after the random value is returned to the caller but before it is
used, but hopefully this just means that the two machines will just
make parallel computations that yield the exact same value, so no
catastrophic consequence will arise (there is the odd case where two
random values are sought and the split happens between the two are
retrieved and this has bad consequences, I think we can ignore that).

> Each one of those touches on vDSO things quite a bit. Basically, the
> motivation for doing that is for making userspace RNGs safe and
> promoting their use with a variety of kernel enhancements to make that
> easy. And IF we are to ship a vDSO RNG, then certainly this vmgenid
> business should be exposed that way, over and above other mechanisms.
> It'd make the most sense...IF we're going to ship a vDSO RNG.
> 
> So the question really is: should we ship a vDSO RNG? I could work on
> designing that right. But I'm a little bit skeptical generally of the
> whole userspace RNG concept. By and large they always turn out to be
> less safe and more complex than the kernel one. So if we're to go that
> way, I'd like to understand what the strongest arguments for it are.

I am not entirely sure how a vDSO RNG would work, I think exposing the
epoch(or whatever indicator) is enough, crypto libraries have pretty
good PRNGs, what they require is simply a good source of entropy for
the initial seeding and this safety mechanism to avoid state
duplication on machine cloning.
All the decent libraries already support detecting process forks.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



