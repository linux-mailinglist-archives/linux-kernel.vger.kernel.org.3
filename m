Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383CB5A762F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiHaGFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiHaGFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:05:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02123275FF;
        Tue, 30 Aug 2022 23:05:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B39616FF;
        Wed, 31 Aug 2022 06:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517AEC433C1;
        Wed, 31 Aug 2022 06:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661925914;
        bh=SGYtE+p3Dtu7fXMJkMnYtZQdjKI8+lz4apBzmE24BwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Leas9ssnKXdkrL04JMj7MN3/F8Ky+L1na54faAV9IGDg7hCXKUJZGk3Vb+tBt2dKN
         LGrhWBJ97gERfM/oo4YvDmIiUM7KGaC+m02IHuXg5TVtgSYRIQu8z8ql+E9FRX75ZV
         A+J5D+7S942nrwBEKrpqkjb4/cnFp/9VMJ+KSIwo=
Date:   Wed, 31 Aug 2022 08:05:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 3/3] HID: avoid runtime call to strlen
Message-ID: <Yw76KBJ2+uulyC/Q@kroah.com>
References: <20220830205309.312864-1-ndesaulniers@google.com>
 <20220830205309.312864-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830205309.312864-4-ndesaulniers@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 01:53:09PM -0700, Nick Desaulniers wrote:
> While looking into a CONFIG_FORTIFY=y related bug, I noticed that
> hid_allocate calls strlen() on a local C string variable. This variable
> can only have literal string values. There is no benefit to having
> FORTIFY have this be a checked strlen call, because these are literal
> values.  By calling strlen() explicitly in the branches of a switch, the
> compiler can evaluate strlen("literal value") at compile time, rather
> than at runtime.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/hid/hid-input.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 48c1c02c69f4..9ad3cc88c26b 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1922,12 +1922,15 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid,
>  		switch (application) {
>  		case HID_GD_KEYBOARD:
>  			suffix = "Keyboard";
> +			suffix_len = strlen(suffix);
>  			break;
>  		case HID_GD_KEYPAD:
>  			suffix = "Keypad";
> +			suffix_len = strlen(suffix);
>  			break;
>  		case HID_GD_MOUSE:
>  			suffix = "Mouse";
> +			suffix_len = strlen(suffix);

<snip>

This seems ripe for someone to come along and go "look at this cleanup
patch where I move all of this duplicated code to below it in one line!"

As this is a compiler bug, why not fix the compiler?  Or at least put a
comment in here saying why this looks so odd to prevent it from being
changed in the future.

thanks,

greg k-h
