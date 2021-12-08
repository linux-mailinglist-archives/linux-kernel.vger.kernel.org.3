Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2446DE58
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhLHW16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLHW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:27:57 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B62EC061746;
        Wed,  8 Dec 2021 14:24:25 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v19so2496082plo.7;
        Wed, 08 Dec 2021 14:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sjS5eItpdC2YAneQBFUzXQv4ThbjKdadvDzqHsuyyiM=;
        b=TIHf2TuurWUu9NDI8Z+xbRQzvmAeW1uO9EmCg3dzjGBe1wTodqsbEUsPU3E9k1aRMS
         uwQN5CZiRVsgqo/svigGIlw6YvFhQHDpInen7oDbAoHOLbCgwkGiPa0ub4mroYwr/3Xc
         P9NztxUTA90bhIbDLRwZGzOhINfOuAXVFyM263s6x2XP6ZbyAgbVs2t2/U+8Y5L1Nqxc
         wPwlaRQR7toRKBTfsvrUZeV5l1ciuhVeoGQ70mVLrRKyuSgCaT+Xn9CnNrEM9yduhx05
         8EK35dj7f1hSLiD25/GeRF9iSY3AF3x8TWdd3LwsOgiOUqnb+//m0V0yXv42GKx3w2oD
         tCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sjS5eItpdC2YAneQBFUzXQv4ThbjKdadvDzqHsuyyiM=;
        b=1kIIyIKgLURiTyxKKw4VBkF1vU3C6A58UXXdySrY2k+53tWAmxooaMRUzJX3wrLlaS
         UGAxESE1evlmaxPySh6Vym1We4p3ihWoOeN6i7SVfOngrW/TMnOIEtk9mpsXNuF/DnYy
         mA5CZH7pDpVyjGPeZVGhQmpnUCiW6sVyDLVqVdKFhAXXe63FLPTXtU7cWMdFU95uYSVh
         WR1kIOXHZJSRpj+oHQb5ph6e5661DSzHdMATTwq5ExSAcd2tN56wklu4evYjQJqvlWQ5
         u8tJD0qq4Nd2mt8sgfqKLCLW0YFD84otEpmqzh86PTjr6cDs5SLjNnzJUAKsRbhB9s0f
         gGPQ==
X-Gm-Message-State: AOAM533XHfn6XqVE/DmKjdv8HcxJne6QbDA/9T1RUXMyE4vBZ98XHzGK
        wpJYDw65Fvr+qyFPTy4S5rE=
X-Google-Smtp-Source: ABdhPJwup0a/qCgp+cDVkP8fXKl8o0ew7hh/iIElik2tQE7jRVCrx4qSZdmdxXE7A7GPoVBd6YeKKQ==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6c92 with SMTP id g7-20020a1709026b4700b0014282e16c92mr62484623plt.84.1639002264505;
        Wed, 08 Dec 2021 14:24:24 -0800 (PST)
Received: from sol (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id ml24sm3652070pjb.16.2021.12.08.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:24:23 -0800 (PST)
Date:   Thu, 9 Dec 2021 06:24:17 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
Message-ID: <20211208222417.GA4654@sol>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-10-dipenp@nvidia.com>
 <20211126013137.GC10380@sol>
 <9ad666ec-eedd-8075-73e6-1e47a1eb228b@nvidia.com>
 <20211201171638.GA31045@sol>
 <4c7c3db1-a1b3-1944-4278-cb37e8a4f373@nvidia.com>
 <20211202005349.GA7007@sol>
 <395ba111-d620-f302-d0e7-8f20f39e6485@nvidia.com>
 <9e53c30f-63e5-b2ca-a2ef-f85dab596b3c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e53c30f-63e5-b2ca-a2ef-f85dab596b3c@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 12:14:36PM -0800, Dipen Patel wrote:
> Hi,
> 
> On 12/7/21 5:42 PM, Dipen Patel wrote:
> > On 12/1/21 4:53 PM, Kent Gibson wrote:
> >> On Wed, Dec 01, 2021 at 10:01:46AM -0800, Dipen Patel wrote:
> >>> Hi,
> >>>
> >>>
> >>> On 12/1/21 9:16 AM, Kent Gibson wrote:
> >>>> On Tue, Nov 30, 2021 at 07:29:20PM -0800, Dipen Patel wrote:
> >>>>>
> >>>>>> [snip]
> >>>>>>> +	if (line->dir >= HTE_DIR_NOSUPP) {
> >>>>>>> +		eflags = READ_ONCE(line->eflags);
> >>>>>>> +		if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
> >>>>>>> +			int level = gpiod_get_value_cansleep(line->desc);
> >>>>>>> +
> >>>>>>> +			if (level)
> >>>>>>> +				/* Emit low-to-high event */
> >>>>>>> +				le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>>>>> +			else
> >>>>>>> +				/* Emit high-to-low event */
> >>>>>>> +				le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
> >>>>>>> +			/* Emit low-to-high event */
> >>>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
> >>>>>>> +			/* Emit high-to-low event */
> >>>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>>>> +		} else {
> >>>>>>> +			return HTE_CB_ERROR;
> >>>>>>> +		}
> >>>>>>> +	} else {
> >>>>>>> +		if (line->dir == HTE_RISING_EDGE_TS)
> >>>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>>>>> +		else
> >>>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>>>> +	}
> >>>>>> The mapping from line->dir to le.id needs to take into account the active
> >>>>>> low setting for the line.
> >>>>>>
> >>>>>> And it might be simpler if the hte_ts_data provided the level, equivalent
> >>>>>> to gpiod_get_raw_value_cansleep(), rather than an edge direction, so you
> >>>>>> can provide a common helper to determine the edge given the raw level.
> >>>>> (So from the level determine the edge?) that sound right specially when
> >>>>>
> >>>>> HTE provider has capability to record the edge in that case why bother
> >>>>>
> >>>>> getting the level and determine edge?
> >>>>>
> >>>>> Calculating the edge from the level makes sense when hte provider does not
> >>>>>
> >>>>> have that feature and that is what if (line->dir >= HTE_DIR_NOSUPP) does.
> >>>>>
> >>>> As asked in the review of patch 02, do you have an example of hardware that
> >>>> reports an edge direction rather than NOSUPP?
> >>> No...
> >> So you are adding an interface that nothing will currently use.
> >> Are there plans for hardware that will report the edge, and you are
> >> laying the groundwork here?
> > Adding here for the general case should there be provider
> >
> > available with such feature.
> 
> I have a doubt as below on how edge_irq_thread calculates le.id (Only for
> 
> gpiod_get_value_cansleep case), i believe clearing that doubt will help me properly
> 
> address this issue:
> 
> - Does it have potential to read level which might have changed by the time thread is run?
> 

Yes it does.

> - Does it make sense to read it in edge_irq_handler instead at least of the chip which can
> 
> fetch the level without needing to sleep?
> 

That would not make it any more valid.  There is an inherent race there
- that is the nature of the irq interface.
The existing code does the best it can in the circumstances - for the
more likely case that there isn't another edge between the interrupt
handler and thread.

The hte can do better - assumung it has hardware capable of providing the
edge as well as the timestamp.

Cheers,
Kent.
