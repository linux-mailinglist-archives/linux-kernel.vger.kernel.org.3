Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE0048A592
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346585AbiAKCYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346579AbiAKCYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:24:34 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46320C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:24:34 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id d7so10400988ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 18:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSQyDPVUrDTpPa0aeIkb88gZSvWQCxb+kxHI+54cFz0=;
        b=XP3yQrg8fDZpSWUZkuN/qfg9052nmszm/0Ms512ggngyobd7ttIvqnXRyrfbVQTWaf
         /zGqSCW6zCzW84h4JMDO76dAuixk4yxZqFqgmYbuFIecfy++oe16hNrJXFTIYI3h86rj
         7J7KqCLyp1LCIst+ibhYsv6zCd9IeG9Hlhapn40NZpRLtRAxXaJ3m9P3fifzHCfrX0+Z
         rYtTnG1Ldv3rswgr8S0TJTBmeTDEr5CdzTxhHwZdq0Y2dYKVSTgZVBR3bPP/PoKSsE6/
         h2T8vQYugkLWcuH4JEaXMIvSedPawB/waoT7n5CVkTpXpLBJCdawHZLGfukgzi3IKixh
         f8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSQyDPVUrDTpPa0aeIkb88gZSvWQCxb+kxHI+54cFz0=;
        b=6cX2FQs0C0uNP+0d2kN5uaWx2a/HPIo/N4WMBP2ypUOP0Py/y2OLdXmqW0zEls06q7
         sh+EmGeLayRbpgTAWFsd7yazNFEfAEqZYg7D/4fbDo8HrzUlRzngFMlrm4W+PH9xmZWG
         WI/sCQmpwL9564mg4ip2hg8Be1D5qobILWrGtd9FBu14D++0OyajvHG2JcSQOmJBBJsd
         1txAY973gqhpPkgHN+0gT0QkJEEu7wuoVOPC7B07GMhVYcAV9/vF85l9RkHjcmgHMMCg
         +jsjHB9vsxaoG63IMqXeAgHA9Cyobfijnsq0JGo3nww5Oym8Ll41q6IqaohkFn2S5GMR
         mZzw==
X-Gm-Message-State: AOAM533eIonA4zMR0GGk3D1G/NDJ9Cfi3Tk1g/Pos+eO58+pdWeUIItO
        uPbXYRoYrFqUxaNQ7ntgpm2qSD4o7fChjCJ1Ucm9ig==
X-Google-Smtp-Source: ABdhPJx11qad2Hf5OTZtbqHBCOaZGNeOpypqrGIcE0GpoUrVWOkLl0m+W/NSQYpHxRry1mTn362lwgm3GWkaLMWghgc=
X-Received: by 2002:a25:abcb:: with SMTP id v69mr3517256ybi.317.1641867873454;
 Mon, 10 Jan 2022 18:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20220111010302.8864-1-richard.weiyang@gmail.com>
In-Reply-To: <20220111010302.8864-1-richard.weiyang@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 11 Jan 2022 10:23:57 +0800
Message-ID: <CAMZfGtVR90mUTL_JgKwO_4ek_nk8CbZGPchn3GxvwtN9q+dxbg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/memcg: use NUMA_NO_NODE to indicate allocation
 from unspecified node
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:03 AM Wei Yang <richard.weiyang@gmail.com> wrote:
>
> Instead of use "-1", let's use NUMA_NO_NODE for consistency.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
