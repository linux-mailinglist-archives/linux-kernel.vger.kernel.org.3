Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB948C086
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbiALI5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349513AbiALI5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:57:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF81C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:57:13 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q8so2812373wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HhvZ3uKij/5andIsYWXWjb4Izd/6e/PP/vgXNxLfogY=;
        b=5kf6KDQr39SrKewfAropcE6gWWCr/MgoEwhYKIcc1ZpTzaQk53nBFiKLuQJB5uA8GP
         6XEz3aWy2A1TcXRAncBzuNdR79AVjVUY10aS14chzi5ajrOe51PgYYYTpaeDSCkX2Qcn
         mpIfnN22bTAe20qyIGLZeU5tyAECgoy9xUcKNmIyg8TFgRhfAvE/A1F4nKCg4Tc6EUXb
         g2J++gp5Zm5wzoWxZHRVZ/FsDfgD18oikdxH33L9pjSu02UNseeuxXcVbbUu2GoaRC/P
         HgzVbt6b6vzpbK3AteWBtDxTWWyfZMrizjp62EYFKmHjtDxx4vHd3gNU/LZvdenzT2IU
         hFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HhvZ3uKij/5andIsYWXWjb4Izd/6e/PP/vgXNxLfogY=;
        b=2/ic7hRmfmcrARLx2s6ZJtnNurD9ktgRBQ3TG5r5JHAR1HMfxza7kDiOdTDrGS8LL0
         18vX/tBIFv9G23RquVj3kjrZTDhvqxqNQLMBzBCjkZMzL+rh5x8DC4/TKtm068i9cJiT
         +ZcJOwlEkySP+/G2nWJ/ycytlqO/gliT09ttXvM0ge5vSGJlNwmUKVbpVQta7xlGDMVE
         Q7AZRrFUPblI8QA1H7LRCoV8kZOYpylg+gdnn+pilbl41c9zg8+odc1XAUE9XJICjJKE
         X0mZjTMYTmc/sSZOanGRDYa4rXBnKepznEWuwmKtZRN8y3Ori2UtYsFfShqf7gnlaIM+
         1sYw==
X-Gm-Message-State: AOAM532MpNi61JTvRtBSvepeSCtGA8ix73j+AY0nJLAS5f3WzpFot869
        ZoS5v8k1hnh+tDPIOQSBiLnMGIm81w1j6A==
X-Google-Smtp-Source: ABdhPJxoppz080L/K51cmR/DK3+uH3HTamW+P2BTnZcrNLMIGJdrepJU9AzsphtY3FXV8DqUpuNMZw==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr7075999wrq.30.1641977831283;
        Wed, 12 Jan 2022 00:57:11 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id n1sm12619238wri.46.2022.01.12.00.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:57:10 -0800 (PST)
Subject: Re: [PATCH v3] media: meson: vdec: Fix a NULL pointer dereference in
 amvdec_add_ts()
To:     Qingyang Zhou <zhou1615@umn.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211214144613.35fec82a@coco.lan>
 <20211215033535.40422-1-zhou1615@umn.edu>
 <368bc1b7-ff86-beaa-6749-afbe5960eaeb@xs4all.nl>
 <CA+Cm_xSOv5NnW5GXcKKGi8bQSvT45iH6=65YJk3EG6uW0c5_Vw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <7e9f1b17-7087-3513-84b9-f5dd25211b87@baylibre.com>
