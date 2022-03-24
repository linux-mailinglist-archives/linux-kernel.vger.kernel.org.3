Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29124E600B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348818AbiCXIOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348862AbiCXIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:14:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EDD9BAD5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:12:21 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220324081218epoutp0466fe1f7fb1f8d87f75cf09eae36e241e~fQuSs5x091102511025epoutp04C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:12:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220324081218epoutp0466fe1f7fb1f8d87f75cf09eae36e241e~fQuSs5x091102511025epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648109538;
        bh=ijbZIdlZTCT7owCfx0etBk42pkcgnP7rXEjmEjUQen0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aRsLWbsOCFr+KM71VMtOqIXSwFTeuuct5sfUu176R211iOwKSFpivnWodQ10ttnhq
         3pHetOjIhjcFcopqD3pXO6/Ogay0gAAZfzD4qzZyWq0cYEJeORS/4BvEFdymDCijj9
         FgqKFelZiy1pVopJ2BM9eOGrfzOqhM4lQ5j6o1hM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220324081217epcas2p39aab5559a3aaa58eb6bd3f24a0528fc6~fQuSBpy-40248902489epcas2p3P;
        Thu, 24 Mar 2022 08:12:17 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KPHy542kfz4x9QY; Thu, 24 Mar
        2022 08:12:13 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.46.33036.DD72C326; Thu, 24 Mar 2022 17:12:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b~fQuNevaXy1700917009epcas2p4Q;
        Thu, 24 Mar 2022 08:12:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220324081212epsmtrp13a53318264a2e4613cf6d2a0b6556e09~fQuNd0RiZ0321203212epsmtrp1W;
        Thu, 24 Mar 2022 08:12:12 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-c5-623c27dd23eb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.5E.29871.CD72C326; Thu, 24 Mar 2022 17:12:12 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220324081212epsmtip24cf9df23301dd8c54dfcd10de71ee888~fQuNLnDwi1325613256epsmtip2R;
        Thu, 24 Mar 2022 08:12:12 +0000 (GMT)
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Oh Eomji <eomji.oh@samsung.com>,
        JaeHun Jung <jh0801.jung@samsung.com>
