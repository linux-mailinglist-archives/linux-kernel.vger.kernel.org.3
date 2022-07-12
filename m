Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAB4572179
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiGLQ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGLQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:58:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB28DEE7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:58:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g12-20020a05690203cc00b0066e232409c9so6492581ybs.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pW3VY9UCSHV/WHaAinEoEI5ziscblWk9zZZv5jrPnko=;
        b=iGASFEYWEgahJcIK+rqOuHbIKmgCy0b/LNGQ/QjENuaU2zo+ZSVAJGLt9YdkeKrEBB
         FQZjcuLiJzjO4YT+YqTDzoyDVaeQQ/EHXsoZ9N1R3NN9SLylgJW9pfKYiJ3XJPCgo+SV
         LlAOss5mIOR0/aLl+/4SzQSzSlKBhuL8+wOPjs8NoF1KiWM1tT7fb0GG2xHHY7wjW/i3
         D5bbCjfAKDrbYvUsajr1MueIW3xcqfdBRPYONWqSyL2P6mYRMY2f9T858cP8LWOaB+WX
         x/Sdl6201wc9QErc0Vy3BYkqC431Nhc0hmvDF3YWeCIAM5qkJGV8Y/TbThqtUb4VXOaP
         G52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pW3VY9UCSHV/WHaAinEoEI5ziscblWk9zZZv5jrPnko=;
        b=Vd/lwr2JtaiALa8y4p8Y4a42HvGzhVt72ZnE/yz5oAtvu4rmNB2WDFmUVVgXkqAF8X
         mf+nYPjt6OqnzuEKUrvNGJjk+Y5WMcTwNYFVKnm/4+c6kwtn9yCmVAnVfk499MQGvLyN
         CaWuGmvdH7+N5ZKSneffiIPDSbsTvj3I5+DlNP/iOC4u8OA3lMAU4WBVNP7FIY7qzlhC
         XHhaTJTP20u5LSQ09yv21T39sdXlcdrjGuABOf0RD/kqlaCWDLrBFCAZsO8rL5L4XMBE
         jw98hAd6tZyZOxMWAodzgBltFSvM2WOEkHFn2Lqjt74cBsUR0RHh6OgVw7BrCMR1Ye4j
         TtuQ==
X-Gm-Message-State: AJIora8YETAlwe8UqIe90IbTFxuKgDgwVVFzy6cKLIKvaomh/KewQGyM
        ye2l4C9hF7R5h02qhLxKKMxacWw=
X-Google-Smtp-Source: AGRyM1vTRa1g122HIBG2Z6ETQ8rb83s+oq/Ra7q6Gnx7ofVy9Eox5zCYafhIjUoysCTl9mrhJ9cZ6Ls=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:b091:0:b0:66e:56f5:eae7 with SMTP id
 f17-20020a25b091000000b0066e56f5eae7mr22038689ybj.366.1657645120866; Tue, 12
 Jul 2022 09:58:40 -0700 (PDT)
Date:   Tue, 12 Jul 2022 09:58:39 -0700
In-Reply-To: <20220712120158.56325-1-shaozhengchao@huawei.com>
Message-Id: <Ys2oPzt7Yn1oMou8@google.com>
Mime-Version: 1.0
References: <20220712120158.56325-1-shaozhengchao@huawei.com>
Subject: Re: [PATCH bpf-next] bpf: Don't redirect packets with invalid pkt_len
From:   sdf@google.com
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hawk@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12, Zhengchao Shao wrote:
> Syzbot found an issue [1]: fq_codel_drop() try to drop a flow whitout any
> skbs, that is, the flow->head is null.
> The root cause, as the [2] says, is because that bpf_prog_test_run_skb()
> run a bpf prog which redirects empty skbs.
> So we should determine whether the length of the packet modified by bpf
> prog or others like bpf_prog_test is valid before forwarding it directly.

> LINK: [1]  
> https://syzkaller.appspot.com/bug?id=0b84da80c2917757915afa89f7738a9d16ec96c5
> LINK: [2] https://www.spinics.net/lists/netdev/msg777503.html

> Reported-by: syzbot+7a12909485b94426aceb@syzkaller.appspotmail.com
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>   net/core/filter.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4ef77ec5255e..27801b314960 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2122,6 +2122,11 @@ static int __bpf_redirect_no_mac(struct sk_buff  
> *skb, struct net_device *dev,
>   {
>   	unsigned int mlen = skb_network_offset(skb);

> +	if (unlikely(skb->len == 0)) {
> +		kfree_skb(skb);
> +		return -EINVAL;
> +	}
> +
>   	if (mlen) {
>   		__skb_pull(skb, mlen);

> @@ -2143,7 +2148,9 @@ static int __bpf_redirect_common(struct sk_buff  
> *skb, struct net_device *dev,
>   				 u32 flags)
>   {
>   	/* Verify that a link layer header is carried */
> -	if (unlikely(skb->mac_header >= skb->network_header)) {
> +	if (unlikely(skb->mac_header >= skb->network_header) ||
> +	    (min_t(u32, skb_mac_header_len(skb), skb->len) <
> +	     (u32)dev->min_header_len)) {

Why check skb->len != 0 above but skb->len < dev->min_header_len here?
I guess it doesn't make sense in __bpf_redirect_no_mac because we know
that mac is empty, but why do we care in __bpf_redirect_common?
Why not put this check in the common __bpf_redirect?

Also, it's still not clear to me whether we should bake it into the core
stack vs having some special checks from test_prog_run only. I'm
assuming the issue is that we can construct illegal skbs with that
test_prog_run interface, so maybe start by fixing that?

Did you have a chance to look at the reproducer more closely? What
exactly is it doing?

>   		kfree_skb(skb);
>   		return -ERANGE;
>   	}
> --
> 2.17.1

