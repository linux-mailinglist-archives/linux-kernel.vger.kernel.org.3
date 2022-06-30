Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29C25612B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbiF3GsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiF3GsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:48:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A93B6;
        Wed, 29 Jun 2022 23:48:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 881A0B82894;
        Thu, 30 Jun 2022 06:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3F1C341CC;
        Thu, 30 Jun 2022 06:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656571683;
        bh=ZmAMu0njF2Bpk/IC0ycI008YD7CsYeOiDoicHzoH9u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kj6+M29Kbq3DuqjW/N5FyqDeZrXnQcTQxF3F8axdJiQ4ZzSylpSJxatZ8A43ZYu8m
         Sm0/VdPemmcZ5MH98lnTs/t/YKJIBB2BEkghAFut7X0mdQ6qM7QoQBxr+sVMqe5GEb
         +bYXDjFCVT/C4U9/iBqbd1TWWoeoOWIRsLW4RBVg=
Date:   Thu, 30 Jun 2022 08:48:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jianglei Nie <niejianglei2021@163.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci: Fix potential memory leak in
 xhci_alloc_stream_info()
Message-ID: <Yr1HIPIMPHuH7Unv@kroah.com>
References: <20220630011008.2167298-1-niejianglei2021@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630011008.2167298-1-niejianglei2021@163.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 09:10:08AM +0800, Jianglei Nie wrote:
> xhci_alloc_stream_info() allocates stream context array for stream_info
> ->stream_ctx_array with xhci_alloc_stream_ctx(). When some error occurs,
> stream_info->stream_ctx_array is not released, which will lead to a
> memory leak.
> 
> We can fix it by releasing the stream_info->stream_ctx_array with
> xhci_free_stream_ctx() on the error path to avoid the potential memory
> leak.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>  drivers/usb/host/xhci-mem.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
