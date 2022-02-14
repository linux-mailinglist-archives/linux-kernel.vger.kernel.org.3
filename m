Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3B94B4D12
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349805AbiBNKyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:54:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349616AbiBNKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:54:29 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2D27D023;
        Mon, 14 Feb 2022 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1644833982;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=/RNqZ6XDotK4+hH5HIHOFU3lzcpRUTrZvxsoPqCBBJY=;
    b=sDDyj2TZaq256WfhRwDUtNaoN5Zj8IwWD4DOK/8UTh9sejSsPTmEza9YdhMiB3EMGw
    w9l75qOJ+YBttR+/1HXxBPtm7qcBOVpqLXTUwmsDOorSJEspXTvjOkFPRxIr6VGfp71f
    waI43N4Et07SWWKHPOFrAOE8R9+U81pnhg5+Uf4IH3CM1NmtIFLAM9CfM3/tYmfNr/Wu
    +OQnQLqhxd3/g520JlTUNHJ2QH9x7ofwAQMYhhBlkUIkiY1FPXOwbAKJmQ0mtMlwm08d
    xV7+JkwMdx0FIrhoyKOeexVJysi2M+k12vwe+0eJv70cKV+Zru+fR6DZSQmPCb9uYVJJ
    A1Uw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3jcR+"
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.39.0 DYNA|AUTH)
    with ESMTPSA id L29417y1EAJfxt5
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 14 Feb 2022 11:19:41 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v15 1/7] drm/ingenic: Fix support for JZ4780 HDMI output
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <PQHA7R.CIX6XS4CFLMM3@crapouillou.net>
Date:   Mon, 14 Feb 2022 11:19:40 +0100
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Paul Boddie <paul@boddie.org.uk>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Harry Wentland <harry.wentland@amd.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        letux-kernel@openphoenux.org,
        Ezequiel Garcia <ezequiel@collabora.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD0193A3-4E97-4B26-9D1F-1CFAD5B18506@goldelico.com>
References: <cover.1644681054.git.hns@goldelico.com>
 <9d3a2000d2bb014f1afb0613537bdc523202135d.1644681054.git.hns@goldelico.com>
 <PQHA7R.CIX6XS4CFLMM3@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,


> Am 14.02.2022 um 11:13 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
> Hi,
>=20
> Le sam., f=C3=A9vr. 12 2022 at 16:50:49 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> From: Paul Boddie <paul@boddie.org.uk>
>> We have to make sure that
>> - JZ_LCD_OSDC_ALPHAEN is set
>> - plane f0 is disabled and not seen from user-space
>=20
> Actually it will still be seen from user-space, but it won't be =
possible to use it. So before applying I'll change this to:
> "plane f0 is disabled as it's not working yet"
>=20
> If that's OK with you.

Yes. You understand much better than me the implications...

BR and thanks,
Nikolaus

