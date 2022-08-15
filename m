Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3A1592E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiHOLYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiHOLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:24:19 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD5E20F40
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:24:18 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-10e6bdbe218so7827259fac.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nZKRK6PqpP9DzZexrnN2X0Qb/e767BxaO5vGQnjget0=;
        b=rUAYoxNnI93ew8bxi9wgUMPjWeUoUDnG6Nj9o52dVkR2NlEGfl91GFzFSx79b35ysF
         B1/f8iqHvCTg/tXiPf3LIWX/oklVsJ7tVX70T4va49yXdi08istOw26actUfiqZb+vah
         9z6C3LLtxGrzUnJY1PszhLsgm1YkVdIstQG++4/Ynocf2OedbOgtDwb/H+MXDXGzanRY
         DadyoocQgJopr1HKQyZimw656KC+mmSB0JBGK5gr6LIB9Z4jLG6lkpq4sqoDS9+HUFy8
         +AYFuSacPLChDp5qNt8NFyWGvjbuq7p1FuZeUMvW9PJ4rgDl/6Qbna78pReiWl05XsvO
         dwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nZKRK6PqpP9DzZexrnN2X0Qb/e767BxaO5vGQnjget0=;
        b=wi+65Zf3pevgDVXRf7hT/TX4stJp/sgwdRQ/MvpqYIIFeO2bTFPZyoaMUwe4b/Jcx3
         amGN0P8wxrwlxdwAP7kakk/vmiNlEFkyzIoQsOe/40uYcQKm3cy4/uaWbVFBEpLs8mQu
         1RAcR1I/+9D19+D6jREfog1dZkEP0SJjlFv0EnUTtsjCkS03aMMKroSlM3khyUqUubMd
         zUM+Pl+lu3pPZz/oXBSKUVNAOoIwCONbdlPjxgfZEydUO2ECNaZbqbzGrAgZfDm16aUs
         XcxrGmKh94HKe2Zpjqxe3FaXVsVi1K4yKJaSVDpdU7KdrIFXPWuRWQr98nIKg5bwFol0
         ZdNw==
X-Gm-Message-State: ACgBeo30tN+QC3RwuDVyxdKSdfXt5TeB7flsHq0G1agN6zBa8roLfhGP
        Z+UMi4GrUEMWH81KTipzclLOP2PAgLztegmfBGpLYg==
X-Google-Smtp-Source: AA6agR6wiP+vKr9ua4UscIVhTqUu7BG3rnpd+PJHlpopLMa7eQFclmDrowFtZDXtA0ZVOeaXnXx/ZkvJL/VIvqyLTbg=
X-Received: by 2002:a05:6870:b28a:b0:10f:72f:6c with SMTP id
 c10-20020a056870b28a00b0010f072f006cmr6274489oao.148.1660562657764; Mon, 15
 Aug 2022 04:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220811125156.293825-1-mst@redhat.com> <166030021657.10916.8438944707929097441.git-patchwork-notify@kernel.org>
In-Reply-To: <166030021657.10916.8438944707929097441.git-patchwork-notify@kernel.org>
From:   Andrew Melnichenko <andrew@daynix.com>
Date:   Mon, 15 Aug 2022 14:12:16 +0300
Message-ID: <CABcq3pGwc0MnkBfUfryOEcJfh96Ar3p_ZZw7U0SHvtnxjt+4pQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: fix endian-ness for RSS
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, jasowang@redhat.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, Yan Vugenfirer <yan@daynix.com>,
        Yuri Benditovich <yuri.benditovich@daynix.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Andrew Melnychenko andrew@daynix.com

On Fri, Aug 12, 2022 at 1:30 PM <patchwork-bot+netdevbpf@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to netdev/net.git (master)
> by David S. Miller <davem@davemloft.net>:
>
> On Thu, 11 Aug 2022 08:51:58 -0400 you wrote:
> > Using native endian-ness for device supplied fields is wrong
> > on BE platforms. Sparse warns about this.
> >
> > Fixes: 91f41f01d219 ("drivers/net/virtio_net: Added RSS hash report.")
> > Cc: "Andrew Melnychenko" <andrew@daynix.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > [...]
>
> Here is the summary with links:
>   - virtio_net: fix endian-ness for RSS
>     https://git.kernel.org/netdev/net/c/95bb633048fa
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
