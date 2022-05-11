Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB78523590
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiEKOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbiEKOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 406D55908A
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652279523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQL38nXvdPxHenWCxul6vJpMbxtsuEI7iyeGKqIARSU=;
        b=Reg1twyRUW4kVgwUxoNiYNu+VB+I17ilDkXrmEMZ0FTBawCg1686JfRutCZCmtgRsL33cR
        NbyWr4xTm+VxbQ8Nxb560gkrDkpCjrUk+QUdrlzB2esybKt3RJMwbzwaddyBeOOpHeoXL9
        LB/+GL8VLJmUBdbkBTqappjdOKq+xNQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-yarXPV__O3GcsEdY0Fjeig-1; Wed, 11 May 2022 10:32:02 -0400
X-MC-Unique: yarXPV__O3GcsEdY0Fjeig-1
Received: by mail-qk1-f199.google.com with SMTP id x191-20020a3763c8000000b0069fb66f3901so1960116qkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 07:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=KQL38nXvdPxHenWCxul6vJpMbxtsuEI7iyeGKqIARSU=;
        b=x/8Xetct3wFNJyH/7Yp5pcFCynwa7SLH9qUohiEjLxH8ak0mC5MAL5R9T2AhdQkCm7
         z1ghTpJKw7A2bce2Cy9RPTu5wzu66153GQNN9hZWUPwCtLGNbHSWKDGJvmcrZ1YvNodT
         2gW6jTHwAinL6+l0ZEW2PVn0AQchodTDIEE1SWO6UxBmmKDAFgaBjan8s3sGoWFaWU5q
         47K5ezG/CEEwCZ0mL9PsGWk2SbBOwvmZfrCcz8dPKukHQKCSi1dRQjrYVbFLhgoGjQ0s
         1i5wxnmgWYIF5k6R8+ju/oTg6azl94rz7pNqUeTMuOhWuWFgM1ykW1m3kxZGG3o2U4dr
         dOkQ==
X-Gm-Message-State: AOAM530KuvwU5VoqD8OxAQnk75AvvSN4/1MV29mGGgCCkbI3OOTVywhl
        YNL0v9tVpnCIw6wlln4hbsQDWg7A2o5mzYw3wIwYvE49ceNYJZYwIZrINXccqICVC6GGNJexQwd
        OzO76fw4wazUOx+h6FN4riFlF
X-Received: by 2002:a05:620a:42:b0:6a0:c64c:35ae with SMTP id t2-20020a05620a004200b006a0c64c35aemr5484449qkt.607.1652279521839;
        Wed, 11 May 2022 07:32:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh4shODUQfLsPm7eUgpyznqBw9eckUeZuWJ+m7D2DbOJd2o74zl6AbM8GLCYVbcGb4/1G9ag==
X-Received: by 2002:a05:620a:42:b0:6a0:c64c:35ae with SMTP id t2-20020a05620a004200b006a0c64c35aemr5484418qkt.607.1652279521576;
        Wed, 11 May 2022 07:32:01 -0700 (PDT)
Received: from m8.users.ipa.redhat.com (cpe-158-222-141-151.nyc.res.rr.com. [158.222.141.151])
        by smtp.gmail.com with ESMTPSA id i3-20020ac860c3000000b002f39b99f682sm1213342qtm.28.2022.05.11.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:32:01 -0700 (PDT)
Message-ID: <503184f1d3d0a5b42057cd550ba2baf695183687.camel@redhat.com>
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
Date:   Wed, 11 May 2022 10:32:00 -0400
In-Reply-To: <Ynu35I4KMW7gMZW3@zx2c4.com>
References: <20220502140602.130373-1-Jason@zx2c4.com>
         <20220502140602.130373-2-Jason@zx2c4.com>
         <8f305036248cae1d158c4e567191a957a1965ad1.camel@redhat.com>
         <YnsO1JGQm5FEkbJt@zx2c4.com>
         <f6a4a5ccb126053534bebe4b070fc1384839e919.camel@redhat.com>
         <Ynu35I4KMW7gMZW3@zx2c4.com>
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

On Wed, 2022-05-11 at 15:19 +0200, Jason A. Donenfeld wrote:
> Please don't dismiss this. I realize you have your one single use case
> in mind, but there are others, and the distinction you gave for why we
> should dismiss the others to focus on yours doesn't really make any
> sense. Here's why:

I do not think I am dismissing any other use cases, clearly anything
that depend on unique random numbers for security is impacted, but I
tend to focus where we can get the biggest impact. 

> In my email I pointed out two places where VM forks impact crypto in bad
> ways:
> 
> - Session keys, wrt nonce reuse.
> 
> - Random nonces, wrt nonce reuse.
> 
> There are other problems that arise from VM forks too. But these stand
> out because they are both quite catastrophic, whether it's duplicated
> ECDSA random nonces, or whether it's the same session key used with the
> same sequential counter to encrypt different plaintexts with something
> like AES-GCM or ChaCha20Poly1305. These are both very, very bad things.
> 
> And both things happen in:
> 
> - Libraries: crypto lib random number generators (e.g. OpenSSL), crypto
>   lib session keys (e.g. any TLS library).
> 
> - Applications: application level random number generators (e.g.
>   Bitcoin Core *facepalm*), application level session keys (e.g.
>   OpenSSH).

Yes, some applications that are involved with security do have their
own application level PRNGs, clearly they will have to either stop
using customized PRNGs and use the library provided ones (or even just
/dev/urandom if their needs are no performance critical) or adjust
their own PRNGs to be safe using whatever mechanism will be provided.

> So I don't think the "library vs application" distinction is really
> meaningful here. Rather, things kind of fall apart all over the place
> for a variety of reasons on VM fork.

I am not really making a library vs application distinction, what I am
saying is that the library uses case has a set of tighter constraints
than the application one. Basically anything a library can use an
application can as well, while the contrary is not true. Therefore it
if we resolve the library problem, applications will have a solution as
well.

> > > - https://lore.kernel.org/lkml/YnA5CUJKvqmXJxf2@zx2c4.com/
> > > - https://lore.kernel.org/lkml/Yh4+9+UpanJWAIyZ@zx2c4.com/
> > > - https://lore.kernel.org/lkml/CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com/
> > 
> > 4c does sound like a decent solution, it is semantically identical to
> 
> It does, yeah, but realistically it's never going to happen. I don't
> think there's a near- or medium-term chance of changing hypervisor
> semantics again. That means for 4-like solutions, there's 4a and 4b.

I think 4a and 4b are fine mechanisms too, 4c is just more efficient,
and potentially optimizable in HW.
That said I think 3 (vDSO) is also a fine solution, and would not be
disappointed if 3 was chosen over 4.

I am not really after evaluating how it is done below the kernel
boundary. As long as the effects are the same, semantically, from the
user space pov.

> By the way, that email of mine has inaccuracy in it. I complain about
> being in irq context, but it turns out not to be the case; we're inside
> of a kthread during the notification, which means we have a lot more
> options on what we can do.
> 
> If 4 is the solution that appeals to you most, do you want to try your
> hand at a RFC patch for it? I don't yet know if that's the best
> direction to take, but the devil is kind of in the details, so it might
> be interesting to see how it pans out.

I think it would be prudent to agree on the correct mechanisms before
venturing into potentially invasive patches.

Simo.

-- 
Simo Sorce
RHEL Crypto Team
Red Hat, Inc



