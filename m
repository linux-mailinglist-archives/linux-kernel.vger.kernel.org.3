Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37945293DC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349123AbiEPWyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 18:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiEPWyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 18:54:36 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14023419AA
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 15:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652741675; x=1684277675;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mA98VrZe/rix7Ydo+Yw58bcGuuP+5pWFws31EDCu4pc=;
  b=Bg3ziZ0P58ra6PUrfWUvcKqaFaqVEuR2T2ipwShJMRFQOvatfUc0SJkO
   ogQg8vhyggZjMhtv7v4M3UcaYDPBfEuFke32u4HlL7G3jvdt7rCBz/VJ3
   MuWnCtyv5tIUT/3GIAD5qW+wHWlcEuBO5h/SUDm5ShBZCun/QHOJ6orgH
   DMn1DQTbGP7u/jB3qpXf8xF4CB8NdyO3wE4Ixe0q17cD1GumvC4ypRvhy
   IquD8K2rEQChbj4ySw64xIuaoUuAu4+wbGRixJv7EM+LFCw4sAYVT8A5w
   A24CMZoWbvawQ9FS73akyIINLvagvcomyxDx2f8iGiKLn3pZreX0Mnyuq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="331602921"
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="331602921"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 15:54:33 -0700
X-IronPort-AV: E=Sophos;i="5.91,231,1647327600"; 
   d="scan'208";a="544585021"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 15:54:33 -0700
Date:   Mon, 16 May 2022 15:58:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Ning Sun <ning.sun@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 6/7] x86/boot/tboot: Move tboot_force_iommu() to Intel
 IOMMU
Message-ID: <20220516155822.6130dd03@jacob-builder>
In-Reply-To: <20220516180628.GL1343366@nvidia.com>
References: <20220514014322.2927339-1-baolu.lu@linux.intel.com>
        <20220514014322.2927339-7-baolu.lu@linux.intel.com>
        <20220516180628.GL1343366@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, 16 May 2022 15:06:28 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> Unrelated, but when we are in the special secure IOMMU modes, do we
> force ATS off? Specifically does the IOMMU reject TLPs that are marked
> as translated?
Yes, VT-d context entry has a Device TLB Enable bit, if 0, it means
"Translation Requests (with or without PASID) and Translated Requests
received and processed through this scalable-mode context-entry are
blocked."

Thanks,

Jacob
