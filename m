Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3F509FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384868AbiDUMiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385124AbiDUMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4112F01F;
        Thu, 21 Apr 2022 05:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D907E61C17;
        Thu, 21 Apr 2022 12:34:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38513C385AA;
        Thu, 21 Apr 2022 12:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650544490;
        bh=nwEgRIc2DkjEOq+aHIKgb93W0tmpmkVrijOMlhjM+2c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kOcXb1lv/nzkVVo5+e+G7lB6G9q+Ds4gTUHOEz/mS+NRZiCo1cPMizp43AaZ/OJaf
         6bmQrVibO21ey4Rx+3aEG5jTUMUgNRhavYc6YIjXtYurJmbNXP6AAxXXueZZ5bZo6g
         YN51K3lqzjbNVUP77kKjHrm45TDIpc/pizXBKccj68lwtS+ILgIZlPPNIgVfnTijI4
         lo2l2c/irPGCVcZunI5bIGJ5vcxNkLmCynsRilQHm5gWsdXXYLxbmRRwaCu8Rz3eJU
         gFM7eA0lk4aAJfUnTT75o+Ov/kyZRhu9s38xzj1RLBmgymFhv/kiXB4b32Bk8R6o/s
         2bitBY6TL3egA==
Received: by mail-pl1-f175.google.com with SMTP id b7so4728503plh.2;
        Thu, 21 Apr 2022 05:34:50 -0700 (PDT)
X-Gm-Message-State: AOAM533iAcoXVp51eYWM+bDyRQRlWHbYRZIpCPfm/PpnAggQEAycB3qo
        z1mhy1XXSdHUtBLBYHVzV4AtMbw+0+6ExoeJkQ==
X-Google-Smtp-Source: ABdhPJwLEPk9OLMoJ9JMm2KtY59U1i0zQMGi1rF12qY8DyKg5Gv81xjxidpwgTMkqj9+231fmtFHFdon2zwGKBXhxtM=
X-Received: by 2002:a17:902:eb8c:b0:158:4cc9:6998 with SMTP id
 q12-20020a170902eb8c00b001584cc96998mr25730080plg.35.1650544489734; Thu, 21
 Apr 2022 05:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220421122303.111766-1-wanjiabing@vivo.com>
In-Reply-To: <20220421122303.111766-1-wanjiabing@vivo.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 21 Apr 2022 07:34:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Ess2=+r+=+QdqkF3pQw9CS=3so86FCM8Mn_XaKBTgLA@mail.gmail.com>
Message-ID: <CAL_Jsq+Ess2=+r+=+QdqkF3pQw9CS=3so86FCM8Mn_XaKBTgLA@mail.gmail.com>
Subject: Re: [PATCH] of: Add missing of_node_put() before return
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Thomas

On Thu, Apr 21, 2022 at 7:23 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> Fix the following coccicheck error:
> drivers/of/platform.c:554:2-23: WARNING: Function "for_each_node_by_type"
> should have of_node_put() before return around line 560.

Especially since the code this fixes just landed, you should Cc the
author and reference the commit.

> Early exits from for_each_node_by_type() should decrement the node
> reference counter.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/of/platform.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

This has to go via the DRM tree.

Fixes: 52b1b46c39ae ("of: Create platform devices for OF framebuffers")
Acked-by: Rob Herring <robh@kernel.org>
