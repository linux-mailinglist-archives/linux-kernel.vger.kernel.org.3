Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4484465B72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354957AbhLBA5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbhLBA5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:57:19 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52306C061574;
        Wed,  1 Dec 2021 16:53:58 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f125so12102564pgc.0;
        Wed, 01 Dec 2021 16:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5MPLJUPFnjkdsMjufuYjZTNM1kkkwdwdThI7+r/x9G4=;
        b=LeDD51BSiR6MGX4t41PfwO5l0Jnp/rLUXZihN1CqrsqCjeUN+vcrtsbUW4ELBOLQPF
         6oS5C7FMHns3qFkPMZfHRCuOAoLXniliVjMnOQZmKS+qbiD4mWuYOjahdpBwQz7UWxDM
         gklgSBZ7q/q+o7biE447A+lTCUi5l4Gb+2bDK8lOeZEGOPrtwuibPWOJCE/i4ZSBYrwU
         OAeN/nT7TpvYa9yPHrTGTW+DZek6vfMEAxv2b8QGhamODIQ2wg8p7YZnoecNFe4vJvDl
         nc9kbybrVs4HfL6ve8E3juj4z3d2iUPbzHS1Q2deUoNhgvKcWDBvNCTAORs217cbLeve
         +Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5MPLJUPFnjkdsMjufuYjZTNM1kkkwdwdThI7+r/x9G4=;
        b=AlqJDdI+REBdr8UEIJTax5VW4MeNLBtJDlJjs8CqaJtxKSZ2gey06ukP1fMYJkbtUe
         Aqae6KvOmbNDziRTUzy2LVGDUfAb6rA+HfV0hK5IpIz6dnbwNFD8CemfQh/jUJRs7Ayh
         fQebwD3Yi5Cb7v76yryavKX+4eJj3xSkwu/sM+VHGJKzSD2rpxyGk6ih6I+4GcRFIDy3
         8CfSkAD2v2jeGS09n8VwL+0poWwo3q1jnCJ+ffIQR0if3vJ4JlcaeA95NP/LGGdIIiXP
         6A301vxRgIzMHG+5NTO2yiG1xawkVKqU1q3zEmY1B73je3JDybHjLg/h7dY14TKc4R7x
         otlQ==
X-Gm-Message-State: AOAM531cgQrFFMnKb2eTXmv2UPN7ouGhvqc2vUhKCKUH5zn1izFSepF/
        sr3hpoq9N9qT62rxPrguFoMAwzq4m6httA==
X-Google-Smtp-Source: ABdhPJwA6Qybwh2N4a02EDBWO46Fj7gEGUATxZDg6hdPrnTODfzGUqTmIYn4tr9t6JTumssaE6o8og==
X-Received: by 2002:a63:8c1b:: with SMTP id m27mr468646pgd.399.1638406437261;
        Wed, 01 Dec 2021 16:53:57 -0800 (PST)
