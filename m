Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B984CC9FF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235240AbiCCXYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 18:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiCCXYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 18:24:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D476710D0;
        Thu,  3 Mar 2022 15:23:36 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id bg10so13941749ejb.4;
        Thu, 03 Mar 2022 15:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9c2fVUpY7DyP3VgtwSVx0smNHNJcvslxILkoyROtr1w=;
        b=ItflX7sdEXiW8zlZ4EFJkhQ4cvSrk29ApLzREKca8BMZ5SHJFf/LQLHc+vpa5ldKhD
         gayzeFaCbaTmiA/r2El83NvflWOrzgHj9tQvgu32iQ263O9uefwrfR/T2TLtIrMnia2l
         wpAwzTjXQTco2LnnHPLEbVGehHO6S69AjUmWcLpKmYAvSoc2J+p6TntH5uOqZDFLkH+n
         qB9PqcYQlTnYLOWgh4UDBUCwtUoE+O565clRJFbAlDKu9FuvhPchofEH59jwPb1ThBh9
         cJ5tyrMwE2nroYd4n098SepAGlo/xlYllHZ17bwqVd2C6LXLS8NeevZ3EPyx9FkA49w2
         S7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9c2fVUpY7DyP3VgtwSVx0smNHNJcvslxILkoyROtr1w=;
        b=U7495zDFARigDXvWnQRRcrjWXtWw6zu+okh9eqYlKKDFuSOd/cX5w0InhAJIfldRbN
         pPNQBNThjGSKulnB9EkoxPICBEKVS+ib7dTWZC7w5jRyQHef4POi0O8xMwwkwx+OiaCO
         9bu868DgC7wLNB0BQ552tPIZwhgW1fjUO1ZU7pw9UkkDrXqLzS+8p00SFieoBno2bbsH
         Y3WCe/9skyco1MlKC2dEVeQVrr+o/u73RceeuGhGZCcUD6CBb1Q3oYq7V2inwXQiwoat
         VwZ1H2xOGXI+ikbNQtfUJPNhtmcBvcVSOphCusbgj/OtwxBJCVbKFC1qY8UlCCBOVuft
         4mhQ==
X-Gm-Message-State: AOAM533CKGqHCQg1j5jTvRxHonDRj8RW5mLF4eXRTJBmIOCdCLEFkNB4
        Img6jh1U8HetsSQr/gYFn8D4S6VIO5bNAJpnOv5+M6ajbio=
X-Google-Smtp-Source: ABdhPJxeMzRCXl3xo2gq478pKijm5mLzaTTem/4gSoCd9EheSFl4eBnXdb0Xyeuvp/fb3WCw46LNosphVQOF7BQsleU=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr29813134ejc.497.1646349814940; Thu, 03
 Mar 2022 15:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20220303150610.47596-1-andriy.shevchenko@linux.intel.com> <YiDpKqwiwD8jZdFT@paasikivi.fi.intel.com>
In-Reply-To: <YiDpKqwiwD8jZdFT@paasikivi.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 4 Mar 2022 01:22:58 +0200
Message-ID: <CAHp75Ve6k7zqy6Z+2cscV1xq_wh6gyRGBUuSy8ES0KU1g2cnow@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] device property: Allow error pointer for fwnode_handle_{get,put}()
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
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

On Thu, Mar 3, 2022 at 11:34 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
> On Thu, Mar 03, 2022 at 05:06:10PM +0200, Andy Shevchenko wrote:
> > Some of the fwnode APIs might return an error pointer instead of NULL
> > or valid fwnode handle. The result of such API call may be considered
> > optional and hence the test for it is usually done in a form of
> >
> >       fwnode = fwnode_find_reference(...);
> >       if (IS_ERR_OR_NULL(fwnode))
> >               ...error handling...
> >
> > Nevertheless the resulting fwnode may have bumped reference count and
> > hence caller of the above API is obliged to call fwnode_handle_put().
> > Since fwnode may be not valid either as NULL or error pointer the check
> > has to be performed there. This approach uglifies the code and adds
> > a point of making a mistake, i.e. forgetting about error point case.
> >
> > To prevent this allow error pointer for fwnode_handle_get() and
> > fwnode_handle_put().

Thanks for the review, my comments below.

...

> I guess fwnode_find_reference() is the only fwnode API function returning
> errors as pointers? If you changed it returning NULL on error, you'd lose
> the error codes.
>
> But I think this is a problem beyond fwnode_handle_{get,put}: fwnode
> obtained this way could be passed to any fwnode function and they should
> just work correctly with that.
>
> How about moving the check to fwnode_has_op()? That function is responsible
> for checking the fwnode is valid and has the op in question.

Yes, I was thinking about it (and I even have a local followup), so
this version of the fix is (semi-)RFC. Moreover, we (wrongly!) do
check in many already, but only _after_ trying to dereference error
pointers.

Letme prepare v2 tomorrow.

> It also seems the explicit fwnode_has_op() call is redundant in
> fwnode_handle_put() as fwnode_call_void_op() already calls fwnode_has_op().

Then call_ptr_op should have the same check as well.

-- 
With Best Regards,
Andy Shevchenko
