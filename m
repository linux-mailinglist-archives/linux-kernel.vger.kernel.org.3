Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0029A4EB4AF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiC2U1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiC2U1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:27:16 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D33941300
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:25:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso13560835otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=SFrq+HkhY8EOOEHs10edXecMcSZIs6/OF4q1ev8rVPs=;
        b=ZXBiMuTCpQ95TzEDmK8L4ho9oCJZxa3gxbUmjHjcUOMxq5dmZfs5TpoLjnQuwQ80FF
         2QcUThWMORa98tz4xapDW4dUoPODp9zFLDZ7MrFvb4YTfttQ59Wzmr9reE/caETJokIu
         6jpSgmpt5IqfH7lZvEK8vTfhnfeDmn/WyKxXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=SFrq+HkhY8EOOEHs10edXecMcSZIs6/OF4q1ev8rVPs=;
        b=aYe6G2bNMcSDxYNCIshDlSrmujfuJKPGY43GTHkOEnMlsQiCdMgbBdYkLBGsO9mA12
         jfn6Q8nEdilgpm43mqKRK3DMRx+E++SqZNEL7WDPW5F0UtvCG6t122NI5Sk4BiOQ81hp
         TltgyLSwlKycEKsSefRTpyduHDKNyISetGMFrKfR+EkBSuM5L9hOFYFJ6Bwos30HS3A+
         YpBVsks3TgBD+GbnNmYfdhUekmf9kN6uF84qwb9kugFSJSNH+9sdmaSxx6nflbZOH6J6
         +Ko10Gcf3DnfGuZU+n6VqxJrU8CvHYFI5oJ+RMPy+DPr300ljKSOw+xy1IIpYEfZ5sIC
         IC8g==
X-Gm-Message-State: AOAM533sKgbI5ciRib9iKopRo+EFTiGYxuWpnf031sRQiXdAmjRJ9hMD
        JHnceqFEx2FalqpbVwpQZpkfHcw6tsfXYxKITYdfTg==
X-Google-Smtp-Source: ABdhPJwFap4yUqGDUQMinigojaLdGmmnd2GrXlRfBs04gEvioesOAE3NzyeFCZ3fpthNyz+tBYNsGF5TzhbGRtExpZU=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr1918913oth.77.1648585531687; Tue, 29 Mar
 2022 13:25:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Mar 2022 22:25:31 +0200
MIME-Version: 1.0
In-Reply-To: <20220327155147.52e898b4@jic23-huawei>
References: <20220324222928.874522-1-swboyd@chromium.org> <20220327155147.52e898b4@jic23-huawei>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 29 Mar 2022 22:25:31 +0200
Message-ID: <CAE-0n50T9uqcB9EK-RnGXPGhd6RWdrsE9pA5FJY9yC58xd=05A@mail.gmail.com>
Subject: Re: [PATCH v2] iio:proximity:sx9324: Fix hardware gain read/write
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Cameron (2022-03-27 07:51:47)
> On Thu, 24 Mar 2022 15:29:28 -0700
> Stephen Boyd <swboyd@chromium.org> wrote:
>
> > There are four possible gain values according to 'sx9324_gain_vals[]':
> >
> >       1, 2, 4, and 8
> >
> > The values are off by one when writing and reading the register. The
> > bits should be set according to this equation:
> >
> >       ilog2(<gain>) + 1
> >
> > so that a gain of 8 is 0x3 in the register field and a gain of 4 is 0x2
> > in the register field, etc
>
> Example seems wrong...
>
> ilog2(8) + 1 = 3 + 1 = 0x4
> ilog2(4) + 1 = 2 + 1 = 0x3
> ilog2(2) + 1 = 1 + 1 = 0x2
> ilog2(1) + 1 = 0 + 1 = 0x1
>                        0x0 reserved.
>
> or have I misunderstood?

Nope. I hit the wrong key but your table is correct. Can you fix it when
applying?
