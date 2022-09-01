Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9185A9A42
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbiIAO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbiIAO2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:28:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEC66B154;
        Thu,  1 Sep 2022 07:28:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bh13so16542565pgb.4;
        Thu, 01 Sep 2022 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=eFXvBBMNEEghXLQat18msWPtHrh19tRiTeT65ddGseE=;
        b=eOzHQG4b4dp+fdDR3chQsix8YHi0GhSy0VJxAZyOXW5iv4W+uW7IMvCRBnEpGiLKAR
         TrV8/7LFKaL1iIW3CxLpt6mBTdagjJqnJguOh/Uo4uA5vCQCn8p1uhNzB8oyJjXziK9a
         OQBSuJJCUzR1RnD1esKAYNaH/NvtFJ/jnxwooOiXHZ2LfzD8mYoC4ddQTDQMUVcGxVyp
         CMiCec+Fq4B6Y2a18jwc27sFPXi0PwMmzLW/KtjTFICr6rq7p6oAj1O9U0UginPDysKF
         Az1OiFGOWV7jOPMC7H6jwLWBHgF19r8XOwmDrPJs+FvFC0pXxCkYvaYTAp6XccLkySA3
         Mtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eFXvBBMNEEghXLQat18msWPtHrh19tRiTeT65ddGseE=;
        b=NWbM8P+dBsnElBqcDPdvYGqvvhmbnEFkNzbVU/A52WSikTqTKWQ57o3dH+cIvOGhCa
         nDb84OK9MK3AnCzdj9Iz11/uW0CSxDBqlx55uFITwFCzYuHdwL0vNrzf26PbVZZVwFmz
         NOa6AOSzhPWro3qaxL7HGf4Rm03pK4F6k+4K80m7oENixXQYW4EoeF7+P+OIPl0arv91
         Zm7pnPdJlZXAWFRB2G6qdWJTJMpewTOOcODxZnwBZEwhKanXUf8NycnyFpJwEpV/sBge
         ObSr7JUZvRvUGAVBJEd6+/Hd8FA+KnCyxZBv9vZnayBMxKGhFBsjS1EPI18TOdGbhGnL
         /DCQ==
X-Gm-Message-State: ACgBeo12cAwvuz4zL2xdD4S4qm2gbFxPk/bXssR686F8jmEq1TNN1KNe
        oBepjXF8M/OhOKm+DnOcL8Y=
X-Google-Smtp-Source: AA6agR5cl32IkcvGmqpXATSTiFcQrDFUiGCHgqw8oVwL+FoZSwm0VTq36xbA4W+UENHXrDNgFmBlRQ==
X-Received: by 2002:a63:fc11:0:b0:430:41b4:acf5 with SMTP id j17-20020a63fc11000000b0043041b4acf5mr5826867pgi.408.1662042523411;
        Thu, 01 Sep 2022 07:28:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i72-20020a62874b000000b0052e987c64efsm13849428pfe.174.2022.09.01.07.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:28:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Sep 2022 07:28:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>, jdelvare@suse.com,
        robh+dt@kernel.org, p.zabel@pengutronix.de, rtanwar@maxlinear.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, talel@amazon.com, hhhawa@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, ronenk@amazon.com,
        itamark@amazon.com, shellykz@amazon.com, shorer@amazon.com,
        amitlavi@amazon.com, almogbs@amazon.com, dkl@amazon.com
Subject: Re: [PATCH v3 18/19] hwmon: (mr75203) add debugfs to read and write
 temperature coefficients
Message-ID: <20220901142839.GA3477025@roeck-us.net>
References: <20220830192212.28570-1-farbere@amazon.com>
 <20220830192212.28570-19-farbere@amazon.com>
 <Yw9Qq+PIfxgXRIK2@smile.fi.intel.com>
 <646af681-38b0-1268-3798-c5434ca30bee@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <646af681-38b0-1268-3798-c5434ca30bee@amazon.com>
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

On Thu, Sep 01, 2022 at 09:54:21AM +0300, Farber, Eliav wrote:
> On 8/31/2022 3:14 PM, Andy Shevchenko wrote:
> > On Tue, Aug 30, 2022 at 07:22:11PM +0000, Eliav Farber wrote:
> > > This change adds debugfs to read and write temperature sensor
> > > coefficients
> > > - g, h, j and cal5.
> > > 
> > > The coefficients can vary between product and product, so it can be very
> > > useful to be able to modify them on the fly during the calibration
> > > process.
> > > 
> > > e.g.:
> > > 
> > > cat /sys/kernel/debug/940f23d0000.pvt/ts_coeff_cal5
> > > 4096
> > > 
> > > echo 83000 > sys/kernel/debug/940f23d0000.pvt/ts_coeff_g
> > 
> > ...
> > 
> > > +     pvt->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> > 
> > > +     if (!pvt->dbgfs_dir) {
> > > +             dev_err(dev, "Failed to create dbgfs_dir\n");
> > > +             return -EINVAL;
> > > +     }
> > 
> > No, just don't check the return value of debugfs API calls.
> > 
> Do you mean that I should just do:
> debugfs_create_dir(dev_name(dev), NULL);
> Can you please explain why it's OK to ignore the return value?
> 

Because that is how debugfs code is supposed to be implemented.
Other debugfs code checks if the dir parameter passed to it is NULL
and do nothing if it is. This reduces code size overall by avoiding
unnecessary error checks.

Guenter
