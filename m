Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A094C4019
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbiBYI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiBYI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:29:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C392399C8;
        Fri, 25 Feb 2022 00:29:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF736B80B4F;
        Fri, 25 Feb 2022 08:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B1CC340E7;
        Fri, 25 Feb 2022 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645777746;
        bh=ZmETsVuyByE5xkMtDoCMvW096Ji7aC0IryJumASrW/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMSaaTUzuWeCim9pRGWIoXlxEzB23dI4ltoiW5E3ZyqIuWcg+BxHdynjDQzh148Bb
         TdccEOltqBXf6WaxCIjZ2BxDwZW6lAzqfSTDP4JZBoOe8FYcDmycXUrUdtZcM1srAN
         gDzhY1zpE6oJTVFipB8Vu6DM5l9ndploW2cQNv2o=
Date:   Fri, 25 Feb 2022 09:29:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Starke <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/1] tty: n_gsm: improve standard compliance and feature
 completeness
Message-ID: <YhiTT2F5NJqFNrwM@kroah.com>
References: <20220225080758.2869-1-daniel.starke@siemens.com>
 <20220225080758.2869-2-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225080758.2869-2-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:07:58AM -0800, Daniel Starke wrote:
> The complete patch based on tty-next is included here for reference.
> A proper series of patches will follow based on the comments to this RFC.
> Please refer to the cover letter for more details.
> 
> Changes included:
> - added: proper n_gsm Kernel module information fields and module version
> - added: optional start-of-frame flag skipping in advanced option mode
> - added: UI (unnumbered information) frame support
> - added: PN (parameter negotiation) message handling and function support
> - added: optional keep-alive control link supervision via Test messages
> - added: proc fs files to provide meta data for the n_gsm instances
> - added: various parameter gated kernel debug messages
> - added: option for strict mode to reject non-standard compliant behavior
> - added: TIOCM_OUT1 and TIOCM_OUT2 to allow responder to operate as modem
> - added: TIOCMIWAIT support on virtual ttys
> - added: additional ioctls and parameters to configure the new functions
> - added: more function comments and aligned all to the coding guidelines
> - changed: overall locking mechanism to avoid data race conditions
> - changed: outgoing data flow to decouple physical from virtual tty
>   handling for better performance and to avoid dead-locks
> - fixed: advanced option mode implementation
> - fixed: convergence layer type 2 implementation
> - fixed: handling of CLD (multiplexer close down) messages
> - fixed: broken muxer close down procedure
> 
> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c         | 4523 +++++++++++++++++++++++++----------
>  include/uapi/linux/gsmmux.h |   70 +-
>  2 files changed, 3364 insertions(+), 1229 deletions(-)

I'm sorry, but there is nothing we can do with such a large patch here
at all.

Please break this up into "one logical change per patch" and we will be
glad to review it.

Put your "fixes" at the beginning of the patch series, so they can be
properly backported to older kernels as needed.  Don't mix up new
features with fixes as that means that the fixes can never be
backported.

One note, please drop the useless MODULE_VERSION() that never belongs in
an in-kernel driver as it makes no sense (the version is the kernel
version).  Same for the license "boiler-plate" text, that should not be
added back, we removed it for a reason.

Also, no module parameters should be added.  Especially pointless ones
like debugging flags, use the built-in kernel debugging options that the
whole rest of the kernel uses.  There is no need for a special case for
just one tiny line discipline module :)

thanks,

greg k-h
