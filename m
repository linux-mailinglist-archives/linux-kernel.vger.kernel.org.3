Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978F85297F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbiEQD0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiEQD0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:26:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F0436E21
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:26:42 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x52so15727658pfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kM0s53Ym3shV8W020VlmwK4XjayyE5Z6Itqi9ef83fY=;
        b=Ed3d1GbhYTnueBxnNdwRguiR2+KwqD3IaQZOOOMRdgBxOJ2uc9YS3brkPM5p8vbLhZ
         dZQ4JkQ5yK3nqltYlB02RXsFu2Boi9pa7/5iLRN1cziQt3q0XzyUV/0UwcRRo8939IS7
         tMqwZ2ILL/2wG1mIe0otRp1gaINOnPIAPfRmqn/FaaaSPmUtRKE8y+Por4DiYvYIqdin
         i5wHcOPcf10kjO1GKgfqreYUXpxp709ngqLkrxYrIzsqjj8cWeLRa3QpvEIEdrNqgHYq
         ALQoWcowLg8bte1bd8EQOr2sMmx3VsL9VlWHPKKvAGfqRZDS33ZAufp8Z+4TewEonEIR
         viDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kM0s53Ym3shV8W020VlmwK4XjayyE5Z6Itqi9ef83fY=;
        b=y1/z0bzLthrPNTEVqzMxUPhTa4FbQech+N1qrdc7chm+oF7+1cQi97XTxmQIpuZv6K
         q8DeXeSlhVpezgNfio/+iUnQEvJ9euRBIbUl89rYICK8pIkhLQnsyu3DZrlSR+JjHiHm
         onqOrI3fSDgjpU5UHv80qWX1ZiRiygsyD1EJ0UBuJagkp58+nNmv260FQB+EBt+yRpku
         hMnR04v7yoXZ95cqKTnhRlisI42Rvod+PzSwiMwCXUc7tJ88uZLQgLVcb3enbv+VG5Tj
         lXK6Q1BA9T+RgD3/FmsjmuO8di/J6vKC/LZ0hB0gIxaaHq/N0QnQ0d68plV1SC19K/IS
         HWPw==
X-Gm-Message-State: AOAM5322gk6V3J0uVOeX5Hs5c1l/Wn4oK84G7NHemAyCt976XBoVm2ar
        IB3T/SbyVmKmP+A5cLDD5MZyfQ==
X-Google-Smtp-Source: ABdhPJyiACufKLkXw5HSHpjJQDow0PPAWQUvFlkBN0Isoz5oOTkjrAZ3n31R0YhFOo82OtQER7qhKg==
X-Received: by 2002:a63:4b5e:0:b0:3f2:3f20:6fc9 with SMTP id k30-20020a634b5e000000b003f23f206fc9mr12545370pgl.454.1652758002181;
        Mon, 16 May 2022 20:26:42 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902e88800b0015e8d4eb28fsm7773177plg.217.2022.05.16.20.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:26:41 -0700 (PDT)
Date:   Tue, 17 May 2022 11:26:38 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v12 0/7] add hugetlb_optimize_vmemmap sysctl
Message-ID: <YoMV7jhf6jKwTvDQ@FVFYT0MHHV2J.usts.net>
References: <20220516102211.41557-1-songmuchun@bytedance.com>
 <20220516114620.d4d85cb35690b4c8265953d6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516114620.d4d85cb35690b4c8265953d6@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:46:20AM -0700, Andrew Morton wrote:
> On Mon, 16 May 2022 18:22:04 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > This series amis to add hugetlb_optimize_vmemmap sysctl to enable or disable
> > the feature of optimizing vmemmap pages associated with HugeTLB pages.
> > 
> > v12:
> >   - Add patch 3 and patch 4 to handle the coexistence of hugetlb_free_vmemmap
> >     and memory_hotplug.memmap_on_memory (David).
> >   - Remove Reviewed-by from Mike in the last parch since it is changed.
> 
> v11 is in mm-stable now, so please send patches against that.  AFAICT
> that will be quite straightforward.
>

IIUC, the mm-stable is introduced recently, and we consider those commits
in mm-stable are stable (meanning the commit sha1 is stable as well).
I'll send a new patchset based on mm-stable.

Thanks.

