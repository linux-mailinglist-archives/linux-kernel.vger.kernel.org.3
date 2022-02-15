Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4914B6472
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiBOHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:37:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiBOHh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:37:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E7657A1;
        Mon, 14 Feb 2022 23:37:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECF55B817DF;
        Tue, 15 Feb 2022 07:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29254C340EC;
        Tue, 15 Feb 2022 07:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644910634;
        bh=MS4a2sCHLZDfgiTN71t3s65oVZd6bxNMNM0atcJwRWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pS+1F9Sj4fbMu0Y2QNh0UNCUsswFlNNCkvOQCsYb86ZoSrdbKstuOh/vHEnPYQ6N5
         KuBooyEaeTAaFvi/dqpcY6FEHzIRR0/K3BYlCekjIP398Q3y9OIiQ9ngiiWLFGF1ku
         HNB67wXhckx/Ila2/JHhITi6G7iQ7nRk+FkdPtg8=
Date:   Tue, 15 Feb 2022 08:37:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Message-ID: <YgtYJ544YsvKTaxS@kroah.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <Ygo9LZg8lxitTE8J@kroah.com>
 <20220215065826.GD144890@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215065826.GD144890@ubuntu>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 03:58:26PM +0900, Jung Daehwan wrote:
> On Mon, Feb 14, 2022 at 12:29:49PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 14, 2022 at 08:08:52PM +0900, Daehwan Jung wrote:
> > > It always sets DWC3_EP_END_TRANSFER_PENDING in dwc3_stop_active_transfer
> > > even if dwc3_send_gadget_ep_cmd fails. It can cause some problems like
> > > skipping clear stall commmand or giveback from dequeue. We fix to set it
> > > only when ep cmd success. Additionally, We clear DWC3_EP_TRANSFER_STARTED
> > > for next trb to start transfer not update transfer.
> > 
> > So is this two different changes?
> > 
> > > 
> > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > 
> > What commit id does this fix?
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hi greg,
> 
> Below is commit id to fix.
> 
> commit c58d8bfc77a2c7f6ff6339b58c9fca7ae6f57e70
> Author: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Date:   Wed Dec 18 18:14:44 2019 -0800

<snip>

Then please properly put that as a "Fixes:" tag in the signed-off-by
area when you resubmit this.

thanks,

greg k-h
