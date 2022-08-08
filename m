Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21DB58D062
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 01:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244410AbiHHXKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiHHXJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 19:09:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C418193FF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660000197; x=1691536197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B4DoIHu/xE0J/XUD3RUk+6lgq5c+Oc/6QTYy8pBOzeA=;
  b=VElDkx0v/elddQWm5vy7E9pODH9ovwhFzVAPwbnCgmgoiiVjZzOmTLvC
   efNb+FFw3fdP9i9C5IjyHv7NpAdo3b+/GwythnjWzvYnoi22XF18ichzl
   jP3EIHOiSy+y937vb5XLUqbxSAWp5Mzi3zHlPQaFUHpQexzDFfHEauZLZ
   NGBrrmoWqEaRX+YlNouhTHyHMdXlvhHhrsypOkUxlo7pkHPWwttx3QGZ0
   yxVIdga1xcNR6jYuN1q/CyWhvhuPv7hQjoUmtFbkW6fm+0XyqSvMj5j0T
   QxvDEj+KYY/l/zH+cy/ljwc6QLM9+EMs5xST54CBHznpUiHdeIgmGNqzB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="290716731"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="290716731"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:09:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="664176757"
Received: from mkabdel-mobl.ger.corp.intel.com (HELO intel.com) ([10.249.40.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 16:09:53 -0700
Date:   Tue, 9 Aug 2022 01:09:51 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Andi Shyti <andi.shyti@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Cheng <michael.cheng@intel.com>,
        Thomas =?iso-8859-15?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris.p.wilson@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org,
        Matthew Auld <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH v3 1/3] drm/i915: pass a pointer for tlb
 seqno at vma_invalidate_tlb()
Message-ID: <YvGXv5td47ky+CnY@alfio.lan>
References: <cover.1659598090.git.mchehab@kernel.org>
 <f9550e6bacea10131ff40dd8981b69eb9251cdcd.1659598090.git.mchehab@kernel.org>
 <YvE75o0uOtDGayNK@alfio.lan>
 <YvFeLbUcC6yiCL5G@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvFeLbUcC6yiCL5G@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Mon, Aug 08, 2022 at 03:04:13PM -0400, Rodrigo Vivi wrote:
> On Mon, Aug 08, 2022 at 06:37:58PM +0200, Andi Shyti wrote:
> > Hi Mauro,
> > 
> > On Thu, Aug 04, 2022 at 09:37:22AM +0200, Mauro Carvalho Chehab wrote:
> > > WRITE_ONCE() should happen at the original var, not on a local
> > > copy of it.
> > > 
> > > Fixes: 5d36acb7198b ("drm/i915/gt: Batch TLB invalidations")
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> 
> Thanks and pushed...

Thanks!

> > 
> > Are you going to send it to the stable mailing list?
> 
> I added cc stable while pushing and the cherry-pick to drm-intel-next-fixes
> has the right sha, so I'd assume this would be automagically now.
> But yeap, it would be good if Mauro can follow up whenever this gets
> to Linus tree and Greg's script start to pop up the heads-up messages.

That's what I meant... does Mauro now need to send the e-mail
again for the stable?

I thought there was some suspicion towards e-mails pushed without
being first sent to both stable and upstream mailing lists
because they can get lost or forgotten... maybe I'm wrong.

Andi

> Thanks,
> Rodrigo.
> 
> > 
> > Andi
