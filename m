Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779D755770E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiFWJrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiFWJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18D649935
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AC1EB8222B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A417C341C6;
        Thu, 23 Jun 2022 09:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655977604;
        bh=YWP8xQl28FqLrVoNh1JnPPBf3z5SkmXcUdzYiHP2f7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gjtv+PjCDpxCyJtM19H3WCoRUbPRJ6X3nmxXRGq7LpG/Ias3TIY3bQk6vsTF0lPWy
         Ac9WflSk2BxdX2HLvW3izOiHYz/v8axaZDYgPmopeiN0BfnajkbAf0/46n1SHjVNUC
         5QItwP4uR9P1wkhPKXp2WqZ684TF3ihhl4Fa2phI=
Date:   Thu, 23 Jun 2022 11:46:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-staging@lists.linux.dev, davem@davemloft.net,
        alexander.deucher@amd.com, kuba@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192u: Fix sleep in atomic context bug in
 dm_fsync_timer_callback
Message-ID: <YrQ2gXtX2FOkyNgu@kroah.com>
References: <20220623055912.84138-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623055912.84138-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:59:12PM +0800, Duoming Zhou wrote:
> There are sleep in atomic context bugs when dm_fsync_timer_callback is
> executing. The root cause is that the memory allocation functions with
> GFP_KERNEL or GFP_NOIO parameters are called in dm_fsync_timer_callback
> which is a timer handler. The call paths that could trigger bugs are
> shown below:
> 
>     (interrupt context)
> dm_fsync_timer_callback
>   write_nic_byte
>     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
>     usb_control_msg
>       kmalloc(.., GFP_NOIO); //may sleep
>   write_nic_dword
>     kzalloc(sizeof(data), GFP_KERNEL); //may sleep
>     usb_control_msg
>       kmalloc(.., GFP_NOIO); //may sleep
> 
> This patch uses delayed work to replace timer and moves the operations
> that may sleep into the delayed work in order to mitigate bugs.
> 
> Fixes: 8fc8598e61f6 ("Staging: Added Realtek rtl8192u driver to staging")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Use delayed work to replace timer.

Did you test this with real hardware to verify it still works?

thanks,

greg k-h
