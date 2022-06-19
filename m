Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6C550986
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiFSJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 05:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFSJpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 05:45:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80F3A453;
        Sun, 19 Jun 2022 02:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC64B80CFE;
        Sun, 19 Jun 2022 09:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A049C34114;
        Sun, 19 Jun 2022 09:45:25 +0000 (UTC)
Date:   Sun, 19 Jun 2022 10:45:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        arnd@arndb.de, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] asm-generic: Add memory barrier dma_mb()
Message-ID: <Yq7wMj30T/mJp+FZ@arm.com>
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-2-wangkefeng.wang@huawei.com>
 <CANpmjNNPf5J2OcVxoMgVtFYjWJhJ2JE+UBFyqnt6+WrPobPOHQ@mail.gmail.com>
 <20220616231350.GA1790663@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMnA0VtExcvpV=Sr57RQ3xxVkHxhrTkvEKeHZ27bhud+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMnA0VtExcvpV=Sr57RQ3xxVkHxhrTkvEKeHZ27bhud+w@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 12:18:41PM +0200, Marco Elver wrote:
> On Fri, 17 Jun 2022 at 01:13, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Mon, May 23, 2022 at 01:35:27PM +0200, Marco Elver wrote:
> > > On Mon, 23 May 2022 at 13:21, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> > > >
> > > > The memory barrier dma_mb() is introduced by commit a76a37777f2c
> > > > ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> > > > which is used to ensure that prior (both reads and writes) accesses
> > > > to memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> > > >
> > > > Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> > > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > >
> > > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Just checking...  Did these ever get picked up?  It was suggested
> > that they go up via the arm64 tree, if I remember correctly.
> 
> I don't see them in -next, and as far as I can tell, they're not in
> the arm64 tree.

Since v4 was posted during the merging window, it hasn't been queued for
5.19-rc1. I normally only merge patches with a Fixes tag during the -rc
period (though there are some exceptions). Mark commented in v1 that
such tag isn't necessary, so I thought I'd leave it for the 5.20 merging
window.

That said, the diffstat is small, so if it helps having this in 5.19, I
can queue it for -rc4.

-- 
Catalin
