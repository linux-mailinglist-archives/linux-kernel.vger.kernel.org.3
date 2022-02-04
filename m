Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107D84A9FC0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 20:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiBDTIm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Feb 2022 14:08:42 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:33593 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiBDTIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 14:08:41 -0500
Received: by mail-yb1-f180.google.com with SMTP id j2so21712588ybu.0;
        Fri, 04 Feb 2022 11:08:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RXFJZ9DMfIJfrTOBd66RHSq34FsmGK+yQLe0NV70Kp0=;
        b=eE8IVtH2smJK7R5TuK4pwfFj2yOzqH0xAnEkpzWFBe7cp6u1704kQ7e3EQg0SN7Xdd
         qEUqAhPQV/8S0CbMOjZEYO0gFfzBNphqD9E45Srn8pHrThwTUj14NiRvvmizqoaaRL6Q
         +sShhCYSa5V8bpTxqb4Ylfe6/WNpnaStp+ou5lAg7ejD92+SsI0pnzVy0whuCZNokoen
         NMIatNTgFmMNeB2Ra/TSxf97tey5ByEnylwlHQo07b4Z1dSvdR3UuBK+lJGpSYsqOiSh
         K9gi0E6Kfdt3Ah/rUgfFXNdVSxzOsIPSp9qDo91Qmog6Z3PyRGz/FJaMbBjd8l8SpTPv
         bnHw==
X-Gm-Message-State: AOAM533x+UB+yCmTU1MNDwDbIJRfLarQlqKxvIVu2h3ZQA5bAkBvf5Zj
        S6K3Kgk7foH9SxZPXZd6m+KY20tMQrD5bfIedIz8JYsOB5M=
X-Google-Smtp-Source: ABdhPJw4sxfUcZ9dEGRVSS/CzkhqBN7tkZ0GyybXqy17yuK2RSj5cztoMhjYiv94YCM0A2KTr3fAcwSzQzqKCiA23Hk=
X-Received: by 2002:a05:6902:54c:: with SMTP id z12mr627784ybs.624.1644001720419;
 Fri, 04 Feb 2022 11:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220128235118.1693865-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0iJph04mtGabTXLY_7FqaA9tCnFwz=-+DR=n3G3GC6Szg@mail.gmail.com> <dae13602d4b4178ae86a749a9b6473fb64b82679.camel@linux.intel.com>
