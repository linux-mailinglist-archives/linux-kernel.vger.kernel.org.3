Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7677857C56B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiGUHhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 03:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiGUHhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 03:37:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106517CB40
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:37:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2738259wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 00:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gzAWwnUgPA8hYUFg1Aq5YWHbOYBuHEot0taeaAhNYtQ=;
        b=MpTCbtKio/TJ8EaXwHYZmaqBSB0W3G2PSKgVmNgRPiln+t53SaPCCwlyheL1ytNuZD
         UuhgB9kHYplJD740Ual4j07JiPBZd0ot9SbISSbOJs11ndeluMNW3hvGV+AbDnlUS6/q
         fBYsaH32/44zJXt3gpRwxxSNNq9KOXzRij7xt/YEZAfvNdL2mc5cqbPCkY2iEjsL3cNG
         nyZZIouibxtG/ZBfot0mqNROr6wdJqVr//bQG4ic8OZ0A91qtuHeUyRm2nUn97ERdKiN
         bzpnHgdRM7BF1ZMceTwtZ3/7B5UqOb2aCSwg5D/eP06UgDGq1QOyHMdOuIVWXcCKJKcR
         DUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gzAWwnUgPA8hYUFg1Aq5YWHbOYBuHEot0taeaAhNYtQ=;
        b=lV4PXj1cffiCGnTDalOJ9xK8Rpldg1I/0nLMjbST9SwAa/6tyFGU1JeSfZNSOGbWuw
         b27DfyTg3qjhJu7IQ+gBH+wuRhZGUnDOsik8Zr047yyzDJ9BwfLv+ckkgUeySB9uNVKK
         iqe5aCZ0E1/nmIe+8V3YHaf19mXzRYP7HnlnLod8LqzAd7hgvGGZCAyJGxEYUqPCCg2P
         lo0d6g8/qsqAD8tKy7rE0txVSMYU9lPa3oFncIrfhuBcru9mqWFAdmiYq6DtyQ7+ZTvB
         i1tuaPloc2FWnRSOz95lr/qB5+ud4vnLIkkG2ux4oQwpKsOeDiWcOA1dlYBCiIayWxoq
         jWfw==
X-Gm-Message-State: AJIora8HcROD9S86L+/9KhJOnDx8JG/8hpmwY/mbWXH5wPuLrsKFoQhl
        y+u9ZZZj19M/xVGxCJ5itWiDdw==
X-Google-Smtp-Source: AGRyM1vUYhpfJ8f5WiYRNRoDmh5lXecdVlAzF+s7bAs2s48eQne8qOMtKWfGmdODzofob0AHo0i4kQ==
X-Received: by 2002:a05:600c:601b:b0:3a3:21a2:8bcd with SMTP id az27-20020a05600c601b00b003a321a28bcdmr6992613wmb.80.1658389063396;
        Thu, 21 Jul 2022 00:37:43 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d5649000000b0021d7ff34df7sm1132377wrw.117.2022.07.21.00.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 00:37:42 -0700 (PDT)
Date:   Thu, 21 Jul 2022 07:37:38 +0000
From:   Keir Fraser <keirf@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtkCQsSvE9AZyrys@google.com>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
 <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org>
 <YtbXxl8STUtQkacb@google.com>
 <20220720024756-mutt-send-email-mst@kernel.org>
 <Yte8h0wtBZqiBky8@google.com>
 <20220720051351-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720051351-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 05:58:28AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 20, 2022 at 08:27:51AM +0000, Keir Fraser wrote:
> > The short answer is that there will be more patches forthcoming,
> > because the balloon driver will need to tell the hypervisor (EL2 Hyp
> > in the ARM PKVM case) that is is willingly relinquishing memory
> > pages. So, there will be a patch to add a new HVC to PKVM Hyp, and a
> > patch to detect and use the new HVC via a new API that hooks into
> > Linux's balloon infrastructure.
> > 
> > So the use case is that virtio_balloon needs to set up its rings and
> > descriptors in a shared memory region, as requested via
> > dma-restricted-pool and the VIRTIO_F_PALTFORM_ACCESS flag. This is
> > required because the host device has no access to regular guest
> > memory.
> > 
> > However, in PKVM, page notifications will notify both the (trusted)
> > Hypervisor, via hypercall, and the (untrusted) VMM, via virtio. Guest
> > physical addresses are fine here. The VMM understands guest PAs
> > perfectly well, it's just not normally allowed to access their
> > contents or otherwise map or use those pages itself.
> 
> OK ... and I wonder whether this extends the balloon device
> in some way? Is there or can there be a new feature bit for this
> functionality?

To my mind it is implementation dependent whether the balloon device
needs to be extended. In my current implementation it is not, and
probably it will continue to be entirely handled host-side by the host
kernel and hypervisor. But we should consider the possibility of
requiring knowledge/extension in the device for sure.

Currently there is no feature flag for the new Hyp-notification path
on the driver side. The notification hypercall is hidden behind a new
API, and there is an init/probe call on that API by which the driver
unilaterally decides the extended path including Hyp notification is to
be used. One downside of this is that the device cannot detect a
legacy driver that lacks knowledge of the extended PKVM path. Any
pages returned by a legacy driver will simply crash the VMM, because
the hypervisor is still protecting those pages. A rather inelegant
failure mode!

I can envision a new feature flag that:

1. Is advertised by the device (makes sense: the VMM surely knows that
it is managing a protected VM).

2. Is Ack'ed by an aware driver, and which switches on the extended
notification path.

3. Is not negotiated by a legacy driver, causing the device to clear
FEATURES_OK, and the balloon is unavailable.

A balloon-specific flag called perhaps VIRTIO_F_BALLOON_UNTRUSTED_HOST,
or VIRTIO_F_BALLOON_NOTIFY_HYP, or somesuch? In some senses it's not a
balloon-specific piece of information, but it's only a pertinent feature
for balloon (at least as of now).

My understanding is that the first step in upstreaming such a new flag
would be to get it accepted into the virtio specification? If so and
this sounds agreeable, I'll rework my private patches, and cook up an
extension to the virtio spec. If an RFC posting of the patches here is
preferred before posting to the virtio-spec list, I can do that too.

> > Perhaps it would make more sense to re-submit this patch as part of
> > a larger series that includes the rest of the mechanism needed to
> > support virtio_balloon on PKVM?
> > 
> > Thanks,
> > Keir
> 
> I suspect so, yes.

Thanks for your review feedback. I will submit a full patch series in
due course.

Regards,
Keir
