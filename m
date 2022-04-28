Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCDA51386B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349227AbiD1PgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiD1PgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:36:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A55D19C37
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:32:53 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q13so800948plr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kuwwuf3KdHolggB4QynNZDU01tz6frvfCx6pko4ErLU=;
        b=mdwwawlT3tK+Sad2l7xPaMAmRf8hcbRiIG24rR+r+5XncpqBaAxD+T9Mc8kweL87tt
         7pxC+hDyHTBI1YA0Y8DpenlSOkkzIXdCrExhIVhEEgir265KjS8iLSnDs3lj0Ska4MNt
         CYCojUx/Edu90VQg7mscBAD8yWxyWZCNOa4KnIh7qz/YGkxUxg2hEtZzlfmhg/qwpTUf
         YZN448EfVQ2vpfH3C3+z7/LFFAbL0vzJZ7hTBnawYBhjVSImLTk2+0+myqPp9sua/I6s
         nKgB5dV7fOOx7gRflnP/GNah1zxnuZnYBmPjq0FnFAEAH9vt150YxPct9oZMuf2KdNcz
         QZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuwwuf3KdHolggB4QynNZDU01tz6frvfCx6pko4ErLU=;
        b=1n4cHkqOOlYRf7xoyFwjlGXx3y7PBltC+0dDMex1LLtQ8Au7tAFdnf1Rl6el01px6w
         ZEKOKi42x/VeGhKxNc+ROCXAqXNwKcKY0ATeDY0L2WM5AGfdnNfndqDfelyo/SNUJveF
         /t6ZLuXrjg77HkrAzgzNgIf3/PVpEzd/n/UbTAEBu2H0W6zBOP4fMjAi/jaqCjk0oono
         4hi/+QM17R3nxqguMznVcD1Sc3elMesqwaV+CxX9I1NnQCnNFS0myn0T/n0y5x2MOqmi
         SwaeTz6F/gAKG235XAe2zZDfTsiTlKNKAZMkBzWnL4gOGihuLvPZkuddkgefkVLgeVWC
         wmtA==
X-Gm-Message-State: AOAM532dM2ocKxiYQIAEODmPSXv7Sm00VDc0pjzeuqIcijImhuel4w24
        ZAakmo+aVJZayOV6U9hyVgHNfQ==
X-Google-Smtp-Source: ABdhPJxZUpJsK6m9XBCnUejJDo99DTeh1DPLe4DudO9Tr9g5JrpDs9QvZ+cvhBkp9xEF5WGlS4O2vw==
X-Received: by 2002:a17:90b:180f:b0:1d9:91db:2976 with SMTP id lw15-20020a17090b180f00b001d991db2976mr20544174pjb.84.1651159972679;
        Thu, 28 Apr 2022 08:32:52 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h132-20020a62838a000000b0050d3d6ad020sm192323pfe.205.2022.04.28.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:32:51 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:32:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     syzbot <syzbot+a8ad3ee1525a0c4b40ec@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        jmattson@google.com, joro@8bytes.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: [syzbot] WARNING in kvm_mmu_uninit_tdp_mmu (2)
Message-ID: <YmqzoFqdmH1WuPv0@google.com>
References: <00000000000082452505dd503126@google.com>
 <13b3235ef66f22475fd4059df95ad0144548ccd1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b3235ef66f22475fd4059df95ad0144548ccd1.camel@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022, Maxim Levitsky wrote:
> I can reproduce this in a VM, by running and CTRL+C'in my ipi_stress test,

Can you post your ipi_stress test?  I'm curious to see if I can repro, and also
very curious as to what might be unique about your test.  I haven't been able to
repro the syzbot test, nor have I been able to repro by killing VMs/tests.
