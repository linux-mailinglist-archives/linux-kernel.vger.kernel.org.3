Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC659A82A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 00:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiHSWIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 18:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiHSWIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 18:08:13 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51922DAB;
        Fri, 19 Aug 2022 15:08:10 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i7so4210830qka.13;
        Fri, 19 Aug 2022 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=t7+zdBcdaf9omNNLA5zpiw0uL/86fti3ZA7dKW43iwc=;
        b=GY7TlHLOLnCrdBD1l/y6qMU9YX+p/r1VFg/e8hQkP+QFmb2vvWfvh5W7uaMWwDi2kX
         iRFU6pb0q6JhD7S4/do1njqaPU3AtQ+w/0V08RxDWnx/73/ZvBmHnOC536HCEhzbmkYZ
         7pd42HMJHK05i3Ta8wn8vEI3pdME2+52aqSizG4lmc4zInkr+LGes/DFejNgvIrmRKiA
         CEbkmXmLDFwF6iyrOcmaEwFOnniv1zZiMe8sQKy6Q+H+UjJV/sVFOWMGw8dClG0ACqrq
         1iNUjJtSPznL2Xmvno13M60yIs9zreo/grptGqybgfgRT39G8ETlCuSobF6xZGC2Oynv
         0XRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=t7+zdBcdaf9omNNLA5zpiw0uL/86fti3ZA7dKW43iwc=;
        b=B596Qgq3k/hmm3pAmyDANuzCBU2k+ql8r6JOXAzz7rB1BOx33LiAPgRxIUUd1+OcIk
         +re7kihRZinOOVic81IGgDpFDSyCcCZq02Nsaf9Z/HOuOG0Kt3gL/DzZcur5BDkanHHq
         TrFKU8egxebYTNmfnZ5UZDAxUEYy/F9RZ+iUEqmPiba9eE2cymPLY93Vc4Of6Zj5DUte
         5e/yJgC/SGb30uPCB6YUJqMId1YKAyfmGVGt9SHw5NbTZoDy7pWvU2RCFf0nr8zwzyo1
         OEEJOu97u9POc2NJbeQMNB4riu2muS4Jaq9KTjnGhgI1sQ1juIA0FOIaorAsk1LQf5hN
         xEcA==
X-Gm-Message-State: ACgBeo2AmraLtjrLrwAMBrrNEqcUfjTVN52ZIOVakE9bkUWwzDrBsY0f
        dWnqCDIcCHfnKjpcCrbeRLFau+LoXaaEJMf1Np6fzTczfLBHuQ==
X-Google-Smtp-Source: AA6agR5tLClgDIi0ZVs6REMDO1onBYeKRH2xHpGGzC2aIw5HcXDCxeldU9SQrMmaQCBhCE32uN7WNCkEuK309QKXFpk=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr6500254qkf.320.1660946889383; Fri, 19
 Aug 2022 15:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220730125024.87764-1-andriy.shevchenko@linux.intel.com>
 <20220818232256.GA3505808@roeck-us.net> <CAHp75Vc5CtOwFFJxLEe2kNTpU0xqWmcwDLAYtFgkhJVx7KvwqA@mail.gmail.com>
 <20220819130339.GA3108215@roeck-us.net>
In-Reply-To: <20220819130339.GA3108215@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 01:07:33 +0300
Message-ID: <CAHp75Vc=Y8gVuUXmOcj=2nqzNBQyuvjPwNAvfhVvrCnW6oGwVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hwmon: (iio_hwmon) Make use of device properties
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>
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

On Fri, Aug 19, 2022 at 4:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Fri, Aug 19, 2022 at 12:50:46PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 19, 2022 at 2:52 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > On Sat, Jul 30, 2022 at 03:50:24PM +0300, Andy Shevchenko wrote:

...

> > > > Add mod_devicetable.h include.
> > > >
> > > What does that have to do with this patch ?
> >
> > See below.
> >
> > > > +#include <linux/mod_devicetable.h>
> >
> > > > -#include <linux/of.h>
> >
> > The of.h implicitly included missed headers. The mod_devicetable.h is
> > necessary when we drop of.h. OTOH I haven't checked if
> > mod_devicetable.h is still included indirectly. Either way the correct
> > approach is to include mod_devicetable.h since we use a data type from
> > it (of_device_id IIRC).
> >
> Something like
>
> "Include mod_devicetable.h explicitly to replace the dropped of.h which
>  included mod_devicetable.h indirectly"
>
> might be useful.

Sure, I will add it in v2.
Thanks for review!

-- 
With Best Regards,
Andy Shevchenko
