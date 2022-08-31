Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CC35A72E8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiHaAq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiHaAqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:46:35 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5535598A4E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:45:34 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id DDB465FD04;
        Wed, 31 Aug 2022 03:45:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661906731;
        bh=n9fLKdgW9f2XXdObgGzN12Cm/zmLpIRqLh2L2kSmuVo=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=isrmR80H9bJEfe2uNnx9Yk8lrXM5pWBmjCWI1xKSkj1varZaSAgIqdbulwQQ6939t
         Nt4M9qIqcfWNlsWMPzf5JHYCbRcunL5Rd6ImNN41uhGrfUgLIUa/CQWC/MzemrH7wv
         1g8WzChJUy6zTqqtWxFkCTkyEifqm91xr1BqPx17cxRbZ+gf+d8i+NaRrcOzCKgrgg
         J70jPj7otEwmW/RHGszIIOeVXrH371nQs92Pe9IeGXEv1JOJRACRvkrfIDGvfOYw7Y
         sbObqEUEXODpGb8LoEzlkNDuBGajIn0jRvJWptskwWChJXvshuVpenIyXJRSzgR/1/
         Y7IH8N2vIJ9sQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 31 Aug 2022 03:45:31 +0300 (MSK)
Date:   Wed, 31 Aug 2022 03:45:30 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Message-ID: <20220831004530.zhvd7ehndqwmqgve@Rockosov-MBP>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
 <CAHp75VfSOL5R1JdH-RS4PEXT1dEwuFGsmUPfkAp7zdDEMGzzjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHp75VfSOL5R1JdH-RS4PEXT1dEwuFGsmUPfkAp7zdDEMGzzjw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/30 23:23:00 #20191014
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Sorry for late response. I didn't have the ability to reach my laptop during
last week.

[...]

> 
> > +               if (val)
> > +                       memcpy(__get_dynamic_array(buf), val, val_len);
> 
> I'm probably missing something, but what this condition prevents from?

In general, this condition prevents memcpy from being executed when
tracepoint is called with a null pointed buffer.

[...]

> > +       TP_printk("%s reg=%x val=%s", __get_str(name),
> > +                 (unsigned int)__entry->reg,
> 
> Why do you need casting?
> 

To be honest, I've made it based on the already existing regmap
tracepoints style. All of them make a cast to unsigned int type when
printout reg number.

-- 
Thank you,
Dmitry
