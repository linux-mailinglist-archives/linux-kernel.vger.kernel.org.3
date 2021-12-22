Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CF647D5D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbhLVR1v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 12:27:51 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]:43621 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbhLVR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:27:47 -0500
Received: by mail-qk1-f180.google.com with SMTP id f138so2970496qke.10;
        Wed, 22 Dec 2021 09:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJFo5ssN3eOfvtMUqY/DK1KvvxhOaZ05yUVdW1jlagc=;
        b=40JPQ68fxCUj4iZK+iJal7+ozY2vot3XdK3Z5efMcs/JRY3LctN0rNVSDerv649ND+
         oEZ+6JnQFHMriabk7cvPOKy7pPwQlxqxREKyYR2uO7MmWnEOult4+Rxpw0vO0oYM5Nad
         wNU2Z11sbweY3PbfNsMq02c/scV9NeaSKuydzvcgTryr4ZCzXpoIIUbUStneI4GLaPxi
         teQCe7RJoabGN9j4VLws9QZ0okSLEpCghMIAfS0CQcZlDS1h6fsfv2aaOufEYfBcyWB3
         T6nJNKiZHRYbfjJMmPv0I9OaqpXSguoCqmkTP1uetkteopC/1Fwps4GRbace5OvQMClB
         95Lw==
X-Gm-Message-State: AOAM532U5yHhn7swykhekQI4nOwgCxc814mjccAnQ9wj7cmm/gP5/CsY
        R1zN8GG6qvwdlxYZEUrzeSLrrB8xzZqmkfrb/5s=
X-Google-Smtp-Source: ABdhPJwOTC8pAinTH1UeT8g2yau47BKovxdLZwk/c7jzYlwUdWC0iFL5tRZdZN+WzCsndlsV/u/EzjZHcyflLlfrS5M=
X-Received: by 2002:a37:dc45:: with SMTP id v66mr614012qki.516.1640194066357;
 Wed, 22 Dec 2021 09:27:46 -0800 (PST)
MIME-Version: 1.0
References: <20211220210533.3578678-1-clement.leger@bootlin.com> <YcMJv3TvqZkrGSMG@kuha.fi.intel.com>
In-Reply-To: <YcMJv3TvqZkrGSMG@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Dec 2021 18:27:35 +0100
Message-ID: <CAJZ5v0jgnE7rMPVEmohgYVt7ODzNkdq-ZRs4D1-hkzwXTky25w@mail.gmail.com>
Subject: Re: [PATCH] software node: fix wrong node passed to find nargs_prop
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:19 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Dec 20, 2021 at 10:05:33PM +0100, Clément Léger wrote:
> > nargs_prop refers to a property located in the reference that is found
> > within the nargs property. Use the correct reference node in call to
> > property_entry_read_int_array() to retrieve the correct nargs value.
> >
> > Fixes: b06184acf751 ("software node: Add software_node_get_reference_args()")
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Applied as 5.17 material, thanks!

> > ---
> >  drivers/base/swnode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> > index 4debcea4fb12..0a482212c7e8 100644
> > --- a/drivers/base/swnode.c
> > +++ b/drivers/base/swnode.c
> > @@ -529,7 +529,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
> >               return -ENOENT;
> >
> >       if (nargs_prop) {
> > -             error = property_entry_read_int_array(swnode->node->properties,
> > +             error = property_entry_read_int_array(ref->node->properties,
> >                                                     nargs_prop, sizeof(u32),
> >                                                     &nargs_prop_val, 1);
> >               if (error)
> > --
> > 2.34.1
>
> --
> heikki
