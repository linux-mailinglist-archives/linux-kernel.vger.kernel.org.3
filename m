Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFBD5344C4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241378AbiEYURQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 16:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbiEYUQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 16:16:48 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804611147D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:16:46 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id bc42so10390369vkb.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sEG0icEbQWzQToljyqBgD3aSPQ/mar2lnW/ygu4neoY=;
        b=eEqJ7TQi6I6W8fbEV9Ibmb7lons3Vl5rNCaekxwVLzqN0iym/F9GFmW3m8TS31Fe45
         ePM+S2RHy/r20laDdii5e9VQiY5RSKaoLD/pgXZ2ghVStHsVV5ugwG8dbXSzeW5nOv7D
         MC9/aFVH0Dx69kSHo86+3frP64Ss6OcL9dq7i3UzIX7lf9daLy05BVveI+yKZVbFg464
         RBO63ztSg2not7N8aYKfyAshrQzRJpnlQfMOl16HBb484uCMYX8FkRSYqNpNIp2ZE1j2
         AQJiXPAQQOuoJxAGTQ7Gw+Iev/omSlrkzV5CgbHvyOKaLku4CDlo7dualO3zn2tzIivB
         nyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sEG0icEbQWzQToljyqBgD3aSPQ/mar2lnW/ygu4neoY=;
        b=i9dvgyFmZldw9uIf6JDOisbDxCvliYXfXkD2sQYPomEqzqw8c6C5PoXqdsFgVKvYir
         oSyzN5U9oUL+h+B+QdcvWguaIGyJrJytReZsHAaVOemR+vqRaZDgOo1fomrY0C2NCcMN
         Pfv6n9cS8a0566xnsAkriDsUGaEL1z6/k3GOinnXfJnFj6Huh1X+Fnjrm6fIz0b8up14
         dqTE9JPLQORg0OsVpXIYiGn+XhOgIdUlEPcoKNE9eIVOENm/A+SACa29eqQW0iA77lZX
         BBTHXdeXuMkA3szO9aSrFe/4OxuKw6fAOphS8JGg/xDlnhy8NhCXMlp+2SOZ6SDqPWvt
         HZrw==
X-Gm-Message-State: AOAM530xcqjr3gQG1YfcGThjKPp9EqI6jxmbGqVSEaLskhlz5XIrSY3Q
        4aEQ98nx4ZzpPhJ24kyZ97zfe5q7Z53jCBxRWJ/1EA==
X-Google-Smtp-Source: ABdhPJxXTD0b0wGt11g6Sf3EIcNgykMMnDOGoXDZJlAhtASlMQY8J+Li2flc5Z6ipSE6ZXPSEPSpTccxmE+am9GnerQ=
X-Received: by 2002:ac5:cdec:0:b0:358:269a:8a24 with SMTP id
 v12-20020ac5cdec000000b00358269a8a24mr2737096vkn.22.1653509805414; Wed, 25
 May 2022 13:16:45 -0700 (PDT)
MIME-Version: 1.0
From:   Jue Wang <juew@google.com>
Date:   Wed, 25 May 2022 13:16:34 -0700
Message-ID: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
To:     pizhenwei@bytedance.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some points to consider:

The injected MCE has _done_ the damages to guest workload. Recovering
the guest poisoned memory doesn't help with the already happened guest
workload memory corruption / loss / interruption due to injected MCEs.

The hypervisor _must_ emulate poisons identified in guest physical
address space (could be transported from the source VM), this is to
prevent silent data corruption in the guest. With a paravirtual
approach like this patch series, the hypervisor can clear some of the
poisoned HVAs knowing for certain that the guest OS has isolated the
poisoned page. I wonder how much value it provides to the guest if the
guest and workload are _not_ in a pressing need for the extra KB/MB
worth of memory.

Thanks,
-Jue
