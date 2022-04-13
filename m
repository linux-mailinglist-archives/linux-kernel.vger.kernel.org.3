Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8EA4FF2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiDMJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDMJFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:05:22 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ECE252AA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=p/6FirwSCVCMNaAVTS0/mDOUExThkpxHbP69SQ0S5jU=;
  b=VzIQa38KpX96o+1RammxR9SDSFZDUFP47BCa+2MS+H+VPV56tFM69xeY
   PgEibEMyMNZBalDWNgtdsQ9UMMWU50dKlAcb6V4TD1kgfSRVnTPO3qMNc
   X9M7i4QtnORkBG1tiq0vA1jQcGWNe31hAseyi8jRtb7IoNqcFcAPjoDjA
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,256,1643670000"; 
   d="scan'208";a="31479824"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 11:02:59 +0200
Date:   Wed, 13 Apr 2022 11:02:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Pavel Skripkin <paskripkin@gmail.com>
cc:     Mahak Gupta <mahak_g@cs.iitr.ac.in>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: remove else after return and break
 statements
In-Reply-To: <4946ce95-8692-b765-b5ea-ab4b521182fc@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204131102300.3470@hadrien>
References: <20220413052759.4859-1-mahak_g@cs.iitr.ac.in> <4946ce95-8692-b765-b5ea-ab4b521182fc@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Apr 2022, Pavel Skripkin wrote:

> Hi Mahak,
>
> On 4/13/22 08:27, Mahak Gupta wrote:
> > Else is not necessary after return and break statements, hence remove
> > it.
> >
> > Reported by checkpatch:
> >
> > WARNING: else is not generally useful after a break or return
> >
> > Signed-off-by: Mahak Gupta <mahak_g@cs.iitr.ac.in>
>
> [snip]
>
> > -	}
> > +	/*  could be pure B, pure G, or B/G */
> > +	if (rtw_is_cckratesonly_included(rate))
> > +		return WIRELESS_11B;
> > +	else if (rtw_is_cckrates_included(rate))
> > +		return	WIRELESS_11BG;
> > +	else
> > +		return WIRELESS_11G;
>
> This 'else' is after 'return' as well, isn't it? Just wondering what's the
> difference between this one and others in this patch

Maybe it's nice to have the three options lined up?

julia