Received: from sol (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id j127sm1040713pfg.14.2021.12.01.16.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:53:56 -0800 (PST)
Date:   Thu, 2 Dec 2021 08:53:49 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [RFC v3 09/12] gpiolib: cdev: Add hardware timestamp clock type
Message-ID: <20211202005349.GA7007@sol>
References: <20211123193039.25154-1-dipenp@nvidia.com>
 <20211123193039.25154-10-dipenp@nvidia.com>
 <20211126013137.GC10380@sol>
 <9ad666ec-eedd-8075-73e6-1e47a1eb228b@nvidia.com>
 <20211201171638.GA31045@sol>
 <4c7c3db1-a1b3-1944-4278-cb37e8a4f373@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c7c3db1-a1b3-1944-4278-cb37e8a4f373@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:01:46AM -0800, Dipen Patel wrote:
> Hi,
> 
> 
> On 12/1/21 9:16 AM, Kent Gibson wrote:
> > On Tue, Nov 30, 2021 at 07:29:20PM -0800, Dipen Patel wrote:
> >> Hi,
> >>
> >> On 11/25/21 5:31 PM, Kent Gibson wrote:
> >>> On Tue, Nov 23, 2021 at 11:30:36AM -0800, Dipen Patel wrote:
> >>>> This patch adds new clock type for the GPIO controller which can
> >>>> timestamp gpio lines in realtime using hardware means. To expose such
> >>>> functionalities to the userspace, code has been added in this patch
> >>>> where during line create call, it checks for new clock type and if
> >>>> requested, calls hardware timestamp related API from gpiolib.c.
> >>>> During line change event, the HTE subsystem pushes timestamp data
> >>>> through callbacks.
> >>>>
> >>>> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> >>>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Added hte_dir and static structure hte_ts_desc.
> >>>> - Added callbacks which get invoked by HTE when new data is available.
> >>>> - Better use of hte_dir and seq from hte_ts_desc.
> >>>> - Modified sw debounce function to accommodate hardware timestamping.
> >>>>
> >>>>  drivers/gpio/gpiolib-cdev.c | 161 ++++++++++++++++++++++++++++++++++--
> >>>>  include/uapi/linux/gpio.h   |   1 +
> >>>>  2 files changed, 153 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> >>>> index c7b5446d01fd..1736ad54e3ec 100644
> >>>> --- a/drivers/gpio/gpiolib-cdev.c
> >>>> +++ b/drivers/gpio/gpiolib-cdev.c
> >>>> @@ -464,6 +464,12 @@ struct line {
> >>>>  	 * stale value.
> >>>>  	 */
> >>>>  	unsigned int level;
> >>>> +	/*
> >>>> +	 * dir will be touched in HTE callbacks hte_ts_cb_t and
> >>>> +	 * hte_ts_threaded_cb_t and they are mutually exclusive. This will be
> >>>> +	 * unused when HTE is not supported/disabled.
> >>>> +	 */
> >>>> +	enum hte_dir dir;
> >>>>  };
> >>>>  
> >>> Documentation should be in present tense, so 
> >>>
> >>> s/will be/is/g
> >>>
> >>> Same applies to other patches.
> >>>
> >>> Also
> >>>
> >>> s/touched/accessed/
> >>>
> >>> dir is a poor name for the field.  It is the hte edge direction and
> >>> effectively the line level, so call it hte_edge_dirn or
> >>> hte_edge_direction or hte_level.
> >>>
> >>> And it is placed in a section of the struct documented as "debouncer specific
> >>> fields", but it is not specfic to the debouncer.  Add a "hte specific
> >>> fields" section if nothing else is suitable.
> >>>
> >>>>  /**
> >>>> @@ -518,6 +524,7 @@ struct linereq {
> >>>>  	 GPIO_V2_LINE_DRIVE_FLAGS | \
> >>>>  	 GPIO_V2_LINE_EDGE_FLAGS | \
> >>>>  	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME | \
> >>>> +	 GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE | \
> >>>>  	 GPIO_V2_LINE_BIAS_FLAGS)
> >>>>  
> >>>>  static void linereq_put_event(struct linereq *lr,
> >>>> @@ -546,6 +553,94 @@ static u64 line_event_timestamp(struct line *line)
> >>>>  	return ktime_get_ns();
> >>>>  }
> >>>>  
> >>>> +static hte_return_t process_hw_ts_thread(void *p)
> >>>> +{
> >>>> +	struct line *line = p;
> >>>> +	struct linereq *lr = line->req;
> >>>> +	struct gpio_v2_line_event le;
> >>>> +	u64 eflags;
> >>>> +
> >>>> +	memset(&le, 0, sizeof(le));
> >>>> +
> >>>> +	le.timestamp_ns = line->timestamp_ns;
> >>>> +	line->timestamp_ns = 0;
> >>>> +
> >>> What is the purpose of this zeroing?
> >>>
> >>>> +	if (line->dir >= HTE_DIR_NOSUPP) {
> >>>> +		eflags = READ_ONCE(line->eflags);
> >>>> +		if (eflags == GPIO_V2_LINE_FLAG_EDGE_BOTH) {
> >>>> +			int level = gpiod_get_value_cansleep(line->desc);
> >>>> +
> >>>> +			if (level)
> >>>> +				/* Emit low-to-high event */
> >>>> +				le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>> +			else
> >>>> +				/* Emit high-to-low event */
> >>>> +				le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_RISING) {
> >>>> +			/* Emit low-to-high event */
> >>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>> +		} else if (eflags == GPIO_V2_LINE_FLAG_EDGE_FALLING) {
> >>>> +			/* Emit high-to-low event */
> >>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>> +		} else {
> >>>> +			return HTE_CB_ERROR;
> >>>> +		}
> >>>> +	} else {
> >>>> +		if (line->dir == HTE_RISING_EDGE_TS)
> >>>> +			le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>> +		else
> >>>> +			le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>> +	}
> >>> The mapping from line->dir to le.id needs to take into account the active
> >>> low setting for the line.
> >>>
> >>> And it might be simpler if the hte_ts_data provided the level, equivalent
> >>> to gpiod_get_raw_value_cansleep(), rather than an edge direction, so you
> >>> can provide a common helper to determine the edge given the raw level.
> >> (So from the level determine the edge?) that sound right specially when
> >>
> >> HTE provider has capability to record the edge in that case why bother
> >>
> >> getting the level and determine edge?
> >>
> >> Calculating the edge from the level makes sense when hte provider does not
> >>
> >> have that feature and that is what if (line->dir >= HTE_DIR_NOSUPP) does.
> >>
> > As asked in the review of patch 02, do you have an example of hardware that
> > reports an edge direction rather than NOSUPP?
> No...

