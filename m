Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7745AEEA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbiIFPYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbiIFPX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:23:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A4BBCC3D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:35:51 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g21so8267427qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=476rRlxJxtv02dpx4c2C/tz7co5HatpsDY03oEbQJew=;
        b=ZdXdqko6JBmInECYFejXaMSaYlTehHRuDJ3j05t/YVKwLUVtmBsPjWLip6RFb7O2w4
         fTyUN5s0DJwVjT30WSAMEu0CcKfXxCZ0C3fuCLYBlRCzMnz7dpG8av121g3R2QCtYD+H
         JhuUTT9d5/I2tHqk74zqhvN7+3pdm5okBSxlQ7zV4QXkKdnFwRV6B1adVq2z8/m8N+AQ
         EPvzHHDHM5aKuJfK3F/NUatL6kUmKuJ8sadBq18KZ1yzAvPt4+iQotmwg3MIhJYLVkok
         Qw1Ca8VFDzcVvtsI/eIvVD/UsKvnuHt13i3/UZXS8bXkEiWBvW4znHJp98bZnQoFlgR8
         /y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=476rRlxJxtv02dpx4c2C/tz7co5HatpsDY03oEbQJew=;
        b=h7ZkP38VyiA1L300i6Uy55xLoynKhALH3KbX0cQa0tHv13ISNVqxbWynvHMvZvmwX+
         XODh3GJKQuDIoy2T2PPx3j861amM3wPLen322hEjEHtowxMiLU5PgLP8PeuNr6Z2o4TQ
         fUJHCCJe97GsmhFtmmzvnYWUSZMYZ8x++wHhi/ExULf8330jnEeoBuwEmLeaO2R1iGNl
         BwMb+e6xv8GS8yJqsfWOn4U+1GhRLJ9ETTXWpuEEo3imYZsDAnBx/M8BguRmk7/nrHYR
         UdiqO4Sd/EjScP5CtyXJCGwemx6asFHjZ69EaZ3DQpknEtq2PqdFXcJ1YNHCmcqMqpVK
         fr7g==
X-Gm-Message-State: ACgBeo0PmNUF3DO3RMzcUCnAenHwWVZJ89PCpaSoyQ0WLJsXpsGkfVCG
        9rUYrq4GRIsxZQoC1xRQPa8=
X-Google-Smtp-Source: AA6agR6bY5pRZZgZJWUTcKXx0KFpJfgIuDOfzgC6Sp5/POHeXp5qN4jI+lf5KNbNjoXHPZ5BAp/2vA==
X-Received: by 2002:a05:620a:1011:b0:6bc:62fc:6e4 with SMTP id z17-20020a05620a101100b006bc62fc06e4mr36723150qkj.484.1662474937349;
        Tue, 06 Sep 2022 07:35:37 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:20bc:1817:1631:6d06])
        by smtp.gmail.com with ESMTPSA id br7-20020a05622a1e0700b00344f91f6fe0sm9623402qtb.67.2022.09.06.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:35:36 -0700 (PDT)
Date:   Tue, 6 Sep 2022 07:35:36 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits
 mess
Message-ID: <YxdauBT3OPW2mXVz@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:55:20AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 05, 2022 at 04:08:15PM -0700, Yury Norov wrote:
> > cpumask subsystem uses nr_cpu_ids and nr_cpumask_bits interchangeably
> > despite that the variables have different meaning and purpose. It makes
> > some cpumask functions broken.
> > 
> > This series cleans that mess and adds new config FORCE_NR_CPUS that
> > allows to optimize cpumask subsystem if the number of CPUs is known
> > at compile-time.
> 
> Who will use this? Distro's can't,

Raspberry PI can. Smartphone vendors can, and probably should. Ditto
for vehicles and all embedded applications.

> which means 99% of people will not
> use this ever. Is it worth it?

I will definitely enable it for myself. Actually anyone who set NR_CPUS
to a non-default value, may also be interested in FORCE_NR_CPUS.
