Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FAA55A0A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiFXSYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiFXSYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:24:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D86273C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:24:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r20so4217338wra.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMtjxd+kU4zjtqehHCMGEMwxsWvYCZlLg8ElbJsoq8U=;
        b=KmtSJXqLyRevtoEQGzDUM2aBKsDqCwJAX5j7D4XR1WTQiwzc0OZCAd9DY5pkIoychu
         4qnxI17pkrg+DnCVl4S2pLlzfDNVMFrrFgDrhJd/yoKjWaupAXuSQ+Jt0X/lVm4key6W
         JMHah50YDZBmUqzN50zU8aPbtk1XnklFIWLDs4dR12xNy/fdcWu1Rh/Zc7zO1UAcRfg1
         UnTI0EiQ4WDsSZ9UrhmeN9nLNcfuuW3laXKl9izySlhv3xoqtryP3wYVj97DcwXEhxez
         IsCcw9HR6CMBWd+lUnEOylsLEt3sUV0gpA4I22lYQP4rulfQfdi+B4Z7PVTEh7NTof29
         h/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMtjxd+kU4zjtqehHCMGEMwxsWvYCZlLg8ElbJsoq8U=;
        b=gvRfF5gpojod0HRVuu1A94/LJA2M5BX1VYexR9i3vxC+lL5MuQyZo0Bu4TNyOKsxeg
         zXhKf8fS/5Q5bwswogjwHEbxBmypZuY35r28J0CloKipSkNpZRSv8QTf4729g6OoRBey
         KIFVoNPeDk8RpLEIeVUWViYnODdvbtbMgB8YQJdXRlvzKRDoSjHl+Tq3RwSHuV1CGPdN
         FY/QDmTeGCrZLp8/Lnst1qqBUZXwl7F2Sp40wuZiLGQ3WCsHqOO6fPq3C6WDMmlKLL+l
         PIWhR9ZZMm2FXCwroLDnMgyBqHT2A+g8vr68ckuidAZBHj8N6rS2DWjZ1F1B7L72vGNp
         YfOw==
X-Gm-Message-State: AJIora89JvqtvhKbtI8StdzuHQRCGoAk8q7A4N5TU1x6RTxHx9mguLlJ
        Wi7wsMUfIh2r/6+IIzdy1TMHF7BsWX0PH3TyOmvH3A==
X-Google-Smtp-Source: AGRyM1t5BMrWFqvlRbuJ/mzoK6du45Zjy/mrMmJbR/AjpP064yhDbpDPwRXunfi6WfShRbxEEUT6jaAFAaAvQ7xDjao=
X-Received: by 2002:a5d:4308:0:b0:219:e5a4:5729 with SMTP id
 h8-20020a5d4308000000b00219e5a45729mr478210wrq.210.1656095067686; Fri, 24 Jun
 2022 11:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
 <20220610194435.2268290-4-yosryahmed@google.com> <ee47c4af-aa4f-3ede-74b9-5d952df2fb1e@fb.com>
 <CA+khW7jU=Fqt49jxG8y5n2YtRu4_C1gFUW-PqZGY_Rt8PGrGEg@mail.gmail.com> <dc5aca8d-16c4-a1fd-a2f1-fd3008c10e02@fb.com>
In-Reply-To: <dc5aca8d-16c4-a1fd-a2f1-fd3008c10e02@fb.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Jun 2022 11:23:51 -0700
Message-ID: <CAJD7tkYX4OLnVZE5KM3J4cLSoU+gMuiSf4_ViYu_FJzq5xwOXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/8] bpf, iter: Fix the condition on p when
 calling stop.
To:     Yonghong Song <yhs@fb.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Jun 24, 2022 at 10:46 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/21/22 12:25 AM, Hao Luo wrote:
> > On Mon, Jun 20, 2022 at 11:48 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> On 6/10/22 12:44 PM, Yosry Ahmed wrote:
> >>> From: Hao Luo <haoluo@google.com>
> >>>
> >>> In bpf_seq_read, seq->op->next() could return an ERR and jump to
> >>> the label stop. However, the existing code in stop does not handle
> >>> the case when p (returned from next()) is an ERR. Adds the handling
> >>> of ERR of p by converting p into an error and jumping to done.
> >>>
> >>> Because all the current implementations do not have a case that
> >>> returns ERR from next(), so this patch doesn't have behavior changes
> >>> right now.
> >>>
> >>> Signed-off-by: Hao Luo <haoluo@google.com>
> >>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>
> >> Acked-by: Yonghong Song <yhs@fb.com>
> >
> > Yonghong, do you want to get this change in now, or you want to wait
> > for the whole patchset? This fix is straightforward and independent of
> > other parts. Yosry and I can rebase.
>
> Sorry for delay. Let me review other patches as well before your next
> version.

Thanks!

>
> BTW, I would be great if you just put the prerequisite patch

I am intending to do that in the next version if KP's patchset doesn't
land in bpf-next.

>
> https://lore.kernel.org/bpf/20220421140740.459558-5-benjamin.tissoires@redhat.com/
> as the first patch so at least BPF CI will be able to test
> your patch set. It looks like KP's bpf_getxattr patch set already did this.
>
> https://lore.kernel.org/bpf/20220624045636.3668195-2-kpsingh@kernel.org/T/#u
>
