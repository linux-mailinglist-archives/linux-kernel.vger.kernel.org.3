Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9385146DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357520AbiD2Kjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357525AbiD2Kjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:39:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0070C1C92;
        Fri, 29 Apr 2022 03:36:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63DF3B83441;
        Fri, 29 Apr 2022 10:36:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59562C385A4;
        Fri, 29 Apr 2022 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651228589;
        bh=Ktc5N4HFPxecyJ36RymVwadyVAhPiXQsm4iiUN/wNrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIclIxoJOVTjjC0URkszf8a4BQAe86WJXc+ViQFV7wUKzWuQW+ip4vBS6XJcM6DI5
         lrv7pQ4IQS/1mXk0TrAF4e4zuYSFN9s0JMeNTTFFN1ah0+4LkLx59P7iCHkMCHZ8H6
         N5PXOkOAdQ2zbbibCPwxhImuQRspjvhQa50TdPr8=
Date:   Fri, 29 Apr 2022 12:36:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mayank Rana <quic_mrana@quicinc.com>, peter.chen@kernel.org,
        balbi@kernel.org, stern@rowland.harvard.edu,
        chunfeng.yun@mediatek.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH RESEND] xhci: Use xhci_get_virt_ep() to validate ep_index
Message-ID: <Ymu/qqxpf68tF1FX@kroah.com>
References: <1651172688-21439-1-git-send-email-quic_mrana@quicinc.com>
 <71347c81-3887-d80e-707b-c0f1018b1a50@linux.intel.com>
 <Ymu3mZyNisr0Bzf7@kroah.com>
 <364cb857-71f0-b89d-54fb-5acb129451d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364cb857-71f0-b89d-54fb-5acb129451d2@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 01:23:50PM +0300, Mathias Nyman wrote:
> On 29.4.2022 13.02, Greg KH wrote:
> > On Fri, Apr 29, 2022 at 12:49:59PM +0300, Mathias Nyman wrote:
> >> On 28.4.2022 22.04, Mayank Rana wrote:
> >>> ring_doorbell_for_active_rings() API is being called from
> >>> multiple context. This specific API tries to get virt_dev
> >>> based endpoint using passed slot_id and ep_index. Some caller
> >>> API is having check against slot_id and ep_index using
> >>> xhci_get_virt_ep() API whereas xhci_handle_cmd_config_ep() API
> >>> only check ep_index against -1 value but not upper bound i.e.
> >>> EP_CTX_PER_DEV. Hence use xhci_get_virt_ep() API to get virt_dev
> >>> based endpoint which checks both slot_id and ep_index to get
> >>> valid endpoint.
> >>
> >> ep_index upper bound is known to be in range as EP_CTX_PER_DEV is 31,
> >> and ep_index = fls(u32 value)  - 1 - 1; 
> >>
> >> We can change to use xhci_get_virt_ep(), but this would be more useful
> >> earlier in xhci_handle_cmd_config_ep() where we touch the ep before
> >> calling ring_doorbell_for_active_rings()
> >>
> >> Also note that this codepath is only used for some prototype
> >> xHC controller that probably never made it to the market about 10 years ago.
> > 
> > Can we just delete the codepath entirely then?
> 
> Probably.
> Commit ac9d8fe7c6a8 USB: xhci: Add quirk for Fresco Logic xHCI hardware.
> that added this states:
> 
> "This patch is for prototype hardware that will be given to other companies
> for evaluation purposes only, and should not reach consumer hands.  Fresco
> Logic's next chip rev should have this bug fixed."
> 
> Should we print some warning instead if this controller is used?
> just in case. 

Would be a good idea, see if that hardware did actually get out into the
wild.

thanks,

greg k-h
