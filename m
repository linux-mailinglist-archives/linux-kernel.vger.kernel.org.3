Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A220259066E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbiHKSdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiHKSdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:33:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C4CB98584
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660242796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dz5R5ZNw+F9/FGCaE9Xpa/l+1/FjVP8+1bl2Y6XNQU=;
        b=J68bB5KRh1VOKItiBTk2gHvFcL8VIdwq6dIWj4zYw8+eLNePPCDPcf3+kPCJ+V9bOyn7J8
        fiHvRxLqqwxQjh38G/4vbUHWfIf/iaua0SlAVJ864o+Bha9b/uwfWmUHe3D2qni0dADVDv
        MwZGlqjribEwp7S0F0UxdFX8ccLvt4I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-141-iQVqyDp-Ory3VnTeDUUH2Q-1; Thu, 11 Aug 2022 14:33:15 -0400
X-MC-Unique: iQVqyDp-Ory3VnTeDUUH2Q-1
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b0043db1fbefdeso11338667edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7dz5R5ZNw+F9/FGCaE9Xpa/l+1/FjVP8+1bl2Y6XNQU=;
        b=VXaYm4iYjWraeBym13/DjPcg0+10vO/jaIh85XGN7Y0xFqWZlUTlA5d3JzfDte//mu
         llUufjDuvJlTTsX8LpPTTHcqyRGDv1Wn+qMX5tZvQvC8W+Yc+gYLLUXANBrwEIWGg1BS
         tMkXHx6iFxMPbQJRoEhmGNTe0C0p7rS5Sa0/yIdRngTpXfANljjdTPeX9Rxap9CFJ0Vp
         +WdPM46hkfUmDOLxJRV4FeLvOQ9ws/sq2xFbZ6WXVmujUewh2bS5oYbNX65cLxCFOien
         q95nNYROd/kMoQp5j8v+g22ECZeKwk7Jex/+JltKax2mjHcYuvoM6PJfggm0TihG1bW2
         7tgg==
X-Gm-Message-State: ACgBeo2uuK5E1JVgS/rEMnHV8VsM/tYxp/+ws/lwrPfTrGFI2nEeRuwp
        uF6Iuwf5K9oc70b72+vyR0FHyTWj/mBLfghc3IlzvQAjRlJEgasw2mgZ+euLgrInPDR0jm0vmRT
        p3xPe7yH1IYAbzBYWddZBHTXx
X-Received: by 2002:a17:907:8b97:b0:730:9480:972a with SMTP id tb23-20020a1709078b9700b007309480972amr245524ejc.648.1660242793769;
        Thu, 11 Aug 2022 11:33:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WllUicIl5uwdNr8dGWulKl9BvguFKH+7knv9r4HZiA3AtTg9mny3d4uq2XI+aRsoV3gOabQ==
X-Received: by 2002:a17:907:8b97:b0:730:9480:972a with SMTP id tb23-20020a1709078b9700b007309480972amr245507ejc.648.1660242793510;
        Thu, 11 Aug 2022 11:33:13 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0072ecef772acsm3794657ejf.2.2022.08.11.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:33:12 -0700 (PDT)
Date:   Thu, 11 Aug 2022 20:33:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-next@vger.kernel.org
Subject: Re: build failure of next-20220811 due to d79b32c2e4a4
 ("vdpa_sim_blk: add support for discard and write-zeroes")
Message-ID: <20220811183310.ttewcrfhvs4mfohz@sgarzare-redhat>
References: <YvU67iF4z5gB4ZYk@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YvU67iF4z5gB4ZYk@debian>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip,

On Thu, Aug 11, 2022 at 06:22:54PM +0100, Sudip Mukherjee (Codethink) wrote:
>Hi All,
>
>Not sure if it has been reported, builds of arm64 with clang failed to
>build next-20220811 with the error:
>
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
>                struct virtio_blk_discard_write_zeroes range;
>                ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
>                if (to_pull != sizeof(range)) {
>                                      ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
>                                to_pull, sizeof(range));
>                                                ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
>                bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
>                                                                         ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
>                sector = vdpasim64_to_cpu(vdpasim, range.sector);
>                                                   ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
>                num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
>                                                        ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
>                flags = vdpasim32_to_cpu(vdpasim, range.flags);
>                                                  ^
>drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
>                u32 num_sectors, flags;
>                    ^
>8 errors generated.
>
>
>git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
>And, reverting that commit has fixed the build failure.
>
>I will be happy to test any patch or provide any extra log if needed.

Thanks for the report, I already re-sent a new series with that patch 
fixed:
https://lore.kernel.org/virtualization/20220811083632.77525-1-sgarzare@redhat.com/T/#t

And it looks like it's already in Michael's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

Thanks,
Stefano

