Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EF64DB921
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 21:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353208AbiCPUFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbiCPUE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 16:04:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08822CCA;
        Wed, 16 Mar 2022 13:03:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t11so4517090wrm.5;
        Wed, 16 Mar 2022 13:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xRrmSaXTPuHNH4vczPmmM5RurjEif4JresYAJudYvWc=;
        b=FqfD0qVQyY2JzhSPaxqS+ifkhnrgmFYU8pFZiQ5Ld/+ajw2zlH3GxSV49hEgPXm2wp
         QH7feBbRLhu/He4VjdQ6QDME1HBxtBUCBB88Bu7xziemX5wIBBXic1xJWuOIuDiXgnBg
         mfohjMUO82cePSELJ7ANo6/q/IZTc2BmK9hB2PcDLWjlo2JAKJEaILrqAO5KbX7lyw7W
         WeFdd6YuuH3/puhFwFRu1RwRadoeZd7XLBoQdz46Tmj4vABMEA8A/1gtHoqWBposDlws
         lfI8KvHTvsRdIS2VuX2fVZasA+oz7bMpHfRUTKcBDqFZhOj1QImcT1SIyQI++DGdjces
         RhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xRrmSaXTPuHNH4vczPmmM5RurjEif4JresYAJudYvWc=;
        b=R3x/LkoDb/z0jRmBf+IMDIvPUNq974fgbkYRXMvX/gX0ll2vCsZxAZ6pPU+9m1H0Za
         7KeEgQSfxbzlh9AjavSTtBhbFsSoFPpd2YZbMuuyIGAGUbCf5exbcr0mGjymntijepIf
         E1ZmxNe7gVTKEqhukvxsyrDtdlsPumPAiyPosU83f7HEDSJzpOP0gONkB+nsm1jiNHbC
         O0LPbPkJqqkx2YhiC9lGw8jGl1hP7MRWXmgp/TVCf/eAFvuigWD6NP/z6IILIcdt5xLq
         4E5pbt4r/B+QWIIwS8J+mWDiEcRNTYOXBX3zxZ4CLXIX90x9xvKnz6O1txmmpI9puZWx
         mN1A==
X-Gm-Message-State: AOAM5324nWvSbW1WmHJcpvCtJ4gaE547Z0g2c7BhgGIQ7zk0O4TJz91j
        QuWTzntWKa61yi2axmYwvvsMlvCYNXeqWNnxxU275QPqZPw=
X-Google-Smtp-Source: ABdhPJwe/qOmXM9fRYbfR0TjwFrwz2y+p/GQCaKzJzgfLqeXm63idcDnub/1584eptHtzSB+GwGei7Si0y9PArMPYsY=
X-Received: by 2002:a5d:47a7:0:b0:203:d1b4:8f6 with SMTP id
 7-20020a5d47a7000000b00203d1b408f6mr1298090wrb.36.1647461021390; Wed, 16 Mar
 2022 13:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220311181014.3448936-1-bjwyman@gmail.com> <fa8b2d9f-e5c9-73f4-3916-84e370748687@roeck-us.net>
In-Reply-To: <fa8b2d9f-e5c9-73f4-3916-84e370748687@roeck-us.net>
From:   Brandon Wyman <bjwyman@gmail.com>
Date:   Wed, 16 Mar 2022 15:03:05 -0500
Message-ID: <CAK_vbW2S07+S8+PrQnBLjvXYnLBXU06FHBvfM2zaT6RYx9HO+g@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs entry
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Joel Stanley <joel@jms.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Eddie James <eajames@linux.ibm.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 11:36 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/11/22 10:10, Brandon Wyman wrote:
> > Add a clear_faults write-only debugfs entry for the ibm-cffps device
> > driver.
> >
> > Certain IBM power supplies require clearing some latched faults in order
> > to indicate that the fault has indeed been observed/noticed.
> >
>
> That is insufficient, sorry. Please provide the affected power supplies as
> well as the affected faults, and confirm that the problem still exists
> in v5.17-rc6 or later kernels - or, more specifically, in any kernel which
> includes commit 35f165f08950 ("hwmon: (pmbus) Clear pmbus fault/warning
> bits after read").
>
> Thanks,
> Guenter

Sorry for the delay in responding. I did some testing with commit
35f165f08950. I could not get that code to send the CLEAR_FAULTS
command to the power supplies.

I can update the commit message to be more specific about which power
supplies need this CLEAR_FAULTS sent, and which faults. It is observed
with the 1600W power supplies (2B1E model). The faults that latch are
the VIN_UV and INPUT faults in the STATUS_WORD. The corresponding
STATUS_INPUT fault bits are VIN_UV_FAULT and Unit is Off.

>
> > Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
> > ---
> > V1 -> V2: Explain why this change is needed
> >
> >   drivers/hwmon/pmbus/ibm-cffps.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> > index e3294a1a54bb..3f02dde02a4b 100644
> > --- a/drivers/hwmon/pmbus/ibm-cffps.c
> > +++ b/drivers/hwmon/pmbus/ibm-cffps.c
> > @@ -67,6 +67,7 @@ enum {
> >       CFFPS_DEBUGFS_CCIN,
> >       CFFPS_DEBUGFS_FW,
> >       CFFPS_DEBUGFS_ON_OFF_CONFIG,
> > +     CFFPS_DEBUGFS_CLEAR_FAULTS,
> >       CFFPS_DEBUGFS_NUM_ENTRIES
> >   };
> >
> > @@ -274,6 +275,13 @@ static ssize_t ibm_cffps_debugfs_write(struct file *file,
> >               if (rc)
> >                       return rc;
> >
> > +             rc = 1;
> > +             break;
> > +     case CFFPS_DEBUGFS_CLEAR_FAULTS:
> > +             rc = i2c_smbus_write_byte(psu->client, PMBUS_CLEAR_FAULTS);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> >               rc = 1;
> >               break;
> >       default:
> > @@ -607,6 +615,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
> >       debugfs_create_file("on_off_config", 0644, ibm_cffps_dir,
> >                           &psu->debugfs_entries[CFFPS_DEBUGFS_ON_OFF_CONFIG],
> >                           &ibm_cffps_fops);
> > +     debugfs_create_file("clear_faults", 0200, ibm_cffps_dir,
> > +                         &psu->debugfs_entries[CFFPS_DEBUGFS_CLEAR_FAULTS],
> > +                         &ibm_cffps_fops);
> >
> >       return 0;
> >   }
>
