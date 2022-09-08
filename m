Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47625B1252
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIHCCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiIHCCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28DAE239
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662602549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GjfEsUaHMfzHi5IAlxBstxq1c6LM3vW3A0uBM7qUHYs=;
        b=cVB2iSgNMg9x4v2VoNpyu8EzB9GUCAsCvyp9eDVKjoD1jC9ZGrDDkCYlOs0w4k5X6bbW4i
        k6g9bwUuqc3he3ABaOjkWVmXfZr5V1d2EXEW68styGNH1o4GZni5EnBFsF4kTe4u13VkGF
        /ExVSZ447jpsw0gG6oIU1agi1eMNjFw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-Ct0DK_35Nsu6g187hVoYOw-1; Wed, 07 Sep 2022 22:02:26 -0400
X-MC-Unique: Ct0DK_35Nsu6g187hVoYOw-1
Received: by mail-yb1-f199.google.com with SMTP id u12-20020a25094c000000b006a9ad6b2cebso4676157ybm.15
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 19:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GjfEsUaHMfzHi5IAlxBstxq1c6LM3vW3A0uBM7qUHYs=;
        b=LVdLdsttlkxl8N+2qNlMlLEPbkj0iGzOuvR7EvccuHr4mAcr1oBEy/L90NzcUZ7jcv
         SDWcUrWYmp4zq/99cpCJpojEj9gz+jayRQA47Ga3w+T/U7J0T05mYpPCcJ2kH0i8uwvN
         CNdhSh/iqv/tLw4qCn09UblLKUvrDJwywbgrSrpNerHCu/4qkacRCj1rTHcoJ882yK1X
         jIJtZw5KSJSGPIeq9G2WyWC6XX34JgypbFTC5W3pGMJJDhcVEFJN0IvWERvw6P7pv/Qa
         BDARMtvHwamLN7O1euhbX4NZ1rbZtWMa9vuAuonOpj/BH9Wlv7f4aOMWK3oqGixmdxbg
         cTkw==
X-Gm-Message-State: ACgBeo2cNXG6f2zXQct6VEw+viFpDdetfQ4JzvjOJNCccaJ7EMD3XlOP
        iBrQBXEiLy/buGdaFJsuybSCIaXsJa5ykkABDAnh38EKMK28N+GB+nRnQzoKCo0DKX17B6nOztC
        3v8AJwG8B2OXPN2D2vH/3ungP6F6WXUz3hIJOfGZw
X-Received: by 2002:a81:892:0:b0:345:3873:36e4 with SMTP id 140-20020a810892000000b00345387336e4mr5729589ywi.249.1662602545650;
        Wed, 07 Sep 2022 19:02:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4+T3GDchJFTil6rYC+k2C3e0KB6ejdT/dDcUQqKgjob00o6B04iojRGphbGviSqYgspdGJOnn2xYLI9NMsyrY=
X-Received: by 2002:a81:892:0:b0:345:3873:36e4 with SMTP id
 140-20020a810892000000b00345387336e4mr5729573ywi.249.1662602545440; Wed, 07
 Sep 2022 19:02:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220830070339.494695-1-tcs_kernel@tencent.com>
In-Reply-To: <20220830070339.494695-1-tcs_kernel@tencent.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 7 Sep 2022 22:02:14 -0400
Message-ID: <CAK-6q+iGfyKdcXRy5Qq+71D=BE2NbXPNSjx6YELr1HO0RYYk-g@mail.gmail.com>
Subject: Re: [PATCH V2] net/ieee802154: fix uninit value bug in dgram_sendmsg
To:     Haimin Zhang <tcs.kernel@gmail.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haimin Zhang <tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 30, 2022 at 3:03 AM Haimin Zhang <tcs.kernel@gmail.com> wrote:
>
> There is uninit value bug in dgram_sendmsg function in
> net/ieee802154/socket.c when the length of valid data pointed by the
> msg->msg_name isn't verified.
>
> We should check the msg_namelen is not less than struct
> sockaddr_ieee802154 when addr_type is SHORT before calling
> ieee802154_addr_from_sa. So we define IEEE802154_MIN_NAMELEN.
> And in function ieee802154_addr_from_sa, when
> addr_type is LONG, we check msg_namelen is not less than
> sizeof(struct sockaddr_ieee802154). Meanwhile we check in the
> beginning of function dgram_sendmsg.
>

There exists also an IEEE802154_ADDR_NONE addr_type.

We need to first check that space is there to evaluate the addr_type.

If it's NONE, ignore hwaddr or short address. If it's SHORT or hwaddr
check if they have space for it, if it's something completely
different return -EINVAL.

There are still missing bits and I would recommend introducing a
helper function to do this "kind" of more complex check. This patch
spreads different checks around by checking on IEEE802154_MIN_NAMELEN
(which isn't correct, because NONE) and then requires another check by
calling ieee802154_addr_from_sa() and checking the return code.

- Alex

