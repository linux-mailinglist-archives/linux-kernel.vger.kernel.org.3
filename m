Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6874B4DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350031AbiBNLMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:12:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349604AbiBNLMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:12:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28B46E36A;
        Mon, 14 Feb 2022 02:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E613B80D75;
        Mon, 14 Feb 2022 10:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7144AC340E9;
        Mon, 14 Feb 2022 10:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644835326;
        bh=qImW5XUSUo6sojbafkess0CO8BoHLJyEOWJdYaLl3jQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ag9UJEwLdn/6jfaORT2b0e5LqdbRH+hGQ31f0I1b1gflP3Nog5cAYNL4a+rbjtIE2
         A0X2s/h0VkOVJPnYmiThGDkUlvcC8iv5sn1badV6vTt9KN3pwED5G818oH8Eu6e0rR
         KDEDC4BkjnLpxEsfNYp81tWdCJCJB+02NCefMnWU=
Date:   Mon, 14 Feb 2022 11:42:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v1 2/2] usb: dwc3: Prevent cleanup cancelled requests at
 the same time.
Message-ID: <Ygox+/x5zNjO5u46@kroah.com>
References: <1644831438-125403-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214094042epcas2p118ac06692ad14f321a3fd59e57bcf1d5@epcas2p1.samsung.com>
 <1644831438-125403-3-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644831438-125403-3-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 06:37:18PM +0900, Daehwan Jung wrote:
> We added cleanup cancelled requests when ep cmd timeout on ep dequeue
> because there's no complete interrupt then. But, we find out new case
> that complete interrupt comes up later. list_for_each_entry_safe is
> used when cleanup cancelled requests and it has vulnerabilty on multi-core
> environment. dwc3_gadget_giveback unlocks dwc->lock temporarily and other
> core(ISR) can get lock and try to cleanup them again. It could cause
> list_del corruption and we use DWC3_EP_END_TRANSFER_PENDING to prevent it.
> 
> 1. MTP server cancels -> ep dequeue -> ep cmd timeout(END_TRANSFER)
>    -> cleanup cancelled requests -> dwc3_gadget_giveback -> list_del -> release lock temporarily
> 2. Complete with END_TRANSFER -> ISR(dwc3_gadget_endpoint_command_complete) gets lock
>    -> cleanup cancelled requests -> dwc3_gadget_giveback -> list_del
> 3. MTP server process gets lock again -> tries to access POISON list(list_del corruption)
> 
> [  205.014697] [2:      MtpServer: 5032] dwc3 10b00000.dwc3: request cancelled with wrong reason:5
> [  205.014719] [2:      MtpServer: 5032] list_del corruption, ffffff88b6963968->next is LIST_POISON1 (dead000000000100)
> 
> Change-Id: I9df055c6c04855edd09e330300914454a6657a23
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> 
> Change-Id: If87c88c3bb4c17ea1a5bde2bfec1382769f7ecab
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>

Why did you sign off on this twice?

And did you run it through checkpatch.pl?  It would have reminded you
that Change-Id: should not be on patches :(

Same for patch 1/1.

Please fix.

thanks,

greg k-h
