Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4736D50479C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbiDQKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiDQKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 06:36:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C642E36169
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 03:33:56 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1ng2E4-0002Nz-GJ; Sun, 17 Apr 2022 12:33:52 +0200
Date:   Sun, 17 Apr 2022 12:33:52 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: r8188eu: merge _mgt_dispatcher into
 mgt_dispatcher
Message-ID: <20220417103352.jqkqpi2auxir2g6g@viti.kaiser.cx>
References: <20220413200742.276806-1-martin@kaiser.cx>
 <20220413200742.276806-3-martin@kaiser.cx>
 <b028d269-4dd8-7165-6220-d42c1e0e588c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b028d269-4dd8-7165-6220-d42c1e0e588c@gmail.com>
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

Hi Pavel,

Thus wrote Pavel Skripkin (paskripkin@gmail.com):

> On 4/13/22 23:07, Martin Kaiser wrote:
> > All that the _mgt_dispatcher function does is to call a function from
> > a function pointer. It's not worth having a separate function for this.

> > Merge _mgt_dispatcher into mgt_dispatcher.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---

> [code snip]

> > +
> > +	if (ptable->func) {
> > +	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
> > +		if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
> > +		    !is_broadcast_ether_addr(GetAddr1Ptr(pframe)))
> > +			return;
> > +		ptable->func(padapter, precv_frame);
> > +	}
> >   }

> Looks like each `mlme_sta_tbl` element has `func` member initialized. I
> think, we can remove this check.

I've just sent a series to refactor mgt_dispatcher.

All mlme_sta_tbl entries have a function pointer, but some of the point
to a dummy function DoReserved. I guess we should use NULL and keep the
check instead of calling a function that does nothing.

Best regards,
Martin
