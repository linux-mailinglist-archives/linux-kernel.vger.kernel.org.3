Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD4508FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381580AbiDTSuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350681AbiDTSuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:50:18 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B843ED3;
        Wed, 20 Apr 2022 11:47:30 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id x39so4500201ybd.8;
        Wed, 20 Apr 2022 11:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dE5RadEMib60o9KVjQcUjy+eJ3gNL/iiBHhDxgP/GWk=;
        b=UxaxjNToC6cgTWoXK8cggvaMSsdJpm8iWmRfdHYXx7xKepb5wSz11y7JsI7k2/7ESB
         G+rzz13z1qp8gtvqkbo4pkfF8/+FzzhxsU0oBnH3vK1vym7ZznAuoyL8toQqRzrvzf5G
         QUxkQF36W9QDXyH5onmzRE8ehECNzjQKARyVSCo0dEcgLzqWOW565AYXYxFkyrn22v5P
         78ZWwKxi03N4pA0ixLE9QT6on0uV89PVxesBPfgpqRisQleY6GyUloQ8asWKtLX9Zjgd
         5SwDg6XBAG4cqc+yBp8W82SUEd/Zxsi5o+S1e+x+xJK4Plfg2bXBzIq7o+hPOM9/sl0y
         EZ+g==
X-Gm-Message-State: AOAM532e5pZ7uxCIFyEWtXtd391oWGng14heJAJi+5amK/v2rEi3Ntot
        jmtE3qop8KknrS4g9E1vbX6oCRCOnDNafxncMHM=
X-Google-Smtp-Source: ABdhPJy0l46FqKK3F6TPwNoLPQjTN9iZHgvIu9g3S+a+hhpuyVO+CbVALwAXm8q/rJbzWksFWeDjWWSShgdOVqSqVVo=
X-Received: by 2002:a05:6902:187:b0:63d:9c95:edca with SMTP id
 t7-20020a056902018700b0063d9c95edcamr20821310ybh.81.1650480449135; Wed, 20
 Apr 2022 11:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233832.391817-1-dmitry.osipenko@collabora.com>
 <20220411233832.391817-5-dmitry.osipenko@collabora.com> <CAJZ5v0gnTSoeNP+QXwrZ45FQY4howVkJMuCjM=j+_-2BngJdQg@mail.gmail.com>
 <990621e7-9f8a-8b4a-02ec-fd6c1e1f48ff@collabora.com>
