Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF84E6635
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351336AbiCXPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242256AbiCXPn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703EBE2C;
        Thu, 24 Mar 2022 08:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F213661834;
        Thu, 24 Mar 2022 15:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5703C340EC;
        Thu, 24 Mar 2022 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648136515;
        bh=doZwDOyg5aAln9B5DrZ3TY24Ms37FN+svJ7hBf9kLOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D2es6RjpWpnvAYmQBArcDtITQiqCqQkxdHOTn+VLib8RpjRqoz7Bk42YaQeIkW4B+
         YV4riix7mFJO6aTCfBltJ+fHD9NcvbmSVUgVRccYTsAThnjUvTUElpQVWLkEmXn3XP
         0KARQD6J5sux0XLqkyQczgxTdKj6a0blrlIj64sjOTOnkhpG5IQOzN1na+sGcth01V
         BHerFSDNphjfIgtjIwzEyNtiuKx5MEFUnf8zYDfP5QxivQK6NnsEXMMHf83nTw7iCV
         0JmhQp4Rh9K55bYoS3LHd/KRXZDaoGGhW53QMIr6NdwapjmHHWkxiYfwY5Yfp7IlAG
         xZBPVqEuXQxJA==
Date:   Thu, 24 Mar 2022 21:11:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [REPOST PATCH v4 07/13] drm/msm/disp/dpu1: Add support for DSC
 in encoder
Message-ID: <YjyRPhdoiLw4gOtD@matsya>
References: <20220210103423.271016-1-vkoul@kernel.org>
 <20220210103423.271016-8-vkoul@kernel.org>
 <20220217223239.2i256klkbjkogovz@SoMainline.org>
 <YjsxaJrvxgtO5ecC@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjsxaJrvxgtO5ecC@matsya>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-22, 20:10, Vinod Koul wrote:
> On 17-02-22, 23:32, Marijn Suijten wrote:
> > On 2022-02-10 16:04:17, Vinod Koul wrote:

> > > +
> > > +	slice_count = dsc->drm->slice_count;
> > > +	slice_per_intf = DIV_ROUND_UP(width, dsc->drm->slice_width);
> > > +
> > > +	/*
> > > +	 * If slice_count is greater than slice_per_intf then default to 1.
> > > +	 * This can happen during partial update.
> > > +	 */
> > > +	if (slice_count > slice_per_intf)
> > > +		slice_count = 1;
> > > +
> > > +	bytes_in_slice = DIV_ROUND_UP(dsc->drm->slice_width *
> > > +				      dsc->drm->bits_per_pixel, 8);
> > > +	total_bytes_per_intf = bytes_in_slice * slice_per_intf;
> > > +
> > > +	dsc->eol_byte_num = total_bytes_per_intf % 3;
> > > +	dsc->pclk_per_line =  DIV_ROUND_UP(total_bytes_per_intf, 3);
> > > +	dsc->bytes_in_slice = bytes_in_slice;
> > > +	dsc->bytes_per_pkt = bytes_in_slice * slice_count;
> > > +	dsc->pkt_per_line = slice_per_intf / slice_count;
> > > +}
> > 
> > I've seen the same calculations duplicated twice in dsi code.  Since the
> > msm_display_dsc_config struct is available in a header, perhaps a single
> > - easily reviewable and maintainable - calculation function should be
> > available there too?
> 
> Let me try check if we can make it common..

I rechecked and we can actually remove this as we do this caln in timing
and update the dsc structure there. So this fn is dropped now

-- 
~Vinod
