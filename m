Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5236B56D4E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiGKGpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKGpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:45:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF7A18E03;
        Sun, 10 Jul 2022 23:45:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53E91B80D90;
        Mon, 11 Jul 2022 06:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB0C34115;
        Mon, 11 Jul 2022 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657521938;
        bh=Ovz0oMFCzUxed5tqrGHDygD5Uxy+oLIyQGwPoBJ7dOI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vIhTM/WIYvfvFd3tYQZQjY+xMo39WcW5td+wL9IHZfdBZoz6Mpp/KwcWBMhbSh8CY
         BvvQslaCEuWXbxaAkzC5+kxiZfadf4PAtdt17djEL7vZauScVSbf9bmRL9lS7ANnDQ
         0gFHD1g4lCPL6vrluOhaNzNMyAzzR3UvVun+O0eQ=
Date:   Mon, 11 Jul 2022 08:45:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 1/5] usb: mtu3: fix coverity of string buffer
Message-ID: <YsvHD6dpU3O7gQD4@kroah.com>
References: <20220708071903.25752-1-chunfeng.yun@mediatek.com>
 <YsfcFXtkDxe6ndFT@kroah.com>
 <9bbc0472bafa6116618e9861c3566d470c30c619.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bbc0472bafa6116618e9861c3566d470c30c619.camel@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 02:39:10PM +0800, Chunfeng Yun wrote:
> On Fri, 2022-07-08 at 09:26 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Jul 08, 2022 at 03:18:59PM +0800, Chunfeng Yun wrote:
> > > Use snprintf instead of sprintf which could cause buffer overflow.
> > 
> > How can it cause an overflow?
> Maybe I didn't describe it clearly, this patch is used to fix coverity
> check warning of string buffer, in fact no overflow happens.

Then perhaps the coverity warning is useless and
yet-another-false-positive that that tool is known to spit out?

Don't make code changes just because broken tools say to do so.

thanks,

greg k-h
