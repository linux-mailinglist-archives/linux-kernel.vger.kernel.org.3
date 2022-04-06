Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611694F6C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiDFVIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiDFVIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:08:16 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BC778FE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 12:45:52 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id w141so204927qkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrpjkiliU8wPY1XOQv+OUkzSsJhLMBGEY6gnsrt3l58=;
        b=kxZaaA0a0zGP6wg8qCMsSM7Ow8BFElXrCpRHQgAp5FPFjUto5oZhr7nRL88c+WFvMB
         nIHrrF7qWy8o70ZDCCV6hYbpzfH9cLJgPKx6KqeD+zMoxSg/At62gIKgd4GNdlenfy/N
         CkKP/FGqJungTP3BiUOLrZ/Y9CmzcgKI1Fa4QgTS4gAYAFbPRkgKvXEG4lBDfckmbNMd
         JgFmmojWoLEZ6hr0xSJNzrM6uupJgj2LC6gbj5dv/DLnLWrKCANN7QF5RCOKCmXAUcaI
         6g4AdhPqhH7AJR0v2g5URzDtDsng0hdGf8TMBgeKyCXzRaLpSE6TkByavNh1RYeFcJav
         ZbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrpjkiliU8wPY1XOQv+OUkzSsJhLMBGEY6gnsrt3l58=;
        b=6bUIezrO8w5MpelR05pmaH9UZh3yzNvWb+Y6LxcILLzITelCvKA6S9a3r6wYnx9uAd
         oVxGQ1lBQMwp7MsQ6v486+GPM3leOnXvebDfGXe8OX4le5RXFjDn0NXY+smQ/xJOba8X
         w1ax688ZLV7BQW3pDegtqN6rtmOcCiz3gsD1r+fy+wLSrRsHI7BfsESPkby2xSvf39D0
         1dRrUgViXuQwDO5piRPRzEHEMFOJwg1Ikuz742ix6xktog4l/jSYowp6YdFDZVC5YOz5
         cvfeyV0TSPCoU6p18KPqsxjkyseRRZa65YfcYLIP1+kKoZ8bIkK9yCVXLNS9XMQDFQ29
         rDJQ==
X-Gm-Message-State: AOAM530lQX/9BGRjJY7S5GTK20xd4WC9ltjCdeNSQUvbAIGcN165q1Qu
        s8dmsMh0Qop1dxRPxXRQsRU6SdUqsvY=
X-Google-Smtp-Source: ABdhPJzicqEcq6eaEnoZ7Brk+o2P9PjBdTaxIqml/OAOTSyY3KpAx2TFX5BYrsad4Gl+7Lx+cS5rGA==
X-Received: by 2002:a05:620a:2699:b0:47d:753c:b8ff with SMTP id c25-20020a05620a269900b0047d753cb8ffmr6773415qkp.763.1649274351527;
        Wed, 06 Apr 2022 12:45:51 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id bl22-20020a05620a1a9600b00680da570a5dsm11388415qkb.61.2022.04.06.12.45.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 12:45:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2eb888cf7e7so38209547b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 12:45:50 -0700 (PDT)
X-Received: by 2002:a81:12c9:0:b0:2eb:83e7:c3fd with SMTP id
 192-20020a8112c9000000b002eb83e7c3fdmr8574499yws.351.1649274349858; Wed, 06
 Apr 2022 12:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220406192956.3291614-1-vladimir.oltean@nxp.com> <20220406192956.3291614-2-vladimir.oltean@nxp.com>
In-Reply-To: <20220406192956.3291614-2-vladimir.oltean@nxp.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 6 Apr 2022 15:45:14 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdK4T7DBf9wi3GjXA6P9o+6X-7c5vh9V0BN40GwbKSeGw@mail.gmail.com>
Message-ID: <CA+FuTSdK4T7DBf9wi3GjXA6P9o+6X-7c5vh9V0BN40GwbKSeGw@mail.gmail.com>
Subject: Re: [PATCH 4.14 1/2] ipv6: add missing tx timestamping on IPPROTO_RAW
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 3:30 PM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> [ Upstream commit fbfb2321e950918b430e7225546296b2dcadf725 ]
>
> Raw sockets support tx timestamping, but one case is missing.
>
> IPPROTO_RAW takes a separate packet construction path. raw_send_hdrinc
> has an explicit call to sock_tx_timestamp, but rawv6_send_hdrinc does
> not. Add it.
>
> Fixes: 11878b40ed5c ("net-timestamp: SOCK_RAW and PING timestamping")
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

For 4.14.y cherry-pick:

Acked-by: Willem de Bruijn <willemb@google.com>

Might be good to point out that this is not only a clean cherry-pick
of the one-line patch, but has to include part of commit a818f75e311c
("net: ipv6: Hook into time based transmission") to plumb the
sockcm_cookie. The rest of that patch is not a candidate for stable,
so LGTM.
