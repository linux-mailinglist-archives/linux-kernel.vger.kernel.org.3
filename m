Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFF54F52D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381780AbiFQKTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380750AbiFQKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:19:18 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020769298
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:19:17 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3176d94c236so37955817b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQLMzotVPqnvzFyRvy50GKa/chJKSSZVKNq74iFATL4=;
        b=MMFYcwLiSBGM3efNJost8LPIQiNIB7AvovEBjR71wfj7Hw3JzKGq3v9nHjbw8+PYOI
         guljfGv10VDVT+GiyiF1LWKCl2cMLo8ix7XQgdbr3i0WyZBPGP/Ef8wGxXVTGAJ3WLhK
         A76tbHoTbRG/iDL32eLLjpV+KMJMYjK8gsgxK/3qKN+HtG80/1lwQ8vcWEjqCrAQ+49K
         c6s/wRxs4RKbnUxSOlg9QjmPpwe3tT4aBPzOH7qGMWkmkTneEMAHuMviabW8OrZU9upB
         sgY9r3iMEyz289JZcqnHHns5jnLwNedThiV32+STQp8iQNrknulOq0sIWv4NEUyjZMRa
         7g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQLMzotVPqnvzFyRvy50GKa/chJKSSZVKNq74iFATL4=;
        b=ULDhIa4aLEguFKbqZynfBgyhquba2TBLeFPvVPL747n+9edpAfAgoRapUX+WGi/f5n
         t71cmbR+GrkA8Mcjb6RJiEwt6bnYj6e2GZ6VpdC9UGAHbhdzwWH5P5uEUrOPt1tecwcV
         UgrngNwwE7suArAAvTyaFVI00IS0SQIegGk/J3non2zisOiK1ayeaTt4mGkImE3uIyzd
         esMeBUAT2Hcj9IJaWkO58wPKmBqVOQVx9qJ2VjDZXrqg+fYw25UU44e0cdG8Wf2jVCHo
         zOHqp0Rnk31+AkHsRCmJtL30sylDZdJtzPxgXWiqKr/S6Ltzt3E/ixM6B4SMXXDyOul2
         c93Q==
X-Gm-Message-State: AJIora+XXtMmy3JRNt7508cH8eq7NFXkr9InVOiwPijKhK+4HmYwaG7C
        BV6prjFWf+d34vbd587RlE38yYrCrsL70rFUzwEWVA==
X-Google-Smtp-Source: AGRyM1tdKx1ExiYYppt6HnbCn7siIIN642I4VhkHpcWhumKXyPkKJC/SvoSUVvnc30GsqtXMPxVJMom11hdnXaS9xSw=
X-Received: by 2002:a0d:f4c6:0:b0:30c:8e46:abe5 with SMTP id
 d189-20020a0df4c6000000b0030c8e46abe5mr10802723ywf.333.1655461156939; Fri, 17
 Jun 2022 03:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-2-wangkefeng.wang@huawei.com> <CANpmjNNPf5J2OcVxoMgVtFYjWJhJ2JE+UBFyqnt6+WrPobPOHQ@mail.gmail.com>
 <20220616231350.GA1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220616231350.GA1790663@paulmck-ThinkPad-P17-Gen-1>
From:   Marco Elver <elver@google.com>
Date:   Fri, 17 Jun 2022 12:18:41 +0200
Message-ID: <CANpmjNMnA0VtExcvpV=Sr57RQ3xxVkHxhrTkvEKeHZ27bhud+w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] asm-generic: Add memory barrier dma_mb()
To:     paulmck@kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        arnd@arndb.de, Peter Zijlstra <peterz@infradead.org>
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

On Fri, 17 Jun 2022 at 01:13, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 01:35:27PM +0200, Marco Elver wrote:
> > On Mon, 23 May 2022 at 13:21, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > >
> > > The memory barrier dma_mb() is introduced by commit a76a37777f2c
> > > ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> > > which is used to ensure that prior (both reads and writes) accesses
> > > to memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> > >
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
>
> Just checking...  Did these ever get picked up?  It was suggested
> that they go up via the arm64 tree, if I remember correctly.

I don't see them in -next, and as far as I can tell, they're not in
the arm64 tree.

Thanks,
-- Marco
