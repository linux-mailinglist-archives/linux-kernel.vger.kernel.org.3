Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6D4C46CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiBYNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiBYNm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:42:27 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204F749F0B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:41:55 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z66so4452505qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V83goiqYyGQpz53d+mmf7MQS3t+Z9Y1WIlxPTksW/2k=;
        b=WQEzx7ZUuhLiVdKdscZ2OVoRp/gF9KV90HiAYBYkFxtrc4+qo1zPxqpp2n5/peQNH+
         8SkkGiKjue3ggp58s5Nb3rw27XIvQkSWKALxbMwwU3idTf1Xd5/40YISHMa9UuVNGvWM
         bmbjYM82MkK9MuZteqwkCE3+9ytILhrBhwmVeI785OnfCZA5ThH/IKCKncDn87nQFITB
         46y15sY6Xh5ta89t5QGVkqXrzj1pYAD1FDK0WaqZmhUMVsv8UgS/QsobddgMjOD6YLpJ
         dCqXlMQ6K2PrrqR/S8PIIgZAhp3Y9Z9MYL2kbAvuRj7mAEYuU1/4tXl0hvYnYRIRZOtJ
         huAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=V83goiqYyGQpz53d+mmf7MQS3t+Z9Y1WIlxPTksW/2k=;
        b=ss6m1MZ8MG54P6z06C8OKfeRnqF4/CiEL3ZwTpqRFCDUebzesuTOp7HU0eSGK31v3S
         40bw/O61GJ/0A3OKAY8t4IzOtMMk3tyM6GiNe4o3/cxq/e2jbver+K20/onC8SC7ADRH
         EyYDbcQ4aUWPcEuzRyXPp+mJbLkcjamXXSUfK61BaxaLavX0xpNdCO93XlAzXORnzpNO
         gMfNkPssbqgEx64EGJIORhIP5lDKepFzyF3/ov0gNTRYKmYC754mCoxdb7gGRInjeSr6
         OAbsTarx5mV/ScHpnXE51qvquP+qLtmZlSE+gjCWa9b4hTPLNCIbIQsSYkmYJgfL3Evm
         0pYA==
X-Gm-Message-State: AOAM532tdEZ9OXRrveDsvdkjLfwzm7SO8OD3x2P3TbdTlEsjT3BHoZw1
        b1WwVqAf9rrI5cThrkCkZk1eqw==
X-Google-Smtp-Source: ABdhPJxhj+4Ta8cKetNhte+HxrNPD8zFxBlshZu89PiwziIqhFgzma7NtqO/yve/DOoELRIHSAGclw==
X-Received: by 2002:a37:a38b:0:b0:506:bebf:f51b with SMTP id m133-20020a37a38b000000b00506bebff51bmr4709794qke.280.1645796514287;
        Fri, 25 Feb 2022 05:41:54 -0800 (PST)
Received: from sevai ([74.127.202.66])
        by smtp.gmail.com with ESMTPSA id g1-20020ac87d01000000b002d5c8226f17sm1548447qtb.7.2022.02.25.05.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Feb 2022 05:41:53 -0800 (PST)
From:   Roman Mashak <mrv@mojatatu.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Menglong Dong <imagedong@tencent.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Cong Wang <cong.wang@bytedance.com>, paulb@nvidia.com,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        flyingpeng@tencent.com, Mengen Sun <mengensun@tencent.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yajun Deng <yajun.deng@linux.dev>,
        Roopa Prabhu <roopa@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: ip: add skb drop reasons for ip egress path
References: <20220220155705.194266-1-imagedong@tencent.com>
        <20220220155705.194266-2-imagedong@tencent.com>
        <3183c3c9-6644-b2de-885e-9e3699138102@kernel.org>
        <CADxym3apww2XEeTX=kU7gW5mbQ9STwVyQypK4Xbsmgid9s+2og@mail.gmail.com>
Date:   Fri, 25 Feb 2022 08:41:28 -0500
In-Reply-To: <CADxym3apww2XEeTX=kU7gW5mbQ9STwVyQypK4Xbsmgid9s+2og@mail.gmail.com>
        (Menglong Dong's message of "Fri, 25 Feb 2022 14:05:08 +0800")
Message-ID: <85v8x3xdvb.fsf@mojatatu.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menglong Dong <menglong8.dong@gmail.com> writes:

> On Tue, Feb 22, 2022 at 11:13 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 2/20/22 8:57 AM, menglong8.dong@gmail.com wrote:
>> > From: Menglong Dong <imagedong@tencent.com>
>> >
>> > Replace kfree_skb() with kfree_skb_reason() in the packet egress path of
>> > IP layer (both IPv4 and IPv6 are considered).
>> >
>> > Following functions are involved:
>> >
>> > __ip_queue_xmit()
>> > ip_finish_output()
>> > ip_mc_finish_output()
>> > ip6_output()
>> > ip6_finish_output()
>> > ip6_finish_output2()
>> >
>> > Following new drop reasons are introduced:
>> >
>> > SKB_DROP_REASON_IP_OUTNOROUTES
>> > SKB_DROP_REASON_BPF_CGROUP_EGRESS
>> > SKB_DROP_REASON_IPV6DSIABLED

Is this a typo and should be SKB_DROP_REASON_IPV6DISABLED ?

[...]

