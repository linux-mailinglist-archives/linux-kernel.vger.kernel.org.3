Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F515AEE12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242140AbiIFOu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiIFOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:50:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F2A221E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:07:46 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id v15so5612626qvi.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=masHYRT9ahsmeIcRZrTIK4gZPR1npGsB/PZZIXwFzis=;
        b=aPeBVmJDXeMB0Znx/F+Prn5xo9S1/j3uj3CezX5DVKDHBF9wOUSeNJEgU6a4B6KJdw
         GCWGujMNbmCjWeQ/tsYhlqb0MtXA+TUxJDhn6iH9aiVFMeq6f9XQrXsZrFK2L8/K9SmJ
         9MmsMURywZpo+df1fbaK9TMXjkz2YcBaPCKzl/pI7222IKlchF9u5B0AZutbEod4CryS
         L01oGJGD7OP4Lt6xDoTyX4aepECYlDPW08Bh8dE6Q0h5AQfTZaOy8voBHEIb9GuuACvk
         k608RVJ1XPikLWN1guNkOsnW3znNgj6HaMWuWxZQG4Nqq2GJkx88tSpaXahzPoXBz4x2
         qijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=masHYRT9ahsmeIcRZrTIK4gZPR1npGsB/PZZIXwFzis=;
        b=LOVsBDrM654/8C/5t+WPtYZPTvOks+75fiRgOfVprGcCxGIgqt3jqop5jO5nOP1IcN
         kw6BEbeoFkUXQpKAxtmdkQf0l+jtvyfuTmgx3NXZMBddk322W5zFi1auS0Ynk26I6Dh1
         jVtXWi76Y/1WHLT4Tp5yrSILZC4xDDzFmVbWuRKAAhCjVAJA2o3c9iyvDDjAvayzzePC
         O833IZY+xEMfsj7IPHVVen43wHFRoHklajzjiWU527SW5cFob8wdx23qbtbLV2az1/or
         p3jp01uyLdIoBIsp9erodwuc4FtLnQhZLmiS+AE1eb+lkE0IW/o79MnserhU1Xci0Sn0
         ijNw==
X-Gm-Message-State: ACgBeo2pJcefPErPCDaB7G4It4M/jk3fzSefECIXhHL2sT8JW8N8Wz0w
        WWGPS78XjlXDz9M4FuKgzZs=
X-Google-Smtp-Source: AA6agR4ghoyW3pwaWUl7O+JhoVJqIVKTatDslqawsX9S+x5Pzp72hI5ihRh9pT02Dg83P6FMHPIEYw==
X-Received: by 2002:a0c:f445:0:b0:4a6:9f4a:9a66 with SMTP id h5-20020a0cf445000000b004a69f4a9a66mr8183823qvm.65.1662473192820;
        Tue, 06 Sep 2022 07:06:32 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:20bc:1817:1631:6d06])
        by smtp.gmail.com with ESMTPSA id q9-20020a05620a2a4900b006b928ba8989sm11427876qkp.23.2022.09.06.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 07:06:32 -0700 (PDT)
Date:   Tue, 6 Sep 2022 07:06:31 -0700
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
Subject: Re: [PATCH v2 1/5] smp: don't declare nr_cpu_ids if NR_CPUS == 1
Message-ID: <YxdT5w9Qd5SxK1wl@yury-laptop>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-2-yury.norov@gmail.com>
 <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxcKoaVGD+sTBjjG@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:53:53AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 05, 2022 at 04:08:16PM -0700, Yury Norov wrote:
> > SMP and NR_CPUS are independent options, hence nr_cpu_ids may be
> > declared even if NR_CPUS == 1, which is useless.
> 
> I'm thikning you're fixing the wrong problem here.

I'm removing dead code. If NR_CPUS == 1, nr_cpu_ids does exist, exported
as an interface variable, but never normally reached, because in some
other piece of code (not even in smp.h) it's declared conditionally. 

> Also who the heck
> cares about SMP=y NR_CPUS=1 anyway?

Build bots.

> Why do we need extra source complexity for this?

To have effective code generation for UP builds.
