Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF535960D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiHPRNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 13:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbiHPRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:13:38 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789D7FD3A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:13:34 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o3so9791481ple.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=nCnzPY6Zh9VdSsRKwhjox/WjI1k8bZC9jPf83kIBEEk=;
        b=HTfIRePpzriHYdTea6DPwsWvn5y7QXMY8OVfQqwJlLpcZ+tVonA1BaB3HbImWENSah
         reUGQ3FY4VDi/URRoQFsKIJYDFXa7LtbZKpLNEMks8xGJ+BdmWV94LfdJ/9q9aCFR1EZ
         VDkGtT6lwdjDVih7UFgGzSCOzZORYGs0DgvhwXa2zLSXz4J1PccV8OcenqD6PSPsF0nd
         zTO/Q3gmzfQz6U576HV6fOyurzdW4TMSx7r6cDpJpNmW3+JcO2pYtkoGR+3Q4KSzGH+y
         1J4rISS3nLnG5Y6eKv7HRSVhzDYiZj+8YkeKB4D3s8jdh1VS2r7QDkWQotQAptmi8cKn
         V5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nCnzPY6Zh9VdSsRKwhjox/WjI1k8bZC9jPf83kIBEEk=;
        b=Nly+EDsmZfX2X93NCXlE1c4Yen4/Hj4WvkFe0AzJjti2dSar0QYCzXXjUNRkpttHf2
         Aqkbyd4eLKVx239eKynuDp7e2C8dFUJsbEL6jqb4ei+TvrfY8v/jBDL6I09knyo4/z/6
         goiCP95qMZPUgJD52FIMUsu9O3qkeQl3toQSeduQiVbGD+07KDpTwgsoRQAT3CclOjTE
         p2UTSLDVhttKlnP7q+013ZjW/oQIez4VpxnvDuk5OtW1WYvqQAybsAPv8aLv6VK1a4l4
         Dik5dOe1mWcTSWZCvtJU5SrP8cuYEBkD5JPCo02RX5j3mvyd7oauTTpjvKSvT5XCqKVU
         zBVQ==
X-Gm-Message-State: ACgBeo0UKhzAMZp43y0vionLqqVzktEfih3mWnpzHMNic49Duvq8zuLM
        VLEU6tI9IlT//Bf4DDPvvHqGFQ==
X-Google-Smtp-Source: AA6agR5L/kCG6++/8HFb3cejkYGUqynoOmOraywNSR1IjQL8jDmOhtSQz5ZOi6O2lTVdIfpucPzXww==
X-Received: by 2002:a17:90a:4801:b0:1fa:98ec:fa2 with SMTP id a1-20020a17090a480100b001fa98ec0fa2mr3521502pjh.41.1660670013710;
        Tue, 16 Aug 2022 10:13:33 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:df29:644b:8119:e30a])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b0016e808dbe55sm9401312plc.96.2022.08.16.10.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:13:33 -0700 (PDT)
Date:   Tue, 16 Aug 2022 10:13:28 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>, stable@kernel.org,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] driver core: Fix bus_type.match() error handling
Message-ID: <YvvQOBk9T3J1uX8k@google.com>
References: <20220815211919.2028890-1-isaacmanjarres@google.com>
 <20220816042507.GB1108868@roeck-us.net>
 <YvsoYzIhOtX9DOi2@google.com>
 <20220816111311.GC1108868@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816111311.GC1108868@roeck-us.net>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 04:13:11AM -0700, Guenter Roeck wrote:
> On Mon, Aug 15, 2022 at 10:17:23PM -0700, Isaac Manjarres wrote:
> > On Mon, Aug 15, 2022 at 09:25:07PM -0700, Guenter Roeck wrote:
> > > > v1 -> v2:
> > > > - Fixed the logic in __driver_attach() to allow a driver to continue
> > > >   attempting to match and bind with devices in case of any error, not
> > > >   just probe deferral.
> > > > 
> > > > Guenter,
> > > > 
> > > > Can you please give test this patch to make sure it still works for you?
> > > > 
> > > 
> > > Not as well as v1. I still see the clk crash with versatileab, and imx25-pdk
> > > emulations now stall during boot when trying to boot from usb.
> > > 
> > > Guenter
> > Thanks for trying the patch out. This patch isn't meant to fix the clk
> > crash that you mentioned on another thread. I had made the following patch for
> > that: https://lore.kernel.org/lkml/YvqTvuqSll30Rv2k@google.com/. Have
> > you been able to give that a shot yet? If not can you please test with the
> > patch in this e-mail and that patch?
> > 
> 
> No, sorry, I missed that one. It does not apply, though - it is whitespace
> corrupted. I tried to fix it up, but that failed.

When applying the patch, can you please try with
git apply --ignore-whitespace ? That worked for me.
> 
> > Did you test imx25-pdk emulations with just v1 of this patch previously?
> > 
> 
> I am quite sure I did because it is a single setup.
> 
That's odd. Is this something that I can try out on qemu? If so, can you
please share the qemu commandline so I can take a look?

Thanks,
Isaac
