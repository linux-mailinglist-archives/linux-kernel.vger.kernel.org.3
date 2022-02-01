Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C144B4A6421
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiBASlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiBASlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:41:10 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E8C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:41:09 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p27so35801425lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KMB5E3V1bz4skn5GoAxZyIA1phJ+tSxcRJR8WInLy0=;
        b=K6RfLu0tss7sWY+3Cb5jC7Cb3noc2STewpCcv7FQBgZBWz1Uf4DsDtQ/sE39JrgFWB
         wuXuiEKHuT1xTy97aiqjEqsOntTXvtpq9EiGZeh1r3Fai4F92dl+yWEN97l1UgndGliB
         m+TpO7+4JaH48lcla/mrWON4/cuz8eUuC1OI5aG0NAud4PwF8cGsl/PrY+nRidqkw/df
         dQUL1f3yw1TFvj3IJ5Z0ODCtVX2uqas+5mUNjma6M8JgWUhUHHRwl3CpGiCajPVARJfJ
         I7lDH6AVVnKkmRtYOaEWSvM5f+xWS1+J5q6pZaEo0C68uReznkP33Lubme34OvNjhchc
         stgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KMB5E3V1bz4skn5GoAxZyIA1phJ+tSxcRJR8WInLy0=;
        b=z/ZX8E9oBkrUzYwWc8ec12kOIJ0zthvIOZHU+hgxaMY2+JAsbSxRpewpdBnDGf1fzP
         jj2Fnyh6HyZWAtc+JiG68ms/7mXzYModyR0kWEXSwjNFRDdwFW1by5CKRp7W0oiwA7iU
         wJw/Xav9FHrtjrJj2sK2mYdVov75MfAvrJymV3dklJabfYJfIzGZldXD61MD2g0U01oG
         PPlFyUv0VZlfiMWOV+M+G1flYJKLeOHvEs6LLHTdb6O9d40KB/Q7iQnnjO65M8Z7imI8
         7qhLT0ddh9tRl9tAvmWX9BF4gQl4uPbpOsx5uWKaDYyEOc635nDkdt7+V+CiKQhmAZNR
         R0Gw==
X-Gm-Message-State: AOAM533gDpn381KmB4AKIWi7UN9WDVcCOw+8Bg45MIv0NFLG9uZ/oEgA
        jgjGyH/u02X9uFYMc6iHo9qtwvUZPpLvCdqXXZWNTg==
X-Google-Smtp-Source: ABdhPJw5kEWBR7jvbAbi8qdyZ/EThlOC/31Qwy3Sx6BUvs5huAKz/oJ7l3Jgbjhn7WjJhbUZyVm9w708H5d9G9futQ0=
X-Received: by 2002:a05:6512:3ca8:: with SMTP id h40mr19976020lfv.213.1643740867743;
 Tue, 01 Feb 2022 10:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20220131153740.2396974-1-willy@infradead.org> <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org> <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org> <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> <87o83rn3ny.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <87o83rn3ny.fsf_-_@email.froward.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 1 Feb 2022 19:40:41 +0100
Message-ID: <CAG48ez1uo41dshk0VoCXyY6B9BUCCAzq3O+_42BX+yV2_iDhgw@mail.gmail.com>
Subject: Re: [PATCH 4/5] coredump/elf: Pass coredump_params into fill_note_info
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 7:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Instead of individually passing cprm->siginfo and cprm->regs
> into fill_note_info pass all of struct coredump_params.
>
> This is preparation to allow fill_files_note to use the existing
> vma snapshot.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Jann Horn <jannh@google.com>
