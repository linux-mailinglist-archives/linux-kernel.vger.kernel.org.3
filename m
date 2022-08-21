Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE759B4CF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiHUPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 11:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUPFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:05:04 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14B71581D
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:05:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j21so11525783ejs.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=h6HHRBszP1qSaglLBv4CHXp3Ol6/zrgby+DBPe5JflQ=;
        b=KDbmyK/uIIxxyzEqWmqcf7+9xsTBsInN0VwwzclaFHULK/BQNdFv/BKQGPCpuVyzUR
         kveviZ3z7NG/PRoBHBHJXm4rdlBzkVTbge7TyonLodwLUJb0wx6HdqHMKmR704AQ1BWo
         U5fS7iFzaBjzyWXYiAD3U7KP1YGqlTJInD8gXJDPJeIl12Cp3NOMry26wNutT2ayUL7i
         gUXZivwnydcFQMZcuSifKewMhSCY3KoH4b9SstDyUiwpvm0SCPPk6aNxGBzM8AueetFd
         qq69p7x07z9Op0944xhAHX1lzt4Bcz7qiwzI4wLDKYe1ff9pfoZdSSRQ9ChRWnxIXpiT
         MEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=h6HHRBszP1qSaglLBv4CHXp3Ol6/zrgby+DBPe5JflQ=;
        b=0JtSLVFCVdtNO4g4Cw3Li7OHLBD+zS7LtR2KkxKHuB3kC0O7+uPlZoZY5DS5DRJelb
         ygdzz4EVOhONZsd3SJctGRqHK4g0HvPKmICR7fyjrqWqP3/3nbkLSe2P38/BoXMK4acc
         OcCm7qaMkxfyyuyH7QY24wvpvt/F8jpkCUCkVXeQ4pt4yk5wtPBRiQB3M6cTE5yXKBN+
         pgYDRyCgWIlVZ3zBf8WlYkR2TdA417lZT3KRocAvTLsF43t10/P1rum4s3emc+j6EfHk
         yyEtTqf9GdyOQss5tofdx+cnwiOehuKsYVgktf4gMIr6i5fTZ958LCCe5D3js1B8T0+g
         GHxA==
X-Gm-Message-State: ACgBeo3YdnZtdNq/cOR+pSj+LWYqcxr2ZOSUhzoc23olPEigFq4ot9Km
        ZxZEjd1j5ZYbXc0ktEgpha0=
X-Google-Smtp-Source: AA6agR57fGQU2gSgrO8yJKl/jul1Q0zkPKgEf+Zuu+ozmwRZ8HdyGhfl0YB1gAfKwsD2lQJIs+6wXg==
X-Received: by 2002:a17:907:3e21:b0:730:92bb:7fcd with SMTP id hp33-20020a1709073e2100b0073092bb7fcdmr10369285ejc.170.1661094302340;
        Sun, 21 Aug 2022 08:05:02 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906200200b0072aa009aa68sm4994409ejo.36.2022.08.21.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 08:05:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date:   Sun, 21 Aug 2022 17:04:51 +0200
Message-ID: <5595912.DvuYhMxLoT@opensuse>
In-Reply-To: <c0d5e4c2-512f-3d6e-b555-8a87b1be1db5@grimberg.me>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com> <c0d5e4c2-512f-3d6e-b555-8a87b1be1db5@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=C3=AC 18 agosto 2022 13:45:49 CEST Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>=20
> Fabio, did you run blktests?
>=20
> The simplest thing you can do is:
>=20
> $ git clone https://github.com/osandov/blktests.git
> $ cd blktests
> $ nvme_trtype=3Dtcp ./check nvme

I just run the tests you requested.
I'm going to send a v3 patch which shows the results.

Thanks,

=46abio



