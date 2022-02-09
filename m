Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B474C4AE9A7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbiBIF6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:58:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbiBIF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:56:15 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B71DDF8E3FE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:56:10 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id j12so1038684qtr.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=TemFlLgBDEYY7gwxbdT3SMjGLcyouI+aT91cRh3aYjs=;
        b=eJOEUl/RaPPJhE3ECQsa8IaWF3KlczvfWymRoJerO6UIUY78T5++YGNrFMIM4Tg46h
         y1ArWBqRJeL3vPBvhGQWXp0joQHcx8YbdD6jXb5K8IXL0roKS4cVwSyaIZohDfxiysEz
         PzkSAXArZpec3lDvS5YV0pmodhHgrEafqoUKBx4OLM/gO18QhiKy7UGtLMkm+ZrgngUn
         uhyvsd8yWzWPMOZjLnbqZ6jJXrNm2S3b2ZKepCeCtVlwOzBa6xzrIbpE74XXS87m80OY
         taGIDkE7VDvVdgBB/Vq7nPkZgt+j6IluHfRJCBuk0zFOm+dY0MvsFSV4nZX76j+nUlEu
         EMOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=TemFlLgBDEYY7gwxbdT3SMjGLcyouI+aT91cRh3aYjs=;
        b=YY/gwd5NRAxm8qcKYoNthpuBAYR7VIin7FEKoENdXMO2mtYgfxZE8bOY9Vxq94j8ro
         YBvGFKckKT+nEBJWdgZMWO9TLLtfKbCWcdUmkqN+ZLqCAvZ8t1TRPRYR+ODKjF716/ON
         EYVh4xIZCZVLbN5xiUVt28ofTo0WjrXq2V0vhnuth8XNDm4aayzcO5zQtt13h1pxpZeb
         vskxLRtjN1siLuQZ8fXUzzvZK8+S9Ax+CNXc/ZmaqH2JROC6EAohkVA9JShgHOJCOCqz
         Sp0yDKRX70+Nt2JBvzkLFUkwrKC3YKtZfFblzyocdGastVGHe3UZBYrASYuiD9odDqae
         RDeQ==
X-Gm-Message-State: AOAM532K4776F+DmC/so4mJC6edESEIZCLJeIEw5ECKROMbJM1enJMIK
        viqxDkiQAb+/trxQ89FWFNUEubGt0tHSRQ==
X-Google-Smtp-Source: ABdhPJzvgcql41ZChT2cwRMaRiAAxOn1gdNvn+hAxNI5wjeszjbRU2S5pOs7N89PTHZYgNWgXDnNzQ==
X-Received: by 2002:ac8:5a08:: with SMTP id n8mr359640qta.332.1644386160813;
        Tue, 08 Feb 2022 21:56:00 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 22sm8843627qtw.75.2022.02.08.21.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:55:59 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:55:48 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     CGEL <cgel.zte@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
In-Reply-To: <62026b89.1c69fb81.b9102.7042@mx.google.com>
Message-ID: <11c8fcd3-58fc-77f4-addb-18d3a52b51a7@google.com>
References: <20220116152150.859520-1-yang.yang29@zte.com.cn> <YeVdvVVBvrXH5U0L@cmpxchg.org> <61e7ac25.1c69fb81.e8938.bc67@mx.google.com> <YegK7+oKFG8EPRp9@cmpxchg.org> <61ea820f.1c69fb81.e79d5.09c9@mx.google.com> <YfNG5KAog6fI0kYu@cmpxchg.org>
 <61f35591.1c69fb81.48dad.3244@mx.google.com> <72532675-d898-9f30-1ba4-318fbd61786@google.com> <62026b89.1c69fb81.b9102.7042@mx.google.com>
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

On Tue, 8 Feb 2022, CGEL wrote:
> On Mon, Feb 07, 2022 at 07:22:22PM -0800, Hugh Dickins wrote:
> > On Fri, 28 Jan 2022, CGEL wrote:
> > > On Thu, Jan 27, 2022 at 08:29:08PM -0500, Johannes Weiner wrote:
> > > > On Fri, Jan 21, 2022 at 09:51:08AM +0000, CGEL wrote:
> > > > >  Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> > > > > > On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > > > > > > I did a test, when we use zram, it takes longer time for ksm copying than
> > > > > > > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > > > > > > average takes 55639ns. So I think this patch is reasonable.
> > > > > > 
> > > > > > Ok, that sounds reasonable to me as well. Please add the
> > > > > > PageWorkingset() check and resubmit the patch. Thanks!
> > > > > I am a litte confused about adding PageWorkingset(), since I
> > > > > think ksm_might_need_to_copy() memstall is like swap_readpage()
> > > > > memstall and swap_readpage() doesn't add PageWorkingset().
> > > > 
> > > > That's actually a bug! It should do that.
> > > I recently found that too. Please CC to me your new patch, thanks!
> > > And I will send V2 of this patch "psi: Treat ksm swapping in copy
> > > as memstall" with PageWorkingset().
> > 
> > I'm entirely PSI-ignorant, and reluctant to disagree with Johannes,
> > but I don't see how your patch to ksm_might_need_to_copy() could be
> > correct - maybe the "swapping" in your subject is confusing.
> > 
> > There is no PSI enter and exit around the page allocation and copying
> > in wp_page_copy(), so why in the analogous ksm_might_need_to_copy()?
> >
> I think it's two questions, first why PSI didn't treat wp_page_copy() as
> memstall, second why should PSI treat ksm_might_need_to_copy() as memstall.
> 
> The first question is unrelated with this patch. I think the reason is PSI
> focous on memory contending(see Documentation/accounting/psi.rst), and
> wp_page_copy() is not caused by memory contending. Actually wp_page_copy()
> will still be called if memory is not contending.

Agreed.

> 
> For the second question, ksm_might_need_to_copy() is called only becaused
> of swapping, and swap is caused by memory contending, so PSI better treat
> it as memstall.

But there I'm not at all convinced.

 * psi_memstall_enter - mark the beginning of a memory stall section
 * @flags: flags to handle nested sections
 *
 * Marks the calling task as being stalled due to a lack of memory,
 * such as waiting for a refault or performing reclaim.

psi_memstall_enter() will have been called if do_swap_page() had to
read back from swap or wait on page lock; and psi_memstall_enter()
will be called if ksm_might_need_to_copy()'s alloc_page_vma() or
mem_cgroup_charge() goes into page reclaim.  Being stalled due to
a lack of memory is fully covered there.

Your argument is that copy_user_highpage() is a significant overhead
(but not a memstall), and it might have been avoided if there was
no KSM or no swapping - though doing the copy there often(?) saves
doing the wp_page_copy() when do_swap_page() goes on to do_wp_page()
(and that one you're not asking to count).

I can understand you wanting to keep track of page copying overhead;
and I've grown uneasy recently about the way CONFIG_KSM=y can add a
ksm_might_need_to_copy() overhead for pages which never went near KSM;
but I still don't see how psi_memstall is appropriate here.

Hugh
