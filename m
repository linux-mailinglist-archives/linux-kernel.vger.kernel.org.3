Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6259B8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiHVFMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbiHVFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:12:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E600252B9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:12:35 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e21so7502392edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XqovIxZ/3mSylc5rFsiQs3Xa2j6oWieFuhAH1I8PWE8=;
        b=Sfw8aaZM+4mGOtXQS53EorPhlU3Wby982Uak8OqCEx5HyqCImzxqVfihu2+tqsdO53
         wNP/1ajHGhcqEZY4ig3Gi+QA8stLY7LAIDRcrrVNjzlRX1XTb7s0vo/e2DAFSINm1n34
         6R1xwdxHb0UrPL6Dn2F+r6hsF+zCOL+beDTxzy0+ACcTj/di22ddRH0JrC3qcKtht6qN
         1BKAF1xZiQ8bcEX5ptgjrIQ25T46lCtxOm193U7KeTxPLjRcfRdO0qwQIiusKO9IB8+0
         WHp5vi/Z0CZ3q50TuEXjzjydhJn8B8bzFFkFyLXAoitHFEM5X19HNx2o/WUz9m414Wyj
         BYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XqovIxZ/3mSylc5rFsiQs3Xa2j6oWieFuhAH1I8PWE8=;
        b=l73/mT7mWDs/Ci4dVK3ePkrpakaKx5m6hNCEo/ZA+JlkzbBR2HFFgNmTseZdlKEIOg
         JQeIjJUwK8Iezp1OFTbPWS96EvNmFEA3ccd+zVI2nk4qCFN6cdO5S09uTnVfWaqExIno
         ustjbvcEJQFXwlMnXlVx6z+W7mI6jICs8dV+C+Tf94lpEBIy6HJTUyOEjZ4ZE5J9Ff2F
         Lq4QFy74kOOCBRPlMZ0KF3v9OmiwWcGeAgMmjTysXBWce5D0T2ENjD/pOWbFcRgfPtOW
         uHA3pjE/FSqbe/P6vDL99IB+Zw0xioifyBh5twNLu1HD5BQWTdIl26IuS9+Bo3/4/VyG
         CWPA==
X-Gm-Message-State: ACgBeo3ATg/xmELpnPr+N8kzfv9pMg13+E4NXHeNGvAohFShS2dj2e6J
        gBNN+vu7qdXZMcNv36QnEM9+fnZm5mJAzW4AtLXmJdM49Wk=
X-Google-Smtp-Source: AA6agR5g+9sEwO0FSnEqOm/9KAo3YoUA0Dl2S7qNgtrnbHs8TFvrM+v16zarP/laWa1jKUdGC+Ycp6k+1T9WJwZWZj0=
X-Received: by 2002:a05:6402:32a7:b0:446:e17f:111c with SMTP id
 f39-20020a05640232a700b00446e17f111cmr826449eda.95.1661145153873; Sun, 21 Aug
 2022 22:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-15-jinpu.wang@ionos.com>
 <20220821055745.GA26064@lst.de>
In-Reply-To: <20220821055745.GA26064@lst.de>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Aug 2022 07:12:23 +0200
Message-ID: <CAMGffEkhQd6oGgg+m9AUkquYnkufyrt1ptEkg5LG_HE_7s-Vsw@mail.gmail.com>
Subject: Re: [PATCH v1 14/19] nvme-rdma: Fix error check for ib_dma_map_sg
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Please don't send me just two random patches out of a series, as I
> have no way to review them.  If the patches are independent, send them
> independently and if they depend on common prep work send the entire
> series to everyone.
Hi Christoph,

As mentioned in the cover letter, the bugfixes are all independent,
for each of the drivers.

I will wait a bit to see if there is other comments,  resend as you
suggested later.

Thx!
