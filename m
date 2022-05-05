Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D1A51B80C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbiEEGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbiEEGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:39:05 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9438EFD17
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:35:26 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id x8so3301778vsg.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4bztzCmwlVS2QcT4CrwLAm2LJYy0mvP8yzB7o5GzUlE=;
        b=VAwbnBGTaJd6CJdGKIY38ODe/I0OSZG3i+j+HGdcVT0DkKaZqnFssiWzfzn+ARvpQu
         dvaH2jDGTkpqey5QsaZ89a3EGLC+YJSCRuyxJ1EuSnmgWMQ4I3Yd8uQsGh8YmzTeJSGv
         LWLbrwZIxlxVtZNLES/wezGhRQHZrvUcTuD1K1eS5Z3rE0RoB92Fm5/4FntJaUMND2GZ
         kyk8uzMJJ4kKfGoZmY9fVXY4HSPfWn7xVjX9cKGPKImthjYk9qrybX8HYuiGW/wVyvp/
         FPazVDw3DE3/oSqqLHe02RbelyDOpBN3DVCVkUtSw16cC08mfEx3KPlxVMONUeA4+vUJ
         Qp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4bztzCmwlVS2QcT4CrwLAm2LJYy0mvP8yzB7o5GzUlE=;
        b=bIpwbl1fnKjz9AJHqDomxAaYggOkd+NnmLRlw09MIIar6uw4Wx5EgoPOkPcImQnWZm
         S3rmQtKn9BczAjyNwEnCNYctVfrwUNl1Lb1JSTbPDNu/ouYe+0ZFCoo0hO47REC8nBOi
         xepQ6mrIVJmUL1dZbYSJl66ixDIfJ5mUBl69XOKOu6HsMEvsn7tE/cVNx18wVguru7eT
         mu6ItKaY1QFeG8lHaNHlOCIxUbCp98kTS159ckrJi9lzxU73GXfhmPslscwYQswlYNxO
         fhPn1lnRyRbrMRfNAPN1vD4YM13pQrddmsHX0Y0J2nMz5oLMCjhz6KpmySYpXUQVYIhT
         SJgw==
X-Gm-Message-State: AOAM530NFOyStMnUF7Zm3EhBKIjFNN9chkWkiNIRPaI/iLVjw3mrWZLO
        xIC9faHbD55x9T0YYuVeuTh0UpijUfsBj2g8ktUnaA==
X-Google-Smtp-Source: ABdhPJyuv+aiZuvubpfM0EsZUwPFAaIYXVBDKpW+Szkd7a/nvSf+KIq0OFlREKrCHj2NU6EZD8olW9vfDC1yhXwI+1k=
X-Received: by 2002:a67:2fc6:0:b0:32d:7195:32e9 with SMTP id
 v189-20020a672fc6000000b0032d719532e9mr1741557vsv.44.1651732525536; Wed, 04
 May 2022 23:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
 <20220501175813.tvytoosygtqlh3nn@offworld> <87o80eh65f.fsf@nvdebian.thelocal>
 <e47bf89c-cee7-3006-5c1b-c76f640c3e23@intel.com> <87mtfygoxs.fsf@nvdebian.thelocal>
 <9fb22767-54de-d316-7e6b-5aac375c9c49@intel.com> <CAAPL-u9UkG1WMQm5u1eAe+4-d04aqVAXc9H0gLSegYoHctkCnw@mail.gmail.com>
 <52541497-c097-5a51-4718-feed13660255@intel.com>
In-Reply-To: <52541497-c097-5a51-4718-feed13660255@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 4 May 2022 23:35:14 -0700
Message-ID: <CAAPL-u_G8dzXCjx=xcnemgXGQxwnVUFEy_NJzHsJOHapUm-9Ew@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, May 4, 2022 at 10:02 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/3/22 18:31, Wei Xu wrote:
> >> Well, x86 CPUs have performance monitoring hardware that can
> >> theoretically collect physical access information too.  But, this
> >> performance monitoring hardware wasn't designed for this specific use
> >> case in mind.  So, in practice, these events (PEBS) weren't very useful
> >> for driving memory tiering.
> > The PEBS events without any filtering might not be useful for memory
> > tiering, but the PEBS events with hardware-based data source filtering
> > can be useful in driving promotions in memory tiering. Certainly,
> > because these events are not designed for this specific use case in
> > mind, there are inefficiencies using them for memory tiering, e.g.
> > instead of just getting a heat counter for each hot page, we can get
> > events repeatedly on the hot pages.
>
> Also, I believe the addresses that come out of the PEBS events are
> virtual addresses (Data Linear Addresses according to the SDM).  If the
> events are written from a KVM guest, you get guest linear addresses.
>
> That means a lot of page table and EPT walks to map those linear
> addresses back to physical.  That adds to the inefficiency.

That's true if the tracking is purely based on physical pages.  For
hot page tracking from PEBS, we can consider tracking in
virtual/linear addresses.  We don't need to maintain the history for
all linear page addresses nor for an indefinite amount of time.  After
all, we just need to identify pages accessed frequently recently and
promote them.

> In the end, you get big PEBS buffers with lots of irrelevant data that
> needs significant post-processing to make sense of it.

I am curious about what are "lots of irrelevant data" if PEBS data is
filtered on data sources (e.g. DRAM vs PMEM) by hardware.  If we need
to have different policies for the pages from the same data source,
then I agree that the software has to do a lot of filtering work.

> The folks at Intel that tried this really struggled to take this mess and turn it into a successful hot-page tracking.
>
> Maybe someone else will find a better way to do it, but we tried and
> gave up.

It might be challenging to use PEBS as the only and universal hot page
tracking hardware mechanism. For example, there are challenges to use
PEBS to sample KVM guest accesses from the host.  On the other hand,
PEBS with hardware-based data source filtering can be a useful
mechanism to improve hot page tracking in conjunction with other
techniques.
