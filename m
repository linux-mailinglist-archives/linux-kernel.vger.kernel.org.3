Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D329F4EE0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiCaSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiCaShh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:37:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266642359E5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:35:42 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id c2so450253pga.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=tNeFkTR9DpNZ/sYrUJuAKvoLFFRWaFO5MwAeYZZpegY=;
        b=Z2ogAaxkds1pGXjfSPCItUJCgR8MxcFpQqVxWukZkqOb0TYB/fQwPXV8XnUZlMxHD7
         e2h2ZsDBlyvyiL+PE3CQY7hKYDehow4COfLsRboHHa2eJfSmaPKFt/48/V1NGCiIEt2T
         cZg4frkbR+l2bal3IhjLmtrWfHaC5Ib95lw+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tNeFkTR9DpNZ/sYrUJuAKvoLFFRWaFO5MwAeYZZpegY=;
        b=LW027bj+puaxBrqWBAp1ErXTKnXbEu836SFSm5JVGSEJbQpTEuTfPFrSVUyXalhLsa
         IbERk5EsCfYr92fHkzJM00smKgD5SUK13zlw65q3pz3wPr2zZiyjvKhb8WMTJWcLvFDK
         HwdzhSXmhg/c7MYk/rfdU9MfDXjA03uxYQC257yP+Y1C/idfuan0NEZV1zZWMmrjtxNP
         GpTzax4M/RBu/etv0dD8+Sz19++hwD7AaiPIrV59dnyeGYjMGDs6wv5U4L2PvgtEiM8J
         SLjxKDilyHR2FGILcgxEEukIAeWqF3Kq4MTtzK6lMUO4aEQPeHDGZrDnbrb/irMAYb6T
         Bf0w==
X-Gm-Message-State: AOAM533jXF9lM7lBzdAAQT2w1G5seSq+9kHvITefl6JWxvOLz4GRxTfR
        cF+fqV58uzLFZeoPxzXwZSilSQ==
X-Google-Smtp-Source: ABdhPJwQNYW5GcaTS+SUl9vxr9XpNUKSOH893YtYvCPVctKCmmEWe8MgBLrtCuqTnouYMuJlg4IXBg==
X-Received: by 2002:a63:fb44:0:b0:372:9ec8:745a with SMTP id w4-20020a63fb44000000b003729ec8745amr11635174pgj.551.1648751741288;
        Thu, 31 Mar 2022 11:35:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bt15-20020a056a00438f00b004fb6a6af05dsm155152pfb.187.2022.03.31.11.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:35:40 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:35:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
Subject: [GIT PULL] hardening fixes for v5.18-rc1
Message-ID: <202203311127.503A3110@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening fixes for v5.18-rc1. This addresses an
-Warray-bounds warning found under a few ARM defconfigs, and disables
long-broken CONFIG_HARDENED_USERCOPY_PAGESPAN.

Thanks!

-Kees

The following changes since commit afcf5441b9ff22ac57244cd45ff102ebc2e32d1a:

  arm64: Add gcc Shadow Call Stack support (2022-03-10 09:22:09 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v5.18-rc1-fix1

for you to fetch changes up to 229a08a4f4e4f9949801cc39b6480ddc9c487183:

  ARM/dma-mapping: Remove CMA code when not built with CMA (2022-03-31 11:19:25 -0700)

----------------------------------------------------------------
hardening updates for v5.18-rc1-fix1

- Disable CONFIG_HARDENED_USERCOPY_PAGESPAN

- DMA: remove CMA code when not buiding CMA

----------------------------------------------------------------
Kees Cook (2):
      usercopy: Disable CONFIG_HARDENED_USERCOPY_PAGESPAN
      ARM/dma-mapping: Remove CMA code when not built with CMA

 arch/arm/mm/dma-mapping.c | 2 ++
 arch/arm/mm/mm.h          | 4 ++++
 include/linux/cma.h       | 4 ----
 security/Kconfig          | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

-- 
Kees Cook
