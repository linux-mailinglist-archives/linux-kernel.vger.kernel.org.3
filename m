Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963C547CA0E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbhLVAJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhLVAJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:09:07 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FEC061401
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:09:07 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id p4so695359qkm.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p6IPtjYLk9ApU3C7Ntq5pzotDKFMZC8bLzlwMwv2DHo=;
        b=gdeWu7dcldq1KRDtXrK466kfK8ZpHrcRgPVzyQPYoZHEx9qR5NNRQnXdVTPhjY05pS
         VX54P/WP7bBdN0Y2YviUR+IzQczADq36rQPDvSeBSlR5CzNBM9hnUWmpeLwh1zOgIfG4
         T1ItolfMfK71PTBrsf594uOVGuRXfsMiL7rUYjcaQdrzDkXfR72il5m2jMYTcW+/hd/4
         pJXYLsW1GpV4xGgUZjfQk/9GLjuyd3LG4uiIxEhBeAPgio5IpswJHOM1wzN1JoffZwqF
         0w74l8kyv5Y2z+6wvMkdK3wXIuGOEzR/6OvL6lryE3Ism03q74Y3rB7rEvGeBhEU3L/r
         JRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p6IPtjYLk9ApU3C7Ntq5pzotDKFMZC8bLzlwMwv2DHo=;
        b=jc19IE19E9/vpwVM95QOnKoO0rKe5YQeqdWqorDeGQ58zI8T/vxJDhHhqdxrTtHm/7
         2mha6w0J6vEvjrHDD4ryXVfhzyc3Q+Pxs1UfPKu07HTH4s4aMNgeU0LBp8IulpZbdJLp
         z6dz25prGSrNg9R5zUFI0WOuzawmyy3HrQa+McfO0sQJKyKq1D+uXzhVezMvD/AdkWw+
         gtJQ6AfuUhrDtRn6jum3S6QZhk18qQZf+L6mSOx9yprlOicnFQ+ai2TZpKXy3JBiPtbz
         sSUfP8p2X4154pgFrtRQAQKzt6WQjL+eJjpkZIkZ8d12HQUX1RkCTmlJn1OTa9Jsr5Qw
         U+cA==
X-Gm-Message-State: AOAM532Nr4lKyMMU6FfjuZs8J1u/EhEMeQ7JLRG6SckA+qtlRUwcQMkB
        ijTKZti3bUuStyA91wWcK888EQ==
X-Google-Smtp-Source: ABdhPJxZLJ+lxeM7m6HgpAAgvnFViXb+v/+egaiwjU9Z/pHPuR+zNWgaBbyZ73XdGEkhpy4k4oD6XA==
X-Received: by 2002:a05:620a:4687:: with SMTP id bq7mr553892qkb.231.1640131746529;
        Tue, 21 Dec 2021 16:09:06 -0800 (PST)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id h2sm457177qkn.136.2021.12.21.16.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 16:09:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mzpBp-007GVm-3o; Tue, 21 Dec 2021 20:09:05 -0400
Date:   Tue, 21 Dec 2021 20:09:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     gregkh@linuxfoundation.org, mustafa.ismail@intel.com,
        shiraz.saleem@intel.com, dledford@redhat.com, leon@kernel.org,
        saeedm@nvidia.com, davem@davemloft.net, kuba@kernel.org,
        vkoul@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, mst@redhat.com,
        jasowang@redhat.com, andriy.shevchenko@linux.intel.com,
        hdegoede@redhat.com, virtualization@lists.linux-foundation.org,
        alsa-devel@alsa-project.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/4] driver_core: Auxiliary drvdata helper cleanup
Message-ID: <20211222000905.GN6467@ziepe.ca>
References: <20211221235852.323752-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221235852.323752-1-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 03:58:48PM -0800, David E. Box wrote:
> Depends on "driver core: auxiliary bus: Add driver data helpers" patch [1].
> Applies the helpers to all auxiliary device drivers using
> dev_(get/set)_drvdata. Drivers were found using the following search:
> 
>     grep -lr "struct auxiliary_device" $(grep -lr "drvdata" .)
> 
> Changes were build tested using the following configs:
> 
>     vdpa/mlx5:       CONFIG_MLX5_VDPA_NET
>     net/mlx53:       CONFIG_MLX5_CORE_EN
>     soundwire/intel: CONFIG_SOUNDWIRE_INTEL
>     RDAM/irdma:      CONFIG_INFINIBAND_IRDMA
>                      CONFIG_MLX5_INFINIBAND
> 
> [1] https://www.spinics.net/lists/platform-driver-x86/msg29940.html 

I have to say I don't really find this to be a big readability
improvement.

Also, what use is 'to_auxiliary_dev()' ? I didn't see any users added..

Jason
