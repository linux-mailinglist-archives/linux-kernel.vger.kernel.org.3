Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869BB46DE60
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhLHWcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhLHWcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:32:23 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21463C061746;
        Wed,  8 Dec 2021 14:28:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q16so3282624pgq.10;
        Wed, 08 Dec 2021 14:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/it6HUZe959wBYIVpiVf+D67NNYbXNlv4wwVqi+e6Y0=;
        b=gz9YfWv0VsLC/Lnyv4vwZn2ab367PM27+JLPvUZsaodAXpnv4TjVcREM2UsphOWN3i
         KpuRtfYDJJdMXcip8z01NjwhSwqUd3OTABV4/e9Ml3aPxj6Pu5IJ6divBN+kyDTLxkOD
         IzFE7ywsaSjbeho8pdt1Va21CXGbY6ImkSrEt4+E5EWPppoMhg3VTH5U+7FACkmRnECa
         z4xq/L42rzeYOfKHjJVKNBIJcWEiRS0l32xwlSOcfcybj/dZDV2B9oDSSvaduk8uJM9r
         Z/ZQQu9byU23CUwL7btzS0jJH4l0oOML40IZ6oWzFZhc0bgsaeHd/Iddm2yhXAe0jYoA
         LnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/it6HUZe959wBYIVpiVf+D67NNYbXNlv4wwVqi+e6Y0=;
        b=j22nNHk4O2UvMVP/oeLefolmg2nGx8c505SWcaQpIOUwm7+9sZErDxK5/4Eb7sVf5h
         EN3suhv3AUGwPsw8P2Ma4ATlvTp2KbXjJidwvCpUquhruaPnEeyJRdWAtzGqgJYjd4Wh
         U/Rr/0vbX8vrk+gjKl2fwNaW77rk1de0/BQliLXY6TgF810yf+GAWf0CMZf861uROfgK
         t+6ioW6pG3OQ41uuDWZLmz5hZglCfORv6dKjuj50839DnzAnxdiJLQBbvsJ9o3VYBzE0
         yUQO/nC+4BwcuVXn4Txu4hwBe/jQzYYpIKPryRhklmrMbOOI3cADnOFxA/o0mBNSgKes
         4AFQ==
X-Gm-Message-State: AOAM5330hhULM2YyqDNLkHcLnQ3NO1VTml+dRftH6ebyGbisEEZXAWNS
        PeNoSDwuiGUHSnB+4bWhgow=
X-Google-Smtp-Source: ABdhPJxmqu6F2G56Ex2EyqpVECWVKKS5EjcdG6NrjjIpZRSyWVMlHoJo7v9ZSdtp0OuCiMrrWcB3ZA==
X-Received: by 2002:a63:9902:: with SMTP id d2mr31720116pge.104.1639002530422;
        Wed, 08 Dec 2021 14:28:50 -0800 (PST)
