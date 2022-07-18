Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E45785E8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiGROzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 10:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiGROzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 10:55:45 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C1A2495B;
        Mon, 18 Jul 2022 07:55:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w12so15611366edd.13;
        Mon, 18 Jul 2022 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tme4hCoAp9MJH+npHPL49EiKb8s+dPVv5cWtW6ohLjk=;
        b=FoWHmcXwsjKL2J3LqgSvD1QjWVSyRADC+Lo6e90B2NLuDiiGpuq2OhATGbWSrvwuju
         OavdJKob7sCVKvts0gUqpztlAviw7jasp39tr0Hkh05Z5i7YwtGZNmQb55UGkGQTVrc1
         /CKziuG/YEvBeIwn2lGrlXevaFf3FYXzz76xaCpIiEcZEsVixLAeDteNwSb2vzwvGWjh
         rIc9ZTHgYxp6UkpzDHhAh/z4HkTDTT5PfopKiQ4aCQ30rUodFpTZlMhbiZOeQe8QwFCk
         ZHqQyBGpyRU3RwNj9RmgVB04PywuEUatRvXnH9Wg1m3N3MdFaV9rLudgXpkm5r+mAsiT
         bg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tme4hCoAp9MJH+npHPL49EiKb8s+dPVv5cWtW6ohLjk=;
        b=IJfVYgWAg1I/ikr3rS2JoT8bGdZ0hfSL70eubY+8IIMwTo/P5dOJJuBIwOSuOgsfoE
         0Y9su2Sewoj33gYfiq/Vcwugu2y3clR+fupe6TJwsu8qqFTLM2Fm/mN6W7mvTd2mgjZh
         NIy3vUjoQx03hy5bISyvrOXqZejgGok8IzFpiwQpamq/Y64KkRDJnJrkI2FUcicBEcGh
         ae4gYhwfRedRGotit/upFcWjd63UCo1UyVnmnNUJPV3ap6PzhyrAbuLbTXrzfv4gt8nz
         y6Wlo/q6CWzozIfBpcGUAoH/D2+uRxw150ItkMbyThbFofLJxa0tZjV4YuT2eowy2BMS
         W8fQ==
X-Gm-Message-State: AJIora/ZVNc+fwrWLJJ/H3N6Fd8lS84N4uftCSsHrpI29JTm2+YgUWV+
        Xsl4hS5k072RepIQMBJZIsj44E0JHDGUXE/qa+U=
X-Google-Smtp-Source: AGRyM1sCF2+fysrzqxDyhua18fILUdQ2AZJyQGxg718W+CMc1RbtcMXNWkH4Ho5xwCKwD1Mz2f17SghcGbsaKierwQw=
X-Received: by 2002:a05:6402:d05:b0:435:b2a6:94eb with SMTP id
 eb5-20020a0564020d0500b00435b2a694ebmr36970947edb.87.1658156142935; Mon, 18
 Jul 2022 07:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220718114748.6365-1-andriy.shevchenko@linux.intel.com> <aa9e27c7-e4cf-00f1-e88a-8d6c3857eb71@redhat.com>
In-Reply-To: <aa9e27c7-e4cf-00f1-e88a-8d6c3857eb71@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jul 2022 16:55:06 +0200
Message-ID: <CAHp75Vfez=qECDuVdsDpWu4qjOt6U_xBrMC3P-O--V2EQprB8w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] platform/x86: p2sb: Move out of
 X86_PLATFORM_DEVICES dependency
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Jonathan Yong <jonathan.yong@intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 4:18 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 7/18/22 13:47, Andy Shevchenko wrote:

...

> >  endif # X86_PLATFORM_DEVICES
> >
> > +config P2SB
> > +     bool "Primary to Sideband (P2SB) bridge access support"
> > +     depends on PCI
>
> This needs to become "PCI && X86" to avoid this possible getting
> enabled on other platforms.

Indeed.

> With that added you may add my:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks!
Amended and sent a v2.

> and this also counts as my ack for merging this through
> Lee's MFD tree together with the rest of the series.


-- 
With Best Regards,
Andy Shevchenko
