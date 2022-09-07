Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773765B0B48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIGRP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiIGRP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:15:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4AA6C49
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 10:15:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so14177006pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 10:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LP6BhElerZIzGOprmbC4BLmDZ102mvint9Kn4+cKMbM=;
        b=mzQyZB40KCiXLMDuKL5lB6eLpwJqIqWqeSH5sGLa5V/Qs0kYdwWCkhQ0NzpWLxRZJq
         7LvN5V/9BoNq1y+PH3OgUtapAwRnn1jW/HpC97/RUwU55XpidRixHzaxHpiTQOejmM4F
         7eKwGh2mGNbCKbAuNWCLWl4u90vI7hqCxt5hkBgV7xU1vKizbhObwVONuz/bL/imPtSh
         PM+eDDKoyfKAxqCBrG6S6gjAmqdaolMmuD27K58kl0Eg4lx9y10jJ7H0ipjk23POshRp
         K4om9jKIL1T6/xlLsy//L9ItJYnculoJ4Lp3sWrvLLG8LbDQbFYqUKdUaK2mev8B4EXt
         m7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LP6BhElerZIzGOprmbC4BLmDZ102mvint9Kn4+cKMbM=;
        b=4Or2AxrTzVtQhaM9RVaadV2/6xES7iGFQqGVt4QsNfgJ3C5HVuQsLg41fHEOuuKlPb
         hjCFwJYjuh0/tzA21tSod3EkCE34TYjCmpyb3AlfdZZsaETBEp38rqHl0mtKfGkQ4i4M
         R5NmOzsRF3Bvy4y47dHNwzWN5wBR4Hblu/KdsnT+ZEfWnlrm87iuBtJbwK1ls8fr+rlT
         ivbtWNpSLATMduyXDfaTN8ZL4iUHDB6vpGcKeCEM8m5MQ2VwDHgWqrUTQVnuFxkdHU19
         cs818wvH7ygwKrkRQt5T7JQofBUNkMhowucTdaj5Z3DKk4nIq4NDV3dO8nqG7xvge/53
         ubzQ==
X-Gm-Message-State: ACgBeo3qpvvriKQsAUvAegajq01p4DjA0Fh9fO3q5nuxOABQ6FvxJPnX
        8EX5NL44gVtjpL8V+wdoXRU=
X-Google-Smtp-Source: AA6agR7xlWPnpZhoywgpWJQYI+8OBmi56gLna4F7CRyVvZXepOcLWT4CPLJ016j4BEooqnen7Z19iQ==
X-Received: by 2002:a65:6c07:0:b0:41d:9ddd:4266 with SMTP id y7-20020a656c07000000b0041d9ddd4266mr4283039pgu.326.1662570954707;
        Wed, 07 Sep 2022 10:15:54 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id g9-20020a635209000000b0042ad3214a88sm10949534pgb.74.2022.09.07.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:15:54 -0700 (PDT)
Date:   Wed, 7 Sep 2022 10:15:51 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Alexey Izbyshev <izbyshev@ispras.ru>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: Potentially undesirable interactions between vfork() and time
 namespaces
Message-ID: <YxjRx3+MipdFOudw@gmail.com>
References: <YxAq2jYvGG8QOypu@gmail.com>
 <87czcfhsme.fsf@email.froward.int.ebiederm.org>
 <bdff6cf478fc29c80997a623a57dae5f@ispras.ru>
 <874jxkcfoa.fsf@email.froward.int.ebiederm.org>
 <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <da95e333b4c508ddf8130f8f2d2cbb92@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 08:33:20AM +0300, Alexey Izbyshev wrote:
> > 
> > That is something to be double checked.
> > 
> > I can't see where it would make sense to unshare a time namespace and
> > then call exec, instead of calling exit.  So I suspect we can just
> > change this behavior and no one will notice.
> > 
> One can imagine a helper binary that calls unshare, forks some children in
> new namespaces, and then calls exec to hand off actual work to another
> binary (which might not expect being in the new time namespace). I'm purely
> theorizing here, however. Keeping a special case for vfork() based only on
> FUD is likely a net negative, so it'd be nice to hear actual time namespace
> users speak up, and switch to the solution you suggested if they don't care.

I can speak for one tool that uses time namespaces for the right
reasons. It is CRIU.  When a process is restored, the monotonic and
boottime clocks have to be adjusted to match old values. It is for what
the timens was designed for. These changes doesn't affect CRIU.

Honestly, I haven't heard about other users of timens yet. I don't take
into account tools like unshare.

> 
> The "unshare" tool from util-linux will also change behavior if called
> without "--fork" (e.g. "unshare --user --time"), but that would be unusual
> usage (just as for "--pid"), so most people probably don't do that (or don't
> care about the time namespace of the exec'ed process, but care only about
> its children).


