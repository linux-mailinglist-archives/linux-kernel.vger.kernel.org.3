Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5BB4C3B97
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 03:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiBYCXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 21:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiBYCXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 21:23:22 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A601218F20A;
        Thu, 24 Feb 2022 18:22:51 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id c23so5022576ioi.4;
        Thu, 24 Feb 2022 18:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fqT7xMVhlkuYITxIP6wUnF7YOQBx/icOOIa7N5wif0A=;
        b=gnlGb05yXUIE56zjJKjuuBAWsC/Cgdmwdqc05R/voHdgesiQq+mhWw3NpP/codOHNi
         WJuDHuVi33I+szk4tje1azz8i7r9xs1rySdJ7bpPKrvYr949RR/ggEc6KW2ZjTajgfpw
         YPwLtQ947hdrrJf4tIut02wnS1WotS4bEzfsyJLUZbMxVhZ0BV/lOkaQNsLfqagHp/7R
         2yG+QummpeMrl/QUSLA0gz96YRv7rPuyrl0gRuWItBqY1faWQIauoQJVG3XqfS6BjZqX
         uAsDD+GIamq1IgYyAV8ANx/mOZKWQLL0AkHSpTlZq3KcXNEsOnSGLIp858U+oWrpuZiO
         jPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqT7xMVhlkuYITxIP6wUnF7YOQBx/icOOIa7N5wif0A=;
        b=3PG8JcD+r4+edTEPzOexSN8OwdIprvGLy6UlqW1EDI8W4YYjtrgB1tIbjIC3/uOLsn
         MYvrpLFNOgCHCaDPI4/BJa6bWEhZGnO/uwg4b70iREDb6XG/dtIvCavhNXrPmgY3MCRg
         eDJ9P9hGcOo8TCZVAhih1Fi0EfScYPliTSUw1a0R3Xe6hQNPWSD8Qk5q/hfI3fYOLMvD
         R1ghem17tDUWYH4LptoLX4HVR3eKNjJ6WmBWDs1K6HA9I1HnDdSLJVlAjN/jxLbk009g
         TooFS3XvdQI6L5atcgtUeGm545TzCnvtQtqgiufsMSrQcALhOj/ocdb5ULhPVVUa+UmY
         1IJg==
X-Gm-Message-State: AOAM531hE5TO90w+qHGVRfplBVFILnLhBCXrz7y1D+kjm149eaGCH/u/
        CKP0WkmliAkyCxs73ZdhJBBULeoA11k=
X-Google-Smtp-Source: ABdhPJy1y/FaYJjQbixlh+TYdSr5O6kFJrbYX26H+xQ8ENN0LB5QEwIEZ1zNSUuyRsIa9eVzU/CEkQ==
X-Received: by 2002:a05:6638:304:b0:314:cffb:6b5 with SMTP id w4-20020a056638030400b00314cffb06b5mr4448153jap.34.1645755771128;
        Thu, 24 Feb 2022 18:22:51 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y3-20020a920903000000b002be151ee1e6sm844332ilg.30.2022.02.24.18.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:22:50 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5D4C727C0054;
        Thu, 24 Feb 2022 21:22:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 24 Feb 2022 21:22:49 -0500
X-ME-Sender: <xms:eD0YYoX9qojkq15d1ZH8PiPucx5Ab8vIdZaehgi9koqwDevJNCw5_A>
    <xme:eD0YYsmLJSXVGxvUmQDdVMqt8SCazLatkyrMYWDEBNCnpRRZKj6Hsi9GhFbSbKjww
    XytNSGYpsAPB8r-gg>
X-ME-Received: <xmr:eD0YYsZyP6_oNm1quC05uF9F_0BNOU0c-nCS6UeYWMXdjDFmdvCPaO3plhCkPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrleefgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvg
X-ME-Proxy: <xmx:eT0YYnUujWbQNcf217XiAoACKv7aA6GFoLTro5D9-CfhxB66XxKxzA>
    <xmx:eT0YYimq-QcXJ50ffl8Y0WqgK8L-4mqsmFc0nHZOLur5NFDLVCKmVA>
    <xmx:eT0YYsfl4KA-quRKq21VtvdTkHdD2e_lX6o4t7tSV03SE0W_3PcOVg>
    <xmx:eT0YYs6YaHcJTyiLK16sY98PKM5WHLwXwd-mEHoZT7xdmWLoFyXENg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Feb 2022 21:22:48 -0500 (EST)
Date:   Fri, 25 Feb 2022 10:22:01 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     corbet@lwn.net, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Leah Leshchinsky <lleshchi@redhat.com>
Subject: Re: [PATCH] Documentation/locking/locktypes: Fix PREEMPT_RT _bh()
 description
Message-ID: <Yhg9SU353e+Gh5Jg@boqun-archlinux>
References: <20220224212312.2601153-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224212312.2601153-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:23:12PM -0600, Andrew Halaney wrote:
> With PREEMPT_RT the _bh() version of a spinlock leaves preemption
> enabled, align the doc to say that instead of the opposite.
> 
> Reported-by: Leah Leshchinsky <lleshchi@redhat.com>
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Documentation/locking/locktypes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 4fd7b70fcde1..bfa75ea1b66a 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -247,7 +247,7 @@ based on rt_mutex which changes the semantics:
>     Non-PREEMPT_RT kernels disable preemption to get this effect.
>  
>     PREEMPT_RT kernels use a per-CPU lock for serialization which keeps
> -   preemption disabled. The lock disables softirq handlers and also
> +   preemption enabled. The lock disables softirq handlers and also
>     prevents reentrancy due to task preemption.
>  
>  PREEMPT_RT kernels preserve all other spinlock_t semantics:
> -- 
> 2.35.1
> 
