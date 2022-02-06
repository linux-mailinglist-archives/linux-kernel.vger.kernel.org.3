Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD9E4AAF02
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiBFLeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbiBFLea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:34:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BE0C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 03:34:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22522B80DAC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 11:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC650C340E9;
        Sun,  6 Feb 2022 11:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644147264;
        bh=fnCdcI1MTiqaB0sidIsbvWztDw55cMdvbUs/9eWFC3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWlTrDigBu+Bog7DiSa4k0/X0KR8qLDgSGFIFJ8bwRFNKYsmPBVsvpcf9tRi5Jv4Z
         6LohQm+3Ff8XaJSmYz1LX2+Lw2Ib+VV90ZuWL1TPu0PSmJFucr9Q7hdZC7cPkUQO/4
         18EnTvSBmafjHLtbLHCA5tV4U2rJpFg83DUzfSTI2z0adaSnkv+4iwRutzHlGH3oeg
         C0WyL6TObkGD6Wj7GMxIGlSB3axE2beyIXpTOyQMkbFaN/9HFdOkAaXsmF39tWi+l1
         ed/v6XVnSjP3k7Mnt372h279rTuDlm8O1DMeUMUfTo3hr4WzloC5FdXk61ajL+xz/L
         T71FcomYlvUeQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4D0A7404A6; Sun,  6 Feb 2022 08:34:22 -0300 (-03)
Date:   Sun, 6 Feb 2022 08:34:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1 fyi] tools include UAPI: Sync sound/asound.h copy
 with the kernel sources
Message-ID: <Yf+yPiujVTH2nkW8@kernel.org>
References: <YflN0j09T+6ODHIh@kernel.org>
 <s5hleytzhca.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hleytzhca.wl-tiwai@suse.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 02, 2022 at 11:35:33AM +0100, Takashi Iwai escreveu:
> On Tue, 01 Feb 2022 16:12:18 +0100,
> Arnaldo Carvalho de Melo wrote:
> > 
> > Picking the changes from:
> > 
> >   55b71f6c29f2a78a ("ALSA: uapi: use C90 comment style instead of C99 style")
> >   fb6723daf89083a0 ("ALSA: pcm: comment about relation between msbits hw parameter and [S|U]32 formats")
> >   b456abe63f60ad93 ("ALSA: pcm: introduce INFO_NO_REWINDS flag")
> >   5aec579e08e4f2be ("ALSA: uapi: Fix a C++ style comment in asound.h")
> > 
> > Which entails no changes in the tooling side as it doesn't introduce new
> > SNDRV_PCM_IOCTL_ ioctls.
> > 
> > To silence this perf tools build warning:
> > 
> >   Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
> >   diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h
> > 
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Thanks for the patch.
> Shall I merge this through sound git tree or was already merged in
> somewhere else?

It'll go thru the perf tools tree, thanks.

- Arnaldo
 
> 
> Takashi
> 
> > ---
> >  tools/include/uapi/sound/asound.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
> > index 5fbb79e30819af91..ef0cafe295b28253 100644
> > --- a/tools/include/uapi/sound/asound.h
> > +++ b/tools/include/uapi/sound/asound.h
> > @@ -202,6 +202,11 @@ typedef int __bitwise snd_pcm_format_t;
> >  #define	SNDRV_PCM_FORMAT_S24_BE	((__force snd_pcm_format_t) 7) /* low three bytes */
> >  #define	SNDRV_PCM_FORMAT_U24_LE	((__force snd_pcm_format_t) 8) /* low three bytes */
> >  #define	SNDRV_PCM_FORMAT_U24_BE	((__force snd_pcm_format_t) 9) /* low three bytes */
> > +/*
> > + * For S32/U32 formats, 'msbits' hardware parameter is often used to deliver information about the
> > + * available bit count in most significant bit. It's for the case of so-called 'left-justified' or
> > + * `right-padding` sample which has less width than 32 bit.
> > + */
> >  #define	SNDRV_PCM_FORMAT_S32_LE	((__force snd_pcm_format_t) 10)
> >  #define	SNDRV_PCM_FORMAT_S32_BE	((__force snd_pcm_format_t) 11)
> >  #define	SNDRV_PCM_FORMAT_U32_LE	((__force snd_pcm_format_t) 12)
> > @@ -300,7 +305,7 @@ typedef int __bitwise snd_pcm_subformat_t;
> >  #define SNDRV_PCM_INFO_HAS_LINK_ESTIMATED_ATIME    0x04000000  /* report estimated link audio time */
> >  #define SNDRV_PCM_INFO_HAS_LINK_SYNCHRONIZED_ATIME 0x08000000  /* report synchronized audio/system time */
> >  #define SNDRV_PCM_INFO_EXPLICIT_SYNC	0x10000000	/* needs explicit sync of pointers and data */
> > -
> > +#define SNDRV_PCM_INFO_NO_REWINDS	0x20000000	/* hardware can only support monotonic changes of appl_ptr */
> >  #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
> >  #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
> >  
> > -- 
> > 2.34.1
> > 

-- 

- Arnaldo
