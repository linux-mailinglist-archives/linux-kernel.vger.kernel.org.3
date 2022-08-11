Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A57F5905C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiHKRXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbiHKRXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:23:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E2266102;
        Thu, 11 Aug 2022 10:23:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v3so22149501wrp.0;
        Thu, 11 Aug 2022 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=j6b8kTrT56pwiU/IWqIOVmZdn5YfEPHXgPdh8M5ebwU=;
        b=h7L4neJIrIWcIOjwXfQEB9hwJK4xq6R+BiWBrtmxIksUhSNdQH7p/IZXM9NG/eSM0h
         hLy9cVMlPI6SVm2QoJ1zzD7Gd6wSFI6/G6O+rDkuaS9WlYydFZoX2rYKpCi+x7IPcC++
         q/TYrO9uxaqzIZzdL+odlDYDp74eWkbaepATdxwmBwCfOs2zrTyDfpkmOfUYuPxzXgbM
         g5sk4lNQFZLRaJQAoVmCUlpeACUBFmJjwo8ovs3BUn9HrcCPg7vju1kmtt4ByxF2mYln
         bnQdbwD5EfXAeXR8VozOrflRRy3ZxW2+WSdWPruAFDr5XlVVWNQ4MNBSCs8LWx2HxJ48
         CtOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=j6b8kTrT56pwiU/IWqIOVmZdn5YfEPHXgPdh8M5ebwU=;
        b=6ThyhmhaV/yGMyAhcNMY5xf01SY4AVE1NssD+WYeNJE+hUHRFNENqfiRCsyMCS6liC
         Wdt3YA+MOmGodbgYVrZoCwYvuvlJSThSMLgebUK0tW0c6p7qSgQzQmcetYcw4GB5wN1D
         8j0iiVUfht8u0qoAQfUh2pIHQC+VhjbGU/wq/pqwMzfMTS+Hcts7qyyFEPacbqrrW3hm
         ZEgoUz9ss2kHUg+aLixKMlmhNn1neaH8RX8zmUvi1xO4Np9H/UXkmXrszER06oDSFLWN
         Tm2lTTBnpCP3OigGZ/ioz9+ou4Cc5qlIGIrznAosXd6gaPj64egvK9qwcfOub+NAPPnh
         YXsw==
X-Gm-Message-State: ACgBeo3viCg0/5cXEkcUYAUrQOUIskgJbTeMRQMxlJ7FmAKKOg/05WNY
        mliH/fgjqWw9JxtKOaMLw2M=
X-Google-Smtp-Source: AA6agR7icK2jhFDxh4B/98tzwNsmxNFF++Z70qopjEziOWND2bqMvSdWSrJzRBBJ2glEiKAihkZd2g==
X-Received: by 2002:adf:f286:0:b0:21e:f0dc:3df0 with SMTP id k6-20020adff286000000b0021ef0dc3df0mr21793wro.377.1660238584739;
        Thu, 11 Aug 2022 10:23:04 -0700 (PDT)
Received: from debian ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id h4-20020a1ccc04000000b003a545ff43c5sm6362884wmb.45.2022.08.11.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:23:03 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:22:54 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        linux-next@vger.kernel.org
Subject: build failure of next-20220811 due to d79b32c2e4a4 ("vdpa_sim_blk:
 add support for discard and write-zeroes")
Message-ID: <YvU67iF4z5gB4ZYk@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Not sure if it has been reported, builds of arm64 with clang failed to
build next-20220811 with the error:

drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:201:3: error: expected expression
                struct virtio_blk_discard_write_zeroes range;
                ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:204:25: error: use of undeclared identifier 'range'
                if (to_pull != sizeof(range)) {
                                      ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:207:21: error: use of undeclared identifier 'range'
                                to_pull, sizeof(range));
                                                ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:212:60: error: use of undeclared identifier 'range'
                bytes = vringh_iov_pull_iotlb(&vq->vring, &vq->out_iov, &range,
                                                                         ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:222:38: error: use of undeclared identifier 'range'
                sector = vdpasim64_to_cpu(vdpasim, range.sector);
                                                   ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:224:43: error: use of undeclared identifier 'range'
                num_sectors = vdpasim32_to_cpu(vdpasim, range.num_sectors);
                                                        ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:225:37: error: use of undeclared identifier 'range'
                flags = vdpasim32_to_cpu(vdpasim, range.flags);
                                                  ^
drivers/vdpa/vdpa_sim/vdpa_sim_blk.c:202:7: error: mixing declarations and code is incompatible with standards before C99 [-Werror,-Wdeclaration-after-statement]
                u32 num_sectors, flags;
                    ^
8 errors generated.


git bisect pointed to d79b32c2e4a4 ("vdpa_sim_blk: add support for discard and write-zeroes").
And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.


--
Regards
Sudip
