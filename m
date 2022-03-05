Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A5C4CE4E8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiCEMrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiCEMrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:47:49 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAEB1CC7FD;
        Sat,  5 Mar 2022 04:46:59 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw13so22669056ejc.9;
        Sat, 05 Mar 2022 04:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HVyxOquQB+7ZUikAfJUPHlomKB3BFHBzFj8UIR5y97Y=;
        b=YHThSsVQxENQwpRIGbl+NzzSfHCB5mdRYcKSwy35/gQm3vfd4EM/h1iR9w30EKp3v8
         xSDAUMeBBq587t/YU3OB7qbOMRSudCGes748JHPb8oYHEOdrNiLgBki19XxUTp5V9H21
         Bx56vmwJLGbbrQoIk1rXuCR6/hb+gJbKSIZN4L/KKvgMKEMXoEzP0UeS5RGKHqGajXpQ
         tkH34htZD8+yhcytVN2LG3v40NbB7CFjbuSFznha5IZLlTQLj3RZpp4Rhp5Wc2NzURoW
         zwie4QH7g7lDXNUnaBrs2DFu5Qigy6MwVqCrEOwIVFRCmwx/vKj25fVMal9b5KNv6NhI
         gL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=HVyxOquQB+7ZUikAfJUPHlomKB3BFHBzFj8UIR5y97Y=;
        b=5yChgqJUFtyR2mztbeMlSceWhKlpruW28+rhoIkpJ934XqT/00SJc/I+/4Tal6H93F
         cUXRCBkMQi4b9ccRbMNtJBjw4lNKgi4zMHTyMGoj90ZN680haVdVQglIo/YV6K4oYjnE
         98lQdLptBl9gP00LGtA5D1mh+xzeaA6IpfOQOKFhipe17+iZUgjoRnGLeVw0HE0lEc7N
         pgvtGkf6mU9P51hvRpIaRkAaDUnypu7RPqAQDTyfwhVCOpPMvZMi3zolmVhliycDb/2i
         ldWb/IMqG4d8/gJy/I0NZenAcBdcv0Sw3JOYbTfNbL71sdz1uyFOu/jqc1OT81Oli8uY
         YzOg==
X-Gm-Message-State: AOAM5326p1zwCXnaQVZVraobOxXQ/rAz1/FqyI1egv+gniCS3yZ4ibtz
        sKNFjk53OtPIex83L3/XiuY=
X-Google-Smtp-Source: ABdhPJxfXD8S/M/zEtq28L8UG0gavIYUYDqwOWdyNIkqfnuUFztvUxL+bWZPVEYjVh5Cpoio1rYllQ==
X-Received: by 2002:a17:907:d06:b0:6da:2902:e9ad with SMTP id gn6-20020a1709070d0600b006da2902e9admr2727047ejc.566.1646484418264;
        Sat, 05 Mar 2022 04:46:58 -0800 (PST)
Received: from ?IPv6:2001:a61:2ae0:801:d90b:c312:2baa:2aa3? ([2001:a61:2ae0:801:d90b:c312:2baa:2aa3])
        by smtp.gmail.com with ESMTPSA id a1-20020aa7d901000000b00416217c99bcsm684935edr.65.2022.03.05.04.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 04:46:57 -0800 (PST)
Message-ID: <8afcf0b81f78ffdda8bcac5f0fd1d4c40dc4f8d6.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] device property: Allow error pointer to be
 passed to fwnode APIs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Date:   Sat, 05 Mar 2022 13:46:56 +0100
In-Reply-To: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com>
References: <20220304173256.39059-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 19:32 +0200, Andy Shevchenko wrote:
> Some of the fwnode APIs might return an error pointer instead of NULL
> or valid fwnode handle. The result of such API call may be considered
> optional and hence the test for it is usually done in a form of
> 
>         fwnode = fwnode_find_reference(...);
>         if (IS_ERR_OR_NULL(fwnode))
>                 ...error handling...
> 
> Nevertheless the resulting fwnode may have bumped reference count and
> hence caller of the above API is obliged to call fwnode_handle_put().
> Since fwnode may be not valid either as NULL or error pointer the
> check
> has to be performed there. This approach uglifies the code and adds
> a point of making a mistake, i.e. forgetting about error point case.
> 
> To prevent this allow error pointer to be passed to the fwnode APIs.
> 
> Fixes: 83b34afb6b79 ("device property: Introduce
> fwnode_find_reference()")
> Reported-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: adjusted the entire fwnode API (Sakari)
> 
> Nuno, can you test this with the ltc2983 series, including the
> IS_ERR_OR_NULL()
> fix to it?
> 

Sure... I will test that series together with this patch.
>  drivers/base/property.c | 45 +++++++++++++++++++++++++--------------
> --
>  include/linux/fwnode.h  | 10 ++++-----
>  2 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index c0e94cce9c29..1922818470b0 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/export.h>
> +#include <linux/fwnode.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> @@ -45,14 +46,16 @@ EXPORT_SYMBOL_GPL(device_property_present);
>  bool fwnode_property_present(const struct fwnode_handle *fwnode,
>                              const char *propname)
>  {
> -       bool ret;
> +       if (IS_ERR_OR_NULL(fwnode))
> +               return false;
>  
> -       ret = fwnode_call_bool_op(fwnode, property_present,
> propname);
> -       if (ret == false && !IS_ERR_OR_NULL(fwnode) &&
> -           !IS_ERR_OR_NULL(fwnode->secondary))
> -               ret = fwnode_call_bool_op(fwnode->secondary,
> property_present,
> -                                        propname);
> -       return ret;
> +       if (fwnode_call_bool_op(fwnode, property_present, propname))
> +               return true;
> +
> +       if (IS_ERR_OR_NULL(fwnode->secondary))
> +               return false;
> +
> +       return fwnode_call_bool_op(fwnode->secondary,
> property_present, propname);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_property_present);
>  
> @@ -232,10 +235,12 @@ static int fwnode_property_read_int_array(const
> struct fwnode_handle *fwnode,
>  {
>         int ret;
>  
> +       if (IS_ERR_OR_NULL(fwnode))
> +               return -EINVAL;
> +
>         ret = fwnode_call_int_op(fwnode, property_read_int_array,
> propname,
>                                  elem_size, val, nval);
> -       if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> -           !IS_ERR_OR_NULL(fwnode->secondary))
> +       if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode->secondary))
>                 ret = fwnode_call_int_op(
>                         fwnode->secondary, property_read_int_array,
> propname,
>                         elem_size, val, nval);
> @@ -371,10 +376,12 @@ int fwnode_property_read_string_array(const
> struct fwnode_handle *fwnode,
>  {
>         int ret;
>  
> +       if (IS_ERR_OR_NULL(fwnode))
> +               return -EINVAL;
> +
>         ret = fwnode_call_int_op(fwnode, property_read_string_array,
> propname,
>                                  val, nval);
> -       if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode) &&
> -           !IS_ERR_OR_NULL(fwnode->secondary))
> +       if (ret == -EINVAL && !IS_ERR_OR_NULL(fwnode->secondary))
>                 ret = fwnode_call_int_op(fwnode->secondary,
>                                          property_read_string_array,

Isn't !IS_ERR_OR_NULL(fwnode->secondary)) redundant? AFAIU,
fwnode_call_int_op() will already check the fwnode and only call the op
if the pointer is valid... 

- Nuno Sá

