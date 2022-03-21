Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE06C4E2366
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345905AbiCUJgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244527AbiCUJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:36:01 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB65D5C2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:34:36 -0700 (PDT)
Received: from dslb-094-219-034-255.094.219.pools.vodafone-ip.de ([94.219.34.255] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1nWEQo-0006nj-F5; Mon, 21 Mar 2022 10:34:30 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1nWEQf-0002OY-8M; Mon, 21 Mar 2022 10:34:21 +0100
Date:   Mon, 21 Mar 2022 10:34:21 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     David Laight <David.Laight@aculab.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: r8188eu: remove local BIT macro
Message-ID: <YjhGnVL5mk4fbQVq@martin-debian-2.paytec.ch>
References: <20220319180342.3143734-1-martin@kaiser.cx>
 <ac3343ea279b4d048d77b3cf2724bcbe@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac3343ea279b4d048d77b3cf2724bcbe@AcuMS.aculab.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

thanks for digging into this mess.

Thus wrote David Laight (David.Laight@ACULAB.COM):

> From: Martin Kaiser <martin@kaiser.cx>
> > Sent: 19 March 2022 18:04

> > The r8188eu driver defines a local BIT(x) macro. Remove this local macro
> > and use the one from include/linux/bits.h.

> > The global BIT macro returns an unsigned long value, the removed local
> > BIT macro used a signed int.

> > DYNAMIC_BB_DYNAMIC_TXPWR is defined as BIT(2), ~DYNAMIC_BB_DYNAMIC_TXPWR
> > is passed to Switch_DM_Func as a u32 parameter. We need a cast in this
> > case as ~DYNAMIC_BB_DYNAMIC_TXPWR is a 64-bit value on x86_64 systems.

> Hmmm....
> Why not fix the called function so that the caller doesn't
> need to do the invert.

When I look into this driver, it's challenging to fix one thing at a time
and not be caught up in all the other problems I discover along the way.

Would you be ok with removing the local BIT macro first?

It seems to me that this whole DYNAMIC_BB_DYNAMIC_TXPWR handling can go.
DYNAMIC_BB_DYNAMIC_TXPWR isn't checked anywhere. I'll submit this as a
separate patch.

With DYNAMIC_BB_DYNAMIC_TXPWR gone, ony three calls remain

  16   6723  drivers/staging/r8188eu/core/rtw_mlme_ext.c <<mlmeext_joinbss_event_callback>>
             Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true);
  17   7124  drivers/staging/r8188eu/core/rtw_mlme_ext.c <<createbss_hdl>>
             Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);
  18   7393  drivers/staging/r8188eu/core/rtw_mlme_ext.c <<sitesurvey_cmd_hdl>>
             Switch_DM_Func(padapter, DYNAMIC_FUNC_DISABLE, false);

DYNAMIC_FUNC_DISABLE is indeed 0 and sets podmpriv->SupportAbility = 0,
DYNAMIC_ALL_FUNC_ENABLE sets podmpriv->SupportAbility = pdmpriv->InitODMFlag.

We can do this without dubious casts and intermediate functions...

Best regards,
Martin
