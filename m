Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9D575079
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiGNOMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiGNOM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:12:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A084D82D;
        Thu, 14 Jul 2022 07:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 067A7B823A9;
        Thu, 14 Jul 2022 14:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE83C34114;
        Thu, 14 Jul 2022 14:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807938;
        bh=mvlJ0wufsEtTo9Dxhf5723LkQmjzyNDzx5teMH2feS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIGl/Cm8qgB4JLLdsP8ojS41VS2bqdX3a1mPi6QqeLmVXUo/qWZeFMjdB93qjxr05
         6i0JdXmd5WGoKQQ+ihQgQRIYqzeOCA0q53C8VqEOC71H83ChLM7GYGmk6SpPMEbHIR
         2jor24XWNoMEprj+483v8ZXQ2MJfKRGA4SniilZs=
Date:   Thu, 14 Jul 2022 16:01:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     pawell@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: Fix potential memory leak in
 cdnsp_alloc_stream_info()
Message-ID: <YtAhzxPihYcqrs1e@kroah.com>
References: <20220630005148.2166473-1-niejianglei2021@163.com>
 <Yr1IpjRbxNpvpGbR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1IpjRbxNpvpGbR@kroah.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:54:30AM +0200, Greg KH wrote:
> On Thu, Jun 30, 2022 at 08:51:48AM +0800, Jianglei Nie wrote:
> > cdnsp_alloc_stream_info() allocates stream context array for stream_info
> > ->stream_ctx_array with cdnsp_alloc_stream_ctx(). When some error occurs,
> > stream_info->stream_ctx_array is not released, which will lead to a
> > memory leak.
> > 
> > We can fix it by releasing the stream_info->stream_ctx_array with
> > cdnsp_free_stream_ctx() on the error path to avoid the potential memory
> > leak.
> > 
> > Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> > ---
> >  drivers/usb/cdns3/cdnsp-mem.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> What commit id does this fix?

Dropped due to lack of response.

greg k-h
