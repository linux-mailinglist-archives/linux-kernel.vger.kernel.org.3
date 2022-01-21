Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC99495A43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348988AbiAUHCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbiAUHCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:02:49 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1477C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:02:48 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id a12so9766012iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVobGviDm1nm1GMLQvd/EYPCyCZ2DMF5uRlmstDHO0I=;
        b=GbJjOyNWKDBuoGbJ17LfQNorZPhqO49Ii9Zpx3oNZq1KscKpnGF8tzMS69aAfuzb7W
         xo5a94992eGe5N2oPV6ud7kSSXez3IX/LS98iilSw7E0EwuJ2x53MFklMFJDSQ4vsMHu
         2I2OFA1z1C5IADPDXj5XiN+H8J8AXykh6li60T/fDhw8IYZaP5mvFQVFGDC9+/+XClFx
         OcWKvKvI8ywljW9vIrl5bEDnA6zN2HuYY5joqPPr50ZhkOkca/AAMmin9+8m5Y0SHmBl
         9AdPidzH5w/c7kSibWbfFDqFWZF3DsKE14ZhMN7sTh6yti7fdBCbcjV9Z2RKedcc7lIf
         Z1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVobGviDm1nm1GMLQvd/EYPCyCZ2DMF5uRlmstDHO0I=;
        b=i3EVHNPIxZEyovpnd1jdS1C7oGlarBkea27gfXX29xiqQFMuVg8TsHvTpNDgUviCba
         TsW2W9H1E3YX9vssnfciPyAWvbSb59wIfJFSS2I2V+C4VIx65v1alFYg7ADVwV8B3BF5
         FcFpLuHbD8b7BUeVuV33VaC/H9xnvoQCHXs/MnzJ09gQO9kPx/LR5KZgnWBsmT82kiiQ
         ygjfCgJL+oXLTSSuSQC1fnJTmlSJ4GcMlAR2nsVfnWwFK+eNS0zGG9xCJTGKlaWhboNK
         B2yRqyhI00B3zUf7DEhS6AJj8Q/OY9TvUJJ5B0LgL6f31cdLuDV2oN5neCTTfHBRt2lr
         GrCw==
X-Gm-Message-State: AOAM533aRTp3bmOd+jF+XecfEj1oY4ejHHJvKDB2pkJRmtjw0G0CxJQC
        nDLdoW+qqnSKnF1FsBp4EJg3k+DhipdStMFskjk=
X-Google-Smtp-Source: ABdhPJx5tjDJw2o9AqfxiHpuePMfQ4+XrlHN7ioUNoql/VyVGUezZc/YkO6IQdRIa894Nj7slhFkATnFLYByfLQ7vnM=
X-Received: by 2002:a02:ca4c:: with SMTP id i12mr1206692jal.40.1642748568390;
 Thu, 20 Jan 2022 23:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20220120131024.502877-1-alexs@kernel.org> <20220120131024.502877-2-alexs@kernel.org>
 <YeljTuECoPfKn6VW@casper.infradead.org>
In-Reply-To: <YeljTuECoPfKn6VW@casper.infradead.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 21 Jan 2022 15:02:12 +0800
Message-ID: <CAJy-AmnmRVZ2ezSt1bws4TVKEw-VKubUXbc4SP8wU0-SQprhcA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: remove page_is_file_lru function
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yu Zhao <yuzhao@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 9:28 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 20, 2022 at 09:10:20PM +0800, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > This function could be full replaced by folio_is_file_lru, so no reason
> > to keep a duplicate function.
>
> This is not a helpful way to do this kind of replacement.
>
> Instead of choosing a function to remove and doing a blind replacement,
> choose a call site and convert the whole calling function to use folios.
> Once you've removed all callers, you can remove the wrapper function.
>
> Also, a number of changes here will conflict with patches I've already
> posted.  Try doing change_pte_range() in mprotect.c to get a feel for
> how to convert a function entirely to folios.

Hi Willy,

Thanks for your comments!

The patchset did the thing as you required "convert the whole calling
function to use folios. then remove the wrapper function" on yesterday's
Linus and next tree, that included your patchset "Page cache/iomap for 5.17".

Is the conflicting patch "Enabling large folios for 5.17" or others? Sorry
for can't check everyone, your patches are many. If just the former, I see
you mentioned: "I'd be uncomfortable seeing it merged before 5.18".
Would you point out which of your patches was interfered or blocked?

And yes, replacing page functions in change_pte_range is a bit harder,
but it seems it has no much relation with this trival patchset.

Thanks
Alex
