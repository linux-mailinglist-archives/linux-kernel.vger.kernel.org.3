Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C300D56AC33
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiGGTtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiGGTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:49:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDB7A19A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 12:49:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 70so6372022pfx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYaArLalh3vKqmHzN7sOkOTeCFEK/B7AHrbYIKq7Ujc=;
        b=Q0WYshBBeT6ZxdWTRwTPDWFChC7wBx9FCQ8gIJTTtvHFspcUsZHN+UMZh+l1AdVgXy
         Wv+8LexaGNng6kyz/w9rOCulD2fmPxek1BAN3SSMDm4gvo6fcXjQAJPc2wAVu3CoUbI+
         NKZzzhjZ5snuKW5tpGxkxKxxCUuh9COXOxjMjTFTk3AyKPWzHHjzrtZJtOPZ6hBCT60w
         +qt7RGNXU+sm1JghaKsSYjnd6HoMJfWpTCPOmU3mg1fDGwSREFfwTJFg/wQVkwFhPwQw
         FBjPqWbMBjl9ZeX0Lqk2FEKoo658Ra9ohFc40tnLEjuyCuSKXvB7+LVlhrzqcCoquqtk
         9LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYaArLalh3vKqmHzN7sOkOTeCFEK/B7AHrbYIKq7Ujc=;
        b=HSLrp9xuaYTFnh9edPv10nTrB8o+CggP3tDubfAHV3n915hLZOaqVD1LLWxfnjE+Ru
         lqRyroYnRsQFIlRpQvoj7un7iUcSvtbo0lvHD4vhX4x0KbfBaJ0OEQT42LO1xZs3eMPm
         vaHgF9FrgV29aRvPzLpC3zSjzZUJ28FnVq7r3hs6S+5rfVAAuWrf/zQ8/0lyWHYUQFR+
         cPYHJKjA12cai3Vnvo2m8x7QDopqniQAlmFmez4gfm9tjeGCYWHiovKAyILYzOGxZzm1
         UbkgU/RQNgYgI0Tm46FEfD6m665dWXuJalHP8rBQhmW/2GiK1JrKEhxRG3zxak1Jngwf
         uuuw==
X-Gm-Message-State: AJIora99iv6YoYUV2akR8gx+4UQNORRMBsN3zAssmWZ4ElKWZGtvw83m
        oAd3g/noKl9P+9MfbolLlsle3Q==
X-Google-Smtp-Source: AGRyM1sWcRwIaJVLhlHKG5va7QGy+rUdBqqQm/zt44lD62bNFFQKXhZnCRnq002LeeICAsJeYAVX4w==
X-Received: by 2002:a17:90a:930b:b0:1ed:5441:1fff with SMTP id p11-20020a17090a930b00b001ed54411fffmr7163591pjo.238.1657223342509;
        Thu, 07 Jul 2022 12:49:02 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id d15-20020a621d0f000000b005289e190956sm5171644pfd.177.2022.07.07.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:49:01 -0700 (PDT)
Date:   Thu, 7 Jul 2022 19:48:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Ben Gardon <bgardon@google.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v3 02/11] KVM: selftests: Dump VM stats in binary stats
 test
Message-ID: <Ysc4qQzwUeKxj5ok@google.com>
References: <20220330174621.1567317-1-bgardon@google.com>
 <20220330174621.1567317-3-bgardon@google.com>
 <YlCSWH4pob00vZq3@google.com>
 <CAL715W+9U=5rp3+j3wG46t0Uvq-UAOFduC-AXz-Z9ZJVQXDzDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL715W+9U=5rp3+j3wG46t0Uvq-UAOFduC-AXz-Z9ZJVQXDzDg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022, Mingwei Zhang wrote:
> On Fri, Apr 8, 2022 at 12:52 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Wed, Mar 30, 2022, Ben Gardon wrote:
> > > Add kvm_util library functions to read KVM stats through the binary
> > > stats interface and then dump them to stdout when running the binary
> > > stats test. Subsequent commits will extend the kvm_util code and use it
> > > to make assertions in a test for NX hugepages.
> >
> > Why?  Spamming my console with info that has zero meaning to me and is useless
> > when the test passes is not helpful.  Even on failure, I don't see what the user
> > is going to do with this information, all of the asserts are completly unrelated
> > to the stats themselves.
> 
> Debugging could be another reason, I suspect? I remember when I tried
> to use the interface, there is really no API that tells me "did I add
> this stat successfully and/or correctly?" I think having a general
> print so that developer/debugging folk could just 'grep mystat' to
> verify that would be helpful in the future.
> 
> Otherwise, they have to write code themselves to do the dirty print...

I've no objection to adding a --verbose option or a #define of some form, but make
it opt-in, not on by default.
