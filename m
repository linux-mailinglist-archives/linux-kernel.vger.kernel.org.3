Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114CC4AF6B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiBIQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiBIQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:30:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD4C0612BE;
        Wed,  9 Feb 2022 08:30:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id f17so5077864wrx.1;
        Wed, 09 Feb 2022 08:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCekoNAsz0CKcPwcVF/KWz963J+qSXSU1YJ6x+zUwaM=;
        b=qh+PJYTJ5oyXPzeL3E+0rzGxo+DHUp8jHmCfBnUKrl6PG9xlEQ25rYzA2jk1QPOukq
         +I+EibDd6oMU7hK4k+RRuf0eTvc5gEPc0G+8oVZHX1caq94TIhDCviljMlnXB1QJuN0c
         0aYxJVQly/6XnjB3b9u9OlOw0lOBhQnpL4unuv0Z394CNxDTt1DXm1IycCS+tcwVTtFu
         UApfxpTYtTmbLPHYngbjvg1g3RTL8G0jeK+IInbnUIPf56JY7DVOZH04ZuWOgDQ/vkiD
         MVM4x49Rcc5JDhMqdvwcC3iJhA+B3CmXPLxfgzJ1qHY2858YRx8AnACnUtL4ZsH65rw+
         PD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TCekoNAsz0CKcPwcVF/KWz963J+qSXSU1YJ6x+zUwaM=;
        b=NoSSFCw/olXR2C45lciqO6Hc9YEwNlyA/+YzKbXjdi5i9UxkUsR9mSuAdv4tseB0E5
         Bq7IbOIB0TnM8UHMUS+DplyB7amN+92W4uMDzEGPyOTnHpzI4N6brg78niAtwv4UGLgG
         nvCkchQJLeqSt18gQbmCmeGAIix2XVBNqV1bhaRDc3fK4vuDi+GOm/89Bh/yhDhMsXFM
         LpIFeH+Z2iMB1W5YSt2OlW9blvyIPU6MwtOw8SHtPh37HVM8ySP/D2TJKDhtE8swoa/O
         1sPNvGReevL4iLpCpDPHvygfhKFWxBvkRKw+NXLzNg+R6Dln6weRUNRUlE2ZYnDLX+NB
         twSQ==
X-Gm-Message-State: AOAM531QvuXvAdPFmL3pkOfNJtEpuliz4TO3s4lBFe6hgospQAdD4JyF
        HtlUslvej2tQq50UMW7Vvd8=
X-Google-Smtp-Source: ABdhPJxWLblgDOqQhOcUPkMpyv6/T7RSuVsXksjpUA3MctF2Nhiv8NtQEHbPtDFW2x4ojiq8ZRbr8g==
X-Received: by 2002:adf:dd50:: with SMTP id u16mr2776373wrm.696.1644424228349;
        Wed, 09 Feb 2022 08:30:28 -0800 (PST)
Received: from leap.localnet (host-95-245-2-16.retail.telecomitalia.it. [95.245.2.16])
        by smtp.gmail.com with ESMTPSA id p7sm5228901wmq.20.2022.02.09.08.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:30:27 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
Subject: Re: [PATCH] usb: core: Unregister device on component_add() failure
Date:   Wed, 09 Feb 2022 17:30:24 +0100
Message-ID: <2094517.irdbgypaU6@leap>
In-Reply-To: <YgPI6RQd/9I4/51p@kuha.fi.intel.com>
References: <20220208170048.24718-1-fmdefrancesco@gmail.com> <YgPI6RQd/9I4/51p@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled? 9 febbraio 2022 15:00:09 CET Heikki Krogerus wrote:
> On Tue, Feb 08, 2022 at 06:00:48PM +0100, Fabio M. De Francesco wrote:
> > Commit 8c67d06f3fd9 ("usb: Link the ports to the connectors they are
> > attached to") creates a link to the USB Type-C connector for every new
> > port that is added when possible. If component_add() fails,
> > usb_hub_create_port_device() prints a warning but does not unregister
> > the device and does not return errors to the callers.
> > 
> > Syzbot reported a "WARNING in component_del()".
> > 
> > Fix this issue in usb_hub_create_port_device by calling device_unregister()
> > and returning the errors from component_add().
> > 
> > Reported-by: syzbot+60df062e1c41940cae0f@syzkaller.appspotmail.com
> > Fixes: 8c67d06f3fd9 ("usb: Link the ports to the connectors they are attached to")
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/usb/core/port.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > [...]
> >
> You didn't remove the peer links. Either remove them here separately,
> or alternatively you can also just shuffle the code so that you only
> create those links after the component_add() call:
>
> [...]
> 

Hello Heikki,

Thanks for your review and suggestion. I think that I'll use the second of the
two possible solutions (shuffle the code).

I had to spend some time to understand the code of usb_hub_create_port_device(),
component_add() and component_del(). Unfortunately, the USB core is very far from
the usual things I look at or care of. Therefore I missed that find_and_link_peer()
does some work that must be either unwound or simply postponed. I agree with you 
that the latter is the best solution.

I need some minutes to submit v2.

Again, thanks,

Fabio

> thanks,
> 
> -- 
> heikki
> 




