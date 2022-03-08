Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953154D20DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349817AbiCHTEj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Mar 2022 14:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiCHTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:04:37 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6284B51318;
        Tue,  8 Mar 2022 11:03:40 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id g26so39655650ybj.10;
        Tue, 08 Mar 2022 11:03:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4E6i+4IRB1zeecnqsoRPPZl4Z+F9fi4/dPQmEE9i2QE=;
        b=RiqzI5RJc3JGeHzzkHSrIr8KiMXQwO+ZvSjuzScH4DPkvOwKoEeIQo/gTozwfNe9Rn
         0+zl2guJiZmTKkIrDZ4uP2xJUPhyrRzwO5rP8wIajWhFH+hs+SbLuwmn3qoUOmHImt5F
         NDHEoXUty/m7L/A1mGPSjIxTs66IiULTjzSyZfYzWgSI8pUZLqkxFTaCKRjZLP47Jpf5
         kYjs9vWUUFCWKrQfhj1duZd06yrOyxL/8M9QdO9wzg/oAymL9G8eswVMmhLy6BgaMMz9
         w+QtVwBNgDoSJ+e2Ys1SJlMka3uHGOCWxFWorxU+OqXI+liCtZylYOYjrDmTZK/A87xQ
         y9lw==
X-Gm-Message-State: AOAM530z62PLPjrCdkW6AnVULh7+NMcmW++Md2xqmdPAJHAx8hLpbGfU
        JeqQYk+WXc9yxjvqBVeYUvTPPrEqjg8mCZaZm9Jqf2a5
X-Google-Smtp-Source: ABdhPJyLtls3pUaZHEPw1JQ1bg3M1xx0F7xGymtOcQQecggJHVBhpsKVsN5kAOo2vL7MZJuIUCjWqWecZNMP4n6Q1Mk=
X-Received: by 2002:a25:fe10:0:b0:625:262f:e792 with SMTP id
 k16-20020a25fe10000000b00625262fe792mr12857920ybe.365.1646766219609; Tue, 08
 Mar 2022 11:03:39 -0800 (PST)
MIME-Version: 1.0
References: <20220308123712.18613-1-andriy.shevchenko@linux.intel.com> <Yidp9/MU4yq93E9S@kuha.fi.intel.com>
In-Reply-To: <Yidp9/MU4yq93E9S@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Mar 2022 20:03:28 +0100
Message-ID: <CAJZ5v0h=4JT3yiWz0KetodLV4HrOqse0EUbWUez-1fcy4-6jGQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] device property: Allow error pointer to be passed
 to fwnode APIs
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 3:36 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Tue, Mar 08, 2022 at 02:37:12PM +0200, Andy Shevchenko wrote:
> > Some of the fwnode APIs might return an error pointer instead of NULL
> > or valid fwnode handle. The result of such API call may be considered
> > optional and hence the test for it is usually done in a form of
> >
> >       fwnode = fwnode_find_reference(...);
> >       if (IS_ERR(fwnode))
> >               ...error handling...
> >
> > Nevertheless the resulting fwnode may have bumped the reference count
> > and hence caller of the above API is obliged to call fwnode_handle_put().
> > Since fwnode may be not valid either as NULL or error pointer the check
> > has to be performed there. This approach uglifies the code and adds
> > a point of making a mistake, i.e. forgetting about error point case.
> >
> > To prevent this, allow an error pointer to be passed to the fwnode APIs.
> >
> > Fixes: 83b34afb6b79 ("device property: Introduce fwnode_find_reference()")
> > Reported-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Tested-by: Nuno Sá <nuno.sa@analog.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Acked-by: Nuno Sá <nuno.sa@analog.com>
>
> This is nice! FWIW:
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied as 5.18 material, thanks!
