Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD04BB988
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbiBRMzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBRMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:55:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E583F2B3565
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645188899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=88nBv9CM5sW4ELGVD1fgBUk+sSiPdeBM/3xxb6Xhxvg=;
        b=ZRXIydv8OCZimQhVRlQ02s+0jlqnLAKcoU+LxNXt8zDy2ixHvM8ZFZy7zudTSLkyceqize
        FCvkb0xMPKdzsivY7mkjgLDkIlXjd+KYcCsDZQYgpiUSy96bL4c8P6wPzX03r/AG3nSi3L
        NpJJMyq3XXMGvFmVzyxYkXDNElGUOXw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-T3SH6EUPPH6doJFDoewwXw-1; Fri, 18 Feb 2022 07:54:58 -0500
X-MC-Unique: T3SH6EUPPH6doJFDoewwXw-1
Received: by mail-wm1-f71.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so2810830wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=88nBv9CM5sW4ELGVD1fgBUk+sSiPdeBM/3xxb6Xhxvg=;
        b=e3VoFVMbhlvuSJ9XmZxTecOHoBw+2lGMEuTdViIWr9kH6TcMI0Id7epx4gDZJRgJus
         x6gFKt2hOgjU69iAYX252ld15pGOueZMknY/jftfr+/I51JkpG1I7+fC/BrSjW5XdMZu
         L9bgjlWeNrBKaP+ND8XO+HY1Ill0uKw4PlHHYVj6j0MiZzR70Aa7hHsclY3HjVaotEnk
         qygFDTzMqoS0Eujxl+4V1NuakXYnE4S41vasv3I8SfndrKuyvWs9H7Cw55PV9n27GBqU
         H+3IGIS72oNlr2KYMG0uYcUn75cqK2H44tX/tEfbwAnzEmx3ybcp7hSTgF5bZ0HruaXu
         7G5Q==
X-Gm-Message-State: AOAM530ezccxSNWCOvJMkzMrQN2BP0cgEcQWfMnKbigSIoPK+UQet76S
        CsGWm90zV67+5XEg2zS020+GZRMlyEHLSktDYuMSWzw/zKuZ7fRbhyees7WFvnN9ngxqrHICvxD
        zuc55Gf2m+NgO8Cj7Hi9+SxA=
X-Received: by 2002:a7b:ce90:0:b0:37d:1e50:1b60 with SMTP id q16-20020a7bce90000000b0037d1e501b60mr10447194wmj.185.1645188897183;
        Fri, 18 Feb 2022 04:54:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNQX5GfcDKh9eOaiz+k0HYtIt1SQne0UO0m6TJ2xtgaBH5ARpEgHOHXEcjA/E1em14nrjSqA==
X-Received: by 2002:a7b:ce90:0:b0:37d:1e50:1b60 with SMTP id q16-20020a7bce90000000b0037d1e501b60mr10447170wmj.185.1645188896948;
        Fri, 18 Feb 2022 04:54:56 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t4sm4168545wmj.10.2022.02.18.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:54:56 -0800 (PST)
Date:   Fri, 18 Feb 2022 12:54:54 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220218125454.utlgmuhijklzr3if@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217163205.GA748087@lothringen>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-17 17:32 +0100, Frederic Weisbecker wrote:
> > If I understand correctly, in the context of nohz_full, since such work is
> > deferred, it will only be handled in a scenario when the periodic/or
> > scheduling-clock tick is enabled i.e. the timer was reprogrammed on exit
> > from idle.
> 
> Oh I see, it's a deferrable delayed work...
> Then I can see two other issues:
> 
> 1) Can an interrupt in idle modify the vmstat and thus trigger the need to
>    flush it? I believe it's the case and then the problem goes beyond nohz_full
>    because if the idle interrupt fired while the tick is stopped and didn't set
>    TIF_RESCHED, we go back to sleep without calling quiet_vmstat().

Yes: e.g. a nohz_full CPU, in idle code, could indeed receive a reschedule
IPI; re-enable local IRQs and generic idle code sees the TIF_NEED_RESCHED
flag against the idle task. Additionally, the selected task could
indirectly released a few pages [to satisfy a low-memory condition] and
modify CPU-specific vmstat data i.e. vm_stat_diff[NR_FREE_PAGES].


> 2) What if we are running task A in kernel mode while the tick is stopped
>    (nohz_full). Task A modifies the vmstat and goes to userspace for a long
>    while.
> Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
> should really be about dynticks-idle only and not dynticks-full. I've always
> been afraid about enforcing that rule though because that would break old
> noise-free setups. But perhaps I should...

If I understand correctly, I agree. For the latter case, nothing can be
done unfortunately since the scheduling-clock tick is stopped.


Kind regards,

-- 
Aaron Tomlin

