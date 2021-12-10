Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1883D4701A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbhLJNeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:34:01 -0500
Received: from foss.arm.com ([217.140.110.172]:42024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241830AbhLJNd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:33:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3B5B2B;
        Fri, 10 Dec 2021 05:30:23 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 154F33F5A1;
        Fri, 10 Dec 2021 05:30:21 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:30:19 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        jonathan.cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, Souvik.Chakravarty@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v7 16/16] clk: scmi: Support atomic clock enable/disable
 API
Message-ID: <20211210133019.GA6207@e120937-lin>
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-17-cristian.marussi@arm.com>
 <CAKfTPtCDostniAStK2zNnFa+dtd1mHJ8zywyGXX9HZYf4u6z+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCDostniAStK2zNnFa+dtd1mHJ8zywyGXX9HZYf4u6z+w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:52:39AM +0100, Vincent Guittot wrote:
> Hi Cristian,
> 

Hi Vincent,

thanks for the feedback, my replies below.

> On Mon, 29 Nov 2021 at 20:13, Cristian Marussi <cristian.marussi@arm.com> wrote:
> >
> > Support also atomic enable/disable clk_ops beside the bare non-atomic one
> > (prepare/unprepare) when the underlying SCMI transport is configured to
> > support atomic transactions for synchronous commands.
> >
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > V5 --> V6
> > - add concurrent availability of atomic and non atomic reqs
> > ---
> >  drivers/clk/clk-scmi.c | 56 +++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 47 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> > index 1e357d364ca2..50033d873dde 100644
> > --- a/drivers/clk/clk-scmi.c
> > +++ b/drivers/clk/clk-scmi.c
> > @@ -88,21 +88,53 @@ static void scmi_clk_disable(struct clk_hw *hw)
> >         scmi_proto_clk_ops->disable(clk->ph, clk->id);
> >  }
> >
> > +static int scmi_clk_atomic_enable(struct clk_hw *hw)
> > +{
> > +       struct scmi_clk *clk = to_scmi_clk(hw);
> > +
> > +       return scmi_proto_clk_ops->enable_atomic(clk->ph, clk->id);
> > +}
> > +
> > +static void scmi_clk_atomic_disable(struct clk_hw *hw)
> > +{
> > +       struct scmi_clk *clk = to_scmi_clk(hw);
> > +
> > +       scmi_proto_clk_ops->disable_atomic(clk->ph, clk->id);
> > +}
> > +
> > +/*
> > + * We can provide enable/disable atomic callbacks only if the underlying SCMI
> > + * transport for an SCMI instance is configured to handle SCMI commands in an
> > + * atomic manner.
> > + *
> > + * When no SCMI atomic transport support is available we instead provide only
> > + * the prepare/unprepare API, as allowed by the clock framework when atomic
> > + * calls are not available.
> > + *
> > + * Two distinct sets of clk_ops are provided since we could have multiple SCMI
> > + * instances with different underlying transport quality, so they cannot be
> > + * shared.
> > + */
> >  static const struct clk_ops scmi_clk_ops = {
> >         .recalc_rate = scmi_clk_recalc_rate,
> >         .round_rate = scmi_clk_round_rate,
> >         .set_rate = scmi_clk_set_rate,
> > -       /*
> > -        * We can't provide enable/disable callback as we can't perform the same
> > -        * in atomic context. Since the clock framework provides standard API
> > -        * clk_prepare_enable that helps cases using clk_enable in non-atomic
> > -        * context, it should be fine providing prepare/unprepare.
> > -        */
> >         .prepare = scmi_clk_enable,
> >         .unprepare = scmi_clk_disable,
> >  };
> >
> > -static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
> > +static const struct clk_ops scmi_atomic_clk_ops = {
> > +       .recalc_rate = scmi_clk_recalc_rate,
> > +       .round_rate = scmi_clk_round_rate,
> > +       .set_rate = scmi_clk_set_rate,
> > +       .prepare = scmi_clk_enable,
> > +       .unprepare = scmi_clk_disable,
> > +       .enable = scmi_clk_atomic_enable,
> 
> For  each clock, we have to start with  clk_prepare and then clk_enable
> this means that for scmi clk we will do
> scmi_clk_enable
> then
> scmi_clk_atomic_enable
> 
> scmi_clk_enable and scmi_clk_atomic_enable ends up doing the same
> thing: scmi_clock_config_set but the atomic version doesn't sleep
> 
> So you will set enable twice the clock.
> 
> This is confirmed when testing your series with virtio scmi backend as
> I can see to consecutive scmi clk set enable request for the same
> clock
> 

Yes, I saw that double enable while testing with CLK debugfs entry BUT I
thought that was due to the design of the debugfs entries (that calls
prepare_enable and so prepare and enable in sequence) also becauase, a few
versions ago, this series WAS indeed providing (beside bugs :P) the
sleeping prepare XOR the atomic enable depending on the SCMI atomic support
state (as you are suggesting now), BUT, after a few offline chats with you,
my (probably faulty) understanding was that some partners, even on a system
supporting atomic SCMI transfers, would have liked to be able to call the
atomic .enable selectively only on some (tipically quickly to setup) clocks
while keep calling the sleeping .prepare on some other (slower ones to
settle). (while keeping all the other slower clk_rate setup ops non-atomic)

So in v6/v7 I changed the API to provide both sleepable and atomic clk APIs
when the underlying SCMI stack support atomic mode: this way, though, it is
clearly up to the caller to decide what to do and if, generally, the
clock framework just calls everytime both, it will result in a double
enable.

Was my understanding of the reqs about being able to selectively choose
the sleep_vs_atomic mode in this way wrong ?

> In case of atomic mode, the clk_prepare should  be a nop
> 

I can certainly revert to use the old exclusive approach, not providing
a .prepare when atomic is supported, but then all clock enable ops on any
clock defined on the system will be operated atomically withot any choice
when atomic SCMI transactions are available.

Ideally, we could like, on a SCMI system supporting atomic, to be able to
'tag' a specific clock something like 'prefer-non-atomic' and so selectively
'noppify' the .prepare or the .enable at the SCMI clk-driver level depending
on such tag, but I cannot see any way to expose this from the CLK framework
API or DT, nor it seems suitable for a per-clock DT config option AND it
would break the current logic of clk_is_enabled_when_prepared().

Indeed clk_is_enabled_when_prepared() logic is ALREADY broken also by this V7
since when providing also .enable/.disable on atomic transports, the core CLK
framework would return clk_is_enabled_when_prepared() --> False which does
NOT fit reality since our SCMI prepare/unprepare DO enable/disable clks even
if .disable/.enable are provided too.

Probably this last observation on clk_is_enabled_when_prepared() is enough
to revert to the exclusive atomic/non-atomic approach and just ignore the
customer wish to be able to selectively choose which clock to operate in
atomic mode.

Any thoughs before a V8 ?

Thanks,
Cristian
 
