Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC610598CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbiHRTst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbiHRTsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:48:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869FE5A813
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 12:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36149B82415
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 19:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07503C433C1;
        Thu, 18 Aug 2022 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660852114;
        bh=LbfCHFjKk6kzGgxEEUBJgU/bUqUM3IB8CCxE0P4a6bY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OzoOBygBfdk21arMXR12/gapkYCLUl5DIZIjGoyLdNfq6LLBUnayGq4VlmnHl323L
         iZx3xye5Bssk3Ez9gQME9SMvSAdHMUaNueGBEKGwyKqLyF/Z3A/8vDgmzU7vzj+YNw
         /dPIV2coNRspoY2u0ns/Kb+OTFDInFA9saWHLRn66nOcXEeVl1eXzOTBvbcjbhI3GX
         ueICF1IHxevnJkimJ5YUZ3bj14htoUYrdSQTyrUFmGovJVl1rh8VQd6p2LnCzKJO0C
         M1R/9YezXiYJoWBw/nhVmU/GAhwePb02Ze6VKUNtoKK31e03j8DEFjuqjYdhHvrBBJ
         bFRPejkcm5irw==
Date:   Thu, 18 Aug 2022 21:48:28 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        josef.schlehofer@nic.cz
Subject: Re: [PATCH linux-phy v2 1/4] string.h: Add str_has_proper_prefix()
Message-ID: <20220818214828.22023dc7@thinkpad>
In-Reply-To: <CAHp75VecURpGCBY3WVKqhd64Ngobjvi-w=PuHQBH2V-MqCzkuw@mail.gmail.com>
References: <20220817200335.911-1-kabel@kernel.org>
        <20220817200335.911-2-kabel@kernel.org>
        <CAHp75VecURpGCBY3WVKqhd64Ngobjvi-w=PuHQBH2V-MqCzkuw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 22:10:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 17, 2022 at 11:06 PM Marek Beh=C3=BAn <kabel@kernel.org> wrot=
e:
> >
> > Add str_has_proper_prefix(), similar to str_has_prefix(), but requires
> > that the prefix is proper: the string itself must be longer than the
> > prefix.
> >
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > ---
> > Andy, Kees, could you ack this if it is ok? =20
>=20
> Seems to me there are too many strlen():s. One is hidden in strncmp().

I thought this was ok cause gcc has optimizations for this in
https://github.com/gcc-mirror/gcc/blob/master/gcc/tree-ssa-strlen.cc

But now I see that kernel does not declare these functions as inline
that call __builtin_strlen()... so probably the optimizations are not
used.

> Besides not the good naming (what 'proper' means),

The naming comes from similar naming in math: proper subset is as
subset that is not equal to the superset. See
https://en.wikipedia.org/wiki/Substring :
  "A proper prefix of a string is not equal to the string itself"

> the entire function is not needed. You may simply call
>=20
>   str_has_prefix() && p[len] !=3D '\0';
>=20
> Correct?

Do you mean that I should implement this function to simply return
  str_has_prefix() && p[len] !=3D '\0'
or that this function should not exist at all and I should do that in
the code where I would have used the function?

Thanks.

Marek
