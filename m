Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0794059693F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiHQGOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238865AbiHQGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:14:15 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FF50071
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:14:14 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id r12-20020a05640251cc00b00440647ec649so8226674edd.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=Xa1Am8o4teQaaL9RutMPnLbxqHkDGkecVOS2SmaoyIs=;
        b=s/1uTUYyEaFlNWqfnApEYsQdesm4fvMpnKQOdzNeq15EnC9twMzAmYS27DYIEpoQNV
         ONiulQIKOyEaJN7vwBiVA52A3T4fcNXzcO2EhlNUv27SahrpI8qf2TkmB06MCRaqefwF
         /yeummP9sXq7fbGE66YggRyUl+gsDQWhxLKEisD400L//ndUoKIQVHn5cqERyZdfGqzW
         MxIJmnSbDnDTsusWT3OxOGRFuDKrQGwlnv+xVRnPv6dCaBuTy0G5ycxfUPP9Z6vnw8Dw
         XiMmWQtzqjM7hXitZzNVNFnrMdeE/E2XvAKW/O257aO7bzFySiL/TErWqyTrtHttYnlB
         qbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=Xa1Am8o4teQaaL9RutMPnLbxqHkDGkecVOS2SmaoyIs=;
        b=i0970s4Jr/5NnoayhTPJSPZKdXZ3H+zrFf4jATCwMhdaE6QA4sfsKzfNAVXZnyH3Ee
         zXmkMv6q29LcrngkVlg4Pjp8VTSVxwIsR35Pq4g5AquKSuPISkN+lh9tF11PpNRRjzFg
         cSWRlLTU3GZvZDz96RnFBzye2nwXR4iW83sFnFXdTgwcsv0sroa1usgBWMv44tsec5xb
         FPdEKvrDBFS6ob8zNW0o4loW2ze9tWrfvLW4B/lLRiPxIxx+WpM+JGRG2WYJB90swTrS
         7L39dLKGUp4PWT8GFxZ3V+VbzEM7eI0Ez6GuaHQ3aUmVfYwi9M9P2tdK/0U7ezNqmn/i
         GaAw==
X-Gm-Message-State: ACgBeo15+LEslL9759rAueeqEjh51WKAWL0LqygryLUovFj0Xza/mTW9
        euTtgB/dvZOy2D/Hda5C/7pgBr4b1Kue
X-Google-Smtp-Source: AA6agR4jDLAGqFGFVp5dCXkX1JHnJoN5Z+/KOffoN15vAxyETRy5Eo2fSEJJ2790+2dor5kkVeI0mn+NTGTR
X-Received: from dvyukov-desk.muc.corp.google.com ([2a00:79e0:9c:201:6b03:2ace:af3d:2660])
 (user=dvyukov job=sendgmr) by 2002:a17:907:608f:b0:734:b422:42f4 with SMTP id
 ht15-20020a170907608f00b00734b42242f4mr14937896ejc.491.1660716853316; Tue, 16
 Aug 2022 23:14:13 -0700 (PDT)
Date:   Wed, 17 Aug 2022 08:13:59 +0200
In-Reply-To: <20220815170444-mutt-send-email-mst@kernel.org>
Message-Id: <20220817061359.200970-1-dvyukov@google.com>
Mime-Version: 1.0
References: <20220815170444-mutt-send-email-mst@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: upstream kernel crashes
From:   Dmitry Vyukov <dvyukov@google.com>
To:     mst@redhat.com
Cc:     James.Bottomley@hansenpartnership.com, andres@anarazel.de,
        axboe@kernel.dk, c@redhat.com, davem@davemloft.net,
        edumazet@google.com, gregkh@linuxfoundation.org,
        jasowang@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, martin.petersen@oracle.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        torvalds@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        xuanzhuo@linux.alibaba.com, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 17:32:06 -0400, Michael wrote:
> So if you pass the size parameter for a legacy device it will
> try to make the ring smaller and that is not legal with
> legacy at all. But the driver treats legacy and modern
> the same, it allocates a smaller queue anyway.
>
> Lo and behold, I pass disable-modern=on to qemu and it happily
> corrupts memory exactly the same as GCP does.

Ouch!

I understand that the host does the actual corruption,
but could you think of any additional debug checking in the guest
that would caught this in future? Potentially only when KASAN
is enabled which can verify validity of memory ranges.
Some kind of additional layer of sanity checking.

This caused a bit of a havoc for syzbot with almost 100 unique
crash signatures, so would be useful to catch such issues more
reliably in future.

Thanks
