Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9606E51E027
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442925AbiEFUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344781AbiEFUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 16:34:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE496D3A9
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 13:31:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id p6so7987199pjm.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3Ntzrv5FDfp2eYpZMiopVYr18OlFo4VdjXUK7cfBPU=;
        b=O85NYqjWtDow9jeD3TU4kt+F6nWSDZskBn/bCqCnzjrY0EvFfS6+VN0I/1Ug/g1LlB
         2DVu+gjTG6VequvguY9OTwOg7lx0M0Xei4zmUF4J4To6SZXF6OW0pjPQW5tz+1JziBPu
         oAJNATpkVHBP2oxE9oggwFfFpeNIqI32ZBDazGe4aKFySi23y67jZQdGZ6KpNArR7aoZ
         0i6l0s63jE1++BzSxYYsV+zeDutL3ni1k8+8pceZ20jUE70PsJEd49T6CNzTWMAJwSHr
         kUxbtMyHSumwabqi2UDYAMg4eCWPDRMdgx9HLIxktjj1lcJKVf9rUGHfqG/aHVsWek4T
         TcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3Ntzrv5FDfp2eYpZMiopVYr18OlFo4VdjXUK7cfBPU=;
        b=WRV85Otao8yOpB+N2k6GC/dy/iq16M9hlSkZCQzEWtTjoKTdZBOntTEjaEFunzpnw4
         UUzvHN/JsWh7lXETqstFTrmoVy7Ou/YY003wdJg2uiGCk2um3x+dYIklW2+6GoozuZJ9
         fFv/ln8XU4/l7GmXYmhdexWj02i6dEFcFsqoKYa3+rnF6kXdaAabMYArfxv3EgjtIl0u
         qFatOEi0b7ofY/i8afUgC/zA+6b7NTQBbELX87mO0v+AOd9ox21KlWRfpdQLO5xgGIHb
         8NiKoHz6EUoAh4s3mUrgh9cmcDhEHjWJGH9/GTYNxEm5qEIaWdDPD6k4PfxeicZ+snk2
         RlDw==
X-Gm-Message-State: AOAM531b6LjWywzAspNWrwSV/Z4DBD1UQaJHOEmZznYPLrVBUV+wnzBj
        6PXjpHQc2VlfEwcnz2oAzwFQKVf6BR8zzw==
X-Google-Smtp-Source: ABdhPJyUnf/2IAy1zjU8UQe87XfdGkBcgm1RleycVg7wfOu86v/fVUxrm5PQSkosijGggjbgCRfX4w==
X-Received: by 2002:a17:902:c952:b0:15e:89be:49ea with SMTP id i18-20020a170902c95200b0015e89be49eamr5571513pla.32.1651869074157;
        Fri, 06 May 2022 13:31:14 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id b7-20020aa79507000000b0050dc7628163sm3822221pfp.61.2022.05.06.13.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 13:31:13 -0700 (PDT)
Date:   Fri, 6 May 2022 13:31:11 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Peilin Ye <peilin.ye@bytedance.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH RFC v1 net-next 1/4] net: Introduce Qdisc backpressure
 infrastructure
Message-ID: <20220506133111.1d4bebf3@hermes.local>
In-Reply-To: <f4090d129b685df72070f708294550fbc513f888.1651800598.git.peilin.ye@bytedance.com>
References: <cover.1651800598.git.peilin.ye@bytedance.com>
        <f4090d129b685df72070f708294550fbc513f888.1651800598.git.peilin.ye@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 May 2022 12:44:22 -0700
Peilin Ye <yepeilin.cs@gmail.com> wrote:

> +static inline void qdisc_backpressure_overlimit(struct Qdisc *sch, struct sk_buff *skb)
> +{
> +	struct sock *sk = skb->sk;
> +
> +	if (!sk || !sk_fullsock(sk))
> +		return;
> +
> +	if (cmpxchg(&sk->sk_backpressure_status, SK_UNTHROTTLED, SK_OVERLIMIT) == SK_UNTHROTTLED) {
> +		sock_hold(sk);
> +		list_add_tail(&sk->sk_backpressure_node, &sch->backpressure_list);
> +	}
> +}

What if socket is closed? You are holding reference but application maybe gone.

Or if output is stalled indefinitely?
