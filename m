Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9250D57D2BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiGURqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiGURql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:46:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D3D51400
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:46:39 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so3074792edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xei2Yln+ZjWGwKDux+SkOl8Rzd0SOZ3o4aR/mHE/YmY=;
        b=GnAW6iRqc52ze4XnkIgJXGSpOJ7pmcASRXDrPGK9Tt1YNvhqtbHnhBvLDVvsLde3Wp
         mB1bcb34NDs2votPjzInMfbhE2r2Kr7UohUhZd3My7bSIOurLodaTEolX3cEMjrSFoja
         PN1PARuJGvb4hdvRHAaVmXKW/Cv8rD+4jc+fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xei2Yln+ZjWGwKDux+SkOl8Rzd0SOZ3o4aR/mHE/YmY=;
        b=iTwN/Ca1/kCmcSVNCdwe9sxII2GdwNbjL+fy0t+fxn1dEw7bfdaaML3SLUNCnRhjJT
         Po2kmYnTfMfRKo7aI7OGpDgxZx8nkqy+pb85Z9oRz9AzOSsHd1VMVF333s1jgB3nhjZE
         YiPa40M2zmI5VLNC+elqrcX9Eaxa3uat6RJOAhOw3zUcqtRZZayGl2orNlRsH7u0eSpk
         ae3BJA49LJqqJAPXtGvbeTxxWI/bHDXzI5LqhGeHbH+yGHZsxmqVDPbvj19BTB1d77hU
         dFQv4XQ8o6VYtKzQr2ZlPBFjLzjvKxY8GYuWAFH56lf3GMOHxqPU/AIsVMAANk6KOjXe
         +mAA==
X-Gm-Message-State: AJIora+kf/veCaDA4ZNBQMMuzrJJ4/YDMT3WFMQmOe2iVRldRjUtLUBc
        I0YxqqHXCmtKxJWKtHeuUqWcPorPi1y181kQbHo=
X-Google-Smtp-Source: AGRyM1taFUFma2U4J/62H++rAibEf+VjpSidb6yGwEAdEzHtlA+Fn/4bakiP6AjhO6p2yJnfC35RsA==
X-Received: by 2002:aa7:cd0a:0:b0:43b:c49d:22b6 with SMTP id b10-20020aa7cd0a000000b0043bc49d22b6mr5671401edw.155.1658425597836;
        Thu, 21 Jul 2022 10:46:37 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id v17-20020a056402175100b0043bb69e1dcfsm1313680edx.85.2022.07.21.10.46.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 10:46:36 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id u5so3315922wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:46:36 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr33926524wrb.442.1658425596274; Thu, 21
 Jul 2022 10:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220708071802.751003711@infradead.org> <YtkQNA4jkhfEfWzs@hirez.programming.kicks-ass.net>
In-Reply-To: <YtkQNA4jkhfEfWzs@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 21 Jul 2022 10:46:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDZmXm9AJHNMJEVKmwJg4ndQP-UeZxT7+gi13SnVsuvw@mail.gmail.com>
Message-ID: <CAHk-=wiDZmXm9AJHNMJEVKmwJg4ndQP-UeZxT7+gi13SnVsuvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] munmap() vs unmap_mapping_range()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 1:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> What are we doing with these patches? Andrew will you pick them up, or
> will I smuggle them in x86/mm or something ?

I'm picking up other random things right now anyway as people have
emailed me, so I'll just do that with this series too.

           Linus
