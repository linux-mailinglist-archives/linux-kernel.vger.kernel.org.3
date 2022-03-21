Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF7F4E2FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352126AbiCUSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350174AbiCUSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:25:35 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B2420F5B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:24:06 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b15so18913657edn.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Znlv0HuHzVHaeUAmdIRV55nsLLlzSzHPvRIX7fedcUo=;
        b=dZCkQITWm7aAaXjcdC9aaJGWOSDwwhmiHMzz4T9vFTAIrBgplBxfZm25g+walJOkE/
         s/1+FK3Q8iyr12mvERqN/SQqQAx8+ypB1IxkVGIV+lbjLfch6NahK1lz9WUKIGbWGR+O
         E8IS8fJy3WHAEZa0+eSiOxCHHFxFvaGzoT6eqWf2r56tqqoqrFu3VkO5TgA3xK9qS83K
         w2IIw1WGHDs8sRYaMoc2DFd1XNRIWbdYPKvYXJv0nfEchin0hxv2AgKt5z2XBcK6yq7K
         HzJG2S05OOtbPXSquUIJ7TEcM50PtjqiTEyoJkHNlHnL/pml7b0fEo0Pch55ynrJWRjB
         DxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Znlv0HuHzVHaeUAmdIRV55nsLLlzSzHPvRIX7fedcUo=;
        b=Noq47wZTHwnAWJ9AE4/Mzf5F9bePphO9WbBmJxLHEJWAGymEjlUX8Bsk7QAHHdlfvL
         YetVMl1zLhEFZhk0td//QKtkZUMsUkqKb7Yp9OqRp4rAnif54h9W5p3hOccYD8II4Z9Z
         PHNNdrdemgARp3Zrvxv0BQyDIEcU1OCtNMG5OGXMNU6aiwYPj/LtmMWljHV0ioFOtPpA
         wspRuEgsGXvtKzksZoQy/T7ALdQosunWXm0bhheh/dxvTqpNf2k1S29TsQKxqy6fVluz
         dphsVwD1cYjcgLyphAVy3Cj/fJiBzwttiShZfGpHRMos6Sko7TpU8rQIaFVcKGhy2HwQ
         5N0Q==
X-Gm-Message-State: AOAM533iDH/tzw44FeGCr2OCUkBvEXl+tXRahvMaiXlqi5wpFx2f/zy7
        N3JheX7gGhPRkJvOd+H09LNBWzHlpoCbFuq7UNKf
X-Google-Smtp-Source: ABdhPJxssqPmh+qHcCzxF3xsED5nNaiei08foUJkKVXI+HTgBGne1+hBjJb9fvtjCFtPaT8nVral3z+eTHU4RmFkNkk=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr24724801edc.232.1647887045389; Mon, 21
 Mar 2022 11:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220321174548.510516-1-mic@digikod.net> <20220321174548.510516-2-mic@digikod.net>
In-Reply-To: <20220321174548.510516-2-mic@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Mar 2022 14:23:54 -0400
Message-ID: <CAHC9VhR+Ss5VAUHLutTvyS8g+agZy7d0YGcu_9dV1LBx_8ifNQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] certs: Explain the rational to call panic()
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 1:45 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>
> The blacklist_init() function calls panic() for memory allocation
> errors.  This change documents the reason why we don't return -ENODEV.
>
> Suggested-by: Paul Moore <paul@paul-moore.com> [1]
> Requested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> Link: https://lore.kernel.org/r/YjeW2r6Wv55Du0bJ@iki.fi [1]
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220321174548.510516-2-mic@digikod.net
> ---
>  certs/blacklist.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

I would suggest changing the second sentence as shown below, but
otherwise it looks good to me.

Reviewed-by: Paul Moore <paul@paul-moore.com>

> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 486ce0dd8e9c..ac26bcf9b9a5 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -307,6 +307,14 @@ static int restrict_link_for_blacklist(struct key *d=
est_keyring,
>
>  /*
>   * Initialise the blacklist
> + *
> + * The blacklist_init() function is registered as an initcall via
> + * device_initcall().  As a result the functionality doesn't load and th=
e

"As a result if the blacklist_init() function fails for any reason the
kernel continues to execute."

> + * kernel continues on executing.  While cleanly returning -ENODEV could=
 be
> + * acceptable for some non-critical kernel parts, if the blacklist keyri=
ng
> + * fails to load it defeats the certificate/key based deny list for sign=
ed
> + * modules.  If a critical piece of security functionality that users ex=
pect to
> + * be present fails to initialize, panic()ing is likely the right thing =
to do.
>   */
>  static int __init blacklist_init(void)
>  {

--
paul-moore.com
