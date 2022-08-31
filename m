Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0D5A84E1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiHaSAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiHaSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695F2844E3;
        Wed, 31 Aug 2022 11:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0472A61BE3;
        Wed, 31 Aug 2022 18:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F71C433C1;
        Wed, 31 Aug 2022 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661968817;
        bh=13xJJEaIRPliXMrrJMtHCZ0PIl2SB6kc52ZdIdM97o0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sGGYu8LsheRWbItI1n0idA86XSMhS2qbHXzrJCqG+1s224OSXW/PMM3hsxFbc/e0y
         DgQEFnhF1wsHqUQxegZoXyOf2MyYRcC6xbV7M59+PwE4U+Ldzoj0DiigIcSq8Yi57M
         xM0TBV/X1oiZG6/Q3xiPEsZOHtDy6vHjCPFbXbk1BldIsIRc0e9JmdJdfE/C05yxZb
         Z6FpRQMkyhrIrcynq1HlYA+wvUR+zSj5QI3JmFEg05hSIeUcgwg0OyDBalMgx65j1s
         p8wpYc4hdDsA5/7C6X1hFAgD4CzxR+oB8dmTJE/Ypr4BXQdlMD/hXZnq+EdcMWbNH5
         P5fahRUzLBXhg==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-324ec5a9e97so314479097b3.7;
        Wed, 31 Aug 2022 11:00:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo2Jag/WRI1LhlAPbsvtAV1e9WvzCwUVdWuYozZFkEkLUKvYN7ig
        jTrtYYFFoizqHekzDBnnNBDN7/HPznuXi78JQZU=
X-Google-Smtp-Source: AA6agR6xkFRRbJ54fJ5ALHKPWrTlGcsMjIJs76DZ2UCN9wjSSSpA2GUb1kwdmLik0nixwcH/+OIDtZ02ZfA2eEkMDNU=
X-Received: by 2002:a81:a18b:0:b0:33d:c4bc:5340 with SMTP id
 y133-20020a81a18b000000b0033dc4bc5340mr19569661ywg.130.1661968816334; Wed, 31
 Aug 2022 11:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220829131502.165356-1-yukuai1@huaweicloud.com>
In-Reply-To: <20220829131502.165356-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 31 Aug 2022 11:00:05 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6pKMeaULJajDGSjDRVmBUDEd=QQdGftK_Oo0vgsEuKVg@mail.gmail.com>
Message-ID: <CAPhsuW6pKMeaULJajDGSjDRVmBUDEd=QQdGftK_Oo0vgsEuKVg@mail.gmail.com>
Subject: Re: [PATCH -next 0/3] md/raid10: reduce lock contention for io
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, yukuai3@huawei.com,
        yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 6:03 AM Yu Kuai <yukuai1@huaweicloud.com> wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> patch 1 is a small problem found by code review.
> patch 2 avoid holding resync_lock in fast path.
> patch 3 avoid holding lock in wake_up() in fast path.
>
> Test environment:
>
> Architecture: aarch64
> Cpu: Huawei KUNPENG 920, there are four numa nodes
>
> Raid10 initialize:
> mdadm --create /dev/md0 --level 10 --bitmap none --raid-devices 4 /dev/nvme0n1 /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1
>
> Test cmd:
> fio -name=0 -ioengine=libaio -direct=1 -group_reporting=1 -randseed=2022 -rwmixread=70 -refill_buffers -filename=/dev/md0 -numjobs=16 -runtime=60s -bs=4k -iodepth=256 -rw=randread
>
> Test result:
> before this patchset:   2.9 GiB/s
> after this patchset:    6.6 Gib/s

Nice work! Applied to md-next.

Thanks,
Song
