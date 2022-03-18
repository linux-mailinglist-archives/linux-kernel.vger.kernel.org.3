Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDD4DD9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiCRMlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiCRMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:41:33 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAA318FAD8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:40:14 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id kj11so2481594qvb.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 05:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LmXFCGzUKyPQi78MWhxrBmfo7hI3p1k1nGlp0osF6aE=;
        b=N8mXUAv1YJYYXpNEDsy6vW/WLv9Vz81haAY4pqjnXzeeSVmCtQCzHqfHXmv5cIM2xM
         rAvax9y02XCxJsRtzNdXXerS+FAZvFY/QwUHYliHtOK+PqFozR/5QqTof2faIsUyoOBC
         dg9L4PF4Y+16G/ezIbymndqaF+X6NdRG4Oyqq/x0TYK34hMr+bV0QnSruVcIX64h4ViU
         qTvNW5CDzRdn9NQohU4HXVLCUlCMfGJYlSv0c5oUrltNEFYHXwWOk1opkQFmvaAzi2mf
         /legt+wKJmBn1rN3IkGMvuYcvuc353y2NaJPES5jXrh/42mWCcyZI29dv7TswLIHO0JD
         95eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmXFCGzUKyPQi78MWhxrBmfo7hI3p1k1nGlp0osF6aE=;
        b=ps+/NcS/vydyeN3fdgoadndSq9ZKplKhHb2LewFAIPohikVG8fKfpMoXy3J2W7mcom
         Ff2MeF7LjJksER3G95pwMguxX7OM3D49rzM4Eq2IGpxAOQ1x4w+vmn4oNWF82CIjzzTy
         yNlrF/VmTFEwXAbjtnzTS2gDFSlIU0dLle92FZVqnz+SJuh5YwbeT5p80OaiQS+AT5qX
         sPNo4Wroabn5wuXwX1LFctQh89S8+m2Fd8kbOGB3fxU4BfedFNNy0vu2SRuHoyFhO0ro
         HH5fRbOoIe2moAkTujBxtwPO+WvbN3BCeIH+kzK//iMex3vDMe4oZj10NnTplhhXIvgk
         3cdQ==
X-Gm-Message-State: AOAM531/O6vljiXUWEArDi42B2W95jVecLqVxJiOenHq1nyhg64HXO2w
        8owrhq/xf7SLo4LTtt5BrVOBHA==
X-Google-Smtp-Source: ABdhPJzmR2mz++JSeS3jA3a1AzaNng4Z1ET3mUDT9Wsi+KzkjLdBsOxJfgKV5E03f9dBkHx7OhnM4A==
X-Received: by 2002:a05:6214:3016:b0:439:365c:56b6 with SMTP id ke22-20020a056214301600b00439365c56b6mr6819937qvb.47.1647607213824;
        Fri, 18 Mar 2022 05:40:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a16b500b0067b1205878esm3687255qkj.7.2022.03.18.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 05:40:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nVBts-002PWG-0b; Fri, 18 Mar 2022 09:40:12 -0300
Date:   Fri, 18 Mar 2022 09:40:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Mika =?utf-8?B?UGVudHRpbMOk?= <mpenttil@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        apopple@nvidia.com, rcampbell@nvidia.com, vbabka@suse.cz
Subject: Re: [PATCH v2] mm/hmm/test: simplify hmm test code: use miscdevice
 instead of char dev
Message-ID: <20220318124011.GE64706@ziepe.ca>
References: <20220311033050.22724-1-mpenttil@redhat.com>
 <20220314182439.GB64706@ziepe.ca>
 <d9b9c82e-4012-cf0a-d966-d9669a684a27@redhat.com>
 <20220315183922.GC64706@ziepe.ca>
 <8e836d75-97b0-d301-4d6a-92025e91cad5@redhat.com>
 <0f53c5ff-1711-861d-9a12-0634d4ab9fca@redhat.com>
 <20220317141539.GD64706@ziepe.ca>
 <10fb1261-f22f-8e21-4056-166c283e26f2@redhat.com>
 <b3d5e596-adce-20b5-73cc-89c07917082f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d5e596-adce-20b5-73cc-89c07917082f@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 07:58:25PM -0700, John Hubbard wrote:
> In other words, given that the usage here is correct, is there some
> reason that miscdevice is still a poor design fit? Is cdev_device_add()
> a better choice here, for design reasons?

cdev's have become so easy to use I don't see the few loc reduction to
add miscdev that valuable. IMHO

> Also, is there any change that could or should be made to miscdevice,
> that you have in mind?

No, it is just a legacy interface that was simplifies drivers that
create a single char dev in static data that is widely misused.

IOW I wouldn't add new miscdevs.

Jason
