Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596974B85E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBPKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:36:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiBPKgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D1965F8;
        Wed, 16 Feb 2022 02:36:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C78966197F;
        Wed, 16 Feb 2022 10:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F406C004E1;
        Wed, 16 Feb 2022 10:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645007795;
        bh=7vyvE44KD4wwP3WaOdcKYQykL1+Q5lIEa0k28fE0Z1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2pgzuVznt4LOGYWVP7ib1zPf5LD+pa7GUTVAGvUraZfWQPz/KW6eTTHJ/M6hBCE7E
         fT0LwBgSQ05X3xxVDbwCAlAdDwXdKqT7DOgnDODVvFfvD6EOYYCLZTrEQXYpNEBaHh
         z97uexsghJfPhJwVL7qgqXrxxW7Id/TVOfGlLrw8=
Date:   Wed, 16 Feb 2022 11:36:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     balbi@kernel.org, ruslan.bilovol@gmail.com,
        pavel.hofman@ivitera.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: gadget: f_uac1: add set requests support
Message-ID: <YgzTsLV/nSKp7FWP@kroah.com>
References: <20220216094301.2448-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216094301.2448-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 05:43:01PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> Currently the f_uac1 driver only supports UAC_SET_CUR request.
> 
> But when uac1 device is plugged to Ubuntu 20.04 PC, at the stage
> of setup, the PC will send UAC_SET_RES request, If the device
> doesn't respond to the request, the PC will abort the setup process
> and uac1 device can't be recognized on Ubuntu 20.04 PC.

So is this a bug in the Host side to not do stuff like this?  Why not
fix it there instead?

Where is the requirement that this command must be handled by the
device?

thanks,

greg k-h
