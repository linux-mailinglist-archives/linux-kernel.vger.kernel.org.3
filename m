Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BAD4EE1B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiCaT3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236456AbiCaT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA4A51E016E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648754882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UI8qEHAbkpwLvW7bt2Ub22ogltHl59gfjOTw6tTvytQ=;
        b=QuScXhTzdgeHIIzadvz40MMJhZJ0CLv4JxIgbdJDpAt0YcX8cYNLcvINwZce4asLZ6b0L5
        jM9a+5f7mL2nGu1CEcX0y9XrDAmuCWic7MAwZmzJwxdg7uFBp1Nhq50yEPaB9PXsWOt1z/
        y0WAypzO9zrjNR27gEIqHLIdGLeokJM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-s7c0ki8lMBa3fSC2gMYsKg-1; Thu, 31 Mar 2022 15:28:00 -0400
X-MC-Unique: s7c0ki8lMBa3fSC2gMYsKg-1
Received: by mail-lf1-f69.google.com with SMTP id e15-20020ac24e0f000000b0044a8b775985so159994lfr.19
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UI8qEHAbkpwLvW7bt2Ub22ogltHl59gfjOTw6tTvytQ=;
        b=aT0XnlrkM50ygvPOk7JBsWzA9q/BfOwEB1O8icJv3Q8fZ2QcTYWqIpLOzoznoGQESm
         OkFz80HHRPlHO+GFJwclzYVvMu7bfufP/TH/wFRJWGNzzCaBo+2hAkt0z/9S48JVDNj+
         bBAIVMfUC7h7ZDFGj1QKlcZa/mYhTjydhY4shArYKAs1ByiXORAv9AghwakbYiU9YK9c
         RW20d2AxtBt0voyXsgpowJt+5Wy3KDizbmxvg19mvYrQcZAVyGEKUinsNBy80tJe7s9F
         2n9syXysSbF9z/8vexAHxfv5b8dUukFiUF2+OVwouzHoGsijAZBnGJ94DpNYD1Ma4ldV
         qvxg==
X-Gm-Message-State: AOAM530309lRPtK8Kbhgjac3qCS5sh50CXHzyR8lMnzAdMUCcITF4iOj
        eJDThU+X8yVL4EDpJyDYvAd1aLsrGUEIudqCpMTz53rrcRrdMcE9RZOIdWO1+sPgbwcapMwmuD8
        uqYTK2QnQRKD3xzb11B0XBClBxkQdTiNGaKvdJx+O
X-Received: by 2002:a2e:1546:0:b0:24a:c194:ba39 with SMTP id 6-20020a2e1546000000b0024ac194ba39mr11236995ljv.65.1648754879217;
        Thu, 31 Mar 2022 12:27:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwag+5InsydWAKAYNXSgt39wabMKxHIRvyZYQqUozjzTMie0M2/x5p5RcXPPjKScZOWzCpZnkanZi3QF7SnJuQ=
X-Received: by 2002:a2e:1546:0:b0:24a:c194:ba39 with SMTP id
 6-20020a2e1546000000b0024ac194ba39mr11236988ljv.65.1648754878993; Thu, 31 Mar
 2022 12:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QYu4q7K-pkAbMt3br_7O-Lu2OWyieLfyiju0PNEiy5YdKYzg@mail.gmail.com>
 <CAASaF6yhTpXcWhTyg5VSU6czPPws5+sQ3vR7AWC8xxM7Xm_BGg@mail.gmail.com>
 <YkXv0NoBjLBYBzX8@google.com> <YkX20LtaENdOOYxi@google.com>
In-Reply-To: <YkX20LtaENdOOYxi@google.com>
From:   Jan Stancek <jstancek@redhat.com>
Date:   Thu, 31 Mar 2022 21:27:42 +0200
Message-ID: <CAASaF6xxscL+Zd1dqsykGOEvKwTJ5nDFvv6tOmWN5Mt-GH1QuA@mail.gmail.com>
Subject: Re: RIP: 0010:param_get_bool.cold+0x0/0x2 - LTP read_all_sys - 5.17.0
To:     Sean Christopherson <seanjc@google.com>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>, kvm <kvm@vger.kernel.org>,
        "Bonzini, Paolo" <pbonzini@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 8:46 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Mar 31, 2022, Sean Christopherson wrote:
> > On Wed, Mar 30, 2022, Jan Stancek wrote:
> > > +CC kvm
> > >
> > > Issue seems to be that nx_huge_pages is not initialized (-1) and
> > > attempted to be used as boolean when reading
> > > /sys/module/kvm/parameters/nx_huge_pages
> >
> > Ugh, CONFIG_UBSAN_BOOL=y complains about a bool not being 0 or 1.  What a pain.
>
> Side topic, any idea why your traces don't have the UBSAN output?  I verified

I guess that's because CONFIG_UBSAN_TRAP=y is also set.

# grep UBSAN -r .config
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
CONFIG_UBSAN_TRAP=y
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_BOOL=y
CONFIG_UBSAN_ENUM=y
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set

> that it's not a panic_on_warn thing.  Having the UBSAN output in future bug reports
> would be very helpful.
>
> [   13.150244] ================================================================================
> [   13.150780] UBSAN: invalid-load in kernel/params.c:320:33
> [   13.151192] load of value 255 is not a valid value for type '_Bool'
> [   13.152079] ================================================================================
>

