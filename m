Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2284617DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347756AbhK2OWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 09:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377794AbhK2OUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:20:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5BC08EB26
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:58:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso12323066wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6A67fbHx2MO5BuK4b671y5tVZE/grLXUd1QZNrRTMeg=;
        b=khXVUQzs0+UG00jtUwYnjNp/nCKqykcCUh5fwfgFabnBNEyBuro/1E9FjDyAiuLOTp
         T5Jk0a5ejBLRWJMiVFJKGk8f3egtmmcA1qknQqqvkgc2dNhq7yzLMZIJ6EizQI8TzqMZ
         KZjZdhC3xPtViAVMxD2Vtdwl7soWy/W35HCWynFzJ5EF6CCh1BrqpkgzYmpei0vUJrC1
         i6Z58ECXkB7kihx6iizsUjMO5hm8GYbVyiZanr7IT3xfffi7emlgNu5INgatWuLFbd30
         QdeRSBhX3FJVkUn8I5Vw1nZYn3pBY5jyoRiadpeFP7frLRZRUDeAxrLRjY55dCq9lbWT
         x82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6A67fbHx2MO5BuK4b671y5tVZE/grLXUd1QZNrRTMeg=;
        b=AUNLDPSWkTYRU6GzNv/ZE9Ox4edfZpO9aIl9i67X1tX6qatS4i6WOxGnEU8AP9zEkv
         RXGCWxpxGvyt2Rx8dAyFVHb9NDQ10EeEQlHMumBe2YPR6rukBX3WcBWBwd+38fEwlPV+
         1awD3zBhQ52OVq7mURX8I9l+UIVUdii3L4oBIV77dxgq5F5ewsuE2iKEqJHXjAl3B5Yh
         y6nhqg8wro4VAJLc4ZiovedNcAtM09UUY+LnHmaSgNXAZKGZh9n333S9ZsgXVlTagPq6
         4Y7aHT4cXRGXw3tnxnfIMXnDHa+b0sS/Qo6B7FX68CWtY7PAU9qRl0Dwv9UXsN0ImDmn
         AQnA==
X-Gm-Message-State: AOAM530I6HuXJuO9AFUh7mFoIwET1kStCvugaJ+DKzBKMzvvWKTUOpJf
        rqvGJA5C9A9VISfkge2ndvZFUzVpN+m9zg==
X-Google-Smtp-Source: ABdhPJwprWYGma5BErTQlhxL9wdHIHIcnqIw6U30kRO8bZEnCyZa5PJr0SaXm89lP+MiTZkl3xn+1g==
X-Received: by 2002:a05:600c:a42:: with SMTP id c2mr36846556wmq.154.1638190719493;
        Mon, 29 Nov 2021 04:58:39 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id t127sm20654711wma.9.2021.11.29.04.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:58:39 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:58:37 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
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
Subject: Re: [PATCH 4/9] drivers: Switch to kvfree_rcu() API
Message-ID: <YaTOfSi99jV6EGfM@google.com>
References: <20211124110308.2053-1-urezki@gmail.com>
 <20211124110308.2053-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211124110308.2053-5-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Uladzislau Rezki (Sony) wrote:

> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> CC: Philipp Reisner <philipp.reisner@linbit.com>
> CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> CC: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> CC: Lee Jones <lee.jones@linaro.org>
> CC: Jorgen Hansen <jhansen@vmware.com>
> CC: Raju Rangoju <rajur@chelsio.com>
> CC: Saeed Mahameed <saeedm@nvidia.com>
> CC: Boris Pismenny <borisp@nvidia.com>
> CC: Jiri Pirko <jiri@nvidia.com>
> CC: "James E.J. Bottomley" <jejb@linux.ibm.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/block/drbd/drbd_nl.c                       | 9 +++------
>  drivers/block/drbd/drbd_receiver.c                 | 6 ++----
>  drivers/block/drbd/drbd_state.c                    | 3 +--
>  drivers/block/rnbd/rnbd-srv.c                      | 3 +--
>  drivers/crypto/nx/nx-common-pseries.c              | 3 +--
>  drivers/infiniband/hw/hfi1/sdma.c                  | 3 +--
>  drivers/ipack/carriers/tpci200.c                   | 3 +--

>  drivers/mfd/dln2.c                                 | 6 ++----

I'm not an expert in this API, but the premise and changes to MFD seem
fine at first glance:

Acked-by: Lee Jones <lee.jones@linaro.org>

>  drivers/misc/vmw_vmci/vmci_context.c               | 6 ++----
>  drivers/misc/vmw_vmci/vmci_event.c                 | 3 +--
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c    | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   | 3 +--
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c | 3 +--
>  drivers/net/ethernet/mellanox/mlxsw/core.c         | 3 +--
>  drivers/scsi/device_handler/scsi_dh_alua.c         | 3 +--
>  drivers/scsi/device_handler/scsi_dh_rdac.c         | 3 +--
>  drivers/staging/fwserial/fwserial.c                | 3 +--
>  17 files changed, 22 insertions(+), 44 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
