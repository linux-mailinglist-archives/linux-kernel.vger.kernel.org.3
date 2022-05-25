Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3E533662
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbiEYF1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiEYF1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:27:53 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1C9544EA
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:27:51 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id k14so4367585uae.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oeM35y0Rq8IijojkgwiCh/ZfifdSgAvlxBvAYeE3+w=;
        b=Xcy0RVXgGffjX4DcbkzVtxPJT+TeZLlT+B26FxyuzmhgmQ4Kt1R9p0gcqRbthfEJnM
         N9OLUpcwlKfB5YkMbn3X/LkYDo0UIPjthEuU68zzVL7ajoMKnQNaN+A5izHYLeRJLitR
         7YpRwOUyCO2nJ+OsadA+u65XhpfxmL7hXg9p++wpkiBmXboKTkGFiQ5yU66aftXIUpZl
         aZ5zADhk8kb5/o61+0O5jcTcR+fDe9ayxNXJ5wRd1N1FgJYhf5JixYmlgpykZi0mffJI
         NYeQ8D/raqPTNPYqMqIBKjS8b+j6rOrFVhwaa9HYJGa1NIoHXzL6FwyCDyAc508ry0YT
         2taQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oeM35y0Rq8IijojkgwiCh/ZfifdSgAvlxBvAYeE3+w=;
        b=TYcAelRKCpb7GAWJtSGmUTSGOZnt+kIcHgdEF7s95i/xgdEezvzqPY+Ddf+dQCWvNp
         xwQ9YtGQoF4oM/OfEXcFgUNsUSW+7tyuVVskX8c8k6F4O01tGhOkx7EzRXAbDCwcu0lt
         XYvmMQ7+ExiSKilS85MHylZWtZOWxe3rFambcJsZtS7l2lsra/r7Ryl81VQtepXkvBbo
         BMo+lYl6DcUP9H09nnh1HKSXjdJ9WhFfWenJSwG1YwDLMOi8t6V4DEXbP3IMizmU66Pt
         ofDxQg+1npazti49MP5NHY8zVtQAm6/xbbrFbdrfcTG0FB4SmZ4h4hUXmn553a89cBaw
         G0dw==
X-Gm-Message-State: AOAM533xz4VWiTu078aWVmJy6nYwjfWtPKk5xiF8CjSnOBR05Pk5Ztv5
        I/CmAFHyEGOuCtyPCny2ogIaGGbpieL1+iLdLDJg2A==
X-Google-Smtp-Source: ABdhPJxn0kyGTNbbVOE3jMzV3HfEw+y5G7vtIz4vsEhVt1oN1dUIBHE1n9ttAVexsOr3fXTYg6hn7d6dv51FKL/hO68=
X-Received: by 2002:ab0:59d2:0:b0:368:a498:189 with SMTP id
 k18-20020ab059d2000000b00368a4980189mr10208212uad.4.1653456470608; Tue, 24
 May 2022 22:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
 <20220512160010.00005bc4@Huawei.com> <CAAPL-u_diGYEb7+WsgqNBLRix-nRCk2SsDj6p9r8j5JZwOABZQ@mail.gmail.com>
 <20220518130037.00001cce@Huawei.com> <CAAPL-u_c+q_uCMJXOtYGg42Fj2gSnD6c8vgYQmi1iVpRwHiQTw@mail.gmail.com>
 <8735gzdpsx.fsf@linux.ibm.com>
In-Reply-To: <8735gzdpsx.fsf@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Tue, 24 May 2022 22:27:39 -0700
Message-ID: <CAAPL-u_ZtCsuNNu2SoqCeqQqrGQxjcsjrbu0ooP3y5Zw802daA@mail.gmail.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
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

On Tue, May 24, 2022 at 6:27 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> Wei Xu <weixugc@google.com> writes:
>
> > On Wed, May 18, 2022 at 5:00 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >>
> >> On Wed, 18 May 2022 00:09:48 -0700
> >> Wei Xu <weixugc@google.com> wrote:
>
> ...
>
> > Nice :)
> >>
> >> Initially I thought this was over complicated when compared to just leaving space, but
> >> after a chat with Hesham just now you have us both convinced that this is an elegant solution.
> >>
> >> Few corners probably need fleshing out:
> >> *  Use of an allocator for new tiers. Flat number at startup, or new one on write of unique
> >>    value to set_memtier perhaps?  Also whether to allow drivers to allocate (I think
> >>    we should).
> >> *  Multiple tiers with same rank.  My assumption is from demotion path point of view you
> >>    fuse them (treat them as if they were a single tier), but keep them expressed
> >>    separately in the sysfs interface so that the rank can be changed independently.
> >> *  Some guidance on what values make sense for given rank default that might be set by
> >>    a driver. If we have multiple GPU vendors, and someone mixes them in a system we
> >>    probably don't want the default values they use to result in demotion between them.
> >>    This might well be a guidance DOC or appropriate set of #define
> >
> > All of these are good ideas, though I am afraid that these can make
> > tier management too complex for what it's worth.
> >
> > How about an alternative tier numbering scheme that uses major.minor
> > device IDs?  For simplicity, we can just start with 3 major tiers.
> > New tiers can be inserted in-between using minor tier IDs.
>
>
> What drives the creation of a new memory tier here?  Jonathan was
> suggesting we could do something similar to writing to set_memtier for
> creating a new memory tier.
>
> $ echo "memtier128" > sys/devices/system/node/node1/set_memtier
>
> But I am wondering whether we should implement that now. If we keep
> "rank" concept and detach tier index (memtier0 is the memory tier with
> index 0) separate from rank, I assume we have enough flexibility for a
> future extension that will allow us to create a memory tier from userspace
> and assigning it a rank value that helps the device to be placed before or
> after DRAM in demotion order.
>
> ie, For now we will only have memtier0, memtier1, memtier2. We won't add
> dynamic creation of memory tiers and the above memory tiers will have
> rank value 0, 1, 2 according with demotion order 0 -> 1 -> 2.

Great. So the consensus is to go with the "rank" approach.  The above
sounds good to me as a starting point.

> -aneesh
