Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCC4B12C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244201AbiBJQ3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:29:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiBJQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:29:34 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C7B104
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:29:35 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c6so17056997ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icJaWELoFkK+x1iy67lv/nCb3yezWQKgn5KOEGJ+cIY=;
        b=SN2tNbcQchx4HXJyjvkghxpfPQ2bvwdEG3CbOAyk+0XyFNYjQkxITqTjVne6ncX93M
         Ft/L/YPHrYfefVdYvRiuB7L8xki1DMTFwDelpjUnawbEyMDT0o5dakr/W8+2VkvrLNZa
         5q5IMl6Op/EZeK1QHdMQnbJUXOuk06mg6VYmGWEYbMD1OAOJjg6mEt9Rdb7AI8N5RE3P
         pDA0PijIAVF9dWawbq0V5TFORF6k91Lg52OzlD6dCOlt06XvOdBgbsfuz6FjKzGf9znC
         Xwbmr06f7BVMlJfpekrsnSWf6dQFwfMtX1T+LhO2xdECrKk6hLVQauiRV1sljIAiQWh7
         X7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icJaWELoFkK+x1iy67lv/nCb3yezWQKgn5KOEGJ+cIY=;
        b=iHQp0tI2oml7YV8xJz8qR+jwBcMTFE4XynIbN0SIldx42365zVFHMZC0b4FhmRu49r
         twgkDk0YAYffBY+qIdIydmCpIgTTE3hhSrCyF8aYZ5e4aEI57j/z3Hnlx5fhKZ/20Msu
         npXE+J3gKIgLguu/D9/bUGNEkZVxqv9rno9Z2V7E7Alhbfjr+/a3Nyp2ycBo1zc0vKHt
         mtqd2osGf6G9HUbW2cey1Rwz6pfcQaFXukoNOPicy870190VGWbVh3942zrXZNhY9NoM
         RBur+HnEy4OQXLIG2A5qyBn6VSEU7axhLqN5Nhsv4pqcKp2L2Y5dhelHI5jyKXAThNh4
         8mqA==
X-Gm-Message-State: AOAM532OvNG132x3RduvU8lrAkDBhwlmH4Yhv+0hLz9E12qtUleH2Kz9
        EooF+ie/ybN7WSLSCKIv1MOzd4TtFiS43eF6hxbuZg==
X-Google-Smtp-Source: ABdhPJzt9+1Rkf4flJfxjiFJAaQfZGZW9tw1ziM0rdiM1SVD5y2oz2Eso/1rLeRMF9U4H1OVH/407PmVpIn8yVGq8f8=
X-Received: by 2002:a25:4f0a:: with SMTP id d10mr7613486ybb.296.1644510574702;
 Thu, 10 Feb 2022 08:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20220128073319.1017084-1-imagedong@tencent.com>
 <20220128073319.1017084-2-imagedong@tencent.com> <0029e650-3f38-989b-74a3-58c512d63f6b@gmail.com>
 <CADxym3akuxC_Cr07Vzvv+BD55XgMEx7nqU4qW8WHowGR0jeoOQ@mail.gmail.com>
 <20220209211202.7cddd337@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CADxym3ZajjCV2EHF6+2xa5ewZuVqxwk6bSqF0KuA+J6sGnShbQ@mail.gmail.com> <20220210081322.566488f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220210081322.566488f6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 10 Feb 2022 08:29:23 -0800
Message-ID: <CANn89iKhkQ_0TbSJnPtMJrC57nz=0iiRXR-XzeZj5q6OPYZnFA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/7] net: skb_drop_reason: add document for
 drop reasons
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        David Ahern <dsahern@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Menglong Dong <imagedong@tencent.com>,
        Alexander Lobakin <alobakin@pm.me>, paulb@nvidia.com,
        Kees Cook <keescook@chromium.org>,
        Talal Ahmad <talalahmad@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, Cong Wang <cong.wang@bytedance.com>
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

On Thu, Feb 10, 2022 at 8:13 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 10 Feb 2022 21:42:14 +0800 Menglong Dong wrote:
> > How about introducing a field to 'struct sock' for drop reasons? As sk is
> > locked during the packet process in tcp_v4_do_rcv(), this seems to work.
>
> I find adding temporary storage to persistent data structures awkward.
> You can put a structure on the stack and pass it thru the call chain,
> that's just my subjective preference, tho, others may have better ideas.

I had a similar TODO item, because stuff like 'waking up task' or free
one skb (or list of skb) could be performed outside of socket lock.
