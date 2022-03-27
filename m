Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F104E8A29
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiC0VKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC0VKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:10:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A0EE0DE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 14:08:53 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so21625777lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsWH6DZnRrNBpmi3G0N/Bk/YRNIz8b7c67Ar9vl8sBo=;
        b=TnbXlHjsdNPdi4vQH++dmDky/x1SOl8XVjuuusaeB/JzY2ejhTw4rz/mcR2ahfMHN9
         R9xC9ktEWntbtfkn05iSIa4WdosCkaasTCqzvw5QGreY3owoCwV5QOt/nruGyEfwAWpX
         SVJLxWfORlkHWVoYmzNXVHsa85zmrVlPfwOp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsWH6DZnRrNBpmi3G0N/Bk/YRNIz8b7c67Ar9vl8sBo=;
        b=VH5S2NxRTHyrMUKJmVpiQHVZmmZPsfuBsQVUtWA29rFXa1scu4ihgBda5AOy0pp/DB
         jh+MTwAAJljzrl9eQL5JNQrNHXTogju5UeY6dJYNHpb0YDI7d1QyLwBJRtJ2BGgs9quz
         qE9U6JeWSijbqtm0zepNf3BpX03z8weWRekX5EpFI7W+fB/GI+Ce5xkT/cLoqhXjLEIu
         zonbhKQgvUxj8Zf9v2BLlKBOP6XY6cFaaoDphoAuFeL3WWncpRPvuLmP0ZWS2CrpA8Kw
         XUmLa4A0qvhON32mREkclEzk7ILGx0tjXWuB320njIXGEFA1zOA0pO1ym5w1g0voti1c
         F14g==
X-Gm-Message-State: AOAM530YuR7eMW5QxhoAOxfRC3Rs7kcd5bs9gfeV/uuWbcHcYr1Wcm+Q
        faCocCWkG5AIOsVhN0htp8GOFJcyzDQNfJoav6s=
X-Google-Smtp-Source: ABdhPJx0y1S/Pp0XYwvDQW61dTUeZmAvcHbQHq4PrUm4Wam1IX1GdSHoMgH3Bpm/AzZMI31msDWaDA==
X-Received: by 2002:a05:6512:1112:b0:44a:4096:39b0 with SMTP id l18-20020a056512111200b0044a409639b0mr16771670lfg.35.1648415331837;
        Sun, 27 Mar 2022 14:08:51 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id q22-20020a194316000000b0044a93059aa9sm228223lfa.260.2022.03.27.14.08.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 14:08:50 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id k21so21644235lfe.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 14:08:50 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr13637755lfu.531.1648415329700; Sun, 27
 Mar 2022 14:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220327051853.57647-1-songmuchun@bytedance.com>
In-Reply-To: <20220327051853.57647-1-songmuchun@bytedance.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Mar 2022 14:08:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-mVrp3auBiK2GSMpuqS10Bbq_7fRa6+=zt-0LiF7O2A@mail.gmail.com>
Message-ID: <CAHk-=wh-mVrp3auBiK2GSMpuqS10Bbq_7fRa6+=zt-0LiF7O2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: kfence: fix missing objcg housekeeping for SLAB
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, roman.gushchin@linux.dev,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 10:19 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The objcg is not cleared and put for kfence object when it is freed, which
> could lead to memory leak for struct obj_cgroup and wrong statistics of
> NR_SLAB_RECLAIMABLE_B or NR_SLAB_UNRECLAIMABLE_B.  Since the last freed
> object's objcg is not cleared, mem_cgroup_from_obj() could return the wrong
> memcg when this kfence object, which is not charged to any objcgs, is
> reallocated to other users.  A real word issue [1] is caused by this bug.

Good that this looks sorted out.

Patch 2/2 seems to still be up in the air. The patch not only causes
build errors, but it looks really very odd to me.

In particular, you do that loop with

                __SetPageSlab(&pages[i]);

in kfence_init_pool(), but that is *not* where you set the
MEMCG_DATA_OBJCGS, and instead do that virt_to_slab(addr) dance later.

That looks very odd to me. I think the two should go hand-in-hand,
since that __SetPageSlab() really is what makes it a slab thing, and I
think it should go together with setting the slab state correctly.

Finally, is there a syzbot report for that second problem?

Anyway, should I apply this PATCH 1/2 now directly as the solution for
the dentry issue, or should I wait for that second patch? They seem to
be related only indirectly, in that the problems were both introduced
by the same commit.

                     Linus
