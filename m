Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A8357B4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbiGTK5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiGTK5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2212964E06
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658314658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3tIBK3odCi2wiUtSPbriFkXsk8gcjLDaLnSU7OmMoI=;
        b=HmfGrUKwwpI6bvs6h9+YxX7Nm4B22VrGpntTxQ+dSaDbI5gbgChK/Ca+1vUU08b3EVP8FQ
        4wHo4M/8O3zdmElIorRLcqiGjeCPjyeMgR1scJ/JcqABvdT9iNeOrui+OGNdIfOJPqYqfX
        ps4gv8nghYnPkaaKrZo8JfAfBZhDl/s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-4mdOZp7wOuSDFH7uUYgbLw-1; Wed, 20 Jul 2022 06:57:37 -0400
X-MC-Unique: 4mdOZp7wOuSDFH7uUYgbLw-1
Received: by mail-ed1-f70.google.com with SMTP id bs1-20020a056402304100b0043ad1e84611so11984532edb.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=L3tIBK3odCi2wiUtSPbriFkXsk8gcjLDaLnSU7OmMoI=;
        b=QX6NhzxHtxHTC692FPRUqSPRUZjc1QFrJjrGCXN0UP2meEevR7FRT7STu1lwxWZNg1
         +ulaaMQzF2RiXY2jq9wVFSp2/dQ+0DUbFM9Pcinn2Qe4i+cOJzG55nmcEGyg4A0IgWzg
         K1SIXwOkbo9P/gjnDBe4+H/Wv2A2F0goDZsW9OgN6L6Tp5V42Rbxf84pfEt1jXXBtxEF
         Xwkhpm1Q6off307daxQMEKZcTjsVgOS4h8x5dC0MUMDd18gSzF8gPZBeEomNbLGD7z5u
         F76s9dUIN8YoGnizh7yuoSPGcQaDHDwy78Ku4NgQrVDNi6sR04Zxmr6FC1vC00Oy9r4b
         zNdA==
X-Gm-Message-State: AJIora9OgVaa/ATHAbnvp1QJzt/vJlMEpkIcDrB0Fw+F4Hr4xfWP582Y
        QUEKtiYn3FZO0NXAKlSL0RZqY6fNKly5EKLQzXWzvJ5BTGUvTMh0wLwKq3ETTXL/dfgVvJA1PWr
        O2jW1PApFQG6x9nxxpYiLx8N6
X-Received: by 2002:a05:6402:1cc8:b0:437:a61a:5713 with SMTP id ds8-20020a0564021cc800b00437a61a5713mr2233487edb.340.1658314656425;
        Wed, 20 Jul 2022 03:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uDdXKfV3xVrIkUIckfn6yUw5ELuqmmf+oZ2zwhtsXXU1rrwGdBmLWNy+ePIewka02ZjThKhw==
X-Received: by 2002:a05:6402:1cc8:b0:437:a61a:5713 with SMTP id ds8-20020a0564021cc800b00437a61a5713mr2233452edb.340.1658314656095;
        Wed, 20 Jul 2022 03:57:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402320800b0043bb8023caesm1031429eda.62.2022.07.20.03.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 03:57:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8C22B4DA011; Wed, 20 Jul 2022 12:57:34 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Linus =?utf-8?Q?L=C3=BCssing?= <ll@simonwunderlich.de>,
        Adrian Chadd <adrian@freebsd.org>,
        Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Kalle Valo <kvalo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sven Eckelmann <sven@narfation.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mac80211: Fix wrong channel bandwidths reported for
 aggregates
In-Reply-To: <31e87fa2-6fea-5fe2-ab80-6050da9af7ce@simonwunderlich.de>
References: <20220718222804.21708-1-linus.luessing@c0d3.blue>
 <CAJ-VmomaQ-ai7n5i8-8sXsgaih4vjjHXyw+JQESGMERgC8Qqdw@mail.gmail.com>
 <31e87fa2-6fea-5fe2-ab80-6050da9af7ce@simonwunderlich.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jul 2022 12:57:34 +0200
Message-ID: <87cze0kq5d.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus L=C3=BCssing <ll@simonwunderlich.de> writes:

> On 19/07/2022 17:03, Adrian Chadd wrote:
>> Hi!
>>=20
>> It's not a hardware bug. Dating back to the original AR5416 11n chip,
>> most flags aren't valid for subframes in an aggregate. Only the final
>> frame has valid flags. This was explicitly covered internally way back
>> when.
>
> Ah, thanks for the clarification! I see it in the datasheet for the=20
> QCA9531, too, now. And thanks for the confirmation, that what we are=20
> doing so far is not correct for ath9k.
>
> Words 0+2 are valid for all RX descriptors, 0+2+11 valid for the last RX=
=20
> descriptor of each packet and 0-11 for the last RX descriptor of an=20
> aggregate or last RX descriptor of a stand-alone packet. Or in other=20
> words, word 4, which contains the 20 vs. 40 MHz indicator, is invalid=20
> for any aggregate sub-frame other than the last one. I can rename that=20
> in the commit message.
>
>
> Another approach that also came to my mind was introducing more explicit=
=20
> flags in cfg80211.h's "struct rate_info", like a RATE_INFO_BW_UNKNOWN in=
=20
> "enum rate_info_bw" and/or RATE_INFO_FLAGS_UNKNOWN in "enum=20
> rate_info_flags". And setting those flags in ath9k_cmn_process_rate().
>
> The current approach is smaller though, as it simply uses the already=20
> existing flags. If anyone has any preferences, please let me know.

I have no objections to doing it in mac80211 like you're proposing here :)

-Toke

