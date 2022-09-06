Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20005AF042
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiIFQUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbiIFQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:20:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF3086FF6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDF661479
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044A3C433D7;
        Tue,  6 Sep 2022 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662479357;
        bh=/bYSUBxiS/WRbTkvLJc3pRlr8II9MNaiuiZYqjjRNbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWkQtzUdMSpQhI24kRSAcctKM38+euqqU0QgokzDtCIibpEuNGXxYxIPQs3Ncwarn
         7zgeDQ3Rh0AnyF5jMrswoIdmLBL6BF2BEPDErZ3reBnk+NF4pdht33BVNOK3NviuRa
         ClFX44OCzgq14sgNhT05h7cZQ28DqHFeI1/KCXfE=
Date:   Tue, 6 Sep 2022 17:49:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deuc her <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Thelford Williams <tdwilliamsiv@gmail.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Yongzhi Liu <lyz_cs@pku.edu.cn>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: fix memory leak when using
 debugfs_lookup()
Message-ID: <Yxdr+tMkpEK4HHJT@kroah.com>
References: <20220902130105.139138-1-gregkh@linuxfoundation.org>
 <YxIAvHOK7uNum9VI@kroah.com>
 <5f29a2e1-4ecb-9f94-1e57-f7d8d3c7afb2@amd.com>
 <YxdiBRCmhlrRxAz5@kroah.com>
 <67fe15fc-bd6a-5eee-4359-5d6244db54ef@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67fe15fc-bd6a-5eee-4359-5d6244db54ef@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:39:44AM -0400, Rodrigo Siqueira Jordao wrote:
> 
> 
> On 2022-09-06 11:06, Greg Kroah-Hartman wrote:
> > On Tue, Sep 06, 2022 at 10:52:28AM -0400, Rodrigo Siqueira Jordao wrote:
> > > 
> > > 
> > > On 2022-09-02 09:10, Greg Kroah-Hartman wrote:
> > > > On Fri, Sep 02, 2022 at 03:01:05PM +0200, Greg Kroah-Hartman wrote:
> > > > > When calling debugfs_lookup() the result must have dput() called on it,
> > > > > otherwise the memory will leak over time.  Fix this up by properly
> > > > > calling dput().
> > > > > 
> > > > > Cc: Harry Wentland <harry.wentland@amd.com>
> > > > > Cc: Leo Li <sunpeng.li@amd.com>
> > > > > Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: "Christian König" <christian.koenig@amd.com>
> > > > > Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> > > > > Cc: David Airlie <airlied@linux.ie>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > > Cc: Wayne Lin <Wayne.Lin@amd.com>
> > > > > Cc: hersen wu <hersenxs.wu@amd.com>
> > > > > Cc: Wenjing Liu <wenjing.liu@amd.com>
> > > > > Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > > > > Cc: Thelford Williams <tdwilliamsiv@gmail.com>
> > > > > Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > > > > Cc: Yongzhi Liu <lyz_cs@pku.edu.cn>
> > > > > Cc: Mikita Lipski <mikita.lipski@amd.com>
> > > > > Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> > > > > Cc: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
> > > > > Cc: Sean Paul <seanpaul@chromium.org>
> > > > > Cc: amd-gfx@lists.freedesktop.org
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > ---
> > > > 
> > > > Despite a zillion cc: items, I forgot to cc: stable on this.  Can the
> > > > maintainer add that here, or do you all want me to resend it with that
> > > > item added?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Hi Greg,
> > > 
> > > Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > 
> > > Is 'Cc: stable@vger.kernel.org' enough here? I can make this change before I
> > > merge it into amd-staging-drm-next.
> > 
> > Yes, please add the cc: stable@ line to the body of the patch, sorry I
> > forgot that.
> > 
> 
> Change applied to amd-staging-drm-next, with the Cc to the stable branch.

Wonderful, thanks!
