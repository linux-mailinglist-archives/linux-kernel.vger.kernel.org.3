Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD76519619
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 05:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344428AbiEDDlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 23:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344413AbiEDDl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 23:41:26 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9562F28996
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 20:37:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t13so155498pgn.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 20:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mnH+42aht6yqmG7U5pfKT59kRTusDPAPgC1nDObmhLU=;
        b=xq0OE+G1oprXqRtC6pQz/5wP42YdYcl3p8QPLJHh1Zo400NXUFiruszN4dZxmb8CKL
         2rglpn6BJ6BPeW4159iBSgG3jVIhdjiQSMXsqIT6j+sxjiCurYrjcpRORaFCjatHlZY3
         /jgUT5V7IcFACKZNJTn2kkt54kOyO2x1EhkmUYwXJWRUd9yvhmgQz5snWeCKBlewCfuw
         uZDdZsC1iAyr/owg+4eguxIJlluL0zrJFNQZu2D5un4lWb8e022BJ4ZXuHPCb54IH6kd
         nrioLR3t6d5Ko7a/ie9dEa0HCsXJKzjlptJrY91Cx6BR0GyjE+mb+E75bu3DTNTV/twp
         yk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mnH+42aht6yqmG7U5pfKT59kRTusDPAPgC1nDObmhLU=;
        b=6CYcP9oqRRIzfamsF0fVFNww3gcUQd6U6Vwj2IZ8R4qxV0zDoCAym+C2p7KyS8ZLPT
         SmuBeRDtFplDJBX+g69JGnmE4U44Quo6NF0UI+H43sUx+rcTLsY7GZDny0QAGX7SUpRq
         qRExesnu8QERhPlz6BYpE7vpje691+7T+P+mNPelLwfWpZKfpy8Zmq76V57X9GvSYBl6
         /99HBCsSLYPxUiIPyu3iAAvG7Bo3EDfXMCysa8VkWveATLMqAtilosEspZHvxPhOkWZ1
         flTMmNvqWirlf7pDbf5VXn1oRL0TLSW5L5BdHbHRNV+paQbH/RNsyQBzOdjzvGjLUCcB
         Ig/w==
X-Gm-Message-State: AOAM532ycbcmBUOD44kGSR2SbwkBPz1aD+BC2six+KbpPIKWd6taJBMe
        Mxa6rMN0rfQvBD1vRrcz2/oGXw==
X-Google-Smtp-Source: ABdhPJwnrBK2PxUL2wLY3YNmxal8cHQW0OPf/mceeWgk1gF2mGj25P+YfQ8ZF5ZQfsXlWJPDRcm7zg==
X-Received: by 2002:aa7:848a:0:b0:510:44da:223d with SMTP id u10-20020aa7848a000000b0051044da223dmr263616pfn.66.1651635466035;
        Tue, 03 May 2022 20:37:46 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id v4-20020a62a504000000b0050dc7628149sm7057285pfm.35.2022.05.03.20.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 20:37:45 -0700 (PDT)
Date:   Wed, 4 May 2022 11:37:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v9 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Message-ID: <YnH1B1Al/oW3rbmu@FVFYT0MHHV2J.usts.net>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
 <20220429121816.37541-3-songmuchun@bytedance.com>
 <3d040faf-7fc1-80a6-c584-aafeff27af18@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d040faf-7fc1-80a6-c584-aafeff27af18@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 05:23:37PM -0700, Mike Kravetz wrote:
> On 4/29/22 05:18, Muchun Song wrote:
> > When "hugetlb_free_vmemmap=on" and "memory_hotplug.memmap_on_memory"
> > are both passed to boot cmdline, the variable of "memmap_on_memory"
> > will be set to 1 even if the vmemmap pages will not be allocated from
> > the hotadded memory since the former takes precedence over the latter.
> 
> I had to read that sentence a few times before understanding what it was
> trying to say.  Not insisting, but how about this instead:
>

Sorry for my poor English.
 
> Freeing HugeTLB vmemmap pages is not compatible with allocating memmap on
> hot added memory. If "hugetlb_free_vmemmap=on" and
> memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
> freeing hugetlb pages takes precedence.  However, the global variable
> memmap_on_memory will still be set to 1, even though we will not try to
> allocate memmap on hot added memory.
> 
> Not sure if that is more clear or not.
> 

Clearer than mine.

> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
>

Thanks.
 
