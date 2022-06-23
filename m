Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8FD557E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbiFWOsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiFWOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:48:34 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 334EA4616E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:48:31 -0700 (PDT)
Received: (qmail 943500 invoked by uid 1000); 23 Jun 2022 10:48:30 -0400
Date:   Thu, 23 Jun 2022 10:48:30 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Neal Liu <neal_liu@aspeedtech.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [PATCH RESEND] usb: gadget: f_mass_storage: Make CD-ROM
 emulation works with Windows OS
Message-ID: <YrR9PrjBXGV5O6bq@rowland.harvard.edu>
References: <20220623030405.1922980-1-neal_liu@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623030405.1922980-1-neal_liu@aspeedtech.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 11:04:05AM +0800, Neal Liu wrote:
> Add read TOC with format 2 to support CD-ROM emulation with
> Windows OS.
> This patch is tested on Windows OS Server 2019.

This description says "format 2", but the patch actually adds code for 
the case where format is 1.  This sort of mistake is not acceptable.

> Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 3a77bca0ebe1..3c2a5f1e8b66 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -1209,6 +1209,7 @@ static int do_read_toc(struct fsg_common *common, struct fsg_buffhd *bh)
>  
>  	switch (format) {
>  	case 0:
> +	case 1:
>  		/* Formatted TOC */
>  		len = 4 + 2*8;		/* 4 byte header + 2 descriptors */
>  		memset(buf, 0, len);

When format is 1, the driver is supposed to ignore the start_track 
value.  Your patch does not do this.

The default case in this switch statement has a comment saying that 
Mutil-session is not supported.  As a result of this change, it now _is_ 
supported.  The patch needs to update that comment.

Alan Stern
