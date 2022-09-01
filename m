Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823625A8EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 08:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiIAG6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiIAG56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 02:57:58 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BEB0A3D0F;
        Wed, 31 Aug 2022 23:57:57 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 828C580A8;
        Thu,  1 Sep 2022 06:50:31 +0000 (UTC)
Date:   Thu, 1 Sep 2022 09:57:55 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tim Van Patten <timvp@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
Message-ID: <YxBX8+7VwyHZc0+5@atomide.com>
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
 <CAHQZ30BTYEYEAGjwsbuiYuYGhpFtQy_AEP66v3trdTzY_DRUOQ@mail.gmail.com>
 <CAJZ5v0gS6U6v-CEPNhgoj=f5E3q1T_Z8vOe2qokyHw4qeVhTsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gS6U6v-CEPNhgoj=f5E3q1T_Z8vOe2qokyHw4qeVhTsQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rafael@kernel.org> [220831 18:35]:
> On Wed, Aug 31, 2022 at 8:14 PM Raul Rangel <rrangel@chromium.org> wrote:
> >
> > On Wed, Aug 31, 2022 at 12:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> > > >
> > > > The Elan I2C touchpad driver is currently manually managing the wake
> > > > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > > > and instead relies on the PM subsystem. This is done by calling
> > > > dev_pm_set_wake_irq.
> > > >
> > > > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > > > tree, so it's only required when using ACPI. The net result is that this
> > > > change should be a no-op. i2c_device_remove also already calls
> > > > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> > > >
> > > > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > > > defined. I verified I can still wake the system and that the wake source
> > > > was the touchpad IRQ GPIO.
> > > >
> > > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > >
> >
> >
> > > I like this a lot, but the assumption in the wakeirq code is that the
> > > IRQ in question will be dedicated for signaling wakeup.  Does it hold
> > > here?
> >
> > The wakeirq code defines two methods: `dev_pm_set_wake_irq` and
> > `dev_pm_set_dedicated_wake_irq`.
> > The latter is used when you have a dedicated wakeup signal. In this
> > driver it's currently assumed
> > that the IRQ and the wake IRQ are the same, so I used `dev_pm_set_wake_irq`.
> >
> > This change in theory also fixes a bug where you define a dedicated
> > wake irq in DT, but
> > then the driver enables the `client->irq` as a wake source. In
> > practice this doesn't happen
> > since the elan touchpads only have a single IRQ line.
> 
> OK, thanks!
> 
> Please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patch.

Looks good to me too:

Reviewed-by: Tony Lindgren <tony@atomide.com>
