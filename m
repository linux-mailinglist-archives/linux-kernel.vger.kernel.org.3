Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC3E51202E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiD0SV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbiD0SVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:21:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3552343495
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:18:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y21so2920156edo.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rvi/o1fbKb1kGp3W3Hpq6Cgdph8ZZoNwuRiCmIxLQS0=;
        b=pBdisntTtPoXxlIXySp5mL/t1MbXSPXNh6/5Su37ufFnYiIhDuZSj6PNsnAX4XZOLz
         wQ8huaEX1oU3I7XFZw/Ephk0aHFyOqLMy6HJ+qQsjgLt+7ga3TKPq50ym1KPFsiHOcJf
         cmKLTdWjFqeZ/Fshqy0yokQrA/Cp+J+hwh03cA9o1LD+eEYm54Uc/HWd57WPWRsuutZu
         M08bIihmHF//JVjnWsmU0LWu4iOPG9/w7GWALV2iWzeaQCjROcGlrQj/Ub7NTafB1uee
         Fd0wiFhLFvKQ/ipDrnztrQy5asxgirYq4jw81hfxrQDlzPmYlMt43yhUTsrBt4mg5QCC
         mB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rvi/o1fbKb1kGp3W3Hpq6Cgdph8ZZoNwuRiCmIxLQS0=;
        b=cBLOy4CjVtTYSqkdBD1+BzQI/I+T8th04xZ5AR2Pm9zHPajdnK88iGVAAvzn2MN356
         GKB6KYpCSnr9KuOY/OAqaXenG0lx40py6O1wDq2AIDJ0+QT/fgDxmUwd59D4cPFgRoL4
         m2/J/nJHRThDNEXzXG9w/CJ5pwXH4JC3cn5kdIhowiUwZsMgZlZakw5M9QtVczV7+v6C
         KmEOjGpeaKUsjP/A5VeL/JYlFXTHZxhOubusseKubi6uMXvOx72juSoPOQJVtCFbx+OA
         aQ3Baey7Up8wdjmxZB3sOvGmhV0NWFlmZuFFqNWxw7HI3QgGhoCgbEGsTyNsxAkbn/Ky
         I5YA==
X-Gm-Message-State: AOAM53365ecqC9g2TeB0FHAtD0KNcvUflVglf1kzk4QQK/Z1yJHDcmIY
        ogLOqZrhtuu4bAEC4d8vjwvw1f3AgRl2eIhodEo=
X-Google-Smtp-Source: ABdhPJwBg5JBuCYhr2CwOxgiJIV7XYFH0Ov9PfOGsOLwVUduuD7nLUnyG1DDrABzRJ0dxX4lKJYGEr2O60HVzgyzwxI=
X-Received: by 2002:a05:6402:d51:b0:425:d5e1:e9f0 with SMTP id
 ec17-20020a0564020d5100b00425d5e1e9f0mr23229672edb.125.1651083490635; Wed, 27
 Apr 2022 11:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
 <Ymldp7E3j29iVlMN@smile.fi.intel.com> <20220427103901.7567e7058dcaa3068056b2ed@linux-foundation.org>
In-Reply-To: <20220427103901.7567e7058dcaa3068056b2ed@linux-foundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 20:17:34 +0200
Message-ID: <CAHp75VesfSdiR8naGLAfLCJ4mvMarXSQ+6PEoQcgMfgMpBSkNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to kstrtobool()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, ying.huang@intel.com,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Petr Mladek <pmladek@suse.com>
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

On Wed, Apr 27, 2022 at 8:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 27 Apr 2022 18:13:43 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> > On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> > > At many places in kernel, It is necessary to convert sysfs input
> > > to corrosponding bool value e.g. "false" or "0" need to be converted
> >
> > corresponding
> >
> > > to bool false, "true" or "1" need to be converted to bool true,
> > > places where such conversion is needed currently check the input
> > > string manually, kstrtobool() can be utilized at such places but
> > > currently it doesn't have support to accept "false"/"true".
> > >
> > > Add support to accept "false"/"true" as valid string in kstrtobool().
> >
> > Andrew, this patch still needs a bit of work.
>
> I fixed the two issues you identified in this email.  Is there more to do?

I think the rest is fine, esp. taking into account Matthew's review.
Feel free to add
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

(It might be better to check the second character as well to be sure
we avoid typos like 'talse' and 'frue', anyone to comment?)

-- 
With Best Regards,
Andy Shevchenko
