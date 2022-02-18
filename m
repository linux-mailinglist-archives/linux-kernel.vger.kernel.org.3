Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148334BC083
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbiBRTvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:51:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBRTvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:51:36 -0500
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B02905B3;
        Fri, 18 Feb 2022 11:51:18 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2d66f95f1d1so77382707b3.0;
        Fri, 18 Feb 2022 11:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UpmHze97W9LathLwKVIjqOsoo/tKcPCSRRjEHG+pgk=;
        b=7E6KQNXkKAOF2BUCuquYMyP2TtV9Xo91qIfV/Sp7WOx2wZH4SBZHqbKObUy0WUApsX
         ZjYaqDMxnE3l7n3sh+aXIl/IrLnocXE52sMVtVPy1msYVW+Ib4/WDrhc/SvHiw94X/qk
         yJP8ceN9qPAihhDWYY3IF2qqNJTRLMdGP/nBR64XinD9sCmO4yYwhLoCWzkuOhmkb2r6
         VG3sXwRruUCB5apELUAy+lExELzgsLBtla5ylLSLZWoGIhVbKfm+DHf+WCf3phMeQPCf
         um36orRqHe0V22oiZkG4vlHNPbA3M2nxD60JTNReAo9cu1NP+FwuW1I78WfVWSRPQ0r5
         qdag==
X-Gm-Message-State: AOAM5302IQefdPjo8CuXofzfrXoCmgN7yUWnWdn12MCQlFRt8gmr1KKh
        V3fx4qpuQpKAkkbZnukzWtO/ZALWVF+rPsIscZxZLxtA
X-Google-Smtp-Source: ABdhPJw8iiRMmLhZY9o1UAyVsrYD0rOzIDAgwp+BY5YjlXi+5cJKUF7wlAYuB72Vi54Y902H7OtvODEqCuS7bM5P1iE=
X-Received: by 2002:a0d:e8d2:0:b0:2d6:1743:4023 with SMTP id
 r201-20020a0de8d2000000b002d617434023mr9279305ywe.7.1645213877421; Fri, 18
 Feb 2022 11:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20220209145318.83405-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220209145318.83405-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 18 Feb 2022 20:51:06 +0100
Message-ID: <CAJZ5v0g5EWb34iGitsHv2EEOMoDSWHFgbpL1avbbqh5Enggcsw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: property: Get rid of redundant 'else'
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 9, 2022 at 3:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In the snippets like the following
>
>         if (...)
>                 return / goto / break / continue ...;
>         else
>                 ...
>
> the 'else' is redundant. Get rid of it.
>
> While at it, replace conditional '<= 0' for unsigned type by '== 0'
> in acpi_data_prop_read(); update comment in the
> __acpi_node_get_property_reference() on how we parse the reference.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/property.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 4744c191acee..928aa4f86344 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -541,7 +541,8 @@ acpi_device_data_of_node(const struct fwnode_handle *fwnode)
>         if (is_acpi_device_node(fwnode)) {
>                 const struct acpi_device *adev = to_acpi_device_node(fwnode);
>                 return &adev->data;
> -       } else if (is_acpi_data_node(fwnode)) {
> +       }
> +       if (is_acpi_data_node(fwnode)) {
>                 const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
>                 return &dn->data;
>         }
> @@ -739,14 +740,19 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
>                                         return -EINVAL;
>                         }
>
> -                       /* assume following integer elements are all args */
> +                       /*
> +                        * Assume the following integer elements are all args.
> +                        * Stop counting on the first reference or end of the
> +                        * package arguments. In case of neither reference,
> +                        * nor integer, return an error, we can't parse it.
> +                        */
>                         for (i = 0; element + i < end && i < num_args; i++) {
>                                 int type = element[i].type;
>
> +                               if (type == ACPI_TYPE_LOCAL_REFERENCE)
> +                                       break;
>                                 if (type == ACPI_TYPE_INTEGER)
>                                         nargs++;
> -                               else if (type == ACPI_TYPE_LOCAL_REFERENCE)
> -                                       break;
>                                 else
>                                         return -EINVAL;
>                         }
> @@ -938,7 +944,7 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
>
>         if (proptype != DEV_PROP_STRING && nval > obj->package.count)
>                 return -EOVERFLOW;
> -       else if (nval <= 0)
> +       if (nval == 0)
>                 return -EINVAL;
>
>         items = obj->package.elements;
> @@ -1000,14 +1006,10 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
>         const struct list_head *head;
>         struct list_head *next;
>
> -       if (!child || is_acpi_device_node(child)) {
> +       if ((!child || is_acpi_device_node(child)) && adev) {
>                 struct acpi_device *child_adev;
>
> -               if (adev)
> -                       head = &adev->children;
> -               else
> -                       goto nondev;
> -
> +               head = &adev->children;
>                 if (list_empty(head))
>                         goto nondev;
>
> @@ -1077,7 +1079,8 @@ acpi_node_get_parent(const struct fwnode_handle *fwnode)
>         if (is_acpi_data_node(fwnode)) {
>                 /* All data nodes have parent pointer so just return that */
>                 return to_acpi_data_node(fwnode)->parent;
> -       } else if (is_acpi_device_node(fwnode)) {
> +       }
> +       if (is_acpi_device_node(fwnode)) {
>                 struct device *dev = to_acpi_device_node(fwnode)->dev.parent;
>
>                 if (dev)
> --

Applied as 5.18 material, thanks!
