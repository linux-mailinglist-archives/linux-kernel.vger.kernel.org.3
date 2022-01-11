Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920DD48B622
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbiAKSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242645AbiAKSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:52:40 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C646C06173F;
        Tue, 11 Jan 2022 10:52:40 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o7so116625ioo.9;
        Tue, 11 Jan 2022 10:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d1ZeXXq1xWjZdp0a/kklqkhFu5pCumiIP9r3pU07RA=;
        b=ixZToSTvKWyoKi8kROyeDiMw1wQ5IFcOJPJFNnsQO6K8WwoM5oXR0oWJXfkGYb186y
         5bNbeamb22HD3vx58AzgbhDhBpxcfMJf7cpa4/8WyF1wZ24A9+K66PNGVl0Oha0RwMB7
         lRWgRlPVgLizHDrAC6wdz6k9AXA7BljTWN2uYfmNceRx2hTmVnCCip+5a57UwxWCob7B
         KVKrfohOqQJ2v9c5mcEqMpMj3Or5LIbJQYkjGD0PERi+6dK6IW9JUPBizq3/M0XHLUES
         KfGBxf32JZ5yJmwfhAi/sKdYsK80P1Nu0Pa3bbHTUl3rhWVqwNoU/NEQGt12w7USeqpb
         8b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d1ZeXXq1xWjZdp0a/kklqkhFu5pCumiIP9r3pU07RA=;
        b=TViz4g30zlzYMSVrSH6YJkSoE5TisJQzOtNDp3THbmspf+VW/brUeMk0WQNtGbqD5V
         sWUVp0oQ/WcnaMrtshvQ6c3DoC4wnibqHNzS265jxwG/15h9LrB1dL+dNvIVaqTOy/bi
         Nev0POBclDdimsiPUM3Uba2RiK8mQNR/iHTTPcVhrlgGb9px0NdgD7A1mC7NejnmEGTO
         i9dVYVZ2X4SZ1w6anBwfxQz0VeeZPoS99vL0iH/UKpSkKWFG9Lwsak1dT2W4SvnKJyuq
         yWVfVf4sLGLLuZXw1kS6EtiPVDvuuYWAW/pBMsBMXSSI8DBbsq7EfFLa6PlG816fsoIJ
         uTrw==
X-Gm-Message-State: AOAM530upPYEIH86zp2/EErvwSHzjwHp7ZVZm1NCEz9zBRe2kL0+bAIP
        oKeuAiYUq7Dc2Cx2lnhY8Y7oRhyzawkhqEfaB/s=
X-Google-Smtp-Source: ABdhPJwivP9fRDpKvRLUdMR7csDsvPZRq6oOhKSUxm/dEZywlXLCLZJwMUYNdFdp1I4bVmWcYuMlJNVE0mavGO+LgbA=
X-Received: by 2002:a05:6638:4090:: with SMTP id m16mr3291604jam.67.1641927160095;
 Tue, 11 Jan 2022 10:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20220111160900.1150050-1-eugene.shalygin@gmail.com>
 <20220111160900.1150050-2-eugene.shalygin@gmail.com> <805dd382-262c-36f0-fcf5-5776223040c8@roeck-us.net>
 <CAB95QATsy2ACgyxWLy2PM2peqoYDEa_j96VNSHBG6GMd+x3LzQ@mail.gmail.com> <050ee3ed-4c30-afb9-d7ce-898d634284be@roeck-us.net>
In-Reply-To: <050ee3ed-4c30-afb9-d7ce-898d634284be@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 11 Jan 2022 19:52:29 +0100
Message-ID: <CAB95QATb_En0KqXRktY99q8UXmosCftMrekpFiAKrAocwFEKmg@mail.gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add driver for ASUS EC
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Just drop it.

OK.
Are there any other edits (want to generate as few new emails as possible)?

Regards,
Eugene
