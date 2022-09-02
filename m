Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6065AB1C7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236820AbiIBNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbiIBNjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8284D15C7B2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:17:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1784E62049
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 13:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8696C433D7;
        Fri,  2 Sep 2022 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662124223;
        bh=gyQWuNAPc+74rM0aS1MSJ4QJ6RbXShDyHWLyEiqRoQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQKn+VJGtrWnpB6WqDuCC3FzieeagB+gNRGChxvz9oDHXXmx2mDyYRnP3ZpCGjJUE
         hl7HBTss0CYdoTojxOhXu5oOiQljkG7Ke505YsbMeEwg8Vji18MsaotJ9qLIt/nOCC
         QNKvcStOo+s3Syd2kweL/NO710tSkB+KG4AQs0tk=
Date:   Fri, 2 Sep 2022 15:10:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deuc her <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com
Cc:     linux-kernel@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
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
Message-ID: <YxIAvHOK7uNum9VI@kroah.com>
References: <20220902130105.139138-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902130105.139138-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:01:05PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  Fix this up by properly
> calling dput().
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Wayne Lin <Wayne.Lin@amd.com>
> Cc: hersen wu <hersenxs.wu@amd.com>
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> Cc: Thelford Williams <tdwilliamsiv@gmail.com>
> Cc: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Cc: Yongzhi Liu <lyz_cs@pku.edu.cn>
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Cc: Bhanuprakash Modem <bhanuprakash.modem@intel.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Despite a zillion cc: items, I forgot to cc: stable on this.  Can the
maintainer add that here, or do you all want me to resend it with that
item added?

thanks,

greg k-h
