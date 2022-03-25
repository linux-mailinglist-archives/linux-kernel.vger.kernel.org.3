Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C03C4E6EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358514AbiCYHRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354764AbiCYHRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:17:09 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6937FC74B4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:15:29 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220325071527epoutp04387e0f5e09567db49ae8e04a0d5d0b1f~fjl771h-O2447424474epoutp04Z
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 07:15:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220325071527epoutp04387e0f5e09567db49ae8e04a0d5d0b1f~fjl771h-O2447424474epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1648192527;
        bh=0RB2zY4IjwuD60lmM1qt63nYEmpNNTM6ztbApUsUjYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mniL/gjDFGTxbsAqMOV91tnZbFYm5Fy3/V4u8Yxp2PAQdThxOV54DhxquKzww2BG+
         XzI8DRYfFymaQr4T0M65R3ao6OpDc1LtAhyC4khC2/LfWqSrJS/kjuA/n4P/a+wwKn
         2aK34cfwMV3YMg6XyUMFPk2CrboqojW343mMbdFc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20220325071526epcas2p161d9add0712ccdcaeb1d9f2de7e3c891~fjl7HO8aN2157021570epcas2p1j;
        Fri, 25 Mar 2022 07:15:26 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KPtf15w8Xz4x9QF; Fri, 25 Mar
        2022 07:15:21 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.C8.25540.60C6D326; Fri, 25 Mar 2022 16:15:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220325071517epcas2p141a5b9d75af93ec8a60f82f98063ffa4~fjlzUD8kE1679216792epcas2p1u;
        Fri, 25 Mar 2022 07:15:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220325071517epsmtrp214d453bfb84edc8f8eb637dceaa36696~fjlzTY8Z02572025720epsmtrp2M;
        Fri, 25 Mar 2022 07:15:17 +0000 (GMT)
X-AuditID: b6c32a47-02a68a80000063c4-c7-623d6c06a769
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.AD.29871.50C6D326; Fri, 25 Mar 2022 16:15:17 +0900 (KST)
Received: from ubuntu (unknown [12.36.155.120]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220325071517epsmtip1f16522e58427f2ac8894fb9b5745a271~fjlzG7WWp3092930929epsmtip1N;
        Fri, 25 Mar 2022 07:15:17 +0000 (GMT)
Date:   Fri, 25 Mar 2022 16:13:57 +0900
From:   Oh Eomji <eomji.oh@samsung.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v1 2/3] sound: usb: Calling vendor's call-back function
 within usb audio operation.