In-Reply-To: <dae13602d4b4178ae86a749a9b6473fb64b82679.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Feb 2022 20:08:29 +0100
Message-ID: <CAJZ5v0hfJ0d=QFu0tOE3q_rHzA1F6M8Om0wfFEbCAByLU+3HHA@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI / fan: Properly handle fine grain control
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 10:54 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2022-02-03 at 21:13 +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 29, 2022 at 12:51 AM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > >
>
> [...]
>
> > > To support fine grain control (when supported) via thermal sysfs:
> > > - cooling device max state is not _FPS state count but it will be
> > > 100 / _FIF.step_size
> > > - cooling device current state is 100 / _FIF.step_size
> >
> > I don't quite understand this.
> >
> > The max state and the current state should not always be the same,
> > should they?
>
> This sentence needs correction.
> The  current_state is _FST.control/_FIF.step_size.
>
> >
> > > - cooling device set state will set the control value
> > >
>
> [...]
>
> > > -       else
> > > +       if (fan->acpi4) {
> > > +               if (fan->fif.fine_grain_ctrl)
> > > +                       *state = 100 / (int)fan->fif.step_size;
> >
> > Is it really necessary to explicitly cast fif.step_size to int?
> This was reported by LKP as fan->fif.step_size is 64 bit. This driver
> doesn't restrict to 64 bit.
>
> "undefined reference to `__udivdi3" for i386-defconfig.

I see.

Then I would convert struct acpi_fan_fif to u32 fields and extract it
directly (and sanitize step_size in the process), because using
acpi_extract_package() to retrieve it is not worth the resulting fuss
IMO.

> >
> > > +               else
> > > +                       *state = fan->fps_count - 1;
> > >
>
> [...]
>
> > > -static int fan_get_state_acpi4(struct acpi_device *device,
> > > unsigned long *state)
> > > +static int fan_get_fps(struct acpi_device *device, struct
> > > acpi_fan_fst *fst)
> >
> > Why is this called fan_get_fps()?  I'd rather call it
> > acpi_fan_get_fst().
> I can change that.
>
> >
> > >  {
> > >         struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> > > -       struct acpi_fan *fan = acpi_driver_data(device);
> > >         union acpi_object *obj;
> > >         acpi_status status;
> > > -       int control, i;
> > >
> > >         status = acpi_evaluate_object(device->handle, "_FST", NULL,
> > > &buffer);
> > >         if (ACPI_FAILURE(status)) {
> > > @@ -119,31 +130,51 @@ static int fan_get_state_acpi4(struct
> > > acpi_device *device, unsigned long *state)
> > >                 goto err;
> > >         }
> > >
> > > -       control = obj->package.elements[1].integer.value;
> > > +       fst->revision = obj->package.elements[0].integer.value;
> > > +       fst->control = obj->package.elements[1].integer.value;
> > > +       fst->speed = obj->package.elements[2].integer.value;
> > > +
> > > +       status = 0;
> > > +err:
> > > +       kfree(obj);
> > > +       return status;
> >
> > There is some confusion regarding the error return values in this
> > function, would be good to fix it while doing this.
> >
> Let me check that.
>
> > > +}
> > > +
> > > +static int fan_get_state_acpi4(struct acpi_device *device,
> > > unsigned long *state)
> > > +{
> > > +       struct acpi_fan *fan = acpi_driver_data(device);
> > > +       struct acpi_fan_fst fst;
> > > +       int status;
> > > +       int control, i;
> > > +
> > > +       status = fan_get_fps(device, &fst);
> > > +       if (status)
> > > +               return status;
> > > +
> > > +       control = fst.control;
> > > +
> > > +       if (fan->fif.fine_grain_ctrl) {
> > > +               /* This control should be same what we set using
> > > _FSL by spec */
> > > +               if (control > 100) {
> > > +                       dev_dbg(&device->dev, "Invalid control
> > > value returned\n");
> > > +                       return -EINVAL;
> >
> > Why don't we fall back to the other method in this case?
> We can.
>
> >
> > > +               }
> > > +
> > > +               *state = control / (int)fan->fif.step_size;
> >
> > Do we care about rounding errors?
> >
> > Say control is 8 and step_size is 9.  Should this count as 0 or as 1?
> >
> We will not set control value to 8 in this case, so we shouldn't read
> 8. But if firmware setup at boot then it will be 0. The compensation to
> reach 100 is at last step which is allowed.
>
> If step size is 9
>
> thermal sysfs will display
>         max_state = 100/9 = 11
>
> control         thermal sysfs cur_state
> 0-8             0
> 9-17            1
> 18-26           2
> 27-35           3
> 36-44           4
> 45-53           5
> 54-62           6
> 63-71           7
> 72-80           8
> 81-89           9
> 90-98           10
> 99-100          11
>
> If step size is 10
> thermal sysfs
>         max_state = 100/10 = 10
> control         thermal sysfs cur_state
> 0-9             0
> 10-19           1
> 20-29           2
> 30-39           3
> 40-49           4
> 50-59           5
> 60-69           6
> 70-79           7
> 80-89           8
> 90-99           9
> 100             10
>
>
>
> > > +               return 0;
> > > +       }
>
> [...]
>
> > > -       if (state >= fan->fps_count)
> > > +       if (state > max_state)
> >
> > Say step_size is 9, so max_state is 11.  state == 12 would still be
> > valid, no?
> We are presenting thermal sysfs max_state as 11 in this case, so
> state 0-11 are valid. To reach 100, the spec allows to compensate the
> last step to reach 100%. So state 11 is 100% not 99% as in the above
> table.
>
> If we present max_state as 12 then also user space can't choose max
> than 12, so (state > max_state) will be still an error.
>
> If we present max state as 12 then in the above table:
> control         state
> ----------------------
> 90              10
> 99              11
> 100             12
>
> Then last state will increase control value by 1.

OK, so the code below can do

value *= fan->fif.step_size;
if (value + fan->fif.step_size > 100)
        value = 100;

and max_size is still not needed IIUC.

>
> >
> > >                 return -EINVAL;
> > >
> > > -       status = acpi_execute_simple_method(device->handle, "_FSL",
> > > -                                           fan-
> > > >fps[state].control);
> > > +       if (fan->fif.fine_grain_ctrl) {
> > > +               int rem;
> > > +
> > > +               value *= fan->fif.step_size;
> >
> > And you don't need the max_state computation for this, it's only
> > necessary to cap value at 100.  In which case you also wouldn't need
> > rem etc.
> For above example to set the state 11 for 100 for step size 9. If
> max_state is chosen as 12 then we can just cap.
>
> >
> > > +
> > > +               /*
> > > +                * In the event OSPM’s incremental selections of
> > > Level
> > > +                * using the StepSize field value do not sum to
> > > 100%,
> > > +                * OSPM may select an appropriate ending Level
> > > +                * increment to reach 100%.
> > > +                */
> > > +               rem = 100 - value;
> > > +               if (rem && rem < fan->fif.step_size)
> > > +                       value = 100;
> > > +       } else {
> > > +               value = fan->fps[state].control;
> > >
>
> [...]
>
> > > +       if (!fan->fif.step_size)
> > > +               fan->fif.step_size = 1;
> > > +       /* If step size > 9, change to 9 (by spec valid values 1-9)
> > > */
> > > +       if (fan->fif.step_size > 9)
> >
> > I would do "else if" here, because both the above conditions cannot
> > hold at the same time.
> OK
>
> >
> > > +               fan->fif.step_size = 9;
> > >  err:
> > >
>
> [...]
>
> > > +       sysfs_attr_init(&fan->fine_grain_control.attr);
> > > +       fan->fine_grain_control.show = show_fine_grain_control;
> > > +       fan->fine_grain_control.store = NULL;
> > > +       fan->fine_grain_control.attr.name = "fine_grain_control";
> > > +       fan->fine_grain_control.attr.mode = 0444;
> > > +       status = sysfs_create_file(&device->dev.kobj, &fan-
> > > >fine_grain_control.attr);
> >
> > I would split the creation of the new attributes into a separate
> > file,
> > for clarity (and to help the review somewhat).
> >
> We can move all the attributes including the current one to a new file.
>
> Thanks,
> Srinivas
>
