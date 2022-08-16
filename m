Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7075B5960B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236679AbiHPQ7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbiHPQ7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:59:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB90796A2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:59:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so14303258edc.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=PZiFKHAPInSqLmOQSyV+TmAHEnPDfiBJsJIlSVONBUo=;
        b=LRCjpJNqVhX8469WWIWi7kwgE6So402iY3NGTnuzSThPccWIrskygornwb3D41OzQ8
         AUJcD7neOIjJ1r8h+Jp8C9vYMNzRMuvxPNuRcwR+OxVlO2b01+dqO7h3GoedFTyK4/ix
         FxYRfhKhFY51NZt1Ph4W4hbaBuIKb82elRAmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PZiFKHAPInSqLmOQSyV+TmAHEnPDfiBJsJIlSVONBUo=;
        b=wGZ29Hk42kKOvHk7GbnMYOE2Y+k3iugqNM+s3bbD7BiXQBrqccQDRuXRmjCBI6CpGO
         mOBy1YF6BKI9kKDGghAWzAw+dcVIEz2KyjTCDX3JXOhYIqBBJnVqIaWSYRVNxeZtZrhn
         SpEik5juWLNIit1g5dNhoRvQnqwujINQ+O/Kab682/4SaIlfWNKZ4mmcSfKw536SRoxL
         w/P4WtNlMKqCa37SIrtbw6FjrM+XlFvPIDZPz6mcZDuYHMZvPXLfy8l4vz31f/Z95C6Q
         FnGuoaQfqcyaBqBRKxRrzIxyhv+W/zcpXxRvksU729nlt6Mv/Ah8D6SXFo2yHEmULRPh
         e91A==
X-Gm-Message-State: ACgBeo35B8n24GzMf4DvBRp5O1UHz81yG1kXNw5D+xZ9MrMa6ztVuhil
        CrC1D4xO+Mk34y1ElDNCDfOvQRAUdRCU9i9iL7M=
X-Google-Smtp-Source: AA6agR6l+A+8fYyopkCteu+6ArdsBelvP1La7o1l6ILnOc8L2BWLIeqFuJXWCq3dkSaUBxKeA0YHmw==
X-Received: by 2002:aa7:cb92:0:b0:443:98d6:20da with SMTP id r18-20020aa7cb92000000b0044398d620damr11828873edt.399.1660669153686;
        Tue, 16 Aug 2022 09:59:13 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id j4-20020aa7ca44000000b0043d1a9f6e4asm8917764edt.9.2022.08.16.09.59.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 09:59:13 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso5125029wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 09:59:12 -0700 (PDT)
X-Received: by 2002:a05:600c:657:b0:3a5:e4e6:ee24 with SMTP id
 p23-20020a05600c065700b003a5e4e6ee24mr8635263wmm.68.1660669152579; Tue, 16
 Aug 2022 09:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <YvqaK3hxix9AaQBO@slm.duckdns.org> <YvsZ6vObgLaDeSZk@gondor.apana.org.au>
 <CAHk-=wgSNiT5qJX53RHtWECsUiFq6d6VWYNAvu71ViOEan07yw@mail.gmail.com>
 <20220816134156.GB11202@willie-the-truck> <YvuvxnfHIRUAuCrD@boqun-archlinux> <74559da4-5cd4-7cc4-0303-ab5f6a8b92ae@marcan.st>
In-Reply-To: <74559da4-5cd4-7cc4-0303-ab5f6a8b92ae@marcan.st>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Aug 2022 09:58:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn=gkf8kOxVPPeTpcgsFk21P9sk4SZRQ26=Jhqo6ewRA@mail.gmail.com>
Message-ID: <CAHk-=whn=gkf8kOxVPPeTpcgsFk21P9sk4SZRQ26=Jhqo6ewRA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix memory ordering race in queue_work*()
To:     Hector Martin <marcan@marcan.st>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tejun Heo <tj@kernel.org>, peterz@infradead.org,
        jirislaby@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, oneukum@suse.com,
        roman.penyaev@profitbricks.com, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
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

On Tue, Aug 16, 2022 at 9:22 AM Hector Martin <marcan@marcan.st> wrote:
>
> It's worth pointing out that the workqueue code does *not* pair
> test_and_set_bit() with clear_bit(). It does an atomic_long_set()
> instead

Yes. That code is much too subtle.

And yes, I think those barriers are

 (a) misleading

 (b) don't work with the "serialize bits using spinlock" model at all

It's a good example of "we need to really have a better model for this".

             Linus
