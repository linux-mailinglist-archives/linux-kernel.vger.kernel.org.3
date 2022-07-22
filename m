Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F263357E601
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236365AbiGVRvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiGVRv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:51:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D4252B3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:50:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n185so3213225wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUTDStGbNNw1f/BTAauOJuxuHrm/bJ5Do+y2MoJFquA=;
        b=Ew6/AHGD9JmeBb3RRlzM2HRqhGhbZX1gLPxyfbOLnHm7krtjtVsgu1gPvDAnbCexP/
         hHUFF9gXmeyog/wnl+8F4z52le24cuf6m+6dpZamYs16B2PvRP54pBayNDl3lgQQB/kp
         hKycIP0bVMhP9givw1kievFqR4ER331GbkItxSRvtJZwOe7StGhXfkCEYqi0AMsv4XnX
         qtb9R1lAO9qDKvGZuqDxMKuolAevLHQIV1Pzi1ckspKF3KunAYZNdGiY8rUIPNP/Nl4D
         Slkv9aCN48TELd8pjAVcxtPY+gs5PC1ewbVxR1H/Qmrq/zhPqHAFBUsMneVTDNhdIFqU
         JVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUTDStGbNNw1f/BTAauOJuxuHrm/bJ5Do+y2MoJFquA=;
        b=y7oRnomVsbJdjNAYNkkZ3M/9Uzv6tPmBviEAzkn7zkMKwLX/jFKbeRCu1+NPiiYW+9
         dCtdySlJIMwr1ZfB/rYwCjTsb9cZN69x5JNW3d6uCnDXwlIWqImaBlsjiL/5n18zdgAq
         Z5e4bycs4vzGYTNiD+R910Tjm7C8qoX5NGJbZ3m5dZdrmLVWZxoe2VeGSX4phLcTPUAD
         XBqLa5vx14pRM+n1sy4GA4aumoejx3Tzjg4h3UPVYS9q43IAK4lduODg+IMaze+l4MOr
         hH9TaqyZD9yqylbr3iW4j0F4+ia9x4Bz4Ba/284jg85gzzPyWhSDDlEqJJWeSz8GS+SB
         uyig==
X-Gm-Message-State: AJIora+Jcch5aE8lmDR4ukjs921Vvta2oHsdIG1AojTvKb5tEXeayYE9
        WGq6gDP/xeNtHa1GkRIo/Hixcn2suOtPwHrQAk1R0A==
X-Google-Smtp-Source: AGRyM1uv7rjlNfppX7jjFHmrlh5E7CeWSii4QxzSGedjuScbMyllP4joA/Xm1z+rpE12bv6p/SH4PuPDii3pHiR4HQQ=
X-Received: by 2002:a7b:ce8f:0:b0:3a3:150c:d8ff with SMTP id
 q15-20020a7bce8f000000b003a3150cd8ffmr13164181wmj.152.1658512228992; Fri, 22
 Jul 2022 10:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220722021313.3150035-1-yosryahmed@google.com>
 <20220722021313.3150035-2-yosryahmed@google.com> <CAADnVQ+c7uuVXukguvy9x2HjM9K8rj6LOa_QJ_n+MVB-bOx3uQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+c7uuVXukguvy9x2HjM9K8rj6LOa_QJ_n+MVB-bOx3uQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 22 Jul 2022 10:49:52 -0700
Message-ID: <CAJD7tkaSx9Oc3WC1C3BObRRXgsj6gvG6hRj9oL-P_BeWXvjS-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/8] btf: Add a new kfunc set which allows to
 mark a function to be sleepable
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>
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

On Fri, Jul 22, 2022 at 9:20 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 21, 2022 at 7:13 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > This allows to declare a kfunc as sleepable and prevents its use in
> > a non sleepable program.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  include/linux/btf.h |  2 ++
> >  kernel/bpf/btf.c    | 13 +++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > index 1bfed7fa0428..6e7517573d9e 100644
> > --- a/include/linux/btf.h
> > +++ b/include/linux/btf.h
> > @@ -18,6 +18,7 @@ enum btf_kfunc_type {
> >         BTF_KFUNC_TYPE_RELEASE,
> >         BTF_KFUNC_TYPE_RET_NULL,
> >         BTF_KFUNC_TYPE_KPTR_ACQUIRE,
> > +       BTF_KFUNC_TYPE_SLEEPABLE,
> >         BTF_KFUNC_TYPE_MAX,
> >  };
>
> This patch needs refactoring using the new BTF_ID_FLAGS scheme.
> When you do that please update the Documentation/bpf/kfuncs.rst as well.
>
> Thanks!

Sent v5 rebased on top of the new kfunc flags infrastructure, and
added documentation for sleepable kfuncs.
