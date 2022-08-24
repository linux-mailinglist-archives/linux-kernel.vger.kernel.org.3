Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65C5A006C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240179AbiHXRcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiHXRb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:31:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3017D797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:31:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ca13so23621395ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NRT6dfzfkfi+NLMeGizooZpE9maX11OCkJa4Z5bjB10=;
        b=RrNM63hFQuNodikVJqSybL0bp4O0dsufrM+sECvfH9W/QCiP6DlkUhO6AVc6GI/uLf
         b4WSf9Hy2tqzLCrPsS+Xf7JXJ4uumotTQUuUifuv2LMS5uIzUYnkzm+yk6Gq8UdsCi8s
         f02zTDeknEeBxz0ZFGol/mf2MswNl8P3QdXVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NRT6dfzfkfi+NLMeGizooZpE9maX11OCkJa4Z5bjB10=;
        b=WO6UoEEO1CDGVbjf7CUr4tv1/FunrsGMDz+8ZlEdVmekYOlyIo8AACPXT3G6OGKGeq
         KBUeG/vlsEP9BcVpQPG0LZW+b3MPTqX8/7XBr4t6Of1dLvl4AaO9gv9EDNhWZrhPk0t3
         w5lZlt5wj0OpiDAqmwHZxDvCNz/Pt8c3eTvFh+LzIaDysjrwuktfuDwA363FKVZ4T6Vk
         Je/FDBxrcUJVHAiU12eMXDlUI7dgKwck0WKKocYFht3zwc8MTmYzNED+o12ZA52c0UI2
         DY3kPq6P32vinAmkB8kesndXPaNhnjes2C7CER+9RstFlZWiU34Wlzs5zwpjWugH2U76
         KtMA==
X-Gm-Message-State: ACgBeo36NN15DRxhahcpL+89ZJs3IF1PcsNF9XtNkKepiM7sq/jUGjWD
        QiwRdENjiUlV/jyAAvibs/E49sPZRnvXiAuB
X-Google-Smtp-Source: AA6agR48sCqTxbgRVnEUpWAQFf2hOSYYynRPAVNsxjAFWKU+Tt+Duwt1ifVw5s6wbBjzQ/MlrCT/Vw==
X-Received: by 2002:a17:907:284a:b0:73d:a818:5a2a with SMTP id el10-20020a170907284a00b0073da8185a2amr14379ejc.159.1661362312839;
        Wed, 24 Aug 2022 10:31:52 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id oq11-20020a170906cc8b00b0073ae9ba9ba9sm1424595ejb.9.2022.08.24.10.31.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:31:52 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id z14-20020a7bc7ce000000b003a5db0388a8so2126844wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:31:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4ece:b0:3a6:28:bc59 with SMTP id
 g14-20020a05600c4ece00b003a60028bc59mr5865091wmq.154.1661362311628; Wed, 24
 Aug 2022 10:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220822141930.5f43b5e7@endymion.delvare>
In-Reply-To: <20220822141930.5f43b5e7@endymion.delvare>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 10:31:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFRok=hU_BNEsqodjyGm=XV9LVZ1w=cm4ooEtWVpYLPg@mail.gmail.com>
Message-ID: <CAHk-=wiFRok=hU_BNEsqodjyGm=XV9LVZ1w=cm4ooEtWVpYLPg@mail.gmail.com>
Subject: Re: [GIT PULL] dmi update for v5.19
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 5:19 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> Andy Shevchenko (1):
>       firmware: dmi: Use the proper accessor for the version field

I pulled this, but I kind of question it.

This replaces a single 32-bit memory access (and an optimized byte
swap) and a mask operation with three load-byte-and-shift operations.

It's not clear that the new code is better.

That said, I can't imagine it matters - but because I looked at it, I
note that the length check seems to be kind of iffy.

The code checks that the length of the block is < 32 before doing the
checksum on it, but shouldn't it also check for some minimum size?
Otherwise the dmi checksum is kind of pointless, isn't it?

It will access a minimum of 24 bytes for that dmi_base thing, so that
would be the most obvious minimum value. But maybe there is some
spec-defined size for that that only covers the header?

           Linus
