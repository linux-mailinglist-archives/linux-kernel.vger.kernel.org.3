Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE71551462C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357239AbiD2KF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357224AbiD2KFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:05:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EAC42EC;
        Fri, 29 Apr 2022 03:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ABF7B833FD;
        Fri, 29 Apr 2022 10:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69874C385AD;
        Fri, 29 Apr 2022 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651226524;
        bh=sBjfabIruas5hiHgvaakX0cMzVsUzvk0vBYdFr7ByXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJQsTeDfk3m8BuSKBr38by48UbNl+eKT/WyYg9hUdLoguFqREG0lpeFGGjt3xcADh
         hWJC6/MVQ+OHc5TB5sR3haN8eSMD83S/yuWHXt7ujRcb2AKGOK1NEQ5KhfjtyE92pT
         49Q050u6wbbyJV3nX2klhTbACuS0JDHdIxVsTK8Y=
Date:   Fri, 29 Apr 2022 12:02:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mayank Rana <quic_mrana@quicinc.com>, peter.chen@kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu,
        chunfeng.yun@mediatek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
Message-ID: <Ymu3mZyNisr0Bzf7@kroah.com>
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
 <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 12:49:59PM +0300, Mathias Nyman wrote:
> On 28.4.2022 22.04, Mayank Rana wrote:
> > ring_doorbell_for_active_rings() API is being called from
> > multiple context. This specific API tries to get virt_dev
> > based endpoint using passed slot_id and ep_index. Some caller
> > API is having check against slot_id and ep_index using
> > xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
> > only check ep_index against -1 value but not upper bound i.e.
> > EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
> > based endpoint which checks both slot_id and ep_index to get
> > valid endpoint.
> 
> ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
> and ep_index = fls(u32 value)  - 1 - 1; 
> 
> We can change to use xhci_get_virt_ep(), but this would be more useful
> earlier in xhci_handle_cmd_config_ep() where we touch the ep before
> calling ring_doorbell_for_active_rings()
> 
> Also note that this codepath is only used for some prototype
> xHC controller that probably never made it to the market about 10 years ago.

Can we just delete the codepath entirely then?

thanks,

greg k-h
