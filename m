Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BA4E5186
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243973AbiCWLpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbiCWLpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:45:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CEC36150;
        Wed, 23 Mar 2022 04:43:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3525B81E7D;
        Wed, 23 Mar 2022 11:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6938C340E8;
        Wed, 23 Mar 2022 11:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648035815;
        bh=WkV8XVmzLw63I9Fodwt+Z/8kLcUo4U+yhHdNLmmb6OM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=H6e0rP9LCnJ63/4bOKhWvsfJt8D9JpW/36GSwu0akuxoBI/3EoqVOm886HE0u8cmV
         oWWIZZtdcBA2KALOQP8rsZhhPncqjPPdIx2fQDEcdyXnv5YD0fn0bm4ixnEbcQSKgV
         Uy6OtxyRh78m3ieuonTnfC3d4ksDxFZkOrFG/AJg=
Date:   Wed, 23 Mar 2022 12:43:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jung Daehwan <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
Subject: Re: [PATCH v1 1/4] usb: host: export symbols for xhci hooks usage
Message-ID: <YjsH5Jtwd4JlXJ6g@kroah.com>
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220304062617epcas2p2084161966aaa66d07f4c25720ec18088@epcas2p2.samsung.com>
 <252651381.41646375583002.JavaMail.epsvc@epcpadp4>
 <b33d8497-d6d5-18e2-93a9-e0564a84c1c5@kernel.org>
 <1983025922.01648006681661.JavaMail.epsvc@epcpadp4>
 <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105eaeec-d77e-b0eb-86ad-a88c7446ca98@kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 10:41:23AM +0100, Krzysztof Kozlowski wrote:
> On 23/03/2022 03:58, Jung Daehwan wrote:
> > On Mon, Mar 07, 2022 at 10:59:06AM +0100, Krzysztof Kozlowski wrote:
> >> On 04/03/2022 07:23, Daehwan Jung wrote:
> >>> Export symbols for xhci hooks usage:
> >>> 	xhci_ring_free
> >>> 	- Allow xhci hook to free xhci_ring.
> >>
> >> Instead of copying-pasting the name of function, please explain why do
> >> you need these symbols exported.
> >>
> >> The "Why" is actually one of most important questions, because "what is
> >> this patch doing" we can easily see...
> >>
> >>>
> >>> 	xhci_get_slot_ctx
> >>> 	- Allow xhci hook to get slot_ctx from the xhci_container_ctx
> >>> 	  for getting the slot_ctx information to know which slot is
> >>> 	  offloading and compare the context in remote subsystem memory
> >>> 	  if needed.
> >>>
> >>
> >>
> >> Best regards,
> >> Krzysztof
> >>
> > 
> > Hi Krzysztof
> > 
> > xhci_ring_free has been removed from v3..
> > The reason why I want to export is for managing vendor specific ring.
> > I want to alloc and free vendor specific ring on specific address.
> > It's done with xhci hooks.
> 
> It's better, but still does not explain why these have to be exported.
> Please mention where are these hooks going to be. Where are they
> implemented. I actually expect all of these exports to be used in your
> patchset.

All exports _HAVE_ to be used by the patchset.  Otherwise it's an
invalid submission.

thanks,

greg k-h
