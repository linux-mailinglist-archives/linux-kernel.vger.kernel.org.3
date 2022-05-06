Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7551C51DC7A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443124AbiEFPsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442930AbiEFPsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:48:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD356D85F;
        Fri,  6 May 2022 08:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651851891; x=1683387891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nyZ5t8pD3rFxQXXz8gDpvzek8yDDoj/KX1ArnB2/pcM=;
  b=j0QDWj1uqgYKDMPFQDudQ4+fqP3w1GcWSbxWyATSAgDkpJDmivBZb/k6
   EHoJ83AdhIpRWIacYPKMn8YnpIO4GqknJCsxKSp+pamCHwuONvF2L9Pnp
   ndP8egJrqnvafGr8iFcWfJUe+8+h+NcrEEmTQSKgSmwRllOylp5ElznnK
   UFkqS6OUiY/xiMS6hVuI65MEbo6rTJwiPjtyf+vy/sICRc5kF2Op0sGo8
   qVOF0ZeoneuxPUWAWLRkdKHTnJhBX1jJj3W+u0zix3twyLYJ1/HXCElOA
   nLAsFIvoVbTIKWk8BzVrx0dGsqTV9mCSKegiFCih6Opy4H+N5cCPD9pAs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="255984466"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255984466"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:44:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="586039009"
Received: from hbourgeo-mobl2.ger.corp.intel.com (HELO intel.com) ([10.249.35.81])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:44:48 -0700
Date:   Fri, 6 May 2022 17:44:44 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Peter Jones <pjones@redhat.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [Intel-gfx] [PATCH] fbdev: efifb: Fix a use-after-free due early
 fb_info cleanup
Message-ID: <YnVCbJJ5DmhkD5WA@intel.intel>
References: <20220506132225.588379-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506132225.588379-1-javierm@redhat.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Fri, May 06, 2022 at 03:22:25PM +0200, Javier Martinez Canillas wrote:
> Commit d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather
> than .remove") attempted to fix a use-after-free error due driver freeing
> the fb_info in the .remove handler instead of doing it in .fb_destroy.
> 
> But ironically that change introduced yet another use-after-free since the
> fb_info was still used after the free.
> 
> This should fix for good by freeing the fb_info at the end of the handler.
> 
> Fixes: d258d00fb9c7 ("fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove")
> Reported-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Reported-by: Andrzej Hajda <andrzej.hajda@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Andi
