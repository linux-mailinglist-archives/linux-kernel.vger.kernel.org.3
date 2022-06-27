Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6821755CB51
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbiF0Tqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbiF0Tq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:46:29 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DFD1A81A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:46:28 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1o5ugf-0002f5-S9; Mon, 27 Jun 2022 21:46:21 +0200
Date:   Mon, 27 Jun 2022 21:46:21 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: drop return value from
 receive_disconnect
Message-ID: <20220627194621.44hziv4cmt3zfrt4@viti.kaiser.cx>
References: <20220626180734.287137-1-martin@kaiser.cx>
 <YrlzLEf1atin6gBd@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrlzLEf1atin6gBd@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and all,

Thus wrote Greg Kroah-Hartman (gregkh@linuxfoundation.org):

> >  	/* check A3 */
> >  	if (!(!memcmp(MacAddr, get_my_bssid(&pmlmeinfo->network), ETH_ALEN)))
> > -		return _SUCCESS;
> > +		return;

> Shouldn't this check return an error instead of success?  If not, what
> exactly is this checking this for?

my understanding is that receive_disconnect is called when an access
point is no longer usable. This could be a deauth or disassoc message or
a beacon with incorrect info (so we assume the access point isn't
working any more).

The if statement checks if the notification is about the access point to
which we're connected. If not, we don't have to process the notification.
I guess this is not necessarily an error.

Thanks & Best regards,

   Martin
