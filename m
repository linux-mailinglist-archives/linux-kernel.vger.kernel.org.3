Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E44E68A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 19:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352636AbiCXS2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352621AbiCXS2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 14:28:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6D7B7C60;
        Thu, 24 Mar 2022 11:26:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA0DE61AB9;
        Thu, 24 Mar 2022 18:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC3DC340EC;
        Thu, 24 Mar 2022 18:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648146418;
        bh=up9oP7zqNV212tSUvD9C7zUAWeokV+evSB4LintGnYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUbyaM0NZ7qowR+z1FSGEy7loNgmXo8C/Ky1gtC/r+F6YAfDwTNOEiMDKjEePTD7a
         9ALVU9dbI/cuMCiuYHBwJTcnPCU7+5cxw7gp1gqfgbb9PJylEd6cnIF+o3o+K5NxQ/
         nmLxj6gWLdeuqHLn1kLp/8vRahs9yrwb3ZzkV5nRzZodyuN1eRRa6Zog4MFaUT0BH1
         DHguxVE4ByIItAqRCNKdjTz2kOvexI44CDpGtp8yEcda4D/OD65yCYIcR0zwiFdK3J
         B41+JMa3fEwtYP4De1AyvwnzwdIsUYatSaXSOosL2U8xA2MwKMAePNlE5ndVxK0WxG
         iPvLGV/4NYYfw==
Date:   Thu, 24 Mar 2022 18:26:56 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <Yjy38Nl2wYf0L1eY@gmail.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
 <1648009787.fah6dos6ya.none@localhost>
 <CAHmME9rsvxczJrhPwRX6nyrh9NB2AuJqkEKrTLx-G-T1J6_czQ@mail.gmail.com>
 <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9ovJpdcuuZhNKrOTUc8XvKDDdC+axhAmOD9iESnRR7JqA@mail.gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 09:18:16PM -0600, Jason A. Donenfeld wrote:
> In light of that conclusion, I'm going to work with every userspace
> downstream I can find to help them fix their file-based seeding, if it
> has bugs. I've started talking with the buildroot folks, and then I'll
> speak with the OpenRC people (being a Gentoo dev, that should be easy
> going). Systemd does the right thing already.
> 
> I wrote a little utility for potential inclusion in
> busybox/util-linux/whatever when it matures beyond its current age of
> being half hour old:
> - https://git.zx2c4.com/seedrng/about/
> - https://git.zx2c4.com/seedrng/tree/seedrng.c
> So I'll see what the buildroot people think of this and take it from there.
> 

The example in random(4) needs to be fixed too, right?

https://man7.org/linux/man-pages/man4/random.4.html

- Eric