Subject: [PATCH v1 1/3] sound: usb: Add vendor's hooking interface
Date:   Thu, 24 Mar 2022 17:10:42 +0900
Message-Id: <1648109444-196321-2-git-send-email-eomji.oh@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmqe5ddZskgxXH+S2uXDzEZHFq+UIm
        i+bF69ks7j78wWIx5ddSZovLu+awWRz4s5jNonNXP6vFhu9rGR04PTZ8bmLz2DnrLrvHplWd
        bB77565h99j3dhmbR9+WVYwe67dcZfH4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne
        1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6D4lhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1S
        akFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGtVX/mQvuOVZM+LyRpYHxpmkXIyeHhICJ
        RMea7ewgtpDADkaJGf2KXYxcQPYnRokdJ7vZIZxvjBKT1q1jhen492gGC0RiL6PEhgXLWCGc
        H4wS3T9mMYFUsQmoSkxftp2xi5GDQ0SgTGLZdEuQGmaB+0A16y6xgdQICzhJXOzexQhiswDV
        X13fCmbzCrhKXD/TzQaxTU7i5rlOZpA5nAJuEr9euoPMkRB4yy7RNGsFWFxCwEXi4gU/iHJh
        iVfHt7BD2FISL/vboOxiiYMLnkONrJF4e7AVKm4sMetZO9iZzAKaEut36UNMVJY4cosFpIJZ
        gE+i4/Bfdogwr0RHmxBEo5LEpKZOJghbQmLF5yYo20PixMyjTJAAmcko0TlhIcsERrlZCAsW
        MDKuYhRLLSjOTU8tNiowgUdXcn7uJkZw4tPy2ME4++0HvUOMTByMhxglOJiVRHjvX7ZOEuJN
        SaysSi3Kjy8qzUktPsRoCgy5icxSosn5wNSbVxJvaGJpYGJmZmhuZGpgriTO65WyIVFIID2x
        JDU7NbUgtQimj4mDU6qBKSNKSDrq/Iv13x/4Hjmona92P3C59ynZaxcOtvQ9TdfMm13nJvrM
        63NaibBrx9WatevjHmhs/fn9c/4fVqXlOfvfiB361XV+rimv7QruyPQu7ytZaybcmlHfMPFC
        SNgWv8xIB7HO4MbDamkrmJd+XFw4dd6Dw3X6H+TNBVnMLjLJPzYNyqvluvB+dnpPYcZ5Jn7P
        nz/533KumOdpdi6/V9TzksRMznDfLyv22K1sZxCzWX1Z4nhfndmuuZ4KdmorHHZwHyvgOKF7
        P6vRa32myYwErs6GrY26ih7HFvI80DJlX/SPO38Kr4Lg/HjF/xazn8qd/Drvw27Ru/kdk5g5
        d0tf4tC8eOXpiStbhctSlFiKMxINtZiLihMBSBhCdQUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWy7bCSvO4ddZskg87v+hZXLh5isji1fCGT
        RfPi9WwWdx/+YLGY8msps8XlXXPYLA78Wcxm0bmrn9Viw/e1jA6cHhs+N7F57Jx1l91j06pO
        No/9c9ewe+x7u4zNo2/LKkaP9Vuusnh83iQXwBHFZZOSmpNZllqkb5fAlXFt1X/mgnuOFRM+
        b2RpYLxp2sXIySEhYCLx79EMli5GLg4hgd2MErdev2CDSEhILOh6zQxhC0vcbznCCmILCXxj
        lJh/yQnEZhNQlZi+bDsjiC0iUCFx6+t2ZpBBzAJPGSUWTrgB1iws4CRxsXsXWBELUMPV9a1g
        Nq+Aq8T1M91Qy+Qkbp7rBKrn4OAUcJP49dIdYperRP/LfWwTGPkWMDKsYpRMLSjOTc8tNiww
        zEst1ytOzC0uzUvXS87P3cQIDlMtzR2M21d90DvEyMTBeIhRgoNZSYT3/mXrJCHelMTKqtSi
        /Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY5Aw2v2FYv0fB+k50QcHB
        I937dteK/AmTSHS1YL7Ickv3wbzlE+0qJtvxyuRenRX9K2W54NWpJb17sqO+Xfn1oiuu44wL
        a4mlS3yqxZOEVcbfdtmdVKpbtegSk33eu4C9lfaRod8yV/959uNLRH2a6c0AI5vWn1/Vlhvc
        4d0bdWeHZtztkmveBxfHdv/Tk9r08FbbrbJw9VANndCQR5l/Auofn7vjt5bXKOkHr9ASsR5Z
        D35T09Tl76bMXSLVz63Vq9B+8vhN6Z7sQ5skXlX3bnp7mGnvuXaf4J/hmQxJbB2HVLZMiL9e
        EvnsZevSwO7LPnlpvDoM8oy3lfrX9G5x0WFeMu1A7McezY42E18lluKMREMt5qLiRADqA0YV
        wgIAAA==
X-CMS-MailID: 20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220324081212epcas2p4d2ed1f3a1bb020606cf65016efec085b@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In mobile, a co-processor can be used with USB audio to improve power
consumption.  To support this type of hardware, hooks need to be added
to the USB audio subsystem to be able to call into the hardware when
needed.

The main operation of the call-backs are:
  - Initialize the co-processor by transmitting data when initializing.
  - Change the co-processor setting value through the interface
    function.
  - Configure sampling rate
  - pcm open/close
  - other housekeeping