Message-ID: <20220325071357.GB123495@ubuntu>
MIME-Version: 1.0
In-Reply-To: <YjwtDo7b/RMHr45e@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmuS5bjm2SwZ+14hZXLh5ismhevJ7N
        YsqvpcwWl3fNYbM48Gcxm0Xnrn5Wiw3f1zI6sHts+NzE5rFz1l12j02rOtk89s9dw+6x7+0y
        No/1W66yeHzeJBfAHpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr
        5OIToOuWmQN0kJJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10v
        L7XEytDAwMgUqDAhO2PtotWMBQvVK9Zf3sfSwLhEvouRk0NCwETi0IEe5i5GLg4hgR2MEu9X
        TmIFSQgJfGKUOLk9DCLxjVHi0tbdbDAd726uZ4FI7GWUuPj1JwtExxNGiQWrSkBsFgFVicaF
        h8DibED29GXbGUFsEQFjif6zs9hBmpkFbjBK7Pv0DqxIWCBTorl3GtgGXgEdiV+Nf6BsQYmT
        M5+A1XAKaEo8+XsDqJmDQ1RAReLVwXqQORICnRwSjw+9Yoe4zkViyt4zLBC2sMSr41ug4lIS
        n9/thfqgWOLggudQdo3E24OtUDXGErOetYMdyiyQLnH1Qh8byC4JAWWJI7dYIMJ8Eh2H/7JD
        hHklOtqEIDqVJCY1dTJB2BISKz43QdkeEpf+72GChNUXRom+6edYJjDKz0Ly2Swk2yBsHYkF
        uz8B2RxAtrTE8n8cEKamxPpd+gsYWVcxiqUWFOempxYbFRjD4zo5P3cTIziparnvYJzx9oPe
        IUYmDsZDjBIczEoivPcvWycJ8aYkVlalFuXHF5XmpBYfYjQFxtNEZinR5HxgWs8riTc0sTQw
        MTMzNDcyNTBXEuf1StmQKCSQnliSmp2aWpBaBNPHxMEp1cBkuN2O8XqLyYLNG05tvcLxIvjp
        28UimnFH5wa65wnZtIVJvq7fbD2D672Ap4bUQbM9Wi/e7rfeHbXP9okio8gvv88GPq4HJT39
        GJd9nyrdcb5IcP+PtMUtenZvJX2eTVE/Ufe27cCqk1smfDbi2+j2uNjr7Z6QP31JBTe+vpdw
        elRWXiVvLFC3hbVT5u/k63wRV300vx9NT63/7nX+/Z1H7/8rBSmvsnn5gtd0+wbhS0X/JlVM
        /S/XlpPlWaN+5OPK6oVTHm8ztrG8mrrqr5Dbgj385RNPa2+JcJ/BanDHP1z2/slj5fvmsk5P
        l+5NFtlpWL8+x0BDnielSsb1a9b2vn13CpR2vlY5EGhy5ASvEktxRqKhFnNRcSIA7fhlWzME
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWy7bCSnC5rjm2SwdZbJhZXLh5ismhevJ7N
        YsqvpcwWl3fNYbM48Gcxm0Xnrn5Wiw3f1zI6sHts+NzE5rFz1l12j02rOtk89s9dw+6x7+0y
        No/1W66yeHzeJBfAHsVlk5Kak1mWWqRvl8CVsez+ddaCJyoVLcv2sjQwNsh2MXJySAiYSLy7
        uZ6li5GLQ0hgN6PElNmHmCASEhILul4zQ9jCEvdbjrBCFD1ilGh61gWWYBFQlWhceIgFxGYD
        sqcv284IYosIGEv0n53FDtLALHCLUWJtz1ywhLBApkRz7zQ2EJtXQEfiV+MfNoipXxgldh85
        wgiREJQ4OfMJ2FRmAS2JG/9eAp3EAWRLSyz/xwES5hTQlHjy9wY7SFhUQEXi1cH6CYyCs5A0
        z0LSPAuheQEj8ypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjODI0NLcwbh91Qe9Q4xM
        HIyHGCU4mJVEeO9ftk4S4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoR
        TJaJg1OqgemAQtDu3S71Ilfb2c9pzlIV2q2y561iutY06dN2lawXA/LjV26p7d9aN2+WIX/D
        NMNwJ5tAV3ePmXZMdz+qrjI9+e7N49tVOvpsxhH2ubo1Fz679zVYx3/iPsl26xyHYbD6iQ2X
        e+R+hKTVZyjuzqtYun+rlr7oY8Zdq2IEPrz5eDH74vqnWw9OaTx/JER46UJ582/L3mzNaQ2e
        JrtnyZ2PX3sX8v9ruf3rt/P73J6GCSe6TzMUHnov+UyiXu9F/LaOhQVdr1nfRCuxx+2ad/H8
        3ReCTs0Ss5dUcCbmd6in5Yl05p7eobQ9ooj9d+qbiu5TBZdlZQVv8/4KTdWdsuqOr9I0fflA
        5svSaZ1uwUosxRmJhlrMRcWJAJEAHb/7AgAA
X-CMS-MailID: 20220325071517epcas2p141a5b9d75af93ec8a60f82f98063ffa4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_9486_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220324081348epcas2p48d3a24dfdfd8d01e9bf350571b18ffff
References: <1648109444-196321-1-git-send-email-eomji.oh@samsung.com>
        <CGME20220324081348epcas2p48d3a24dfdfd8d01e9bf350571b18ffff@epcas2p4.samsung.com>
        <1648109444-196321-3-git-send-email-eomji.oh@samsung.com>
        <YjwtDo7b/RMHr45e@kroah.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_9486_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Mar 24, 2022 at 09:34:22AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 24, 2022 at 05:10:43PM +0900, Oh Eomji wrote:
> > When a new interface is connected or removed, the call-back functions
> > are called to transmit a command to the hardware.
> > 
> > Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> > ---
> >  sound/usb/pcm.c    | 37 +++++++++++++++++++++++++++++++++++++
> >  sound/usb/stream.c |  2 ++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> > index cec6e91a..4bae4ba 100644
> > --- a/sound/usb/pcm.c
> > +++ b/sound/usb/pcm.c
> > @@ -144,6 +144,8 @@ find_format(struct list_head *fmt_list_head, snd_pcm_format_t format,
> >  			found = fp;
> >  			cur_attr = attr;
> >  		}
> > +
> > +		snd_vendor_set_pcm_binterval(fp, found, &cur_attr, &attr);
> >  	}
> >  	return found;
> >  }
> > @@ -434,6 +436,7 @@ static int configure_endpoints(struct snd_usb_audio *chip,
> >  			       struct snd_usb_substream *subs)
> >  {
> >  	int err;
> > +	struct usb_interface *iface;
> >  
> >  	if (subs->data_endpoint->need_setup) {
> >  		/* stop any running stream beforehand */
> > @@ -442,6 +445,13 @@ static int configure_endpoints(struct snd_usb_audio *chip,
> >  		err = snd_usb_endpoint_configure(chip, subs->data_endpoint);
> >  		if (err < 0)
> >  			return err;
> > +
> > +		iface = usb_ifnum_to_if(chip->dev, subs->data_endpoint->iface);
> > +		err = snd_vendor_set_pcm_intf(iface, subs->data_endpoint->iface,
> > +				subs->data_endpoint->altsetting, subs->direction);
> > +		if (err < 0)
> > +			return err;
> > +
> >  		snd_usb_set_format_quirk(subs, subs->cur_audiofmt);
> >  	}
> >  
> > @@ -616,8 +626,18 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
> >  	struct snd_pcm_runtime *runtime = substream->runtime;
> >  	struct snd_usb_substream *subs = runtime->private_data;
> >  	struct snd_usb_audio *chip = subs->stream->chip;
> > +	struct snd_usb_endpoint *ep = subs->data_endpoint;
> >  	int ret;
> >  
> > +	ret = snd_vendor_set_pcm_buf(subs->dev, subs->cur_audiofmt->iface);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!subs->cur_audiofmt) {
> > +		dev_err(&subs->dev->dev, "no format is specified\n");
> > +		return -ENXIO;
> > +	}
> > +
> >  	ret = snd_usb_lock_shutdown(chip);
> >  	if (ret < 0)
> >  		return ret;
> > @@ -630,6 +650,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
> >  	if (ret < 0)
> >  		goto unlock;
> >  
> > +	if (snd_vendor_get_ops()) {
> > +		ret = snd_vendor_set_rate(ep->cur_audiofmt->iface,
> > +				ep->cur_rate, ep->cur_audiofmt->altsetting);
> > +		if (!ret)
> > +			goto unlock;
> > +	}
> > +
> >  	/* reset the pointer */
> >  	subs->buffer_bytes = frames_to_bytes(runtime, runtime->buffer_size);
> >  	subs->inflight_bytes = 0;
> > @@ -1104,6 +1131,11 @@ static int snd_usb_pcm_open(struct snd_pcm_substream *substream)
> >  	struct snd_usb_substream *subs = &as->substream[direction];
> >  	int ret;
> >  
> > +	ret = snd_vendor_set_pcm_connection(subs->dev, SOUND_PCM_OPEN,
> > +					    direction);
> > +	if (ret)
> > +		return ret;
> > +
> >  	runtime->hw = snd_usb_hardware;
> >  	/* need an explicit sync to catch applptr update in low-latency mode */
> >  	if (direction == SNDRV_PCM_STREAM_PLAYBACK &&
> > @@ -1137,6 +1169,11 @@ static int snd_usb_pcm_close(struct snd_pcm_substream *substream)
> >  	struct snd_usb_substream *subs = &as->substream[direction];
> >  	int ret;
> >  
> > +	ret = snd_vendor_set_pcm_connection(subs->dev, SOUND_PCM_CLOSE,
> > +					    direction);
> > +	if (ret)
> > +		return ret;
> > +
> >  	snd_media_stop_pipeline(subs);
> >  
> >  	if (!snd_usb_lock_shutdown(subs->stream->chip)) {
> > diff --git a/sound/usb/stream.c b/sound/usb/stream.c
> > index ceb93d7..26ca696 100644
> > --- a/sound/usb/stream.c
> > +++ b/sound/usb/stream.c
> > @@ -1227,6 +1227,8 @@ static int __snd_usb_parse_audio_interface(struct snd_usb_audio *chip,
> >  		snd_usb_init_pitch(chip, fp);
> >  		snd_usb_init_sample_rate(chip, fp, fp->rate_max);
> >  		usb_set_interface(chip->dev, iface_no, altno);
> > +		if (protocol > UAC_VERSION_1)
> 
> Why the protocol check?  That's not documented in your changelog
> anywhere :(
> 
>
Hi,

In kernel 5.10, set_interface is performed when the protocol is more
than UAC_VERSION_1 in the snd_usb_init_sample_rate function.
There was an issue here, so there is a history of adding to perform
snd_vendor_set_interface when the protocol is more than UAC_VERSION_1.
But I don't think I need this in kerenel 5.15, so I'll delete it.

Thanks,
Eomji Oh

------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_9486_
Content-Type: text/plain; charset="utf-8"


------Hit0D2w6tI2G2F3pksn2lDL9DCLqPArtVXtx_.FrHH4Lj9aG=_9486_--
