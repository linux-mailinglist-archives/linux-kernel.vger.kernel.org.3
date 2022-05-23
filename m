Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A54531255
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbiEWOPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236963AbiEWOPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:15:08 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4956208
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:15:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id dm17so12181155qvb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gQqSOYtXKCovkcmnzORDeqKEFCpsqidTzONhfpIe2p8=;
        b=vKzkSS4bG/EMe1SPtyOi4LEBAkEGV2enoBPonfxF5+4AHmjNpTtXnkLCtnsq1Xvv4E
         GRj2+N6KpPbAADnV+7fmpgdvsnDrtiFG0VHZHXYc2wmTv1OuSsorJB5WEHpKzoWjwPDK
         k/2mK+W3ZAz/FFJH8JVyAWRpGymYz/1QpgK3gN37JahC01zUcT9mw6ih78Q7mJIjgk2b
         e0tuPxiCmo1HZalzLh1IKi7nXy/VvodzIaVloi9hV6P6z3MRtbx1R22n2ErtrQX02rrJ
         ynewHtDppmBXIgCvptEaLRNoiTYOfmguW5gh1HSDcIVTXzQV9sckJFu8Ss0fIISRK2nE
         iwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gQqSOYtXKCovkcmnzORDeqKEFCpsqidTzONhfpIe2p8=;
        b=PhII/F26UCH4GGHn+dVsCiQ5zSpZ9OlRbtlgDmntJzEPwz/v0gC0Yzl9kQdaK81Bix
         J37xQu6YllHNksbBqDuXzdelUbgNPwzDSnldBqZ6fyqcAUianzM5XwC0k+3QSdbbklbU
         Tqy4x/Iqlf1r6ELKNpB3E7qKXVy3/X9uzwOuMG2/959mXRgLKoaJI1awgtRUX5oX1S6g
         VrGo1WVGETJLKQiHu4Os6mjm3rqng8YAg9lzoVP/VjKV9LEr7+KynfnjdFWhrKwYrz+7
         g/Zs4E9okqI7f8iNISDHz7V5zBrc4Wds2j9vcmzeofToCNxDSUPn4lzOEV4rDbqV5W9R
         wAAQ==
X-Gm-Message-State: AOAM533h+wLIBXosGiiSf0mridOfSmh1DTg3lgZ9zhEtnXciSeLh+uiu
        siwxe0MNXnnYgEutI2fmvt/Pqfjh6g3sYg==
X-Google-Smtp-Source: ABdhPJwQ9+RAgP4Mkgg0O5FGiPJWPkwcW/SbB9MFOMsl2KVNW+Wyah4aI6YwsGVPAxrC4/jG/5Kaig==
X-Received: by 2002:a0c:e7c7:0:b0:461:e559:18d0 with SMTP id c7-20020a0ce7c7000000b00461e55918d0mr17285270qvo.2.1653315300574;
        Mon, 23 May 2022 07:15:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k17-20020a05620a139100b006a367e8d954sm4096141qki.118.2022.05.23.07.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:15:00 -0700 (PDT)
Date:   Mon, 23 May 2022 10:14:59 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 2/6] nbd: fix race between nbd_alloc_config()
 and module removal
Message-ID: <YouW4zDFENSvO5Kv@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-3-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-3-yukuai3@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 03:37:45PM +0800, Yu Kuai wrote:
> When nbd module is being removing, nbd_alloc_config() may be
> called concurrently by nbd_genl_connect(), although try_module_get()
> will return false, but nbd_alloc_config() doesn't handle it.
> 
> The race may lead to the leak of nbd_config and its related
> resources (e.g, recv_workq) and oops in nbd_read_stat() due
> to the unload of nbd module as shown below:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000040
>   Oops: 0000 [#1] SMP PTI
>   CPU: 5 PID: 13840 Comm: kworker/u17:33 Not tainted 5.14.0+ #1
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>   Workqueue: knbd16-recv recv_work [nbd]
>   RIP: 0010:nbd_read_stat.cold+0x130/0x1a4 [nbd]
>   Call Trace:
>    recv_work+0x3b/0xb0 [nbd]
>    process_one_work+0x1ed/0x390
>    worker_thread+0x4a/0x3d0
>    kthread+0x12a/0x150
>    ret_from_fork+0x22/0x30
> 
> Fixing it by checking the return value of try_module_get()
> in nbd_alloc_config(). As nbd_alloc_config() may return ERR_PTR(-ENODEV),
> assign nbd->config only when nbd_alloc_config() succeeds to ensure
> the value of nbd->config is binary (valid or NULL).
> 
> Also adding a debug message to check the reference counter
> of nbd_config during module removal.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
