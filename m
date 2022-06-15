Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AAA54D132
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358150AbiFOSwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358430AbiFOSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 14:52:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7788024BF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:52:47 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso2858001pjh.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+plJLyc6BfesKBMfyYWeTBRHfNx/06Fk1S03G42Wxl4=;
        b=mOjsn2omSJQYO+C6R1n+7Va36LEjp++XQfMZQgxSRdbtYoqgUjImwjvbQoccczC3ou
         OK/8E3yx+flabo4DNZPP1FDlsfa/wuavvcUMnn3Sltx0t+EsgbhR+8+fUuzNZZ0hYpzq
         SKKwvjXO9r8BlrtMxm+PVmnl7H+JWP6Jbc+dqBFR9NJ3BLGG9GSTUN4I54zr56QOoCKs
         4ungpINDDzuBJYu67AZtMp+9+o8ePw72rKL7PRdNedynU/LKR0Hl6T+u58qaycxXX29C
         QmvgsP/EpuWm5ZCAsm28B+TL8NqUFxoWWIONQQdGxDFOmalbPBJSnIbD4uHP9QeY+U6o
         MH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+plJLyc6BfesKBMfyYWeTBRHfNx/06Fk1S03G42Wxl4=;
        b=Szqo4sg3zlHfnekU1166hSKG0wXPmd5tI9fRTLqqKhNwueA3hDPAWPUmcuswZtTduV
         xbxVsZP9jhJBtT9go78TsdW7F6nNmyNYAD006d9m186cRv1tt4T3g6SwFmNJwfzU0d2t
         8zy0k3IlF/I+KInW+B4Qa+V64xgco7FPVbzMIGb4bMH9iK1eCf2+9WBcwIs7b88Dkvz/
         0KwO+6b/+abHfm3jVaQY53D5Lc3jXUCBWcQVKKZXz3KzT/7kTwcn0PXmwqPoZKSm0AL2
         +Mu2fo0BApGbPZeOKfCM7DxvOEb6sBvsbENp6MNRInSSS9n2AbhzataInL32c3NhuwjG
         hjDg==
X-Gm-Message-State: AJIora/19FMjFvuZxqsoFiYYorInPxvDrQFCI2wXlDYJL4WQ57C8+2Q0
        5DH5R6+qLGNq/SmtaIPGA5ohZ819RsmEF+oQmug=
X-Google-Smtp-Source: AGRyM1uv162bCxcjTyRBxlF1tp1Zb5MwY4voLjUmqFzFiEHVLDBOmRp1rYP5BwTpxmjAgvK+XJFsN6S0SJ3kInFRCT4=
X-Received: by 2002:a17:90b:4ac9:b0:1e3:1dca:d995 with SMTP id
 mh9-20020a17090b4ac900b001e31dcad995mr856644pjb.111.1655319167029; Wed, 15
 Jun 2022 11:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220615180213.760756-1-e.velu@criteo.com> <YqonwfjE8BL6Xowf@kbusch-mbp>
In-Reply-To: <YqonwfjE8BL6Xowf@kbusch-mbp>
From:   Erwan Velu <erwanaliasr1@gmail.com>
Date:   Wed, 15 Jun 2022 20:52:35 +0200
Message-ID: <CAL2Jzux0ZnrJRocxj3X8YVwAb56krPtHUtKDnNqCURUJzgPoag@mail.gmail.com>
Subject: Re: [PATCH] nvme: Report model,sn,fw,pci device information during init
To:     Keith Busch <kbusch@kernel.org>
Cc:     Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> The PCI_ID: print is misleading. That format usually indicates VID:DID, but
> you're printing VID:SSVID.
True.

> This is also very similar to the recently introduced nvme_print_device_info(),
> but that one removes the annoying trailing spaces if they exist. I guess if
> we're going this direction, just use that print, but change it from dev_err to
> dev_info, and remove the call on global id collision detection.
Oh I missed it.
Shall I provide a patch for nvme-5.19 or wait until the next window ?
