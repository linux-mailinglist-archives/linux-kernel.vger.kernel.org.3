Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353424C5BD0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiB0Nzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiB0Nzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:55:31 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F9D1BE88
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:54:55 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id l19so8783136pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R5/L3FvnnktNyA34E6kruOzfisqAyzhCs9ooPGmemyU=;
        b=uuLL8S0E+zI20jKmcmApZ8T7BLy1ekrigcJchDezUrX58/hAEEwRWtQ8ixFg6WwbZF
         9Vfe4zkxPKtl6nk75f0qx6s/j4iSpeEI1ioAlj894Gh9jhhSfIwSMw/nYiZz5FpK3mK8
         yDqfKHXZuAV686mDbZNgIlvd2AaCcUgsyuwTbyPHLrRORL5h7yaCtg0M5cf+aon/8Yi2
         Ho29Y3QLIBQMpe5QW2akghgcYyDEwaubjGYraXpVw+qH+UnYondbitbR0ltIkaAhlDHZ
         6VwTPUxe15KRvxs+sPtwHLiGLBPLIMLxxe8indN6XxMJ8sYHw8ZA7HKBU57VUGRnQpso
         0j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5/L3FvnnktNyA34E6kruOzfisqAyzhCs9ooPGmemyU=;
        b=z1BAQUx3ZaQ0FKk2DG+/yGypwNKG4g0mMItMtOLnES05y4KhM1PxTF88dTH72Qa4+P
         Ds37n6B5qcKQEcx390CRw0TMZo1nsvx1NT0X4JrmCM2MWNWdl0RLt813bSwqFxK0jdX0
         NV0iiw2q7LD2ou0AUpUF8PdYfDIgbuBrj9HltgTAVpfsjb+YXZ0VTRs1mBRQGHtCndlP
         M2fgjVGkimPFTQskFd5EofIiKXu8FZ3e+2fBvb5bHahIGcUOAbVrKVY2d7gzsJWoB0kY
         NCyL5/fnA86T0GV1+4gMLGh4uHQiGfySotur1VFjPC/LbPsgr/SB22gS4ykwWPR1IPje
         Uy6g==
X-Gm-Message-State: AOAM532RVIGh+uwXSNZU0eP8sAu7Qv9f050aJSSdMdsdnoyr27XIFvO+
        biZjhK4uSCvbu2TC1Ir3zr9PMg==
X-Google-Smtp-Source: ABdhPJw1trEejf2Gp3RfzHniQF58pqnIWCn0DG0TdWVAUuroABa8H5/f51okcOdZQvFbGHfkKnpNhw==
X-Received: by 2002:a63:3111:0:b0:373:a1fa:8998 with SMTP id x17-20020a633111000000b00373a1fa8998mr13312669pgx.415.1645970094678;
        Sun, 27 Feb 2022 05:54:54 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.180.219])
        by smtp.gmail.com with ESMTPSA id v14-20020a056a00148e00b004e1cee6f6b4sm10221833pfu.47.2022.02.27.05.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:54:54 -0800 (PST)
Date:   Sun, 27 Feb 2022 21:54:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ali Saidi <alisaidi@amazon.com>
Cc:     german.gomez@arm.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, andrew.kilroy@arm.com,
        benh@kernel.crashing.org, james.clark@arm.com,
        john.garry@huawei.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH 2/2] perf arm-spe: Parse more SPE fields and store source
Message-ID: <20220227135444.GB107053@leoy-ThinkPad-X240s>
References: <9266bfb6-341c-1d9c-e96f-c9f856a5ffb6@arm.com>
 <20220222192943.20137-1-alisaidi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222192943.20137-1-alisaidi@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 07:29:43PM +0000, Ali Saidi wrote:

[...]

> >So I am just wandering if we can set the field
> >sample::data_src::mem_lock for atomic operations, like:
> >
> >    data_src.mem_op   = PERF_MEM_OP_LOAD;
> >    data_src.mem_lock = PERF_MEM_LOCK_ATOMIC;
> >
> >The field "mem_lock" is only two bits, we can consider to extend the
> >structure with an extra filed "mem_lock_ext" if it cannot meet our
> >requirement.
> 
> These are for the LOCK instruction on x86. I don't know that we want to
> overload the meaning here. Minimally there is value in differentiating
> exclusives vs atomics.

Good point.  Can we consider to add new filed data_src.atomic with
below types?

    PERF_MEM_ATOMIC_INST  -> Atomic operations
    PERF_MEM_ATOMIC_EXCL  -> Load-Exclusive/Store-Exclusive
    PERF_MEM_ATOMIC_ACQUIRE_RELEASE  ->Load-Acquire/Store-Release

Thanks,
Leo
