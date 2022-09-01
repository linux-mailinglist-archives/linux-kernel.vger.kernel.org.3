Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7445A8B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiIACM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiIACMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:12:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3FE990D;
        Wed, 31 Aug 2022 19:12:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y1so13930269plb.2;
        Wed, 31 Aug 2022 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=tiutLiA7GBbtplCbgudlUQfYaNKZDMZqwpjkfiSj9sI=;
        b=CKQN4i+DIZNhh7GvxOK+Edpy84OmR9FFbnxrMxy2jf52OA3nAW1TDhFzXJWGuXhpZb
         ADfYO56I1hc48HWGXjtLYBKSLN/sLEPNWVeMMdZH+KnU8SqlLX9RODeE19r3B3UttG9X
         NLj63aSbjwQNsqQ0LODmZ2AkZJ0aJ8hRlItprXw/aYIlNbgSzHeuKVb6a/kKlOhj/Owi
         GregrO+2V92XdQIId0eEt/Hq2PW1mCrq+FPlnzo1K/x40RdJtp/PeoVOH75469qOhrNr
         MdZ+K5sD3W3De8z1moq15oZA9HRBHBN3yQVCpXvq/G6hkl5HcORrElkz1tjFp+LnMrTj
         rqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tiutLiA7GBbtplCbgudlUQfYaNKZDMZqwpjkfiSj9sI=;
        b=Xq+OaIr7dfclbuE0lxM4KQROGI9ARw+DpjyYhSwBmwOruxrlpoJhYHVUtsLEhQsUW0
         9KDQmMzOgOiNWYDAJHqc9331YtwSWKiLP+i/qy3jSnTqKBqq3tJk5tSIVjySxbPUNNjQ
         2w/uh2T8F1ePedhl8mTvS7L1SBrhJoeqmDxsUjk6BZDSmzhU1sbo17eUc0h9lVQBYGl5
         m3RH0LY/lfX83HUQ+HHH43QOVNPlgnzYija1xl9kLbASXWInN7noJitIaak/aiFuBEBz
         gqbryK82MVyMwHfeuQVwr45UtM+SgWVQqWkrPvDnVdZZ4hxb8GSazZe+q8NXVPZD26r5
         QfyQ==
X-Gm-Message-State: ACgBeo3CgnjUhPced7yxILfgx6xlZ+iYX9A3QZ+j4TvTbiCD31RfQUbi
        Vg5Dw2N2S0BDDjqdkL3Df9c=
X-Google-Smtp-Source: AA6agR4wO1Y4TlpAN2rt/Rz4EaMyzi1tTFsP+zifx/pdp4rZW5opnC7kZKeQTCIW2sIL/fxzerA2lA==
X-Received: by 2002:a17:90b:4f44:b0:1fa:f63c:ea1b with SMTP id pj4-20020a17090b4f4400b001faf63cea1bmr6472718pjb.30.1661998341847;
        Wed, 31 Aug 2022 19:12:21 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:45ee:d53e:4a22:630d])
        by smtp.gmail.com with ESMTPSA id d35-20020a631d23000000b0042c2def703asm4031509pgd.22.2022.08.31.19.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 19:12:21 -0700 (PDT)
Date:   Wed, 31 Aug 2022 19:12:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH v4 3/3] input: misc: rt5120: Add power key support
Message-ID: <YxAVAt2eWB3NFlrk@google.com>
References: <1660100142-32493-1-git-send-email-u0084500@gmail.com>
 <1660100142-32493-4-git-send-email-u0084500@gmail.com>
 <Yw/lC9rjnbFW3ORC@google.com>
 <CADiBU38AuVW9yeFisKvK=_080tQzn-1PUxsDXH4p0QrA2AUSww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiBU38AuVW9yeFisKvK=_080tQzn-1PUxsDXH4p0QrA2AUSww@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 08:39:05AM +0800, ChiYuan Huang wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> 於 2022年9月1日 週四 清晨6:47寫道：
> >
> > Hi ChiYuan,
> >
> > On Wed, Aug 10, 2022 at 10:55:42AM +0800, cy_huang wrote:
> > > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > > +MODULE_DESCRIPTION("Richtek RT5120 power key driver");
> > > +MODULE_LICENSE("GPL v2");
> >
> > I changed this to be simply "GPL" (per checkpatch.pl, see commit
> > 'bf7fbeeae6db module: Cure the MODULE_LICENSE "GPL" vs. "GPL v2"
> > bogosity' for details) + did a couple of minor edits, and applied, thank
> > you.
> >
> Ok, got it.
> Old "GPL" text as GPL v2 or "later", and  the "later" keyword is the problem.
> This patch is to fix it.
> 
> How about the SPDX license string? The same definition?

No, MODULE_LICENSE() is sorely for symbol resolution during module
loading, so GPL vs GPLv2 or later, etc is all the same. SPDX denotes
the actual license for the source code that governs derivative works,
etc. and I did not change it - it is left exactly as you sent it:

// SPDX-License-Identifier: GPL-2.0-only

Thanks.

-- 
Dmitry
