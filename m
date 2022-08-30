Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4F5A65EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiH3OIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3OI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79558F8244;
        Tue, 30 Aug 2022 07:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE1861509;
        Tue, 30 Aug 2022 14:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7504C433C1;
        Tue, 30 Aug 2022 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661868506;
        bh=ux4h3Llu3Xn8hcq4G08hx6TYSq1WAZloO+EsuQis5QA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSCQkPJGPWzIGcKEolE5zeH0J3N2NX+yq4V5Bfos9C3jmc9u4E+4vNZjs9Kz5ysCY
         CsRFA37iNEE9D3UC3h6jDf4yz7UKom9t1fNa/DfNxHQuz16Wcn8+H/cKH24eNg2Bsa
         g1SIRJeuG7368DsmalEt047R9xDQX2kzKHukhCMY=
Date:   Tue, 30 Aug 2022 16:08:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, Thinh.Nguyen@synopsys.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_jackp@quicinc.com
Subject: Re: [PATCH v4 5/9] usb: dwc3: Avoid unmapping USB requests if
 endxfer is not complete
Message-ID: <Yw4Z191jbRJc9EuR@kroah.com>
References: <20220817182359.13550-1-quic_wcheng@quicinc.com>
 <20220817182359.13550-6-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817182359.13550-6-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 11:23:55AM -0700, Wesley Cheng wrote:
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
> 

This commit does not apply to my usb-testing branch.  I've taken the
first 4, please rebase and resend the rest.

thanks,

greg k-h
