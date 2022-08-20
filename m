Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D220B59AA55
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiHTBEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 21:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHTBEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 21:04:31 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F662103C4A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 18:04:30 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so5678972pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 18:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/Y5lHtfDOgHcOef5HSbxzPooyar/bKM8Dwba8ypxoL0=;
        b=SW1MjJSeP+bDFGAYJxSKETSxuG2jBpYoerBwoNQqzarKzWwN28sxiyJs5P7fZV7qAG
         fab5B9F8IOzSjFfAPRoVeYamd0IoeUeXzNsYd+BxTOME63q2j99lTvLU+IY9b8zwVlOk
         XK7BX4rECknKAK/Miv7Fbn24etobKUslgNTqkjwhDbZOHm7svVJORx49CGk6IExNIfg4
         hKfKoVxJ8ddjkX70fJ37f7s1DN88zplVptRZOUwOQuCc/1Tkjo64DZqvr4SwVhsC2aq1
         uDDPHQXc+aEfxlojRhIECgbRUoQVVWX7DNyBmVpdHZXolPq5Ru+iuVdFhKuSqpv+rHcr
         uZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/Y5lHtfDOgHcOef5HSbxzPooyar/bKM8Dwba8ypxoL0=;
        b=bsRd+1u9FmoyjcN/5CqWUEj3C3o9KcyFijXXlC5bc2W7cgsnvs+ShZIOcuL4D/xnjb
         RIQslbAZR+Pk/P/Orj7dJu1PRm4XtVwz+u7xxcS3+IYAx//BQDDbAKnuRjl5O2/r2bF/
         EfbY6/rWyw7BxoUrNVuGOlv/M8ae57SBhyHCfrS3LMHAoH/ogMzRXPiGY0a1MgLjkl3i
         8SOrzmp5f0vR7qr7Evxznr9xRyUzMxt/vaakKEJAuDmSRF3RXgmYhQrvyLBNVe0+6/Im
         mgePLeZa1EXklNzmQwU/8golp+3LQtxKmmY1iLciG/zbb9CKSfdEPCDUkut0zj45QbM9
         iEYQ==
X-Gm-Message-State: ACgBeo3OJYB6ZAJD4GZoNDB799bGa2mZHcSSLO5DGgFFeFVRQf6z+ody
        GtMUnWH6Y+GbS3C9OZIBGr/0SwBWHXUrJvou
X-Google-Smtp-Source: AA6agR4nU1fIGgyts2XcWTJye531TNjPdUDubtz6CAhtah7FRLyOIU2IGuSlibJr2UElMQCM1qMuuQ==
X-Received: by 2002:a05:6a00:b4e:b0:52f:59dc:70 with SMTP id p14-20020a056a000b4e00b0052f59dc0070mr10481781pfo.2.1660957470082;
        Fri, 19 Aug 2022 18:04:30 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902da9200b001714c36a6d9sm3718881plx.229.2022.08.19.18.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Aug 2022 18:04:29 -0700 (PDT)
From:   lizhe.67@bytedance.com
To:     mhocko@suse.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        mark-pk.tsai@mediatek.com, mhiramat@kernel.org,
        rostedt@goodmis.org, vbabka@suse.cz, yuanzhu@bytedance.com
Subject: Re: [PATCH] page_ext: move up page_ext_init() to catch early page allocation if DEFERRED_STRUCT_PAGE_INIT is n
Date:   Sat, 20 Aug 2022 09:02:57 +0800
Message-Id: <20220820010257.11488-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz>
References: <Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-18 7:36 UTC, mhocko@suse.com wrote:
>> From: Li Zhe <lizhe.67@bytedance.com>
>> 
>> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
>> we call page_ext_init() after page_alloc_init_late() to avoid some panic
>> problem. It seems that we cannot track early page allocations in current
>> kernel even if page structure has been initialized early.
>> 
>> This patch move up page_ext_init() to catch early page allocations when
>> DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
>> DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
>> allocations. This is useful especially when we find that the free memory
>> value is not the same right after different kernel booting.
>
>is this actually useful in practice? I mean who is going to disable
>DEFERRED_STRUCT_PAGE_INIT and recompile the kernel for debugging early
>allocations?

Yes it is useful. We use this method to catch the difference of early
page allocations between two kernel.

> I do see how debugging those early allocations might be useful but that
> would require a boot time option to be practical IMHO. Would it make
> sense to add a early_page_ext parameter which would essentially disable
> the deferred ipage initialization. That should be quite trivial to
> achieve (just hook into defer_init AFAICS).

It is a good idea. A cmdline parameter is a flexible and dynamic method for
us to decide whether to defer page's and page_ext's initilization. For
comparison, this patch provides a static method to decide whether to defer
page's and page_ext's initilization. They are not conflicting. My next
work is trying to achieve your idea.
--
Li Zhe
