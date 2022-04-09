Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC714FA951
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239943AbiDIPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiDIPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:39:52 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC21AE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qSAd225M961dn+WkBnENZ0S8iDdzBuda9tOMKouPLss=;
  b=vOiUMr0h2cq52oDuERvHs4ZaBVcfR84QTX8JxgbvtYFZXtIYzldUuZLd
   f+DLVg6BZd6WIFzqEOqoH32xNvKYftdU0ya9dZsLsANA1grbkK+lKKcOx
   xXuWcRR0og+kj0YTvW3v3lBP9+CSYjIF82WZHAoT5l9Xf0rH8XzopdpGx
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,248,1643670000"; 
   d="scan'208";a="30916323"
Received: from unknown (HELO hadrien) ([109.190.253.16])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2022 17:37:39 +0200
Date:   Sat, 9 Apr 2022 17:37:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     =?ISO-8859-15?Q?J=E9r=F4me_Pouiller?= <jerome.pouiller@silabs.com>
cc:     Jaehee Park <jhpark1013@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Stefano Brivio <sbrivio@redhat.com>
Subject: Re: [PATCH] staging: wfx: use container_of() to get vif
In-Reply-To: <1911301.taCxCBeP46@pc-42>
Message-ID: <alpine.DEB.2.22.394.2204091737130.2655@hadrien>
References: <20220407204128.GA1810425@jaehee-ThinkPad-X1-Extreme> <alpine.DEB.2.22.394.2204081149360.2196@hadrien> <20220408222102.GB2511628@jaehee-ThinkPad-X1-Extreme> <1911301.taCxCBeP46@pc-42>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1289766131-1649518660=:2655"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1289766131-1649518660=:2655
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Sat, 9 Apr 2022, Jérôme Pouiller wrote:

> On Saturday 9 April 2022 00:21:02 CEST Jaehee Park wrote:
> > On Fri, Apr 08, 2022 at 11:49:49AM +0200, Julia Lawall wrote:
> > > On Thu, 7 Apr 2022, Jaehee Park wrote:
> > >
> > > > Use container_of() to get vif. This improves the code in two ways:
> > > > [1] it speeds up the compilation because container_of() saves steps to
> > > > retrieve vif (the representation of ieee80211_vif), and
> > >
> > > I don't understand this part.
> > >
> > > julia
> > >
> >
> > Thank you for your message. I revised the commit message (below)--
> > I hope it makes it clearer. I'm open to suggestions as well!
> >
> > Currently, upon virtual interface creation, wfx_add_interface() stores
> > a reference to the corresponding struct ieee80211_vif in private data,
> > for later usage. This is not needed when using the container_of
> > construct. This construct already has all the info it needs to retrieve
> > the reference to the corresponding struct from the offset that is
> > already available, inherent in container_of(), between its type and
> > member inputs (struct ieee80211_vif and drv_priv, respectively).
> > Remove vif (which was previously storing the reference to the struct
> > ieee80211_vif) from the struct wfx_vif, define a macro
> > wvif_to_vif(wvif) for container_of(), and replace all wvif->vif with
> > the newly defined container_of construct.
> >
> > Sorry if I'm putting out more information than was asked for:
> > Diagram is worth a thousand words; this one is made by Stefano when
> > he was explaining the container_of() construct:
> >
> > .-----------------------------------.
> > |  .------------------------------. |
> > '->| struct ieee80211_vif         | |
> >    |------------------------------| |
> >    | 1                            | |
> >    | 2                            | |
> >    |  .--------------------------.| |
> >    | 3| struct wfx_vif drv_priv   | |
> >    |  |---------------------------| |
> >    |  | ...                       | |
> >    |  |                           | |
> >    |  | struct ieee80211_vif *vif---'
> >    '------------------------------'
> > In this example, the offset is 3.
> > What I want to convey here is the compiler already knows the offset
> > of drv_priv within struct ieee80211_vif by using the container_of()
> > construct. So, it doesn't need to do extra work.
>
> Wow, nice ascii art :)
>
> I think that Julia has not understand why you said it "speeds up the
> compilation". I think you meant "speeds up the execution", don't you?

Yes, that was my concern.

julia
--8323329-1289766131-1649518660=:2655--
