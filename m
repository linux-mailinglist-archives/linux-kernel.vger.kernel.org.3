Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E914A531221
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiEWOQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236992AbiEWOQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:16:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A853A60
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:16:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id g3so12599584qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 07:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H767C2i0qpntP2Hc25tbjn02oMYnv32wuUYy29Xv2ng=;
        b=VKeQ6xPhdr+J56IKqkCNNphoFA9/Dp/YQhSmkGwfWDKX1rbeX8HmFE31UJPFRkHOFx
         uEhxIkgD8DHNx4OWFSVU1Nqh6ZQwz7m/4I5ANeTsgKMLiKJLRkc35PzktklEcXUTAWp1
         MMPXycGF/aRmwO5QdDU2rJ1O32iAeffGYuTnGw2LAmGa4n1yzj5y+FLvaTbCp676rYBH
         //o4NKTmMCRpfHL/yl5hNQvqG5opsemec2n3ZTxWXnYwr0ITu1IO6e/47ZJIXEIt22+u
         jtmbKxyXVxT2hxvIl6MDdYWeJe5FeELdljLp9cAYp8viRD9ZX1IEroTJZ41CkKrDo+zN
         qx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H767C2i0qpntP2Hc25tbjn02oMYnv32wuUYy29Xv2ng=;
        b=fGAw08k5K9OIucjO17D3qyLwmHSyjupnr16eSgVAhCerlmq4KZ/ac2ukL5lVUQLxS8
         UJFMUW9xmE8ZASsIN8zH2iWHGh8RKtAyiOb/K2aJxRhgiZrOwUK8Ie6s70NQNEtEyWjk
         cQx/DzGnl+gWKWCuad5PIGbZvUW9vKWIwgGQmMqM7m5kxdp+uiR83Ei4FDs4PsU37x6N
         4dg4rbxyncoExgESo6Y1R4OHvQkD03bubcmZgplF9YWzgaoUWw1bLKd25/1IdroZKzwX
         09YEXy6y3Utf9On1AgYFmTPeUwqoPpBWUXu+ttI9DhcFP8dq3k9i5apZtVhi1QnIwFT5
         EMJQ==
X-Gm-Message-State: AOAM530qnru6gc6UKNAUI5OTk4l5nd8/5EHSBF8IJRJs3jIYh83eizUL
        r859g61MKa1N7PJ8zHG3iz3MQ/eHxU0spA==
X-Google-Smtp-Source: ABdhPJyWvmxgvwQh77GvbLiPrvty8oAChia/sMMFwbpgZEYfGVYSwOCRw3DbsadOlhmz2+uVGVAMsQ==
X-Received: by 2002:ac8:5889:0:b0:2f3:bb3f:b0d2 with SMTP id t9-20020ac85889000000b002f3bb3fb0d2mr16130738qta.593.1653315376387;
        Mon, 23 May 2022 07:16:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c19-20020a05620a165300b0069fc13ce1e5sm4348806qko.22.2022.05.23.07.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:16:15 -0700 (PDT)
Date:   Mon, 23 May 2022 10:16:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next v3 6/6] nbd: use pr_err to output error message
Message-ID: <YouXLg33YEIuV2aO@localhost.localdomain>
References: <20220521073749.3146892-1-yukuai3@huawei.com>
 <20220521073749.3146892-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521073749.3146892-7-yukuai3@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 03:37:49PM +0800, Yu Kuai wrote:
> Instead of using the long printk(KERN_ERR "nbd: ...") to
> output error message, defining pr_fmt and using
> the short pr_err("") to do that. The replacemen is done
> by using the following command:
> 
>   sed -i 's/printk(KERN_ERR "nbd: /pr_err("/g' \
> 		  drivers/block/nbd.c
> 
> This patch also rewrap to 80 columns where possible.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
