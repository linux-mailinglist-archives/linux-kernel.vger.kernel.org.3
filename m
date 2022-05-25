Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C91053446F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbiEYTnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345747AbiEYTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 15:43:32 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BA066F8C
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:43:27 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so43702885ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2so5Mzc6/Anj+eAb5PeB2pn0wQd0Ui5hrmZSPShUJSk=;
        b=ClAeyv25erXN5fpKcHwk4B8YWpXUehQeunEBVPSwb07wr0kbkKr02a6OwiYbxyOabm
         tHJtW2HEqZbHj1o2OTY/PAcEDKegqBNws8JTasC+43LHXgY1lRrN3DzuoPvJ/sxSloCD
         J+MDtDglojRRImuuzXr14wwumcd5JskHn5378=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2so5Mzc6/Anj+eAb5PeB2pn0wQd0Ui5hrmZSPShUJSk=;
        b=k0eh5GWWkWgYv7uQDgbHVYZH351BZNNGcF+4ceyp4PVXgXA3Vb5q9xuLbvmxvCIfqi
         tM6Qdh6Wnzr/+cAmjgvOGszHkpHWTrQBmCRbcwJgwHW+iMsBpJ0s5VvbZlCTW66D4Cqi
         PYpYCkThRLJzO/CKYhq0OQhZ3SqW2I0lCRhJeOQzxSiKGG4eQYv6rejQRQYPxrCJHGk7
         HsrxcHDTe/2hiYx6o/YK4z0z6rGCyPCbRDMipKIumPdGCs809sX5oak3KgPUXAsxXzXm
         tq54mD/jRa0MDVqLqelNszSx81H7bKw85GbnuC20CUUbbxkUecJEoHxGgdI88gFpuitR
         LeSg==
X-Gm-Message-State: AOAM531368X32hEPRkNNgS1NJG9Vm1Hr0lqgJOIb0OMAxZbxJckJo1/4
        QQ7LdS5+AjBEiGw91pC4ZgQfTpr36/bS4Am4WFA=
X-Google-Smtp-Source: ABdhPJxT2MUlg19wCrR7QXuGi22U8nhTvF7yLTGQtqbflngFW/3C5XN7LIMg2asiGew1C0fpp/Ihfw==
X-Received: by 2002:a17:907:1b0c:b0:6fe:25bf:b3e5 with SMTP id mp12-20020a1709071b0c00b006fe25bfb3e5mr30806860ejc.689.1653507805922;
        Wed, 25 May 2022 12:43:25 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906700600b006fed40e5564sm3873958ejj.83.2022.05.25.12.43.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 12:43:25 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id e28so30868495wra.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:43:25 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr17441487wrf.193.1653507805043; Wed, 25
 May 2022 12:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
In-Reply-To: <Yowcc/ZOBIIs2JtZ@slm.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 12:43:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
Message-ID: <CAHk-=wiGsJgFTJ=yqYwWA2vcTWQy=2QQ6to6vd3ETutaE0cDxQ@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup changes for v5.19-rc1
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 4:44 PM Tejun Heo <tj@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.19

Your two pulls sadly broke the perfect signed tag streak that we had
this merge window up until just now.

I'm very happy to see how people have started doing signed tags for
everything, but that only makes your pull requests stand out even
more.

So yeah, despite not requiring it for kernel.org pulls, I'd _really_
like to make using signed tags just be the standard behavior for all
the kernel pull requests.

Can we try to aim for that next time? Please?

               Linus
