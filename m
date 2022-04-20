Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0004D508C21
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377432AbiDTPeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiDTPeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:34:19 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB37D13E1E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:31:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id b17so1551441qvf.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a9+tln+SBWdrxscTorynVYTsRPymEa6IdAPPuiE+hRA=;
        b=MJ5awmtjdB+b0qHjzLnwU4AyLo2nsLSfcty8TJGyedKEFAfi7gqfN2JD6hT3fF5m3Z
         ybnOKBEAU3ayeeJuf7tuY0RKVwlcHd2qTfdWiL78BZFbjpfGAKAoHxyC+s1LI7yS9KZF
         AlhO5mwBQjUZm+edcJ6MIV9Vmtc/gX765MC+zukIJYz11/5YkXIeeuNxzAbh1FSqTOJM
         Nnhcy/OONLSeNEBMRgs22lN0MgNb/KA0voZd/WAovshlq5IEspJjgqoMPCGvNoMTZHm3
         8AP/TP/DRGC6yzuDN9GXoj/DYPxWYJl88QVXGpwy+yUT9L8wQYbgMcbghdfRs3wMwU9r
         h+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9+tln+SBWdrxscTorynVYTsRPymEa6IdAPPuiE+hRA=;
        b=J21E9CVTjVcJKrF1Whprl8plFrf+anN2fGTtdxJwo8FwZqvlgXeulVjdhIEU1k73J8
         QfvOomuPA/+JeMALubngtTpDdEMNCSGiwjfXEEXr+srv6gnOlcHIB5WW5pr5kSU4z8f1
         ONsDSw3gOC07dVnJeShjhT1CJVro92r/2g+y2AJpgANzfUYQS5GpZ+4rE70vKCvkdLA4
         2u16ks2Zxo9rb1OH+sUFxfVwx1kOpmR7JK/vnaqXxUk09FqD6pKOyWbxgNl/X9b4L3Cm
         T48zTXgVujplQqGq5zs2IhXczBrK1dE4/i7DSnrDNMFr/T69Qmv9TkzBbb60Z3IpynyC
         3v0Q==
X-Gm-Message-State: AOAM530WzSxZmjFw5copwjUSe8j3e6v8B36ny99732uh2WbMLNT04RZK
        3ew9fD0+I13H1cxwVRkKYVIBiSyIUfzWyg==
X-Google-Smtp-Source: ABdhPJyqNs7YHl/vg9v6mONyUg0PEUcOfirwAa5f/w2fqiEaZEObprOa2+X7OPvm0PSgFzrm4bRCQA==
X-Received: by 2002:a0c:ed46:0:b0:444:3e69:767b with SMTP id v6-20020a0ced46000000b004443e69767bmr15933174qvq.71.1650468691098;
        Wed, 20 Apr 2022 08:31:31 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a16b100b0069eb1eb06b7sm1582231qkj.131.2022.04.20.08.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:31:30 -0700 (PDT)
Date:   Wed, 20 Apr 2022 11:31:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/uffd: Move USERFAULTFD configs into mm/
Message-ID: <YmAnUQdQ63jD48ad@cmpxchg.org>
References: <20220420144823.35277-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420144823.35277-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:48:23AM -0400, Peter Xu wrote:
> We used to have USERFAULTFD configs stored in init/.  It makes sense as a
> start because that's the default place for storing syscall related configs.
> 
> However userfaultfd evolved a bit in the past few years and some more
> config options were added.  They're no longer related to syscalls and start
> to be not suitable to be kept in the init/ directory anymore, because
> they're pure mm concepts.
> 
> But it's not ideal either to keep the userfaultfd configs separate from
> each other.  Hence this patch moves the userfaultfd configs under init/ to
> be under mm/ so that we'll start to group all userfaultfd configs
> together.
> 
> We do have quite a few examples of syscall related configs that are not put
> under init/Kconfig: FTRACE_SYSCALLS, SWAP, FILE_LOCKING, MEMFD_CREATE..
> They all reside in the dir where they're more suitable for the concept. So
> it seems there's no restriction to keep the role of having syscall related
> CONFIG_* under init/ only.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
