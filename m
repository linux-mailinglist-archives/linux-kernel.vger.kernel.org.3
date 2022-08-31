Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB85A8692
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiHaTQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiHaTQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:16:55 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BADA3E7;
        Wed, 31 Aug 2022 12:16:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id w88-20020a17090a6be100b001fbb0f0b013so221889pjj.5;
        Wed, 31 Aug 2022 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ZK0vHIfZPri/cAEw3Zdyq0wwULbp0p+CYdJ+uPfD3lw=;
        b=StM2j/K88IgCtG2X5L0R783WzsDO96XJEdMhI6cFDCoHtg+7KSwYtCXTVT8NEtQTwI
         5uoEZThJFr+/oqP+1yJhWry9AibhJnq2SR3FDsypSfEPgrzObELvm0SNp3rKTorhXgT+
         dUQKgmxZCYwlI+FIgQ7IVlthQ+T68lTLKiBjEd3n1QjftSgcMmaBqW6Pe5AAZntxBrxo
         NwnJs/O1TxDzpb7EWwb9fyMrfrW7VOBTByskk+HJ4M+5u54miaML7E6RJYF5EeDEHuw+
         N44KaHDUmo7pn5nUJzBEChmHxuZci5RW1ZZUSobOXZfl35kQPmddOTgk0kxL7Zv+lJQ0
         URAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZK0vHIfZPri/cAEw3Zdyq0wwULbp0p+CYdJ+uPfD3lw=;
        b=DspWGuMb2jM/hkoe80CkfY/edUwADoJiS24eN9NVlRZcNnwmRM0hOGwX3CXzUjUsFO
         UCp4opPAFi11ohLTDnqq2MFKNkf0tpKpNCQWR/oDhIzkzXpfXHsGDNCpcFwSCSNXEL4O
         fP/0fnQRmVkRbqftYy702mWl120547c8Hrg7n9Kqt0bGP/GMmiSg2FNKW4EKzTZg6AoG
         7wOmiOG26dvDEawLb7mqORhzcSFOhYsg75BdGDQ7qWTtYYh1bvRkGnwVZYcO/SIuX0Qv
         AuBDDAqtK90lkVljmkw3Z2r76hDpzoyAjbJlATZlx0SonkNT9/SaGXBmuZNtj7jvrn4H
         yHBw==
X-Gm-Message-State: ACgBeo1fI0tz2vB/IPl385GPvzzHSDsn9VQIKAx0NFAZpoU6+BXPjte2
        EVY6Xq8RuGwV8cLs5Hrzzt8=
X-Google-Smtp-Source: AA6agR7pNWhfE5E6RwFMxPZSIOyo66ySTqc06RTjM2uhWmM5cfckljJKQRDslgj4mIyLQKDW3lWEKw==
X-Received: by 2002:a17:902:ef50:b0:171:516d:d2ce with SMTP id e16-20020a170902ef5000b00171516dd2cemr26104496plx.171.1661973414421;
        Wed, 31 Aug 2022 12:16:54 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b00536f0370db8sm11265802pfv.212.2022.08.31.12.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:16:53 -0700 (PDT)
Date:   Wed, 31 Aug 2022 12:16:51 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Raul E Rangel <rrangel@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        timvp@google.com, "jingle.wu" <jingle.wu@emc.com.tw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] Input: elan_i2c - Use PM subsystem to manage wake irq
Message-ID: <Yw+zo9eUQM+T1eYZ@google.com>
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
 <Yw+yqbaTi04Ydgkq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw+yqbaTi04Ydgkq@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 12:12:41PM -0700, Dmitry Torokhov wrote:
> On Wed, Aug 31, 2022 at 08:01:12PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > The Elan I2C touchpad driver is currently manually managing the wake
> > > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > > and instead relies on the PM subsystem. This is done by calling
> > > dev_pm_set_wake_irq.
> > >
> > > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > > tree, so it's only required when using ACPI. The net result is that this
> > > change should be a no-op. i2c_device_remove also already calls
> > > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> > >
> > > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > > defined. I verified I can still wake the system and that the wake source
> > > was the touchpad IRQ GPIO.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > 
> > I like this a lot [...]
> 
> I also like this a lot, but this assumes that firmware has correct
> settings for the interrupt... Unfortunately it is not always the case
> and I see that at least Chrome OS devices, such as glados line (cave, chell, sentry,
> ect) do not mark interrupt as wakeup:
> 
> src/mainboard/google/glados/variants/chell/overridetree.cb
> 
>                         chip drivers/i2c/generic
>                                 register "hid" = ""ELAN0000""
>                                 register "desc" = ""ELAN Touchpad""
>                                 register "irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
>                                 register "wake" = "GPE0_DW0_05"
>                                 device i2c 15 on end
> 
> I assume it should have been ACPI_IRQ_WAKE_LEVEL_LOW for the interrupt
> to be marked as wakeup.
> 
> (we do correctly mark GPE as wakeup).
> 
> So we need to do something about older devices....

After re-reading the patch I believe this comment is more applicable to
the followup patch to elan_i2c, not this one, which is fine on its own.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
