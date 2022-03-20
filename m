Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308A64E1DD4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343671AbiCTVHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:07:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3717F13509A;
        Sun, 20 Mar 2022 14:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9F0CB80ED5;
        Sun, 20 Mar 2022 21:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3719C340ED;
        Sun, 20 Mar 2022 21:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647810371;
        bh=2Y1L25cyDv1k+8KPOElCQuifEV1cbJm3AJmJUGFUNxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NmDbPyY3wwW5vgsTvIQk0ZNiMgGNVH8wLP++BsJ+CMN2HVy8HFf9MqMjyDbAO5gVw
         Ki+Q/BiVs4Qm0OQQdSnsQsrqUm26lo8He4TMGbXR7LWUpLLaR5w+FkWISltUUMqT55
         8za3JmOMwo8YKJTbQSu2q/k7Cdyyq6b9VKLh2tJ6JArYrEN2Y1C1WT5OiryVusGZUF
         v5ldBF7E3WhUEQ0APiFEf6+IzMf3yXd/n1DtWAYrYiQtHzLbdluRjeqcFWXN1eCh12
         mhRUApsNvU2Fq4lCIMpTJ1yziN0THCMUdSpsRAOjUF6RXDcFDjh6DrvwxmeslH73hR
         RY6uOm/rxjiLA==
Date:   Sun, 20 Mar 2022 23:07:12 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] certs: Remove panic() calls from
 system_trusted_keyring_init()
Message-ID: <YjeXgEbUE+X7bshR@iki.fi>
References: <20220311174741.250424-1-mic@digikod.net>
 <20220311174741.250424-3-mic@digikod.net>
 <YjLk5p1ej3JwFdaJ@iki.fi>
 <57a2e3ef-5baa-16ef-7865-245134a26e25@digikod.net>
 <42caa9d0-a069-8c6e-314f-7ec87ad95b7f@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42caa9d0-a069-8c6e-314f-7ec87ad95b7f@digikod.net>
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 09:31:10AM +0100, Mickaël Salaün wrote:
> 
> On 17/03/2022 09:30, Mickaël Salaün wrote:
> > 
> > On 17/03/2022 08:36, Jarkko Sakkinen wrote:
> > > On Fri, Mar 11, 2022 at 06:47:41PM +0100, Mickaël Salaün wrote:
> > > > From: Mickaël Salaün <mic@linux.microsoft.com>
> > > > 
> > > > Replace panic() calls from device_initcall(system_trusted_keyring_init)
> > > > with proper error handling using -ENODEV.
> > > > 
> > > > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> > > > Link: https://lore.kernel.org/r/Yik0C2t7G272YZ73@iki.fi [1]
> > > > Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> > > > Link: https://lore.kernel.org/r/20220311174741.250424-3-mic@digikod.net
> > > > ---
> > > >   certs/system_keyring.c | 26 ++++++++++++++++++++------
> > > >   1 file changed, 20 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > > > index 05b66ce9d1c9..428046a7aa7f 100644
> > > > --- a/certs/system_keyring.c
> > > > +++ b/certs/system_keyring.c
> > > > @@ -148,8 +148,10 @@ static __init int system_trusted_keyring_init(void)
> > > >                     KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH),
> > > >                     KEY_ALLOC_NOT_IN_QUOTA,
> > > >                     NULL, NULL);
> > > > -    if (IS_ERR(builtin_trusted_keys))
> > > > -        panic("Can't allocate builtin trusted keyring\n");
> > > > +    if (IS_ERR(builtin_trusted_keys)) {
> > > > +        pr_err("Can't allocate builtin trusted keyring\n");
> > > > +        return -ENODEV;
> > > > +    }
> > > >   #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
> > > >       secondary_trusted_keys =
> > > > @@ -161,14 +163,26 @@ static __init int
> > > > system_trusted_keyring_init(void)
> > > >                     KEY_ALLOC_NOT_IN_QUOTA,
> > > >                     get_builtin_and_secondary_restriction(),
> > > >                     NULL);
> > > > -    if (IS_ERR(secondary_trusted_keys))
> > > > -        panic("Can't allocate secondary trusted keyring\n");
> > > > +    if (IS_ERR(secondary_trusted_keys)) {
> > > > +        pr_err("Can't allocate secondary trusted keyring\n");
> > > > +        goto err_secondary;
> > > > +    }
> > > > -    if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0)
> > > > -        panic("Can't link trusted keyrings\n");
> > > > +    if (key_link(secondary_trusted_keys, builtin_trusted_keys) < 0) {
> > > > +        pr_err("Can't link trusted keyrings\n");
> > > > +        goto err_link;
> > > > +    }
> > > >   #endif
> > > >       return 0;
> > > > +
> > > > +err_link:
> > > > +    key_put(secondary_trusted_keys);
> > > > +
> > > > +err_secondary:
> > > > +    key_put(builtin_trusted_keys);
> > > > +
> > > > +    return -ENODEV;
> > > >   }
> > > >   /*
> > > > -- 
> > > > 2.35.1
> > > > 
> > > 
> > > Changes make sense to me but you should implement all this to the
> > > original
> > > patch set.
> 
> Do you mean to squash these two patches together?

You could squash function documentation to the corresponding
patch addressing the use of panic() so that we know why things
are done against normal status quo.

BR, Jarkko
