Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508E524941
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbiELJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352186AbiELJjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:39:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E49BC5D8F;
        Thu, 12 May 2022 02:39:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDA3C619E3;
        Thu, 12 May 2022 09:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725ACC34100;
        Thu, 12 May 2022 09:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652348374;
        bh=yEe8U9fJTTN2e7EoUB9IR0dDTElIvA701b3+IIT/eyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dn98lqDObEU4zMKR1wQidlveiwJFT7Z/0gaa2kjuGxV0iI4SkO2DStjZRhd4C7Vv+
         NjLJ7cAbxJugolMo7IO5oJwinTlbXYObiEJwjnGPzi81uezMvxVaVjNFI4URSeJ4mi
         67JMRBP7whQKrgyMuZY/b4bPL6W0hNndgI+iIq5c=
Date:   Thu, 12 May 2022 11:39:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Albert Wang <albertccwang@google.com>
Cc:     balbi@kernel.org, quic_jackp@quicinc.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: gadget: Move null pinter check after
 window closed
Message-ID: <YnzV04QXBEM0GoxL@kroah.com>
References: <20220512093146.1301669-1-albertccwang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512093146.1301669-1-albertccwang@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:31:46PM +0800, Albert Wang wrote:
> After inspecting further, we do see the locking is implicit, with the
> main gotcha being the unlock/re-lock. That creates a window for a race
> to happen. This change moves the NULL check to be adjacent to where
> to it's used and after the window is "closed".
> 
> Fixes: 26288448120b ("usb: dwc3: gadget: Fix null pointer exception")
> 
> Signed-off-by: Albert Wang <albertccwang@google.com>

No blank line between Fixes: and signed-off-by please.

> ---
>  v2: Remove redundant 'else' and add additional comments and more
>      descriptive commit text

I see two v2 copies on the lists for this commit.

Please send a v3, never duplicate the versions, that just causes
confusion, right?

thanks,

greg k-h
