Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8744E6029
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348873AbiCXIPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiCXIPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:15:30 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF38A6D3BA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:13:58 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220324081357epoutp038a30379e51bae581dbe545a2e39bd35f~fQvubzHI90321903219epoutp03O
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:13:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220324081357epoutp038a30379e51bae581dbe545a2e39bd35f~fQvubzHI90321903219epoutp03O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648109637;
        bh=YW/2ceFMHoRfV7fzxxaDnC0GyOKNFo3dhe+3d+i6lhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7gnzmzet5eskAraKcHhfkX2X6vImBGd2vb9C57KZPD9GZxoD5tsnPDRdrfGf5qsX
         D8/HqmCRSrRR22vt7oYWWX3XM94842oEFYvx82venO9L2Gyd3LusytPWn4KiDwrAQD
         vyoLIWaeTrGUHifMhyluz/Sq3INa4xxe8fYGNOLM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220324081356epcas2p1966dd6d7123f831434fccf1a9321a3c1~fQvtnieql2232922329epcas2p1G;
        Thu, 24 Mar 2022 08:13:56 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.100]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KPHzz0Tlcz4x9Q3; Thu, 24 Mar
        2022 08:13:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.E4.25540.C382C326; Thu, 24 Mar 2022 17:13:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220324081348epcas2p48d3a24dfdfd8d01e9bf350571b18ffff~fQvmqrMTj0598405984epcas2p4c;
        Thu, 24 Mar 2022 08:13:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324081348epsmtrp1c3b1a025dd259ecc157f7cf500477fae~fQvmp07mu0419104191epsmtrp1T;
        Thu, 24 Mar 2022 08:13:48 +0000 (GMT)
X-AuditID: b6c32a47-81bff700000063c4-d6-623c283ce36e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.7E.29871.C382C326; Thu, 24 Mar 2022 17:13:48 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324081348epsmtip2ea52d3bb30fb2d5b3a180677e31513f5~fQvmdNqXf1325713257epsmtip2A;
        Thu, 24 Mar 2022 08:13:48 +0000 (GMT)
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Oh Eomji <eomji.oh@samsung.com>
Subject: [PATCH v1 2/3] sound: usb: Calling vendor's call-back function
 within usb audio operation.
