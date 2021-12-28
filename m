Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5C480C81
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbhL1SYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhL1SYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:24:47 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D82C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 10:24:46 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id f9so16895665qtk.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2IL2B0lVlzDDKflM5/dU7wtOruTd4vhkwBkmfQOkqs=;
        b=uwz15lVlduYINnzR3VpaUPNFKIW6cXsPcXeSstjGPZYSzC1etybiaIXmCbL0y1UOek
         IoSdyG04WAnCN4KGBp+LqN8hjFJsp8TTW9k1xDhX6gv6MD+8fb6G0PbpXO4TDFESKVuQ
         iBJcoLwcsgNstrnyf9/FRq9AxNo/8V2uHa+sMwCE/ejPD6jMn6a008/wxy9f+tXE3XLN
         Y8eMCsDLC+fjA6vkjIhS99c4+4fBIjj+Y5G2KL5PGi8JOTK+pBjm1qzMoPuEOCgmlDiQ
         Wq660xmsF+wt8qdRC3NQbx9i20K6sCg6jbwqNJ0MfKYdwM//2/to9RuVpesTUX4RDIxX
         BvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2IL2B0lVlzDDKflM5/dU7wtOruTd4vhkwBkmfQOkqs=;
        b=DJXKCbqP4wEnSqk5P3VxHoP20GUtOLC2PPZQciXkSMs7Pvamkl58dilLfS18EhSDxX
         Gb2X2tHz61zax/5FN4xuv5uzcQXVj3l98y8jqsGOSDPnFQDWILSShjsWJrlbT1cDiC18
         dvkPOB1KTB5TraVk3vl1IuqUjSYnH2WMBbwCXFmkhUzpEaJNaqS4PcCqYLJqvlFLTzJ1
         8xpDrkGBoIDkZiVrJrJhCAnolGn730jPZ/UrKnI523uCAFu6J6A+xv94RR1gQ2GLW5Ou
         9ZuRelYzrmXpRgTKfXRFxOgWceRdgU8mQF72nfl+74yJRoX6pX7zUDJQXCsezGOTBm6V
         5LaA==
X-Gm-Message-State: AOAM533x6qid9odkvgu0S9FtYzEzkP2+QEoLPZUH7nwivYsOncJv683h
        hcVx/hB8BkSpGbOw+1m53MIV8qCEhPEJZEGns3RceQ==
X-Google-Smtp-Source: ABdhPJyM34OihwzGbuEqYf59SHZSNrRkti5xiawGB0dXZ1399Edl8FEcyIQAtfMGg6IU9j6BAcWfwP/Xe8IsRVNP9O4=
X-Received: by 2002:a05:622a:411:: with SMTP id n17mr19589076qtx.439.1640715885970;
 Tue, 28 Dec 2021 10:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20211228052116.1748443-1-bjorn.andersson@linaro.org>
 <20211228052116.1748443-4-bjorn.andersson@linaro.org> <78491489-6b31-c741-8c69-8d52fb614a6c@linaro.org>
 <YctDgaHV8dsR109L@ripper>
In-Reply-To: <YctDgaHV8dsR109L@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 28 Dec 2021 21:24:34 +0300
Message-ID: <CAA8EJpqO7-2_xNRvgTzi9nBNEpWwO6G2-97BWKg2tZFZ-WsQKw@mail.gmail.com>
Subject: Re: [PATCH 3/8] device property: Helper to match multiple connections
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 at 20:03, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 28 Dec 05:09 PST 2021, Dmitry Baryshkov wrote:
>
> > On 28/12/2021 08:21, Bjorn Andersson wrote:
> > > In some cases multiple connections with the same connection id
> > > needs to be resolved from a fwnode graph.
> > >
> > > One such example is when separate hardware is used for performing muxing and/or
> > > orientation switching of the SuperSpeed and SBU lines in a USB-C
> > > connector. In this case the connector needs to belong to a graph with
> > > multiple matching remote endpoints, and the TypeC controller needs to be
> > > able to resolve them both.
> > >
> > > Add a new API that allows this kind of lookup.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >   drivers/base/property.c  | 94 ++++++++++++++++++++++++++++++++++++++++
> > >   include/linux/property.h |  5 +++
> > >   2 files changed, 99 insertions(+)
> > >
> > > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > > index cbe4fa298413..0aa0296fd991 100644
> > > --- a/drivers/base/property.c
> > > +++ b/drivers/base/property.c
> > > @@ -1180,6 +1180,36 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >     return NULL;
> > >   }
> > > +static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
> > > +                                           const char *con_id, void *data,
> > > +                                           devcon_match_fn_t match,
> > > +                                           void **matches,
> > > +                                           unsigned int matches_len)
> > > +{
> > > +   struct fwnode_handle *node;
> > > +   struct fwnode_handle *ep;
> > > +   unsigned int count = 0;
> > > +   void *ret;
> > > +
> > > +   fwnode_graph_for_each_endpoint(fwnode, ep) {
> > > +           if (count >= matches_len) {
> > > +                   fwnode_handle_put(ep);
> > > +                   return count;
> > > +           }
> > > +
> > > +           node = fwnode_graph_get_remote_port_parent(ep);
> > > +           if (!fwnode_device_is_available(node))
> > > +                   continue;
> > > +
> > > +           ret = match(node, con_id, data);
> > > +           fwnode_handle_put(node);
> > > +
> > > +           if (ret)
> > > +                   matches[count++] = ret;
> > > +   }
> > > +   return count;
> > > +}
> >
> > This API doesn't let it's user know if there are more matches found in the
> > device tree or not. I'd suggest to add 'count' mode that would return the
> > amount of found matches if (matches == NULL) && (matches_len == 0).
> >
>
> Unfortunately in this code path we don't know how to "free" the objects
> returned by match(), e.g. see how typec_switch_match() returns wrapper
> of a refcounted device.
>
> So we must return all the match results to the caller to it can free
> things up based on its knowledge of what matches[] actually contains..

