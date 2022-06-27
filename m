Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395F355DCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiF0TGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240035AbiF0TG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:06:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5402639
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:06:24 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 23so9939659pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OwptFnOeVufNyWYVaUbNezAsNgxBLnSp5YRWWMPGeU4=;
        b=Nep8adCrywMhk8ZutjZQ3tfryiXOviRDQw/MQJ/JqaCRwLAZt0pJQkuJPU5dUZf0T8
         mzkjbRZ2Ht+PdUAcSPscDpb9zx/DbqWcULKOOejsjs9DKG/rTHE+7L/G+JDzAmlu5xbC
         cXz3xW2lTdrodfN1MJJZBsb4eykNpRuRhXsMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OwptFnOeVufNyWYVaUbNezAsNgxBLnSp5YRWWMPGeU4=;
        b=Pj79NCCFlRTH1vhE8VWv6FNmgBzj7tQf77pchMIWRq08Odli5ldm+VqyccZGmOlZxz
         vlqDGU7bkuFWBN/O3E7QA1Din8NdotlEgPCYITVWx+doghi+KBYRpWA0lYIdWRx1lULp
         gs4HJq2Zkl5VYLxDsHF69eLSREXunXfNlBVVkuR9Q3MHsK6/TEZXJtsWJlBFlLrhfj7u
         iTvm7uv9ZKjhNWACQ5A4vv8AZ+RsX3/3jMmByifiui774NkUwDzxpEA1UTiCxvsxK465
         JMOXOpct5tQNZY7yrksgK1oQMLKQOLZ9wOG8YY7xYUl9hycCQkPgjNrd/JejawCNyWyB
         kjKA==
X-Gm-Message-State: AJIora/FtP0P/qRLbMcUm7EQbRB4Plnu6hBw7MxtUb1CzFL/7lVurh1Z
        RlZrveQBK61XxmXqDK3yemUrcQ==
X-Google-Smtp-Source: AGRyM1uzKMX8lc3yOB65UK4bfLsFrTm5HeZk66lgKZ+5KpmhBSQTuno7q2Sp0F6BljBpXtnRsGe1DA==
X-Received: by 2002:aa7:989a:0:b0:525:252f:3c51 with SMTP id r26-20020aa7989a000000b00525252f3c51mr510250pfl.39.1656356784404;
        Mon, 27 Jun 2022 12:06:24 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f31c:687c:3a61:62c5])
        by smtp.gmail.com with UTF8SMTPSA id f9-20020a170902f38900b0016a51167b75sm7523839ple.286.2022.06.27.12.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:06:24 -0700 (PDT)
Date:   Mon, 27 Jun 2022 12:06:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH v22 2/3] usb: misc: Add onboard_usb_hub driver
Message-ID: <Yrn/rfrzSWod5SCT@google.com>
References: <Yqub17iT4O7aqFMi@google.com>
 <CAD=FV=VEztPLhsrJecZUdyHCW7ZfFTVvxyqY5CqRVv2mWyrLog@mail.gmail.com>
 <YquoSMiQS+RG8rOM@google.com>
 <CAD=FV=W81pSEUbzw2ZQgs_TJ9MLnHQHiDopZXZ6bHdS7QMzAyA@mail.gmail.com>
 <YqvMffveCPiKQEUk@google.com>
 <CAD=FV=UJOStPfRR3Hq2DmRBSH-HCtZ16hAU9eVH5w6Hm=WSJRQ@mail.gmail.com>
 <YqytDNB2y4+qT8GD@google.com>
 <CAD=FV=UT0XtMjZ9syQPGXeTEaUrwGTb_LgDow+cofgmx4D30VA@mail.gmail.com>
 <Yrnzl8k81f9JTMIQ@google.com>
 <Yrn8y4GGZm+NyXIi@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yrn8y4GGZm+NyXIi@rowland.harvard.edu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 02:54:03PM -0400, Alan Stern wrote:
> On Mon, Jun 27, 2022 at 11:14:47AM -0700, Matthias Kaehlcke wrote:
> > Maybe a bit more verbose documentation like this could help:
> > 
> >   Some background about the logic in this function, which can be a bit hard
> >   to follow:
> > 
> >   Root hubs don't have dedicated device tree nodes, but use the node of their
> >   HCD. The primary and secondary HCD are usually represented by a single DT
> >   node. That means the root hubs of the primary and secondary HCD share the
> >   same device tree node (the HCD node). As a result this function can be
> >   called twice with the same DT node for root hubs. We only want to create a
> >   single platform device for each physical onboard hub, hence for root hubs
> >   the loop is only executed for the primary hub. Since the function scans
> 
> By "primary hub", you mean "root hub for the primary HCD", right?  This 
> should be clarified.

Ok, thanks for the suggestion!

> >   through all child nodes it still creates pdevs for onboard hubs connected
> >   to the secondary hub if needed.
> 
> And likewise for "secondary hub".
>
> > 
> >   Further there must be only one platform device for onboard hubs with a
> >   companion hub (the hub is a single physical device). To achieve this two
> 
> What do you mean by "companion hub"?  I think you are using the wrong 
> word here.  If you're talking about the relation between the two logical 
> hubs (one attached to the SuperSpeed bus and one attached to the 
> Low/Full/High-speed bus) within a physical USB-3 hub, the correct term 
> for this is "peer".  See the existing usages in hub.h, hub.c, and 
> port.c.
> 
> "Companion" refers to something completely different (i.e., the UHCI or 
> OHCI controllers that handle Low/Full-speed connections on behalf of a 
> High-speed EHCI controller).

Yes it's the relation between the two logical hub. The term 'companion-hub'
stems from the binding and has been around since v6 of this series. I guess
we should update the binding if the terminology isn't correct.
