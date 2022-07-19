Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7257A36A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbiGSPqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbiGSPqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:46:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A15466B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:46:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so9421736wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kqnEGuwdGL/9ka9VI5SH5OR/R6+4E4AxuYZiFP6QOA=;
        b=DgwVaZAuXJgpKNuo/mQO2VpGOFldoshJHhrRh5+WU47YO4bxB8XHgjPKF21snVQzEh
         AF0W9yap/1oEQ/9DrgFLEaueqzmGPcWUpTID9Brn4WnnglQsXQHTf5a93fYYNLyl/cco
         wg3vW0w2ovG5u9qiKjg5/P1kUCFlXbYrX5sXivV8yr2Ue/tucgeQGtRXM/7YmPYucGjw
         h/5BFS7p7tI8/NZ1Vjr15C1Hs6yQaKWwTrR8nzIygGECEEvjNC7tKwUAvNK9Cw1mEtYT
         cAzMdcxfh5L4mbcUvT6SkEEMR6ICELlFQ1AU48lFdG1uCq+FDDjaLySKsnG9b9mH7exM
         p2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+kqnEGuwdGL/9ka9VI5SH5OR/R6+4E4AxuYZiFP6QOA=;
        b=wbmp0Wq2DWlQyTJBuICOEwkgOkTSB15Ib0DDMl5a8QDSqUVSN1qL1CpcwB965wGX5F
         qOs0Q4u0jn3KZ21ymzDF/uTCmDaJkjd/773yONTRYoVJTgVMJ2n2gYbC1IOX5r8Je403
         RyCWgzpR+dFksZpohRT/X4Az98dVcsh0HFgQUkE5E7GnnfjdjuwI0/tJ2OHDUmx18HaE
         wr/UCSWYH8YI44+BgfGVOAxZj/KMD23HypknQ2TvzFC8Ld1GUd4dK8zkELF9fSktySbM
         9l9RSH21plOClu5hlUKlbhN0Z41qK1bCMJUDIicHIzBp0Dal9o037fqsLX6wbNv3qypQ
         wfXQ==
X-Gm-Message-State: AJIora+4ikLHDQ9Kf1hiHKNTyY7EppHWnZQp1W/lA1OWBpxf0sbv+dvE
        vN8LsT/CSXo5R0rz26f157U9EQ==
X-Google-Smtp-Source: AGRyM1vS1EEs2tjnXlD0CCiCQ+rDlIaT/ApLJbmp6pmhhDNOgkNHr7nIR7GFrG6LQGRWxqN4zTJa/A==
X-Received: by 2002:a05:600c:190d:b0:3a0:585a:256 with SMTP id j13-20020a05600c190d00b003a0585a0256mr29780283wmq.54.1658245572362;
        Tue, 19 Jul 2022 08:46:12 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id t4-20020a1c7704000000b003a308e9a192sm16733494wmi.30.2022.07.19.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:46:11 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:46:08 +0000
From:   Keir Fraser <keirf@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel-team@android.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtbRwO40CmIRWOUR@google.com>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtbMcBw4l0LAFn9+@infradead.org>
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

On Tue, Jul 19, 2022 at 08:23:28AM -0700, Christoph Hellwig wrote:
> On Tue, Jul 19, 2022 at 10:02:56AM +0000, Keir Fraser wrote:
> > +#include <linux/swiotlb.h>
> 
> Drivers must never use this header.  We have a few pre-existing abuses
> in the drm code, but they will go away.
> 

Ok fair enough, and I'll admit I don't like my use of
swiotlb_for_alloc() a lot either.

However, if the general idea at least is acceptable, would the
implementation be acceptable if I add an explicit API for this to the
DMA subsystem, and hide the detail there?

Or a completely different approach would be to revert the patch
e41b1355508d which clears VIRTIO_F_ACCESS_PLATFORM in the balloon
driver. MST: That's back in your court, as it's your patch!
