Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465D750FAC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbiDZKfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349169AbiDZKfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:35:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76807BC80;
        Tue, 26 Apr 2022 03:15:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bv19so35046021ejb.6;
        Tue, 26 Apr 2022 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3Y2xFiZZM73aQbd0fWB6wOUMQq6/t+7deOrBNRhpAo=;
        b=L0JvI+hwzslb7KKVSWtMbcFSetgyuHbkwLbRyMxEENT6QJ+aSWwO2YG51X3qnGcv/Y
         /d/Q6vSYhVwvUVLG3dPZbFsDQL1fwYeNw/jlAUUuF6sjHW08dWfI8/0Kk6WjrmeX8sgP
         XEJalN/f+v2PU6g2LnOVTridPXqmUoZG2CFSk+GokxNEco2+pRcAjnHCZil8rEpATQIP
         NupWyqdlD5+F7+jCFBaLO3GkQWf0jYMUq5ZvhTYTnGgqx2MYEHhYUKpgdLIm8o7e10kT
         wRUek3rToTfanY01ncLCh9/98lWMw+ZqTmfjeLkm6+DfKlRVgeKp+H1UX6y2AwI7NNkX
         NDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3Y2xFiZZM73aQbd0fWB6wOUMQq6/t+7deOrBNRhpAo=;
        b=HyJUwYTl/34QwMHUpaRftAIJWwHevrEsSjvvwpir4gC8c7Ka+t8Kic+JzH37Bw23hw
         lVdxUUiJ/ACcHh6kMmV15UUOAjUguejuw2WUfKPQAqVcoGKP6I+71CwF7Rhutk8C+qKH
         cv+pCTCBbcy/rSItCCyD4/RTgVrq76ZPMoXZlskVFzkZnpEf/1RSWNUlO63aLGAGpJQQ
         JR+qce83EQt9t7TjM9wouLXCSsAkp9w0hViGO5UGqJdl4m8JJ1HoBIeW5fzSC4TF8ifn
         Nr8ocwZfFxNGu594aXD0Jr9LO0eo3Zt52BIkpaXYo6GLOaXKtJ3tcgjYOnDKPs+ikHo+
         MFsA==
X-Gm-Message-State: AOAM531cZsPmregWjh1dZ0EuEspjKlbLiMD/MRpfDpaTdNUMSnYdWa/L
        /YTN9aeRg+w3mONgG0OAajFuz2mjIvHVfe2Q8Mk=
X-Google-Smtp-Source: ABdhPJx+imrat0Zla/qc8W6CK7Tbr/jceeZWxvAY6UNQhFT3P/lC6vjpbSbUKrsLvZi6tatpbMkn9a7w0LbrUygEvi4=
X-Received: by 2002:a17:907:7d8c:b0:6f2:476d:fde4 with SMTP id
 oz12-20020a1709077d8c00b006f2476dfde4mr19519158ejc.497.1650968152522; Tue, 26
 Apr 2022 03:15:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220422222351.1297276-1-bjorn.andersson@linaro.org> <20220422222351.1297276-2-bjorn.andersson@linaro.org>
In-Reply-To: <20220422222351.1297276-2-bjorn.andersson@linaro.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Apr 2022 12:15:13 +0200
Message-ID: <CAHp75VdT7FYpoxV8RD6J-ujHuDnj0GWswDx6wCyCyz9cozkQ7Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] device property: Add helper to match multiple connections
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
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

On Sat, Apr 23, 2022 at 1:25 AM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> In some cases multiple connections with the same connection id
> needs to be resolved from a fwnode graph.
>
> One such example is when separate hardware is used for performing muxing
> and/or orientation switching of the SuperSpeed and SBU lines in a USB
> Type-C connector. In this case the connector needs to belong to a graph
> with multiple matching remote endpoints, and the Type-C controller needs
> to be able to resolve them both.
>
> Add a new API that allows this kind of lookup.

