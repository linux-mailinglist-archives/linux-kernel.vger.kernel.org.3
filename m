Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318694CDBF6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbiCDSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiCDSQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:16:24 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5391C666E;
        Fri,  4 Mar 2022 10:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646417714;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=x6yMCnO3alKHl8bvpa17cTtqDXil1QBvA/YzB+Y6Jio=;
    b=Rj8qbuj7YIiU0M/7SG5kKIFQ3JnK+966RzkaaLQBG2xu/pazNpn72z+oRVfT8I6Zsq
    XtVVcAO35auaLxXyjbYPDNZdKh2oR5/qljD5epQ0eAwp/dXOlnlj8Ti4N1mcsIQ90wNb
    LtLjzDYLvE5aIVWGxu/u+WUOA8471FCPRIvYXZ3y6jAD7+lsxqznahPf8eHI4dZp2EFP
    dfSaXqQXya4EuDZbQHOIGxA+d0fq73wWL1AVYThBQEl2sN0YrAdSe1gNAKLKs/tr/Wpc
    WohBJRiArrZzvI83m+iqoVjsU+TFFEHhB+jveC0MF/8GMyE7bfxpQ8c3vVZWgfO5j8iX
    AxHg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7gpw91N5y2S3i8QUWw=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey24IFE7hV
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Fri, 4 Mar 2022 19:15:14 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [Letux-kernel] [PATCH v16 1/4] drm/bridge: dw-hdmi: introduce
 dw_hdmi_enable_poll()
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <8JF88R.9V5YQ3Q6E8QO2@crapouillou.net>
Date:   Fri, 4 Mar 2022 19:15:13 +0100
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Paul Boddie <paul@boddie.org.uk>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CC8B441-AA50-45F5-A5D3-2F40F72A1B50@goldelico.com>
References: <cover.1645895582.git.hns@goldelico.com>
 <e54838849f80454b863f9f5634dd10f79ef7bb8f.1645895582.git.hns@goldelico.com>
 <983e9064-17ad-e646-f37d-ca9173ba0967@baylibre.com>
 <C8AE9A7A-E288-4637-ACAD-40CD33CD5F8C@goldelico.com>
 <3E620AF4-402E-45EA-9D92-92EAEA9647F5@goldelico.com>
 <SHH68R.Z3J9KSY0GQVA2@crapouillou.net>
 <ABC1BD09-383B-4499-B034-340CE88725B3@goldelico.com>
 <RUI68R.Z009SPJAAD8N1@crapouillou.net>
 <F0F8F36B-3A0A-476C-8C7D-566255C629C6@goldelico.com>
 <a52702bd-c929-8170-8896-d34ba82aba3c@baylibre.com>
 <VYB88R.ATGIVGZ13PFM1@crapouillou.net>
 <929BF693-D54F-40F0-BB61-520301D1C31F@goldelico.com>
 <8JF88R.9V5YQ3Q6E8QO2@crapouillou.net>
To:     Paul Cercueil <paul@crapouillou.net>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> Am 04.03.2022 um 19:04 schrieb Paul Cercueil <paul@crapouillou.net>:
>=20
>=20
>=20
> Le ven., mars 4 2022 at 18:51:14 +0100, H. Nikolaus Schaller =
<hns@goldelico.com> a =C3=A9crit :
>> Hi Paul, Neil,
>>> Am 04.03.2022 um 17:47 schrieb Paul Cercueil <paul@crapouillou.net>:
>>> =46rom what I understood in Nikolaus' last message, HDMI hotplug is =
actually correctly detected, so there's no need for polling. What is =
missing is the call to drm_kms_helper_hotplug_event *somewhere*, so that =
the information is correctly relayed to userspace.
>> Exactly.
>> As Maxime pointed out it should already be called by =
drm_helper_hpd_irq_event() in dw_hdmi_irq() but isn't
>> because mode_config.poll_enabled isn't enabled.
>> So we can either
>> a) enable mode_config.poll_enabled so that it is called by =
drm_helper_hpd_irq_event() or
>> b) make drm_kms_helper_hotplug_event() being called explicitly in =
dw_hdmi_irq().
>>   We could guard that by mode_config.poll_enabled to avoid =
drm_kms_helper_hotplug_event()
>>   being called twice (but I think the "changed" mechanism will take =
care of).
>>> I think this issue can be fixed by calling =
drm_bridge_connector_enable_hpd() on the connector in ingenic-drm-drv.c.
>> I don't see yet how this would solve it, but it may work.
>=20
> dw_hdmi_irq() calls drm_bridge_hpd_notify(), which would call =
bridge->hpd_cb() if it was non-NULL.

Ok, this is a case c).

I vaguely remember having tried to analyse what bridge->hpd_cb is but =
stopped since it is NULL...

>=20
> Calling drm_bridge_connector_enable_hpd() will set the =
bridge->hpd_cb() callback to point to drm_bridge_connector_hpd_cb(), =
which itself will call drm_kms_helper_hotplug_event(). Therefore, all =
that is missing is one call to drm_bridge_connector_enable_hpd().

Ah, ok, I see.

>> Anyways, this all is a missing feature (sometimes called "bug") of =
the *dw-hdmi driver* and IMHO
>> neither of the connector nor the ingenic-drm-drv.

Well, a little more analysis shows that drm_bridge_connector_enable_hpd =
is called
in the *-drv.c for some other plaforms:

=
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/imx/dcss/dc=
ss-dev.c#L292
=
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/imx/dcss/dc=
ss-kms.c#L145
=
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/omapdrm/oma=
p_drv.c#L393
=
https://elixir.bootlin.com/linux/v5.17-rc6/source/drivers/gpu/drm/msm/hdmi=
/hdmi.c#L317

>> So I think it should not be solved outside dw-hdmi.

Hm. Can we call drm_bridge_connector_enable_hpd() from inside dw-hdmi?

Or would this be the solution if merged? (I currently can't try code).

=
https://lore.kernel.org/lkml/a7d0b013-6114-07b3-0a7b-0d17db8a3982@cogentem=
bedded.com/T/

BR and thanks,
Nikolaus

