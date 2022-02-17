Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E094BA8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbiBQSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:43:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbiBQSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:43:43 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A1E5131F;
        Thu, 17 Feb 2022 10:43:27 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id q8so4811771iod.2;
        Thu, 17 Feb 2022 10:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdYgdQe4oczZK33AfyD+pmbhRlarULisZsDe4vobqxg=;
        b=DeWAwZZqus9lRrZ+u8FOuSEDBcXyqA5DUgD6GrHpNf44cGiNE9fgkl1FrXrnmGjfBe
         Y4cWjV1WUjXBgD7DmLxd/ONfzLyVVk0Si7ANnIMy8X76Eq37tM7ctnvUgiEpz7GR2RFD
         iKd0o2RBIzn+BW9UwLzFnSJSXrI3ohhAhCVWHbTzCldPwifG2OXMz5o8mGu8doTCs1r9
         qfltEvsp/7QTHucweSdZBUgWcItY1taLeN7gYP8BT+/nZZ/jk4FG6sssaV74ir1A5xhf
         IysQIUqJe1kRU57kiqpoxHwwI8/RZ9Tw3UwNFjeENRjtTjli/Kys20zytw2e4yTEiKJV
         Popg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdYgdQe4oczZK33AfyD+pmbhRlarULisZsDe4vobqxg=;
        b=noerU4Dx4wM+X98QsMb82b/SJ9Lkj/y2ydtWok8Gaparzx1m2Absfw7uZb+DyukWCo
         rKqz0MPDi03rzZ+fKlLZuoJlJ/8STmCVL3vOGeorSxpyeFOG4WA2/bsOSCHmDXzBGKVb
         cf2wLbQUfPDuaIv9IPbOZU7aw9daWuF47Ht4MHYub2BqqBpdXuYUUht6mHEXWiW+YtGE
         +Ezp9GC2AME3hyjKTIcWkxjRugyXdddC4Ohz1FOv6lBu07Dl/WoXbW0jZjSih71HR9HW
         Q1oABMHZuQKNSAty1Dz36pcQeGI+JlgCx8Dzp8iivpb7s1bl82O3geb2lVNXara5kEAe
         eD+A==
X-Gm-Message-State: AOAM533AIVZK+mQAd/qYHJxVm+rX4aBXdA4yCRUqqBU+jotJWDoAyDSY
        eqeQ9CFiAXB4RA9zdrYDd5Jcx4Tcjv5/CziOK80=
X-Google-Smtp-Source: ABdhPJxISherzAJec28qVkLzKLJDkzOcgeSXKA+FxQU/zcvK95BGvfJGEbBSSHxj0g8eg7R37+SFfBtaNodf93WBCpU=
X-Received: by 2002:a02:11c1:0:b0:310:4239:ae67 with SMTP id
 184-20020a0211c1000000b003104239ae67mr2766041jaf.108.1645123405854; Thu, 17
 Feb 2022 10:43:25 -0800 (PST)
MIME-Version: 1.0
References: <20220217072340.2472987-1-eugene.shalygin@gmail.com> <bf18f96a-b9ee-43f0-8b53-fc7d4aa6cf39@roeck-us.net>
In-Reply-To: <bf18f96a-b9ee-43f0-8b53-fc7d4aa6cf39@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Thu, 17 Feb 2022 19:43:14 +0100
Message-ID: <CAB95QASiF=mXcUoBsOwKvtZ8KmVYgNd1bP-5+e0WYifcEzK55w@mail.gmail.com>
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

On Thu, 17 Feb 2022 at 19:26, Guenter Roeck <linux@roeck-us.net> wrote:
> Looks like you did not run checkpatch.

I did (0 errors/warnings/checks). What needs to be corrected?

> Either case, I think you should just drop this function In probe:

Yes, currently that function is tiny, but some tests with motherboards
from other families are done by users and if I add other families, the
information required for each board model will grow and in that case
I'd switch from dmi_system_id array to a custom struct to define all
the board-related data at at the same place, and to save some space in
the module binary, as unused parts of the dmi_system_id array already
take a quarter of the total binary size. So, the function will likely
get some more code soon.

Regards,
Eugene
