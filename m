Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF73596684
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiHQBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238078AbiHQBGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:06:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B9180EA4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:06:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g18so2215300pju.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=QTO5LFk5DPH2+BEtFS5IyQK8KQFw5ow5IIpLWWVQtw0=;
        b=J09656TvhsCnHWhJqnVh70bxKuWE2WqRwTHHzxSmayp+NDr3Qk9c65N15oqGniot9J
         BCJQJVQ0FF3yDVyIH/Ha8UgMtGfmi5WHkNWGqqeSmmvg9lCWTQpY7s0yaBr7ytwktcOG
         mllGiFVstNwmyB1+g4k91f1UzCVCOJYalxph1CEZWfE750Fqeyc27F1xJegoimce+Zch
         8P9wPMtn6kiM0z+t4DWRMNmWFeuQEypBwj16Iuu56ARTMmhNvfh35u+tg4ZPur5Iwqxs
         ngrBmfwp8+/H9mxHwdLzuW8bpuK+y2oMI78/ifI2G53QVkgsPt6zaf9u6V1NqXtTLoJ5
         OsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=QTO5LFk5DPH2+BEtFS5IyQK8KQFw5ow5IIpLWWVQtw0=;
        b=qb/R4yuwf7yX7lOJm4VD0CZkMXzxf7T7VNy+9QhcNodzpwaIAYsUHG/gqK/djHTQAf
         STO/2KZnlKDFkDPE9M2ohZTzvstcTk+ICMB0sPNpjFmAoep6aqDxcPVl7NHrfNSicr3B
         EXTHRoH8ZQT/oseJL73rm79+aMvYHQ/G4sKau2RZ+03+qHLNjy3QsETC2tK1XmK8fxlY
         ruaOdlwszHt81pK3j83fAPGhL99Dst47ebAEEAv16YDE9jQAbL7W2KzfyYE6aznhQftb
         2pjwt19VeurUDQDobLVHDCXS1h85cdmNe0YI42ikG8PpnKa21agA6X9GCIa/XTWX4m6/
         mcwg==
X-Gm-Message-State: ACgBeo1ROmJrnCyM63N8lQfAfMZuHKGI1UMhG7+Bb8vDY28ROYtCmV93
        7pEuFBVVMd3PtmaGOhPcihc=
X-Google-Smtp-Source: AA6agR6HjNH0ADvKypN2sZi7Vm41eZLw0nWmMcKudGwuxMJbIehTBoh8CCvcBKYyCwcXUs4JJcyclg==
X-Received: by 2002:a17:902:e885:b0:16e:c85b:e3bd with SMTP id w5-20020a170902e88500b0016ec85be3bdmr24791965plg.63.1660698363917;
        Tue, 16 Aug 2022 18:06:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k23-20020aa79737000000b0052ac99c2c1csm9090888pfg.83.2022.08.16.18.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:06:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 16 Aug 2022 18:05:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Isaac Manjarres <isaacmanjarres@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <20220817010559.GA1880847@roeck-us.net>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
 <YvvQOBk9T3J1uX8k@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvvQOBk9T3J1uX8k@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 10:13:28AM -0700, Isaac Manjarres wrote:
> On Tue, Aug 16, 2022 at 04:13:11AM -0700, Guenter Roeck wrote:
> > On Mon, Aug 15, 2022 at 10:17:23PM -0700, Isaac Manjarres wrote:
> > > On Mon, Aug 15, 2022 at 09:25:07PM -0700, Guenter Roeck wrote:
> > > > > v1 -> v2:
> > > > > - Fixed the logic in __driver_attach() to allow a driver to continue
> > > > >   attempting to match and bind with devices in case of any error, not
> > > > >   just probe deferral.
> > > > > 
> > > > > Guenter,
> > > > > 
> > > > > Can you please give test this patch to make sure it still works for you?
> > > > > 
> > > > 
> > > > Not as well as v1. I still see the clk crash with versatileab, and imx25-pdk
> > > > emulations now stall during boot when trying to boot from usb.
> > > > 
> > > > Guenter
> > > Thanks for trying the patch out. This patch isn't meant to fix the clk
> > > crash that you mentioned on another thread. I had made the following patch for
> > > that: https://lore.kernel.org/lkml/YvqTvuqSll30Rv2k@google.com/. Have
> > > you been able to give that a shot yet? If not can you please test with the
> > > patch in this e-mail and that patch?
> > > 
> > 
> > No, sorry, I missed that one. It does not apply, though - it is whitespace
> > corrupted. I tried to fix it up, but that failed.
> 
> When applying the patch, can you please try with
> git apply --ignore-whitespace ? That worked for me.

Ok, that worked. With the above patch, the problems with sx1 and versatileab
are gone. However, imx25-pdk fails to shut down when booting from usb
drive. I cross checked that this does not happen without the above patch.

Guenter
