Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988894CB4BF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbiCCCQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiCCCQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:16:03 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018591095
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:15:15 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id c4so1812196vkq.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 18:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdhuskQuosfzBeb8z+Fw+9uS9iR9qqjZkm3VJwDCg1o=;
        b=fyifej2r6yEl56R5HvkqsbKCxJQYs3JnwGY15Xz9Yg5jb5u4KHiFnxV74A7BjArKsi
         n+CL7ALafiR7YROr6a3DxuvZtTGr9JtxncoklQYbZi6KeHDXJHUxuOXv6et67gkrFE/z
         vNcIJjpc+iZEvm6Es8oGzg+MXqI6qJgb1XLwi1pzZQgx10b9ExJhVwj38dRUi5T8y53M
         MxuLimBtNYj5w+JfnyL9kpEPuT2BFaCwbEnimlXbh8BubzixXIrrJ2MI8r/14cavKxyp
         jY0XilCRm/PAjuCgIwcVGhzHucwrgs7eV56+QLr91cQC+tY2I+B+kaE7MReEe99TixCy
         A4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdhuskQuosfzBeb8z+Fw+9uS9iR9qqjZkm3VJwDCg1o=;
        b=TvXRSi8dSpmtGBnhe2kulBSZMzxcajRTNYj+aITacmRo3KRJfi+7YdfqNUU3FrlJ7/
         7Pk36BlyTEG52J316+H6i+IOloFd+QIYrxla/H4HQUYKR0QfkD+XSaB9fKuHBcqdliuL
         UDo8OPvFum1QBMBA8C9//V97ub9qWWrAnaoDRcoAZmuV+MxfwfEPoVUfTn9UuHOtdr1E
         8bMKWGSDFwakCm+g63OjnSRCa3xSZsRhxkxMUBA0ZfxnOedpfXPnWI5yqy8nl/jLQCO5
         Ec4iwtBGX/HuL4V5DjC7lkmI0naVX+damS+Odv5iYB1q8CXRwCG6rSP3BTfv/bwztvED
         /EYw==
X-Gm-Message-State: AOAM530M7IZwz4h5cBfdfpYMIWefq9JfHPge/UN2bNwW+50Dbwdumu+X
        +2fLsjY5vKUXEElrH9pDl+uwtMmWaNdumTZ3Yc1rCw==
X-Google-Smtp-Source: ABdhPJxxPJmUqV3N42adKjLUQWTJARjhYVZ1C1A4KeWxCTKz/K1bi7A7Qb8l8sGihbUQCrrlqH0Q9z+ocAsnCEpRYPk=
X-Received: by 2002:a05:6122:208c:b0:320:3628:10be with SMTP id
 i12-20020a056122208c00b00320362810bemr13545734vkd.14.1646273713966; Wed, 02
 Mar 2022 18:15:13 -0800 (PST)
MIME-Version: 1.0
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
In-Reply-To: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 2 Mar 2022 19:15:02 -0700
Message-ID: <CAOUHufbJnFNLmS+tKDhsi0jwyXupjNKbs2J_D_1Nqe3UhBOMFA@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm: delete __ClearPageWaiters()
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 6:56 PM Hugh Dickins <hughd@google.com> wrote:
>
> The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
> vmscan.c's free_unref_page_list() callers rely on that not to generate
> bad_page() alerts.  So __page_cache_release() and release_pages() (and
> the presumably copy-and-pasted put_zone_device_private_or_public_page())
> are redundant and misleading to make a special point of clearing it (as
> the "__" implies, it could only safely be used on the freeing path).
>
> Delete __ClearPageWaiters().  Remark on this in one of the "possible"
> comments in wake_up_page_bit(), and delete the superfluous comments.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> We've used this since 2018, and I see Yu Zhao posted similar in 2020:
> https://lore.kernel.org/linux-mm/20200818184704.3625199-3-yuzhao@google.com/
> I couldn't join in at that time, but think its reception was over-cautious.

Indeed.

Tested-by: Yu Zhao <yuzhao@google.com>
