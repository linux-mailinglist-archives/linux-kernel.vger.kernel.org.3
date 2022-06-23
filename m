Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309AD556FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376872AbiFWAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 20:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233875AbiFWAyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 20:54:32 -0400
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E03A1B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:54:30 -0700 (PDT)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1048b8a38bbso7964397fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 17:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7BGYb4uJNzNMJaBdJBYOJtJ2jniVCCa2u6RxJZ+q+BI=;
        b=j0AKNqfPv99QIxZddYMg2OS66qDt1jkcGjrEAVIuefE9vT81dg/ZKw3d9pL2IWDsiE
         sd8g+qD/kQG0mdd/Kovv2vkyvENh2yU0iK7tgA2PE6HZO7RmL+UMR6YIIlpFOj0x8VmA
         LFx1e+AC8gOFANdQDlfJiMsFxoPwqAVjTubuf28H9klfluYh4r9nGCHMoRTdfejZKtBg
         A8AtqHUhSJnvw9d9NCk0eAgLP5p2GSRWrHPGEjJHSYC2fUm6zdM0hsqgdE71k1DdzUU9
         X2H+hKNcKwSbYvxXG8PZ5+OS4SIviNYO48AfJKLvLt4af5fHxaqCTZKyseHPUWciwnt/
         4CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BGYb4uJNzNMJaBdJBYOJtJ2jniVCCa2u6RxJZ+q+BI=;
        b=jkbxthhLlMe1vIY8Ru4+mqMZPNj0OYaerPQ70vSGSO2sjPT88dmsXytC1EQZNuFbOL
         BM+wHFBJNOPR0W9fQ1KV8xI1TJQfqUPJ1mdeEPeVdFgI9xQAdc4UvEWirZxdmD6tMJVR
         lqYWmMxy8jb6YNPMxTvNoAdQAWZ7pbTMZLZX3meTDHkWJxUF+/l16JQj7Ljdi2MobOGX
         a5vI2QzMQz+QhIGc8/aUCWZZdVRUGJjh6bPKviW0x78Ze7wwVlVNr9pXQVCPvW8RQVyv
         29PqTXWRFpDoonfunZgLCal7n5lpS+D+/BZyU30z/Ack3QR/bk5t0mkCYEY6sbPWMboy
         xQ/w==
X-Gm-Message-State: AJIora+hA9I6Sig4keTjciDjS21ITs11IP2ijrFQWvS6papSyZKo7noc
        NR0LlH/TiVsF63sbt7vNEl5ydKkprKY=
X-Google-Smtp-Source: AGRyM1tVMhkDW5yh22qxALM0HjpAAm4fYkBDTGoSfQjMh0zH4hyVaOHkXq9OYgfe9y3VxpWD/hdDfg==
X-Received: by 2002:a05:6870:6588:b0:101:c8b2:6b85 with SMTP id fp8-20020a056870658800b00101c8b26b85mr726652oab.159.1655945669981;
        Wed, 22 Jun 2022 17:54:29 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id fq38-20020a0568710b2600b000f28a948dd2sm3720921oab.21.2022.06.22.17.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 17:54:29 -0700 (PDT)
Date:   Wed, 22 Jun 2022 19:54:27 -0500
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] memblock tests: add VERBOSE and MEMBLOCK_DEBUG
 Makefile options
Message-ID: <YrO5w+dNCIH5F3Rj@bertie>
References: <cover.1655889641.git.remckee0@gmail.com>
 <0754cefe-e8e1-6eec-cad0-35c081c880d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0754cefe-e8e1-6eec-cad0-35c081c880d7@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 12:00:05PM +0200, David Hildenbrand wrote:
> On 22.06.22 11:29, Rebecca Mckeever wrote:
> > These patches add options VERBOSE and MEMBLOCK_DEBUG to Memblock
> > simulator, which can be specified when running make. These patches also
> > implement the functionality for these options.
> > 
> > VERBOSE
> > Usage:
> > 
> > $ make VERBOSE=1
> > 
> > Passing VERBOSE=1 will enable verbose output from Memblock simulator. For
> > each test, the verbose output includes the name of the memblock function
> > being tested, the name of the test, and whether the test passed or failed.
> > Since all the tests in Memblock simulator run as one monolithic test, this
> > output is a quick way to get a summary of test results.
> > 
> > MEMBLOCK_DEBUG
> > Usage:
> > 
> > $ make MEMBLOCK_DEBUG=1
> > 
> > Passing MEMBLOCK_DEBUG=1 will enable memblock_dbg() messages. These
> > are debug messages built into several functions in memblock that include
> > information such as the name of the function and the size and start and
> > end addresses of the memblock region.
> > 
> > Rebecca Mckeever (4):
> >   memblock tests: add user-provided arguments to Makefile
> >   memblock tests: add verbose output to memblock tests
> >   memblock tests: set memblock_debug to enable memblock_dbg() messages
> >   memblock tests: remove completed TODO items
> > 
> >  tools/testing/memblock/Makefile               |   4 +
> >  tools/testing/memblock/README                 |  10 +-
> >  tools/testing/memblock/TODO                   |  14 +-
> >  tools/testing/memblock/internal.h             |   7 +
> >  .../testing/memblock/scripts/Makefile.include |  10 +
> >  tools/testing/memblock/tests/alloc_api.c      | 241 ++++++++----
> >  .../memblock/tests/alloc_helpers_api.c        | 135 +++++--
> >  tools/testing/memblock/tests/alloc_nid_api.c  | 371 ++++++++++++------
> >  tools/testing/memblock/tests/basic_api.c      | 365 ++++++++++++-----
> >  tools/testing/memblock/tests/common.c         |  58 +++
> >  tools/testing/memblock/tests/common.h         |  54 +++
> >  11 files changed, 913 insertions(+), 356 deletions(-)
> > 
> > ---
> > Changes
> > 
> > v1 -> v2
> > PATCH 2, in common.c:
> >   Remove #ifdef VERBOSE around prefixes and related constants
> >   Add __maybe_unused to prefixes
> >   Move PREFIXES_LEN_MAX, DELIM, and DELIM_LEN so that they are
> >     immediately after the other constants
> >   Add #ifdef VERBOSE around definitions for test_*() and prefix_*()
> > 
> > v2 -> v3
> > PATCH 1:
> >   Add Reviewed-by tag
> > ---
> > 
> 
> Hi Rebecca,
> 
> no need to resend a new version that frequently; wait for more feedback
> first.
> 
> Usually, people expect a new version when there hasn't been more review
> feedback for a few days.
> 
> Also, there is usually no need to send a new version when you get a
> rb/ack tag: the maintainer might just pick them up when applying the
> patches.
> 
Hi David,

I sent v2 because I noticed a nontrivial mistake after I sent v1 and I
wanted to save reviewers some trouble by correcting it right away. I
agree that v3 was probably unnecessary.
> -- 
> Thanks,
> 
> David / dhildenb
> 
Thanks,
Rebecca