LGTM now,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
thanks!

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v4:
> - Added "Add" to patch subject
> - Added "(Optional)" kernel-doc of fwnode_connection_find_matches()
>
>  drivers/base/property.c  | 109 +++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |   5 ++
>  2 files changed, 114 insertions(+)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 36401cfe432c..babab8cec7a0 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1201,6 +1201,40 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>         return NULL;
>  }
>
> +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> +                                               const char *con_id, void *data,
> +                                               devcon_match_fn_t match,
> +                                               void **matches,
> +                                               unsigned int matches_len)
> +{
> +       struct fwnode_handle *node;
> +       struct fwnode_handle *ep;
> +       unsigned int count = 0;
> +       void *ret;
> +
> +       fwnode_graph_for_each_endpoint(fwnode, ep) {
> +               if (matches && count >= matches_len) {
> +                       fwnode_handle_put(ep);
> +                       break;
> +               }
> +
> +               node = fwnode_graph_get_remote_port_parent(ep);
> +               if (!fwnode_device_is_available(node)) {
> +                       fwnode_handle_put(node);
> +                       continue;
> +               }
> +
> +               ret = match(node, con_id, data);
> +               fwnode_handle_put(node);
> +               if (ret) {
> +                       if (matches)
> +                               matches[count] = ret;
> +                       count++;
> +               }
> +       }
> +       return count;
> +}
> +
>  static void *
>  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>                     void *data, devcon_match_fn_t match)
> @@ -1223,6 +1257,37 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
>         return NULL;
>  }
>
> +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> +                                         const char *con_id, void *data,
> +                                         devcon_match_fn_t match,
> +                                         void **matches,
> +                                         unsigned int matches_len)
> +{
> +       struct fwnode_handle *node;
> +       unsigned int count = 0;
> +       unsigned int i;
> +       void *ret;
> +
> +       for (i = 0; ; i++) {
> +               if (matches && count >= matches_len)
> +                       break;
> +
> +               node = fwnode_find_reference(fwnode, con_id, i);
> +               if (IS_ERR(node))
> +                       break;
> +
> +               ret = match(node, NULL, data);
> +               fwnode_handle_put(node);
> +               if (ret) {
> +                       if (matches)
> +                               matches[count] = ret;
> +                       count++;
> +               }
> +       }
> +
> +       return count;
> +}
> +
>  /**
>   * fwnode_connection_find_match - Find connection from a device node
>   * @fwnode: Device node with the connection
> @@ -1250,3 +1315,47 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
>         return fwnode_devcon_match(fwnode, con_id, data, match);
>  }
>  EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> +
> +/**
> + * fwnode_connection_find_matches - Find connections from a device node
> + * @fwnode: Device node with the connection
> + * @con_id: Identifier for the connection
> + * @data: Data for the match function
> + * @match: Function to check and convert the connection description
> + * @matches: (Optional) array of pointers to fill with matches
> + * @matches_len: Length of @matches
> + *
> + * Find up to @matches_len connections with unique identifier @con_id between
> + * @fwnode and other device nodes. @match will be used to convert the
> + * connection description to data the caller is expecting to be returned
> + * through the @matches array.
> + * If @matches is NULL @matches_len is ignored and the total number of resolved
> + * matches is returned.
> + *
> + * Return: Number of matches resolved, or negative errno.
> + */
> +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> +                                  const char *con_id, void *data,
> +                                  devcon_match_fn_t match,
> +                                  void **matches, unsigned int matches_len)
> +{
> +       unsigned int count_graph;
> +       unsigned int count_ref;
> +
> +       if (!fwnode || !match)
> +               return -EINVAL;
> +
> +       count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> +                                                 matches, matches_len);
> +
> +       if (matches) {
> +               matches += count_graph;
> +               matches_len -= count_graph;
> +       }
> +
> +       count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> +                                         matches, matches_len);
> +
> +       return count_graph + count_ref;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index fc24d45632eb..a5b429d623f6 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -451,6 +451,11 @@ static inline void *device_connection_find_match(struct device *dev,
>         return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
>  }
>
> +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> +                                  const char *con_id, void *data,
> +                                  devcon_match_fn_t match,
> +                                  void **matches, unsigned int matches_len);
> +
>  /* -------------------------------------------------------------------------- */
>  /* Software fwnode support - when HW description is incomplete or missing */
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