Ugh. Then we should probably return -E2BIG, -ENOSPC or any other such error.
Another option might be to split match into match & map functions,
first one returning bool and second one returning actual corresponding
object..

>
> Regards,
> Bjorn
>
> > > +
> > >   static void *
> > >   fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >                 void *data, devcon_match_fn_t match)
> > > @@ -1202,6 +1232,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
> > >     return NULL;
> > >   }
> > > +static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
> > > +                                     const char *con_id, void *data,
> > > +                                     devcon_match_fn_t match,
> > > +                                     void **matches,
> > > +                                     unsigned int matches_len)
> > > +{
> > > +   struct fwnode_handle *node;
> > > +   unsigned int count = 0;
> > > +   void *ret;
> > > +   int i;
> > > +
> > > +   for (i = 0; ; i++) {
> > > +           if (count >= matches_len)
> > > +                   return count;
> > > +
> > > +           node = fwnode_find_reference(fwnode, con_id, i);
> > > +           if (IS_ERR(node))
> > > +                   break;
> > > +
> > > +           ret = match(node, NULL, data);
> > > +           fwnode_handle_put(node);
> > > +
> > > +           if (ret)
> > > +                   matches[count++] = ret;
> > > +   }
> > > +
> > > +   return count;
> > > +}
> > > +
> >
> > Same comment applies.
> >
> > >   /**
> > >    * fwnode_connection_find_match - Find connection from a device node
> > >    * @fwnode: Device node with the connection
> > > @@ -1229,3 +1288,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
> > >     return fwnode_devcon_match(fwnode, con_id, data, match);
> > >   }
> > >   EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
> > > +
> > > +/**
> > > + * fwnode_connection_find_matches - Find connections from a device node
> > > + * @fwnode: Device node with the connection
> > > + * @con_id: Identifier for the connection
> > > + * @data: Data for the match function
> > > + * @match: Function to check and convert the connection description
> > > + * @matches: Array of pointers to fill with matches
> > > + * @matches_len: Length of @matches
> > > + *
> > > + * Find up to @matches_len connections with unique identifier @con_id between
> > > + * @fwnode and other device nodes. @match will be used to convert the
> > > + * connection description to data the caller is expecting to be returned
> > > + * through the @matches array.
> > > + *
> > > + * Return: Number of matches resolved, of negative errno.
> > > + */
> > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > +                              const char *con_id, void *data,
> > > +                              devcon_match_fn_t match,
> > > +                              void **matches, unsigned int matches_len)
> > > +{
> > > +   unsigned int count;
> > > +
> > > +   if (!fwnode || !match || !matches)
> > > +           return -EINVAL;
> > > +
> > > +   count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
> > > +                                       matches, matches_len);
> > > +
> > > +   return count + fwnode_devcon_matches(fwnode, con_id, data, match,
> > > +                                        matches + count,
> > > +                                        matches_len - count);
> > > +}
> > > +EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
> > > diff --git a/include/linux/property.h b/include/linux/property.h
> > > index 16f736c698a2..59484ccb260e 100644
> > > --- a/include/linux/property.h
> > > +++ b/include/linux/property.h
> > > @@ -444,6 +444,11 @@ static inline void *device_connection_find_match(struct device *dev,
> > >     return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
> > >   }
> > > +int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
> > > +                              const char *con_id, void *data,
> > > +                              devcon_match_fn_t match,
> > > +                              void **matches, unsigned int matches_len);
> > > +
> > >   /* -------------------------------------------------------------------------- */
> > >   /* Software fwnode support - when HW description is incomplete or missing */
> >
> >
> > --
> > With best wishes
> > Dmitry



-- 
With best wishes
Dmitry
