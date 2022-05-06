Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3660F51DF08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 20:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391515AbiEFSZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357923AbiEFSZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 14:25:10 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938EC289BA;
        Fri,  6 May 2022 11:21:26 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso90248627b3.5;
        Fri, 06 May 2022 11:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eqHGxVTiC+aOYyLf5Hf3ZQlbjff/7JbxSC1u3k4i3I=;
        b=dBWk/dp0NXUQsaZFkg8kwmIQaLS1QgzDX4+7jSSdE9Pq4LZsRneRbyj2L5gcU7ron1
         VfWD/P4YN9XRB7OQ8pkWV6UvwuoUt6ytGibxrs/nruB0n8i8IhVO252lKn0k6ch1aJ6l
         52Z68UUtSEEaI9USNB7nu8CJXrgKgAMLvNTkhkXYesums/7y1nYzdBKjonp0UFchIbsI
         3mO4t9kYi5K/Y9BgFQrbhwM2NB7ZWjeFHVngxQqkKUU+T61qbD5d1W7MA6mo7dQWFVfH
         wyCKvSuK6yWq/ruzkuaJx6KGxmAuxEt9F5UOKfjU1fEj+McKN2L42hjb0+vHs0CQtxdY
         HT0g==
X-Gm-Message-State: AOAM532Xop+ONypgdiN/tJqmO7ijcIp13120J3uDSD3/yzJ8/03FUKcI
        iPEgmagTFxR48pTHPFCx90VxEX4+z9vWzxlXvuE=
X-Google-Smtp-Source: ABdhPJxwEWPNBpCkkxsc+OW2EnhG0ybSKmz2h5QNQ80MYVe3xElHnV7PBsvP2u4Hwf++KNrbm4Ed3vR0FopXoyJxjKo=
X-Received: by 2002:a0d:edc7:0:b0:2f8:f300:df2b with SMTP id
 w190-20020a0dedc7000000b002f8f300df2bmr3757397ywe.515.1651861285758; Fri, 06
 May 2022 11:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220422222351.1297276-1-bjorn.andersson@linaro.org>
 <20220422222351.1297276-2-bjorn.andersson@linaro.org> <CAHp75VdT7FYpoxV8RD6J-ujHuDnj0GWswDx6wCyCyz9cozkQ7Q@mail.gmail.com>
In-Reply-To: <CAHp75VdT7FYpoxV8RD6J-ujHuDnj0GWswDx6wCyCyz9cozkQ7Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 6 May 2022 20:21:14 +0200
Message-ID: <CAJZ5v0grpObZMb+C6ResOnmVMZmiHf9NYBtVQzsTRSP_Wn8t=g@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] device property: Add helper to match multiple connections
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:15 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Apr 23, 2022 at 1:25 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > In some cases multiple connections with the same connection id
> > needs to be resolved from a fwnode graph.
> >
> > One such example is when separate hardware is used for performing muxing
> > and/or orientation switching of the SuperSpeed and SBU lines in a USB
> > Type-C connector. In this case the connector needs to belong to a graph
> > with multiple matching remote endpoints, and the Type-C controller needs
> > to be able to resolve them both.
> >
> > Add a new API that allows this kind of lookup.
>
> LGTM now,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> thanks!

For this and the next patch in the series:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and please feel free to route the whole lot via USB.

Thanks!

> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Changes since v4:
> > - Added "Add" to patch subject
> > - Added "(Optional)" kernel-doc of fwnode_connection_find_matches()
> >
> >  drivers/base/property.c  | 109 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |   5 ++
> >  2 files changed, 114 insertions(+)
> >
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 36401cfe432c..babab8cec7a0 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -1201,6 +1201,40 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> >         return NULL;
> >  }
> >
> > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > +                                               const char *con_id, void *data,
> > +                                               devcon_match_fn_t match,
> > +                                               void **matches,
> > +                                               unsigned int matches_len)
> > +{
> > +       struct fwnode_handle *node;
> > +       struct fwnode_handle *ep;
> > +       unsigned int count = 0;
> > +       void *ret;
> > +
> > +       fwnode_graph_for_each_endpoint(fwnode, ep) {
> > +               if (matches && count >= matches_len) {
> > +                       fwnode_handle_put(ep);
> > +                       break;
> > +               }
> > +
> > +               node = fwnode_graph_get_remote_port_parent(ep);
> > +               if (!fwnode_device_is_available(node)) {
> > +                       fwnode_handle_put(node);
> > +                       continue;
> > +               }
> > +
> > +               ret = match(node, con_id, data);
> > +               fwnode_handle_put(node);
> > +               if (ret) {
> > +                       if (matches)
> > +                               matches[count] = ret;
> > +                       count++;
> > +               }
> > +       }
> > +       return count;
> > +}
> > +
> >  static void *
> >  fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> >                     void *data, devcon_match_fn_t match)
> > @@ -1223,6 +1257,37 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> >         return NULL;
> >  }
> >
> > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > +                                         const char *con_id, void *data,
> > +                                         devcon_match_fn_t match,
> > +                                         void **matches,
> > +                                         unsigned int matches_len)
> > +{
> > +       struct fwnode_handle *node;
> > +       unsigned int count = 0;
> > +       unsigned int i;
> > +       void *ret;
> > +
> > +       for (i = 0; ; i++) {
> > +               if (matches && count >= matches_len)
> > +                       break;
> > +
> > +               node = fwnode_find_reference(fwnode, con_id, i);
> > +               if (IS_ERR(node))
> > +                       break;
> > +
> > +               ret = match(node, NULL, data);
> > +               fwnode_handle_put(node);
> > +               if (ret) {
> > +                       if (matches)
> > +                               matches[count] = ret;
> > +                       count++;
> > +               }
> > +       }
> > +
> > +       return count;
> > +}
> > +
> >  /**
> >   * fwnode_connection_find_match - Find connection from a device node
> >   * @fwnode: Device node with the connection
> > @@ -1250,3 +1315,47 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> >         return fwnode_devcon_match(fwnode, con_id, data, match);
> >  }
> >  EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> > +
> > +/**
> > + * fwnode_connection_find_matches - Find connections from a device node
> > + * @fwnode: Device node with the connection
> > + * @con_id: Identifier for the connection
> > + * @data: Data for the match function
> > + * @match: Function to check and convert the connection description
> > + * @matches: (Optional) array of pointers to fill with matches
> > + * @matches_len: Length of @matches
> > + *
> > + * Find up to @matches_len connections with unique identifier @con_id between
> > + * @fwnode and other device nodes. @match will be used to convert the
> > + * connection description to data the caller is expecting to be returned
> > + * through the @matches array.
> > + * If @matches is NULL @matches_len is ignored and the total number of resolved
> > + * matches is returned.
> > + *
> > + * Return: Number of matches resolved, or negative errno.
> > + */
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +                                  const char *con_id, void *data,
> > +                                  devcon_match_fn_t match,
> > +                                  void **matches, unsigned int matches_len)
> > +{
> > +       unsigned int count_graph;
> > +       unsigned int count_ref;
> > +
> > +       if (!fwnode || !match)
> > +               return -EINVAL;
> > +
> > +       count_graph = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > +                                                 matches, matches_len);
> > +
> > +       if (matches) {
> > +               matches += count_graph;
> > +               matches_len -= count_graph;
> > +       }
> > +
> > +       count_ref = fwnode_devcon_matches(fwnode, con_id, data, match,
> > +                                         matches, matches_len);
> > +
> > +       return count_graph + count_ref;
> > +}
> > +EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index fc24d45632eb..a5b429d623f6 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -451,6 +451,11 @@ static inline void *device_connection_find_match(struct device *dev,
> >         return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
> >  }
> >
> > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > +                                  const char *con_id, void *data,
> > +                                  devcon_match_fn_t match,
> > +                                  void **matches, unsigned int matches_len);
> > +
> >  /* -------------------------------------------------------------------------- */
> >  /* Software fwnode support - when HW description is incomplete or missing */
> >
> > --
> > 2.35.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
