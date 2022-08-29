Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990B25A5279
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiH2RBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiH2RBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:01:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9109B9A9BE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:01:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so10965043edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 10:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=bTARlCeOibrBAZlTV6Fk9ACuYXQ1cVcNl7i+g8mazqU=;
        b=hVzqRNsdQaTATFlTRZEAUtegZzrniojbBze7lC0I1DCFGyj6BkyQ5+0ggqZhq7zSSU
         6zy7RkbawwAYK000WcoS4z9DbiDoTtUzmOPxwjv5oeD3bBDK4xrd2tMZamPQsOvGfnNa
         UpB9OXBiQo3k2aWxOmoOL5iUfv0LCkTMr3iyb59yIqgyN01+zKEJu1xTJsbfHqDZK05h
         X+jAloKUs5wfYSVw8Q7s4Ql2Snaj6uXlu/EJ7yoJfmF1RPB/1UlQynzfsSmZU7vLktoD
         c+/Dmzo7x0JhxUkbT1OAsiGFb9etA7VWwcvKSzGLX+vse77NW3ypLtFoJCpKrJrXQB2r
         PrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=bTARlCeOibrBAZlTV6Fk9ACuYXQ1cVcNl7i+g8mazqU=;
        b=BJ9sUZ13lRPJVyF+csa44G7FExkjaBWzgfAgWiwnXNjprpTEUqscbUINZsz/N/5mfW
         5egzz8SmPhlwssn6dyKtgUbbtU7d3X93Pi1TXaG9xmNereH+uRH//tGYoG6t3gBf80bW
         HdkNULmBN1PbDPq+Ghr35kXaD4qpggSm/w8Dz5OjqazBav4342JMLYvCg9w+KctBohvx
         Ou8TdX0aIOnn22yzuDsjSyGXR5YB1UM6uRLiStv83/tOlBL6PosVtEznZIQXP2UcdRgI
         KJoUc3PY8a9WySQ24iydKXwZvtT7dEv6UC7iM93R0fc4TEBtpV0LPiIEmO6mMHNEMyJ/
         a0JQ==
X-Gm-Message-State: ACgBeo3iQIIp/cPgkDTFVEB8Sv3QT039pjChH2aEAQsK7Nq0hlOcWsoy
        TeuXKblCRzN+JEzgNBz9cIJgNg==
X-Google-Smtp-Source: AA6agR4R+kKRn6AXknM8I0Gcw14CKYwx4jBXyZeW4PcPSqKr5gZ/66Zs3WorLAtQqLsDEX0N1uLleg==
X-Received: by 2002:a05:6402:138f:b0:43d:8ed5:c841 with SMTP id b15-20020a056402138f00b0043d8ed5c841mr17596592edv.27.1661792500845;
        Mon, 29 Aug 2022 10:01:40 -0700 (PDT)
Received: from smtpclient.apple (ip5b434222.dynamic.kabel-deutschland.de. [91.67.66.34])
        by smtp.gmail.com with ESMTPSA id gl10-20020a170906e0ca00b0073dbfd33a8dsm4697277ejb.21.2022.08.29.10.01.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 10:01:40 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <YwzerCnjvTKsEyIi@sirena.org.uk>
Date:   Mon, 29 Aug 2022 19:01:38 +0200
Cc:     =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>, wens@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <479AFACA-866E-4B3B-B0C2-ABA83591DA56@kohlschutter.com>
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com>
 <YwzerCnjvTKsEyIi@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 29. Aug 2022, at 17:43, Mark Brown <broonie@kernel.org> wrote:
>=20
> On Thu, Aug 25, 2022 at 09:28:42PM +0000, Christian Kohlsch=C3=BCtter =
wrote:
>> Previously, an unresolved regulator supply reference upon calling
>> regulator_register on an always-on or boot-on regulator caused
>> set_machine_constraints to be called twice.
>=20
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
>=20
> Please don't send new patches in reply to old patches or serieses, =
this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep =
track
> of what current patches are, both for the new patches and the old =
ones.

My apologies, I wasn't aware that's not the preferred way forward.

Following up with "regulator: core: Fix regulator supply registration =
with sysfs", see
=
https://lore.kernel.org/all/20220829165543.24856-1-christian@kohlschutter.=
com/

