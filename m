Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4865A53B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiH2SCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2SCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:02:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4D7E82A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:02:49 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f14so6673556qkm.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UeCjsqVX03HELV6Qxt26VdXhNVQmFOTxZbHveZi3Wic=;
        b=cUqah88qiqkMfKXIggmg3kkUscXJDGR5OrYwItkLbrscXP0wYnc6ckeka2erXb9+EK
         sMS+NHZt6ZJeQw5uULvYMQj02mdFaEp9RH0AfvLiKJs1hk2KIeSzdztoblg4GHwuYAqo
         xJeq1L3lg9LCT0kx6VYK7lxh2La6HHLVxdQnn1yW8dW25hwlg5PRUQsgU5boHtjoRdVD
         2dJ9e3wrNYW/kfW4g7WqzZoY8OzS/twBI5CP3iVmtwlxOE/oC9V6GgT6xG4x7+OqE3Zl
         sTXfjeW5XeJ2pFjxoriPT0yfEIdAhd+uiYl+xGpi8w3v08bruNKjvsBUwGxhCPUrdKMl
         xAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UeCjsqVX03HELV6Qxt26VdXhNVQmFOTxZbHveZi3Wic=;
        b=cNJYBcwe1aQCHDssKtlqrdxmqfGzehN0AbtAvLKgj0EbBYBO8LRmVSYD1sirn2Q5Jj
         oZGdCidyVZOI3Org54Ogob4bLDOMmfGvyEcwVk3Tp9Hc/ExUq1p0aG6zI8/w39OEfsAh
         zcrwf125bXDEjO0lKrYvjGAKUSh0JmphaEcdprmfm7HZlp1Bx30PRfUK3OXMlPYboiib
         IB3XGGTIuUOv1uH/iO2Y/yDWH7Mxp2YHTH3rfUNsfyNogrx5J6CUrZ7fL4JhFGBPuPvl
         XQA05dRSkY8DjJl1Xj1+efnmJm+9ypvxUB5QWUnOirTb8ahiBNZlCVd7ZHT1nHctBt9B
         z3gw==
X-Gm-Message-State: ACgBeo14G3OjSBSNn1YI8APU5L06EntjM0suW5WCTPCW/tFMRdCD58rE
        R81mw3T9s6FqUu9bO1zRCnOw43J1J+b+qxGZ0bj2UQ==
X-Google-Smtp-Source: AA6agR5OBmeDJ16u+wpsLthSvl07+laB7IqnfG6IMHAL5xzAxarEXJcb+CwRWclg02qBxPnvrkbaCKG0Hlu9zMCSoWg=
X-Received: by 2002:a37:4d7:0:b0:6ba:c29a:c08f with SMTP id
 206-20020a3704d7000000b006bac29ac08fmr9048293qke.669.1661796167617; Mon, 29
 Aug 2022 11:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220826165238.30915-1-mkoutny@suse.com> <20220826165238.30915-5-mkoutny@suse.com>
 <CAJD7tkZZ6j6mPfwwFDy_ModYux5447HFP=oPwa6MFA_NYAZ9-g@mail.gmail.com>
 <20220829125957.GB3579@blackbody.suse.cz> <CAJD7tkZySzWgJgp4xbkpSstc_RMN_tJqt83-FFrxv6jASeg8CA@mail.gmail.com>
 <Ywz8J70t3508J62n@slm.duckdns.org>
In-Reply-To: <Ywz8J70t3508J62n@slm.duckdns.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 11:02:36 -0700
Message-ID: <CA+khW7jZCN54nUonNLp59fTAqOtAk_Ror+PgrLBfufRcE-CnFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] cgroup/bpf: Honor cgroup NS in cgroup_iter for ancestors
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Aditya Kali <adityakali@google.com>,
        Serge Hallyn <serge.hallyn@canonical.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 10:49 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Aug 29, 2022 at 10:30:45AM -0700, Yosry Ahmed wrote:
> > > I'd like to clarify, if a process A in a broad cgroup ns sets up a BPF
> > > cgroup iterator, exposes it via bpffs and than a process B in a narrowed
> > > cgroup ns (which excludes the origin cgroup) wants to traverse the
> > > iterator, should it fail straight ahead (regardless of iter order)?
> > > The alternative would be to allow self-dereference but prohibit any
> > > iterator moves (regardless of order).
> > >
> >
> > imo it should fail straight ahead, but maybe others (Tejun? Hao?) have
> > other opinions here.
>
> Yeah, I'd prefer it to fail right away as that's simple and gives us the
> most choices for the future.
>

Thanks Michal for fixing the cgroup iter use case! I agree that
failing straight ahead is better. I don't envision a use case that
wants the alternative.

> Thanks.
>
> --
> tejun