Date:   Thu, 24 Mar 2022 17:10:43 +0900
Message-Id: <1648109444-196321-3-git-send-email-eomji.oh@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmha6thk2SwfmNzBZXLh5isji1fCGT
        RfPi9WwWU34tZba4vGsOm8WBP4vZLDp39bNabPi+ltGBw2PD5yY2j52z7rJ7bFrVyeaxf+4a
        do99b5exefRtWcXosX7LVRaPz5vkAjiism0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUN
        LS3MlRTyEnNTbZVcfAJ03TJzgE5TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSY
        F+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnnJt/ib1gr2zFj7MNbA2MEyW6GDk5JARMJI782sfU
        xcjFISSwg1HibvtsZgjnE6PEo45TzCBVQgLfGCXmbOSD6ejq+QxVtJdRYuGeBywQzg9GiWX/
        u8A62ARUJaYv287YxcjBISJQJrFsuiVIDTPIiifvlrKD1AgLpEo8vLYDrJ4FqH7Or242EJtX
        wFViy7SLjBDb5CRunutkBpnDKeAm8eulO8gcCYFH7BI3FnawQNS4SKw6dIkNwhaWeHV8CzuE
        LSXxsr8Nyi6WOLjgOVRNjcTbg61QcWOJWc/awe5kFtCUWL9LH8SUEFCWOHILbDqzAJ9Ex+G/
        7BBhXomONiGIRiWJSU2dTBC2hMSKz01QtofEpf97oAE6k1Hi9fwW9gmMcrMQFixgZFzFKJZa
        UJybnlpsVGAMj6/k/NxNjOCEp+W+g3HG2w96hxiZOBgPMUpwMCuJ8N6/bJ0kxJuSWFmVWpQf
        X1Sak1p8iNEUGHQTmaVEk/OBKTevJN7QxNLAxMzM0NzI1MBcSZzXK2VDopBAemJJanZqakFq
        EUwfEwenVAOTjHnXnV2M+005lzf8++nicu125uGXf+3uvWp6rJHYoZl8YNLic9kWG8R3spj4
        zT3gxG0Uz9Sd8eSy16eKGcXVd4W+zwtyyN/1w+HD7c/RovZTtZmP1Dte+CSsLvxVrWRLT+tN
        FtbtpfkvCx4lix26tF/eICnHSsB5N+vkzPItAQrWnTsS7zqJ6m39Ed7CdKZQY1nTqq7QbUJt
        tpO5LU5Wz351IvaIuYTmmVu1Fxa9t+76Wmey0SJfh2v+BevlGqs4jpxsP2o085tavG2rSmfx
        98MT93FNrFjWc+T1utTWFw1F7c97Paefn6vbUyF6kjFeapfY/P2t85v6O/NOPH81zWnd1Nkb
        lr2ICn1/IfupEktxRqKhFnNRcSIAR75CvQEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsWy7bCSvK6Nhk2Swf4GFYsrFw8xWZxavpDJ
        onnxejaLKb+WMltc3jWHzeLAn8VsFp27+lktNnxfy+jA4bHhcxObx85Zd9k9Nq3qZPPYP3cN
        u8e+t8vYPPq2rGL0WL/lKovH501yARxRXDYpqTmZZalF+nYJXBnn5l9iL9grW/HjbANbA+NE
        iS5GTg4JAROJrp7PzF2MXBxCArsZJTat6GCCSEhILOh6zQxhC0vcbznCCmILCXxjlLg+SwPE
        ZhNQlZi+bDsjiC0iUCFx6+t2sEHMAnsYJZqONoM1CwskS1yb08cOYrMANcz51c0GYvMKuEps
        mXaREWKBnMTNc51A9RwcnAJuEr9eukPscpXof7mPbQIj3wJGhlWMkqkFxbnpucWGBYZ5qeV6
        xYm5xaV56XrJ+bmbGMHBqaW5g3H7qg96hxiZOBgPMUpwMCuJ8N6/bJ0kxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9OB98yP1yyZo6nmKXF7fmej5p1i
        GYu5TT8/HHSZMHW56ba6V5mOubLOeVWSufeWe2kKP8/zNTXsmpucY6FrE5JZ2V3UJVe32jKx
        2P6iV6DbkZZHCSveSdswGH78O6FpIfOG/Q15p5721k5PEXH4du6H5Op9kzvWPzpUEnU/82RF
        n0OV9TTZK1e9HZafX1ypddP/4ped9T9m/bJMObz9xkKTaj4REY2jMl4FrEWLfoXsyewx+rv2
        PuvswzmTVFzCzX6+9KtxnWH2pT395uyU1s2tewV5/9oFG/i+sv5rXqsrJmTyJcbu2v3SjnP/
        HFo1khIZDGSkJIqXlbX0XdtkuW1Ciaue1JuXHf18XoXCSizFGYmGWsxFxYkAjBVkb70CAAA=
X-CMS-MailID: 20220324081348epcas2p48d3a24dfdfd8d01e9bf350571b18ffff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324081348epcas2p48d3a24dfdfd8d01e9bf350571b18ffff
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220324081348epcas2p48d3a24dfdfd8d01e9bf350571b18ffff@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 sound/usb/pcm.c    | 37 +++++++++++++++++++++++++++++++++++++
 sound/usb/stream.c |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index cec6e91a..4bae4ba 100644
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
 
@@ -616,8 +626,18 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_usb_substream *subs = runtime->private_data;
 	struct snd_usb_audio *chip = subs->stream->chip;
+	struct snd_usb_endpoint *ep = subs->data_endpoint;
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
@@ -630,6 +650,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		goto unlock;
 
+	if (snd_vendor_get_ops()) {
+		ret = snd_vendor_set_rate(ep->cur_audiofmt->iface,
+				ep->cur_rate, ep->cur_audiofmt->altsetting);
+		if (!ret)
+			goto unlock;
+	}
+
 	/* reset the pointer */
 	subs->buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
 	subs->inflight_bytes = 0;
@@ -1104,6 +1131,11 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
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
@@ -1137,6 +1169,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
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

