Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF395578D14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbiGRVty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbiGRVtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:49:52 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AE828E3E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:49:51 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10c0119dd16so27511321fac.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YRegPlGkAgnXCQS+56XrhwlChkX0WERwCF78v3+dEDE=;
        b=tx4wDsqJpNDyDy+RoCSOngclATfOSZSGSNqXermhdzAgWIJQzVv0Sma93TTt5PbTRY
         +e7j74ZUKxge80dMCD6hCLmAJ2hJBFc3zvXypaiavIDgrvxyXj1DjZQdv7wvxR1Wxoxk
         4+rGISmGIRqAt8HpsKy75keqQh+uErIt/MgHLMjTRI2ItvOLvWYMS5l0MstP+DAKkbzD
         cnRaXQS6t2qZe6WYsf8Y+oGTp3+xwjJ1crHibSHTjBN6Y73d8RHByBcdPS0VB24OCp9h
         0ndrMFGKb1W0GUoTKLkZNswK44qbXle4hLt5CkaXZ6tWaHq08rpmzz+QP9mgMrtl3oks
         nf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YRegPlGkAgnXCQS+56XrhwlChkX0WERwCF78v3+dEDE=;
        b=7/y+hH0mchMDFCJCaPM3LCwh3yT5wdNf7zGKuLVP4+14KXG19GrHuFUTXnlIrtRG72
         yF9GDs6B7uMCciWw40/rmIct88EnoSWcVME9BncZAgCNoSMv+tIT/m3RRPc+vJKINpP2
         zAAGgFV9Tw0EuyR8pOktaK/fHJteugjwD9QV2oSJ3leh+PWXbOQMJkMB5FBzez5OlI6s
         kjhkFbNYncVXbbFP55YbWTb/Et0CxiTbgfJAUfZbgLmNHbK7m5kOu+4obxnTs7RLOGJq
         7dho2omUmlqQidY1OpliIrwTdJhZ84TTZrzNMakeQ49UsrIZKVFzMFkD8hUu7lVwpc6s
         +WSg==
X-Gm-Message-State: AJIora9XHPpoqs53zjw47HfUFWKSCL8WhbWq7jVIYdgnkD9PzwL/D8ox
        72bwNmTNG535wH45KLhsgGS8Fw==
X-Google-Smtp-Source: AGRyM1vz+73Xt/EprCxr0glRx7mlW8o0gR7RQ50oLzXGipGpGPDEmsqZtjvD/fY5SFshUU/R35B23w==
X-Received: by 2002:a05:6808:1691:b0:2f9:4bd7:581e with SMTP id bb17-20020a056808169100b002f94bd7581emr16545639oib.144.1658180990517;
        Mon, 18 Jul 2022 14:49:50 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c127-20020a4a0585000000b00431003ca076sm5472932ooc.44.2022.07.18.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:49:50 -0700 (PDT)
Date:   Mon, 18 Jul 2022 18:49:44 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, paul.kocialkowski@bootlin.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: cedrus: hevc: Add check for invalid timestamp
Message-ID: <YtXVeAChyKlfqD8O@eze-laptop>
References: <20220718165649.16407-1-jernej.skrabec@gmail.com>
 <4725382.GXAFRqVoOG@kista>
 <b588b53fcfe539692a0a55b9fd0e97528def1d96.camel@collabora.com>
 <1795344.atdPhlSkOF@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1795344.atdPhlSkOF@jernej-laptop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

