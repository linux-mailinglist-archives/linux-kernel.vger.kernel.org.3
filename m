Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A074EFC3A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344744AbiDAVk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:40:55 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB27A8AE4A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:39:05 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id k11so2887083ilv.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HQybvipiwCmhDTMI61RMqSUH6YQ4cHyMt2incAt7F0M=;
        b=d7qruhihQmBK9XRXFDTh/OTFwOPUebBbBRONhopS4Kl3YS6Bi5NMrVsCYDEno0qUE2
         PHL/op/2RZN53g+F8PqMf+RGpmtoRceNQ2hJQe23qD8n2Z4tyFOh09yDWN3y7im+ON6H
         FNml4umZ981FkpwzHWjVwer70e8OrdQSzD5wysr24DFRYLuYiltD712vAQUAUj9KU72T
         K1WC4mgeJ7ck53xxur7kZFSCvvaEcDUFNfFtSXMonZAqw0muNFIglXH5OFJJ+4Hpe5uI
         3QccBy7LUbIaoHsAaeYwwpcyr9H8zr5KqFxkFNYMXVUztyCEVKP9JS40ggeGGkCpyAwk
         uMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HQybvipiwCmhDTMI61RMqSUH6YQ4cHyMt2incAt7F0M=;
        b=tR6Mv+3XBrimwXjV8r7gDg38r8OE+cK0WKOiXkiy8egjwKWRU3ilOWDDKfb4i8Xby1
         1RJEDDvWV4yk7RST7DXJy+SbI/YaMi7sblGt34LFe+2UC+nad5HCEtPjuEcZDHVmSdoM
         CvehnNAL+lZLUsZ3dNjzTrrW7ZzdmzfSk84dvyfNSBeZYxkpmC+nkAeQRR1mMavcrax9
         u7ek5W2czi9yJC2GnW/YYyIXi2FC01yx3GanXHO+acV5ekbiI3HYvCn15SuS72CneE/+
         UKfoiTGcaHAtY/0n9OUtL+N7Ge8dSSPmFBCegY8NagyAO9KBBUkcTAduoW6Y8dHlQDWw
         J6/w==
X-Gm-Message-State: AOAM530cXxI91Kt8Ke6saMVd1Ml6FdE96WtRf5ecKvoiL8JbNNUmcBy/
        e0PfWrEsTV5oNw8Cv/bv6y6pu1bwxpWBiq+Nw9QYOw==
X-Google-Smtp-Source: ABdhPJw339gzjfTqTSkdWhWJGffdRyP08iLkKXFtUKR1Qq+D288cs49wq7sJRek+Lkk2yCojN5U4n9uiQvL0a0zxC0M=
X-Received: by 2002:a05:6e02:12ed:b0:2c9:adfa:bdf5 with SMTP id
 l13-20020a056e0212ed00b002c9adfabdf5mr812423iln.164.1648849144956; Fri, 01
 Apr 2022 14:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <YkdrEG5FlL7Gq2Vi@cmpxchg.org> <243A0156-D26A-47C9-982A-C8B0CDD69DA2@linux.dev>
In-Reply-To: <243A0156-D26A-47C9-982A-C8B0CDD69DA2@linux.dev>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 1 Apr 2022 14:38:53 -0700
Message-ID: <CAAPL-u_UiJQetHJbMXb6CbgzjLOUUFGcLnLn0MDGTN=LWpcgqQ@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Apr 1, 2022 at 2:21 PM Roman Gushchin <roman.gushchin@linux.dev> wr=
ote:
>
> > On Apr 1, 2022, at 2:13 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > =EF=BB=BFOn Fri, Apr 01, 2022 at 11:39:30AM -0700, Roman Gushchin wrote=
:
> >> The interface you're proposing is not really extensible, so we'll like=
ly need to
> >> introduce a new interface like memory.reclaim_ext very soon. Why not c=
reate
> >> an extensible API from scratch?
> >>
> >> I'm looking at cgroup v2 documentation which describes various interfa=
ce files
> >> formats and it seems like given the number of potential optional argum=
ents
> >> the best option is nested keyed (please, refer to the Interface Files =
section).
> >>
> >> E.g. the format can be:
> >> echo "1G type=3Dfile nodemask=3D1-2 timeout=3D30s" > memory.reclaim
> >
> > Yeah, that syntax looks perfect.
> >

I agree this is a better syntax than positional arguments. The latter
would require a default value be specified for each earlier argument
if we just want to provide a custom value for a later argument.

> > But why do you think it's not extensible from the current patch? We
> > can add those arguments one by one as we agree on them, and return
> > -EINVAL if somebody passes an unknown parameter.
> >
> > It seems to me the current proposal is forward-compatible that way
> > (with the current set of keyword pararms being the empty set :-))
>
> It wasn=E2=80=99t obvious to me. We spoke about positional arguments and =
then it wasn=E2=80=99t clear how to add them in a backward-compatible way. =
The last thing we want is a bunch of memory.reclaim* interfaces :)
> So yeah, let=E2=80=99s just describe it properly in the documentation, no=
 code changes are needed.
