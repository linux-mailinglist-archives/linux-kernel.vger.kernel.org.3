Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA474FBE88
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347011AbiDKOQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347006AbiDKOQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014142DF3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=C8NDoDyqZvQBoGqfHeb040RcvsP4vUZqRpM2TBpIVh8=; b=eiX8fUOyFg6kzfTVNVUmza6+Wx
        fBpDqSkeDwGoweT9Gegf39Lu+hcA9AEK7M0rJjLjDJ/0P++isIIMCySrNTfdDemwdSYiGsoyTKse+
        3vU/9Rt1cgUtBDEL89e+7IT2rKSvVrMeExsmLo0OVnp1doIS5kW3FZ4Ct5EvZo+Pu5dNTUBDrsh98
        rLHkxtElLCRXdxm8gcx1WjtoLuZELubYs+3Wik8Z+DrpeOF5VOSiFNRzamhJaLi9ktGhu0sm8FR/t
        S5fz45rALbWHMNr/VHE9IuLEIDAtp9FyMbgEWWay7tIy3fzPObh/g0KODsowLXaOsXhzdfp58N9o+
        UZnXs90g==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndunw-009KHC-IW; Mon, 11 Apr 2022 14:14:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: refactor the i915 GVT support and move to the modern mdev API v3
Date:   Mon, 11 Apr 2022 16:13:29 +0200
Message-Id: <20220411141403.86980-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the GVT code in the i915 is a bit of a mess right now due to strange
abstractions and lots of indirect calls.  This series refactors various
bits to clean that up.  The main user visible change is that almost all
of the GVT code moves out of the main i915 driver and into the kvmgt
module.

Tested on my Thinkpad with a Kaby Lake CPU and integrated graphics.

Git tree:

    git://git.infradead.org/users/hch/misc.git i915-gvt

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/i915-gvt

Changes since v2:
 - rebased on top of Linx 5.18-rc +
   "Refactor GVT-g MMIO tracking table and handlers"
 - don't fold the gvt Makefile into the main Makefile
 - add the mdev patches to remove the legacy interface that is now
   unused to the end of the series

Changes since v1:
 - rebased on Linux 5.15
 - allow the kvmgvt module to be loaded at any time and thus solve
   the deadlock when both i915 amd kvmgvt are modular
 - include the conversion to the modern mdev API

Note that I do expect to rebased this again against 5.16-rc1 once
released, but I'd like to get this out for review ASAP.

Diffstat:
 b/drivers/gpu/drm/i915/Kconfig          |   33 
 b/drivers/gpu/drm/i915/Makefile         |   31 
 b/drivers/gpu/drm/i915/gvt/cfg_space.c  |   89 --
 b/drivers/gpu/drm/i915/gvt/cmd_parser.c |    4 
 b/drivers/gpu/drm/i915/gvt/dmabuf.c     |   36 -
 b/drivers/gpu/drm/i915/gvt/execlist.c   |   12 
 b/drivers/gpu/drm/i915/gvt/gtt.c        |   55 +
 b/drivers/gpu/drm/i915/gvt/gvt.h        |  125 ++-
 b/drivers/gpu/drm/i915/gvt/interrupt.c  |   38 +
 b/drivers/gpu/drm/i915/gvt/kvmgt.c      | 1099 +++++++++++++++-----------------
 b/drivers/gpu/drm/i915/gvt/mmio.c       |    4 
 b/drivers/gpu/drm/i915/gvt/opregion.c   |  148 ----
 b/drivers/gpu/drm/i915/gvt/page_track.c |    8 
 b/drivers/gpu/drm/i915/gvt/scheduler.c  |   37 -
 b/drivers/gpu/drm/i915/gvt/trace.h      |    2 
 b/drivers/gpu/drm/i915/gvt/vgpu.c       |   22 
 b/drivers/gpu/drm/i915/i915_drv.c       |    7 
 b/drivers/gpu/drm/i915/i915_drv.h       |    1 
 b/drivers/gpu/drm/i915/i915_trace.h     |    1 
 b/drivers/gpu/drm/i915/intel_gvt.c      |  162 +++-
 b/drivers/gpu/drm/i915/intel_gvt.h      |   17 
 drivers/gpu/drm/i915/gvt/Makefile       |    9 
 drivers/gpu/drm/i915/gvt/gvt.c          |  340 ---------
 drivers/gpu/drm/i915/gvt/hypercall.h    |   82 --
 drivers/gpu/drm/i915/gvt/mpt.h          |  400 -----------
 25 files changed, 929 insertions(+), 1833 deletions(-)
