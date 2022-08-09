Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A658D3C2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiHIG3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiHIG33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:29:29 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B251FCF2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 23:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660026568; x=1691562568;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vyIFmtqAbHdY0idNmSeJSH07tqTNSFTVNWQhsfMsQAg=;
  b=iwIGchJxqEkEMq2DoffyTpFgqgX25A+4Wzwvlk8hmNwW+W8ekHk0kHwd
   OTATltamLo1Lm24vjsqAZ1pzE7WuxXrqMH96ed6JQ4wRbWG2R54FesNid
   TqhLIwVzGVwZUEuKmB0pVtFlPwRnx8iq+CNaJqUbG/cKa3ZzowbDSnVfZ
   T9eJuGxjweylR16KK76vtbqInfwgk9dP29ZDdwtOgVbybje3WDS+9arGX
   vTjNLxpnIgWXUYhchh6ewyVcfWqDjtgTd9FHwE2dB8NrFiD3+lf5MOma8
   Pb4j5RLwOwiNmuQuByqgkIiS/6UlXMM4xjqd22jCra43N6OJc66uWhvvW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="292005174"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="292005174"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:29:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="664306799"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO maurocar-mobl2) ([10.252.48.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:29:25 -0700
Date:   Tue, 9 Aug 2022 08:29:22 +0200
From:   Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>
To:     "Vivi, Rodrigo" <rodrigo.vivi@intel.com>
Cc:     "andi.shyti@linux.intel.com" <andi.shyti@linux.intel.com>,
        "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
        "Cheng, Michael" <michael.cheng@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Wilson, Chris P" <chris.p.wilson@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Auld, Matthew" <matthew.auld@intel.com>
Subject: Re: [Intel-gfx] [PATCH v3 1/3] drm/i915: pass a pointer for tlb
 seqno at vma_invalidate_tlb()
Message-ID: <20220809082922.2dbd6c0c@maurocar-mobl2>
In-Reply-To: <aabd5eff13bde62966ca9ad2a483978e4557c55f.camel@intel.com>
References: <cover.1659598090.git.mchehab@kernel.org>
        <f9550e6bacea10131ff40dd8981b69eb9251cdcd.1659598090.git.mchehab@kernel.org>
        <YvE75o0uOtDGayNK@alfio.lan>
        <YvFeLbUcC6yiCL5G@intel.com>
        <YvGXv5td47ky+CnY@alfio.lan>
        <aabd5eff13bde62966ca9ad2a483978e4557c55f.camel@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Aug 2022 00:15:14 +0000
"Vivi, Rodrigo" <rodrigo.vivi@intel.com> wrote:

> On Tue, 2022-08-09 at 01:09 +0200, Andi Shyti wrote:
> > Hi Rodrigo,
> > 
> > On Mon, Aug 08, 2022 at 03:04:13PM -0400, Rodrigo Vivi wrote:
> > > On Mon, Aug 08, 2022 at 06:37:58PM +0200, Andi Shyti wrote:
> > > > Hi Mauro,
> > > > 
> > > > On Thu, Aug 04, 2022 at 09:37:22AM +0200, Mauro Carvalho Chehab
> > > > wrote:
> > > > > WRITE_ONCE() should happen at the original var, not on a local
> > > > > copy of it.
> > > > > 
> > > > > Fixes: 5d36acb7198b ("drm/i915/gt: Batch TLB invalidations")
> > > > > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > > 
> > > > Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> > > 
> > > Thanks and pushed...
> > 
> > Thanks!
> > 
> > > > 
> > > > Are you going to send it to the stable mailing list?
> > > 
> > > I added cc stable while pushing and the cherry-pick to drm-intel-
> > > next-fixes
> > > has the right sha, so I'd assume this would be automagically now.
> > > But yeap, it would be good if Mauro can follow up whenever this
> > > gets
> > > to Linus tree and Greg's script start to pop up the heads-up
> > > messages.
> > 
> > That's what I meant... does Mauro now need to send the e-mail
> > again for the stable?
> > 
> > I thought there was some suspicion towards e-mails pushed without
> > being first sent to both stable and upstream mailing lists
> > because they can get lost or forgotten... maybe I'm wrong.
> 
> It doesn't help to send now to stable ml because it can only be merged
> there after it reaches the Linus' master tree.
> Right now with the right fixes and cc:stable it should be automatically
> and he shouldn't worry.
> But in case he notices that the first patch got in but the second
> didn't then it is when we send the patch directly to the stable ml.

I sent a heads-up to Greg to warn him about the issue. I'll keep my eyes
on the -stable automatic e-mails to double-check that they'll both be
merged altogether.

Thanks!
Mauro

> 
> 
> > 
> > Andi
> > 
> > > Thanks,
> > > Rodrigo.
> > > 
> > > > 
> > > > Andi
> 
