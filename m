Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D164A54ADDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiFNJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355679AbiFNJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:59:00 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1374614C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:58:59 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id AC41A5201FA;
        Tue, 14 Jun 2022 11:58:57 +0200 (CEST)
Received: from lxhi-065 (10.72.94.27) by hi2exch02.adit-jv.com (10.72.92.28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Tue, 14 Jun
 2022 11:58:57 +0200
Date:   Tue, 14 Jun 2022 11:58:51 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
CC:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>,
        <syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com>,
        <naveenkumar.sunkari@in.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Test for "silence" field in struct
 "pcm_format_data"
Message-ID: <20220614095851.GA4199@lxhi-065>
References: <20220409012655.9399-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220409012655.9399-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.94.27]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fabio, hello All,

On Sa, Apr 09, 2022 at 03:26:55 +0200, Fabio M. De Francesco wrote:
> Syzbot reports "KASAN: null-ptr-deref Write in
> snd_pcm_format_set_silence".[1]
> 
> It is due to missing validation of the "silence" field of struct
> "pcm_format_data" in "pcm_formats" array.
> 
> Add a test for valid "pat" and, if it is not so, return -EINVAL.
> 
> [1] https://lore.kernel.org/lkml/000000000000d188ef05dc2c7279@google.com/
> 
> Reported-and-tested-by: syzbot+205eb15961852c2c5974@syzkaller.appspotmail.com
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> I wasn't able to figure out the commit for the "Fixes:" tag. If this patch
> is good, can someone please help with providing this missing information?
> 
>  sound/core/pcm_misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> index 4866aed97aac..5588b6a1ee8b 100644
> --- a/sound/core/pcm_misc.c
> +++ b/sound/core/pcm_misc.c
> @@ -433,7 +433,7 @@ int snd_pcm_format_set_silence(snd_pcm_format_t format, void *data, unsigned int
>  		return 0;
>  	width = pcm_formats[(INT)format].phys; /* physical width */
>  	pat = pcm_formats[(INT)format].silence;
> -	if (! width)
> +	if (!width || !pat)
>  		return -EINVAL;
>  	/* signed or 1 byte data */
>  	if (pcm_formats[(INT)format].signd == 1 || width <= 8) {

JFYI, PVS-Studio 7.19 reports:

sound/core/pcm_misc.c	409	warn	V560 A part of conditional expression is always false: !pat.

I haven't fully validated the finding, but it appears to be legit,
since the pointer variable (as opposed to the contents behind the
pointer) is always non-null, hence !pat always evaluating to false.

If the above is true, then the patch likely hasn't introduced any
regression, but also likely hasn't fixed the original KASAN problem.

Or are there alternative views?

BR, Eugeniu.
