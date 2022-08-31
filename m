Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0315A8680
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiHaTMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiHaTMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:12:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E262DD9D60;
        Wed, 31 Aug 2022 12:12:44 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l3so15002151plb.10;
        Wed, 31 Aug 2022 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=J8+gw0Ed2BKWKNTM6I+2z6oJ3D/Q+GyJQau9gr2e+74=;
        b=TIm6eifYCXYq/PDBPG8Rj+J5qLJhCxQactVwc3wazhmU9BLD+RTNNfM2Vgu7DFADzv
         5629vKQ+L2ehtlNMrHY34I0XhzNSoBMj28Pbe+9X6pcFX8lFXaCDflqbo9v93mEnEDJn
         7EQJjvNAj2ZZelg6D3r5jtXj/HmhzbKNawgYU37IVEGucJxgfcZf0mpIdg3iql/CnGti
         W5ss01iNL3B/OyxMMRPBZ/HV7SvbOpSmTWTvvyeEofWvsi53RIJ+273HFwZ4SkTojNb+
         UcCMwxU/GrpFvHyUpn3nE0suJZ/ImQyRZzztKbBIfIuLzB9sQeIfzZJ50EZrVeVzu2+l
         tpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=J8+gw0Ed2BKWKNTM6I+2z6oJ3D/Q+GyJQau9gr2e+74=;
        b=E8yutALp52Gie5rpEYnp0iGnzLrIKNsWPvD/P2KNcAqtYF5txD1F+UOj3J7qgsOP9P
         zC0NvcGD1KuebkhAvJ5FR/qinHTaKWovnr677+DSP+aXPCyR1XPZdMBzn3NupOCT7G26
         I7s5AhWEAfwSEUeYQ4A9ZUdyXznWHoq0iu/epiO3p87DUXlcmO2YvSsHns+CziTjpdxv
         mJiCyByDDXAbLveFjdPnvIVdH09IDaW9WKCrDIxIzIPSeOuH0na2PtjRLee/vL+HxfUB
         Qwa78pAQYlvMe/55zXCA3wJeoPAt8v3mMBtwkIWHJR97tAf0YcnZGpQwwA3cFf/Aojnd
         ehmQ==
X-Gm-Message-State: ACgBeo0yDyjOzVNVAuD2J6VJ8LW4zD/Vk7WjFA5VnWKG5o0gYkJhuZ05
        zXu4Qf2RvmaPluDwSDYpbqw=
X-Google-Smtp-Source: AA6agR7zHOg4Ib5yW645lx9oyZjDhbo86Yl2jtZwt70PO5wWt4Qqzk4e4xqVhXE0ZUim6dT9/siaxg==
X-Received: by 2002:a17:902:b217:b0:172:bd6c:814d with SMTP id t23-20020a170902b21700b00172bd6c814dmr27201253plr.55.1661973164211;
        Wed, 31 Aug 2022 12:12:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2488:79db:897a:5de7])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709027e4a00b001752ffe92absm3429677pln.91.2022.08.31.12.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 12:12:43 -0700 (PDT)
Date:   Wed, 31 Aug 2022 12:12:41 -0700
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
Message-ID: <Yw+yqbaTi04Ydgkq@google.com>
References: <20220830231541.1135813-1-rrangel@chromium.org>
 <20220830171332.1.Id022caf53d01112188308520915798f08a33cd3e@changeid>
 <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h10wrurjYG50dA+pCfRtNDqN=c8odQ0p6HJRnOyJh7KA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:01:12PM +0200, Rafael J. Wysocki wrote:
> On Wed, Aug 31, 2022 at 1:16 AM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > The Elan I2C touchpad driver is currently manually managing the wake
> > IRQ. This change removes the explicit enable_irq_wake/disable_irq_wake
> > and instead relies on the PM subsystem. This is done by calling
> > dev_pm_set_wake_irq.
> >
> > i2c_device_probe already calls dev_pm_set_wake_irq when using device
> > tree, so it's only required when using ACPI. The net result is that this
> > change should be a no-op. i2c_device_remove also already calls
> > dev_pm_clear_wake_irq, so we don't need to do that in this driver.
> >
> > I tested this on an ACPI system where the touchpad doesn't have _PRW
> > defined. I verified I can still wake the system and that the wake source
> > was the touchpad IRQ GPIO.
> >
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> 
> I like this a lot [...]

I also like this a lot, but this assumes that firmware has correct
settings for the interrupt... Unfortunately it is not always the case
and I see that at least Chrome OS devices, such as glados line (cave, chell, sentry,
ect) do not mark interrupt as wakeup:

src/mainboard/google/glados/variants/chell/overridetree.cb

                        chip drivers/i2c/generic
                                register "hid" = ""ELAN0000""
                                register "desc" = ""ELAN Touchpad""
                                register "irq" = "ACPI_IRQ_LEVEL_LOW(GPP_B3_IRQ)"
                                register "wake" = "GPE0_DW0_05"
                                device i2c 15 on end

I assume it should have been ACPI_IRQ_WAKE_LEVEL_LOW for the interrupt
to be marked as wakeup.

(we do correctly mark GPE as wakeup).

So we need to do something about older devices....

-- 
Dmitry
