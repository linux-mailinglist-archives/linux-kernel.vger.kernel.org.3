Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A84F8E75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbiDHFlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbiDHFlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7410C195D85
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649396382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IZ7lgdZeZiKpKmhex2GbjuSTe4esituqY0pCR5Ga/NE=;
        b=a+Zxp+xbzElwHDb/J/9xojhkgz1bDk8WKu/h3GTb3f2WFGwoJh5AQWthOhpKgC/apu/5xm
        nGLsOkYK+LB+Oe8psiObvholV16rgXskNHL8+qeK3J1Uun1YZDtbmgGZqQgiLgsenaHSe3
        Wj8fHln5cI5BVa7swnuFaVamJh3H8tA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-3K-Kqz55MRuO41B0wxRquQ-1; Fri, 08 Apr 2022 01:39:19 -0400
X-MC-Unique: 3K-Kqz55MRuO41B0wxRquQ-1
Received: by mail-qt1-f197.google.com with SMTP id c19-20020ac84e13000000b002ed0b1f458cso208484qtw.18
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 22:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZ7lgdZeZiKpKmhex2GbjuSTe4esituqY0pCR5Ga/NE=;
        b=CFo+iy628buLJHxMrWzN/F1veLuiJlagBlvRYHeyHWvEgHyr07+HcGUKEgC0VefZla
         5Gn/g+11A0ges7scyuRCbPW16czXU1HATUA9DZf0dMM02jAYEL+NOs67rxQqA+/FW4W3
         w2PmYT8O9VVHzz+gGtrCAkngSHLtlcZbq9MCJ5Ls6gtye6TYZmLS5KmUot6TYBr55eS5
         +/yPkwFJQ2vaN/gAptvi+z6lhPwUcshuzCMtwpmnlSQgYMoax+mzurxu/XXd2jYUK4r+
         /ltTeCptFsYt6yt1akrGlfBieqxR0BC/e+HW90iTpj6qxufRaTVqROKiPH9v/+XxK6Xp
         rs9g==
X-Gm-Message-State: AOAM530OG3IImnJnJpDRVDzkd5sCm55jYjxTu7ep7vC0qIRB4TAy66/D
        OCMlPdwwnpDAE5Y2uniVrG5sLc8v1ZM7pdc57OCQma8RHHFUy6rfBS3bkQQKrWlN+OMo0X2bqPC
        mFq6N/xZnTdXOlmo33voYrHeW
X-Received: by 2002:a05:620a:4008:b0:680:9de9:6ecd with SMTP id h8-20020a05620a400800b006809de96ecdmr11906794qko.385.1649396358707;
        Thu, 07 Apr 2022 22:39:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxX1+ghE3EFczgvRq33KUGWGagkx7jyuaqyP77YQfrDLD3SM8i96LFs8tt/6N7bpKy5KsTmdg==
X-Received: by 2002:a05:620a:4008:b0:680:9de9:6ecd with SMTP id h8-20020a05620a400800b006809de96ecdmr11906785qko.385.1649396358418;
        Thu, 07 Apr 2022 22:39:18 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u187-20020a3792c4000000b0067e679cfe5asm13356838qkd.59.2022.04.07.22.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 22:39:17 -0700 (PDT)
Date:   Thu, 7 Apr 2022 22:39:14 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Artem Savkov <asavkov@redhat.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        netdev@vger.kernel.org, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] timer: add a function to adjust timeouts to be
 upper bound
Message-ID: <20220408053914.csbplfylubrlkads@treble>
References: <20220407075242.118253-2-asavkov@redhat.com>
 <87zgkwjtq2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zgkwjtq2.ffs@tglx>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:37:25AM +0200, Thomas Gleixner wrote:
>  "Make sure TCP keepalive timer does not expire late. Switching to upper
>   bound timers means it can fire off early but in case of keepalive
>   tcp_keepalive_timer() handler checks elapsed time and resets the timer
>   if it was triggered early. This results in timer "cascading" to a
>   higher precision and being just a couple of milliseconds off it's
>   original mark."
> 
> Which reinvents the cascading effect of the original timer wheel just
> with more overhead. Where is the justification for this?
> 
> Is this really true for all the reasons where the keep alive timers are
> armed? I seriously doubt that. Why?
> 
> On the end which waits for the keep alive packet to arrive in time it
> does not matter at all, whether the cutoff is a bit later than defined.
> 
>      So why do you want to let the timer fire early just to rearm it? 
> 
> But it matters a lot on the sender side. If that is late and the other
> end is strict about the timeout then you lost. But does it matter
> whether you send the packet too early? No, it does not matter at all
> because the important point is that you send it _before_ the other side
> decides to give up.
> 
>      So why do you want to let the timer fire precise?
> 
> You are solving the sender side problem by introducing a receiver side
> problem and both suffer from the overhead for no reason.

Here are my thoughts.  Maybe some networking folks can chime in to
keep us honest.

I get most of what you're saying, though my understanding is that
keepalive is only involved in sending packets, not receiving them.  I do
think there would be two opposing use cases:

  1) Client sending packets to prevent server disconnects

  2) Server sending packets to detect client disconnects

For #1, it's ok for the timer to pop early.  For #2, it's ok for it to
pop late.  So my conclusion is about the same as your sender/receiver
scenario: there are two sides to the same coin.

If we assume both use cases are valid (which I'm not entirely convinced
of), doesn't that mean that the keepalive timer needs to be precise?

Otherwise we're going to have broken expectations in one direction or
the other, depending on the use case.

> Aside of the theoerical issue why this matters at all I have yet ot see
> a reasonable argument what the practical problen is. If this would be a
> real problem in the wild then why haven't we ssen a reassonable bug
> report within 6 years?

Good question.  At least part of the answer *might* be that enterprise
kernels tend to be adopted very slowly.  This issue was reported on RHEL
8.3 which is a 4.18 based kernel:

  The time that the 1st TCP keepalive probe is sent can be configured by
  the "net.ipv4.tcp_keepalive_time" sysctl or by setsockopt(). 

  We observe that if that value is set to 300 seconds, the timer
  actually fires around 15-20 seconds later. So ~317 seconds. The larger
  the expiration time the greater the delay. So for the default of 2
  hours it can be delayed by minutes. This is causing problems for some
  customers that rely on the TCP keepalive timer to keep entries active
  in firewalls and expect it to be accurate as TCP keepalive values have
  to correspond to the firewall settings. 

-- 
Josh

