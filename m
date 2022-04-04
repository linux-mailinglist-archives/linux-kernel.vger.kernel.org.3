Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64FA4F186F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378551AbiDDPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378548AbiDDPbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:31:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E06125C46
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:29:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso2249433pjj.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYdLkpnPyZngOUeZn/lWuqKTc6z7uKg+rCuaLMiMRSc=;
        b=ZlGFBz+QAxW6mc1NL3lIxSAx855Zk+iZwgoqXuomMIcEcJoR8BzxRfrpd34fRuKg44
         X13qx0BYfm9/Mt3mW3wjTJh1hI4v3dFMmcwtp/8kk+/f7rWYN9oGt2zMFPm/8CsNUk6w
         GklHiSRfDYcCfYUvs7Fwq/SeaVkmrjlXBI16fRQylzfva90ac9g5ZXssdASocEnzvVNT
         WOvxVz5glovklgt1eTwh4IHje1EGFqRrlU4LJ590a2MSDuEuMxOLmVqNX3xVHUsOksxb
         ekewxmzbJVBMpsS22MVS/OdAmPo2+oYeD4yJMBeEkImJtrz/udmJOCHJBs3gw+JKDN3V
         Xewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYdLkpnPyZngOUeZn/lWuqKTc6z7uKg+rCuaLMiMRSc=;
        b=Vu/zML5eFkK2TzSPb/p8fTJ+rosYXun/ZS40keJZBjUN2oCh2f6m2TcmMM0weiTsnP
         v9NcSxQo2nrqvKAM+GPunr9PmaF0c/tRydATSjN/8rSFcB5j0abq59j2gbneXx2skFfS
         11R+wsgVLc4B6k5HWhG38gkFSVOwpd4eOvFTUULRKFND840BhKDj1xqqJor12JETF4fG
         FFF066yZb0rqNdsE43Skqy9UaFhD7VKsCcbLuLX7h9IuqHoROifIEVmqT1P7Yvsxkic+
         UD+ImgjaKm+ZJxVyx3AXz/SvSIDibJ2e0WXlLx9J7GnCGKNiaEe3xMyO0+x6eeAeyLwu
         3Oyw==
X-Gm-Message-State: AOAM5322nJi2EFaF+I+oKD1PoZQ0gUVytatP291qp4s3ULW5zawOA9Ec
        y/hIFYbwwswRdwU3N1jfrx6ci6b35gc3sgE///k=
X-Google-Smtp-Source: ABdhPJw9XMoIfKMRbk3XIvNIhtAvrlb2TSOCmuuImlQkXykuazD6i7HUF6W5/gXUNTZblUIirnDGjH+/dp4KBlxWLPI=
X-Received: by 2002:a17:902:d88f:b0:155:e660:b769 with SMTP id
 b15-20020a170902d88f00b00155e660b769mr231842plz.36.1649086194452; Mon, 04 Apr
 2022 08:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220404150442.934496-1-jan.varho@gmail.com> <YksMxDLxPZtuYlFm@zx2c4.com>
In-Reply-To: <YksMxDLxPZtuYlFm@zx2c4.com>
From:   Jan Varho <jan.varho@gmail.com>
Date:   Mon, 4 Apr 2022 18:29:18 +0300
Message-ID: <CAE2X=SxCwoKa1OpNAsy5FN1Ugeos3gaM4YX4K4uTWfkKBEr0pA@mail.gmail.com>
Subject: Re: [PATCH] random: fix add_hwgenerator_randomness entropy accounting
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 4, 2022 at 6:20 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > Fix by not crediting entropy if any input was consumed for fast init.
>
> Yea, I'd seen this and wasn't really sure what the correct fix was. My
> recent addition of `&& entropy < POOL_MIN_BITS` is a step in the right
> direction of making your fix the desirable path, since it makes it less
> likely that we'd wind up throwing away "good" entropy. So maybe it's
> time we do that.

Yes, but since it's a hwrng, hopefully it will supply more soon.

And like you say, the new condition makes it less likely to happen.

> This is untested, but if you want to test it and submit it at v2, I
> think it might be an okay incarnation of the lazy approach.

I thought about doing it that way, but the return value allows
checking that any input was actually used instead of fast init
completing in the mean time.

If you want I can do that.

Jan
