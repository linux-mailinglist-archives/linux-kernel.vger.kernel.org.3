Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5DF483B03
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 04:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiADDfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 22:35:47 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:47614 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiADDfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 22:35:46 -0500
Date:   Tue, 04 Jan 2022 03:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1641267343;
        bh=CtQiq4lflRfXZBK4qlNWgLY+8xhc4BjhH8iVZ3/Y3hs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:From:To:Cc;
        b=e8erSZ46x1E4Wc474MWY29MhGWwH4AXLAtxL7/jy08a0b5zfwSUsQV5eZkvudLf91
         KQwACSRHzKs0u9bi/UEH2C7fizGnhQDejKlVQUUxNTavpLUzNNP5Ji8JvJAJeXb7J/
         hc0h8y53A7BvjMYx5HrEGapInv2k2aU6ooYkk+YKw7WfNb1mveQ+28mm2Q1CidkCMV
         k+RzZ+BRQZOrP8WLHrWGx1b4p5vPA7koXTHWDTS9XKy/MxkUOeOQsjgRnwAxewSd+z
         MisQ57h6FtQytUMsnHuaKgmaRmcc+XzLPDpqPwEk5dHS13iLrodpQNjewNIrgo/aU+
         ISDGVCZc9ELkg==
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] ASoC: wcd9335: Keep a RX port value for each SLIM RX mux
Message-ID: <20220104033356.343685-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rx_port_value is a single unsigned int that gets overwritten
when slim_rx_mux_put() is called for any RX mux, then the same value is
read when slim_rx_mux_get() is called for any of them. This results in
slim_rx_mux_get() reporting the last value set by slim_rx_mux_put()
regardless of which SLIM RX mux is in question.

Turn rx_port_value into an array and store a separate value for each
SLIM RX mux.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/codecs/wcd9335.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index bc5d68c53e5a..1e60db4056ad 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -341,7 +341,7 @@ struct wcd9335_codec {
 =09int reset_gpio;
 =09struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
=20
-=09unsigned int rx_port_value;
+=09unsigned int rx_port_value[WCD9335_RX_MAX];
 =09unsigned int tx_port_value;
 =09int hph_l_gain;
 =09int hph_r_gain;
@@ -1269,10 +1269,11 @@ static const struct snd_kcontrol_new sb_tx8_mux =3D
 static int slim_rx_mux_get(struct snd_kcontrol *kc,
 =09=09=09   struct snd_ctl_elem_value *ucontrol)
 {
-=09struct snd_soc_dapm_context *dapm =3D snd_soc_dapm_kcontrol_dapm(kc);
-=09struct wcd9335_codec *wcd =3D dev_get_drvdata(dapm->dev);
+=09struct snd_soc_dapm_widget *w =3D snd_soc_dapm_kcontrol_widget(kc);
+=09struct wcd9335_codec *wcd =3D dev_get_drvdata(w->dapm->dev);
+=09u32 port_id =3D w->shift;
=20
-=09ucontrol->value.enumerated.item[0] =3D wcd->rx_port_value;
+=09ucontrol->value.enumerated.item[0] =3D wcd->rx_port_value[port_id];
=20
 =09return 0;
 }
@@ -1286,9 +1287,9 @@ static int slim_rx_mux_put(struct snd_kcontrol *kc,
 =09struct snd_soc_dapm_update *update =3D NULL;
 =09u32 port_id =3D w->shift;
=20
-=09wcd->rx_port_value =3D ucontrol->value.enumerated.item[0];
+=09wcd->rx_port_value[port_id] =3D ucontrol->value.enumerated.item[0];
=20
-=09switch (wcd->rx_port_value) {
+=09switch (wcd->rx_port_value[port_id]) {
 =09case 0:
 =09=09list_del_init(&wcd->rx_chs[port_id].list);
 =09=09break;
@@ -1309,11 +1310,11 @@ static int slim_rx_mux_put(struct snd_kcontrol *kc,
 =09=09=09      &wcd->dai[AIF4_PB].slim_ch_list);
 =09=09break;
 =09default:
-=09=09dev_err(wcd->dev, "Unknown AIF %d\n", wcd->rx_port_value);
+=09=09dev_err(wcd->dev, "Unknown AIF %d\n", wcd->rx_port_value[port_id]);
 =09=09goto err;
 =09}
=20
-=09snd_soc_dapm_mux_update_power(w->dapm, kc, wcd->rx_port_value,
+=09snd_soc_dapm_mux_update_power(w->dapm, kc, wcd->rx_port_value[port_id],
 =09=09=09=09      e, update);
=20
 =09return 0;
--=20
2.34.1


