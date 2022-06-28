Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA755D35E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343771AbiF1JLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiF1JLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:11:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9A10578
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF41A616EB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C24C3411D;
        Tue, 28 Jun 2022 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656407468;
        bh=rBGVIVW0p/BjBhPp3FAvn8AGSqX6kksyJLXvOIxCCvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Lz1I4/74Yu+Vw7FvyHqQXtn9ye1W27z8j/GY00fWrsw32m29aOJa8zfLeWUTSS1J
         Z3yvDgy9jQFmTBSkxyjks/n9pdULKAFwwVvhPAmHXTz6hpm+6O6Z9GdhauDpwmf3VX
         efiQKGuVVIT5RcaMfYy0MqVDG3eAYq6nqstD47BY=
Date:   Tue, 28 Jun 2022 11:11:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yangxi Xiang <xyangxi5@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the
 buffer
Message-ID: <YrrFqfFdwDM0vrrw@kroah.com>
References: <466232ee-8d55-e33f-d2ca-e6b9fc0b8103@kernel.org>
 <20220628085922.22460-1-xyangxi5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628085922.22460-1-xyangxi5@gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 04:59:22PM +0800, Yangxi Xiang wrote:
> >> Both of them works, and I pick one of them.
> >
> > Sorry, I don't understand.
> 
> We can use both scr_memcpyw() and scr_memmovew() for the not
> overlapping case (cp <= nr), which is more likely to happen.
> In this case I keep using scr_memcpyw().

The point is we should just do one type of copy, let's pick the one that
always works and do that, no need to check anything here.

thanks,

greg k-h
