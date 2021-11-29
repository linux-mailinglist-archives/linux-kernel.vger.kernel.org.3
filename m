Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05DD461FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbhK2S5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbhK2SzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:55:15 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9EC0613B7;
        Mon, 29 Nov 2021 07:18:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so8079691edq.7;
        Mon, 29 Nov 2021 07:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fg0HkMGTtAqcFYEZKN7N7vH4aKzmXNmYwj8fXsChyOg=;
        b=JmE/DPMH5haneeMqZwupEKtjlGdRguyJm8OZ0wOHoRze2usTTnHh0roJZw3EFkJiw/
         Ntnr3+ZqpYV5iR82WsabZJgz0HfaYWeMpK90VgAbHUbVq4YcXNaTMXMywnlS0CJRMqE8
         uDEme4Xpho3vAsvqv+TyhGsCfuLvMMpoSRo+KJocbc3ZooFWUs3lnu9dY0kkLZiWCIcL
         gSqlGJgIHQWmDwsLtC++W3c2clSYBOFgx02/rO5OXew/rGWm6g2xdt9be3h6FEJX/2Gr
         QxjSXeoARLsRFjTmqmHP0T21Kqlp/R1ef2CoNFnKogwUjh6qGP4COa2fz5GkrfIOqIZt
         //KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fg0HkMGTtAqcFYEZKN7N7vH4aKzmXNmYwj8fXsChyOg=;
        b=nwSAhO6Ecof1GaJH5NlkuWsuFHpY3qmaRVAsca6YZeQ5rqXbFizToY//ti1LN2d5sZ
         zaPr4HPruCrx9+2sANbGvKHqqVV3btawZKkvwFaaVkiOJhs7wPta6sxFkHlPTxbx/i30
         I4kzJEejBkvguTQ3Wpt7+NGkKz1gaflUO5WMUuYUE4SOFxtE18gwkjZcvfmZR775+n4u
         eRo9fJfXCYI661j830m6bQ1wBd0EBQMax+S3YY6AwJs3Lz/5C2QQov/6iGRZ0QIJG3G5
         gpoOjbTEI9y7/Tf8K7rOhehCzl5PQtElx24dlmeUI+YCtNdTKOYuc8915gMKV+eftWM0
         8XXg==
X-Gm-Message-State: AOAM531sbCoA5VsySIawE36oet21DcJMVpiH2zeH1+OBRAh60laxHO72
        qqhzQrdH2FIr5h0/tMoJOqgadSWweMZuKJYxzgk=
X-Google-Smtp-Source: ABdhPJzNMsNraGASkuPlByhgCetFGAevsRWNgpotvjY0hj2PsCm1suVH+BRbjxHhrU020nta+H8a1+ray/wFhb1wZEk=
X-Received: by 2002:aa7:c78f:: with SMTP id n15mr76072167eds.344.1638199115241;
 Mon, 29 Nov 2021 07:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20211124110308.2053-1-urezki@gmail.com> <20211124110308.2053-5-urezki@gmail.com>
 <YaTOfSi99jV6EGfM@google.com>
In-Reply-To: <YaTOfSi99jV6EGfM@google.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Mon, 29 Nov 2021 16:18:24 +0100
Message-ID: <CA+KHdyV2j8LFC4JssD_xc3m5H_pNfn1jraWg0pWgTqrX+OHjUw@mail.gmail.com>
Subject: Re: [PATCH 4/9] drivers: Switch to kvfree_rcu() API
To:     Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 1:58 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 24 Nov 2021, Uladzislau Rezki (Sony) wrote:
>
> > Instead of invoking a synchronize_rcu() to free a pointer
> > after a grace period we can directly make use of new API
> > that does the same but in more efficient way.
> >
> > CC: Philipp Reisner <philipp.reisner@linbit.com>
> > CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> > CC: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> > CC: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> > CC: Lee Jones <lee.jones@linaro.org>
> > CC: Jorgen Hansen <jhansen@vmware.com>
> > CC: Raju Rangoju <rajur@chelsio.com>
> > CC: Saeed Mahameed <saeedm@nvidia.com>
> > CC: Boris Pismenny <borisp@nvidia.com>
> > CC: Jiri Pirko <jiri@nvidia.com>
> > CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  drivers/block/drbd/drbd_nl.c                       | 9 +++------
> >  drivers/block/drbd/drbd_receiver.c                 | 6 ++----
> >  drivers/block/drbd/drbd_state.c                    | 3 +--
> >  drivers/block/rnbd/rnbd-srv.c                      | 3 +--
> >  drivers/crypto/nx/nx-common-pseries.c              | 3 +--
> >  drivers/infiniband/hw/hfi1/sdma.c                  | 3 +--
> >  drivers/ipack/carriers/tpci200.c                   | 3 +--
>
> >  drivers/mfd/dln2.c                                 | 6 ++----
>
> I'm not an expert in this API, but the premise and changes to MFD seem
> fine at first glance:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>
Thanks!

--
Uladzislau Rezki
