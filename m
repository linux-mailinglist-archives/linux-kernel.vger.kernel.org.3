Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7768596F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiHQNHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbiHQNHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:07:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AEA915F3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741530; x=1692277530;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0r/wRpHDY/cJKimAN46sLg8b9MsBF0hryVYD2PnhY/Y=;
  b=OpJdyNR2bYWw8SkK+futHoY/Y3Eu62ukr3+gskHvdfZije1zGO8uQtwN
   5dAltjLH7+bb/P6ohjy2TtfS4fe0vVQxPlBVn/mhLVRX29XY1NlmqnOUt
   Q+l6aAE53habHzyTIZnzHZLAh5c1OcEcVl++AScv42Qb5kBx5utArN05I
   V1GKQVxaV90LrimxnKKBOrYeqvLJP/g6kS+MeoErLDQmf0uaFOl4MiyDf
   sEQrBGzXBWdlXR/N0eOHq6O9SdUAsVmjQornzKRbMn5T9X64lzodg+Cxm
   tSRlMRV94hl7OwXsAkROdaoDBRsKRowpvBrN+7YcKl4BCACMTQa2b7KFd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="279450522"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="279450522"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:05:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="710542739"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.59])
  by fmsmga002.fm.intel.com with SMTP; 17 Aug 2022 06:05:14 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 17 Aug 2022 16:05:13 +0300
Date:   Wed, 17 Aug 2022 16:05:13 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com,
        Zenghui Yu <yuzenghui@huawei.com>,
        Imre Deak <imre.deak@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Switch TGL-H DP-IN to dGFX when
 it's supported
Message-ID: <YvzniYpjr+PBIa56@intel.com>
References: <20220816025217.618181-1-kai.heng.feng@canonical.com>
 <CACO55tt=Op=0E94kK+1M8cDXNCk5Tkc=FMR8=OQFc5ohehjwaw@mail.gmail.com>
 <CAAd53p49X95MKrTDUq92LuHw3y2i09fUA2HEPzM1EcO8xO97Eg@mail.gmail.com>
 <CACO55tvgmb4Vog701idDYGuh125S9mjWPXhftxDMZ7hg-nQXBw@mail.gmail.com>
 <CAAd53p4W9rjmVJcUasy9hb1Yam+846+Oomvc2r9RMNmWeh_=0w@mail.gmail.com>
 <YvzYGGXils/Gf44d@intel.com>
 <CAAd53p49zc2G1KutPMUcUBM3_rbCh9_40e0mdtcZKb+C69QL_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p49zc2G1KutPMUcUBM3_rbCh9_40e0mdtcZKb+C69QL_Q@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 08:15:58PM +0800, Kai-Heng Feng wrote:
> On Wed, Aug 17, 2022 at 7:59 PM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> 
> [snipped]
> 
> > I had a quick trawl through some Windows stuff for this and
> > it does seem to do a few extra checks:
> > - platform must be TGL-H (nothing else has the DPin stuff I guess)
> > - OpRegion header must indicate dGPU presence
> 
> Is the dGPU presence denoted by the return bitmask of
> INTEL_DSM_FN_GET_BIOS_DATA_FUNCS_SUPPORTED

No, there are apparently some extra bits in the OpRegion
header which we're not currently even decoding.

> 
> IIUC the mask 20 won't be set when dGPU is not present.

Not sure whether that bit would change depending on the dGPU
presence or not. Windows doesn't seem trust it alone, so either
it won't change or someone was just extra paranoid.

> 
> >
> > Otherwise it does call this DSM uncoditionally on boot/S4 resume
> > so seems like that is the only really validated configuration.
> > Although it does seem to explicitly turn off displays prior to
> > the DSM so that does perhaps indicate that those ports might have
> > also been enabled via the iGPU by the BIOS. Not sure if disabling
> > the ports would work correctly after the DSM or not. If not then
> > the DSM call would need to happen after state readout/sanitization
> > so that we can shut things down gracefully.
> >
> > Additionally after the DSM call it scans the FIA TC live state
> > bits to check for DPin usage. Looks like its trying to make sure
> > the driver stops poking at the relevant power wells once in DPin
> > mode. i915 doesn't check that stuff atm so we might end up
> > mangling something while the dGPU is driving the port.
> 
> Thanks for investigating this. I am not really familiar with other
> stuffs you mentioned, but I am happy to test any follow-up patch.
> 
> Kai-Heng
> 
> >
> > --
> > Ville Syrjälä
> > Intel

-- 
Ville Syrjälä
Intel
