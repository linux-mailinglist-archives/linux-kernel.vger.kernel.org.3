Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA050E2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbiDYOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiDYOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD2421D336
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650896243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3M0aoxkyxBu8tMQw8TfYWG0VMojy3pZmIs9OKgeG0uY=;
        b=I45q1LiJfmZlSy/1hvA6gRGwZ1cXOHYPrCAwnT7HIxZwb0yc8FL01DE2XA97cxK+zvHe+w
        U81smKudZNz3npuDjwB76hoNUjY+kgGBq1HNqnLCiebWhJ3luoMQdA0yTRT1MV7EEgVOGC
        U+PWjXskryQDWqCWlrtNz9Y3pJULoQY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-a92EowTmN7aRTbViTfYHQA-1; Mon, 25 Apr 2022 10:17:22 -0400
X-MC-Unique: a92EowTmN7aRTbViTfYHQA-1
Received: by mail-wm1-f69.google.com with SMTP id t2-20020a7bc3c2000000b003528fe59cb9so7205321wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3M0aoxkyxBu8tMQw8TfYWG0VMojy3pZmIs9OKgeG0uY=;
        b=qmeTYiRYZgbobjS8Nvv/Na7B0/W43ly2Aapz6+AIOTK/MevRHcuJ32JTHAWkHlwSvf
         1kEhjQ528f4XscuUxtYE+coxmhxHeLuhNeL1NuONweRiY/6AdTBXC3p35T0zoTatjMUT
         iHJxA2FcJigA5Od8PAMNFYonNc72KBnGKXW9xadD/pMEMbsyym00p0tCpqfDZbR43Zp0
         Hm6/9xVR/qQ/YjQ40l91Ibec8zbQPA7A3GDaOtBq9yb14sMI/oDCB3297DF9OXlbu06K
         KZWtXrLpv27S4MnCtT2aQDqwCGYOypdQwgkLL8KyjzlmBdnd62PW/Usb/nB8OigF9fLY
         WwVg==
X-Gm-Message-State: AOAM531X4Xlu5TvF/B4MDxX8SMk8aY+97dXdJ6jDdlLjMj2TTzDXvF0u
        WXZu/U+qSZEUo8BNc7xBiOUXR5Fh4CSqjHu/uEPKJb1NLp9bNuh+LlkDMi2z8xsWohf6KjWjlPg
        N4BIgoHatlPvtX3gmBPwAZPo=
X-Received: by 2002:a7b:c84f:0:b0:393:e729:e670 with SMTP id c15-20020a7bc84f000000b00393e729e670mr8781326wml.153.1650896241040;
        Mon, 25 Apr 2022 07:17:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMT+A2bqCqaIIs9ZgaQ2ZSK7SudVpQXxznSITCu/tmHcNBfasGTF4frwxIwbGgb5wHo/ba1w==
X-Received: by 2002:a7b:c84f:0:b0:393:e729:e670 with SMTP id c15-20020a7bc84f000000b00393e729e670mr8781309wml.153.1650896240824;
        Mon, 25 Apr 2022 07:17:20 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b003917d43d339sm11918988wma.4.2022.04.25.07.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 07:17:19 -0700 (PDT)
Date:   Mon, 25 Apr 2022 15:17:17 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Lameter <cl@gentwo.de>, frederic@kernel.org,
        mtosatti@redhat.com, tglx@linutronix.de, mingo@kernel.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v3] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220425141717.vw2jfnn3zp6c5ib2@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220422193647.3808657-1-atomlin@redhat.com>
 <alpine.DEB.2.22.394.2204250919400.2367@gentwo.de>
 <20220425113909.u3smtztp66svlw4o@ava.usersys.com>
 <alpine.DEB.2.22.394.2204251406370.13839@gentwo.de>
 <20220425132700.GK2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220425132700.GK2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-04-25 15:27 +0200, Peter Zijlstra wrote:
> On Mon, Apr 25, 2022 at 02:09:06PM +0200, Christoph Lameter wrote:
> > On Mon, 25 Apr 2022, Aaron Tomlin wrote:
> > 
> > > Yes, in the context of nohz, this patch should ensure it, if required, when
> > > the idle tick is to be stopped.
> > 
> > What I said was that it is generally useful. Even in the non NOHZ case.
> > 
> > Folding the vmstat diffs *always* when entering idle prevents unnecessary
> > wakeups and processing in the future and also provides more accurate
> > counters for the VM allowing better decision to be made on reclaim.
> 
> I'm thinking you're going to find a ton of regressions if you try it
> though; some workloads go idle *very* shortly, doing all this accounting
> is going to be counter-productive.

Hi Peter, Christoph,

Indeed. Which was why I decided, initially, against the general-purpose
case/or approach. Personally, I would prefer to keep this somewhat
restrictive to nohz.


Kind regards,

-- 
Aaron Tomlin

