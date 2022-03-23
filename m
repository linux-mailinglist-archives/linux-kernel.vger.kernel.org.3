Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329514E5B42
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 23:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345233AbiCWWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbiCWWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 18:32:16 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC378F9B6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:30:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t13so1110690pgn.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kuegp+jO55Es2fDo8uYnNCcqkv5SBF2sv4c9HycY6CM=;
        b=HYy8RfEcJn0cdTzqwpS2rlZi7xnKmbeG+psgdpchzqU/5y+CTsFtVX4rVeEtsVb83D
         hAFNA1M1MtQL9GFDKHiGNlyncPlwKh5GVNrn8g9edkO55gj6nqwVPQ504xJOVnaEYKtq
         8AGKluaPKOdzHMuFDynqtxL9szrRkudj9R+Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kuegp+jO55Es2fDo8uYnNCcqkv5SBF2sv4c9HycY6CM=;
        b=BxbCux5yyMSS01XEC/+3XAYI4kdeHipz+9WuuDJ0iU7tSmQukgJ/BSPemd0U3+5ed+
         S7NmzonQOI2DQpZzK/1rhUXjgZmZCsW9kjDSMVXV6ndx2b53CDatg1GsZiaVjR8Er47b
         zOfePuPvlin1KcqoHVwDaadsfDjLqWovmeV7svyRrjau/9Aw0woSEXHFTmpRg4v34d3J
         F8iCyKVuRgJmDaUyWyApXqXuY5V5oT85hcwJhvjFCVZcyBc8A4uO/JGXyikc319V266H
         HhGwyME3LxmW0PdLB4KmL+CRFLV6twpaYQ18JFV+j0XCndCXqRfOXkoMDQM847MDQ9sT
         oH6w==
X-Gm-Message-State: AOAM531RXIQPKLQMLRA7FxUE1jej76SFgoHrCg9czh2TphgNX2BH+BZv
        n9Tr9MzZlWGCzPwd8s6Cx5J7hw==
X-Google-Smtp-Source: ABdhPJz6ppDgUCCU1EEidVNx0pB3pB42Xh2BRv858RFx8oyIXI6p3k7PGxbYXLcQkfyt+HaBh0l3Ew==
X-Received: by 2002:a05:6a02:101:b0:386:865:44a0 with SMTP id bg1-20020a056a02010100b00386086544a0mr1585953pgb.475.1648074645645;
        Wed, 23 Mar 2022 15:30:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00098f00b004faa58d44eesm839224pfg.145.2022.03.23.15.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:30:45 -0700 (PDT)
Date:   Wed, 23 Mar 2022 15:30:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <oliver.sang@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [scsi]  6aded12b10: kernel_BUG_at_mm/usercopy.c
Message-ID: <202203231529.0CB76344@keescook>
References: <20220320143453.GD6208@xsang-OptiPlex-9020>
 <20220323071409.GA25480@lst.de>
 <202203230809.D63BF9511@keescook>
 <Yjs/6pLB1uDKBRCG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjs/6pLB1uDKBRCG@casper.infradead.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 03:42:34PM +0000, Matthew Wilcox wrote:
> On Wed, Mar 23, 2022 at 08:40:30AM -0700, Kees Cook wrote:
> > On Wed, Mar 23, 2022 at 08:14:10AM +0100, Christoph Hellwig wrote:
> > > The actual warning is;
> > > 
> > > [   34.496096][  T331] usercopy: Kernel memory overwrite attempt detected to spans multiple pages (off set 0, size 6)!
> > > 
> > > This is for the cmnd field in struct scsi_cmnd, which is allocated by
> > > the block layer as part of the request allocator.  So with a specific
> > > packing it can legitimately span pages.
> > > 
> > > Kees: how can we annotate that this is ok?
> > 
> > The main problem is that CONFIG_HARDENED_USERCOPY_PAGESPAN=y is broken
> > (and nothing should be setting it).
> > 
> > This series removes it:
> > https://lore.kernel.org/linux-hardening/20220110231530.665970-1-willy@infradead.org/
> > 
> > Matthew, what's the status of that series? Will it make the current
> > merge window?
> 
> I thought you were going to merge it!  I haven't put it in any of my
> public trees.

LOL. Okay, you'd mentioned another check, so I wasn't sure. I can go
ahead and snag it, but I'll likely wait until the next window and let it
live in -next for a while, unless you think it should get YOLOed in. :)

-Kees

-- 
Kees Cook
