Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB095652F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbiGDLDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGDLDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:03:16 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04BCDD0;
        Mon,  4 Jul 2022 04:03:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so7735829wmp.3;
        Mon, 04 Jul 2022 04:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version;
        bh=tcELFetdYGA2DUMvfbpy/EbdVD0LihfAQ4JNPb6Poww=;
        b=TTnj9RnTY/Fil7PCVEcwlz/5zbedogy6o3+qZn4x4ph014UGq1I8N/4ije3jqjdWyH
         PqhdysPAM5VKsiRpCQoiHjgR7B0M+3JZCy7KjgpR9YYGSOm4T+wMR4nMnf3l8btVz1IT
         8XTN+2pb/DUQEHumEXsx9fWiqiclpDvZd/EG0orzFet/0UzpkQPXpUfvK4pGVOM7QNqR
         xQzr3ulVUJOTEvE+Vno9l5tlMeeroyyf48UQASHZgQu76/FvdncVGWNRz4tD3irTQLNm
         ctiLIbvZQgVj5foxb7EkisN+yIDR2PrLt/v5x7qgKUtsfrQ701qOeLdJrIe7jUzWfPmQ
         M6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=tcELFetdYGA2DUMvfbpy/EbdVD0LihfAQ4JNPb6Poww=;
        b=qukgMBasuoBtLQUoZ0+TpYH8e3D9hAPj9tV5YAWMZEYUmO/6Mn902LO5BvFglxAHiB
         DjmyYvqksk7Tgf7NLoWP2ZJnjk+SGFfSzGGY0eaqPEmuP/wH5TsznOFD9jj6cle6Vi6L
         D1TLURhoMC0mUJpaurbKBLHYV3gBYA3Rc/umu/QNZN6QJ1yxxIOTY6fcbnraA3/WXhJ5
         fwEr4ILddBsoeUnMvgoLYexShSam4hL5xXzI1V+QoSHhdeanfKEdIL8379TO7cuSP1F7
         RR50FWP6mzbk9lCLTSjnrR3L00Y3oM7TBEjekt8E0cLISSJ7PMEdEJR4X7ykC86EMPA1
         ujKQ==
X-Gm-Message-State: AJIora8KTQItQtkimi3a0bMTpQ07d2YAuOuRriezcSqQVJCn4C64oEzx
        b+fYC80wwNbn+fKoTLVw0GI=
X-Google-Smtp-Source: AGRyM1tXgagNme9jWgH4512rljB9jn/pOVDZPYpFUxLXkdosIaPbcj3rI9+d70jI/s9usfstzfVJww==
X-Received: by 2002:a1c:f60f:0:b0:3a0:3e0c:1de1 with SMTP id w15-20020a1cf60f000000b003a03e0c1de1mr33084700wmc.56.1656932594082;
        Mon, 04 Jul 2022 04:03:14 -0700 (PDT)
Received: from localhost (92.40.202.48.threembb.co.uk. [92.40.202.48])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm29358435wrr.101.2022.07.04.04.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:03:13 -0700 (PDT)
References: <20220703112101.24493-1-aidanmacdonald.0x0@gmail.com>
 <CAHp75VdjPVzOQ15S93GDnYz3cUFkHF-sF97f5GhoDEHdM+iFDQ@mail.gmail.com>
 <YsLCRvuy8G6W6qku@sirena.org.uk>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] regmap-irq cleanups and refactoring
Date:   Mon, 04 Jul 2022 11:58:41 +0100
In-reply-to: <YsLCRvuy8G6W6qku@sirena.org.uk>
Message-ID: <LIUiHsmHaJNAcy8tSd153xDy2GYqEjG8@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Brown <broonie@kernel.org> writes:

> On Sun, Jul 03, 2022 at 04:27:49PM +0200, Andy Shevchenko wrote:
>
>> Obviously you haven't rebased it on top of
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/log/?h=for-5.20
>> so it may not be applied.
>
> Yes, please send incremental patches against what's already applied.

Alright, I'll send a patch along shortly. I thought it was fine to drop
patches from -next if problems show up so I had assumed it was better to
just replace the series.
