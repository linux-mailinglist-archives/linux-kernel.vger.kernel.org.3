Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAF24F6C1B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiDFVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiDFVIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:08:18 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92617C31C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:45:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so2888900plg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QR9VBOF3kjexQACzq2xyx6513mlIANmHO5eMnNtR5po=;
        b=bT3Y0W3IY0MmXP4LbGQ7myD11Um/f2YwBybIgcW8/e4c9JpleLbA6fMIUTdyWsq/l/
         QmvXqnGNGoGzXsZfEBfGRMR13NfFSEfDzAM5Qtkl20Tg7G/K80nI3UWpt95zVYe5+NI0
         5ZErY1G03Yw+yaXfTkhXXqCrWnbJcxjyhgpOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QR9VBOF3kjexQACzq2xyx6513mlIANmHO5eMnNtR5po=;
        b=Lj64icFwUyRQ8KnW95HXqqDI9lCSNarXoeI6vlCBXRQL9yQ452hsrXOgD1ciBzM0+D
         9NIfjjGMdUC/FRR8IVPCW0P7yn1r9I7M3kqD7BKA1t9D/GRvJ53xRlHYstz68PqxeobK
         lwTb0zjbUzHmWw4eZYqEoa8uiNdtAmRi3Flc/MzLNiVU6leuUnP2HOju/FvRSL0wH66H
         aj5DGR6Gn1ctTrvYDX8uaof8X8qO/jXb22H18tP+FbQtNkJxcxhFgRq7lZcHpyj2YUv7
         oibcMpXVAjd3QKNpc9gw/OktGOx2K2XQGjepWN2CguJfEPzn+P0MVtMC1cnhYB6B2QPY
         W1uQ==
X-Gm-Message-State: AOAM531SmlGeoMfiWSlB8Bo4SfOKQbHLaFrongGrn4Glxxzz6xt2khPf
        MragNQPemkmII0n/o/FMEfe6kQ==
X-Google-Smtp-Source: ABdhPJyCWXEiXug5j/YhyTe7l4u20Ek1Ou2bigp3Nxso9GCPynFzuly95CtpgeKIIzozmjXBLpkCvA==
X-Received: by 2002:a17:902:a9c5:b0:156:32bf:b526 with SMTP id b5-20020a170902a9c500b0015632bfb526mr10440281plr.46.1649274358106;
        Wed, 06 Apr 2022 12:45:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm19854441pfc.3.2022.04.06.12.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:45:57 -0700 (PDT)
Date:   Wed, 6 Apr 2022 12:45:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <202204061243.FB134CA4B1@keescook>
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202005211950.D56130B81@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005211950.D56130B81@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*thread necromancy*

Hi Dan,

I'm doing a KSPP bug scrub and am reviewing
https://github.com/KSPP/linux/issues/74 again.

Do you have a chance to look at this? I'd love a way to make mmap()
behave the same way as read() for the first meg of /dev/mem.

-Kees

On Thu, May 21, 2020 at 08:01:53PM -0700, Kees Cook wrote:
> On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> > The typical usage of unmap_mapping_range() is part of
> > truncate_pagecache() to punch a hole in a file, but in this case the
> > implementation is only doing the "first half" of a hole punch. Namely it
> > is just evacuating current established mappings of the "hole", and it
> > relies on the fact that /dev/mem establishes mappings in terms of
> > absolute physical address offsets. Once existing mmap users are
> > invalidated they can attempt to re-establish the mapping, or attempt to
> > continue issuing read(2) / write(2) to the invalidated extent, but they
> > will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> > block those subsequent accesses.
> 
> Nice!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> And a thread hijack...   ;)
> 
> I think this is very close to providing a way to solve another issue
> I've had with /dev/mem, which is to zero the view of the first 1MB of
> /dev/mem via mmap. I only fixed the read/write accesses:
> a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads")
> I.e. the low 1MB range should be considered allowed, but any reads will see
> zeros.
> 
> > +	unmap_mapping_range(inode->i_mapping, res->start, resource_size(res), 1);
> 
> Is unmap_mapping_range() sufficient for this? Would it need to happen
> once during open_port() or something more special during mmap_mem()?
> 
> -- 
> Kees Cook

-- 
Kees Cook