Date:   Wed, 12 Jan 2022 09:57:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CA+Cm_xSOv5NnW5GXcKKGi8bQSvT45iH6=65YJk3EG6uW0c5_Vw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/01/2022 14:03, Qingyang Zhou wrote:
> Hi Hans:
> 
> Here I certify that this is an origin patch I wrote. I did not copy Neil's patch, and I did not know his patch.
> 
> Neil, please post your original patch here, so everyone can see both patches.
> 
> Yours 
> Zhou Qingyang.
> 
> On Tue, Jan 11, 2022 at 5:16 PM Hans Verkuil <hverkuil-cisco@xs4all.nl <mailto:hverkuil-cisco@xs4all.nl>> wrote:
> 
>     Zhou Qingyang, this is exactly the patch Neil wrote, except you just stuck your
>     name on it. Not nice.
> 
>     Neil, can you post your patch with your own Signed-off-by, then I'll take that one.
> 
>     Regards,
> 
>             Hans
> 
>     On 15/12/2021 04:35, Zhou Qingyang wrote:
>     > In amvdec_add_ts(), there is a dereference of kzalloc(), which could lead
>     > to a NULL pointer dereference on failure of kzalloc().
>     >
>     > Fix this bug by adding a NULL check of new_ts.
>     >
>     > This bug was found by a static analyzer[1].
>     >
>     > Builds with CONFIG_VIDEO_MESON_VDEC=m show no new warnings,
>     > and our static analyzer no longer warns about this code.
>     >
>     > Fixes: 876f123b8956 ("media: meson: vdec: bring up to compliance")
>     > Signed-off-by: Zhou Qingyang <zhou1615@umn.edu <mailto:zhou1615@umn.edu>>
>     > ---
>     >
>     > [1] The analysis employs differential checking to identify inconsistent
>     > security operations (e.g., checks or kfrees) between two code paths and
>     > confirms that the inconsistent operations are not recovered in the
>     > current function or the callers, so they constitute bugs.
>     >
>     > Note that, as a bug found by static analysis, it can be a false
>     > positive or hard to trigger. Multiple researchers have cross-reviewed
>     > the bug.
>     >
>     > Changes in v3:
>     >   -  Change the description of patch
>     >   -  Turn the return type from 'void' to 'int'
>     >   -  Check the return value in the caller 'esparser_queue()'
>     >
>     > Changes in v2:
>     >   -  Delete dev_err() message
>     >
>     >  drivers/staging/media/meson/vdec/esparser.c     | 7 ++++++-
>     >  drivers/staging/media/meson/vdec/vdec_helpers.c | 8 ++++++--
>     >  drivers/staging/media/meson/vdec/vdec_helpers.h | 4 ++--
>     >  3 files changed, 14 insertions(+), 5 deletions(-)
>     >
>     > diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
>     > index db7022707ff8..095100a50da8 100644
>     > --- a/drivers/staging/media/meson/vdec/esparser.c
>     > +++ b/drivers/staging/media/meson/vdec/esparser.c
>     > @@ -328,7 +328,12 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>     > 
>     >       offset = esparser_get_offset(sess);
>     > 
>     > -     amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
>     > +     ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
>     > +     if (!ret) {
>     > +             v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>     > +             return ret;
>     > +     }
>     > +
>     >       dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
>     >               vb->timestamp, payload_size, offset, vbuf->flags);
>     > 
>     > diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
>     > index b9125c295d1d..06fd66539797 100644
>     > --- a/drivers/staging/media/meson/vdec/vdec_helpers.c
>     > +++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
>     > @@ -227,13 +227,16 @@ int amvdec_set_canvases(struct amvdec_session *sess,
>     >  }
>     >  EXPORT_SYMBOL_GPL(amvdec_set_canvases);
>     > 
>     > -void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>     > -                struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
>     > +int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>     > +               struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
>     >  {
>     >       struct amvdec_timestamp *new_ts;
>     >       unsigned long flags;
>     > 
>     >       new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
>     > +     if (!new_ts)
>     > +             return -ENOMEM;
>     > +
>     >       new_ts->ts = ts;
>     >       new_ts->tc = tc;
>     >       new_ts->offset = offset;
>     > @@ -242,6 +245,7 @@ void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>     >       spin_lock_irqsave(&sess->ts_spinlock, flags);
>     >       list_add_tail(&new_ts->list, &sess->timestamps);
>     >       spin_unlock_irqrestore(&sess->ts_spinlock, flags);
>     > +     return 0;
>     >  }
>     >  EXPORT_SYMBOL_GPL(amvdec_add_ts);
>     > 
>     > diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
>     > index 88137d15aa3a..4bf3e61d081b 100644
>     > --- a/drivers/staging/media/meson/vdec/vdec_helpers.h
>     > +++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
>     > @@ -56,8 +56,8 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
>     >   * @offset: offset in the VIFIFO where the associated packet was written
>     >   * @flags: the vb2_v4l2_buffer flags
>     >   */
>     > -void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>     > -                struct v4l2_timecode tc, u32 offset, u32 flags);
>     > +int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
>     > +               struct v4l2_timecode tc, u32 offset, u32 flags);
>     >  void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
>     > 
>     >  /**
> 

Let's inspect:

I posted a probable solution the 09/12/2021 in a reply to 20211209085840.2081024-1-jiasheng@iscas.ac.cn :

===================><=============================
diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index db7022707ff8..df733eff9ac7 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -328,7 +328,11 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)

        offset = esparser_get_offset(sess);

-       amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+       ret = amvdec_add_ts(sess, vb->timestamp, vbuf->timecode, offset, vbuf->flags);
+       if (ret) {
+               v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
+               return ret;
+       }
        dev_dbg(core->dev, "esparser: ts = %llu pld_size = %u offset = %08X flags = %08X\n",
                vb->timestamp, payload_size, offset, vbuf->flags);

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index b9125c295d1d..593b2ccbece2 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -227,13 +227,15 @@ int amvdec_set_canvases(struct amvdec_session *sess,
 }
 EXPORT_SYMBOL_GPL(amvdec_set_canvases);

-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
-                  struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+                 struct v4l2_timecode tc, u32 offset, u32 vbuf_flags)
 {
        struct amvdec_timestamp *new_ts;
        unsigned long flags;

        new_ts = kzalloc(sizeof(*new_ts), GFP_KERNEL);
+       if (!new_ts)
+               return -ENOMEM;
        new_ts->ts = ts;
        new_ts->tc = tc;
        new_ts->offset = offset;
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
index 88137d15aa3a..4bf3e61d081b 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.h
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
@@ -56,8 +56,8 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
  * @offset: offset in the VIFIFO where the associated packet was written
  * @flags: the vb2_v4l2_buffer flags
  */
