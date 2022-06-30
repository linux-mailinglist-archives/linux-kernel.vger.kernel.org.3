Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2685612C7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiF3Gyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiF3Gyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:54:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A50E21822;
        Wed, 29 Jun 2022 23:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EE3EB82604;
        Thu, 30 Jun 2022 06:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD44C34115;
        Thu, 30 Jun 2022 06:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656572073;
        bh=Oc83V9rZVapugamHQO61OIkhuj92VI3JWG+xP2f66GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1OvESiIreK8McHhAazCMjlaRve/btiMWa1cCLYV3LBwK4wT2EA1thwJ+YPOX7HAws
         J5Px8R/MROEDDFlp0zwUdczannrmtN41HFzoKB9SnPjddey/1DImW046/EOq6dxUpm
         cOUq+lScrvqeQV+oYn4E3CI7t0cPlzTm0F4Vgwrw=
Date:   Thu, 30 Jun 2022 08:54:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     pawell@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: Fix potential memory leak in
 cdnsp_alloc_stream_info()
Message-ID: <Yr1IpjRbxNpvpGbR@kroah.com>
References: <20220630005148.2166473-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630005148.2166473-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:51:48AM +0800, Jianglei Nie wrote:
> cdnsp_alloc_stream_info() allocates stream context array for stream_info
> ->stream_ctx_array with cdnsp_alloc_stream_ctx(). When some error occurs,
> stream_info->stream_ctx_array is not released, which will lead to a
> memory leak.
> 
> We can fix it by releasing the stream_info->stream_ctx_array with
> cdnsp_free_stream_ctx() on the error path to avoid the potential memory
> leak.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/usb/cdns3/cdnsp-mem.c | 1 +
>  1 file changed, 1 insertion(+)

What commit id does this fix?

thanks,

greg k-h
