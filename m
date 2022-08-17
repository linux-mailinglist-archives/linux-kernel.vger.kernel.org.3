Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F259711A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiHQO3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiHQO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:29:27 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D70DDE9D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:29:25 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id n21so10464035qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=nbI+k5DQHbTWrnCEgebBhMe02FygG1PsU1gqd/fMVzQ=;
        b=0iHMYg0kCRDW8yqhXS+ynKl/wauUqc5ln3Q+N+/vnttHptHNQjC8LPtSbNMVBNToQZ
         mG2rnVvxcZ9p3glmpKKS/KOx0OrrmYnG2ieDwB4AOMp7Aq/gtBGmYZbMo8buhWK/fKYn
         Y/L9B6L6dLg4WpDCUzMEopU6aVaa7cWDS3cdCTwP6Irk+szWOYD2Kp5AKwoBAoLualBm
         8wekDBT3vUtmKgbfztzwq8vp/mfW8X+EY3GlkqdFWSBuGDBa9+LvqQG6+NdbE2F2JpSr
         AWvyZcYLCI3ALNAQ0Asd2GEA8Wg/PpgzlyE7k5LuWyprQl3sDyX2HCW57YyjLF4p/aSn
         5Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=nbI+k5DQHbTWrnCEgebBhMe02FygG1PsU1gqd/fMVzQ=;
        b=IKXVO/yiE3eQo26BlI3R+y8G6hLk/dw7pQV8rXdekjsHN0bzsu1EVzYxGbdeyaDvyh
         Y66xFfo/owqnR5d6YSwUpuBW03DC6ftYlhQiNthR8Sj4Xo7jvfFxqvDU52w010Kjj6kb
         q3VjKPg9Kqqjpr6jn1CdHH7BWXftTRCys+7IHMn4f/uZ79jqKF6Qbfy2rH13P1MuAeup
         sQ/9ck7cJISIRpTCtp49bbIuL/U2JEJLYrlXxw9m4hkC0wohj8BVDcppfOS8v909yfqs
         5nexjKay4bzXuJeUh3IGdRqnxTFOQwgTTcmG9+T6SBZTdieoMa+9mlUsIJ8ke71rhDis
         xQ4A==
X-Gm-Message-State: ACgBeo38HU0p17qnAPmCSRe8116hTu9of3VjAL6OzTY3S5U5ND7kqeUP
        Kln6j7nNsNAk8z7A5QXDIiNQYw==
X-Google-Smtp-Source: AA6agR6C6mJevKTBi3H2YQPBbQVqiNBMdYN0rm8sN6vMAzMhaxKrVi45NNefk9toDAu3+nfmMuslpQ==
X-Received: by 2002:a05:620a:261d:b0:6bb:fa6:1ad6 with SMTP id z29-20020a05620a261d00b006bb0fa61ad6mr12091743qko.65.1660746564595;
        Wed, 17 Aug 2022 07:29:24 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id n6-20020a05622a040600b00339b8a5639csm13236130qtx.95.2022.08.17.07.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:29:23 -0700 (PDT)
Message-ID: <eef2fc413695cb96a5071627bfe44830f80cfe9e.camel@ndufresne.ca>
Subject: Re: [EXT] Re: [PATCH 1/3] dma-buf: heaps: add Linaro secure dmabuf
 heap support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Olivier Masse <olivier.masse@nxp.com>,
        "brian.starkey@arm.com" <brian.starkey@arm.com>
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "nd@arm.com" <nd@arm.com>,
        =?ISO-8859-1?Q?Cl=E9ment?= Faure <clement.faure@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>
Date:   Wed, 17 Aug 2022 10:29:22 -0400
In-Reply-To: <de46324d8fa8fb6a8dda4641e531d30842410744.camel@nxp.com>
References: <20220805135330.970-1-olivier.masse@nxp.com>
         <20220805135330.970-2-olivier.masse@nxp.com>
         <20220805154139.2qkqxwklufjpsfdx@000377403353>
         <7e61668164f8bf02f6c4ee166e85abc42b5ee958.camel@nxp.com>
         <20220812163922.v7sf3havi5dpgi5u@000377403353>
         <de46324d8fa8fb6a8dda4641e531d30842410744.camel@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

Le mardi 16 ao=C3=BBt 2022 =C3=A0 11:20 +0000, Olivier Masse a =C3=A9crit=
=C2=A0:
> Hi Brian,
>=20
>=20
> On ven., 2022-08-12 at 17:39 +0100, Brian Starkey wrote:
> > Caution: EXT Ema
> >=20

[...]

> >=20
> > Interesting, that's not how the devices I've worked on operated.
> >=20
> > Are you saying that you have to have a display controller driver
> > running in the TEE to display one of these buffers?
>=20
> In fact the display controller is managing 3 plans : UI, PiP and
> video. The video plan is protected in secure as you can see on slide
> 11:
> https://static.linaro.org/connect/san19/presentations/san19-107.pdf



just wanted to highlight that all the WPE/GStreamer bit in this presentatio=
n is
based on NXP Vendor Media CODEC design, which rely on their own i.MX VPU AP=
I. I
don't see any effort to extend this to a wider audience. It is not explaini=
ng
how this can work with a mainline kernel with v4l2 stateful or stateless dr=
ivers
and generic GStreamer/FFMPEG/Chromium support.

I'm raising this, since I'm worried that no one cares of solving that high =
level
problem from a generic point of view. In that context, any additions to the
mainline Linux kernel can only be flawed and will only serves specific vend=
ors
and not the larger audience.

Another aspect, is that this design might be bound to a specific (NXP ?)
security design. I've learn recently that newer HW is going to use multiple
level of MMU (like virtual machines do) to protect the memory rather then
marking pages. Will all this work for that too ?

regards,
Nicolas