Received: from sol (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id t13sm4565061pfl.98.2021.12.08.14.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:28:49 -0800 (PST)
Date:   Thu, 9 Dec 2021 06:28:43 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
Message-ID: <20211208222843.GA5029@sol>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-10-dipenp@nvidia.com>
 <20211126013137.GC10380@sol>
 <9ad666ec-eedd-8075-73e6-1e47a1eb228b@nvidia.com>
 <20211201171638.GA31045@sol>
 <4c7c3db1-a1b3-1944-4278-cb37e8a4f373@nvidia.com>
 <20211202005349.GA7007@sol>
 <395ba111-d620-f302-d0e7-8f20f39e6485@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <395ba111-d620-f302-d0e7-8f20f39e6485@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:42:35PM -0800, Dipen Patel wrote:
> 
> On 12/1/21 4:53 PM, Kent Gibson wrote:
> > On Wed, Dec 01, 2021 at 10:01:46AM -0800, Dipen Patel wrote:
> >> Hi,
> >>
> >>
> >> On 12/1/21 9:16 AM, Kent Gibson wrote:
> >>> On Tue, Nov 30, 2021 at 07:29:20PM -0800, Dipen Patel wrote:
> >>>> Hi,
> >>>>
> >>>> On 11/25/21 5:31 PM, Kent Gibson wrote:
> >>>>> On Tue, Nov 23, 2021 at 11:30:36AM -0800, Dipen Patel wrote:
> >>>>>> This patch adds new clock type for the GPIO controller which can
> >>>>>> timestamp gpio lines in realtime using hardware means. To expose such
> >>>>>> functionalities to the userspace, code has been added in this patch
> >>>>>> where during line create call, it checks for new clock type and if
> >>>>>> requested, calls hardware timestamp related API from gpiolib.c.
> >>>>>> During line change event, the HTE subsystem pushes timestamp data
> >>>>>> through callbacks.
> >>>>>>
> >>>>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >>>>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>>>> ---
> >>>>>> Changes in v2:
> >>>>>> - Added hte_dir and static structure hte_ts_desc.
> >>>>>> - Added callbacks which get invoked by HTE when new data is available.
> >>>>>> - Better use of hte_dir and seq from hte_ts_desc.
> >>>>>> - Modified sw debounce function to accommodate hardware timestamping.
> >>>>>>
> >>>>>>  drivers/gpio/gpiolib-cdev.c | 161 ++++++++++++++++++++++++++++++++++--
> >>>>>>  include/uapi/linux/gpio.h   |   1 +
> >>>>>>  2 files changed, 153 insertions(+), 9 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> >>>>>> index c7b5446d01fd..1736ad54e3ec 100644
> >>>>>> --- a/drivers/gpio/gpiolib-cdev.c
> >>>>>> +++ b/drivers/gpio/gpiolib-cdev.c
> >>>>>> @@ -464,6 +464,12 @@ struct line {
> >>>>>>  	 * stale value.
> >>>>>>  	 */
> >>>>>>  	unsigned int level;
> >>>>>> +	/*
> >>>>>> +	 * dir will be touched in HTE callbacks hte_ts_cb_t and
> >>>>>> +	 * hte_ts_threaded_cb_t and they are mutually exclusive. This will be
> >>>>>> +	 * unused when HTE is not supported/disabled.
> >>>>>> +	 */
> >>>>>> +	enum hte_dir dir;
> >>>>>>  };
> >>>>>>  
> >>>>> Documentation should be in present tense, so 
> >>>>>
> >>>>> s/will be/is/g
> >>>>>
> >>>>> Same applies to other patches.
> >>>>>
> >>>>> Also
> >>>>>
> >>>>> s/touched/accessed/
> >>>>>
> >>>>> dir is a poor name for the field.  It is the hte edge direction and
> >>>>> effectively the line level, so call it hte_edge_dirn or
> >>>>> hte_edge_direction or hte_level.
> >>>>>
> >>>>> And it is placed in a section of the struct documented as "debouncer specific
> >>>>> fields", but it is not specfic to the debouncer.  Add a "hte specific
> >>>>> fields" section if nothing else is suitable.
> >>>>>
> >>>>>>  /**
> >>>>>> @@ -518,6 +524,7 @@ struct linereq {
> >>>>>>  	 GPIO_V2_LINE_DRIVE_FLAGS | \
> >>>>>>  	 GPIO_V2_LINE_EDGE_FLAGS | \
> >>>>>>  	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME | \
> >>>>>> +	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE | \
> >>>>>>  	 GPIO_V2_LINE_BIAS_FLAGS)
> >>>>>>  
> >>>>>>  static void linereq_put_event(struct linereq *lr,
> >>>>>> @@ -546,6 +553,94 @@ static u64 line_event_timestamp(struct line *line)
> >>>>>>  	return ktime_get_ns();
> >>>>>>  }
> >>>>>>  
> >>>>>> +static hte_return_t process_hw_ts_thread(void *p)
> >>>>>> +{
> >>>>>> +	struct line *line = p;
> >>>>>> +	struct linereq *lr = line->req;
> >>>>>> +	struct gpio_v2_line_event le;
> >>>>>> +	u64 eflags;
> >>>>>> +
> >>>>>> +	memset(&le, 0, sizeof(le));
> >>>>>> +
> >>>>>> +	le.timestamp_ns = line->timestamp_ns;
> >>>>>> +	line->timestamp_ns = 0;
> >>>>>> +
> >>>>> What is the purpose of this zeroing?
> >>>>>
> >>>>>> +	if (line->dir >= HTE_DIR_NOSUPP) {
> >>>>>> +		eflags = READ_ONCE(line->eflags);
> >>>>>> +		if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
> >>>>>> +			int level = gpiod_get_value_cansleep(line->desc);
> >>>>>> +
> >>>>>> +			if (level)
> >>>>>> +				/* Emit low-to-high event */
> >>>>>> +				le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>>>> +			else
> >>>>>> +				/* Emit high-to-low event */
> >>>>>> +				le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
> >>>>>> +			/* Emit low-to-high event */
> >>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
> >>>>>> +			/* Emit high-to-low event */
> >>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>>> +		} else {
> >>>>>> +			return HTE_CB_ERROR;
> >>>>>> +		}
> >>>>>> +	} else {
> >>>>>> +		if (line->dir == HTE_RISING_EDGE_TS)
> >>>>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>>>> +		else
> >>>>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>>> +	}
> >>>>> The mapping from line->dir to le.id needs to take into account the active
> >>>>> low setting for the line.
> >>>>>
> >>>>> And it might be simpler if the hte_ts_data provided the level, equivalent
> >>>>> to gpiod_get_raw_value_cansleep(), rather than an edge direction, so you
> >>>>> can provide a common helper to determine the edge given the raw level.
> >>>> (So from the level determine the edge?) that sound right specially when
> >>>>
> >>>> HTE provider has capability to record the edge in that case why bother
> >>>>
> >>>> getting the level and determine edge?
> >>>>
> >>>> Calculating the edge from the level makes sense when hte provider does not
> >>>>
> >>>> have that feature and that is what if (line->dir >= HTE_DIR_NOSUPP) does.
> >>>>
> >>> As asked in the review of patch 02, do you have an example of hardware that
> >>> reports an edge direction rather than NOSUPP?
> >> No...
> > So you are adding an interface that nothing will currently use.
> > Are there plans for hardware that will report the edge, and you are
> > laying the groundwork here?
> 
> Adding here for the general case should there be provider
> 
> available with such feature.
> 

Then you are adding dead code, and you should remove that aspect of your
interface until you have hardware that does support it.

Cheers,
Kent.
