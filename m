Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA5C56B452
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiGHITI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiGHITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:19:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8C7694B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 01:19:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n185so11968026wmn.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IRHop/Q9bOB6K90zq0W59vf8hzLmWFwLAu49XupFkZI=;
        b=ZfOQnNvZS+61ImvjHbFW0xLS5SfVP8CadQnWvtcAsmAABylUG+xbGiQ5m1tcni58U6
         nBIp4TUTKnfuNCIaQsY+QVe8g+HsiPEXrUU0RvmeKumauzen1XdEjGJiRjoKFGLfyx83
         usrAYBqO3MqPk43/Gg8gRB54oJHwMgPyop6Ab1fIqaCz1LwWtcxk2myQhwsLrsEAcGY8
         JiSN/NMNyVzDWNMnG2D5qJTLqWkciVZioZ8I35e7cogwcIXJy7bvWZykwL1Iw3AMu6Af
         KZqVKSrXlG1FKOPCaBGV96FdGar0toonEvyP9ljsbg2SmtCw3RMCs8RdzfVyuy5usE1H
         OV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IRHop/Q9bOB6K90zq0W59vf8hzLmWFwLAu49XupFkZI=;
        b=6cDvYGsxXGVeqMWCMKBY3CfX2z2Ate7Nzse8qnbS0ygn3lwS0ke81LyCKBsGwIO04z
         jNZ48FCyb7EumO9ShtNv3wpRG1HAmNsmxd+VEJ+zXPBsKGhrUfabAZAvbC9KbKZBoKBN
         AKxBgGx2zUunJZJwUq60rmaMI/VfRDSIfO+DvibaNOAtWwkfoV3ZOMQHSG2HeYbpOeO8
         09JZ5qydJIUdQBXsuI5YeRS4MnDoZLn2epwu9cZeSs0I48TwGD0yRV2mM/fX50GApvqP
         JfkEGHnUnbCEzFGNhvjAka9gYIvaxVazjgxQLLbauTIBd1IosPPQNhc9Y70hkDF0zHto
         9EOw==
X-Gm-Message-State: AJIora9Iy4NSa3su2WycypWJbkOeQe78vafRLC1UGcjRgJJEOsX2KKZC
        TxOerokdBXz3UBRjNzwggJk+jw==
X-Google-Smtp-Source: AGRyM1tR49BJcx8MfGtbkNemgsXk1vcZaxMude2C65rkYmp+isYP0s1nW+BkZEC/7D+0xnFtQ03P8g==
X-Received: by 2002:a05:600c:3491:b0:3a1:8609:ba7e with SMTP id a17-20020a05600c349100b003a18609ba7emr2284834wmq.79.1657268341602;
        Fri, 08 Jul 2022 01:19:01 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d684b000000b0021badf3cb26sm5436574wrw.63.2022.07.08.01.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 01:19:00 -0700 (PDT)
Date:   Fri, 8 Jul 2022 08:18:59 +0000
From:   Sebastian Ene <sebastianene@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        maz@kernel.org, vdonnefort@google.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v10 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <Ysfoc2YhQCLge1iY@google.com>
References: <20220707154226.1478674-1-sebastianene@google.com>
 <20220707154226.1478674-3-sebastianene@google.com>
 <20220707182737.GE4852@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707182737.GE4852@willie-the-truck>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 07:27:38PM +0100, Will Deacon wrote:
> Hi Sebastian,
> 
> On Thu, Jul 07, 2022 at 03:42:27PM +0000, Sebastian Ene wrote:

Hi Will,

> > This driver creates per-cpu hrtimers which are required to do the
> > periodic 'pet' operation. On a conventional watchdog-core driver, the
> > userspace is responsible for delivering the 'pet' events by writing to
> > the particular /dev/watchdogN node. In this case we require a strong
> > thread affinity to be able to account for lost time on a per vCPU.
> > 
> > This part of the driver is the 'frontend' which is reponsible for
> > delivering the periodic 'pet' events, configuring the virtual peripheral
> > and listening for cpu hotplug events. The other part of the driver is
> > an emulated MMIO device which is part of the KVM virtual machine
> > monitor and this part accounts for lost time by looking at the
> > /proc/{}/task/{}/stat entries.
> > 
> > Signed-off-by: Sebastian Ene <sebastianene@google.com>
> > ---
> >  drivers/misc/Kconfig               |  14 ++
> >  drivers/misc/Makefile              |   1 +
> >  drivers/misc/vcpu_stall_detector.c | 209 +++++++++++++++++++++++++++++
> >  3 files changed, 224 insertions(+)
> >  create mode 100644 drivers/misc/vcpu_stall_detector.c
> 
> Thanks for addressing all of my feedback on v9 so promptly:
> 
> Reviewed-by: Will Deacon <will@kernel.org>
> 
> Just one question on this part:
> 
> > +static enum hrtimer_restart
> > +vcpu_stall_detect_timer_fn(struct hrtimer *hrtimer)
> > +{
> > +	u32 ticks, ping_timeout_ms;
> > +
> > +	/* Reload the stall detector counter register every
> > +	 * `ping_timeout_ms` to prevent the virtual device
> > +	 * from decrementing it to 0. The virtual device decrements this
> > +	 * register at 'clock_freq_hz' frequency.
> > +	 */
> > +	ticks = vcpu_stall_config.clock_freq_hz *
> > +		vcpu_stall_config.stall_timeout_sec;
> 
> It would be quite easy for this to overflow 32 bits, so perhaps it would
> be best to check the values from the DT during probe and fallback to the
> defaults (with a warning) if the result of the multiplication is out
> of range for the 32-bit register.
> 
> What do you think? My review stands in any case, as this shouldn't happen
> in practice with sensible values.
> 

Good point ! I think falling back to defaults in case the values from the
DT exceed a limit is a good approach. I will do that in the next
version.

> Will

Thanks,
Seb
