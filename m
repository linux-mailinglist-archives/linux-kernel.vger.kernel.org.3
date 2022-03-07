Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F794CEF9A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 03:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbiCGCZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 21:25:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiCGCZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 21:25:28 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091405B8B9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 18:24:34 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220307022432epoutp04d4b90a95fd483ed1a04bf442bbd98425~Z_Ay-UjWy3026430264epoutp04M
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:24:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220307022432epoutp04d4b90a95fd483ed1a04bf442bbd98425~Z_Ay-UjWy3026430264epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1646619872;
        bh=+RIzp4jVjDc1Eu24ddfYbcp5A5wycc7JP/1zMmUQDQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dalfez9h3vN5su8pZUfnxCplMTE7nFt5drKoEuJAWHSDmXxulKVyZw9V1z+49Vc7S
         RXWAf6opZM3UXCbDwdQ2Iy3vNGFOKAGCqmKTFBS5svgpkIVd1uJmI4KaLm1KUIFf3D
         i8aJW20BdmE+CHGB+39xf0pdVc+EtIKo+zvpCfi4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220307022430epcas2p35c7c8e5994dcd6588f04cd78ee347236~Z_AxeSAeB0807208072epcas2p3q;
        Mon,  7 Mar 2022 02:24:30 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.88]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KBj2f2ClXz4x9Q9; Mon,  7 Mar
        2022 02:24:26 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.E1.33036.34A65226; Mon,  7 Mar 2022 11:13:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220307022421epcas2p4fe01bb594b97591480149a686ab2a39a~Z_Aot1OEC1505015050epcas2p4L;
        Mon,  7 Mar 2022 02:24:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220307022421epsmtrp2758a0579f5809b0bb6126ec11d4396fa~Z_Aos_Cvc2100821008epsmtrp2W;
        Mon,  7 Mar 2022 02:24:21 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-0b-62256a43973e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.D2.29871.5DC65226; Mon,  7 Mar 2022 11:24:21 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220307022421epsmtip283191d5bc41d0615d32f796ceff6d982~Z_AoiAYh_2591225912epsmtip20;
        Mon,  7 Mar 2022 02:24:21 +0000 (GMT)
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Oh Eomji <eomji.oh@samsung.com>
Subject: [PATCH 2/2] sound: usb: Calling vendor's call-back function within
 usb audio operation.
Date:   Mon,  7 Mar 2022 11:22:00 +0900
Message-Id: <1646619720-97113-2-git-send-email-eomji.oh@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646619720-97113-1-git-send-email-eomji.oh@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmha5zlmqSwc65mhZXLh5isji1fCGT
        RfPi9WwWU34tZba4vGsOm8WBP4vZLDp39bNabPi+ltGBw2PD5yY2j52z7rJ7bFrVyeaxf+4a
        do99b5exefRtWcXosX7LVRaPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
        F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRn/Ji+i7FgtVzF31M9LA2MHyS6GDk5JARMJHo2LGHr
        YuTiEBLYwSixcucqRgjnE6PEtG+HWCGcb4wSk9bdZ4dpmTvrOVRiL6PEya4rUP0/GCX63sxj
        AaliE1CVmL5sO9AsDg4RgTKJZdMtQWqYQXY8ebcUbJKwQJLEu28/wepZgOpXLNkOFucVcJH4
        eXY/C8Q2OYmb5zqZQeZwCrhKTDwXCzJHQuARu8Taff+halwkPny6zQZhC0u8Or4F6lIpic/v
        9kLFiyUOLngOZddIvD3YClVjLDHrWTvYncwCmhLrd+mDmBICyhJHboFNZxbgk+g4/JcdIswr
        0dEmBNGoJDGpqZMJwpaQWPG5Ccr2kNi1dBk0RGYwSjT9+sU8gVFuFsKCBYyMqxjFUguKc9NT
        i40KTOARlpyfu4kRnPK0PHYwzn77Qe8QIxMH4yFGCQ5mJRHe++dVkoR4UxIrq1KL8uOLSnNS
        iw8xmgKDbiKzlGhyPjDp5pXEG5pYGpiYmRmaG5kamCuJ83qlbEgUEkhPLEnNTk0tSC2C6WPi
        4JRqYEqbPK3/emNyb6DmKc4X3KfeJ+TZ3WvY/pxF0Z5r077lj1c/3FTz1/62W96rMi/dY+9f
        P1C6cJTNp4Fp39/lLs+a4j5OdkjaeX+bbo1I4SUhj5iljSrrXtzj1XFO4PN/eMpW4/znsFA+
        95NVp9NX9cxjnq1b/e5ZG2fWlMBdwQHLZr94Z7np+K8oY/V1WqKLf+9pZhR49Em//utGjXY2
        w73nnrFs3B3/fL6dX+/LH2d71Ze8/bOrfkYD09YkWwbZJ72s0/cZKNy/GnDrwwVO+Sn9Hxx1
        DnV/cGJ66XnW99ePFTt2OR7l0Qi49GFWSe2ameELbNK23igUDDawFz/2b0NW1dRrRw/3rlvq
        MGOnE8cTJZbijERDLeai4kQAmPNl7wIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsWy7bCSvO7VHNUkgwuLBS2uXDzEZHFq+UIm
        i+bF69kspvxaymxxedccNosDfxazWXTu6me12PB9LaMDh8eGz01sHjtn3WX32LSqk81j/9w1
        7B773i5j8+jbsorRY/2WqywenzfJBXBEcdmkpOZklqUW6dslcGX8mL6LsWC1XMXfUz0sDYwf
        JLoYOTkkBEwk5s56ztrFyMUhJLCbUeLIm+VMEAkJiQVdr5khbGGJ+y1HoIq+ARXN+gyWYBNQ
        lZi+bDsjiC0iUCFx6+t2ZpAiZoE9jBJNR5vBioQFEiS+3vkNNpUFqGHFku3sIDavgIvEz7P7
        WSA2yEncPNcJVM/BwSngKjHxXCxIWAio5PzOjWwTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytO
        zC0uzUvXS87P3cQIDk8tzR2M21d90DvEyMTBeIhRgoNZSYT3/nmVJCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqYmF7b5zaken4zqVfYtfexrmHqrJBT
        P+JlVd78X3wy7xD3pnvXfCO3SdrG/3347f82nXdHP9Smiex+OJvb5uzBspu/b4QqiQSdO8oc
        9fjenoLrO9V1t137n+Ny3OnT6lNzJmxdIH874pp05eol99ZePcm2WVbSJu3lGY/gQvfDst3p
        ghZugoxTClyuu89lze9gTZV5tpLplFkH9xuehRcLHt7piE1UUIo/+EJt8uzCc9+dS9335eU1
        +Nh1/VHTyz03O6JCepGdZetp9TI/GZ4i8c2nQz90WX0/8uKCgKhuU/ZK83mhglnsj1uvajb2
        NBZVyten7Tv0cLNfufBJo5KWLM3LRxz/T6ntvc/J131LiaU4I9FQi7moOBEAdE3Qd74CAAA=
