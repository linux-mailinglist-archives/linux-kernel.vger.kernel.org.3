Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2550E9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 22:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiDYUFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 16:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiDYUFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 16:05:07 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E40DB0A56
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:02:02 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j16so15495538vsv.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipbl5TQBmzxQLxByP8eeV1/87M/skoc9cO2qR76GObw=;
        b=r51c8MsCuZts96hTOgBMB9l5ucaeMldWh0LftO8XLuhjmUopI4bpnF5LiNu2SXBRBo
         VckwfD5s2hSbp6UtRhiU/9SBS6YZAmDCB6Oo0PnVzZZK6YZeLJJaHE/gEBGqPd+W+y51
         wx1PvO1PHDvkxkCRx7s9ZnyA1PwrMMm+FUfM0MNg4yCJRgVTnplTn9gi9l0+xBK0Sy9d
         QQSL98y6XSPs0Scpr6w3higdumcI/Or4dpZnW3vF5G2mXonlwj/bzZtm7n45GcsRnR7R
         /zCZ1qGBV74dyzOnOrxMnv2Ne4MdpRIbzJw8/S0dUXCMrc8oHBcLIMOGMPorgdSCeOs5
         36Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipbl5TQBmzxQLxByP8eeV1/87M/skoc9cO2qR76GObw=;
        b=0qwCC/saF7QTmTAPyfg0fKQelzbjHg4+M3tS45cTcXD5ke2Jn5NIF2n+5AoomGDBp7
         trWhjHMy26te4zfXS4Y7XFpLBnYyrVaqtxoS/dzo8tIuoaLGEUIPv46Y8FnmRFi/dqVc
         SNyjVSgzAcDtAQNhoJk2CvLtOfzl657yoBmkn4GdqT3P9z9oCvK7KgWffadG7caHu2DZ
         +FuU9oIBvnL3eD/5brmnK2y/yhdyHnYG37sWcJn+Hqvn7eKpZGfVDvbUHxAJ3w5JmfM3
         iQYcH0XEhlZ/6gjcnUYGKeE6+OpeTMIU61T+DbVmsdiNVkw7lWGtLU8sTN+1OW9GJmmF
         +APA==
X-Gm-Message-State: AOAM533VMHIA02jpmoMIENxnzUcfQzuyzv2EEAgMpuLdFMJ9eTIYK/Pf
        pGsApSK8m6GvCMBdrvMbeVCyYr6C5GGg4P+h8TkAkL/KlY4=
X-Google-Smtp-Source: ABdhPJxEKYhd/X+UL6zAs/4j1oJDJoOQK9AIqhshal0SMNW9n9f1uwef7k2qNy7h1iv2IWrg0stUDnsM5QP2GgckCGc=
X-Received: by 2002:a05:6102:158a:b0:32a:56ea:3fba with SMTP id
 g10-20020a056102158a00b0032a56ea3fbamr5534217vsv.84.1650916921320; Mon, 25
 Apr 2022 13:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220416010259.4gbz5hgvm2lgr3sj@revolver> <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver> <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
 <20220419155055.qf52xpcftqb3r5nj@revolver> <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
 <20220419231748.omnhkl43vl5ep2j5@revolver> <CAOUHufaR3Pbv_PgGpzfmzzCHLLwBkHT8G-RcDfe1bo0zESekPw@mail.gmail.com>
 <20220420134336.bny7wza3ez2ldjsd@revolver> <CAOUHufZZbF-e6LF=xgig-Q8zuTSq_hvgPc-rMOwhyPdsD5=p0w@mail.gmail.com>
 <20220425195852.qd3dzzjpitwaocx7@revolver>