On Mon, Jul 18, 2022 at 10:34:37PM +0200, Jernej Škrabec wrote:
> Dne ponedeljek, 18. julij 2022 ob 21:37:31 CEST je Nicolas Dufresne 
> napisal(a):
> > Le lundi 18 juillet 2022 à 19:57 +0200, Jernej Škrabec a écrit :
> > > Dne ponedeljek, 18. julij 2022 ob 19:41:48 CEST je Nicolas Dufresne
> > > 
> > > napisal(a):
> > > > Le lundi 18 juillet 2022 à 18:56 +0200, Jernej Skrabec a écrit :
> > > > > Not all DPB entries will be used most of the time. Unused entries will
> > > > > thus have invalid timestamps. They will produce negative buffer index
> > > > > which is not specifically handled. This works just by chance in
> > > > > current
> > > > > code. It will even produce bogus pointer, but since it's not used, it
> > > > > won't do any harm.
> > > > > 
> > > > > Let's fix that brittle design by skipping writing DPB entry altogether
> > > > > if timestamp is invalid.
> > > > > 
> > > > > Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > > > ---
> > > > > 
> > > > >  drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 3 +++
> > > > >  1 file changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c index
> > > > > 1afc6797d806..687f87598f78 100644
> > > > > --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > > > > @@ -147,6 +147,9 @@ static void
> > > > > cedrus_h265_frame_info_write_dpb(struct
> > > > > cedrus_ctx *ctx,>
> > > > > 
> > > > >  			dpb[i].pic_order_cnt_val
> > > > >  		
> > > > >  		};
> > > > > 
> > > > > +		if (buffer_index < 0)
> > > > > +			continue;
> > > > 
> > > > When I compare to other codecs, when the buffer_index does not exist,
> > > > the
> > > > addr 0 is being programmed into the HW. With this implementation is is
> > > > left
> > > > to whatever it was set for the previous decode operation. I think its is
> > > > nicer done the other way.
> > > 
> > > It's done the same way as it's done in vendor lib. As I stated in commit
> > > message, actual values don't matter for unused entries. If it is used by
> > > accident, HW reaction on all zero pointers can only be worse than using
> > > old, but valid entry.
> > > 
> > > Due to no real documentation and Allwinner unwillingness to share details,
> > > we'll probably never know what's best response for each error. Some things
> > > can be deduced from vendor code, but not all.
> > > 
> > > I would rather not complicate this fix, especially since it's candidate
> > > for
> > > backporting.

I think this makes sense, since it allows to fix the bug for the time
being.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks!
Ezequiel

> > 
> > I am simply trying to highlight that this is not consistant with how the
> > H264 part is done. Why do we reset the register for one codec and not the
> > other ?
> 
> While H264 and HEVC are similar in many ways, Cedrus uses two different cores 
> or in Cedrus slang, engines, for them. They have their own quirks. One of the 
> most apparent is handling of DPB array. H264 requires that same entry is 
> always at the same position in HW DPB. That's not required by HEVC.
> 
> Additional reasons for differences come from the fact that it's from two 
> different authors (Maxime and Paul). Those differences were created at the 
> beginning and it is what it is.
> 
> > 
> > Perhaps you should sync to your preference the driver as a whole. It also
> > seems that before your patch, some bits would be 0 and some other would be
> > very large values. Between this and leaving random value, I don't really
> > see any gain or reason for a backport. It neither break or fix anything as
> > far as I understand.
> 
> Maybe there is no need to backport, but the change is nevertheless useful. As 
> I explained, current code works only by chance, as we noticed with Ezequiel's 
> rework. It's certainly worthwhile to make code less brittle. As far as I'm 
> concerned, fixes tag can be dropped or even Ezequiel can squash this change 
> into his commit, with appropriate adjustments, of course.
> 
> I'm not completely sure what do you mean by syncing driver preference. Code 
> changes always need a good reason to be accepted. Moving code around and 
> renaming things just to be similar with something else is not.
> 
> Best regards,
> Jernej
> 
> > 
> > My general opinion, is that we fixe the unused address (like to 0) then when
> > something goes wrong, as least it will go wrong consistently.
> > 
> > > Best regards,
> > > Jernej
> > > 
> > > > > +
> > > > > 
> > > > >  		cedrus_h265_frame_info_write_single(ctx, i,
> > > 
> > > dpb[i].field_pic,
> > > 
> > > 
> > > pic_order_cnt,
> > > 
> > > buffer_index);
> 
> 
> 
> 
