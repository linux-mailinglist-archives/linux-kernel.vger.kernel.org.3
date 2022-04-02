Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854544F013F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 13:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350606AbiDBLro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 07:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344929AbiDBLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 07:47:41 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9F510240E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 04:45:48 -0700 (PDT)
Received: from dslb-094-219-034-140.094.219.pools.vodafone-ip.de ([94.219.34.140] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1nacCE-00019f-8u; Sat, 02 Apr 2022 13:45:34 +0200
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1nacCD-001Fxh-K1; Sat, 02 Apr 2022 13:45:33 +0200
Date:   Sat, 2 Apr 2022 13:45:33 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: Remove goto to no-op exit label
Message-ID: <Ykg3Xfb4vjjGSyKc@martin-debian-2.paytec.ch>
References: <20220401183513.26222-1-fmdefrancesco@gmail.com>
 <YkdjhGtMwnbJcz+P@iweiny-desk3>
 <1724388.VLH7GnMWUR@leap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1724388.VLH7GnMWUR@leap>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Fabio M. De Francesco (fmdefrancesco@gmail.com):

> > >  	pnpi = netdev_priv(netdev);

> > >  	if (!pnpi->priv)
> > > -		goto RETURN;
> > > +		return;

> I cannot see how pnpi->priv might ever be NULL.

Even if pnpi->priv was NULL, we wouldn't need the check. It's ok to call
vfree(NULL).

> After the two removals I've talked about above, the code will always call 
> vfree(pnpi->priv) and then free_netdev(netdev).

That makes sense.

Best regards,
Martin
