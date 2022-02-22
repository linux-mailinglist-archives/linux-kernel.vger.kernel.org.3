Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F3E4BEED2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 02:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbiBVAmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 19:42:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiBVAmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 19:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDD255B2;
        Mon, 21 Feb 2022 16:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B20C5B816FB;
        Tue, 22 Feb 2022 00:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1340CC340E9;
        Tue, 22 Feb 2022 00:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645490512;
        bh=IELOXQyVJAFo5UdAD8Yr5sUxke47bf1fgOMma60bkAc=;
        h=From:To:Cc:Subject:Date:From;
        b=cLlQqg6/YHrSI2FFKsNhdc7lvW6iiZR4lPQopFrZkkz8XbrTZEr+rbdPl5r6ty0UX
         /rwvK+bHez4M+NtS4E4911O4rhcWpQuwKiKwsQONN2AIfz9E9QLOUyYG1pZT1yfaqZ
         Cros8dWt3VaRPe9pngdKUKWplOyttoPGnPIEUJ+ORjOpTVIxEap0RQFYQ3LvUQmuDD
         QhvXOjDWdNm6ppOc4+vizTwD7MjHHcnEpLi6KtsW5CwDMDyUMEFBWpO+0nyjX2bwlQ
         MN2jRDfeE1KPJWs+at0ejJ8UTpjPkITTevlNh/nMi03R5T9F7rVVglqcFriyucDooO
         D/5xP+iU0KYlw==
From:   broonie@kernel.org
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: linux-next: manual merge of the folio tree with the drm-intel tree
Date:   Tue, 22 Feb 2022 00:41:47 +0000
Message-Id: <20220222004147.3360596-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  drivers/gpu/drm/drm_cache.c

between commit:

  7938f4218168a ("dma-buf-map: Rename to iosys-map")

from the drm-intel tree and commit:

  96160c2f78bd1 ("mm: don't include <linux/memremap.h> in <linux/mm.h>")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/drm_cache.c
index 4b0da6baff78e,50b8a088f763a..0000000000000
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@@ -27,11 -27,11 +27,11 @@@
  /*
   * Authors: Thomas Hellström <thomas-at-tungstengraphics-dot-com>
   */
- 
 -#include <linux/dma-buf-map.h>
 +#include <linux/cc_platform.h>
  #include <linux/export.h>
  #include <linux/highmem.h>
 -#include <linux/cc_platform.h>
+ #include <linux/ioport.h>
 +#include <linux/iosys-map.h>
  #include <xen/xen.h>
  
  #include <drm/drm_cache.h>
