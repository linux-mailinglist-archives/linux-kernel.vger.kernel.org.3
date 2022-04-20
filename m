Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C471508D83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380685AbiDTQoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380608AbiDTQoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:44:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186351C931
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A94B0619F3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:41:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A163C385A1;
        Wed, 20 Apr 2022 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650472889;
        bh=0jGEShzA7BDA9BjXcsM5j4+M5Zwl/bVzaAJeee2fzBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvPM998HcXX5mBLfEzmQvOhTZekvLEGIPiTRfgKKsP+immVQ06fieB7sqLGyiMhHv
         c3o9rXVNIeHbRyKktX3416YEJskhMn1qA2bP9yaafW5zwCm7SQoLm90j5fxlvsK5KV
         9etObSS1A3QUfI62GkKYKk3VHlDp22hmR+u4HCjA=
Date:   Wed, 20 Apr 2022 18:41:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] staging: rtl8192e: Fix signedness bug in
 rtllib_rx_assoc_resp()
Message-ID: <YmA3ttZal8Bwlp7P@kroah.com>
References: <20220415065810.GQ3293@kadam>
 <1650007296-31508-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650007296-31508-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 03:21:35PM +0800, Haowen Bai wrote:
> The rtllib_rx_assoc_resp() function has a signedness bug because it's
> a declared as a u16 but it return -ENOMEM.  When you look at it more
> closely it returns a mix of error codes including 0xcafe, -ENOMEM, and
> a->status which is WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG.  This is a mess.
> 
> Clean it up to just return standard kernel error codes.  We can print
> out the a->status before returning a regular error code.  The printks
> in the caller need to be adjusted as well.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: reduce return random value; print its own error message.
> V2->V3: change commit message; change s16 -> int.
> V3->V4: add message suggested by Dan Carpenter. If you look up what 
> a->status is, it can only be WLAN_STATUS_NOT_SUPPORTED_AUTH_ALG which 
> is not worth preserving really.

I see 3 different v4 patches.  Obviously something went wrong, please
submit a new one, and properly number it and say what changed between
them all.

thanks,

greg k-h
