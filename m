Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CB44EE12F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbiCaS7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiCaS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:59:01 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0451A9CAB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:57:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t2so412564pfj.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1+siZaVK/kXVqsXYbi//KXC5axu7BHMbEufK00AlNjc=;
        b=aPdxjXbqnRl8zkYeXt242YklwYJJtJHUT7hXWJryzIimZis6pJ7UFItGf/o3AVBIQt
         FpJ+NjyejG8w6lw2IC2MuawguCRN/FwnIa4lXoW4ajwEra9UwF2ggG4HEzWZiEAorIg9
         29t6wknDOwaxMZCU/C1nvfJDvEKUz0vQh4jNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1+siZaVK/kXVqsXYbi//KXC5axu7BHMbEufK00AlNjc=;
        b=PP1s5TiXdEaSd3Ak0yZLgCHMOSw8le2B+diHNGtpO8X9AXexL8YUAXZvOU40OQphIJ
         tKpS9aAu9esxx1u9dPLnOFt8LKuKWXznLETsEDruYYxvx82BLdqhbGXozBfwZU9hzEsY
         pVGq0U1wTQYelkGoX1hzB6xv9We7Zroqge5J/+udJ0zC2gbciDZXvx66K23cVRw+z5GZ
         Pg02s3fPanCIFetb0xDERi1i7zNAvd+ZFw4DVLL7RQGBDcsVwUoS5mc8vvA4FYf71KtT
         arss/o/RyOcnWSKhC+I6AhF2/IrNw7b9dKz4bJ5OAo6fs8kOJQ9SsCmiRTZrTHLRDgXc
         nLOg==
X-Gm-Message-State: AOAM532P9jNcAB+DogZ2YkZPadDj5AVh0Wn2TrwT9P1SR9LSnu6ADHYj
        ro208mmpjFvT4I33zDRQ8IASdw==
X-Google-Smtp-Source: ABdhPJwQut3pKHwZBwM67ZAcNHcDMFOpwSRVJbF1FtR4uiIl/GBq8kkD0Hu+isv8bqcA5u7FY2h1kg==
X-Received: by 2002:a62:a50b:0:b0:4f7:4457:a48a with SMTP id v11-20020a62a50b000000b004f74457a48amr40446968pfm.50.1648753033531;
        Thu, 31 Mar 2022 11:57:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f15-20020a056a0022cf00b004fb32b9e000sm224600pfj.1.2022.03.31.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:57:13 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:57:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
Subject: Re: [GIT PULL] hardening fixes for v5.18-rc1
Message-ID: <202203311154.ABD158F6@keescook>
References: <202203311127.503A3110@keescook>
 <YkX3BKpxwCaey8QU@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkX3BKpxwCaey8QU@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 07:46:28PM +0100, Russell King (Oracle) wrote:
> On Thu, Mar 31, 2022 at 11:35:40AM -0700, Kees Cook wrote:
> > Hi Linus,
> > 
> > Please pull these hardening fixes for v5.18-rc1. This addresses an
> > -Warray-bounds warning found under a few ARM defconfigs, and disables
> > long-broken CONFIG_HARDENED_USERCOPY_PAGESPAN.
> 
> I don't see these patches on linux-arm-kernel... are we doing away with
> patch review now? :D

Uh, what? The links in the patches show the reviews, even. I assume
you're mainly talking about the DMA one; it's right here:
https://lore.kernel.org/linux-arm-kernel/20220309175107.195182-1-keescook@chromium.org/

I had thought hch was going to take this patch, but the dma tree didn't
have it, so I sent it in.

And the usercopy patch was here, with references to the discussion
around it too:
https://lore.kernel.org/all/20220324230255.1362706-1-keescook@chromium.org/

-- 
Kees Cook
