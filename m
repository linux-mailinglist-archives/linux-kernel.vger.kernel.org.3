Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9A84A8253
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349587AbiBCKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349205AbiBCKa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:30:29 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5DEC061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 02:30:29 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z7so3241208ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fq71Zy1N9jBs3AfhHIITF18JMFrsGvlMgJHozhmwSWg=;
        b=TOwrCUIKwnpw3MEY5F5d2dw/YLQlij2jV8hEjeKjupC3W8Y01aSXN99/GXn1A6cdVu
         8V5jQ+osk+l8D2ArVLUz2mlEKJVDIp8F+ffF/qTW+sJMYmAJcRixFXeOrvfyupx2ZReV
         wORIPuvt/gMDECvR9UXB1K7iAdZJWi2V2qBQ6veU2nXzE4WwFXpTvmaXjZFNHSDD+xXl
         qRGBqvSBdPlAvnJVmVv4AtRp/17Izw4NEtfIRkJcZ6FAEmJdlx3aHG1Ynk5yrVuCrKBX
         czERQqKMUM9965NTV8XEv/J6u/SJfaNeo4aaoC1C4h6hRC4KxyZELGVSPQPcVIAd4bfb
         0Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fq71Zy1N9jBs3AfhHIITF18JMFrsGvlMgJHozhmwSWg=;
        b=cGYfxF53wgudYXFFu2PzA+J+Iwcz9+FxA3+FBOGm0yKkAWUGvTXVNVeDTOKO8q90ex
         cRa9VZodazZa+A/YiO94FMS0MsZYwux/dKCjbYA6M1w2yx0rFHa+aRmgas3EtTyy65G2
         nV2Ub8RhiN7pec9vlg7CXHjKd4R1W7v2Lkj0uZDFaj5Fsnwsmr7q2/q8US5aMXBAKYcA
         u3CtMvr7owiLyvxRasbPlwrc8MoKP+Fqj9sfI71znmk7CDtWPi61+sqlvyR2J2/KorXt
         N1qcH1lq+R3wt6vNDY7exbFyPKH4EvYlQhWlI/fkllU+fz7M7S0+0UmjWXvQWPJFf95r
         Tr7g==
X-Gm-Message-State: AOAM530I3sPnrjDwY0l2yj8RDOlCKc8+6JX7zkFKUbo4m2+oExh0+UGP
        Lc3amE85636ZUMnJnns5BY4eAx8wSZez7H0fAbc=
X-Google-Smtp-Source: ABdhPJzL16V++jZmbzUnKrXRb04xl6tmQyhPuNZ/871XgyeLYHwl/VJAKniZ3lXMFtIYLXJQgyj9twxqcmOu9OsacMU=
X-Received: by 2002:a2e:a5c3:: with SMTP id n3mr14004615ljp.212.1643884227393;
 Thu, 03 Feb 2022 02:30:27 -0800 (PST)
MIME-Version: 1.0
From:   Nikita Popov <npv1310@gmail.com>
Date:   Thu, 3 Feb 2022 15:30:16 +0500
Message-ID: <CA+cA0PB92khCo7dNAyw-zUmhKJHg-D2aQyT=HmLHhyVvd_Cd5g@mail.gmail.com>
Subject: A logical error in arch/x86/mm/init.c
To:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

It appears that there is a logical error in arch/x86/mm/init.c in the
master branch. Although it is unlikely to occur in practice. I
discovered it while studying source code in that file.

Here is the description:
1) The function 'init_range_memory_mapping' is responsible for direct
mapping of the normal memory range. Before proceeding to mapping of a
valid subrange containing usable RAM the function checks that it is
safe to allocate pages from PGT_BUF subarea of BRK area (the 'safe'
means we we are not mapping the page belonging to PGT_BUF subarea
which can incur MMU issues if that page is allocated as a page
directory). As a result the global flag 'can_use_brk_pgt' reflects
whether the current subrange overlaps with the free area from PGT_BUF.
The 'true' value means no overlapping.
2) The function 'alloc_low_pages' is used during page directories
construction. If it happens that we exhausted PGT_BUF completely (such
condition usually causes can_use_brk_pgt == true), there is a chance
that we use common BRK area on memblock allocation failure (memblock
allocator is restricted to use already mapped pages only). If the
'can_use_brk_pgt' flag is set we allocate a page from the common BRK
area. But the BRK area is not protected with the similar check meaning
that in theory we can allocate a page serving as page directory for
the very same page. The flag 'can_use_brk_pgt' protects only the
PGT_BUF subarea of the BRK area. Not the whole BRK area.

In my opinion one of the simplest fixes here is to completely remove
the following lines:
    if (!ret && can_use_brk_pgt)
            ret = __pa(extend_brk(PAGE_SIZE * num, PAGE_SIZE));

I look forward to seeing your comments on this.
Kind regards.

Nikita Popov
Senior C Developer