So you are adding an interface that nothing will currently use.
Are there plans for hardware that will report the edge, and you are
laying the groundwork here?

> >
> > Anyway, this is just a naming thing - the information content being passed
> > is the the same, be it high/low/unknown or rising/falling/unknown.
> >
> > If the hardware does report edge direction then it is just one bit, and
> > that also corresponds to the physical level immediately following the
> > edge, so no additional conversion required there.
> >
> > It would be clearer to pass a level than an edge, as
> >  - a hte edge (hte_dir) could be confused with a cdev edge
> >    (gpio_v2_line_event_id), in mails like this if not in the code.
> >  - cdev will fallback to using the physical level to determine the edge
> >    if the hte can't provide it
> I believe I have retained all the fallback logic in such case.
> >  - cdev has to perform inversion if active low and it already does that
> >    based on levels
> >
> >>>> +
> >>>> +	le.line_seqno = line->line_seqno;
> >>>> +	le.seqno = (lr->num_lines == 1) ? le.line_seqno : line->req_seqno;
> >>>> +	le.offset = gpio_chip_hwgpio(line->desc);
> >>>> +
> >>>> +	linereq_put_event(lr, &le);
> >>>> +
> >>>> +	return HTE_CB_HANDLED;
> >>>> +}
> >>>> +
> >>>> +static hte_return_t process_hw_ts(struct hte_ts_data *ts, void *p)
> >>>> +{
> >>>> +	struct line *line = p;
> >>>> +	struct linereq *lr = line->req;
> >>>> +
> >>>> +	if (!ts)
> >>>> +		return HTE_CB_ERROR;
> >>>> +
> >>>> +	line->timestamp_ns = ts->tsc;
> >>>> +	line->dir = ts->dir;
> >>>> +
> >>> The doc for timestamp_ns states:
> >>>
> >>> 	 * timestamp_ns and req_seqno are accessed only by
> >>> 	 * edge_irq_handler() and edge_irq_thread(), which are themselves
> >>> 	 * mutually exclusive, so no additional protection is necessary.
> >>>
> >>> That no longer holds.  It is now also accessed here, and in
> >>> process_hw_ts_thread(), which wont run concurrently with each other or
> >>> the edge_irq_* handlers, but also in debounce_work_func() which may run
> >>> concurrently with the others.
> >>> So timestamp_ns now requires protection from concurrent access.
> >>>
> >>>> +	/*
> >>>> +	 * It is possible that HTE engine detects spurious edges for the
> >>>> +	 * lines where software debounce is enabled. This primary callback
> >>>> +	 * will be called multiple times in that case. It will be better to
> >>>> +	 * let debounce_work_func handle instead of process_hw_ts_thread.
> >>>> +	 * The timestamp_ns will be overwritten here which is fine as we are
> >>>> +	 * interested in the last value anyway. The debounce_work_func will
> >>>> +	 * then just read whatever last line->timestamp_ns is stored. Because
> >>>> +	 * this callback can be called multiple times, we are not really
> >>>> +	 * interested in ts->seq.
> >>>> +	 */
> >>> Not sure what this is trying to say.
> >>> Is this the primary callback? Or debounce_irq_handler()?
> >> This is primary callback called from HTE when it pushes new TS data per line, it
> >>
> >> also says so in the second line.
> >>
> > Yeah, I probably read that as "The primary callback", but it is
> > confusing anyway. "This primary callback" implies there is another
> > primary callback. 
> > Just say "This handler" instead of "This primary callback".
> Noted...
> >
> >>> You say you really aren't interested in ts->seq, but the code immediately
> >>> uses it.
> >> That is when sw_debounced is not set and whole paragraph is about when
> >>
> >> sw_debounced is set.
> >>
> > So your whole comment here is about the else case?
> > Then either put the comment where the else would be, or better yet invert
> > the logic and return immediately if sw_debounced.
> Sure...

Understand, you wont be maintaining this code, even if you intend to.
Consider the poor unfortunate who will have to deal with your code in
the future.  This is not and should not be a minor consideration.

Sometimes long winded comments only add confusion rather than clarity.
If the code alone is confusing and requires more than a line or two of
explanatory comments, excluding function documentation, then you might
want to rethink your code.

In this case the clearest is probably to restructure the if condition as
I suggested and simplify or even drop the comment.

> >
> >>> Reword to clarify.
> >>> And add braces after function names to highlight them, so
> >>> debounce_work_func().
> >> Will do.
> >>>> +	if (!READ_ONCE(line->sw_debounced)) {
> >>>> +		line->line_seqno = ts->seq;
> >>>> +
> >>>> +		/*
> >>>> +		 * Increment in this callback incase all the lines in linereq
> >>>> +		 * are enabled for hw timestamping. This will work even if
> >>>> +		 * subset of lines are enabled for hw timestamping as
> >>>> +		 * edge_irq_* callbacks will proceed as usual for them.
> >>>> +		 */
> >>> s/incase/in case/
> >>>
> >>> Not sure what the comment is trying to say. There is no check here that
> >>> the other lines have HTE enabled.  And that is not relevant anyway.
> >>> The edge_irq_* handlers will proceed as usual for those lines NOT
> >>> enabled for hw timestamping.
> >>>
> >>> To clarify, the line_seqno indicates where this event lies in the
> >>> sequence of events for the line.
> >>> The request seqno indicates where this event lines in the sequence of
> >>> events for the request.
> >>> For a single line request these are the same, hence the minor
> >>> optimisation of not updating lr->seqno below.
> >>>
> >>>> +		if (lr->num_lines != 1)
> >>>> +			line->req_seqno = atomic_inc_return(&lr->seqno);
> >>>> +
> >>> The req_seqno should be updated corresponding to the change in the
> >>> line_reqno.  That always used to be 1, but no longer if hte can discard
> >>> events, i.e. skip over line_seqnos.
> >> HTE does not discard any events, it pushes to clients as soon as its
> >>
> >> available through primary callback.
> > The discarding of events that I am referring to is from your previous
> > answers that indicated, to me anyway, that there could be gaps in the
> > ts->seq numbers if the hardware event FIFO overflowed.
> > Is that not the case?
> 
> Not in this patch series as the provider I have dealt with does not such
> 
> feature. ts->seq is software counter in that case.
> 

The code here has to deal with the general case, not just the one example
driver you have provided.  So in general there COULD be gaps in the
ts->seq, right?

I do see that using the ts-seq for sw debounced lines is problematic
though. The debouncer itself will be discarding hte events, but that
shouldn't be considered a lost event to the user.  You could track
how many events are discarded by the debouncer and subtract those from
the sequence numbers reported to userspace?

> >
> > And when you say "primary callback", both here and elsewhere, you mean the
> > cb parameter to gpiod_req_hw_timestamp_ns() and gc->req_hw_timestamp()?
> yes, cb is primary and tcb (threaded cb) is optional secondary.
> > Either way, be specific and name the function or parameter, or find a
> > better term than "primary callback".
> > In this case "the client's event handler" would be much clearer.
> Noted...
> >
> >>> To be consistent, i.e. if events were lost for this line then they were
> >>> also lost for the requested lines, the lr->seqno should be incremented by
> >>> the change in line_seqno.  Probably with some sanity checks.
> >>>
> >>>> +		return HTE_RUN_THREADED_CB;
> >>>> +	}
> >>>> +
> >>>> +	return HTE_CB_HANDLED;
> >>>> +}
> >>>> +
> >>>>  static irqreturn_t edge_irq_thread(int irq, void *p)
> >>>>  {
> >>>>  	struct line *line = p;
> >>>> @@ -553,6 +648,10 @@ static irqreturn_t edge_irq_thread(int irq, void *p)
> >>>>  	struct gpio_v2_line_event le;
> >>>>  	u64 eflags;
> >>>>  
> >>>> +	/* Let process_hw_ts_thread handle */
> >>>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags))
> >>>> +		return IRQ_HANDLED;
> >>>> +
> >>> This adds pointless runtime overhead, and for everyone not just hte users.
> >>> Don't stub out a handler in the handler - stub it out where it is
> >>> registered by registering a stub handler.  Or don't request it at all.
> >>>
> >>> So why would gpiolib-cdev be requesting the irq, only to stub out
> >>> the handlers?
> >>> If that has a side-effect that hte requires then hte should be taking
> >>> care of it - it is not gpiolib-cdev's problem.
> >> - Why stop at moving irq and debounce related stuff to hte then?
> >>
> > How about you answer my question before asking your own?
> > Here I am only questioning why gpiolib-cdev is requesting an interrupt
> > for a hte line at all.  It has no reason to, so hte must have?
> 
> Commented below in "separation of concern" paragraph.
> 
> > And where did I suggest moving the "debounce stuff" to hte?
> 
> Perhaps I misunderstood "That includes the sw debouncer - more on that
> 
> below." comment.
> 

