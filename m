Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71154D5EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347659AbiCKJqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiCKJqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:46:08 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC2D1B3708
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:45:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id o83so1324167oif.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cVczuzNre+vtNmBk9yrx2YwKmhuwSmFiNpzeXGmT38c=;
        b=L+F3zhqkl/Ct8Qq1V35I+omWnTGlk+AjBc0WRiSjC7+RmA7r2TlIxxo6rufzP6haEU
         MGHHWTT3zhErtyNeAVx5otmei2A5HDbOtNu3p5l3NX3dgnWj0NiiQTziNzJotEQop8bS
         I/2gTOkEPc6Emea3sC7DRCcanpKRQuvmt+9d0FXTMsGktHjd9Mej5cTPxfn9vSOMASK8
         Xd+dht2uqezbrzDBua9fnhBtEu2ayXkTYvOPHdhLDK2VEwVA9HPNtrZcD1B5+Prrr4Eq
         pXhGJ6m92lz5kaVbH9+4EtsWhszitfUe+xQFhRrUqVVoWeLyAYcyThglGxmCTFh3A2GD
         JD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cVczuzNre+vtNmBk9yrx2YwKmhuwSmFiNpzeXGmT38c=;
        b=t3MJ0cACOkhYF32s+7lzFLQbCEMfCY85GSVea77IFIwnJ5bIPQEW1/h1K3SDfHc3ye
         ioWRKlchxdA5IVGWJXSyCvYu3mkRy5pGZ+DE3kSYY39cQDlPjWxSdc5qouSTTKSx6OBS
         STJWI56pFAO8Pwfdxm04DXEugXr+a1rzhhxtny7CYrJodjS0HG83g7w1r0uWm4uInrgw
         4pxVKNfJXZVVYIMyxC69gOzIxQn1S9fuMoZEXtn1HkP56Eu1INlxZ6AvWHNvmRwvLnOp
         5/CTJkMh0rCUVoiD8SRDltGv8whNynKyBgTfo+zfM2aSp+qKxXbFEqCPg6F4H5UvM6F/
         KhCw==
X-Gm-Message-State: AOAM533BcWys/z3xTnWaeScsZqf38mhdGO4lYbqq/+7QNaeQTyBKvb0M
        rTmGi0TjRn4qShn6WTkGKe+T0w==
X-Google-Smtp-Source: ABdhPJxpJQtMDTtXA2ssF7gPxUQOs6B6AaihiU1Ud4gfukMe6UQt48hg7ecbADzegKT2OiPivTZvhw==
X-Received: by 2002:a05:6808:218b:b0:2da:5fd1:a85b with SMTP id be11-20020a056808218b00b002da5fd1a85bmr4384601oib.71.1646991905244;
        Fri, 11 Mar 2022 01:45:05 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r21-20020a05683002f500b005b249ffa43fsm3483775ote.22.2022.03.11.01.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:45:04 -0800 (PST)
Date:   Fri, 11 Mar 2022 01:44:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     kernel test robot <oliver.sang@intel.com>
cc:     Yang Shi <shy828301@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm]  aae2359b1a:
 BUG:Bad_rss-counter_state_mm:#type:MM_ANONPAGES_val
In-Reply-To: <20220311022718.GC18612@xsang-OptiPlex-9020>
Message-ID: <a98d4b1-da3f-c183-52a7-af72131ee5@google.com>
References: <20220311022718.GC18612@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: aae2359b1a514180633c4a4e6666c91e44a928c8 ("mm: thp: don't have to lock page anymore when splitting PMD")

Yes, known bad patch, replaced by good patch a day or two later.

> url: https://github.com/0day-ci/linux/commits/Qianggui-Song/arm64-dts-meson-s4-add-gpio_intc-node/20220310-172923
> 
> in testcase: trinity
> version: trinity-static-i386-x86_64-f93256fb_2019-08-28
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-01
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   20.947643][ T4079] mm/pgtable-generic.c:51: bad pmd e7d8e333(8000000433c000c5)
> [   20.949757][  T427] BUG: Bad rss-counter state mm:84638533 type:MM_ANONPAGES val:512
> [   20.951030][  T427] BUG: non-zero pgtables_bytes on freeing mm: 4096
> [   20.960329][ T4080] mm/pgtable-generic.c:51: bad pmd 6dc594d8(8000000433c000c5)
> [   20.961775][  T427] BUG: Bad rss-counter state mm:bf324b3f type:MM_ANONPAGES val:512
> [   20.963109][  T427] BUG: non-zero pgtables_bytes on freeing mm: 4096
> [   20.974600][ T4081] mm/pgtable-generic.c:51: bad pmd d1c9ec63(8000000433c000c5)
> [   20.977758][  T427] BUG: Bad rss-counter state mm:e038d31c type:MM_ANONPAGES val:512
> [   20.978918][  T427] BUG: non-zero pgtables_bytes on freeing mm: 4096
> [   20.982960][ T4082] mm/pgtable-generic.c:51: bad pmd 8d2043e0(8000000433c000c5)
> [   20.994138][ T4083] BUG: Bad rss-counter state mm:890a50d8 type:MM_ANONPAGES val:512
> [   20.995441][ T4083] BUG: non-zero pgtables_bytes on freeing mm: 4096
> [   20.997140][ T4083] mm/pgtable-generic.c:51: bad pmd 78b279e7(8000000433c000c5)
> [   21.088268][ T3649] BUG: Bad rss-counter state mm:10e6eb4f type:MM_ANONPAGES val:512
> [   21.089552][ T3649] BUG: non-zero pgtables_bytes on freeing mm: 4096
