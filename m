Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897044AE38D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387339AbiBHWXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386227AbiBHTqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:46:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C14C0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:46:40 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k13so35328897lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 11:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:user-agent:references
         :mime-version:content-disposition:in-reply-to;
        bh=mS3C+Wo/VrSubSEHXbpL025cTzdbcGtIyC7RL2QVj1k=;
        b=dxvNMVA9VhI2Ic4/NqHu66Bawb1X5QOhCGBr7npMY8t0pMy5egEwQ0zGOws3/p5UVU
         obo6BmPk66JYaDw/VWbvHOvxEkyB6IG4uQPA681CCErEaT175YwGVuJ8hRr2LNGEdwJv
         hwvryfKvyGmCbsbR2brFkXCc0SXJJQiKzHmb9mtpqzIYoPWXLhPfAyq3Ep0QpJXxQ1PX
         eV3kPJ1Yhmj1kkjoI/XdB8AToWTvdeLOwvfrez2kcWfcNbEzbnK2sqKBaZHZiWtuYIix
         9Sq4+XseteOthTLKIlejiaY2MjChGKOPPyznlI8H4jXDySKECV5FKj6mblYepfNKbH3B
         LzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :references:mime-version:content-disposition:in-reply-to;
        bh=mS3C+Wo/VrSubSEHXbpL025cTzdbcGtIyC7RL2QVj1k=;
        b=FX1AEr+Qd8SenVmv3/4QHh7qlXXMpGCIzf0hcvQkC9wSrddtk3YLwJhYiIFROUuRmf
         lutCF9k569bp2vye0YovMllt5iokI3AFCogoSbKRRSezv0FKw1lHBe8wGSZf2fg9h7oX
         qGW35qHwvDi30VV8pQ1lQDZWiZmiUt7k6eYM3PeXKkZroHDDg4OU0mpeq1mIXq7iyMQT
         jyFFayu2jYF8xpAyfoIHB5OblW5W1+YkIrSeMFJLeiKl98pOJPusR6y0jv7xemYR+cdh
         SOOnDuwgccZMulnDfUUChkWXcxFwaCDa7R0LjVroDU026Vw6rYOp67qrjV9h9alnrAeD
         /9Dg==
X-Gm-Message-State: AOAM533lJ0gdFb0IXUIT5ppiNr0HlxA9Xk0Vly09uOWNWN1xGyXn+q5W
        WCIvRIcKOSMTNKMYFPVnX+o=
X-Google-Smtp-Source: ABdhPJxEzT360EJlxEiU+T+hZd/m/GXxo+WymxxJdJOvSwtymCUmypCgsT6c6ReKKHiNy7lhnZElsw==
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr4040567lfp.580.1644349599141;
        Tue, 08 Feb 2022 11:46:39 -0800 (PST)
Received: from localhost.localdomain (broadband-95-84-228-163.ip.moscow.rt.ru. [95.84.228.163])
        by smtp.gmail.com with ESMTPSA id l12sm381178lfg.32.2022.02.08.11.46.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 08 Feb 2022 11:46:38 -0800 (PST)
Date:   Tue, 8 Feb 2022 22:52:37 +0300
From:   Alexander Sergeyev <sergeev917@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jeremy Szu <jeremy.szu@canonical.com>, tiwai@suse.com,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kailang Yang <kailang@realtek.com>,
        open list <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        PeiSen Hou <pshou@realtek.com>
Subject: Re: [PATCH 1/4] ALSA: hda/realtek: fix mute/micmute LEDs for HP 855
 G8
Message-ID: <20220208195237.3tnsslzaj2pmzr25@localhost.localdomain>
User-Agent: mtt
References: <20220115152215.kprws5nja2i43qax@localhost.localdomain>
 <s5hilugw0l0.wl-tiwai@suse.de>
 <20220119093249.eaxem33bjqjxcher@localhost.localdomain>
 <20220122190522.ycaygrqcen7d3hj2@localhost.localdomain>
 <20220122205637.7gzurdu7xl4sthxw@localhost.localdomain>
 <s5ho83yldu3.wl-tiwai@suse.de>
 <20220129144704.xlmeylllvy3b3fum@localhost.localdomain>
 <20220130111020.44gzrm5ckrakjta2@localhost.localdomain>
 <s5htudk9cn3.wl-tiwai@suse.de>
 <s5h4k59s9wn.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4k59s9wn.wl-tiwai@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 03:36:08PM +0100, Takashi Iwai wrote:
> ... and here is a fix patch for allowing more rebinds.
> Give it a try.

It works, no problems with large numbers of rebinds.

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda: Fix driver index handling at re-binding
> 
> HD-audio driver handles the multiple instances and keeps the static
> index that is incremented at each probe.  This becomes a problem when
> user tries to re-bind the device via sysfs multiple times; as the
> device index isn't cleared unlike rmmod case, it points to the next
> element at re-binding, and eventually later you can't probe any more
> when it reaches to SNDRV_CARDS_MAX (usually 32).
> 
> This patch is an attempt to improve the handling at rebinding.
> Instead of a static device index, now we keep a bitmap and assigns to
> the first zero bit position.  At the driver remove, in return, the
> bitmap slot is cleared again, so that it'll be available for the next
> probe.
> 
> Reported-by: Alexander Sergeyev <sergeev917@gmail.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 4b0338c4c543..a2922233e85f 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2064,14 +2064,16 @@ static const struct hda_controller_ops pci_hda_ops = {
>  	.position_check = azx_position_check,
>  };
>  
> +static DECLARE_BITMAP(probed_devs, SNDRV_CARDS);
> +
>  static int azx_probe(struct pci_dev *pci,
>  		     const struct pci_device_id *pci_id)
>  {
> -	static int dev;
>  	struct snd_card *card;
>  	struct hda_intel *hda;
>  	struct azx *chip;
>  	bool schedule_probe;
> +	int dev;
>  	int err;
>  
>  	if (pci_match_id(driver_denylist, pci)) {
> @@ -2079,10 +2081,11 @@ static int azx_probe(struct pci_dev *pci,
>  		return -ENODEV;
>  	}
>  
> +	dev = find_first_zero_bit(probed_devs, SNDRV_CARDS);
>  	if (dev >= SNDRV_CARDS)
>  		return -ENODEV;
>  	if (!enable[dev]) {
> -		dev++;
> +		set_bit(dev, probed_devs);
>  		return -ENOENT;
>  	}
>  
> @@ -2149,7 +2152,7 @@ static int azx_probe(struct pci_dev *pci,
>  	if (schedule_probe)
>  		schedule_delayed_work(&hda->probe_work, 0);
>  
> -	dev++;
> +	set_bit(dev, probed_devs);
>  	if (chip->disabled)
>  		complete_all(&hda->probe_wait);
>  	return 0;
> @@ -2372,6 +2375,7 @@ static void azx_remove(struct pci_dev *pci)
>  		cancel_delayed_work_sync(&hda->probe_work);
>  		device_lock(&pci->dev);
>  
> +		clear_bit(chip->dev_index, probed_devs);
>  		pci_set_drvdata(pci, NULL);
>  		snd_card_free(card);
>  	}
> -- 
> 2.34.1
> 
