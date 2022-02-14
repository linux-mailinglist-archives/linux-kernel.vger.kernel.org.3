Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA0E4B4F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351437AbiBNLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:49:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352043AbiBNLja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:39:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151EE0EE;
        Mon, 14 Feb 2022 03:29:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2B3D611AF;
        Mon, 14 Feb 2022 11:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D912C340E9;
        Mon, 14 Feb 2022 11:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644838192;
        bh=X/vj9bZ7G1cVDoVme5LRY1sPodeCFxRDwg34D93ziYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uv5SsfQuTXs2i2R1L8ykWa/fJBxk/gBL4Sh+B28sSyioGyDt1WYw0BULm3wuSExGJ
         j5dm8CUpeYPJpQv0a8NhxxyFyAeoX5QczTroGqwGWw+L4/Ii3WrABUWpVS6l0UTLxV
         LQP3eEbzrmSOZFmPhZ5fMop+O12c7LGD8IaqZSlo=
Date:   Mon, 14 Feb 2022 12:29:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daehwan Jung <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Message-ID: <Ygo9LZg8lxitTE8J@kroah.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 08:08:52PM +0900, Daehwan Jung wrote:
> It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> skipping clear stall commmand or giveback from dequeue. We fix to set it
> only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> for next trb to start transfer not update transfer.

So is this two different changes?

> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>

What commit id does this fix?

thanks,

greg k-h
