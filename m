Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2413C4BAA36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245510AbiBQTuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:50:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244989AbiBQTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:50:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273043EF5;
        Thu, 17 Feb 2022 11:49:50 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m8so3062529ilg.7;
        Thu, 17 Feb 2022 11:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzK5esxwKtf3QmXFi7RB++PMzIXUAMKz2NRvQ5MKEaI=;
        b=EhcTn0QU/eiiY9W/4pqfmCWtP1aqNeeOFQiFjNmwIG2A+4Y9cifyV5Q5P/U14YMQ+G
         LII84Odsy3gdt/LpqG5ioA2pPbn7DiwyWaHe7vO/2BfUewUndEyJvAaiynmtMNb/KHzN
         8qMO/TQcTcL+tavqk2kw8Mjsv1eho4SsTqbG/X041K0DG/SMeqy/StDFOZqziM35PukU
         F8BqwzS6T3zOy076/5CZ8xpVEbK3Z/oXUU6/LVSZgN7SpX1DNLVo1WDzSEnhQOL9OJhU
         x5tZkJZFnXdMhU0Ng9D8LxYShhPVi+XTmcAGdvwN2so+ErlbN0eqTriXUtntqorHgQg5
         uwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzK5esxwKtf3QmXFi7RB++PMzIXUAMKz2NRvQ5MKEaI=;
        b=IXwyhAblbe0KsL9TAVoXwbHmDwamy9LUvrxGHVdpcaKsoJJh2FrgbaSlyTZWkPitvy
         ssFJFcKGDeGj1OhyLl+BRw7/2fiRHG9iPNQVwewskGJryKO7l7ZP1qTiCJjH9SyZwtWG
         S19BRD3R7g17EUo9cSWdK5WadCpb1JN+y8Upjf/zk3jd7F7JyQe6IXBZWQEDybmlY0zf
         0LjP1Skta2AQmy8ZmT0+wB/FbNPX98xzSayqK8R1X5kcxdso/AFWIhw2zCAIr0BfYAvw
         zihUKMGtAvk1NIetCq2m5Yz6glf1CdOJJ+ng2s0BtkEOj+rDzKBBWu9WcJ3gsD+LG94T
         oY0w==
X-Gm-Message-State: AOAM530PLx31syXLKEZjMGf3AUpvqoAdIoufYY6AvgY2isJFVVAJ0CiM
        6SBLQDxTez84l/JsL99uPGyE+rYJSHy8/UOOiNg=
X-Google-Smtp-Source: ABdhPJx+vEr7tgoxzCWZbd3TV9zPoXSRZOeL4GOANK/HcO8WBcdHN68CuicWsiWBWi07vMICwkzVtKYLOrR+vkwpYNs=
X-Received: by 2002:a92:cf12:0:b0:2be:3a27:67c7 with SMTP id
 c18-20020a92cf12000000b002be3a2767c7mr3098661ilo.187.1645127390329; Thu, 17
 Feb 2022 11:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217072340.2472987-1-eugene.shalygin@gmail.com>
 <bf18f96a-b9ee-43f0-8b53-fc7d4aa6cf39@roeck-us.net> <CAB95QASiF=mXcUoBsOwKvtZ8KmVYgNd1bP-5+e0WYifcEzK55w@mail.gmail.com>
 <a8e9e6f1-e7a0-d40d-8065-b72f60c72a32@roeck-us.net>
In-Reply-To: <a8e9e6f1-e7a0-d40d-8065-b72f60c72a32@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 17 Feb 2022 20:49:39 +0100
Message-ID: <CAB95QATVnZMQLCU_eTr7=ASVmJ+aYayQGJ0xZ=OtowdhPZQKSw@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) do not print from .probe()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
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

On Thu, 17 Feb 2022 at 20:33, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 2/17/22 10:43, Eugene Shalygin wrote:
> > On Thu, 17 Feb 2022 at 19:26, Guenter Roeck <linux@roeck-us.net> wrote:
> >> Looks like you did not run checkpatch.
> >
> > I did (0 errors/warnings/checks). What needs to be corrected?
> >
>
> Interesting. It appears that the continuation line in the declaration
> confuses it. Otherwise you would get:
>
> WARNING: Missing a blank line after declarations

Added in v2, thank you!

> >> Either case, I think you should just drop this function In probe:
> >
> > Yes, currently that function is tiny, but some tests with motherboards
> > from other families are done by users and if I add other families, the
> > information required for each board model will grow and in that case
> > I'd switch from dmi_system_id array to a custom struct to define all
> > the board-related data at at the same place, and to save some space in
> > the module binary, as unused parts of the dmi_system_id array already
> > take a quarter of the total binary size. So, the function will likely
> > get some more code soon.
> >
>
> Hmm, ok. Wouldn't you still need some kind of dmi match ?

Of course, just not via dmi_first_match():
https://github.com/zeule/asus-ec-sensors/blob/feature/prime-x470-pro-no-dmi/asus-ec-sensors.c#L787

Regards,
Eugene
