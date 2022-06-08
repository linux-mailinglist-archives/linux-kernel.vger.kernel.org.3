Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39233542CA2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiFHKIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiFHKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26201A65C3;
        Wed,  8 Jun 2022 02:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D442661A36;
        Wed,  8 Jun 2022 09:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9EBC3411C;
        Wed,  8 Jun 2022 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654681867;
        bh=sH3Vdk1XxP7lXEyXGE5VL4w6OlidDdN7xfcuFi3i3os=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Gl/cfyAklpvMDV286oPV2n7HVBbiSKqCuBVe0WviCdDJP9DrKspX8IQhcVEtdiEmm
         AaZH0nEraZUCX4iUDDXgqvE/TB6K7b558BO5wWfBvmqP76dntUzoYrb7f1Pgp+BhWd
         Sr1z0fiTCAVbLSATOnjyRUpOapaof2etdIR4mY5dBpqNTxzk6mRNA3qfiSUh7B68Nh
         57ndVZR5KHqs4yADtEZhXjyAcU0deE/EDVKqN5IDOc1Mf+fM4pNS8vNLgsf6f5O0/E
         V6qx5tgUffqHjkVgNeT7K1/IOnVZ6DotJDD107vh8kSTfmcTsAAMzNa02M2W0Rn38n
         dK9Rl1ZNegWIg==
Date:   Wed, 8 Jun 2022 11:51:03 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefanberzl@gmail.com, dlatypov@google.com,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v3 0/4] Add support for XP-PEN Deco L
In-Reply-To: <20220606101237.GA939277@elementary>
Message-ID: <nycvar.YFH.7.76.2206081150060.10851@cbobk.fhfr.pm>
References: <20220531181246.190729-1-jose.exposito89@gmail.com> <20220606101237.GA939277@elementary>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jun 2022, José Expósito wrote:

> > This patchset adds support for the UGEE XP-PEN Deco L tablet.
> > This device belongs to a family of tablets that must receive a chunk of
> > magic data in order to be enabled (named UGEE v2 internally).
> >
> > [...]
> >
> > ---
> > 
> > v1 - Initial version
> > https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/
> > 
> > v2 - Fix some errors reported by the kernel test robot:
> > 
> >  - Add MODULE_DESCRIPTION/LICENSE/AUTHOR to hid-uclogic-rdesc-test.c
> >  - Remove unused variable in uclogic_params_ugee_v2_init
> >  - Add sparse __force anotation in the result of cpu_to_le16
> >  - Add DISABLE_STRUCTLEAK_PLUGIN for KUnit tests
> > 
> > https://lore.kernel.org/linux-input/20220518224702.1409327-1-jose.exposito89@gmail.com/T/
> > 
> > v3 - This version:
> > 
> >  - Improve Kconfig message
> >  - Add .kunitconfig. Thanks to Daniel Latypov for suggesting it in an
> >    unrelated patch:
> >    https://lore.kernel.org/dri-devel/CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com/
> 
> As mentioned in the v3 changelog, I'm working on a DRM patch including
> a few KUnit tests [1].
> 
> Some interesting highlights from the comments there:
> 
> - It looks like the maintainers prefer to include a single symbol [2]
> to enable all tests in the subsystem.
> 
> Jiøí, Benjamin, how would you like to handle it? Would you prefer to
> have a symbol for each test (HID_UCLOGIC_KUNIT_TEST)? Or a symbol for
> all tests (HID_KUNIT_TEST)?

I don't really see any benefit in breaking it down to per-driver tests, so 
yes, please hide it all under one unified HID_KUNIT_TEST as far as I am 
concerned.

Thanks,

-- 
Jiri Kosina
SUSE Labs

