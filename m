Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBA25816A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiGZPnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239077AbiGZPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785A22CDD4;
        Tue, 26 Jul 2022 08:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33099B81330;
        Tue, 26 Jul 2022 15:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEF1C433D6;
        Tue, 26 Jul 2022 15:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658850190;
        bh=+aJWGbt27mhEfLgoMne9gRyx7fiFLy6p387pc/K3T04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7Y+PsVsseiiWVuWpBdeRyRUp5DqrKAWafQ4IiAp9IiWlO/8EvZcW53qQqn9acMZr
         cZcOOo9va3/FTgkuyVPP294tM6c1iDNG/MJDbDX/AjeNs9zx8byu9pSwYo4Qe4sJYW
         5cBwQTpak2wC6gLO04j7sr1hl5g/JVCLv2UGdmas=
Date:   Tue, 26 Jul 2022 17:43:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_mrana@quicinc.com, Thinh.Nguyen@synopsys.com
Subject: Re: [PATCH] usb: dwc3: gadget: Avoid duplicate requests to enable
 Run/Stop
Message-ID: <YuALjN8o/XNS7RE2@kroah.com>
References: <20220725201136.7989-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725201136.7989-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:11:36PM -0700, Wesley Cheng wrote:
> Relocate the pullups_connected check until after it is ensured that there
> are no runtime PM transitions.  If another context triggered the DWC3
> core's runtime resume, it may have already enabled the Run/Stop.  Do not
> re-run the entire pullup sequence again, as it may issue a core soft
> reset while Run/Stop is already set.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

What commit does this fix?

How far back should it go to stable kernels?

thanks,

greg k-h
