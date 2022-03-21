Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C04E351D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 01:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiCUX71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCUX7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:59:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7338628D295;
        Mon, 21 Mar 2022 16:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD7B0B81ACE;
        Mon, 21 Mar 2022 23:53:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B99CC340E8;
        Mon, 21 Mar 2022 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647906838;
        bh=cj/bg1sLNNaJqVbORGbd8V+TtcWsAd5DpPi34vxVBaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jG6Iugnvq9+d6FpMQh4OXsHDYag7OBVdmKGbPXMugx1nLVkFXiyjGHP4SzRll0IzV
         WZEf51AichSBMW4+Gdh9AvgLqBUX5O61NRj0ceCc8GRODHAx7Z2JTKCIt4zzNoW+Z6
         GxpRtL2Ay9j3e1spyAd5WEHRi/b1d4+JCWba3RfAK7kICHe6dpDnt1K5hno/9cklzi
         +nXWKcR5tToM7qwPcll7bLb2rs8LQfB/qLI1eEppJGbz4l2SUSN+RBXgKB6NBILqef
         /Gypl4G3TQk+syuMICPME9IbehTQ5ZZjO4pagqsRxoV+eadF95vyuRMfOsC32ngFw1
         yroKlFAIAqzvQ==
Date:   Tue, 22 Mar 2022 01:53:09 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v1 1/1] certs: Explain the rational to call panic()
Message-ID: <YjkP5d6e6SU8BPtO@iki.fi>
References: <20220321174548.510516-1-mic@digikod.net>
 <20220321174548.510516-2-mic@digikod.net>
 <CAHC9VhR+Ss5VAUHLutTvyS8g+agZy7d0YGcu_9dV1LBx_8ifNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR+Ss5VAUHLutTvyS8g+agZy7d0YGcu_9dV1LBx_8ifNQ@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:23:54PM -0400, Paul Moore wrote:
> On Mon, Mar 21, 2022 at 1:45 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > From: Mickaël Salaün <mic@linux.microsoft.com>
> >
> > The blacklist_init() function calls panic() for memory allocation
> > errors.  This change documents the reason why we don't return -ENODEV.
> >
> > Suggested-by: Paul Moore <paul@paul-moore.com> [1]
> > Requested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> > Link: https://lore.kernel.org/r/YjeW2r6Wv55Du0bJ@iki.fi [1]
> > Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> > Link: https://lore.kernel.org/r/20220321174548.510516-2-mic@digikod.net
> > ---
> >  certs/blacklist.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> I would suggest changing the second sentence as shown below, but
> otherwise it looks good to me.
> 
> Reviewed-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Mickaël, I think since your patch set was not huge in the first place, I'm
considering making it part of rc2 pull request while I normally try to
avoid any features after rc1. It's anyway throughly tested, and generally
has been around for a *long time*. I've even tested it myself a few times.

Just trying to be responsible as a maintainer and if something does not
feel right, I don't  try to pretend that "I get it", if you know what 
I mean. This fully clarifies "not getting it" part :-)

Thanks!

BR, Jarkko
