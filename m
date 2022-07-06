Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71E568F74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiGFQne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiGFQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:43:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3431582D;
        Wed,  6 Jul 2022 09:43:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso11004071pjo.0;
        Wed, 06 Jul 2022 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oraZyyvVir1700yNQVzrP9Zwaxp7xrxcJj7xCrbOwKY=;
        b=EfJh9o7U1fzaM7uW6JPnPBco1gx5afL8OEXdBvSEwnnQzDqzqN65FghE6rrrlQ2L3+
         p+Dpmz5ngc/Ntn6shHZm/lOtJEfedW0os2igAWzQR37X8hcZ2mpJBjSIEM3Su+YB8ggR
         NDR6nWv0pqQxrt/gpcDp1CBhiKkQBpST2EnW8i2hECHMUd4yb0oekQ+A+59+p5DdB2M9
         HRQyC99nu2wVuQp0CuL9qk4b4mz7oaFl42gUL2z5dA/gG7QCBZAdFPVfviLOe3u5zMes
         BeLQ9rQRBPQIIhcx2FvpZHMjFgb8pW+fn5nHqQaVW52Ua25EzRK5osDhv2Z9NxlJUe5s
         3hpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oraZyyvVir1700yNQVzrP9Zwaxp7xrxcJj7xCrbOwKY=;
        b=MEEBikBkpo/f5XHbxDtHFaap+Za40g3nU+o+ICTzPeQiC3DFo07YtBipR9Uhr5jGBL
         G9zilPRBoq9OFzwfC5ZF1ll3WV/fndl6mcwUKT6tIhjA6tuAYl8Ki95JTXd8qxbHPBM8
         Ojo8thCgohFB4PdgsULVKGvz3GJH188mm5NCA1pEAiED1DZemwx4b29fPKcg5AV4RXjn
         As/wr2dbYncCX8p/mVR4pvvumlr4IHnIQnpsJ3CbkBM2U6pkxTyAz1/IXNK3DNGLI2Dp
         5hJStcwA+YQOfg2vN4bKXLD8H9i0PbRvQ5OWFSX1G6fVNpeKeCsnlHMY1a0q4hCLL1jr
         rYZA==
X-Gm-Message-State: AJIora8SD1bV3cTJa0mBHxxsUkhM7tWJ4Vrc5kxoj3nBoq4UL4sG7mn7
        e2IZjRqsadF/YWbtPNq9IBU=
X-Google-Smtp-Source: AGRyM1skinJBZte4Q+yq3FR+y6tbCuPsShkOzB4+jvtzpcNoq/exAfYvBFN41bB15wIBO1q8dnwGig==
X-Received: by 2002:a17:90b:38c4:b0:1ef:84e0:90f5 with SMTP id nn4-20020a17090b38c400b001ef84e090f5mr23618932pjb.149.1657125808122;
        Wed, 06 Jul 2022 09:43:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x67-20020a628646000000b005252ab25363sm25121974pfd.206.2022.07.06.09.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:43:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Jul 2022 09:43:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Philippe Boos <pboos@baylibre.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] watchdog: meson: keep running if already active
Message-ID: <20220706164325.GA776177@roeck-us.net>
References: <20220705142444.17063-1-pboos@baylibre.com>
 <f756b2d5-56e7-6e52-2739-eca4bb33508b@baylibre.com>
 <1jmtdnwd7y.fsf@starbuckisacylon.baylibre.com>
 <20220706124139.GB492220@roeck-us.net>
 <1j8rp6z720.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1j8rp6z720.fsf@starbuckisacylon.baylibre.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 03:24:27PM +0200, Jerome Brunet wrote:
> 
[ ... ]

> 
> No worries. That being said, I have gone over 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
> 
> It just says that Reviewed-by sent on the list should be collected for
> the following version. Nothing against adding the tag if the job has
> been done, on or off list. Same goes for Suggested-by, Tested-by, etc.
> 
> If I missed something or it is non-written rule, please let me know.

Your interpretation is quite a strict one. I don't think there is a rule
that states that tags not sent to a list must not be collected.

Anyway, I would have called it common sense, especially since it does
happen that someone accidentally hits "reply" instead of "reply all"
and replies end up not being sent to the list. If you expect me to dig
through e-mail headers to determine if you meant your tags to be published
or not, sorry, that won't happen. Do not send me e-mails with any tags
unless you accept that they may be published.

Guenter
