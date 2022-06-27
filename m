Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2F955CBF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238821AbiF0MIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbiF0MHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E29DEFE;
        Mon, 27 Jun 2022 05:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AB16B81126;
        Mon, 27 Jun 2022 12:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69B5C3411D;
        Mon, 27 Jun 2022 12:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656331593;
        bh=NbyhByzCH5/okHi8PrVyh0HR/ISn4xht5nGthfBzx1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cp3sfI9zfJK8tiLDjFucyDJ1O6N1SLfwDmCJQIj553q3nNVv/+Kl7dcsLauoH3CeY
         WsHRPuzOODEZLLe5Hck5CmJPwMYljbBYfJTehisItHl4wGlrYi7UwnfAk1c50JXeMZ
         IOMU8udi15yR7LW3RNYC7UO26S91nxP7BA2/3adY=
Date:   Mon, 27 Jun 2022 13:54:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 6/9] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Message-ID: <YrmajcyijzquuFui@kroah.com>
References: <DB9PR10MB5881188AE33199085DAD1460E0B59@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB5881188AE33199085DAD1460E0B59@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:26:27PM +0000, Starke, Daniel wrote:
> > This is a bit huge for stable backports, especially given that a huge
> > number of the previous stable backports have totally failed and no one
> > has submitted new versions.
> > 
> > So why is this needed for stable?  Same for all of these in the series...
> 
> Given the fact that these are all bug fixes I assumed that these are also
> relevant for backporting. Maybe only in the more recent stable releases
> if there are issues with the merges.
> I do not mind removing the stable kernel reference and keep these changes
> only for mainline. So please let me know your preference.
> Should I resubmit the patches without stable reference?

Please read the stable kernel rules for what is, and is not allowed.
Generally a patch that does:
	drivers/tty/n_gsm.c | 410 ++++++++++++++++++++++++++++++--------------
is not allowed.

Please sort by what is stable fixes, and what is not.  Given that you
don't seem to want to backport patches to older stable kernels when they
fail to apply, why are any of these needed in stable kernels if the
older ones are not also going to be merged there?

thanks,

greg k-h