Known issues:
  - This only supports one set of callback hooks, meaning that this only
    works if there is one type of USB controller in the system.  This
    should be changed to be a per-host-controller interface instead of
    one global set of callbacks.

Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
---
 sound/usb/card.c     | 119 +++++++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/card.h     |  20 +++++++++
 sound/usb/usbaudio.h |  45 +++++++++++++++++++
 3 files changed, 184 insertions(+)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 3769622..bd59311 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -117,6 +117,117 @@ MODULE_PARM_DESC(skip_validation, "Skip unit descriptor validation (default: no)
 static DEFINE_MUTEX(register_mutex);
 static struct snd_usb_audio *usb_chip[SNDRV_CARDS];
 static struct usb_driver usb_audio_driver;
+static struct snd_usb_audio_vendor_ops *usb_vendor_ops;
+
+int snd_vendor_set_ops(struct snd_usb_audio_vendor_ops *ops)
+{
+	if ((!ops->connect) ||
+	    (!ops->disconnect) ||
+	    (!ops->set_interface) ||
+	    (!ops->set_rate) ||
+	    (!ops->set_pcm_buf) ||
+	    (!ops->set_pcm_intf) ||
+	    (!ops->set_pcm_connection) ||
+	    (!ops->set_pcm_binterval) ||
+	    (!ops->usb_add_ctls))
+		return -EINVAL;
+
+	usb_vendor_ops = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_vendor_set_ops);
+
+struct snd_usb_audio_vendor_ops *snd_vendor_get_ops(void)
+{
+	return usb_vendor_ops;
+}
+
+static int snd_vendor_connect(struct usb_interface *intf)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->connect(intf);
+	return 0;
+}
+
+static void snd_vendor_disconnect(struct usb_interface *intf)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		ops->disconnect(intf);
+}
+
+int snd_vendor_set_interface(struct usb_device *udev,
+			     struct usb_host_interface *intf,
+			     int iface, int alt)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->set_interface(udev, intf, iface, alt);
+	return 0;
+}
+
+int snd_vendor_set_rate(int iface, int rate, int alt)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->set_rate(iface, rate, alt);
+	return 0;
+}
+
+int snd_vendor_set_pcm_buf(struct usb_device *udev, int iface)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		ops->set_pcm_buf(udev, iface);
+	return 0;
+}
+
+int snd_vendor_set_pcm_intf(struct usb_interface *intf, int iface, int alt,
+			    int direction)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->set_pcm_intf(intf, iface, alt, direction);
+	return 0;
+}
+
+int snd_vendor_set_pcm_connection(struct usb_device *udev,
+				  enum snd_vendor_pcm_open_close onoff,
+				  int direction)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->set_pcm_connection(udev, onoff, direction);
+	return 0;
+}
+
+int snd_vendor_set_pcm_binterval(const struct audioformat *fp,
+				 const struct audioformat *found,
+				 int *cur_attr, int *attr)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->set_pcm_binterval(fp, found, cur_attr, attr);
+	return 0;
+}
+
+static int snd_vendor_usb_add_ctls(struct snd_usb_audio *chip)
+{
+	struct snd_usb_audio_vendor_ops *ops = snd_vendor_get_ops();
+
+	if (ops)
+		return ops->usb_add_ctls(chip);
+	return 0;
+}
 
 /*
  * disconnect streams
@@ -753,6 +864,10 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (err < 0)
 		return err;
 
+	err = snd_vendor_connect(intf);
+	if (err)
+		return err;
+
 	/*
 	 * found a config.  now register to ALSA
 	 */
