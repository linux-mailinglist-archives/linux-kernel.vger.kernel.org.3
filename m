Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE8A5A99BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbiIAOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbiIAOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:10:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02D85C958;
        Thu,  1 Sep 2022 07:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12AB2B826E2;
        Thu,  1 Sep 2022 14:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695B2C433C1;
        Thu,  1 Sep 2022 14:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662041426;
        bh=UNTflGqsKnchcU6RuHZVMvgsPP56HVZkeRHzd+46hwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bpBG+jCGAECaRGzI/yh8mUf5OXyYYqkBilRlLtHJhLXTVAlpcfT25EwREcmKpZWr8
         ZsTzvQr/V5sq8/AfSqD05oHg74YCKUnT/qzmPimMYbbY9kbnpJAHVSLWsRsXeZx1jL
         vMo6ctRUOWRnvc1XBDaodFCE3dREsE8/4v0Qx9S0=
Date:   Thu, 1 Sep 2022 16:10:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v5 1/5] usb: dwc3: Avoid unmapping USB requests if
 endxfer is not complete
Message-ID: <YxC9UBEvpMD3n7xF@kroah.com>
References: <20220831183242.27826-1-quic_wcheng@quicinc.com>
 <20220831183242.27826-2-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831183242.27826-2-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:32:38AM -0700, Wesley Cheng wrote:
> If DWC3_EP_DELAYED_STOP is set during stop active transfers, then do not
> continue attempting to unmap request buffers during dwc3_remove_requests().
> This can lead to SMMU faults, as the controller has not stopped the
> processing of the TRB.  Defer this sequence to the EP0 out start, which
> ensures that there are no pending SETUP transactions before issuing the
> endxfer.
> 
> Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  drivers/usb/dwc3/core.h   | 3 +++
>  drivers/usb/dwc3/ep0.c    | 5 ++++-
>  drivers/usb/dwc3/gadget.c | 6 +++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)

As the kernel-test robot reported, this patch doesn't even build.  How
did you test it?

greg k-h