The point I was trying to make there was that, for hte enabled lines, the
sw debouncer should be driven by hte events, not irq events.
That does not imply nor require moving the debouncer to hte.

> >
> > What I am suggesting is called separation of concerns.  In this context
> > the intent is to look towards abstracting the edge event generation.
> > Having hte and irq entangled for no apparent reason makes doing that more
> 
> But in this patch series (i.e. HTE provider), they are entangled as hte provider
> 
> will only ts the GPIO line which is configured as input irq. That is why I have
> 
> separated GPIO line config part and TS part. In other words, let cdev handle
> 
> any line config that userspace has asked and let hte handle ts part if the
> 
> line config is supported (If line config is not suitable, it will not enable hte, see
> 
> gpio-tegra186.c function tegra186_gpio_req_hw_ts() in this patch series where
> 
> check happens for the tegra hte provider).
> 

Can you explain "hte provider will only ts the GPIO line which is
configured as input irq"?  That sounds like a hte concern to me, or even
worse a particular hte provider problem.

The user requests a line with edge event detection enabled and with hte
timestamps.
Nothing in that requires irq from gpiolib-cdev.
gpiolib-cdev should use hte as the event source where it would usually
use irq. If hte requires irq to allow it to generate those events then
hte should be responsible for requesting the irq.
In a hypothetical extreme case where gpiolib-cdev only supported hte
lines there should be no reference to irq in gpiolib-cdev.
Yet you continue to insist that gpiolib-cdev should request the irq for
hte.
What am I missing here?

