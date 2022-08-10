Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE358EC9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiHJM7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiHJM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:58:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CA672872;
        Wed, 10 Aug 2022 05:58:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD0E2B81C5A;
        Wed, 10 Aug 2022 12:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B2FC433D6;
        Wed, 10 Aug 2022 12:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660136314;
        bh=zJTyKc9bsQ4IOOGvSmJc+/Fq4ZNxCf7iPND1dV2N8ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2eOuKErBZztkAEPPtbPXBuSnHdUdCNy6wnloytiravFZcSxtwv5CewUYXYoUhtgPj
         BT3f1Ujk+GgaZ564pQK7ZlGq3sSimk0Gifj9H1RoMMfZur/s6b/ixLxnE+E3T53KMq
         a84HUt7H8s+xnbUCm/M569aaQ53DdFLG4q4O14Yc=
Date:   Wed, 10 Aug 2022 14:58:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rondreis <linhaoguo86@gmail.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux version v5.18 warn in alloc_ep_req
Message-ID: <YvOrd/HYBNZyD1an@kroah.com>
References: <CAB7eexJcUuLm10m-Yd9PVnHt1VvaPQzCBkoiFv1uKTR=0O=KsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB7eexJcUuLm10m-Yd9PVnHt1VvaPQzCBkoiFv1uKTR=0O=KsQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 08:53:43PM +0800, Rondreis wrote:
> Hello,
> 
> When fuzzing the Linux kernel driver v5.18.0, the following crash was triggered.

Your report below says 5.19-rc4, not 5.18.0.

> HEAD commit: 4b0986a3613c92f4ec1bdc7f60ec66fea135991f (HEAD, tag: v5.18)
> git tree: upstream
> 
> kernel config: https://pastebin.com/KecL2gaG
> C reproducer: https://pastebin.com/sh8uUVpV
> console output: https://pastebin.com/yV0hwZSi
> 
> Basically, in the c reproducer, we use the gadget module to emulate
> the process of attaching a usb device (vendor id: 0x13d3, product
> id:0x3333, with function: midi).
> To reproduce this crash, we utilize a third-party library to emulate
> the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
> Just clone this repository, make install it, and compile the c
> reproducer with ``` gcc crash.c -lusbgx -o crash ``` will do the
> trick.
> 
> It seems that when calling a pre-allocate write usb requests to use on
> f_midi_transmit, kernel will eventually call alloc_ep_req function,
> and a failed kmalloc allocation on the buffer filed within use_request
> struct will cause this error happen.

Great, now that you have a reproducer and a way to trigger it, can you
send a patch to fix the issue as well?

thanks,

greg k-h
