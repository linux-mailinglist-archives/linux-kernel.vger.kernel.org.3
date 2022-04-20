Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456BE509316
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382984AbiDTWpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382968AbiDTWpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:45:39 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E352BB0B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:42:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkFzr5dD6z4xTX;
        Thu, 21 Apr 2022 08:42:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1650494554;
        bh=o602KQ/+agNDKL9zbAJn0li/P3xi6zOfUFviZ8GVtWA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YnyIJSjfggiqOcBnpaqnJxPQIU9gjrc8XhMQET/vTLn6XrgAJKxmDJ83Na9yAupO7
         sKCFl2RHCtdB561lmK224mYwiDZyw6lK1XsN9NeC187Q4v8MrVnfMAzlTfPfcXqB4v
         M8DwK6vhU64YTqCazpMHH6eMaOztsabNjZmwZQd3OatGbExtBCsCSHiHxtnHVrFivH
         yX4UBJTjOL3KCSBK3R8I5zB4UWNm2Va0gC4JHxEMjabJU9IjTkE2hCoy2RLQTtboi6
         HTiBLkhjZMv0ajpAfyOK+BQvm+ZyXJ6D7tWEpJbosO8g0nJUjbXa9z70KUT/U2BG7H
         EcIo6Kh3UMpGQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node
 assignment
In-Reply-To: <CACRpkdbqfNiWQG6ayqMXACby4xkW0pY6JhdYE-x+pWkSxJU5TQ@mail.gmail.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com>
 <Yk2PE7+oEEtGri95@smile.fi.intel.com>
 <CACRpkdbqfNiWQG6ayqMXACby4xkW0pY6JhdYE-x+pWkSxJU5TQ@mail.gmail.com>
Date:   Thu, 21 Apr 2022 08:42:30 +1000
Message-ID: <87fsm7fkbt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:
> On Wed, Apr 6, 2022 at 3:02 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Mon, Mar 28, 2022 at 03:16:08PM +0200, Linus Walleij wrote:
>> > On Wed, Mar 23, 2022 at 6:43 PM Andy Shevchenko
>> > <andriy.shevchenko@linux.intel.com> wrote:
>> >
>> > > Let GPIO library to assign of_node from the parent device.
>> > > This allows to move GPIO library and drivers to use fwnode
>> > > APIs instead of being stuck with OF-only interfaces.
>> > >
>> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >
>> > That's a nice patch.
>> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Thanks!
>>
>> Can we have this applied now?
>
> I think Michael Ellerman could help with this?
>
> Michael?

Yep, I'll pick it up when I start putting things into next.

That's usually the week after rc2, but I had a break for Easter.

cheers
