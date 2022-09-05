Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5815ACD64
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiIEIEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236971AbiIEIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:04:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694B47BA6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 01:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA3476113E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 08:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A350AC433D6;
        Mon,  5 Sep 2022 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662365057;
        bh=ZviM3XQ2DcMV3uk7a7yxPjcP+JOLn+NSZCdFHlInwuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDuXJgJ/tP3RSsm/7imHBc/Vd0Qlz/CuALQErsD1g1FZNdNo7l1LNgbYOdnREqrZs
         Gl6QXF+9ALdBybSasdsVT+9FKbHk2JjlOdT4kdYmAp7koRZbH7r6MuC1+fnz0rV6Yn
         bcSzBHv8ARR0pQ1uMZe5l0j/3FI18MI3TYPv+N1A=
Date:   Mon, 5 Sep 2022 10:04:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     xmzyshypnc <1002992920@qq.com>, airlied@linux.ie, daniel@ffwll.ch,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        alex000young@gmail.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
Message-ID: <YxWtfjfpNsoPUrgh@kroah.com>
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 03:46:09PM +0800, Zheng Hacker wrote:
> I rewrote the letter. Hope it works.
> 
> There is a double-free security bug in split_2MB_gtt_entry.
> 
> Here is a calling chain :
> ppgtt_populate_spt->ppgtt_populate_shadow_entry->split_2MB_gtt_entry.
> If intel_gvt_dma_map_guest_page failed, it will call
> ppgtt_invalidate_spt, which will finally call ppgtt_free_spt and
> kfree(spt). But the caller does not notice that, and it will call
> ppgtt_free_spt again in error path.
> 
> Fix this by returning the result of ppgtt_invalidate_spt to split_2MB_gtt_entry.
> 
> Signed-off-by: Zheng Wang
> 
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index ce0eb03709c3..9f14fded8c0c 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1215,7 +1215,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
>                 ret = intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_index,
>                                                    PAGE_SIZE, &dma_addr);
>                 if (ret) {
> -                       ppgtt_invalidate_spt(spt);
> +                       ret = ppgtt_invalidate_spt(spt);
>                         return ret;

But now you just lost the original error, shouldn't this succeed even if
intel_gvt_dma_map_guest_page() failed?

And how are you causing intel_gvt_dma_map_guest_page() to fail in a real
system?

thanks,

greg k-h
