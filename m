Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2919A5721A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiGLRUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiGLRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:20:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B5967C81
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:20:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d12so15053255lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibrUHnlGz87syZWBzvYZCl2iDjwrLt5IxsZ/+T6H5Kk=;
        b=LKapj/7eKcH3Ctl0xLFhsHrioyJ2DRfd8EH69UtRZl8yDlKgnJU/i5wG+H7SaVVYjF
         1/+fCuNEwfB8Df87JbtOiS1YHhVYLPvwSWtdiKFDJljv4fYaR8HScOgqK1fb1svFnAUu
         NqoEVjX2rZPj90rE+JjAt/7BvdepDYNW7bwldQVTvpr8M4JLpSAYt42iaX+61GtVIcTa
         3Od0RJSgItJlic/n5ypdpsuhC/CuT/hyexCfQGrSnw7dwoygyhRJBtA+QX9L2sZ4tG6N
         01Ii3o+98GrbVlEZxHHM5WeTLsFeE+BTNFhZjap7o9NT9FpV64jK595ilhgduNMscK1C
         UCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibrUHnlGz87syZWBzvYZCl2iDjwrLt5IxsZ/+T6H5Kk=;
        b=MZmmbmLpXGjhPEvtErPqf6VnsSiw5rIxQZphKXH/iHEyqDPneML3JRGai6ag6p6IEC
         lz3/oIJx3w+w9wQJlYiOJM8yo0Z8Of+6R+ocBVqsuxqzJQVvS+tdVstVedfLFh/B53vj
         82itykHu8uhR2VHARpe8itcUscIjo7Gkuzjo55HI5iu8Oz26aQZ0+rwI5KN7AhTUwVXe
         KTYRasgPD2eLHNfjiJYpfHdnZ3+m0GSqSzreFeII/ZsStqpRNYnzpF8uGd2x03tr0liL
         Jvhh5hA5i2Y73NpHROunkR1Jn8qa6oRLYbLzIU5QEEXLrY/Li1Ui7Nizd5ub7y/rOHqC
         gUhQ==
X-Gm-Message-State: AJIora+TumHdz5nXxLXs/fh/QOdzb2adHtyB/KnmFOCyUgZTWgGbZ4q0
        o0S/jpJsjg9TCbF1DoIeyvzPp4jg/3Uoo7Bia0b/uA==
X-Google-Smtp-Source: AGRyM1sAh9uywucDWtlWxMee+W8CJDTIEAdUt5aFrGoVFJdcm32kcNTvUU60L8KP6MWXbwXkjeM/a8fSk7y6Hqk3/jk=
X-Received: by 2002:a05:6512:1523:b0:489:db27:c171 with SMTP id
 bq35-20020a056512152300b00489db27c171mr8262355lfb.58.1657646410942; Tue, 12
 Jul 2022 10:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-20-jthoughton@google.com> <Ysy1EySRmjxl2TmQ@monkey>
In-Reply-To: <Ysy1EySRmjxl2TmQ@monkey>
From:   James Houghton <jthoughton@google.com>
Date:   Tue, 12 Jul 2022 10:19:59 -0700
Message-ID: <CADrL8HVimb9qx8fjhgFMfj2hWwD3+6_ZY7W=gHbf6as6qbiLYQ@mail.gmail.com>
Subject: Re: [RFC PATCH 19/26] hugetlb: add HGM support for copy_hugetlb_page_range
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

On Mon, Jul 11, 2022 at 4:41 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 06/24/22 17:36, James Houghton wrote:
> > This allows fork() to work with high-granularity mappings. The page
> > table structure is copied such that partially mapped regions will remain
> > partially mapped in the same way for the new process.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> >  mm/hugetlb.c | 74 +++++++++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 59 insertions(+), 15 deletions(-)
>
> FYI -
> With https://lore.kernel.org/linux-mm/20220621235620.291305-5-mike.kravetz@oracle.com/
> copy_hugetlb_page_range() should never be called for shared mappings.
> Since HGM only works on shared mappings, code in this patch will never
> be executed.
>
> I have a TODO to remove shared mapping support from copy_hugetlb_page_range.

Thanks Mike. If I understand things correctly, it seems like I don't
have to do anything to support fork() then; we just don't copy the
page table structure from the old VMA to the new one. That is, as
opposed to having the same bits of the old VMA being mapped in the new
one, the new VMA will have an empty page table. This would slightly
change how userfaultfd's behavior on the new VMA, but that seems fine
to me.

- James

> --
> Mike Kravetz