> > difficult than it needs to be, whereas keeping them separate greatly
> > simplifies identification of common code suitable for refactoring
> > subsequently.
> >
> > Not sure what to call what you are suggesting.
> >
> >> I mean if there is hte provider which can TS GPIO output/input
> >>
> >> does it mean hte is responsible for parsing the GPIO line configs, setting them up
> >>
> >> (i.e. input or output) as well? Are we not duplicating logic instead of
> >>
> >> leveraging gpio-cdev? Does it make sense for the HTE subsystem which not
> >>
> >> only TS the GPIOs but other SoC lines?
> >>
> >> - What happens to in kernel GPIO HTE client (for example, hte-tegra194-gpio-test.c)?
> >>
> >> some clients do more in their IRQ handler than what edge_irq_handler does in which
> >>
> >> case it would make sense to have them request irq in their code than through HTE.
> >>
> >>> And speaking as to how the whole hte/gpiolib-cdev interface should work,
> >>> hte should be an edge event generator alternative to irq.  So lines with
> >>> hte enabled should work without any irq calls from gpiolib-cdev.
> >>> That includes the sw debouncer - more on that below.
> >>>
> >>>>  	/* Do not leak kernel stack to userspace */
> >>>>  	memset(&le, 0, sizeof(le));
> >>>>  
> >>>> @@ -604,6 +703,10 @@ static irqreturn_t edge_irq_handler(int irq, void *p)
> >>>>  	struct line *line = p;
> >>>>  	struct linereq *lr = line->req;
> >>>>  
> >>>> +	/* Let HTE supplied callbacks handle */
> >>>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags))
> >>>> +		return IRQ_HANDLED;
> >>>> +
> >>>>  	/*
> >>>>  	 * Just store the timestamp in hardirq context so we get it as
> >>>>  	 * close in time as possible to the actual event.
> >>>> @@ -682,14 +785,6 @@ static void debounce_work_func(struct work_struct *work)
> >>>>  	/* Do not leak kernel stack to userspace */
> >>>>  	memset(&le, 0, sizeof(le));
> >>>>  
> >>>> -	lr = line->req;
> >>>> -	le.timestamp_ns = line_event_timestamp(line);
> >>>> -	le.offset = gpio_chip_hwgpio(line->desc);
> >>>> -	line->line_seqno++;
> >>>> -	le.line_seqno = line->line_seqno;
> >>>> -	le.seqno = (lr->num_lines == 1) ?
> >>>> -		le.line_seqno : atomic_inc_return(&lr->seqno);
> >>>> -
> >>>>  	if (level)
> >>>>  		/* Emit low-to-high event */
> >>>>  		le.id = GPIO_V2_LINE_EVENT_RISING_EDGE;
> >>>> @@ -697,6 +792,23 @@ static void debounce_work_func(struct work_struct *work)
> >>>>  		/* Emit high-to-low event */
> >>>>  		le.id = GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>>  
> >>>> +	if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &line->desc->flags)) {
> >>>> +		le.timestamp_ns = line->timestamp_ns;
> >>>> +		if (line->dir < HTE_DIR_NOSUPP)
> >>>> +			le.id = (line->dir == HTE_RISING_EDGE_TS) ?
> >>>> +				 GPIO_V2_LINE_EVENT_RISING_EDGE :
> >>>> +				 GPIO_V2_LINE_EVENT_FALLING_EDGE;
> >>>> +	} else {
> >>>> +		le.timestamp_ns = line_event_timestamp(line);
> >>>> +	}
> >>>> +
> >>> Move the FLAG_EVENT_CLOCK_HARDWARE check into line_event_timestamp().
> >>>
> >>> And the id fudging is necessary because the level returned by
> >>> gpiod_get_raw_value_cansleep() can disagree with the level from hte?
> >>> So you are still trying to synchronise events from two streams.
> >>> And that is still broken.
> >>> If a hte event occurs between the level being sampled by
> >>> gpiod_get_raw_value_cansleep() and the line->dir being read then the line
> >>> will have toggled and you will be reporting the opposite state than the
> >>> one the debouncer determined was stable.  And maybe the wrong timestamp as
> >>> well.
> >>>
> >>> For lines where hte is enabled, the hte should be the source of level for
> >>> the debouncer, not the raw value.  And the mod_delayed_work() that
> >>> drives the debouncer should be called by a hte handler, not an irq handler.
> >>>
> >>> There is also a race on reading the hte timestamp (line->timestamp_ns) and
> >>> the hte level (line->dir), such that you can get the level from one event
> >>> the timestamp from another.
> >>>
> >>>> +	lr = line->req;
> >>>> +	le.offset = gpio_chip_hwgpio(line->desc);
> >>>> +	line->line_seqno++;
> >>>> +	le.line_seqno = line->line_seqno;
> >>>> +	le.seqno = (lr->num_lines == 1) ?
> >>>> +		le.line_seqno : atomic_inc_return(&lr->seqno);
> >>>> +
> >>> What is the purpose of moving this block of code moved from before the
> >>> if (level)?
> >>>
> >>>
> >>>>  	linereq_put_event(lr, &le);
> >>>>  }
> >>>>  
> >>>> @@ -891,7 +1003,6 @@ static int gpio_v2_line_flags_validate(u64 flags)
> >>>>  	/* Return an error if an unknown flag is set */
> >>>>  	if (flags & ~GPIO_V2_LINE_VALID_FLAGS)
> >>>>  		return -EINVAL;
> >>>> -
> >>> Gratuitous whitespace change.
> >>>
> >>>>  	/*
> >>>>  	 * Do not allow both INPUT and OUTPUT flags to be set as they are
> >>>>  	 * contradictory.
> >>>> @@ -900,6 +1011,11 @@ static int gpio_v2_line_flags_validate(u64 flags)
> >>>>  	    (flags & GPIO_V2_LINE_FLAG_OUTPUT))
> >>>>  		return -EINVAL;
> >>>>  
> >>>> +	/* Only allow one event clock source */
> >>>> +	if ((flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME) &&
> >>>> +	    (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE))
> >>>> +		return -EINVAL;
> >>>> +
> >>>>  	/* Edge detection requires explicit input. */
> >>>>  	if ((flags & GPIO_V2_LINE_EDGE_FLAGS) &&
> >>>>  	    !(flags & GPIO_V2_LINE_FLAG_INPUT))
> >>>> @@ -992,6 +1108,8 @@ static void gpio_v2_line_config_flags_to_desc_flags(u64 flags,
> >>>>  
> >>>>  	assign_bit(FLAG_EVENT_CLOCK_REALTIME, flagsp,
> >>>>  		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME);
> >>>> +	assign_bit(FLAG_EVENT_CLOCK_HARDWARE, flagsp,
> >>>> +		   flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE);
> >>>>  }
> >>>>  
> >>>>  static long linereq_get_values(struct linereq *lr, void __user *ip)
> >>>> @@ -1154,6 +1272,21 @@ static long linereq_set_config_unlocked(struct linereq *lr,
> >>>>  				return ret;
> >>>>  		}
> >>>>  
> >>>> +		/* Check if new config sets hardware assisted clock */
> >>>> +		if (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE) {
> >>>> +			ret = gpiod_req_hw_timestamp_ns(desc, process_hw_ts,
> >>>> +							process_hw_ts_thread,
> >>>> +							&lr->lines[i]);
> >>>> +			if (ret)
> >>>> +				return ret;
> >>> Note that the line config is the complete line config, not a delta.
> >>>
> >>> What happens when a line that already has hte enabled is reconfigured
> >>> and still has hte enabled?  i.e. what happens when
> >>> gpiod_req_hw_timestamp_ns() is called for the second time?
> >> HTE will return without doing anything with error code.
> >>
> > But this is not an error case, it is a normal reconfigure of an
> > attribute other than the hte flag.
> 
> I assumed when this function is called it will "reset" and not  update the configs.
> 
> If this assumption is wrong, I will correct the logic here.
> 

The set_config does whatever is required to change the line request
config from the old to the new.  Both old and new are complete snapshots
of the line request config.

The change should be seamless except for the attributes being changed.
We certainly do not reset the config and start from scratch - that would
be little better than the user releasing and re-requesting the lines.

For many attributes we can just apply the new config.  But some cases,
such as a change to active low polarity, are a lot more involved.
And if hte considers re-requesting the line to be an error then you
should only make the hte request when the hte flag changes to set.

Cheers,
Kent.

> > And that will now return an error to userspace?
> >
> > Cheers,
> > Kent.
> >
> >>> You provide a comment for the release case below, what of the request
> >>> case?
> >>>
> >>> If you need to check for change then compare the old and new flags, as
> >>> the polarity_change check does (not visible in the diff here).
> >>>
> >>>> +		} else {
> >>>> +			/*
> >>>> +			 * HTE subsys will do nothing if there is nothing to
> >>>> +			 * release.
> >>>> +			 */
> >>>> +			gpiod_rel_hw_timestamp_ns(desc);
> >>>> +		}
> >>>> +
> >>> Comment will fit on one line.
> >>>
> >>> And it would be better to document that the function is idempotent in the
> >>> function documentation, not everywhere it is used.
> >>>
> >>>>  		blocking_notifier_call_chain(&desc->gdev->notifier,
> >>>>  					     GPIO_V2_LINE_CHANGED_CONFIG,
> >>>>  					     desc);
> >>>> @@ -1409,6 +1542,14 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
> >>>>  					flags & GPIO_V2_LINE_EDGE_FLAGS);
> >>>>  			if (ret)
> >>>>  				goto out_free_linereq;
> >>>> +
> >>>> +			if (flags & GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE) {
> >>>> +				ret = gpiod_req_hw_timestamp_ns(desc, process_hw_ts,
> >>>> +							process_hw_ts_thread,
> >>>> +							&lr->lines[i]);
> >>>> +				if (ret)
> >>>> +					goto out_free_linereq;
> >>>> +			}
> >>>>  		}
> >>>>  
> >>>>  		blocking_notifier_call_chain(&desc->gdev->notifier,
> >>>> @@ -1959,6 +2100,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
> >>>>  
> >>>>  	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
> >>>>  		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
> >>>> +	else if (test_bit(FLAG_EVENT_CLOCK_HARDWARE, &desc->flags))
> >>>> +		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE;
> >>>>  
> >>>>  	debounce_period_us = READ_ONCE(desc->debounce_period_us);
> >>>>  	if (debounce_period_us) {
> >>>> diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
> >>>> index eaaea3d8e6b4..d360545b4c21 100644
> >>>> --- a/include/uapi/linux/gpio.h
> >>>> +++ b/include/uapi/linux/gpio.h
> >>>> @@ -80,6 +80,7 @@ enum gpio_v2_line_flag {
> >>>>  	GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN	= _BITULL(9),
> >>>>  	GPIO_V2_LINE_FLAG_BIAS_DISABLED		= _BITULL(10),
> >>>>  	GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME	= _BITULL(11),
> >>>> +	GPIO_V2_LINE_FLAG_EVENT_CLOCK_HARDWARE	= _BITULL(12),
> >>>>  };
> >>>>  
> >>> I'm now thinking this name, "HARDWARE" is too vague, in case other
> >>> timestamp source alternatives join the fray, and so should be "HTE".
> >>>
> >>> Cheers,
> >>> Kent.
