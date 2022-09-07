Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9428E5AFC3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiIGGNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIGGNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:13:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CB898D2F;
        Tue,  6 Sep 2022 23:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662531207; x=1694067207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/VLf3zxr7OVGvgGkYCU2+xIEOKPejkhQ9Me6a6V8Gk=;
  b=nZ0E8+wGBtR+TvcDLlBvDhj1EOTonBRpP05nEQvQwXyRqy9ZaUlTgzVs
   6wS/PGAY4ReFDKUG1TxdJzkoPGgH5U7rPTrYfr19KlvWYM3F99X9GxVxQ
   Y2iYa6vPVAMOEVxzJh06AtSGl94oxK73Six/fPVB+lJ8GmdOBwGnxp5Ay
   eCIKzaqXu5QmKmm4mbehvbJqJe2/f63eLKpcPJ+IyAMHbV3eVYWf07nrY
   /XUscA7tpytAdqnnEVDOIjOHKLUhn7XC0p3DA4MqucxIzvb8YcEgTuMpq
   l7ix8WNaF8+aiEAf7oUCLgpSU3ZDnpw5Q4+XUN0NpUb7RVCsAooV9IVn5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283788246"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="283788246"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 23:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="682683724"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2022 23:13:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 56EF8F7; Wed,  7 Sep 2022 09:13:39 +0300 (EEST)
Date:   Wed, 7 Sep 2022 09:13:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Szuying Chen <chensiying21@gmail.com>
Cc:     YehezkelShB@gmail.com, gregkh@linuxfoundation.org,
        mario.limonciello@amd.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yd_Tseng@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw, Richard_Hsu@asmedia.com.tw
Subject: Re: [PATCH v9 0/6] thunderbolt: Add support for ASMedia NVM firmware
 image format
Message-ID: <Yxg2k/iydKbwzcx/@black.fi.intel.com>
References: <20220906101245.6559-1-chensiying21@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906101245.6559-1-chensiying21@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 06, 2022 at 06:12:45PM +0800, Szuying Chen wrote:
> From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> 
> Hi,
> 
> > Hi all,
> > 
> > This series adds support for ASMedia NVM images. It is based on the
> > work of Szuying Chen with a couple of changes from me. The first
> > patches move Intel specific NVM validation into nvm.c and >adds a
> > vendor table for both routers and retimers that can be extended to
> > support different >vendor NVM image formats. Once that is done the
> > ASMedia NVM image format support is added.
> > 
> > The previous version of the patch series can be found here:
> > 
> >   https://lore.kernel.org/linux-usb/20220902094010.2170-1-chensiying21@gmail.com/
> > 
> > Changes from the previous version:
> > 
> >   * Shuffled the ordering of the patches a bit
> >   * Add tb_retimer_nvm_read() and tb_switch_nvm_read()
> >   * Add ->write_headers() callback that is used with Thunderbolt 2
> >     routers
> >   * Cover retimers too
> >   * Minor cleanups and tweaks
> > 
> > I have tested this on Intel Thunderbolt 3 and Thunderbolt 4 routers.
> > ASMedia folks, can you try this also on your side and let me know if it works or not?
> 
> I send a comments in separate email please help to modify it.
> I have tested this on ASMedia USB4 router. It work well.

I fixed the copy paste issue and applied all to thunderbolt.git/next,
thanks!
