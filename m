Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C94E686F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352547AbiCXSOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352542AbiCXSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:14:16 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB52B7168
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:12:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k21so9463614lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/LSEoPoVBVnfztCSkUFcbwBfE5ukisNTx0Z0bM1jWgk=;
        b=fBZauSq0ACQcCD0aXGuuoIgacGzWbZWvHI/yboiImq3d2gbCBsK4u0P2R6I9rA5s+1
         llLlGyVUkbHFxwANgyrhG7OcuWCL4PearUKXNl+3bWauMSB43nTGA6zaQsGMBIOxTMat
         Y9LYQyxU0oUnKd77In8/8H15bD1XyIFNQEVc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/LSEoPoVBVnfztCSkUFcbwBfE5ukisNTx0Z0bM1jWgk=;
        b=WDHBadPDRFzXW85OeY1DDEatY/o256RjHJwyYNtZ8yULIZLI5x2X0edB6yscm0pi8V
         8z1NMaho1a1qIyIlRSuMcYwjHTuNFqXCJHzMppNJAmh+IHBhCS/8C3d2MoYzMV+qnKTs
         b1iFkwyPkjPVzpU0INDww++J5el8Nt9Hwj389M89hc0gdi/mjaIQ8+/GyfEeaBeARQGt
         jUfGPn3as8UxusDAM3cmyDTShVbQceDrq0o/SrVHxeGk+QPspiheM77AePeZM1h/R2S1
         U47QMrgAXLElCpvqgDrQC5n2zd8SeJVV4j43BRzoe+OkN+Odh3j9VXxMgG2lpKCGgy9u
         divQ==
X-Gm-Message-State: AOAM532DGhkYOCo3zloG91CiZFzsKmG1ZqRTY+N7w0hKdMCqqnJUSu5A
        etoehN7jl5VLXT3cO2df+OEtu/2L/lwa773d2pE=
X-Google-Smtp-Source: ABdhPJx/I2pgdPPSU+M7Q+KHoS/WEyFjjXS582zYYOx173b3iyC9F388RkLXvmw+TUvL+8eGr31W7Q==
X-Received: by 2002:a05:6512:2395:b0:44a:33d2:b9b5 with SMTP id c21-20020a056512239500b0044a33d2b9b5mr4743483lfv.514.1648145562200;
        Thu, 24 Mar 2022 11:12:42 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id k9-20020a192d09000000b004487dfc9d9csm415417lfj.260.2022.03.24.11.12.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 11:12:38 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 17so7270447ljw.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 11:12:38 -0700 (PDT)
X-Received: by 2002:a2e:a5c4:0:b0:249:9ec3:f2b with SMTP id
 n4-20020a2ea5c4000000b002499ec30f2bmr4898966ljp.358.1648145558024; Thu, 24
 Mar 2022 11:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1644862280.git.legion@kernel.org> <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <877d8kfmdp.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Mar 2022 11:12:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
Message-ID: <CAHk-=wgBB8iPd0W=MQWnQJukMAPAqgsC0QX2wwiSvcct9zu_RA@mail.gmail.com>
Subject: Re: [GIT PULL] ipc: Bind to the ipc namespace at open time.
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Serge Hallyn <serge@hallyn.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Vasily Averin <vvs@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 1:24 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Please pull the per-namespace-ipc-sysctls-for-v5.18 tag from the git tree:

Ugh.

I pulled this. Then I stared at it for a long time.

And then I decided that this is too ugly to live.

I'm sorry. I think Alexey has probably spent a fair amount of time on
it, but I really think the sysctl code needs to be cleaned up way more
than this.

The old code was horribly hacky too, but that setup_ipc_sysctls() (and
setup_mq_sysctls()) thing that copies the whole sysctls table, and
then walks it entry by entry to modify it, is just too ugly for words.

And then it hides things in .extra1, and because it does that it can't
use the normal "extra1 and extra2 contains the limits" so then at
write() time it copies it into a local one AGAIN only to set the
limits back so that it can call the normal routines again.

Not ok.

Yes, yes, the old code did some similar things - to set the 'data'
pointer. That was disgusting too. Don't get me wrong - the existing
code was nasty too. But this took nasty code, and doubled down on it.

I really think this is a fundamental problem, and needs a more
fundamental fix than adding more and more of these kinds of nasty
hacks.

And yes, that fundamental fix is almost certainly to pass in 'struct
cred *' to all those sysctl helper functions.

Then, when you do the actual 'sysctl()' system calls, you pass in
'current_cred()".

And the /proc users would pass in file->f_cred.

And yes, that patch might be quite messy, because we have quite a lot
of those random .proc_handler users.

But *most* of them by far (at least in random code) use the standard
proc_dointvec_minmax() and friends, and won't even notice.

And then the ones that are about namespace issues will have to
continue to do the nasty "make a copy and update the data pointer",
but *MAYBE* we could also introduce the notion of an "offset" to those
proc_dointvec_minmax() things to help them out (and at least avoid the
"make a copy" thing).

Anyway, I really think we must not make that sysctl code even uglier
than it is today, and I think we need to move towards a model that
actually makes sense. And that "pass in the right cred" is the only
sensible model I can see.

I haven't tried to create such a patch, and maybe Alexey already tried
to do something like that and it turned out to be too ugly for words
and that's why these nasty patches happened.

But at least for now, I can't with a good conscience pull this.

Sorry,
                   Linus
