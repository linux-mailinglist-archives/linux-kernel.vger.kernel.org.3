Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC0249B651
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbiAYOea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiAYObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:31:09 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26209C061773
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:26:44 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g14so62104148ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl6G1I8d7amrdxFUYe5VdZlTB2njtWsoXMFyPet+gSM=;
        b=AGW72ryFUV7dVhvx7fItSQe6ZZHiMtTV5Da/c6LbG0unTjI5NleXJ6OdX+dcMAo3XP
         Egpc2Ui/iAx/cdbFGKKIggUeC7r+FbsAeu6d9h+vTDvb25dE8nqSP7ccD+/WTQdWj0+s
         9aMo3rC131UNWFHlxKUd5aZ62wkqORyZpgNvACVVaLR4Mumpf7Qm438DHuTrBqP9jpCm
         /Ft8pdlHTjs9Qq/e2gNrC2s7q43TXwOr/RCgSdSyWjsqC6Ezc2J/L1jjSNPDh7F1RRgB
         kCh2H1qKG+GhLqK22qGSxvtGlAjTFmh+zZb8yyte+M1KeTy4OO71L38j3uGr51G9usH7
         sqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl6G1I8d7amrdxFUYe5VdZlTB2njtWsoXMFyPet+gSM=;
        b=wlYIwAn7U8VXPflFGqsJs538RN6yLOtUeOXZHN1VVeYl5pfa3og/z9j7PYMi+xUay2
         VZ3tbaHNogbxIBUwh2t9rpw0O+NzaPw8BnPw+CEgdc+dPi4Xm6705v3/h3D0iOHKKGwo
         FdDD1lLQvBOcl36SHBb1yDpe9hablBcbhud6g+mQKhNhLUxV7unCTeA5qkLHxKTPBRXf
         GM3XVF5pc2166eteP6KIhWJHO+c8/7SgW4nlHrex0neCP/qY3YZVA4WLg0Mv/5iNyx8F
         sfwtTNo6Sazr/13skD8tP7vlVcztZOq97jLIO+renzqzqT4gKg7SwTc+kv6Q6+aYFc2D
         yHIQ==
X-Gm-Message-State: AOAM531bduWYYvAVZHANIQPj7OGlJXbi1ul0JQtsBHZ5WTH2OTqa9KuW
        WHXoFmk/JXGKSYV5FvkfSA9yNxmXYhVjetWZK7NUOaAwAiXS1w==
X-Google-Smtp-Source: ABdhPJyFvo0J2ACdgGip0xhojHQiB4Fhvy8CYFKQFGItnOFG8EzOF30f7xwY1X3oEdihcoOJrEv5uvnaovhwTDuhnyE=
X-Received: by 2002:a25:af4b:: with SMTP id c11mr29461798ybj.49.1643120803495;
 Tue, 25 Jan 2022 06:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20220125132221.2220-1-linmiaohe@huawei.com>
In-Reply-To: <20220125132221.2220-1-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 25 Jan 2022 22:26:07 +0800
Message-ID: <CAMZfGtUJ08hL8RW0VCxx6KMmf0eUvMaO1hu_Mhhhu90HQQ31rQ@mail.gmail.com>
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 9:29 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
> feature"), these functions are called via balloon_aops callbacks. They're
> not called directly outside this file. So make them static and clean up
> the relevant code.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
