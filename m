Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D26561F31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiF3P0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 11:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiF3PZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 11:25:55 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583039831
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:25:53 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31772f8495fso182648517b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1HHuJRU/PzgASK5LVwUbv/TAJnPbu4jGG6I27QsOqY=;
        b=K7z0kaXZV+Vs0mudhBZ7v5I4hJ8K2IoRajqCVJXAvPAUEz8uwvT8kGg0TdLJ301AZC
         JKYyEQwIY2IUACWR8lS97iGRrC3WGn0tOXHUT16Ho/0modgYkovGX6yeA4tUtBtJfS0z
         Zlme6FyIJLdzNxUkBOwb8Mg7cC00jhPzMIFSa5h9jSd6wzE5flCIjTdT1UreW/ZMi4jZ
         yZ1Hp5lhZBiHrqx3mTXl95L0gizbbmnSXYD/Qa7zF5btYwTA0Hz3lZxHv2AbyPMVnZzl
         OM/jrbRauDoW2DR/7klV31KWRREq37PILkOqdgt1n2sU2VQbdKdICAxeJsewdFtutPMr
         WhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1HHuJRU/PzgASK5LVwUbv/TAJnPbu4jGG6I27QsOqY=;
        b=ani3TzAlgkJ8UycP+wAG49ZNhKnhm6B8xkydoa0R+uV4WpW286dMnbA1E0/BJz/gei
         4GdP/RlL1+3BPPN45qq3BC2VNEwenqx2tEL1GGfNp4F/Ug+MKD3pVPL4vS3HHrridRQ/
         rtAIWEKvHb2kVfBZVd0WcVmRzAPdwCCNLkYKygnS5gwLd57dM/7VIQBakDUJKSEr+zd7
         igpdJS6sy5KfVZ5yjXqyGCU03hPfe4PP0CHs80/RZKEvfF9jMz/WPLr+IXOQon4sMtC4
         DrpETMO8oA6eZDsL5MZKNE2RwbehBewNj29IpvLIgUY2BAGYKnkJYb+t2ga0jEkoePGy
         VMGQ==
X-Gm-Message-State: AJIora/ebiUifjXcQFVXLsWX1GK+ryDWkyHHkzvk8wibRx7eZdxuOqpn
        8l/U4wKk+ApCX6875ssQhsvezaE9hdH1QBkvvISm5g==
X-Google-Smtp-Source: AGRyM1uuJ9rW4KbHFrPXVR1zK2ZCcPA3iz7q8YM9loeKl8FGUB46bzc9Tsz6h5bvkfR24CeeTCDnuPbW+dVmdEVQjFQ=
X-Received: by 2002:a0d:df50:0:b0:317:9c40:3b8b with SMTP id
 i77-20020a0ddf50000000b003179c403b8bmr11226355ywe.332.1656602752755; Thu, 30
 Jun 2022 08:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220629085836.18042-1-fmdefrancesco@gmail.com>
 <Yr12jl1nEqqVI3TT@boxer> <CAKgT0UfGM8nCZnnYjWPKT+JXOwVJx1xj6n7ssGi41vH4GrUy0Q@mail.gmail.com>
In-Reply-To: <CAKgT0UfGM8nCZnnYjWPKT+JXOwVJx1xj6n7ssGi41vH4GrUy0Q@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 30 Jun 2022 17:25:40 +0200
Message-ID: <CANn89iK6g+4Fy2VMV7=feUAOUDHu-J38be+oU76yp+zGH6xCJQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] ixgbe: Use kmap_local_page in ixgbe_check_lbtest_frame()
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Alexander Duyck <alexanderduyck@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, bpf <bpf@vger.kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Jun 30, 2022 at 5:17 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Thu, Jun 30, 2022 at 3:10 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 10:58:36AM +0200, Fabio M. De Francesco wrote:
> > > The use of kmap() is being deprecated in favor of kmap_local_page().
> > >
> > > With kmap_local_page(), the mapping is per thread, CPU local and not
> > > globally visible. Furthermore, the mapping can be acquired from any context
> > > (including interrupts).
> > >
> > > Therefore, use kmap_local_page() in ixgbe_check_lbtest_frame() because
> > > this mapping is per thread, CPU local, and not globally visible.
> >
> > Hi,
> >
> > I'd like to ask why kmap was there in the first place and not plain
> > page_address() ?
> >
> > Alex?
>
> The page_address function only works on architectures that have access
> to all of physical memory via virtual memory addresses. The kmap
> function is meant to take care of highmem which will need to be mapped
> before it can be accessed.
>
> For non-highmem pages kmap just calls the page_address function.
> https://elixir.bootlin.com/linux/latest/source/include/linux/highmem-internal.h#L40


Sure, but drivers/net/ethernet/intel/ixgbe/ixgbe_main.c is allocating
pages that are not highmem ?

This kmap() does not seem needed.
