Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1E4B4F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352193AbiBNLsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:48:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351970AbiBNLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD414086;
        Mon, 14 Feb 2022 03:30:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1ADEECE130F;
        Mon, 14 Feb 2022 11:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D7C340E9;
        Mon, 14 Feb 2022 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644838235;
        bh=h/tLqKI+kSgP4V2Ob7fIJ54EMGn25h4EBw9QAxLYA9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MV9CfUo4SJgnR3hhU1XdAnESN3u1XnC6Ufn1cSDCy0OgfnG7r8o4b9gg9Q/JXvOjr
         ZB4+Rpopl+Y4rrOQTuhciz3DRsrXterdGxLI6GmAkBPqb1BSir/MFCia1wJl89luIz
         3P8EI0JNeI79zOWWRDn7XkCXzYjxMydF7EbgENnI=
Date:   Mon, 14 Feb 2022 12:30:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v2 2/2] usb: dwc3: Prevent cleanup cancelled requests at
 the same time.
Message-ID: <Ygo9WMCVRNp/4/Ry@kroah.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p29b9e39b84d7203572422531beb3c39ed@epcas2p2.samsung.com>
 <1644836933-141376-3-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644836933-141376-3-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:08:53PM +0900, Daehwan Jung wrote:
> We added cleanup cancelled requests when ep cmd timeout on ep dequeue
> because there's no complete interrupt then. But, we find out new case
> that complete interrupt comes up later. list_for_each_entry_safe is
> used when cleanup cancelled requests and it has vulnerabilty on multi-core
> environment. dwc3_gadget_giveback unlocks dwc->lock temporarily and other
> core(ISR) can get lock and try to cleanup them again. It could cause
> list_del corruption and we use DWC3_EP_END_TRANSFER_PENDING to prevent it.
> 
> 1. MTP server cancels -> ep dequeue -> ep cmd timeout(END_TRANSFER)
> 	-> cleanup cancelled requests -> dwc3_gadget_giveback ->
> 	list_del -> release lock temporarily
> 2. Complete with END_TRANSFER -> ISR(dwc3_gadget_endpoint_command_complete)
> 	gets lock -> cleanup cancelled requests -> dwc3_gadget_giveback
> 	-> list_del
> 3. MTP server process gets lock again
> 	-> tries to access POISON list(list_del corruption)
> 
> [2: MtpServer: 5032] dwc3 10b00000.dwc3: request cancelled
> 						with wrong reason:5
> [2: MtpServer: 5032] list_del corruption,
> 		ffffff88b6963968->next is LIST_POISON1 (dead000000000100)
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/dwc3/gadget.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

What commit id does this fix?

thanks,

greg k-h
