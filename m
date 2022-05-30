Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045C35376B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiE3I0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbiE3I0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:26:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC9E12AA5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:26:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 442C360F19
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52135C34119;
        Mon, 30 May 2022 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653899203;
        bh=bjVbSPvihSxYjvHQHgA3hXBC3TXCMdD3HcCbn6qypOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6FECxfH8o4lG/G7O2M8Bt0N92wdycrEuwXxOx04CiUlBS5wty/PSXabxvhonnzUk
         UO7eFv9T13oCZ1F8TsjHJnfHuqgx1Is0xVZ5CsZB9hAkJiqNsGBR+UVdfI9UUQhzhg
         oe2yq8Z90VS+tGdiS8L6oCvgRly6cy169xmDrtoU=
Date:   Mon, 30 May 2022 10:26:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     baihaowen <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix pointer dereferenced before
 checking
Message-ID: <YpR/wHwWRbJ9cWbo@kroah.com>
References: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
 <YpR85JgzGsTzYm3W@kroah.com>
 <61130a41-a626-c860-e321-9295f9c9d0dd@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61130a41-a626-c860-e321-9295f9c9d0dd@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:22:11PM +0800, baihaowen wrote:
> 在 2022/5/30 下午4:14, Greg Kroah-Hartman 写道:
> > On Mon, May 30, 2022 at 04:05:32PM +0800, Haowen Bai wrote:
> >> The padapter->recvpriv.signal_qual_data is dereferencing before null
> >> checking, so move it after checking.
> >>
> >> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> >> ---
> >>  drivers/staging/rtl8712/rtl8712_recv.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> >> index 7f1fdd058551..8ed94b259dbe 100644
> >> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> >> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> >> @@ -863,10 +863,12 @@ static void process_link_qual(struct _adapter *padapter,
> >>  {
> >>  	u32	last_evm = 0, tmpVal;
> >>  	struct rx_pkt_attrib *pattrib;
> >> -	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
> >> +	struct smooth_rssi_data *sqd;
> >>  
> >>  	if (!prframe || !padapter)
> >>  		return;
> >> +
> >> +	sqd = &padapter->recvpriv.signal_qual_data;
> > How can padapter ever be NULL in this codepath?
> >
> > thanks,
> >
> > greg k-h
> Just the original  code, show me
> 
> if (!prframe || !padapter)
> 
> It would be null, and then return.

Again, trace things backwards, how can padapter ever be NULL?