-void amvdec_add_ts(struct amvdec_session *sess, u64 ts,
-                  struct v4l2_timecode tc, u32 offset, u32 flags);
+int amvdec_add_ts(struct amvdec_session *sess, u64 ts,
+                 struct v4l2_timecode tc, u32 offset, u32 flags);
 void amvdec_remove_ts(struct amvdec_session *sess, u64 ts);
===================><=============================


Then the patches were sent:
- 20211210015620.2143555-1-jiasheng@iscas.ac.cn on 10/12/2021
- 20211215033535.40422-1-zhou1615@umn.edu on 15/12/2021

They are extremely close but not similar, mostly indenting differs.

Both patches have the missing final "return 0" in amvdec_add_ts which is missing in my proposal.

But only 20211210015620.2143555-1-jiasheng@iscas.ac.cn has the correct "if (ret)" in esparser_queue().
Patch 20211215033535.40422-1-zhou1615@umn.ed has a wrong "if (!ret)".

But when comparing, 20211215033535.40422-1-zhou1615@umn.edu is an almost exact copy of my proposal, minus the fixes and the bogus return check.

To be honest, there is a limited way to fix this, it's probable 20211215033535.40422-1-zhou1615@umn.edu was written independently from
my proposal since there is a bug return check, and 20211210015620.2143555-1-jiasheng@iscas.ac.cn was rewritten from my proposal.

Since 20211215033535.40422-1-zhou1615@umn.ed has a bogus return check, it should be naked.

I'll only ask 20211210015620.2143555-1-jiasheng@iscas.ac.cn to be resent with a "Suggested-by" and indentation fixed like my proposal.

Neil

