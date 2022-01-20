Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D047495467
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358258AbiATSti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiATSth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:49:37 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4792EC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:49:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so15901247wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PjKjTy7eKMFmfv+qinocmQZR2jNJN1JZ8w0q2u47Vn0=;
        b=paUwrbhZpOFOr2xyR2soJ0kAo/nNbfubVkLwUSz83Sz4q100u/2m+ldwyqhvP4+ibh
         LJoQv0pBDZkkBmEmGsTXanXgsY+pbr6Om76/tzDmzfEm+K9YhcvY/MNq/9r77Wq6PE84
         hDH5fDVjTO2RdutpFbmeFsHefNlQ4X2AqM/DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PjKjTy7eKMFmfv+qinocmQZR2jNJN1JZ8w0q2u47Vn0=;
        b=ukY9TgQeqM99ItMUSSZ8rwLdQbmv7wdr+uTvhb5t20/2wdPIt6uBX4ooDeIr0rhYYu
         Ryf7PHfIM4DkUV23pX2+Vm8gjocltU1c1qh9jOj6j1p62Y2/sIk53z6klkePhKmhUXA8
         jnMi936pNCrRrUAkvIs2mYEwR2m7WHGD6llzhz7F2z5CKkQWYV76/F40nneLO4PvsU8j
         vHMzgV9NjkvIWMxwZ6gi4b5AKJP67VaXZYX9bph7DSuZVZEUDynpXM3BEnuIK2LJ41ih
         DMxp7DgeMDN6dVA+6M1ajB8T4yMvcuIeQSMkhR4bxBW4iGBtTKxMKkWAePO3Flngxme3
         LbkA==
X-Gm-Message-State: AOAM533hEqER+Ipn5euj7wWXBA3m8FWIfWBNaEznkJ4WjkdfWR/s9l1p
        /IJ8GhSSA6iJhju7qaIropdTLYyfoZdu2g==
X-Google-Smtp-Source: ABdhPJy/33XhjLc483J2fGdR8q8hYcr38yxjUVZuY1FCf5UdwYkL+OsJLlJHmPsW6ujinOgXviu0Gw==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr358168wrb.545.1642704575807;
        Thu, 20 Jan 2022 10:49:35 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id p8sm3781641wre.72.2022.01.20.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:49:35 -0800 (PST)
References: <20220119014005.1209-1-zhudi2@huawei.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Di Zhu <zhudi2@huawei.com>
Cc:     andrii.nakryiko@gmail.com, ast@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, luzhihao@huawei.com,
        rose.chen@huawei.com
Subject: Re: [PATCH bpf-next v6 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
In-reply-to: <20220119014005.1209-1-zhudi2@huawei.com>
Date:   Thu, 20 Jan 2022 19:49:34 +0100
Message-ID: <87wniunsxt.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 02:40 AM CET, Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
>
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Thanks for adding the annotation.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
