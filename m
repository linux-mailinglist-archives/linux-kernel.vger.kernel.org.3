Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5664C3E58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 07:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237793AbiBYGYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 01:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbiBYGY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 01:24:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA0F23584B;
        Thu, 24 Feb 2022 22:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B01961A4D;
        Fri, 25 Feb 2022 06:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55565C340E7;
        Fri, 25 Feb 2022 06:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645770234;
        bh=JIjPLXAFteEFGFpis11xNVKv9A9z+UArDoDbTHvX+Z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxRmf/Vgkh0rt6lUwdVqBhKNdailJzKBY9PYNbPw3Udm2O5kKkNq5QaXrHd1unw4E
         MLfd38LlZYPjmtadv883rVLUTVLNbDzmNxGkLoREjgHPXiU/21ZrmI45Dzv2nfzigK
         +wJ+ItW5mtOzkTIp+FVojs4FZTgkPkJopYflTV6Y=
Date:   Fri, 25 Feb 2022 07:23:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Henry Lin <henryl@nvidia.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xhci: fix runtime PM imbalance in USB2 resume
Message-ID: <Yhh19qsTsGRhsLWT@kroah.com>
References: <20220225055311.92447-1-henryl@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225055311.92447-1-henryl@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 01:53:11PM +0800, Henry Lin wrote:
> USB2 resume starts with usb_hcd_start_port_resume() in port status
> change handling for RESUME link state. usb_hcd_end_port_resume() call is
> needed to keep runtime PM balance.
> 
> Signed-off-by: Henry Lin <henryl@nvidia.com>
> ---
>  drivers/usb/host/xhci-hub.c | 2 ++
>  1 file changed, 2 insertions(+)

What commit does this fix?
