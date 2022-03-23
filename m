Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEAE4E5B44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344631AbiCWWfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241288AbiCWWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:35:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14084A91D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s11so2492108pfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FLvEj99W00mHv5B9slSilnvGkrPhQki6M9e6QFVKTLw=;
        b=c+I8yLbApFcdgUn8ce7KccpjXqMKYbFfWoXTnmRsnyTyPLPllx0fX54RZjMcU+2hax
         6g5G3cEOm5r3ZlMtA7kWxOLun+XwYqpPgVLElhqunddjM95buZ73WOrAkW7GhYeug88W
         vTT0PKJ1e5bSz1zqzS4QGFEmJq0qFDp+FbdoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FLvEj99W00mHv5B9slSilnvGkrPhQki6M9e6QFVKTLw=;
        b=8DaET7s6R+A3nvK6t527F2qVG2YqLU7XUUEXoBiIWZ8wcdNG7iJAd4TFSWTDzigJg/
         T319m1BOxEvI1WS26IXVcwR1dXdVp1eb9ZlSJYsEtGvKP3WOXWiATZs272b2mFPcYw38
         M+DwFk63U2iuKiN3LCa8Om7CPdJvp6FuFmjeBq/Zl6PV6xhK3g8OTeBaZ9K3I/IzoOEL
         UeIyLDY5eaJ3suaBZZtDMvz7CZOVHIie9H9gm9O0RmEz8PqCjm9iv97OvttCjS9tuG3i
         hgYhe6f2juRiDV3fT1crIxpUoOFWJHhibs0PrudCWuR6sKzvKhwNVjTsz8kDPlj4feib
         ++0g==
X-Gm-Message-State: AOAM532CFa6aaZGRrDg+VO/G/o8jgkFDVAwFPxV91cAeGXF0GfxTHptT
        8kAbdiNBAfQp+OKHfyZxJyJA7g==
X-Google-Smtp-Source: ABdhPJyz4zUzV3AWTkSwEjVMOftfaD5LbJrk0gnGi1w1o8j0flvgW2Dv6sCuVA11x5HmY4oAo0VoQw==
X-Received: by 2002:a63:e243:0:b0:381:6a51:145f with SMTP id y3-20020a63e243000000b003816a51145fmr1615681pgj.625.1648074811398;
        Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w24-20020a639358000000b00385fcbf8e55sm708627pgm.28.2022.03.23.15.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:33:31 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:33:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <202203231531.02D8297F77@keescook>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
 <20220323071409.GA25480@lst.de>
 <202203230809.D63BF9511@keescook>
 <20220323154739.GA816@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323154739.GA816@lst.de>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 04:47:39PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> > Regardless, I'm concerned that disabling PAGESPAN will just uncover
> > further checks, though. Where is allocation happening? The check is here:
> 
> blk_mq_alloc_rqs, using alloc_pages_node.  This hasn't actually changed
> with this comment.  Just the size of the allocation shrunk, probably
> leading to the span of pages.

Okay, the page allocator _should_ be fine for that. In the mean time,
lkp should probably just disable PAGESPAN.

> > I *think* the allocation is happening in scsi_ioctl_reset()? But that's
> > a plain kmalloc(), so I'm not sure why PAGESPAN would have tripped...
> > are there other allocation paths?
> 
> scsi_ioctl_reset is the odd one out and does also allocate a request,
> but that request is never used for user copies (and that whole hacky
> side path needs to go away, there is a huge series that needs to be
> finished to sort this out).

Gotcha!

-- 
Kees Cook
