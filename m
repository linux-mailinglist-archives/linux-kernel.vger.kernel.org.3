Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343804C212C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 02:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBXBmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 20:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiBXBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 20:42:28 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBE260ABF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:41:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y24so1385985lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 17:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=torvalds.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0FFBkvIcjFMOM0hqUZNjmDF0t+Ha0Kl81ed03YkD3w=;
        b=GFTM2OY9vWIE39i8WbpocEunkuGykh61viUOA48wsUSJffRZoZlqa5icjLYhxM3N+m
         DKb9PvkkIZn5iYFbTaqaXYOIv7wagx+TBn+qjRDwmj0eY8Dliq8aLNw02KfWObzbcyQ/
         4rNhuNeMr4UAGG+y8fPMgvU7IgR711a1AM7IOJj07uM1WtLcRDXCrrGdLdr7qxs+tDmK
         8QwvhC3Z7oK33d06ETfSjgfhoDAQ4nWVZI/AM9EEk6a+ylMTMo8IiFcerUWNREyKfDVm
         LIu84/FrGcky24qdwdKZfwBBil//MBUS7mgm21lImxN/1SYkkrAS7jhBVSk/149bXMyA
         gFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0FFBkvIcjFMOM0hqUZNjmDF0t+Ha0Kl81ed03YkD3w=;
        b=dWly1pMxNT1rbfHrHsoCzxVHpOJHTUV1UwFAIHEVzRQNm6YPUsn1yzMmdRC+44xc0Y
         0Swl5QuYC9jkvEMUwSSHBN1exAKA6ivBICHRmZhgqFVNI40vemoia7LY5osrp1YchLRx
         qRY4O4QxDelIfQH50slCQm7+/fvrO4TN5GERcsj4MR70NMvyAJMtjrTHz47ftfKqNyZS
         GMzhF2NHJjn77KZuEQTHlyEh+Me+OREK1vPEFR+/lypHraWm0yBZ0OyLxSajQcUKyndv
         KtFRxAoREK9w4mPMQN5qYd6SuqM4QWSyeEjcxVyd6YlFGxPC8+nSS6Y28YCoGfS5ww5h
         S1pQ==
X-Gm-Message-State: AOAM530DppI8cpD3pJd+PQ4oNqnzwMCBsTQeYvZpJczNIlXdSsbSPoxM
        e+u9QncirCj9JjbmPxxqZZgjLmvucdNSV9tI27YE2Q==
X-Google-Smtp-Source: ABdhPJxrHmZdK6XMjwOn4d/RYaqX5Cxen9btOowPzWsadcRuB7ZhpiGfM3EaLPc7ca8Ocp7bBOOOTW9+VLPRBV26s3Y=
X-Received: by 2002:ac2:4d91:0:b0:443:127b:558a with SMTP id
 g17-20020ac24d91000000b00443127b558amr363692lfe.542.1645666917210; Wed, 23
 Feb 2022 17:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20220207121800.5079-1-mkoutny@suse.com> <e9589141-cfeb-90cd-2d0e-83a62787239a@edechamps.fr>
 <20220215101150.GD21589@blackbody.suse.cz> <87zgmi5rhm.fsf@email.froward.int.ebiederm.org>
 <87fso91n0v.fsf_-_@email.froward.int.ebiederm.org> <CAHk-=wjX3VK8QRMDUWwigCTKdHJt0ESXh0Hy5HNaXf7YkEdCAA@mail.gmail.com>
 <878ru1qcos.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <878ru1qcos.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <linus@torvalds.org>
Date:   Wed, 23 Feb 2022 17:41:41 -0800
Message-ID: <CAHk-=wgW8+vmqhx4t+uFiZL==8Ac5VWTqCm_oshA0e47B73qPw@mail.gmail.com>
Subject: Re: How should rlimits, suid exec, and capabilities interact?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Etienne Dechamps <etienne@edechamps.fr>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Security Officers <security@kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>, NeilBrown <neilb@suse.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 5:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Question: Running a suid program today charges the activity of that
> program to the user who ran that program, not to the user the program
> runs as.  Does anyone see a problem with charging the user the program
> runs as?

So I think that there's actually two independent issues with limits
when you have situations like this where the actual user might be
ambiguous.

 - the "who to charge" question

 - the "how do we *check* the limit" question

and honestly, I think that when it comes to suid binaries, the first
question is fundamentally ambiguous, because it almost certainly
depends on the user.

Which to me implies that there probably isn't an answer that is always
right, and that what you should look at is that second option.

So I would actually suggest that the "execute a suid binary" should
charge the real user, but *because* it is suid, it should then not
check the limit (or, perhaps, should check the hard limit?).

You have to charge somebody, but at that point it's a bit ambiguous
whether it should be allowed.

Exactly so that if you're over a process limit (or something similar -
think "too many files open" or whatever because you screwed up and
opened everything) you could still log in as yourself (ssh/login
charges some admin thing, which probably has high limits or is
unlimited), and hopefully get shell access, and then be able to "exec
sudo" to actually get admin access that should be disabled from the
network.

The above is just one (traditional) example of a fork/open bomb case
where a user isn't really able to no longer function as himself, but
wants to fix things (maybe the user has another terminal open, but
then he can hopefully use a shell-buiiltin 'kill' instead).

And I'm not saying it's "the thing that needs to work". I'm more
making up an example.

So I'm only saying that the above actually has two examples to the two
sides of the coin: "login" lowering privileges to a user that may be
over some limit - and succeeding despite that - and 'suid' succeeding
despite the original user perhaps being over-committed.

So it's intended exactly as an example of "picking the new or the old
user would be wrong in either case if you check limits at the
transition point".

Hmm?

            Linus
