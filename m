Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549455B1840
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiIHJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiIHJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:18:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B946D2B11
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 02:18:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25145B8205A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A24C433D6;
        Thu,  8 Sep 2022 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662628729;
        bh=CdqCZJBl/nD8tWz9C2cg69rsNzcpvtg1+SARQijR/vI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSSGMdJPkAvltnSIff35TEf9g68krlOpCDvgsc1OoS+k3CYikT76RqQsZ7hqnrDdt
         vgt/s6s5sJ9oxM1EzfMWpK5ml0giX3LKW8WNmtVgtcb+JixhX84V7WmTBcyenvRuv1
         U3nOO54NX0ONTRfVvm7jjfyhEhCHqNyibrj1CmwQ=
Date:   Thu, 8 Sep 2022 11:19:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>, alex000young@gmail.com,
        security@kernel.org, dri-devel@lists.freedesktop.org,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, xmzyshypnc <1002992920@qq.com>,
        jani.nikula@linux.intel.com, daniel@ffwll.ch,
        rodrigo.vivi@intel.com, intel-gvt-dev@lists.freedesktop.org,
        zhi.a.wang@intel.com
Subject: Re: [PATCH] drm/i915/gvt: fix double-free bug in split_2MB_gtt_entry.
Message-ID: <Yxmzj2nCoTKurCY8@kroah.com>
References: <tencent_E1BBF05904DFB73C478DCD592740AAE0780A@qq.com>
 <CAJedcCxVW++iH49UFZp9ruUuTcNubWCH6Wsqe11K4COB3E8msg@mail.gmail.com>
 <CAJedcCw1eJqjSK+yR7eQMDheNtH3Mjm+viwt00xAhnmrfpq2pw@mail.gmail.com>
 <CAJedcCweHjD78F7iydiq6Xc2iH=t_3m=H9JKnaCooToUk32FvQ@mail.gmail.com>
 <YxWtfjfpNsoPUrgh@kroah.com>
 <CAJedcCzMo51aiy=Dv7zn7VmL3gwkw7JgzwAPAB2Z27C9CnhoYA@mail.gmail.com>
 <20220907030754.GU1089@zhen-hp.sh.intel.com>
 <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJedcCxO_Rq0qMeLiHtY5+FuN1A1pDGsZd3gMtvUpm1xbAK3aA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 05:09:40PM +0800, Zheng Hacker wrote:
> Hi Zhenyu,
> 
> This issue has been open for a few days. Could you plz write a patch
> for that :) I'm not familiar with the logical code here.

As this is only able to be hit in a theoretical system, it isn't that
high of a priority, if any priority at all.  Why not try to write a
patch for it yourself to help resolve the issue faster?

thanks,

greg k-h
