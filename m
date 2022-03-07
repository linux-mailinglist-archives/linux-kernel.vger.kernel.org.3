Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0683C4D0C02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiCGX3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbiCGX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:29:30 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC2B50E20
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 15:28:33 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id jr3so13342346qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 15:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=csQ+GPOclCXQ3pU1PuTrUt8p8sL259wWZ7Rnzk5mnCU=;
        b=noo0jaS/K7u8+2GPbiawML/hW3YeiL1uGecEST0JeVyYVJWJaKUcOBSPq8pq2cuI91
         mgzcBCP930JQWsZbI3qOqvNnx9DQAFxJhnTBtmollG+IlxyVlP+kUmtbIEXem0+v1sC+
         89xKsCCW4Dma/LcytR+mwZ0WqkC3d2OEi0HqfCPEXy2PEm1HSo1VOZ9GUYOKbOaO0vIC
         NSGY9/8vjiB4GlrpKM5VnD64HR8oxJWP00wWWHlCpybl7DPlZvxzBXKSden4FD3Gd2D2
         48r5x52wDfh+ddLcmscSf6FHM+4oGj9SpJUsXVWBOW2LyTtuQGWeF5lE5UjOW3ezQkFC
         7edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=csQ+GPOclCXQ3pU1PuTrUt8p8sL259wWZ7Rnzk5mnCU=;
        b=0scO3fMgmYU9+YAu+5NgIfKBs6BG84NaKOLw8Fc2kXri8zKlJ2RBlYtm45bg1tOmWl
         o582izO9wDMABkdzYQPDn2Ml4V/TMCQkvtcmXqRZhjm09t9MFVHRMwLS8N7n16MZG8vX
         oEWUhTN8w7z8E9QxHuFbW2YU0Z41nlAVrKRRnRRUOLrKJPhHUvfZ2Lv3+TeByxIZMUkv
         xjm8BSbHoXYAKEJd/5IQLYdjBm+JeSmvxO+fa2sC/5ncVTdfQly2wVJO/a4FYjJ2dC/g
         ZGUhoZ6zActv+XPLE/XSfJp9+aw9RUg65mzxvRWyOx+NxtjwDSF5teB2vkHQYcw5WGEC
         2QRQ==
X-Gm-Message-State: AOAM532fdj/xhphTB5/6o4VSo5Y7rW2BW2Wsr9Wv3klzNizolSqqpqmo
        FgSy6ZmT/gH7Pt9m+CEhgYmY/Xiui1Q=
X-Google-Smtp-Source: ABdhPJxg9rMmhCg+15kobctRfYRvpnkPuhOLo6ovrB02ae2W+PLVWQAv84TT0qdIIvEHKvxvTBm2og==
X-Received: by 2002:ad4:5bc1:0:b0:42c:3700:a6df with SMTP id t1-20020ad45bc1000000b0042c3700a6dfmr10597008qvt.94.1646695712986;
        Mon, 07 Mar 2022 15:28:32 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id u13-20020a05622a14cd00b002d5e213eb93sm9217755qtx.14.2022.03.07.15.28.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:28:32 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2d07ae0b1c0so183188417b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 15:28:32 -0800 (PST)
X-Received: by 2002:a0d:e288:0:b0:2db:f50a:9d10 with SMTP id
 l130-20020a0de288000000b002dbf50a9d10mr10600121ywe.419.1646695711609; Mon, 07
 Mar 2022 15:28:31 -0800 (PST)
MIME-Version: 1.0
References: <20220307223126.djzvg44v2o2jkjsx@begin>
In-Reply-To: <20220307223126.djzvg44v2o2jkjsx@begin>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 7 Mar 2022 18:27:56 -0500
X-Gmail-Original-Message-ID: <CA+FuTSewYr+dXBzUVSMuwo3p39TvwozUAJ0MHMnxPUozxxwcnA@mail.gmail.com>
Message-ID: <CA+FuTSewYr+dXBzUVSMuwo3p39TvwozUAJ0MHMnxPUozxxwcnA@mail.gmail.com>
Subject: Re: [PATCHv2] SO_ZEROCOPY should return -EOPNOTSUPP rather than -ENOTSUPP
To:     Samuel Thibault <samuel.thibault@labri.fr>, davem@davemloft.net,
        kuba@kernel.org,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
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

On Mon, Mar 7, 2022 at 5:31 PM Samuel Thibault <samuel.thibault@labri.fr> wrote:
>
> ENOTSUPP is documented as "should never be seen by user programs",
> and thus not exposed in <errno.h>, and thus applications cannot safely
> check against it (they get "Unknown error 524" as strerror). We should
> rather return the well-known -EOPNOTSUPP.
>
> This is similar to 2230a7ef5198 ("drop_monitor: Use correct error
> code") and 4a5cdc604b9c ("net/tls: Fix return values to avoid
> ENOTSUPP"), which did not seem to cause problems.
>
> Signed-off-by: Samuel Thibault <samuel.thibault@labri.fr>

Acked-by: Willem de Bruijn <willemb@google.com>

From what I can tell, the first of the two referenced patches went to
net-next, the second one to net and stable. I would suggest only
net-next for this. Else, we should also add a Fixes tag.

Small nit, for future patches: preferred syntax is commit $SHA1
("subject"), including the commit keyword.
