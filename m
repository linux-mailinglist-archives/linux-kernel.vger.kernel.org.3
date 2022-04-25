Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5150E7C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244229AbiDYSJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiDYSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:09:32 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782F38BD7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:06:28 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id 63so5942380uaw.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsCWtGvQdpehXpOnJzf3Xy4LkzxOmS8c7itH/1kQMSU=;
        b=KeTmEFAL7NujVcG7aypNbHt9mUPTHmIapKOtNOb1rSbp7sY7D18ulNsQ+OWs4CBHpP
         Ta1EjNmapbeR/qBgcEZhfW1J8aIDhrlx75HHgVSxpg4UZ1i2VHQY0gXr5+R35AUpG3Fr
         RO0CoBQ5rz8l/z8SecS/fDj+s4LPDDsCU7M4B35wKjeq8y7+/R+zMG1+AnlV4jrJO3sv
         QVZlhIAAH+IAZMIbEL9ZlKkYZVRy9zJjJltJE7Eq9SQt0m4l9phmmfi2cnB2fxMBEtrF
         Qoet435VR3xYvNO3eIoYzJ9CYgpb295PmP7ONqd3SZiWt+nzL7ULdZxl0wibOY3y3a9N
         gXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsCWtGvQdpehXpOnJzf3Xy4LkzxOmS8c7itH/1kQMSU=;
        b=MqQZ+yu4//ldfhZ/nvS+80CwUiUnXyI8IllBZVsRiXbunpB6bLZ7xWxelGXnf1liKg
         yRQ1dYqWnTnZhfuBB55Il10RnrlURO1cMG86uzNYKny9D97fmmSoZvP6/PeuS25M3/hn
         dM61lCNXDzmAWauPIVKWzBwmC4KGE9Go80Mcq0Ll2AY7G4C9XZVLf1HEBmgakPzd8dXe
         +IaFxoer9788GRj15PGEzzfplLHJLsyn1D8+E40cNbfPIcIic6qyeJ9guuaIP+wjqj1f
         flqjIOs/cgrQE94tcin6uWuw43GEtZljfFshpoOo7yuDJEfQgtz4R1J0N/m/8SMgI1h8
         EpQg==
X-Gm-Message-State: AOAM5326t6sVnZ2uyw8jLJuwRVmU4lG9XDJ3Zyss/9qK+TUup7MAD9Uj
        stLJQHvPycn3QKYgUwfL9NSLINuC6jilulzkDAPkVQ==
X-Google-Smtp-Source: ABdhPJyEjWKt6MQz612hu23UA90+bvp40aD7BMW+buy6PMhx+mCqvc6VvEtk/VNzTsIK/CoeIzcC8MCZfSDNmWZjURY=
X-Received: by 2002:ab0:77d5:0:b0:352:42d7:88c2 with SMTP id
 y21-20020ab077d5000000b0035242d788c2mr5531417uar.1.1650909987129; Mon, 25 Apr
 2022 11:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220414121911.8bb89fc3681b13af1566d79c@linux-foundation.org>
 <YlkaiUopM5HKWEdX@google.com> <20220416010259.4gbz5hgvm2lgr3sj@revolver>
 <CAOUHufZ8zPnpamkkpKK6KcSLTF91Eiba+S9VTX-ivhFrPQ_Cpw@mail.gmail.com>
 <20220416151923.ig5zavuptjsufm3d@revolver> <CAOUHufZewjQyMy1pHKxRkY82J5STPbUSJor7Q2aJgrkpZvU6bw@mail.gmail.com>
 <20220419155055.qf52xpcftqb3r5nj@revolver> <CAOUHufbX_aq+aHf-EVKFLN_jw6hXJ5vtKpG0jskD6uXVKB406w@mail.gmail.com>
 <20220419231748.omnhkl43vl5ep2j5@revolver> <CAOUHufaR3Pbv_PgGpzfmzzCHLLwBkHT8G-RcDfe1bo0zESekPw@mail.gmail.com>
 <20220420134336.bny7wza3ez2ldjsd@revolver>
In-Reply-To: <20220420134336.bny7wza3ez2ldjsd@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 25 Apr 2022 12:05:51 -0600
Message-ID: <CAOUHufZZbF-e6LF=xgig-Q8zuTSq_hvgPc-rMOwhyPdsD5=p0w@mail.gmail.com>
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

On Wed, Apr 20, 2022 at 7:43 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220419 19:23]:
> > On Tue, Apr 19, 2022 at 5:18 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > * Yu Zhao <yuzhao@google.com> [220419 17:59]:
> > > > On Tue, Apr 19, 2022 at 9:51 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > >
> > > > > * Yu Zhao <yuzhao@google.com> [220416 15:30]:
> > > > > > On Sat, Apr 16, 2022 at 9:19 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > > > >
> > > > > >
> > > > > > <snipped>
> > > > > >
> > > > > > > How did you hit this issue?  Just on boot?
> > > > > >
> > > > > > I was hoping this is known to you or you have something I can verify for you.
> > > > >
> > > > >
> > > > > Thanks, yes.  I believe that both crashes are the same root cause.  The
> > > > > cause is that I was not cleaning up after the kmem bulk allocation
> > > > > failure on my side.  Please test with this patch.
> > > >
> > > > Thanks. I applied this patch and hit a LOCKDEP and then a BUG_ON:
> > > >
> > > >   lib/maple_tree.c:847 suspicious rcu_dereference_protected() usage!
> > > >   Call Trace:
> > > >    <TASK>
> > > >    dump_stack_lvl+0x6c/0x9a
> > > >    dump_stack+0x10/0x12
> > > >    lockdep_rcu_suspicious+0x12c/0x140
> > > >    __mt_destroy+0x96/0xd0
> > > >    exit_mmap+0x2a0/0x360
> > > >    __mmput+0x34/0x100
> > > >    mmput+0x2f/0x40
> > > >    free_bprm+0x64/0xe0
> > > >    kernel_execve+0x129/0x330
> > > >    call_usermodehelper_exec_async+0xd8/0x130
> > > >    ? proc_cap_handler+0x210/0x210
> > > >    ret_from_fork+0x1f/0x30
> > > >    </TASK>
> > >
> > > Thanks - I'm not sure how this got through, but this should fix it.
> > >
> > > This should be added to 4236a642ad185 to avoid the LOCKDEP issue.
> > >
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3163,9 +3163,9 @@ void exit_mmap(struct mm_struct *mm)
> > >
> > >         BUG_ON(count != mm->map_count);
> > >
> > > -       mmap_write_unlock(mm);
> > >         trace_exit_mmap(mm);
> > >         __mt_destroy(&mm->mm_mt);
> > > +       mmap_write_unlock(mm);
> > >         vm_unacct_memory(nr_accounted);
> > >  }
> >
> > Will try this.
>
>
> Andrew,
>
> Please add this fix to the commit 4236a642ad185 "mm: start tracking VMAs
> with maple tree"
>
> I've attached the patch for your convenience.

Hi Liam,

I assume you are still looking at the BUG_ON problem. I'll restart my
testing once you have something for me to try.

Thanks.
