Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE72B4B4221
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbiBNGw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:52:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbiBNGwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:52:24 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2620517C8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:52:17 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id j12so14700780qtr.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 22:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=EopoKbEevrqLLp9ZzPCZTcvF6J4LEYpvvNmknpmGcQ4=;
        b=BeUxMuEePib8qdIFCiAfvIKXi1J/Vzn+EWXyESq2TdUZwquqPO0vhwBhMJ8MjK7miy
         PkBPvyTAJAH90Vv86IleeL0YQwXS0y1cP56wVvt+ULsjqz4BcEPkakWJgCmVMcTsZv10
         /4TzCZ6XClW/x0QAo9KPIydGL0HFjwXyxGPEXpLuJUOWCod5hl6iaSuthCcjk2zEpk3d
         svJLwQ/ldGIs6CLugsHgGp5oE+Fnp3rxvNHT7NuM3teT04YpRHg2q87F3qmH/bPhmGn9
         1Yr7y0h9xR5cHvzCUBX+JQ0du4Hb5BKQ8h/wnBWBJsbdgAvpc6z6ifnPMWgqyPV2K6Bs
         PPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=EopoKbEevrqLLp9ZzPCZTcvF6J4LEYpvvNmknpmGcQ4=;
        b=6zOh9SNIL7LFFiiN5LI+JXurfAkOz9vb8M2x8ulWhUsoBPySjWjft5bM2kNKe/Xln1
         ZGpLKUWrmlkTlQHp1QoblQRyxA5F42Q6+r8Mj66FOMu1nA5/D+W/4mJATBi310IOuxf+
         uIkfJod2kBaYqEAEEaphlM+BL0UTh8DazXbnXtOAjcEvmQmVW5jaBdEhW/oA5Eln8wHB
         +PanV2ToEZg0MC56xVy7kE3KKA/au1Jebb/2eR2ciO+UWFZ0wE9bKvwjjqtKDeZS267x
         AvNFWrkHz9ANrCyGoMDD3kT3DUhGaKmnmzhcv41/vSECEnyhF66puTdDVKj1il4wbd/W
         fzuQ==
X-Gm-Message-State: AOAM531xGj0LeryWMd6bTU4y2LpOfp9NwgLOQw8NfGL+aNFAasqMRlKJ
        vRxn6kn/QheLAlnwsB7JISQIlA==
X-Google-Smtp-Source: ABdhPJzCwHU4Op2qWLkszS0o2FCgyTE9JNDodLZ/xEayw3EgbBpqJvIQkE4GhbjDewxPDCglnhaWjg==
X-Received: by 2002:a05:622a:15ce:: with SMTP id d14mr8711515qty.330.1644821536764;
        Sun, 13 Feb 2022 22:52:16 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bl34sm12969452qkb.15.2022.02.13.22.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 22:52:15 -0800 (PST)
Date:   Sun, 13 Feb 2022 22:52:13 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 01/13] mm/munlock: delete page_mlock() and all its
 works
In-Reply-To: <957e2ea6-d01e-256f-51a0-d927a93b50a5@suse.cz>
Message-ID: <eeee75ac-c888-6458-3438-24fe39adccae@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <5ed1f01-3e7e-7e26-cc1-2b7a574e2147@google.com> <4a5bc989-e59a-d421-faf4-8156f700ec99@suse.cz> <ed2c4952-f3e-688d-40c1-53afebe5c7cb@google.com> <957e2ea6-d01e-256f-51a0-d927a93b50a5@suse.cz>
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

On Thu, 10 Feb 2022, Vlastimil Babka wrote:
> On 2/9/22 23:28, Hugh Dickins wrote:
> > 
> > Though taking this apart and putting it back together brings its own
> > dangers.  That second suggestion probably won't fly very well, with
> > 06/13 using mlock_count only while on the unevictable.  I'm not sure
> > how much rethinking the bisection possibility deserves.
> 
> Right, if it's impractical to change for a potential and hopefully unlikely
> bad bisection luck, just a note at the end of each patch's changelog
> mentioning what temporarily doesn't work, should be enough.

I'm adding a paragraph on that to the end of this 01/13's changelog.
If you or akpm think it's better  duplicated in 02, 03, 04, 05, 06
then I think it will be easiest if Andrew edits it into them, rather
than me updating them one by one.

> > As to VM_LOCKED: yes, you're right, at this stage of the series the
> > munlock really ought to be clearing VM_LOCKED (even while it doesn't
> > go on to do anything about the pages), as it claims in the comment above.
> > I removed this line at a later stage (07/13), when changing it to
> > mlock_vma_pages_range() serving both mlock and munlock according to
> > whether VM_LOCKED is provided - and mistakenly folded back that deletion
> > to this patch.  End result the same, but better to restore that maskout
> > in this patch, as you suggest.
> 
> Great, thanks. That restores any effect on VM_LOCKONFAULT in any case as well.

Yes, it turned out to be a mistake in my rebasing the series, the original
had the VM_LOCKED_CLEAR_MASK masking still there (up until the interface
changes in 07/13).  Thanks for spotting that.

Vlastimil, many thanks for your valiant effort reviewing this series:
it's not at all easy, and I much appreciate the time you've put into it.

I'm now going to send out v2 updates to 01, 04, 07, 10, 11 (only),
still based on 5.17-rc2, but incorporating your and others' suggestions.

Hugh