In-Reply-To: <20220425195852.qd3dzzjpitwaocx7@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 25 Apr 2022 14:01:24 -0600
Message-ID: <CAOUHufbyJc1rM+pNyU9s1zpbxJSKnzGSAD8Or5WYt_d4fjGoPw@mail.gmail.com>
Subject: Re: [PATCH v7 00/70] Introducing the Maple Tree
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 1:59 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220425 14:06]:
> > On Wed, Apr 20, 2022 at 7:43 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > * Yu Zhao <yuzhao@google.com> [220419 19:23]:
> > > > On Tue, Apr 19, 2022 at 5:18 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > >
> > > > > * Yu Zhao <yuzhao@google.com> [220419 17:59]:
> > > > > > On Tue, Apr 19, 2022 at 9:51 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > > > >
> > > > > > > * Yu Zhao <yuzhao@google.com> [220416 15:30]:
> > > > > > > > On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > > > > > >
> > > > > > > >
> > > > > > > > <snipped>
> > > > > > > >
> > > > > > > > > How did you hit this issue?  Just on boot?
> > > > > > > >
> > > > > > > > I was hoping this is known to you or you have something I can verify for you.
> > > > > > >
> > > > > > >
> > > > > > > Thanks, yes.  I believe that both crashes are the same root cause.  The
> > > > > > > cause is that I was not cleaning up after the kmem bulk allocation
> > > > > > > failure on my side.  Please test with this patch.
> > > > > >
> > > > > > Thanks. I applied this patch and hit a LOCKDEP and then a BUG_ON:
> > > > > >
> > > > > >   lib/maple_tree.c:847 suspicious rcu_dereference_protected() usage!
> > > > > >   Call Trace:
> > > > > >    <TASK>
> > > > > >    dump_stack_lvl+0x6c/0x9a
> > > > > >    dump_stack+0x10/0x12
> > > > > >    lockdep_rcu_suspicious+0x12c/0x140
> > > > > >    __mt_destroy+0x96/0xd0
> > > > > >    exit_mmap+0x2a0/0x360
> > > > > >    __mmput+0x34/0x100
> > > > > >    mmput+0x2f/0x40
> > > > > >    free_bprm+0x64/0xe0
> > > > > >    kernel_execve+0x129/0x330
> > > > > >    call_usermodehelper_exec_async+0xd8/0x130
> > > > > >    ? proc_cap_handler+0x210/0x210
> > > > > >    ret_from_fork+0x1f/0x30
> > > > > >    </TASK>
> > > > >
> > > > > Thanks - I'm not sure how this got through, but this should fix it.
> > > > >
> > > > > This should be added to 4236a642ad185 to avoid the LOCKDEP issue.
> > > > >
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -3163,9 +3163,9 @@ void exit_mmap(struct mm_struct *mm)
> > > > >
> > > > >         BUG_ON(count != mm->map_count);
> > > > >
> > > > > -       mmap_write_unlock(mm);
> > > > >         trace_exit_mmap(mm);
> > > > >         __mt_destroy(&mm->mm_mt);
> > > > > +       mmap_write_unlock(mm);
> > > > >         vm_unacct_memory(nr_accounted);
> > > > >  }
> > > >
> > > > Will try this.
> > >
> > >
> > > Andrew,
> > >
> > > Please add this fix to the commit 4236a642ad185 "mm: start tracking VMAs
> > > with maple tree"
> > >
> > > I've attached the patch for your convenience.
> >
> > Hi Liam,
> >
> > I assume you are still looking at the BUG_ON problem. I'll restart my
> > testing once you have something for me to try.
> >
> > Thanks.
>
> No, The above fix stopped the suspicious rcu dereference.  I've found
> another issue in the mlock() code which I've also fixed.. but I needed
> to change my allocations from within the immap rwsem lock as it triggers
> a potential lockdep issue on high memory usage - lockdep complains about
> fs-reclaim lock.  I've a patch set that works but I'm working through
> making it bisectable.  I think the easiest thing is to integrate these
> fixes and the others sent to Andrew into a v8.  I hope to have this done
> by the end of the day tomorrow.

No worries. Just wanted to make sure I didn't miss anything from you.
