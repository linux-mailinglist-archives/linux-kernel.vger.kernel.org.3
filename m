Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535A4F83BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344945AbiDGPmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbiDGPmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:42:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7C41EAF6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:39:46 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j2so10337867ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AvsbPAce0Zm6SYyVd62fnUo12PcDxQJ27rYPHvZXRk=;
        b=fjf7AWP69YJT4yeCWiQ0Q8ftWxK8OFZ+N67gnbo3o6nyyculc49nYEaiY3+3mNt88a
         QQLOSGwOBjL0m5FpnH243EgzIiVW0onVdIFl8P3bUjyPICLjifpkeqCDmnK2l6Bjfnjo
         62kWjJW67FKBB54YHj3YItis4vE3R7Zu6RNDivVeE4mIJ8+ZOj1yVhziXuH4OTC/rKbi
         8nTk5qSSAlET0R/46a6sOmLkwZkD60zFjAI3KXQNEdkOTalUeJXvmUChKo4CP9WApCbB
         sb2adlunIsp+BM3iFfxxM09PR+36SWgToNnqj35aTpqOYIb2k5w8OurF71n4cYTnxQWO
         YluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AvsbPAce0Zm6SYyVd62fnUo12PcDxQJ27rYPHvZXRk=;
        b=w9tSRWTEXGdwr1RA/Q5fY+ukgO6Yo+ICPDWceA8Vfut81fe4uN5XKsbFsWjXW1Fugt
         1IllBnEAHkRwJvZBJBQT4IjIG9iDsMMkiP1yyteV9jRu5s/c0/4eTku4qTeid+nlfPmi
         ZiWQ3J9bjoVqNgbN7786DkXHq9L53cO5kAmxrtP2KUa2VFZV4wOD22uDXfIdMyLW8HXq
         QIP1O6w114VxhKjcFDA+rOeMnQSkuDQ03WZqeh2rvf415JIycImr8j/BrZvkrEymFvwT
         Lszay9/Z0hWFm4o+iV56iLmzrqP/c4rpEGSf1EPPlwAi1R7PRk1W0iXWHMwNvSMEntiH
         Yl8w==
X-Gm-Message-State: AOAM532JT8pTPmigEPibPJzuzi7WaqKO0dlyverlzF3OYbLoHlaV6Mx4
        /XGwZhDamU7XHqgK/KuB9MPKRmbbW0baX2cjtgFzrg==
X-Google-Smtp-Source: ABdhPJyhsGdF3cMRU0ODbyZoaVZ+2NHLKO70Ar7Zh7PvM+7yCGYcTkNyyLmxFo2geEJGDUM/lTdHjxS55wTDpYGiWIg=
X-Received: by 2002:a25:f441:0:b0:611:4f60:aab1 with SMTP id
 p1-20020a25f441000000b006114f60aab1mr10641308ybe.598.1649345985425; Thu, 07
 Apr 2022 08:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220406172600.1141083-1-jeffreyjilinux@gmail.com>
 <20220406223141.51881854@kernel.org> <CAMzD94T_wo=5x5mzm6NgjgSyTrj6koCqg_ia50HeKZnGp73C6w@mail.gmail.com>
In-Reply-To: <CAMzD94T_wo=5x5mzm6NgjgSyTrj6koCqg_ia50HeKZnGp73C6w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Apr 2022 08:39:34 -0700
Message-ID: <CANn89iL=Yw1RmzH4qL1_jyM1D-aLrn-E2UiXh3YsFOZjc9y_cQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net-core: rx_otherhost_dropped to core_stats
To:     Brian Vazquez <brianvv@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Jeffrey Ji <jeffreyjilinux@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Menglong Dong <imagedong@tencent.com>,
        Petr Machata <petrm@nvidia.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Ji <jeffreyji@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 8:36 AM Brian Vazquez <brianvv@google.com> wrote:
>
> Looks good to me, thanks Jeffrey.
>
> Reviewed-by: Brian Vazquez <brianvv@google.com>


Reviewed-by: Eric Dumazet <edumazet@google.com>

Thank you.
