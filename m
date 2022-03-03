Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71AD64CC3AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiCCR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiCCR0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:26:48 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F919E02C
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:26:01 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id n185so4433420qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=HpUtMT59V1Dnqp2zw86tWtEA5X/jod13ModO/+p9Deo=;
        b=jjawInHuhXlrYKywMUQ6u85Mb3wkFgN3bCEJteCcFDNQ5uE5FGq0UjCO0L1TGWL8ab
         V9GlBewr1A8gUJa1B1B05NANwOqSfQcI30W4w/k6lpJTCutjJWRKkinSmDR5wt1FO4yi
         iVpikjy4C9Gwl9rif/sa+Pg8X+ItbNh2d/Pk0NS8o0natuNtomeGNQWH+DrPzSsDr5Pg
         iZRJXppysKoSPlVicQOh4xbzWB+Ajp+xq9/Bwvq7XTAk7elO+CFXC7XTH2tVtRCn7jJE
         P37MCW0SSa1kjzlO7mU0/alFefExPamQZxOwDxq/qd2Ulgs6Bip+x63MjdphEphkcdTS
         vZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HpUtMT59V1Dnqp2zw86tWtEA5X/jod13ModO/+p9Deo=;
        b=s+bM1gdxjkUz4vLj6CqzMAD0gw+uqcQKmfjbVurvHKrq4dTllZX+PxZDj76IUd8O+P
         GnZ9muoh3HeQ2oI/QJofSPwkjLYRI9XStSCs0bxd4CDViMRtD6ViQkoTt36xKxyw1tNS
         GHIsH1rcvE528E55xtHtovy6To2Pn0K7nZGFWOHnY6BSJ9yA/dguM4DGIGYDbVYTlhX3
         vMydzrqe3+2a4+DvvCAKygu0kT46Tsjf5Fh3KKiFBU+hSHCjy29ZbyRYlNY2AZ0t8MPJ
         gQL0nmDO/We3HCcGL3Osv1muSDNdASjivtWstKofyRkndVnPuGQuIS21p9p8lkc54am9
         1sdQ==
X-Gm-Message-State: AOAM531sH4ksLt16lu7U/qCcelHHJdKFifpR4Y6Tw3qLHDJQEUZFStqE
        TIHfIqe4jtfAsAKp0YSPvjTD9g==
X-Google-Smtp-Source: ABdhPJzqju+8pmjZ5eHUzN8w+ZiB6sEbK9gZCNHSaTxhq8obDD2oNU51ROCDYUqOHHK+KP/bGnvf2w==
X-Received: by 2002:a05:620a:1a08:b0:648:ac5c:37eb with SMTP id bk8-20020a05620a1a0800b00648ac5c37ebmr163288qkb.49.1646328360132;
        Thu, 03 Mar 2022 09:26:00 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d77-20020ae9ef50000000b00649555ce936sm1331249qkg.83.2022.03.03.09.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:25:59 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:25:47 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm/munlock: mlock_vma_folio() check against
 VM_SPECIAL
In-Reply-To: <YiDPeJ+7DVWpsuRv@casper.infradead.org>
Message-ID: <39f9e61b-c66c-a741-5118-997a48dd440@google.com>
References: <9b95d366-1719-f8e2-a5a3-429f9e808288@google.com> <YiDPeJ+7DVWpsuRv@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Thu, 3 Mar 2022, Matthew Wilcox wrote:
> On Wed, Mar 02, 2022 at 05:35:30PM -0800, Hugh Dickins wrote:
> > Although mmap_region() and mlock_fixup() take care that VM_LOCKED
> > is never left set on a VM_SPECIAL vma, there is an interval while
> > file->f_op->mmap() is using vm_insert_page(s), when VM_LOCKED may
> > still be set while VM_SPECIAL bits are added: so mlock_vma_folio()
> > should ignore VM_LOCKED while any VM_SPECIAL bits are set.
> > 
> > This showed up as a "Bad page" still mlocked, when vfree()ing pages
> > which had been vm_inserted by remap_vmalloc_range_partial(): while
> > release_pages() and __page_cache_release(), and so put_page(), catch
> > pages still mlocked when freeing (and clear_page_mlock() caught them
> > when unmapping), the vfree() path is unprepared for them: fix it?
> > but these pages should not have been mlocked in the first place.
> > 
> > I assume that an mlockall(MCL_FUTURE) had been done in the past; or
> > maybe the user got to specify MAP_LOCKED on a vmalloc'ing driver mmap.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > ---
> > Diffed against top of next-20220301 or mmotm 2022-02-28-14-45.
> > This patch really belongs as a fix to the mm/munlock series in
> > Matthew's tree, so he might like to take it in there (but the patch
> > here is the foliated version, so easiest to place it after foliation).
> 
> It looks like it fixes "mm/munlock: mlock_pte_range() when mlocking or
> munlocking", so I'll fold it into that patch?

No and yes.

That's great if you're prepared to move it back before the foliation.
I think that just involves editing every "folio" to "page", including
in the title - I very nearly sent it out with mlock_vma_page() in title.

But I would prefer it to remain as a separate fix at the end of the
mm/munlock series: this case is too unusual, and only a "Bad page",
to mess with bisection prospects; and it's addressing an entirely
different issue from what the "mlock_pte_range()..." is dealing with.
Each of them needs its own explanation.

So I would prefer it as a separate fix about "page"s, on top of the
mm/munlock series, and you then adjust your foliation commit accordingly.

Thank you: this is what I really wanted, but was afraid to ask of you
(and of course, other fixes may turn out to be required, too late to
adjust across the page<->folio barrier in this way: so it's nice to
be able to do it this way, but rather beyond the call of duty).

Hugh
