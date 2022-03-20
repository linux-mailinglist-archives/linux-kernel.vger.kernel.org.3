Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECB4E1DCD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiCTVE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:04:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F6E59384;
        Sun, 20 Mar 2022 14:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7545EB80E0E;
        Sun, 20 Mar 2022 21:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52CCEC340E9;
        Sun, 20 Mar 2022 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647810206;
        bh=b6J0AaU317Tzh6IzUdIfF4nn+9FPVkNTnPYZOaj147k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MnX2Q1+s3Gg0F3AbRzSzJAGL0XDG4ustbeT9ttK/OtkyWuRBdUkYl0z5aZ1AfjfxA
         672qLJdiXc73sa9wq2izyW+5Ri+srhYAwZ3ZghL9A0mxCg4rFW2yzXRyfDTJhkTNza
         jNCjb8gMUD5O2HwnQfvCmKShTw2NSBWaEepfS2Q/YGxwzRx1ssO860QpzkMFsKVV48
         XPePNz0klm23tIWmT967FRlYmsT6pZABtNRH/sSxljdYiJeFQ4cd7IK6dNn3Ytv9qi
         2Gpkl9n1hRNuBcLvzg9yiGEtpNdolZpzsE2UoV94DVSc5axJxsTr909nf6G4byJO1/
         T0mnTehyJhfTw==
Date:   Sun, 20 Mar 2022 23:04:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] certs: Remove panic() calls from blacklist_init()
Message-ID: <YjeW2r6Wv55Du0bJ@iki.fi>
References: <20220311174741.250424-1-mic@digikod.net>
 <20220311174741.250424-2-mic@digikod.net>
 <CAHC9VhThwFbO83D8u09XmRRvQxft7fHZ+KPciGfmrBJNZA1wGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhThwFbO83D8u09XmRRvQxft7fHZ+KPciGfmrBJNZA1wGQ@mail.gmail.com>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 05:00:32PM -0500, Paul Moore wrote:
> On Fri, Mar 11, 2022 at 12:47 PM Mickaël Salaün <mic@digikod.net> wrote:
> > From: Mickaël Salaün <mic@linux.microsoft.com>
> >
> > Replace panic() calls from device_initcall(blacklist_init) with proper
> > error handling using -ENODEV.
> >
> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> > Link: https://lore.kernel.org/r/Yik0C2t7G272YZ73@iki.fi [1]
> > Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> > Link: https://lore.kernel.org/r/20220311174741.250424-2-mic@digikod.net
> > ---
> >  certs/blacklist.c | 27 +++++++++++++++++++++------
> >  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> I'm not sure we can safely rely on a non-zero error code saving us in
> the care of failure, can we?
> 
> The blacklist_init() function is registered as an initcall via
> device_initcall() which I believe is either executed via
> do_init_module() in the case of a dynamic module load, or via
> do_initcalls() if built into the kernel.  In either case the result is
> that the module/functionality doesn't load and the kernel continues on
> executing.  While this could be acceptable for some non-critical
> modules, if this particular module fails to load it defeats the
> certificate/key based deny list for signed modules, yes?
> 
> I completely understand the strong desire to purge the kernel of
> panic()s, BUG()s, and the like, but if a critical piece of security
> functionality that users expect to be present fails to initialize,
> panic()ing is likely the right thing to do.

OK, I get this. 

What this function should have is this information documented in
the header. Otherwise, this is just confusing.

BR, Jarkko
