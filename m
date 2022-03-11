Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021984D5837
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345681AbiCKCju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiCKCjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:39:49 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34611184B43;
        Thu, 10 Mar 2022 18:38:47 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i8so10891505wrr.8;
        Thu, 10 Mar 2022 18:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a7DTeDEbKx5KJQVwJ+AhwwoJQbxNGNy74ssqdwTeGWc=;
        b=A5jA/zf/Z3qsp0jKcMLCJskCu9VJ2wvvcK6Ohyq0JvZGOcv8RqGHSQZ+dktx2ayM19
         /WrgSt75xLxG0fWpRU373ELgPH485foVSzz17U24LLUQ4OMmL9Hx0uBgxuB81xPbvdEf
         jRKUAetojzHExGsxIwKUnFyQxSMUsw5WNKIJnERDsQVXsgwmKU3Ox1pvtPFM4+9qUGLz
         pHugdqNe8mLJuTHVy2FIXwp3q6xjFKP2BqqTYzWQfH2ShPuInbXoIvUlMdtXv2QKJXCx
         CthAu8iY1f8ZwW+06Fqc1cN2xNaAOfvJrcC75yBkL3jtISNN0uJpjZlviGYWd4fsvt3O
         SbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a7DTeDEbKx5KJQVwJ+AhwwoJQbxNGNy74ssqdwTeGWc=;
        b=ijgvoNRYw3eQk1Sr8Aglo/LVlPwEa+d4PQrGeH+DXbqdbs0c4SCcn+GtudLqHb5W9K
         twNVPf7yi1j04V1K6RNEREXKtLZ+fB0tgd3gc8P6jbwGda9BfMZYFbhCZj3UnTIduxqb
         Y5L1+eSyJ2nIi3Gh7u/qENOo4HUsn9z1pIXR40yOntGT/6rPIN7bw8V1mhMg3jnf53os
         hd3X8b6saPtL/D0asyDTLmYYwOqZPkYjyom0qVEuwtHovLtTdiCnppnNBqmtAdlSDzPP
         9pS7tErU+QCsDgLMb+HuuCqjO6+Wa9ePaWB8hDGdmNUHmbVCN3LAeg73Cl6d6S0pf4n2
         L2sA==
X-Gm-Message-State: AOAM533BXHCz37GgdbDWhM2zpZbLKR2JDTdRqa3Y7zSIzU1NIN7AAHNR
        uoHTa9Hlr3z58nP4sPoE9aYd4WfUBBH+jGH2AN+L1eN8Wpo=
X-Google-Smtp-Source: ABdhPJzan+575jWFZNJg0aqxz6vncXWbvUFYtNBVRas43tiHZ7FW5Ne8nNjHpBg4itlF+DqRpszg8Uh33vVb76pxzb0=
X-Received: by 2002:a5d:47ac:0:b0:1fc:f09b:c258 with SMTP id
 12-20020a5d47ac000000b001fcf09bc258mr5765512wrb.618.1646966325578; Thu, 10
 Mar 2022 18:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20220311001858.4166205-1-bjwyman@gmail.com> <3602c1b2-1335-0663-c96a-c524c555ccc9@roeck-us.net>
In-Reply-To: <3602c1b2-1335-0663-c96a-c524c555ccc9@roeck-us.net>
From:   Brandon Wyman <bjwyman@gmail.com>
Date:   Thu, 10 Mar 2022 20:38:10 -0600
Message-ID: <CAK_vbW3ccx-bXzTXGJHj-v1o8f0ehqp8Xf=e_667jaWisAWb-A@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (pmbus/ibm-cffps) Add clear_faults debugfs entry
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

On Thu, Mar 10, 2022 at 7:00 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/10/22 16:18, Brandon Wyman wrote:
> > Add a clear_faults write-only debugfs entry for the ibm-cffps device
> > driver.
> >
>
> This does not explain _why_ this would be needed.
>
> Guenter

I must have chopped that out when I did a squash on the commits I had.

>
> > Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
> > ---
> >   drivers/hwmon/pmbus/ibm-cffps.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
> > index e3294a1a54bb..fca2642a8ed4 100644
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
