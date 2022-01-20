Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB14495469
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377345AbiATSt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346820AbiATSt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:49:56 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF5AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:49:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id x11so25210769lfa.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Eh+25ZzZLYPGl/lRxMZZYY8+xM69nDxzcnnWuCwMvIE=;
        b=rkDjhCqFWK0H62S9t7gWiqC6lYeFJeEk8jWydfTwVKoVSiYzQocyyU4LqiV7Ws6o8m
         vL8nqSzpUxUtktNtxq9qHgSoaGqcLUkF413ViUBXa1+erdUHS4ZwBGN16angkbHBWN/u
         hnQ80tQJmuz2zKdubwauE5ISZxtnr+p1UXBgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Eh+25ZzZLYPGl/lRxMZZYY8+xM69nDxzcnnWuCwMvIE=;
        b=Ri16FL4yldDnLA5Rjy5D0me0VXIN8A29bzg++bj408XjlqDtyJQrfuN280TquFrqev
         V1RY+XH3Rc9sdD4fTdyNFOG3lW2NezvbkOWn9ky8n3FeICpPb5B+Nao3QzSMS7goEjId
         F6rT6A6CENQeJBGw/CzMmzs8qAnFM1dcR1Wb/m9n8x/2cARWYxr1TW/Uwhyotx18RSLz
         1ugMDtcCLfXgRUnuD+YRq0tsp7QUeE9yEt6/+oK7ZAYMAuqdFUZg8bM4nQFDyxB/4XOb
         VGyuvgVEzxXJHzjpAQZIUBbL4wel7ZP3laa0thwsIdnZX28hTFN5XN2dOPUip3ZTyRNh
         8Nng==
X-Gm-Message-State: AOAM533lh7+qYssEzRfgo1Zg3hnDGu/CSVeKz5d++rZrWEf69Qnas26c
        X7LOECVnvOb1IjLXxLIQ+NZxuw==
X-Google-Smtp-Source: ABdhPJythW6Wd+a6ncMIUG/oO9XSAJNmdNG8aRPp/RO38w+a3zFTtYBOtF72sRlsB7rdgcrLWnjbEA==
X-Received: by 2002:a05:651c:236:: with SMTP id z22mr299253ljn.188.1642704594715;
        Thu, 20 Jan 2022 10:49:54 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id z3sm2420lfu.8.2022.01.20.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:49:54 -0800 (PST)
References: <20220119014005.1209-1-zhudi2@huawei.com>
 <20220119014005.1209-2-zhudi2@huawei.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Di Zhu <zhudi2@huawei.com>
Cc:     andrii.nakryiko@gmail.com, ast@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, luzhihao@huawei.com,
        rose.chen@huawei.com
Subject: Re: [PATCH bpf-next v6 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
In-reply-to: <20220119014005.1209-2-zhudi2@huawei.com>
Date:   Thu, 20 Jan 2022 19:49:53 +0100
Message-ID: <87v8yensxa.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:40 AM CET, Di Zhu wrote:
> Add test for querying progs attached to sockmap. we use an existing
> libbpf query interface to query prog cnt before and after progs
> attaching to sockmap and check whether the queried prog id is right.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