X-CMS-MailID: 20220307022421epcas2p4fe01bb594b97591480149a686ab2a39a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220307022421epcas2p4fe01bb594b97591480149a686ab2a39a
References: <1646619720-97113-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220307022421epcas2p4fe01bb594b97591480149a686ab2a39a@epcas2p4.samsung.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a new interface is connected or removed, the call-back functions
are called to transmit a command to the hardware.

Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
---
 sound/usb/pcm.c    | 40 ++++++++++++++++++++++++++++++++++++++++
 sound/usb/stream.c |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index cec6e91a..92e5e82 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -144,6 +144,8 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
 			found = fp;
 			cur_attr = attr;
 		}
+
+		snd_vendor_set_pcm_binterval(fp, found, &cur_attr, &attr);
 	}
 	return found;
 }
@@ -434,6 +436,7 @@ static int configure_endpoints(struct snd_usb_audio *chip,
 			       struct snd_usb_substream *subs)
 {
 	int err;
+	struct usb_interface *iface;
 
 	if (subs->data_endpoint->need_setup) {
 		/* stop any running stream beforehand */
@@ -442,6 +445,13 @@ static int configure_endpoints(struct snd_usb_audio *chip,
 		err = snd_usb_endpoint_configure(chip, subs->data_endpoint);
 		if (err < 0)
 			return err;
+
+		iface = usb_ifnum_to_if(chip->dev, subs->data_endpoint->iface);
+		err = snd_vendor_set_pcm_intf(iface, subs->data_endpoint->iface,
+				subs->data_endpoint->altsetting, subs->direction);
+		if (err < 0)
+			return err;
+
 		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
 	}
 
@@ -616,8 +626,19 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_usb_substream *subs = runtime->private_data;
 	struct snd_usb_audio *chip = subs->stream->chip;
+	struct snd_usb_endpoint *ep = subs->data_endpoint;
+	struct usb_interface *iface;
 	int ret;
 
+	ret = snd_vendor_set_pcm_buf(subs->dev, subs->cur_audiofmt->iface);
+	if (ret)
+		return ret;
+
+	if (!subs->cur_audiofmt) {
+		dev_err(&subs->dev->dev, "no format is specified\n");
+		return -ENXIO;
+	}
+
 	ret = snd_usb_lock_shutdown(chip);
 	if (ret < 0)
 		return ret;
@@ -630,6 +651,15 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto unlock;
 
+	iface = usb_ifnum_to_if(chip->dev, ep->cur_audiofmt->iface);
+
+	if (snd_vendor_get_ops()) {
+		ret = snd_vendor_set_rate(iface, ep->cur_audiofmt->iface,
+					ep->cur_rate, ep->cur_audiofmt->altsetting);
+		if (!ret)
+			goto unlock;
+	}
+
 	/* reset the pointer */
 	subs->buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
 	subs->inflight_bytes = 0;
@@ -1104,6 +1134,11 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_usb_substream *subs = &as->substream[direction];
 	int ret;
 
+	ret = snd_vendor_set_pcm_connection(subs->dev, SOUND_PCM_OPEN,
+					    direction);
+	if (ret)
+		return ret;
+
 	runtime->hw = snd_usb_hardware;
 	/* need an explicit sync to catch applptr update in low-latency mode */
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
@@ -1137,6 +1172,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_usb_substream *subs = &as->substream[direction];
 	int ret;
 
+	ret = snd_vendor_set_pcm_connection(subs->dev, SOUND_PCM_CLOSE,
+					    direction);
+	if (ret)
+		return ret;
+
 	snd_media_stop_pipeline(subs);
 
 	if (!snd_usb_lock_shutdown(subs->stream->chip)) {
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index ceb93d7..26ca696 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -1227,6 +1227,8 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
 		snd_usb_init_pitch(chip, fp);
 		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
 		usb_set_interface(chip->dev, iface_no, altno);
+		if (protocol > UAC_VERSION_1)
+			snd_vendor_set_interface(chip->dev, alts, iface_no, 0);
 	}
 	return 0;
 }
-- 
2.7.4

