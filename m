Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058F55E915
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbiF1P3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346936AbiF1P3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:29:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CFB21E0A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:29:37 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so16287917pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbW4NuEgaNk8iXnqeHVDmPcJNFTOfGhN7YoLZsDvjjU=;
        b=SYGhAs9kNTsqIjUiYzrGMrV724WHEeSKEt2JDTF3kV1rovW4Dh9JUi1asrwCOE5tY8
         dAXvt341ActjSq4Mre0xDy3f72LqABXcnID/vtUlIUSLJCBz7VN9IvVIj6jAl0FNZbAX
         7uxslHHE9evmGBv+JKpuVR30CQT+HvH29y4cxmfiXhTP89UsprA398fCd0SN44BYjIQk
         BtGUGY1IBoVJhX/D8Bn1UbdFG0MG5DEoiaYCRa6mRyPPl5uxThBT95CLthM7a/NraUvT
         DtPQ3+TBlrcj/ptoTx9vClcyCp4tPX93X5H+KsgbgAdKA7m1/z1JTkfd+9nwEMVhhkCB
         IyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbW4NuEgaNk8iXnqeHVDmPcJNFTOfGhN7YoLZsDvjjU=;
        b=JFPGMjtBSZbQiohwHoN+yrK4oNqMZEpgKPjN16QHA8WBriNeuwEtfBpi/w9r03UKG5
         i8zvgSj3GwIXevEfQASQE+HEsXq+4CG1+MS/vAiY2wkVmWtZts0yp+qVr1/OsVPF+6mA
         jpbGmTEgCoN6ET8PUl13MWDfFdPx1EtkXhFFwTGZPApwgbzZwwUnc6r3LZc1SGO+3cLR
         KJU+iXT2f9d4bxr/sSeFowAwJl3cVfL+EqIQU9C1MSTj4ZJ9ERltEJtJMq06/Ly8jIHs
         VuNvjOfVAQn63+CQRN624MGhhRUB9N3MSPM/t4J0Zlk2tOkny92JQNWCMouElisEGpdv
         XVSg==
X-Gm-Message-State: AJIora8IvfFMxN5Fxaj46bwaTQb1GIYxYrKzG3yk4ple8KPlA0vXCOB2
        EHmJQEPt1DAq4fde49hI/ewwAYgkZw1ZG+RLV4gTIw==
X-Google-Smtp-Source: AGRyM1teM52cYsj/ucnvyw+ULXM5H94YrpROT8deeiSMkpmkqiym/VDJdhQgGKnECo8ufyec3yr45JS6y5Ceof0oeoM=
X-Received: by 2002:a17:903:2490:b0:168:d4d0:54da with SMTP id
 p16-20020a170903249000b00168d4d054damr5626146plw.42.1656430176681; Tue, 28
 Jun 2022 08:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-5-jthoughton@google.com> <YroYaWVvNZJvtqsH@monkey>
In-Reply-To: <YroYaWVvNZJvtqsH@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 28 Jun 2022 08:29:25 -0700
Message-ID: <CADrL8HXoKUP3Fjb-R1-YL0JWohG23BtgiBTFdijK_LYPA8-0-g@mail.gmail.com>
Subject: Re: [RFC PATCH 04/26] hugetlb: make huge_pte_lockptr take an explicit
 shift argument.
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 27, 2022 at 1:52 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/24/22 17:36, James Houghton wrote:
> > This is needed to handle PTL locking with high-granularity mapping. We
> > won't always be using the PMD-level PTL even if we're using the 2M
> > hugepage hstate. It's possible that we're dealing with 4K PTEs, in which
> > case, we need to lock the PTL for the 4K PTE.
>
> I'm not really sure why this would be required.
> Why not use the PMD level lock for 4K PTEs?  Seems that would scale better
> with less contention than using the more coarse mm lock.

I should be using the PMD level lock for 4K PTEs, yeah. I'll work this
into the next version of the series. Thanks both.

>
> --
> Mike Kravetz
