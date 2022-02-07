Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36FA4AC878
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiBGSXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbiBGSUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:20:47 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2956C0401D9
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:20:46 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id c189so11636084qkg.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 10:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=I2DL4qfJF0wopDmaBBJJTApXAPXSGaVHG9z0BUOLoOE=;
        b=YbIKyftG6woux+8E1fgQAiMqIm0TvfqEDBedwgGD1Uwetzo9ic30PxX8iS6T8ocVPu
         /UN9gvBNac/kfAGnW2Tdm1B84NCCvsL2yNqm0iKD7yhZdUvAx7V+EyVe1LXZ/vLFoQtk
         TaKlKfsCnhc6OiCPjwIUEYKxBBv30KKyQwyDvfgyevj9sv5kK+0PVHXK0KLpjEmR60cc
         YZiIaiCQ3F8+DqssVfipX1f0QMEyYkKMT3KH2B6EgA0FcClk7mgRuXt1469TcnJ+ukDx
         WHlIOl4TclX3+0tnMZx8IOih5iFplVmQzdt0xVHT21WzmS3GEePsQiEy5dnfuS7kcCus
         InAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=I2DL4qfJF0wopDmaBBJJTApXAPXSGaVHG9z0BUOLoOE=;
        b=rfFnp8MygOhG468wHkiNOHYSE/XMbxlAU5lyzV+tW8BVpFMGWOXMDhy3TMsB/ObstF
         FDLR/i2RzHV5Dzzpfj/mbmlmhWAroFAD/oTpG1kKfDN4v6omyvDiOcEbdBxLfs8oDQEF
         t3xhCe7VHhHYzBwXdSm/Pg2ry49aO/BWbWPVE3+b113JGzLYJoxypuKXtCWPSJ0UD7bG
         N6ZD3Jt4mpK7FO3LHW7GHpEDBOPZSF5QSOD+HPdmyFNghnoyF1eu+c4kjChZeHPi93AX
         8v1M/wlTMEwGmCimEh+fG0uAvr+AwTKw0nHNBieFQS0vDA286YocKydlkBqsk0QavnH2
         d+FQ==
X-Gm-Message-State: AOAM533+YxlRYEtsAtilgAFXfWsqgLbqFgLPm6T3Tl3QqNt62RjgkjVv
        li0kOphcl18ZH4wGkNjalaR/cQ==
X-Google-Smtp-Source: ABdhPJyD9GfKfmksb7UZOqPKAtYdNuGTXOOd/DmqknB0tstTGMTuqgIX2/xe3DLPraRPnj8G/jUSKA==
X-Received: by 2002:a05:620a:4614:: with SMTP id br20mr615237qkb.172.1644258045571;
        Mon, 07 Feb 2022 10:20:45 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i20sm6133901qtx.44.2022.02.07.10.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:20:44 -0800 (PST)
Date:   Mon, 7 Feb 2022 10:20:23 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/13] mm/munlock: rework of mlock+munlock page
 handling
In-Reply-To: <YgA/0TfVOpQkMuQT@casper.infradead.org>
Message-ID: <a685f0a6-137b-6d3b-d812-5eac37c927b@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <YgA/0TfVOpQkMuQT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sun, 6 Feb 2022, Matthew Wilcox wrote:
> On Sun, Feb 06, 2022 at 01:27:41PM -0800, Hugh Dickins wrote:
> > Here it is based on 5.17-rc2, applies also to -rc3, almost cleanly to
> > mmotm 2022-02-03-21-58 (needs two easy fixups in mm/huge_memory.c); but
> > likely to conflict (I hope not fundamentally) with several concurrent
> > large patchsets.
> 
> Most of this patchset hasn't arrived here yet, but I would be
> _delighted_ to rebase the folio conversion on top of this.  What
> convoluted code it is!  I am so glad you've cleaned this up; I was
> dreading doing the rest of the mlock file.

That's a very generous offer: thank you.  I'd been looking at it
the other way round, afraid that it would be getting in your way:
but now think you're right, that the cleanup there will help your
work.

I had found mm/mlock.c unexpectedly difficult to deal with when
doing shmem huge pages, and IIRC Kirill had the same experience.

Hugh
