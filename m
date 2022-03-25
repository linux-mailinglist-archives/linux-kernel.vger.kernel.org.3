Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489484E7C61
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiCYThs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiCYTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:37:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E953203A5E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:21:54 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so14969040lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MqmH9CCCrUKFAq5y+I/qeK/sNikgDEGLg2VH+hZ/B8=;
        b=EEYCtzdxDwF4pZQoFLQy5R1bkbtIioQJ+didZOsq+7BOWsBdCAqNeXRuHlQHbxjkxI
         6ZpgNOxAuZZNbggkh7Po3d0QcOFG1glqGOPQvM9m9QhMt25NNyLu1evDrcAPEgux5s6f
         doW8iQM9agqh0IgmvQNxMRNQkwdp7w1AkhPq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MqmH9CCCrUKFAq5y+I/qeK/sNikgDEGLg2VH+hZ/B8=;
        b=ov2y5Mova7OKvx1eVg2wyTjQhRQP7+fJeyX3+UnrumiTaXp9cOoTwyj6ZC1w660dbg
         aycqKKTVtUHuYkRcirgkDw38PKcV42TbtTR1c+J2ry+eychGODcqCF2e/S5eajLGCyfP
         iQs/Hr/2oiLxXZFqttou6uZnkS8F4j82EwyxiS1AenDTgqu6he2WIlYi1ASq1oliaHF+
         qL6qSMEPCyGQmxkXUc39Vr2339+81ynMhb3FRJuMH6/uMBd6PV71sTOTGbbI+y18FijR
         O5aV5dw8YbX7920Kw6ZtX/j55zPiOH1IssbtTuB3eMWvULpX+V940PQnhPk1+ZKTSa93
         Th8A==
X-Gm-Message-State: AOAM530RVtsR7ZMCZmnduuNtMAKihg9Zvtju7I3m46oO/VOH0SStHIlh
        K2icLN89F//QLwlLnLfjvfP93AKZ7hZcOb2oyNQ=
X-Google-Smtp-Source: ABdhPJxNG1ohd5we/7hcyRSNdNdEuVpIFa7qluLH1i+2BgLIKgZUT6oGtoKg1hmUNkaR4bGYSlD5mw==
X-Received: by 2002:ac2:5f4d:0:b0:448:7d37:5838 with SMTP id 13-20020ac25f4d000000b004487d375838mr9036236lfz.419.1648236112053;
        Fri, 25 Mar 2022 12:21:52 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0044a2580a2d3sm799165lfj.156.2022.03.25.12.21.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:21:51 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id bu29so15067520lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:21:50 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr8851909lfh.687.1648236109737; Fri, 25
 Mar 2022 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <1812355.tdWV9SEqCh@natalenko.name> <f88ca616-96d1-82dc-1bc8-b17480e937dd@arm.com>
 <20220324055732.GB12078@lst.de> <4386660.LvFx2qVVIh@natalenko.name>
 <81ffc753-72aa-6327-b87b-3f11915f2549@arm.com> <878rsza0ih.fsf@toke.dk>
 <4be26f5d8725cdb016c6fdd9d05cfeb69cdd9e09.camel@freebox.fr>
 <20220324163132.GB26098@lst.de> <d8a1cbf4-a521-78ec-1560-28d855e0913e@arm.com>
 <871qyr9t4e.fsf@toke.dk> <CAHk-=whUQCCaQXJt3KUeQ8mtnLeVXEScNXCp+_DYh2SNY7EcEA@mail.gmail.com>
 <31434708dcad126a8334c99ee056dcce93e507f1.camel@freebox.fr>
 <CAHk-=wippum+MksdY7ixMfa3i1sZ+nxYPWLLpVMNyXCgmiHbBQ@mail.gmail.com> <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
In-Reply-To: <a1829f4a-d916-c486-ac49-2c6dff77521a@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 12:21:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpKDePfUoKmvJhSNbWcHFY5e7Uq5qEypD=R14+66DNvQ@mail.gmail.com>
Message-ID: <CAHk-=whpKDePfUoKmvJhSNbWcHFY5e7Uq5qEypD=R14+66DNvQ@mail.gmail.com>
Subject: Re: [REGRESSION] Recent swiotlb DMA_FROM_DEVICE fixes break
 ath9k-based AP
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Maxime Bizon <mbizon@freebox.fr>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Halil Pasic <pasic@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Olha Cherevyk <olha.cherevyk@gmail.com>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>
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

On Fri, Mar 25, 2022 at 12:14 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Note "between the DMA transfers", and not "during the DMA transfers".
> The fundamental assumption of the streaming API is that only one thing
> is ever accessing the mapping at any given time, which is what the whole
> notion of ownership is about.

Well, but that ignores reality.

Any documentation that ignores the "CPU will want to see the
intermediate state" is by definition garbage, because that is clearly
a simple fact.

We don't write documentation for fantasy.

            Linus
