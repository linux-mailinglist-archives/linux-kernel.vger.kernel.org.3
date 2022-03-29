Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200AC4EB5A9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiC2WNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiC2WNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:13:10 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A891868A2;
        Tue, 29 Mar 2022 15:11:27 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id p21so8773457ioj.4;
        Tue, 29 Mar 2022 15:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvt1ivDFOdD3T0k6kk1O9V6/h6xEBeJye/Lcnr3Wtgs=;
        b=jmorP6U+4/mkZFDLTy8a2AIY8t3+v+BlxhIf16GAtjim+hddTxz80mCZ+1WpRvmg9k
         aALH/JZJi68TIL6AJajr1vd55oN/Ol9erU7wjoZYdK/WvsFP8LcuLeALcrEyol2luT9p
         TV9cHolCf/7JIq1Q5xPg2bx59D3Gjqhut3s77iWD92FbQPiNgqOpvTYmVERRPvgFmOH2
         QMS8jS4aM4PSwpVkwcQbekSGD+t+z5cWH8Jymt42tL9cYAYtEET+PNSoctPooehZCQL/
         0MJSA8ppQ7JtPQUvQ0TqJt8Dt3MwOiaJEr4YcV5Qbb4MpplfQ26PSgo60zk3yLLZA/M/
         wKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvt1ivDFOdD3T0k6kk1O9V6/h6xEBeJye/Lcnr3Wtgs=;
        b=E8DAfU8HdLlFX5F+Jza8duEcuahnLhKeOg+oGI0w1ttIsfGhLiLHc0ItEDCvSOl4wc
         qdUA/xF7X6iOz9krprdKIW8yMUu9BbyYXsipXMV39dU1Ql3xySy7RrBhy6AaIKIf6TGR
         kE2xxBOAfvHv+KbVkyE/oCyrbaaitooknnSJP4TQllTSDn2IDZALTbpKtiAy0fEfHprK
         DipdeTfk9QNednADWpAej0ndTRaRgU1yIewPHMGU04HEe+JE/ZkPK5oYHFHOQ3NJ3CJp
         4QUrTK3Cr9iL73o5MlNz62R64NStXbYfe63vHVX6hpHzMDvSqn9Q3bkm4pESZrNJQq+d
         V5fg==
X-Gm-Message-State: AOAM531cNwmsEY0OyGL99F1TcxutecvYiAc33NRH2TbVdBwtTzUjQDM1
        VByLtkNOLlkyYbsH5WG6f+zLPCl1Rbq7rkQXe4E=
X-Google-Smtp-Source: ABdhPJzcldOBKyh1ITzThHZ4gr+CKCy4zYmwM3nJkUKVCCQAFtzglJSew2gaoJGSdN7/2Rc/IRAA1rox0TQ19N2xb1c=
X-Received: by 2002:a6b:e40a:0:b0:64c:8ce1:3757 with SMTP id
 u10-20020a6be40a000000b0064c8ce13757mr3316281iog.106.1648591886519; Tue, 29
 Mar 2022 15:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220327121404.1702631-1-eugene.shalygin@gmail.com>
 <20220327121404.1702631-3-eugene.shalygin@gmail.com> <df43bce6-b1bc-1abc-307b-878ee7acb261@roeck-us.net>
In-Reply-To: <df43bce6-b1bc-1abc-307b-878ee7acb261@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Wed, 30 Mar 2022 00:11:15 +0200
Message-ID: <CAB95QASgzUSaLjZuxWauiSvNK7Or=1Kz8htJcjWqU+HrRutvJg@mail.gmail.com>
Subject: Re: [PATCH 2/4] hwmon: (asus-ec-sensors) implement locking via the
 ACPI global lock
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     darcagn@protonmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, 29 Mar 2022 at 23:23, Guenter Roeck <linux@roeck-us.net> wrote:

> > +/* Moniker for the ACPI global lock (':' is not allowed in ASL identifiers) */
> > +#define ACPI_GLOBAL_LOCK_PSEUDO_PATH ":GLOBAL_LOCK"
> > +
>
> That needs to be documented.

Do you mean a note in the /Documentation/..../...rst or adding details
here? There is an additional bit of information on this identifier
below, in the ec_board_info struct declaration.

> There is some type confusion in the above lock functions. Some return
> ACPI error codes, some return Linux error codes. Please make return
> values consistent.
>
> Also, why use mutex_trylock() instead of mutex_lock() ? This is
> unusual since it will result in errors if more than one user
> tries to access the data (eg multiple processes reading sysfs
> attributes at the same time), and thus warrants a detailed
> explanation.
OK.

> > +     struct lock_data lock_data;
> > +     /* number of board EC sensors */
> > +     u8 nr_sensors;
>
> Ok, I must admit I am more than a bit lost. In patch 1/4
> you removed this variable (and argued that removing it was
> for "deduplication"), only to re-introduce it here.
> Sorry, I don't follow the logic.

Sorry for that. This is my mistake which I tried to warn you about in
my first reply to the email with this patch.

> > +     if (!mutex_path || !strlen(mutex_path)) {
>
> When would mutex_path be NULL ?
When it is set to NULL in the board definition struct ec_board_info.

> > +             if (ACPI_FAILURE(status)) {
> > +                     dev_err(dev,
> > +                             "Failed to get hardware access guard AML mutex"
> > +                             "'%s': error %d",
>
> Please no string splits. And the negative impact can be seen here:
> No space between "mutex" and "'%s'".

Yes, of course.

> >               dev_warn(dev,
> > -                     "Concurrent access to the ACPI EC detected.\nRace condition possible.");
> > +                     "Concurrent access to the ACPI EC detected.\n"
> > +                     "Race condition possible.");
>
> Why this change, and how is it related to this patch ?
Same as above, will be corrected.

Thank you,
Eugene
