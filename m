Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277B24D235C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbiCHVdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350498AbiCHVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:33:34 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25273A19E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:32:34 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id jx8so35994qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=YOXQDRCIfx4IjSjbZnhb2Qm6e7avo35Rozd5Ovb9UuU=;
        b=NoBZj+BoD+zd71XjiH9cllPdclP0sfXsbHf7r1D4BvJDBNwDI0a/sBSL+5vDPbAh7H
         P7cOhmDzcFMJEGXIgN1TyoI7iPCBa/Z4lO624dihHnRo1DxTSWTpZ6f2dspqZoLqUyEk
         ZXn88TzOQJd1Bp2ZLDV0TkHHPy1k9/jqm21rehJ8fXk1S8Ic5qqHbFQvgJCzrZxEWp13
         qMC9Ml13fL8fdHLCpwA0j64jjXEy4AnPKWPwrFjIcLSTshY9MvNitHgYECpzdegD/6xR
         0ArGZYFsJDf5z1XnWpkquNXwVej4RrPiGF/ZbiK7/k2w9hljUCpDBjKe+ok5h0jFPIHS
         X0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=YOXQDRCIfx4IjSjbZnhb2Qm6e7avo35Rozd5Ovb9UuU=;
        b=WqE3CHzxXD45wDKCbg3KQtveTpLnHGIWLbxuEtZhP4Jqkus62FSjdTkJYcTB4WQMQQ
         yxrd/XVnxugzQzcaWT3NxtuAim4OZ5bw6t4RWf0Qof8NyVnRVjcxwwpCHZ7KHjkYBhF2
         5GuKnwopFEa3IspDUDzjZUOHNkMDSKXMa9ysh+sedPkxh9AdgPJUv9tP7Z+ZP9fn2wbn
         TKmY7QdqvjdHqZySc+Xvj9zeDhpuIyb0a8wwLIFdHrkP4rU/IYHb6uyEpsLAa3bXxtCy
         Pfhz9mP7/RnKg6jyh9/MU0Y/JizCkg0LVOErBWEj7VWr7jUrYHDPmLh+4Q317NWSaxJ4
         XKdA==
X-Gm-Message-State: AOAM530OTO7DKepjzsv9tlZMCzv1LpeNoIKNt9jXqO1TpTfenfQiIxNX
        rpoIXMrOcA0r9ZEeUDx8Hiuozw==
X-Google-Smtp-Source: ABdhPJzl0aw6y1OP+W+9Ro/QjkGXpfNxhZvFkO4SJY8YmozH4S0Iqlsyp3KV2dzqvdSK3w1UuzMc9g==
X-Received: by 2002:ad4:5f49:0:b0:435:a88e:ae0e with SMTP id p9-20020ad45f49000000b00435a88eae0emr5221716qvg.98.1646775152887;
        Tue, 08 Mar 2022 13:32:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h17-20020ac85e11000000b002ddd5fab777sm77992qtx.41.2022.03.08.13.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 13:32:32 -0800 (PST)
Date:   Tue, 8 Mar 2022 13:32:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Liam Howlett <liam.howlett@oracle.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH mmotm] mempolicy: mbind_range() set_policy() after
 vma_merge()
In-Reply-To: <20220308160552.d3dlcaclkqnlkzzj@revolver>
Message-ID: <6036627b-6110-cc58-ca1-a6f736553dd@google.com>
References: <319e4db9-64ae-4bca-92f0-ade85d342ff@google.com> <20220304184927.vkq6ewn6uqtcesma@revolver> <20220304190531.6giqbnnaka4xhovx@revolver> <6038ebc2-bc88-497d-a3f3-5936726fb023@google.com> <20220305020021.qmwg5dkham4lyz6v@revolver>
 <29eac73-4f94-1688-3834-8bd6687a18@google.com> <20220308160552.d3dlcaclkqnlkzzj@revolver>
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

On Tue, 8 Mar 2022, Liam Howlett wrote:
> * Hugh Dickins <hughd@google.com> [220304 21:29]:
> > On Sat, 5 Mar 2022, Liam Howlett wrote:
> > > * Hugh Dickins <hughd@google.com> [220304 17:48]:
> > > > On Fri, 4 Mar 2022, Liam Howlett wrote:
> > > > > * Liam R. Howlett <Liam.Howlett@Oracle.com> [220304 13:49]:
> > > > > > * Hugh Dickins <hughd@google.com> [220303 23:36]:
> > > > > 
> > > > > I just thought of something after my initial email
> > > > > 
> > > > > How does the ->set_policy() requirement on tmpfs play out for the
> > > > > mpol_equal() check earlier in that for loop?
> > > > 
> > > > It took me a while to page all this back in (and remind myself of
> > > > what is case 8) to answer that question!
> > > > 
> > > > The answer is that the mpol_equal() check at the top of the loop is on
> > > > an existing, unmodified vma; so it's right to assume that any necessary
> > > > set_policy() has already been done.
> > > > 
> > > > Whereas the mpol_equal() check being removed in this patch, is being
> > > > done on a vma which may have just been extended to cover a greater range:
> > > > so although the relevant set_policy() may have already been done on a part
> > > > of its range, there is now another part which needs the policy applied.
> > > 
> > > Doesn't the policy get checked during vma_merge()?  Specifically the
> > > mpol_equal(policy, vma_policy(next)) check?
> > 
> > Sorry, I'm reduced to the unhelpful reply of "Yes. So?"
> > 
> > If vma_merge() finds that vma's new_pol allows it to be merged with prev,
> > that still requires mbind_range() (or its call to vma_replace_policy())
> > to set_policy() on prev (now assigned to vma), to apply that new_pol to
> > the extension of prev - vma_merge() would have checked mpol_equal(),
> > but would not have done the set_policy().
> 
> I must be missing something.  If mpol_equal() isn't sufficient to ensure
> we don't need to set_policy(), then why are the other vma_merge() cases
> okay - such as madvise_update_vma() and mlock_fixup()?  Won't the mem
> policy change in the same way in these cases?

mlock provides a good example to compare.

Mlocking pages is the business of mlock(), and mlock_fixup() needs to
attend to mm->locked_vm, and calling something to mark as PageMlocked
those pages already in the area now covered by mlock.  But it doesn't
need to worry about set_policy(), that's not its business, and is
unaffected by mlock changes (though merging of vmas needs mpol_equal()
to check that policy is the same, and merging and splitting of vmas
need to maintain the refcount of the shared policy if any).

Whereas NUMA mempolicy is the business of mbind(), and mbind_range()
needs to attend to vma->vm_policy, and if it's a mapping of something
supporting a shared set_policy(), call that to establish the new range
on the object mapped.  But it doesn't need to worry about mm->locked_vm
or whether pages are Mlocked, that's not its business, and is unaffected
by mbind changes (though merging of vmas needs to check VM_LOCKED among
other flags to check that they are the same before it can merge).

Does that help?

Hugh