@@ -820,6 +935,8 @@ static int usb_audio_probe(struct usb_interface *intf,
 	if (chip->quirk_flags & QUIRK_FLAG_DISABLE_AUTOSUSPEND)
 		usb_disable_autosuspend(interface_to_usbdev(intf));
 
+	snd_vendor_usb_add_ctls(chip);
+
 	/*
 	 * For devices with more than one control interface, we assume the
 	 * first contains the audio controls. We might need a more specific
@@ -907,6 +1024,8 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 
 	card = chip->card;
 
+	snd_vendor_disconnect(intf);
+
 	mutex_lock(&register_mutex);
 	if (atomic_inc_return(&chip->shutdown) == 1) {
 		struct snd_usb_stream *as;
diff --git a/sound/usb/card.h b/sound/usb/card.h
index 87f042d0..81280ac 100644
--- a/sound/usb/card.h
+++ b/sound/usb/card.h
@@ -204,4 +204,24 @@ struct snd_usb_stream {
 	struct list_head list;
 };
 
+struct snd_usb_substream *find_snd_usb_substream(unsigned int card_num,
+	unsigned int pcm_idx, unsigned int direction, struct snd_usb_audio
+	**uchip, void (*disconnect_cb)(struct snd_usb_audio *chip));
+
+int snd_vendor_set_ops(struct snd_usb_audio_vendor_ops *vendor_ops);
+struct snd_usb_audio_vendor_ops *snd_vendor_get_ops(void);
+int snd_vendor_set_interface(struct usb_device *udev,
+			     struct usb_host_interface *alts,
+			     int iface, int alt);
+int snd_vendor_set_rate(int iface, int rate, int alt);
+int snd_vendor_set_pcm_buf(struct usb_device *udev, int iface);
+int snd_vendor_set_pcm_intf(struct usb_interface *intf, int iface, int alt,
+			    int direction);
+int snd_vendor_set_pcm_connection(struct usb_device *udev,
+				  enum snd_vendor_pcm_open_close onoff,
+				  int direction);
+int snd_vendor_set_pcm_binterval(const struct audioformat *fp,
+				 const struct audioformat *found,
+				 int *cur_attr, int *attr);
+
 #endif /* __USBAUDIO_CARD_H */
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 1678341..90c68cb 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -184,4 +184,49 @@ extern bool snd_usb_skip_validation;
 #define QUIRK_FLAG_DSD_RAW		(1U << 15)
 #define QUIRK_FLAG_SET_IFACE_FIRST	(1U << 16)
 
+struct audioformat;
+
+enum snd_vendor_pcm_open_close {
+	SOUND_PCM_CLOSE = 0,
+	SOUND_PCM_OPEN,
+};
+
+/**
+ * struct snd_usb_audio_vendor_ops - function callbacks for USB audio accelerators
+ * @connect: called when a new interface is found
+ * @disconnect: called when an interface is removed
+ * @set_interface: called when an interface is initialized
+ * @set_rate: called when the rate is set
+ * @set_pcm_buf: called when the pcm buffer is set
+ * @set_pcm_intf: called when the pcm interface is set
+ * @set_pcm_connection: called when pcm is opened/closed
+ * @set_pcm_binterval: called when the pcm binterval is set
+ * @usb_add_ctls: called when USB controls are added
+ *
+ * Set of callbacks for some accelerated USB audio streaming hardware.
+ *
+ * TODO: make this USB host-controller specific, right now this only works for
+ * one USB controller in the system at a time, which is only realistic for
+ * self-contained systems like phones.
+ */
+struct snd_usb_audio_vendor_ops {
+	int (*connect)(struct usb_interface *intf);
+	void (*disconnect)(struct usb_interface *intf);
+
+	int (*set_interface)(struct usb_device *udev,
+			     struct usb_host_interface *alts,
+			     int iface, int alt);
+	int (*set_rate)(int iface, int rate, int alt);
+	int (*set_pcm_buf)(struct usb_device *udev, int iface);
+	int (*set_pcm_intf)(struct usb_interface *intf, int iface, int alt,
+			    int direction);
+	int (*set_pcm_connection)(struct usb_device *udev,
+				  enum snd_vendor_pcm_open_close onoff,
+				  int direction);
+	int (*set_pcm_binterval)(const struct audioformat *fp,
+				 const struct audioformat *found,
+				 int *cur_attr, int *attr);
+	int (*usb_add_ctls)(struct snd_usb_audio *chip);
+};
+
 #endif /* __USBAUDIO_H */
-- 
2.7.4

