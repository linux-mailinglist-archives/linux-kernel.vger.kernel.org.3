Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861E74C95DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiCAUSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238014AbiCAURx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:17:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A2189CC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:16:49 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d23so28745672lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IVJCWuEom0kHlh/OKXDsN3qCzQx/9M9wC7RTfclR0WE=;
        b=BpAEsMmHbz6DldI3lrXW/NoVL9h7Y1Bb3g4jW8C7mdmGyS8h6DJzcjMNPCcb5i0eTv
         U7LBxmxLpMxQLSdiNBGQ/nOQ2K++bwghf8WSxi5cejyHlrOc1Q0Y3NIYV/Er9JexFbTd
         wZkpV/0FlL02n71JKK++Oi+26AojFvTWPs3FE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IVJCWuEom0kHlh/OKXDsN3qCzQx/9M9wC7RTfclR0WE=;
        b=xIbO+0yaWkbHRomW+q+CuAhH54/dwJpxYs/VBu7oQ3NuZxfYs00ph6sEd0VKGeW1lU
         5UppwrMrPIIMEn2iq3GT8b/18/y1MpZn6Hsww2k17RtXKnyAqJ5sNHQNF14kNiCo5eOf
         GqrWWha+3uv946pc3if5F5iGRzl0BHvspUwtjkVEvQLwLGV9u3gBCxUG3e178WBGL/mM
         jh7KZcJ4I51pk62Fc7yTCn12+bUWzGBGoV3wt9wa3Gzeqi36+2qZufWH1U8JGneHPiuI
         f/IDMK7DFENG/5JhtDDkjygVZqhq5PDGWKAFFw/9YxqesoHkVvklRQTvLQIiBBmVLMNd
         a4xw==
X-Gm-Message-State: AOAM530NFd4nunb3bBSgxt3rDKiiQVL4xLPwFgo7PCRVbmywSoqIf9+W
        jOJiq84e8SXn3s7SAXdH+7jbUBdcdrn6iTX56Jg=
X-Google-Smtp-Source: ABdhPJzle4beAQadMnWFBgNCs+o9H/6ibm+EG5RNOsy7EhdfUL4eor1ZXrqLb/XmrCHxZqydcweUYg==
X-Received: by 2002:ac2:5fc2:0:b0:443:82cf:9603 with SMTP id q2-20020ac25fc2000000b0044382cf9603mr16488968lfg.142.1646165807502;
        Tue, 01 Mar 2022 12:16:47 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u8-20020ac251c8000000b004458c1d1462sm1393738lfm.142.2022.03.01.12.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:16:45 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id g39so28747519lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:16:45 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr16012940lfh.531.1646165804889; Tue, 01
 Mar 2022 12:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20220301075839.4156-2-xiam0nd.tong@gmail.com> <202203020135.5duGpXM2-lkp@intel.com>
In-Reply-To: <202203020135.5duGpXM2-lkp@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 12:16:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVF0SeV2132vaTAcL1ccVDP25LkAgNgPoHXdFc27x-0g@mail.gmail.com>
Message-ID: <CAHk-=wiVF0SeV2132vaTAcL1ccVDP25LkAgNgPoHXdFc27x-0g@mail.gmail.com>
Subject: Re: [PATCH 1/6] Kbuild: compile kernel with gnu11 std
To:     kernel test robot <lkp@intel.com>
Cc:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, kbuild-all@lists.01.org,
        Arnd Bergmann <arnd@arndb.de>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 10:00 AM kernel test robot <lkp@intel.com> wrote:
>
> All warnings (new ones prefixed by >>):
>
> >> cc1: warning: result of '-117440512 << 16' requires 44 bits to represent, but 'int' only has 32 bits [-Wshift-overflow=]

So that's potentially an interesting warning, but this email doesn't
actually tell *where* that warning happens.

I'm not entirely sure why this warning is new to this '-std=gnu11'
change, but it's intriguing.

Instead it then gives the location for another warning:

>    arch/mips/pci/pci-rc32434.c: In function 'rc32434_pcibridge_init':
>    arch/mips/pci/pci-rc32434.c:111:22: warning: variable 'dummyread' set but not used [-Wunused-but-set-variable]
>      111 |         unsigned int dummyread, pcicntlval;
>          |                      ^~~~~~~~~

but that wasn't the new one (and that 'dummyread' is obviously
_intentionally_ set but not used, as implied by the name).

Is there some place to actually see the full log (or some way to get a
better pointer to just the new warning) to see that actual shift
overflow thing?

              Linus