In-Reply-To: <990621e7-9f8a-8b4a-02ec-fd6c1e1f48ff@collabora.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 Apr 2022 20:47:17 +0200
Message-ID: <CAJZ5v0jxXtwot0qpib4UG8Tz8Hd1dEbgo58tEdPFboU8xwKHNw@mail.gmail.com>
Subject: Re: [PATCH v7 04/20] kernel: Add combined power-off+restart handler
 call chain API
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 3:44 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 4/15/22 21:14, Rafael J. Wysocki wrote:
> > Honestly, I would prefer this to be split so as to make it easier to
> > review if nothing else.
>
> I'll try to split it in v8.
>
> > On Tue, Apr 12, 2022 at 1:39 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> SoC platforms often have multiple ways of how to perform system's
> >> power-off and restart operations. Meanwhile today's kernel is limited to
> >> a single option. Add combined power-off+restart handler call chain API,
> >> which is inspired by the restart API. The new API provides both power-off
> >> and restart functionality.
> >>
> >> The old pm_power_off method will be kept around till all users are
> >> converted to the new API.
> >>
> >> Current restart API will be replaced by the new unified API since
> >> new API is its superset. The restart functionality of the sys-off handler
> >> API is built upon the existing restart-notifier APIs.
> >
> > Which means that the existing notifier chains for system restart are
> > used as they are without modifications.
> >
> > At least that's what follows from the code and it would be good to
> > mention it here.
>
> Will improve the commit message.
>
> > Moreover, a new notifier chain is introduced for the power-off case
> > and it appears to be the counterpart of the restart_handler_list
> > chain, but then why is it blocking and not atomic like the latter?
>
> Good catch, it probably indeed should be atomic because shutting down
> could run with a disabled interrupts. I'll invistigate this more for v8,
> at least right now I don't recall any particular reason for using the
> blocking notifier.
>
> >> In order to ease conversion to the new API, convenient helpers are added
> >> for the common use-cases. They will reduce amount of boilerplate code and
> >> remove global variables. These helpers preserve old behaviour for cases
> >> where only one power-off handler is expected, this is what all existing
> >> drivers want, and thus, they could be easily converted to the new API.
> >> Users of the new API should explicitly enable power-off chaining by
> >> setting corresponding flag of the power_handler structure.
> >
> > "the corresponding"
>
> Thanks
>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>  include/linux/reboot.h   | 229 ++++++++++++++-
> >>  kernel/power/hibernate.c |   2 +-
> >>  kernel/reboot.c          | 604 ++++++++++++++++++++++++++++++++++++++-
> >>  3 files changed, 827 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> >> index a2429648d831..ba5e5dddcfcd 100644
> >> --- a/include/linux/reboot.h
> >> +++ b/include/linux/reboot.h
> >> @@ -8,10 +8,35 @@
> >>
> >>  struct device;
> >>
> >> -#define SYS_DOWN       0x0001  /* Notify of system down */
> >> -#define SYS_RESTART    SYS_DOWN
> >> -#define SYS_HALT       0x0002  /* Notify of system halt */
> >> -#define SYS_POWER_OFF  0x0003  /* Notify of system power off */
> >> +enum reboot_prepare_mode {
> >> +       SYS_DOWN = 1,           /* Notify of system down */
> >> +       SYS_RESTART = SYS_DOWN,
> >> +       SYS_HALT,               /* Notify of system halt */
> >> +       SYS_POWER_OFF,          /* Notify of system power off */
> >> +};
> >> +
> >> +/*
> >> + * Standard restart priority levels. Intended to be set in the
> >> + * sys_off_handler.restart_priority field.
> >> + *
> >> + * Use `RESTART_PRIO_ABC +- prio` style for additional levels.
> >> + *
> >> + * RESTART_PRIO_RESERVED:      Falls back to RESTART_PRIO_DEFAULT.
> >> + *                             Drivers may leave priority initialized
> >> + *                             to zero, to auto-set it to the default level.
> >
> > What is the "default level" here?
>
> "default level" = RESTART_PRIO_DEFAULT = 128
>
> I'll remove the second sentence about the "default level", for clarity.
>
> >> + *
> >> + * RESTART_PRIO_LOW:           Use this for handler of last resort.
> >> + *
> >> + * RESTART_PRIO_DEFAULT:       Use this for default/generic handler.
> >> + *
> >> + * RESTART_PRIO_HIGH:          Use this if you have multiple handlers and
> >> + *                             this handler has higher priority than the
> >> + *                             default handler.
> >> + */
> >> +#define RESTART_PRIO_RESERVED          0
> >> +#define RESTART_PRIO_LOW               8
> >> +#define RESTART_PRIO_DEFAULT           128
> >> +#define RESTART_PRIO_HIGH              192
> >>
> >>  enum reboot_mode {
> >>         REBOOT_UNDEFINED = -1,
> >> @@ -49,6 +74,201 @@ extern int register_restart_handler(struct notifier_block *);
> >>  extern int unregister_restart_handler(struct notifier_block *);
> >>  extern void do_kernel_restart(char *cmd);
> >>
> >> +/*
> >> + * System power-off and restart API.
> >> + */
> >> +
> >> +/*
> >> + * Standard power-off priority levels. Intended to be set in the
> >> + * sys_off_handler.power_off_priority field.
> >> + *
> >> + * Use `POWEROFF_PRIO_ABC +- prio` style for additional levels.
> >
> > What exactly does this mean?
>
> "POWEROFF_PRIO_DEFAULT+1 or POWEROFF_PRIO_DEFAULT-1" for example, I'll
> improve it in v8.

So the users of this interface are expected to set priorities relative
to the "standard" levels.  That wasn't clear.

> >> + *
> >> + * POWEROFF_PRIO_RESERVED:     Falls back to POWEROFF_PRIO_DEFAULT.
> >> + *                             Drivers may leave priority initialized
> >> + *                             to zero, to auto-set it to the default level.
> >> + *
> >> + * POWEROFF_PRIO_PLATFORM:     Intended to be used by platform-level handler.
> >> + *                             Has lowest priority since device drivers are
> >> + *                             expected to take over platform handler which
> >> + *                             doesn't allow further callback chaining.
> >> + *
> >> + * POWEROFF_PRIO_DEFAULT:      Use this for default/generic handler.
> >> + *
> >> + * POWEROFF_PRIO_FIRMWARE:     Use this if handler uses firmware call.
> >> + *                             Has highest priority since firmware is expected
> >> + *                             to know best how to power-off hardware properly.
> >> + */
> >> +#define POWEROFF_PRIO_RESERVED         0
> >> +#define POWEROFF_PRIO_PLATFORM         1
> >> +#define POWEROFF_PRIO_DEFAULT          128
> >> +#define POWEROFF_PRIO_HIGH             192
> >> +#define POWEROFF_PRIO_FIRMWARE         224
> >> +
> >> +enum poweroff_mode {
> >> +       POWEROFF_NORMAL = 0,
> >
> > Why not just POWEROFF?
>
> This is a bit too generic name to me.
>
> I can rename it as MODE_POWEROFF and MODE_POWEROFF_PREPARE.

In that case I would leave POWEROFF_PREPARE as is and rename the other
one to POWEROFF_FINAL.  And maybe put them in the reverse order in the
enum definition, because _PREPARE will be done before _FINAL.

> >> +       POWEROFF_PREPARE,
> >> +};
> >> +
> >> +/**
> >> + * struct power_off_data - Power-off callback argument
> >> + *
> >> + * @cb_data: Callback data.
> >> + */
> >> +struct power_off_data {
> >> +       void *cb_data;
> >> +};
> >> +
> >> +/**
> >> + * struct power_off_prep_data - Power-off preparation callback argument
> >> + *
> >> + * @cb_data: Callback data.
> >> + */
> >> +struct power_off_prep_data {
> >> +       void *cb_data;
> >> +};
> >
> > Why does this need to be a separate data type?
>
> To allow us extend the "struct power_off_prep_data" with more parameters
> later on without a need to update each driver with the new arguments.

I'm not really sure what you mean here.  Can you give an example?

> >> +
> >> +/**
> >> + * struct restart_data - Restart callback argument
> >> + *
> >> + * @cb_data: Callback data.
> >> + * @cmd: Restart command string.
> >> + * @stop_chain: Further lower priority callbacks won't be executed if set to
> >> + *             true. Can be changed within callback. Default is false.
> >> + * @mode: Reboot mode ID.
> >> + */
> >> +struct restart_data {
> >> +       void *cb_data;
> >> +       const char *cmd;
> >> +       bool stop_chain;
> >> +       enum reboot_mode mode;
> >> +};
> >> +
> >> +/**
> >> + * struct reboot_prep_data - Reboot and shutdown preparation callback argument
> >> + *
> >> + * @cb_data: Callback data.
> >> + * @cmd: Restart command string.
> >> + * @stop_chain: Further lower priority callbacks won't be executed if set to
> >> + *             true. Can be changed within callback. Default is false.
> >> + * @mode: Preparation mode ID.
> >> + */
> >> +struct reboot_prep_data {
> >> +       void *cb_data;
> >> +       const char *cmd;
> >> +       bool stop_chain;
> >> +       enum reboot_prepare_mode mode;
> >> +};
> >
> > There seem to be some duplicate data items between struct restart_data
> > and struct reboot_prep_data, so what's the reason why they are
> > separate?
>
> They indeed look similar, but have different purposes. We shouldn't use
> reboot handler for restarting, hence why should we mix them?

Well, I got confused by the naming.

The "reboot prep" thing really should be a "system is going down"
notification.  Since "sysoff" is already used in the names below, why
not rename it to "sysoff_prepare"?

> >> +struct sys_off_handler_private_data {
> >> +       struct notifier_block power_off_nb;
> >> +       struct notifier_block restart_nb;
> >> +       struct notifier_block reboot_nb;
> >
> > So restart_nb is going to be added to restart_handler_list, eboot_nb
> > will be added to reboot_notifier_list (which both exist already) and
> > power_off_nb will be added to the new power_off_handler_list, right?
> >
> > Of course, this means that reboot_nb will be used in
> > kernel_restart_prepare() and kernel_shutdown_prepare(), so the
> > corresponding callback will be invoked in both the restart and
> > power-off cases.
> >
> > It would be good to document that somehow.
>
> This is documented in the doc-comment to struct sys_off_handler later in
> this patch. You actually found it below.

IMO, it would be better to document it here, because that's where
people will look first, as a rule.

> >> +       void (*platform_power_off_cb)(void);
> >> +       void (*simple_power_off_cb)(void *data);
> >> +       void *simple_power_off_cb_data;
> >
> > Is there any particular reason to put these callbacks here and not
> > directly into struct sys_off_handler?
>
> They are used internally by reboot.c and shouldn't be touched by the
> kernel API users, so I wanted to factor out and protect all the private
> data.

But they come from these users anyway, don't they?

> >> +       bool registered;
> >> +};
> >> +
> >> +/**
> >> + * struct sys_off_handler - System power-off and restart handler
> >> + *
> >> + * @cb_data: Pointer to user's data.
> >> + *
> >> + * @power_off_cb: Callback that powers off this machine. Inactive if NULL.
> >> + *
> >> + * @power_off_prepare_cb: Power-off preparation callback. All power-off
> >> + * preparation callbacks are invoked after @reboot_prepare_cb and before
> >> + * @power_off_cb. Inactive if NULL.
> >> + *
> >> + * @power_off_priority: Power-off callback priority, must be unique.
> >> + * Zero value is reserved and auto-reassigned to POWEROFF_PRIO_DEFAULT.
> >> + * Inactive if @power_off_cb is NULL.
> >> + *
> >> + * @power_off_chaining_allowed: Set to false if callback's execution should
> >> + * stop when @power_off_cb fails to power off this machine. True if further
> >> + * lower priority power-off callback should be executed. False is default
> >> + * value.
> >> + *
> >> + * @restart_cb: Callback that reboots this machine. Inactive if NULL.
> >> + *
> >> + * @restart_priority: Restart callback priority, must be unique. Zero value
> >> + * is reserved and auto-reassigned to RESTART_PRIO_DEFAULT. Inactive if
> >> + * @restart_cb is NULL.
> >> + *
> >> + * @restart_chaining_disallowed: Set to true if callback's execution should
> >> + * stop when @restart_cb fails to restart this machine. False if further
> >> + * lower priority restart callback should be executed. False is default
> >> + * value.
> >> + *
> >> + * @reboot_prepare_cb: Reboot/shutdown preparation callback. All reboot
> >> + * preparation callbacks are invoked before @restart_cb or @power_off_cb,
> >> + * depending on the mode. It's registered with register_reboot_notifier().
> >> + * The point is to remove boilerplate code from drivers which use this
> >> + * callback in conjunction with the restart/power-off callbacks.
> >> + *
> >> + * @reboot_priority: Reboot/shutdown preparation callback priority, doesn't
> >> + * need to be unique. Zero is default value. Inactive if @reboot_prepare_cb
> >> + * is NULL.
> >
> > It is unclear that the ->reboot_prepare_cb() callback is going to be
> > used for both restart and power-off and reboot_priority is about the
> > preparation phase only.
> >
> > And in the preparation phase the priority may not matter that much,
> > because there are users who don't care about the ordering as long as
> > their stuff is called at all.
> >
> > Honestly, I would change the naming here, because what it is is quite
> > confusing at least to me.  Especially that "restart" and "reboot" seem
> > to be used interchangeably in the comments.
>
> These are the legacy names and they are indeed very confusing. Do you
> have suggestion for a better names?

Well, as I said above, I would rename the "reboot" thing to
"sysoff_prepare" covering all of the cases.  And then either "restart"
or "poweroff" would be called after that, depending on the specific
case.

On a slightly related note, I started to wonder about the actual value
provided by struct sys_off_handler.  Namely, the existing "reboot" and
"restart" notifier chains will be used anyway and there are ways to
use them directly.  Also, there will be ways to use the new "poweroff"
chain directly, so struct sys_off_handler appears to be an extra
complication and it is not particularly easier to use than a
combination of "raw" notifiers.

It looks to me that it might be sufficient to have a way to register a
callback for "sysoff_prepare" (aka "reboot") and "restart" and a pair
of callbacks for "poweroff", with a given priority with all of the
necessary internals taken care of by the framework.

> >> + *
> >> + * @priv: Internal data. Shouldn't be touched.
> >> + *
> >> + * Describes power-off and restart handlers which are invoked by kernel
> >> + * to power off or restart this machine. Supports prioritized chaining for
> >> + * both restart and power-off handlers.
> >> + *
> >> + * Struct sys_off_handler can be static. Members of this structure must not be
> >> + * altered while handler is registered.
> >> + *
> >> + * Fill the structure members and pass it to @register_sys_off_handler().
> >> + */
> >> +struct sys_off_handler {
> >> +       void *cb_data;
> >> +
> >> +       void (*power_off_cb)(struct power_off_data *data);
> >> +       void (*power_off_prepare_cb)(struct power_off_prep_data *data);
> >> +       int power_off_priority;
> >> +       bool power_off_chaining_allowed;
> >> +
> >> +       void (*restart_cb)(struct restart_data *data);
> >> +       int restart_priority;
> >> +       bool restart_chaining_disallowed;
> >> +
> >> +       void (*reboot_prepare_cb)(struct reboot_prep_data *data);
> >> +       int reboot_priority;
> >> +
> >> +       const struct sys_off_handler_private_data priv;
> >
> > Why is it const?  Because of the callbacks in there?
>
> It's const to prevent changing/abusing of the internal data by kernel
> API users. Those callbacks are private to kernel/reboot.c
>
> > Doesn't this mean that all struct sys_off_handler need to be static?
>
> The reboot.c is allowed to modify the private data, sys_off_handler can
> be static and dynamic. There is no limitaion, I made the 'priv' member
> constant only for the API users.

Well, to me it is confusing and it doesn't really make the intention clear.

Personally, I'd call it something like "internal_leave_alone" or similar.

> >> +};
> >> +
> >> +int register_sys_off_handler(struct sys_off_handler *handler);
> >> +int unregister_sys_off_handler(struct sys_off_handler *handler);
> >> +
> >> +int devm_register_sys_off_handler(struct device *dev,
> >> +                                 struct sys_off_handler *handler);
> >> +
> >> +int devm_register_prioritized_power_off_handler(struct device *dev,
> >> +                                               int priority,
> >> +                                               void (*callback)(void *data),
> >> +                                               void *cb_data);
> >> +
> >> +int devm_register_simple_power_off_handler(struct device *dev,
> >> +                                          void (*callback)(void *data),
> >> +                                          void *cb_data);
> >> +
> >> +int register_platform_power_off(void (*power_off)(void));
> >> +int unregister_platform_power_off(void (*power_off)(void));
> >> +
> >> +int devm_register_prioritized_restart_handler(struct device *dev,
> >> +                                             int priority,
> >> +                                             void (*callback)(struct restart_data *data),
> >> +                                             void *cb_data);
> >> +
> >> +int devm_register_simple_restart_handler(struct device *dev,
> >> +                                        void (*callback)(struct restart_data *data),
> >> +                                        void *cb_data);
> >> +
> >> +void do_kernel_power_off(void);
> >> +
> >>  /*
> >>   * Architecture-specific implementations of sys_reboot commands.
> >>   */
> >> @@ -70,6 +290,7 @@ extern void kernel_restart_prepare(char *cmd);
> >>  extern void kernel_restart(char *cmd);
> >>  extern void kernel_halt(void);
> >>  extern void kernel_power_off(void);
> >> +extern bool kernel_can_power_off(void);
> >>
> >>  void ctrl_alt_del(void);
> >>
> >> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> >> index 938d5c78b421..a9464b4a3209 100644
> >> --- a/kernel/power/hibernate.c
> >> +++ b/kernel/power/hibernate.c
> >> @@ -665,7 +665,7 @@ static void power_down(void)
> >>                 hibernation_platform_enter();
> >>                 fallthrough;
> >>         case HIBERNATION_SHUTDOWN:
> >> -               if (pm_power_off)
> >> +               if (kernel_can_power_off())
> >>                         kernel_power_off();
> >>                 break;
> >>         }
> >> diff --git a/kernel/reboot.c b/kernel/reboot.c
> >> index acdae4e95061..e76e2570dcf5 100644
> >> --- a/kernel/reboot.c
> >> +++ b/kernel/reboot.c
> >> @@ -296,6 +296,595 @@ void kernel_halt(void)
> >>  }
> >>  EXPORT_SYMBOL_GPL(kernel_halt);
> >>
> >> +/*
> >> + *     Notifier list for kernel code which wants to be called
> >> + *     to power off the system.
> >> + */
> >> +static BLOCKING_NOTIFIER_HEAD(power_off_handler_list);
> >> +
> >> +/*
> >> + * Temporary stub that prevents linkage failure while we're in process
> >> + * of removing all uses of legacy pm_power_off() around the kernel.
> >
> > Nit: inconsistent comment formatting.
> >
> >> + */
> >> +void __weak (*pm_power_off)(void);
> >> +
> >> +static void dummy_pm_power_off(void)
> >> +{
> >> +       /* temporary stub until pm_power_off() is gone, see more below */
> >> +}
> >> +
> >> +static struct notifier_block *pm_power_off_nb;
> >> +
> >> +/**
> >> + *     register_power_off_handler - Register function to be called to power off
> >> + *                                  the system
> >> + *     @nb: Info about handler function to be called
> >> + *     @nb->priority:  Handler priority. Handlers should follow the
> >> + *                     following guidelines for setting priorities.
> >> + *                     0:      Reserved
> >> + *                     1:      Power-off handler of last resort,
> >> + *                             with limited power-off capabilities
> >> + *                     128:    Default power-off handler; use if no other
> >> + *                             power-off handler is expected to be available,
> >> + *                             and/or if power-off functionality is
> >> + *                             sufficient to power-off the entire system
> >> + *                     255:    Highest priority power-off handler, will
> >> + *                             preempt all other power-off handlers
> >> + *
> >> + *     Registers a function with code to be called to power off the
> >> + *     system.
> >
> > Because this is only used internally in this file, I'd say what it
> > does directly, that is "Add a notifier to the power-off chain used for
> > powering off the system".
>
> I'll improve it, thanks.
>
> >> + *
> >> + *     Registered functions will be called as last step of the power-off
> >> + *     sequence.
> >> + *
> >> + *     Registered functions are expected to power off the system immediately.
> >> + *     If more than one function is registered, the power-off handler priority
> >> + *     selects which function will be called first.
> >> + *
> >> + *     Power-off handlers are expected to be registered from non-architecture
> >> + *     code, typically from drivers. A typical use case would be a system
> >> + *     where power-off functionality is provided through a PMIC. Multiple
> >> + *     power-off handlers may exist; for example, one power-off handler might
> >> + *     turn off the entire system, while another only turns off part of
> >> + *     system. In such cases, the power-off handler which only disables part
> >> + *     of the hardware is expected to register with low priority to ensure
> >> + *     that it only runs if no other means to power off the system is
> >> + *     available.
> >
> > I would move the above 3 paragraphs to the description comment for
> > power_off_handler_list.
>
> Noted
>
> >> + *
> >> + *     Currently always returns zero, as blocking_notifier_chain_register()
> >> + *     always returns zero.
> >> + */
> >> +static int register_power_off_handler(struct notifier_block *nb)
> >> +{
> >> +       int ret;
> >> +
> >> +       ret = blocking_notifier_chain_register_unique_prio(&power_off_handler_list, nb);
> >> +       if (ret && ret != -EBUSY)
> >> +               return ret;
> >> +
> >> +       if (!ret)
> >> +               goto set_pm_power_off;
> >> +
> >> +       /*
> >> +        * Handler must have unique priority. Otherwise call order is
> >> +        * determined by registration order, which is unreliable.
> >> +        *
> >> +        * This requirement will become mandatory once all drivers
> >> +        * will be converted to use new sys-off API.
> >> +        */
> >> +       pr_err("failed to register power-off handler using unique priority\n");
> >> +
> >> +       ret = blocking_notifier_chain_register(&power_off_handler_list, nb);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /*
> >> +        * Some drivers check whether pm_power_off was already installed.
> >> +        * Install dummy callback using new API to preserve old behaviour
> >> +        * for those drivers during period of transition to the new API.
> >> +        */
> >> +set_pm_power_off:
> >> +       if (!pm_power_off) {
> >> +               pm_power_off = dummy_pm_power_off;
> >> +               pm_power_off_nb = nb;
> >> +       }
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int unregister_power_off_handler(struct notifier_block *nb)
> >> +{
> >> +       if (nb == pm_power_off_nb) {
> >> +               if (pm_power_off == dummy_pm_power_off)
> >> +                       pm_power_off = NULL;
> >> +
> >> +               pm_power_off_nb = NULL;
> >> +       }
> >> +
> >> +       return blocking_notifier_chain_unregister(&power_off_handler_list, nb);
> >> +}
> >> +
> >> +static void devm_unregister_power_off_handler(void *data)
> >> +{
> >> +       struct notifier_block *nb = data;
> >> +
> >> +       unregister_power_off_handler(nb);
> >> +}
> >> +
> >> +static int devm_register_power_off_handler(struct device *dev,
> >> +                                          struct notifier_block *nb)
> >> +{
> >> +       int err;
> >> +
> >> +       err = register_power_off_handler(nb);
> >> +       if (err)
> >> +               return err;
> >> +
> >> +       return devm_add_action_or_reset(dev, devm_unregister_power_off_handler,
> >> +                                       nb);
> >> +}
> >> +
> >> +static int sys_off_handler_power_off(struct notifier_block *nb,
> >> +                                    unsigned long mode, void *unused)
> >> +{
> >> +       struct power_off_prep_data prep_data = {};
> >> +       struct sys_off_handler_private_data *priv;
> >> +       struct power_off_data data = {};
> >> +       struct sys_off_handler *h;
> >> +       int ret = NOTIFY_DONE;
> >> +
> >> +       priv = container_of(nb, struct sys_off_handler_private_data, power_off_nb);
> >> +       h = container_of(priv, struct sys_off_handler, priv);
> >> +       prep_data.cb_data = h->cb_data;
> >> +       data.cb_data = h->cb_data;
> >> +
> >> +       switch (mode) {
> >> +       case POWEROFF_NORMAL:
> >> +               if (h->power_off_cb)
> >> +                       h->power_off_cb(&data);
> >> +
> >> +               if (priv->simple_power_off_cb)
> >> +                       priv->simple_power_off_cb(priv->simple_power_off_cb_data);
> >> +
> >> +               if (priv->platform_power_off_cb)
> >> +                       priv->platform_power_off_cb();
> >
> > The invocation of the priv callbacks here confuses me quite a bit.
> >
> > Can you please at least add a comment explaining this?
>
> Sure
>
> >> +
> >> +               if (!h->power_off_chaining_allowed)
> >> +                       ret = NOTIFY_STOP;
> >> +
> >> +               break;
> >> +
> >> +       case POWEROFF_PREPARE:
> >> +               if (h->power_off_prepare_cb)
> >> +                       h->power_off_prepare_cb(&prep_data);
> >> +
> >> +               break;
> >> +
> >> +       default:
> >> +               unreachable();
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >> +static int sys_off_handler_restart(struct notifier_block *nb,
> >> +                                  unsigned long mode, void *cmd)
> >> +{
> >> +       struct sys_off_handler_private_data *priv;
> >> +       struct restart_data data = {};
> >> +       struct sys_off_handler *h;
> >> +
> >> +       priv = container_of(nb, struct sys_off_handler_private_data, restart_nb);
> >> +       h = container_of(priv, struct sys_off_handler, priv);
> >> +
> >> +       data.stop_chain = h->restart_chaining_disallowed;
> >> +       data.cb_data = h->cb_data;
> >> +       data.mode = mode;
> >> +       data.cmd = cmd;
> >> +
> >> +       h->restart_cb(&data);
> >
> > Wouldn't it be a bit more straightforward to allow ->restart_cb() to
> > return a value being either NOTIFY_STOP or NOTIFY_DONE?
>
> Vast majority of drivers don't use the 'stop_chain', hence it's
> unnecessary boilerplate code for drivers. The code looks nicer without
> the boilerplate "return NOTIFY_DONE", IMO.

I don't really think that making the callback non-void would be a problem.

> >> +       return data.stop_chain ? NOTIFY_STOP : NOTIFY_DONE;
> >
> > And I would prefer
> >
> > if (data.stop_chain)
> >         return NOTIFY_STOP;
> >
> > return NOTIFY_DONE;
>
> Okay
>
> >> +}
> >> +
> >> +static int sys_off_handler_reboot(struct notifier_block *nb,
> >> +                                 unsigned long mode, void *cmd)
> >> +{
> >> +       struct sys_off_handler_private_data *priv;
> >> +       struct reboot_prep_data data = {};
> >> +       struct sys_off_handler *h;
> >> +
> >> +       priv = container_of(nb, struct sys_off_handler_private_data, reboot_nb);
> >> +       h = container_of(priv, struct sys_off_handler, priv);
> >> +
> >> +       data.cb_data = h->cb_data;
> >> +       data.stop_chain = false;
> >> +       data.mode = mode;
> >> +       data.cmd = cmd;
> >> +
> >> +       h->reboot_prepare_cb(&data);
> >> +
> >> +       return data.stop_chain ? NOTIFY_STOP : NOTIFY_DONE;
> >
> > And analogously here.
> >
> >> +}
> >> +
> >> +static struct sys_off_handler_private_data *
> >> +sys_off_handler_private_data(struct sys_off_handler *handler)
> >> +{
> >> +       return (struct sys_off_handler_private_data *)&handler->priv;
> >
> > Is the cast needed to avoid a warning about "const"?
>
> The private data is constant to prevent the API users from using it. For
> internal use we need to cast out the "const". It's a compilation error
> to change the constant members.

Precisely.  And so it shouldn't be done in any way.

> >> +}
> >> +
> >> +/**
> >> + *     devm_register_sys_off_handler - Register system power-off/restart handler
> >
> > register_sys_off_handler
>
> Good catch!
>
> >> + *     @dev: Device that registers handler
> >> + *     @handler: System-off handler
> >> + *
> >> + *     Registers handler that will be called as last step of the power-off
> >> + *     and restart sequences.
> >
> > Not necessarily as the last step, because there may be other system
> > power-off/restart handlers called after it.
> >
> > I would just say "at the end of the power-off and restart sequences".
> >
> > Moreover, it registers the "reboot_cb" part that is not called "at the
> > end" even.
> >
> > Also, because this is the function that will be used by drivers etc to
> > register handlers, I would give some more information on how the
> > object registered by it is going to be used to the prospective users.
>
> I'll improve the description, thank you.
>
> >> + *
> >> + *     Returns zero on success, or error code on failure.
> >> + */
> >> +int register_sys_off_handler(struct sys_off_handler *handler)
> >> +{
> >> +       struct sys_off_handler_private_data *priv;
> >> +       int err, priority;
> >> +
> >> +       priv = sys_off_handler_private_data(handler);
> >> +
> >> +       /* sanity-check whether handler is registered twice */
> >> +       if (priv->registered)
> >> +               return -EBUSY;
> >> +
> >> +       if (handler->power_off_cb || handler->power_off_prepare_cb) {
> >> +               if (handler->power_off_priority == POWEROFF_PRIO_RESERVED)
> >> +                       priority = POWEROFF_PRIO_DEFAULT;
> >
> > I'm not sure that this helps.
> >
> > I mean, why can't the users of this new API pass POWEROFF_PRIO_DEFAULT
> > directly if they want "default"?
>
> Users could pass POWEROFF_PRIO_DEFAULT, but it's a boilerplate code
> which I wanted to avoid by reserving 0 for the alias to
> POWEROFF_PRIO_DEFAULT=128.
>
> This removes a need from drivers to explicitly specify the default
> priorities in the code, assuming that sys_off_handler is initialized to
> zero.

But the developers need to check whether or not they do the right
thing anyway and so they will need to look at the code here to see
whether or not it is OK to pass 0 and what happens then.  I'm not sure
if I prefer this to the explicit "default".

Or define POWEROFF_PRIO_DEFAULT as 0 and there will be nothing to worry about.

> >> +               else
> >> +                       priority = handler->power_off_priority;
> >> +
> >> +               priv->power_off_nb.notifier_call = sys_off_handler_power_off;
> >> +               priv->power_off_nb.priority = priority;
> >> +
> >> +               err = register_power_off_handler(&priv->power_off_nb);
> >> +               if (err)
> >> +                       goto reset_sys_off_handler;
> >> +       }
> >> +
> >> +       if (handler->restart_cb) {
> >> +               if (handler->restart_priority == RESTART_PRIO_RESERVED)
> >> +                       priority = RESTART_PRIO_DEFAULT;
> >> +               else
> >> +                       priority = handler->restart_priority;
> >> +
> >> +               priv->restart_nb.notifier_call = sys_off_handler_restart;
> >> +               priv->restart_nb.priority = priority;
> >> +
> >> +               err = register_restart_handler(&priv->restart_nb);
> >> +               if (err)
> >> +                       goto unreg_power_off_handler;
> >> +       }
> >> +
> >> +       if (handler->reboot_prepare_cb) {
> >> +               priv->reboot_nb.notifier_call = sys_off_handler_reboot;
> >> +               priv->reboot_nb.priority = handler->reboot_priority;
> >> +
> >> +               err = register_reboot_notifier(&priv->reboot_nb);
> >> +               if (err)
> >> +                       goto unreg_restart_handler;
> >> +       }
> >> +
> >> +       priv->registered = true;
> >> +
> >> +       return 0;
> >> +
> >> +unreg_restart_handler:
> >> +       if (handler->restart_cb)
> >> +               unregister_restart_handler(&priv->restart_nb);
> >> +
> >> +unreg_power_off_handler:
> >> +       if (handler->power_off_cb)
> >> +               unregister_power_off_handler(&priv->power_off_nb);
> >> +
> >> +reset_sys_off_handler:
> >> +       memset(priv, 0, sizeof(*priv));
> >> +
> >> +       return err;
> >> +}
> >> +EXPORT_SYMBOL(register_sys_off_handler);
> >> +
> >> +/**
> >> + *     unregister_sys_off_handler - Unregister system power-off/restart handler
> >> + *     @handler: System-off handler
> >> + *
> >> + *     Unregisters sys-off handler. Does nothing and returns zero if handler
> >> + *     is NULL.
> >> + *
> >> + *     Returns zero on success, or error code on failure.
> >> + */
> >> +int unregister_sys_off_handler(struct sys_off_handler *handler)
> >> +{
> >> +       struct sys_off_handler_private_data *priv;
> >> +
> >> +       if (!handler)
> >> +               return 0;
> >> +
> >> +       priv = sys_off_handler_private_data(handler);
> >> +
> >> +       /* sanity-check whether handler is unregistered twice */
> >> +       if (!priv->registered)
> >> +               return -EINVAL;
> >> +
> >> +       if (handler->reboot_prepare_cb)
> >> +               unregister_reboot_notifier(&priv->reboot_nb);
> >> +
> >> +       if (handler->restart_cb)
> >> +               unregister_restart_handler(&priv->restart_nb);
> >> +
> >> +       if (handler->power_off_cb)
> >> +               unregister_power_off_handler(&priv->power_off_nb);
> >> +
> >> +       memset(priv, 0, sizeof(*priv));
> >> +
> >> +       return 0;
> >> +}
> >> +EXPORT_SYMBOL(unregister_sys_off_handler);
> >> +
> >> +static void devm_unregister_sys_off_handler(void *data)
> >> +{
> >> +       struct sys_off_handler *handler = data;
> >> +
> >> +       unregister_sys_off_handler(handler);
> >> +}
> >> +
> >> +/**
> >> + *     devm_register_sys_off_handler - Register system power-off/restart handler
> >> + *     @dev: Device that registers handler
> >> + *     @handler: System-off handler
> >> + *
> >> + *     Resource-managed variant of register_sys_off_handler().
> >> + *
> >> + *     Returns zero on success, or error code on failure.
> >> + */
> >> +int devm_register_sys_off_handler(struct device *dev,
> >> +                                 struct sys_off_handler *handler)
> >> +{
> >> +       int err;
> >> +
> >> +       err = register_sys_off_handler(handler);
> >> +       if (err)
> >> +               return err;
> >> +
> >> +       return devm_add_action_or_reset(dev, devm_unregister_sys_off_handler,
> >> +                                       handler);
> >> +}
> >> +EXPORT_SYMBOL(devm_register_sys_off_handler);
> >> +
> >> +/**
> >> + *     devm_register_prioritized_power_off_handler - Register prioritized power-off callback
> >> + *     @dev: Device that registers callback
> >> + *     @priority: Callback's priority
> >> + *     @callback: Callback function
> >> + *     @cb_data: Callback's argument
> >> + *
> >> + *     Registers resource-managed power-off callback with a given priority.
> >> + *     It will be called as last step of the power-off sequence. Callbacks
> >> + *     chaining is disabled, i.e. further lower priority callbacks won't
> >> + *     be executed if this @callback will fail to execute.
> >> + *
> >> + *     Returns zero on success, or error code on failure.
> >
> > What's the case in which this should be used instead of registering a
> > full sys_off handler?
>
> There are a lot of drivers that just want to register power-off handler
> with a non-default priority and don't need to stop the chain or do
> anything else special. This is a convinient helper for them.
>
> Please note that the callback here takes only the cb_data for the
> argument, while sys_off uses "struct power_off_data".
>
> Similar for the reset of the convinient helpers.

So if there is a way to do this, why would anyone prefer to use the
full sys_off handler at all?

> ...
> >> +/**
> >> + *     register_platform_power_off - Register platform-level power-off callback
> >> + *     @power_off: Power-off callback
> >> + *
> >> + *     Registers power-off callback that will be called as last step
> >> + *     of the power-off sequence. This callback is expected to be invoked
> >> + *     for the last resort. Further lower priority callbacks won't be
> >> + *     executed if @power_off fails. Only one platform power-off callback
> >> + *     is allowed to be registered at a time.
> >> + *
> >> + *     Returns zero on success, or error code on failure.
> >
> > What's the use case for this?
>
> There are dozens of trivial platform/board-specific power-off handlers
> in the arch/ code. Those handlers don't take any arguments, hence it's a
> convinient helper that transits them to the new API neatly.
>
> >> + */
> >> +int register_platform_power_off(void (*power_off)(void))
> >> +{
> >> +       struct sys_off_handler_private_data *priv;
> >> +       int ret = 0;
> >> +
> >> +       priv = sys_off_handler_private_data(&platform_power_off_handler);
> >> +
> >> +       spin_lock(&platform_power_off_lock);
> >> +       if (priv->platform_power_off_cb)
> >> +               ret = -EBUSY;
> >> +       else
> >> +               priv->platform_power_off_cb = power_off;
> >
> > Wasn't priv supposed to be const?
>
> It's const only for the external API users to prevent them from abusing
> the internal data.

So if this is not clear yet, I'm not going to let this go.

> >> +       spin_unlock(&platform_power_off_lock);
> >> +
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       ret = register_power_off_handler(&priv->power_off_nb);
> >> +       if (ret)
> >> +               priv->platform_power_off_cb = NULL;
> >> +
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(register_platform_power_off);
> >> +
> >> +/**
> >> + *     unregister_platform_power_off - Unregister platform-level power-off callback
> >> + *     @power_off: Power-off callback
> >> + *
> >> + *     Unregisters previously registered platform power-off callback.
> >> + *
> >> + *     Returns zero on success, or error code on failure.
> >> + */
> >> +int unregister_platform_power_off(void (*power_off)(void))
> >> +{
> >> +       struct sys_off_handler_private_data *priv;
> >> +       int ret;
> >> +
> >> +       priv = sys_off_handler_private_data(&platform_power_off_handler);
> >> +
> >> +       if (priv->platform_power_off_cb != power_off)
> >> +               return -EINVAL;
> >> +
> >> +       ret = unregister_power_off_handler(&priv->power_off_nb);
> >> +       priv->platform_power_off_cb = NULL;
> >> +
> >> +       return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(unregister_platform_power_off);
> >> +
> >> +/**
> >> + *     do_kernel_power_off - Execute kernel power-off handler call chain
> >> + *
> >> + *     Calls functions registered with register_power_off_handler.
> >> + *
> >> + *     Expected to be called as last step of the power-off sequence.
> >> + *
> >> + *     Powers off the system immediately if a power-off handler function has
> >> + *     been registered. Otherwise does nothing.
> >> + */
> >> +void do_kernel_power_off(void)
> >> +{
> >> +       /* legacy pm_power_off() is unchained and has highest priority */
> >> +       if (pm_power_off && pm_power_off != dummy_pm_power_off)
> >> +               return pm_power_off();
> >> +
> >> +       blocking_notifier_call_chain(&power_off_handler_list, POWEROFF_NORMAL,
> >> +                                    NULL);
> >> +}
> >> +
> >> +static void do_kernel_power_off_prepare(void)
> >> +{
> >> +       /* legacy pm_power_off_prepare() is unchained and has highest priority */
> >> +       if (pm_power_off_prepare)
> >> +               return pm_power_off_prepare();
> >> +
> >> +       blocking_notifier_call_chain(&power_off_handler_list, POWEROFF_PREPARE,
> >> +                                    NULL);
> >> +}
> >> +
> >>  /**
> >>   *     kernel_power_off - power_off the system
> >>   *
> >> @@ -304,8 +893,7 @@ EXPORT_SYMBOL_GPL(kernel_halt);
> >>  void kernel_power_off(void)
> >>  {
> >>         kernel_shutdown_prepare(SYSTEM_POWER_OFF);
> >> -       if (pm_power_off_prepare)
> >> -               pm_power_off_prepare();
> >> +       do_kernel_power_off_prepare();
> >>         migrate_to_reboot_cpu();
> >>         syscore_shutdown();
> >>         pr_emerg("Power down\n");
> >> @@ -314,6 +902,16 @@ void kernel_power_off(void)
> >>  }
> >>  EXPORT_SYMBOL_GPL(kernel_power_off);
> >>
> >> +bool kernel_can_power_off(void)
> >> +{
> >> +       if (!pm_power_off &&
> >> +           blocking_notifier_call_chain_is_empty(&power_off_handler_list))
> >> +               return false;
> >> +
> >> +       return true;
> >
> > return pm_power_off ||
> > blocking_notifier_call_chain_is_empty(&power_off_handler_list);
>
> Thank you for the thorough review!

You're very welcome!
