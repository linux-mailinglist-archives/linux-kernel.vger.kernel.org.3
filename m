Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68CC4FFD85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiDMSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiDMSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:12:55 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABA526AF7;
        Wed, 13 Apr 2022 11:10:34 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id g34so5266240ybj.1;
        Wed, 13 Apr 2022 11:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWnLw7pcgFg7OO/Mp5u2CJgjWXHz+s+DaK73ibuVFlU=;
        b=55DySKyrYv/fNb5oDcmg1V44RYLhlz8LvWDgTlx7nTkQ+FFlkvOSpUHJgGSO++XAFf
         /cMfVfOhhexjpTjbW4QCL36nX7JQmairVfqE2+tZVFXdjAYQqPG7goW5Zm6KQWVBD2UV
         uYjXYAR/e8XNwsjlFy6mESrk4bwaoKCJQGX+sCL1A9qBU+W73Xmzwwzj/BI8WLwOoxez
         CSWVWEsK0xcg6lHAUfzNMz9rM13TZsN5HDW+3eCuHtFWl4pF4irpteUpVLLbRndO9sgB
         7d7EGH5Y0r6FCLpYJCdIS5jgu9kyUTdXwuSHFIaX2JU/tNjg8OIyO17Cf2gxH4RSY4z5
         X3Fg==
X-Gm-Message-State: AOAM5315e634pQ/H/HnJtSGe6kRVF1vFIfX2neZNA9JQSlVaPaI9h2ts
        cIHD+UaW6fyatRtSsJ4vFQcm79u9UCNbYV/acic=
X-Google-Smtp-Source: ABdhPJzhrYFwc77slRKKGPSvgQKp3I24ZGfcYuYi9ZzAPo/jWfp3TjnJB9dQmBb7nWtQDG5MRNl7xRiOK+ISKc8OtXE=
X-Received: by 2002:a25:3cc3:0:b0:63e:6ee9:4840 with SMTP id
 j186-20020a253cc3000000b0063e6ee94840mr112067yba.153.1649873433436; Wed, 13
 Apr 2022 11:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220408184844.22829-1-andriy.shevchenko@linux.intel.com> <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220408184844.22829-4-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 20:10:22 +0200
Message-ID: <CAJZ5v0jnyg6n-1QRmVg1tjzu3szsG3DYqYTXAbobbKwkFhTreg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] device property: Constify fwnode_handle_get()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 8:49 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> As to_of_node() suggests and the way the code in the OF and software node
> back ends actually uses the fwnode handle, it may be constified. Do this
> for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v6: new patch
>  drivers/base/property.c  | 2 +-
>  drivers/base/swnode.c    | 2 +-
>  drivers/of/property.c    | 2 +-
>  include/linux/fwnode.h   | 2 +-
>  include/linux/property.h | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 36401cfe432c..1ad4b37cd312 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -776,7 +776,7 @@ EXPORT_SYMBOL_GPL(device_get_named_child_node);
>   *
>   * Returns the fwnode handle.
>   */
> -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode)
> +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode)
>  {
>         if (!fwnode_has_op(fwnode, get))
>                 return fwnode;
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index b0bbd1805970..84a11008ffb8 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -363,7 +363,7 @@ EXPORT_SYMBOL_GPL(property_entries_free);
>  /* -------------------------------------------------------------------------- */
>  /* fwnode operations */
>
> -static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
> +static struct fwnode_handle *software_node_get(const struct fwnode_handle *fwnode)
>  {
>         struct swnode *swnode = to_swnode(fwnode);
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 9a50ad25906e..8d06282af8e4 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -858,7 +858,7 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
>  }
>  EXPORT_SYMBOL(of_graph_get_remote_node);
>
> -static struct fwnode_handle *of_fwnode_get(struct fwnode_handle *fwnode)
> +static struct fwnode_handle *of_fwnode_get(const struct fwnode_handle *fwnode)
>  {
>         return of_fwnode_handle(of_node_get(to_of_node(fwnode)));
>  }
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 9a81c4410b9f..a94bd47192a3 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -108,7 +108,7 @@ struct fwnode_reference_args {
>   *             zero on success, a negative error code otherwise.
>   */
>  struct fwnode_operations {
> -       struct fwnode_handle *(*get)(struct fwnode_handle *fwnode);
> +       struct fwnode_handle *(*get)(const struct fwnode_handle *fwnode);
>         void (*put)(struct fwnode_handle *fwnode);
>         bool (*device_is_available)(const struct fwnode_handle *fwnode);
>         const void *(*device_get_match_data)(const struct fwnode_handle *fwnode,
> diff --git a/include/linux/property.h b/include/linux/property.h
> index fc24d45632eb..c631ee7fd161 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -121,7 +121,7 @@ struct fwnode_handle *fwnode_get_named_child_node(
>  struct fwnode_handle *device_get_named_child_node(struct device *dev,
>                                                   const char *childname);
>
> -struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
> +struct fwnode_handle *fwnode_handle_get(const struct fwnode_handle *fwnode);
>  void fwnode_handle_put(struct fwnode_handle *fwnode);
>
>  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
> --

Why is 0-day complaining about this one?
