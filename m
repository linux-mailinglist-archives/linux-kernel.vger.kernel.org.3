Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBBA5400C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244142AbiFGOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiFGOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:11:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7869B1BD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:11:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 187so15632439pfu.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SdrNomF4nhx1466F59Cs0XBm4DrFs3fSMmHF2b5d1e0=;
        b=YWdHmyRPgXwT5Qi5R4fjTlaDOegA5ZwY7kd0cNW+AniEZ9gqycaerLcysiv7Yc87yE
         2C70wH3f79NoW84qA7fZusj7t6pLZo9I8/HVY/ZYiQ7+fljY1WecjXZJrX7H0RSA1Khe
         1FTrcwTQayTr7bGlBZpLDOsKqNgr9KglwIATX+xf6dgFs92JIcXMqSfh2wdTOI39fC9y
         5eiGZ0pqhBeO8FhoE0bNopfv901Cnm/WzyIQ7K3rjxGPImJO+7L0MCpgOqdojh95CTxg
         RoOhILHg9P9RcEGMr0E/A2rQr//BDDMwkFwZOdonsdSq3T36wqQkbmUJmO8YvCEQUTw3
         78vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SdrNomF4nhx1466F59Cs0XBm4DrFs3fSMmHF2b5d1e0=;
        b=WAPIWw3SHOOmNFbwwzm41y9kJOoclOiKTIkuyuxklPhfbuX/wFyyrcKlrSxEH1t+dW
         Nvnh1jrd8+be51H3lvwL086z184+nN8F7VWh8A2h54WzmXDnvBKah8zzsyO+VK47HEl+
         2Y3O8un2aqGN2uVKkAVuqlu/KCOjidb5HWrgRBY1c/7xo8EsKj7d/dQvywB2o1zxllgN
         vtEpOANx1V9vqLb4qHMc/K+wurX5wNHuf8iYo6lhPtbh6USnIuhZY+acxsF09bp0Qtce
         GPE6jXDKDTQDibVVkRXNDRCBgNxCf2oHQRqmIvJ+mTEM/lAG6BPZWIRxtNKpdgBbi+C2
         uM7Q==
X-Gm-Message-State: AOAM531nCArqWzspR1A6S2fozDK49VXMVnZXgYFnbn0g4QpQ09hIxpYJ
        cf/udcy1q750VOpBQPMC8bmo8Cl4Z1Q7NS2bEBYReQ==
X-Google-Smtp-Source: ABdhPJw6uvsovKcKEsVatuSAukDIo0+3pI8rZnaWuOqZGty1hm85rKto4OfXHOtKKjKiaDxzPIkUG/cz9GuFDKZA0VE=
X-Received: by 2002:a63:4c09:0:b0:3fc:a85f:8c07 with SMTP id
 z9-20020a634c09000000b003fca85f8c07mr25624592pga.509.1654611063721; Tue, 07
 Jun 2022 07:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <Yp4F6n2Ie32re7Ed@qian>
 <360a2672-65a7-4ad4-c8b8-cc4c1f0c02cd@openvz.org> <CALvZod7+tpgKSQpMAgNKDtcsimcSjoh4rbKmUsy3G=QcRHci+Q@mail.gmail.com>
 <183333fc-e824-5c85-7c44-270474f5473a@openvz.org>
In-Reply-To: <183333fc-e824-5c85-7c44-270474f5473a@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Jun 2022 07:10:52 -0700
Message-ID: <CALvZod5fizxoqC5cWtKFt4mkd9bvHhRhKs=H+McDtWvYz3Yq2g@mail.gmail.com>
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks allocations
To:     Vasily Averin <vvs@openvz.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
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

On Tue, Jun 7, 2022 at 5:37 AM Vasily Averin <vvs@openvz.org> wrote:
>
> On 6/7/22 08:58, Shakeel Butt wrote:
> > On Mon, Jun 6, 2022 at 11:45 AM Vasily Averin <vvs@openvz.org> wrote:
> >>
> > [...]
> >>
> >> As far as I understand this report means that 'init_net' have incorrect
> >> virtual address on arm64.
> >
> > So, the two call stacks tell the addresses belong to the kernel
> > modules (nfnetlink and nf_tables) whose underlying memory is allocated
> > through vmalloc and virt_to_page() does not work on vmalloc()
> > addresses.
>
> However in both these cases get_mem_cgroup_from_obj() -> mem_cgroup_from_obj() ->
> virt_to_folio() -> virt_to_page() -> virt_to_pfn() -> __virt_to_phys()
> handles address of struct net taken from for_each_net().
> The only net namespace that exists at this stage is init_net,
> and dmesg output confirms this:
> "virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)"
>
> >> Roman, Shakeel, I need your help
> >>
> >> Should we perhaps verify kaddr via virt_addr_valid() before using virt_to_page()
> >> If so, where it should be checked?
> >
> > I think virt_addr_valid() check in mem_cgroup_from_obj() should work
> > but I think it is expensive on the arm64 platform. The cheaper and a
> > bit hacky way to avoid such addresses is to directly use
> > is_vmalloc_addr() directly.
>
> I do not understand why you mean that processed address is vmalloc-specific.
> As far as I understand it is valid address of static variable, and for some reason
> arm64 does not consider them valid virtual addresses.
>

Indeed you are right as we are using the addresses of net namespaces
and the report already has the information on the address
ffffd8efe2d2fe00 which is init_net.

I don't know what is the right way to handle such addresses on arm64.
BTW there is a separate report on this issue and arm maintainers are
also CCed. Why not ask this question on that report?
