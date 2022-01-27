Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64EF49EB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbiA0Tjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbiA0Tja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:39:30 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FF1C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:39:30 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ah7so8243082ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFb8NFrlSpLTas5OqZUZmins6ncV7W5Rmo5+3meVR3g=;
        b=Y1M+Bf1wwslphNC9H9x0VpVivB/SCcil9aYfoAVt13yg5Ovnt7H3lIEMuriqtFhlpv
         ekrnPLi/jLCjKpYhcBiKQBI9U8Q2idhM5Y2jnY5rVDWUw1D6PturF4Qp5HxF07TKCc1Z
         hVPZC4maBNEUCfeGSOEebJPeP6XLJ/2fdS8qKWy0JeBADfPYrbrLx2OhCFPxksMVJcQc
         pfFFyD8UgurIoPS2TtPatrHLxpKUCG+aG2YLdtHhjbazAXLDlRPMwy5COPM6VtOcVKhi
         0rl/2OvACuxdK0d4eD5XYawWhm3ABq00YjIyLHYSPCUVqI1G0PbJJKlCvEeYhPk9CmHS
         MKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFb8NFrlSpLTas5OqZUZmins6ncV7W5Rmo5+3meVR3g=;
        b=uWeOikz6qygq0OnYKiSXNAVqbwbarNj00YOuvJ5Ik2v/MujixmIAEWbrp79lNijXu/
         4OEQoAS1vEEFPDnMaYnMW0MVpN7qrhV5eag6MQW10Xbhe+YusVjHpC1w6H6kuiiGixSA
         j+FRhrxqBJcMTKs83gSW8PaOpFzn3oQeGag/FPYNj1UttDL+0jOexvegl5CAgO0OCd+k
         2g1RcbgvH1dlQQSrAXY/+CUT4Ow5AREN+J/VUT3ueawIKpfwdNBG6H0o2Dojt7muoiTH
         nkVcY1QyCuq2rjhgoJo1gUZ+UiBbKXrPdgtwYVvPUzoBPDAFYn2BPVbXfaUK4nQRSk06
         jBgw==
X-Gm-Message-State: AOAM530unqjZIPIMuj6ZfokeMWp1IFKsA70Srt5oH3fbuba59KnfDhCB
        K2e1Klj1RsdEqTW1/fbT2Vuh5mIJ/NTPNUidxuVEiA==
X-Google-Smtp-Source: ABdhPJwuhg8zPBVbIllXAibAi/ysZVpdojXGj11dmGEm1WuhDT5JouZwm0vT8xovbBnIKrNXGk5qaynKQV2BHOOjEus=
X-Received: by 2002:a17:906:dc92:: with SMTP id cs18mr4099175ejc.590.1643312369033;
 Thu, 27 Jan 2022 11:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20220126183429.1840447-1-pasha.tatashin@soleen.com>
 <20220126183429.1840447-2-pasha.tatashin@soleen.com> <YfGZ/0hhkqVeX04p@casper.infradead.org>
 <CA+CK2bDHkOQbTrK=GbsGbojAj_6gaAX_8w3cBCd_LWqXt--yZA@mail.gmail.com> <b7f580cb-84f7-5c78-5f68-7ab8f67b0811@suse.cz>
In-Reply-To: <b7f580cb-84f7-5c78-5f68-7ab8f67b0811@suse.cz>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 27 Jan 2022 14:38:52 -0500
Message-ID: <CA+CK2bBAXZSX6E0boEoZ=Cake94v9q4LuWzQ-mj0QbWTsQcjOw@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] mm: add overflow and underflow checks for page->_refcount
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is not only about chasing a bug. This also about preventing
> > memory corruption and information leaking that are caused by ref_count
> > bugs from happening.
>
> So you mean it like a security hardening feature, not just debugging? To me
> it's dubious to put security hardening under CONFIG_DEBUG_VM. I think it's
> just Fedora that uses DEBUG_VM in general production kernels?

In our (Google) internal kernel, I added another macro:
PAGE_REF_BUG(cond, page) to replace VM_BUG_ON_PAGE() in page_ref.h.
The new macro keeps the asserts always enabled.  I was thinking of
adding something like this to the upstream kernel as well, however, I
am worried about performance implications of having extra conditions
in these routines, so I think we would need yet another config which
decouples DEBUG_VM and some security crucial VM asserts. However, to
reduce controversial discussions, I decided not to do this as part of
this series, and perhaps do it as a follow-up work.

Pasha
