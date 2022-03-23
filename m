Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFB4E4A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 02:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiCWBJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 21:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiCWBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 21:09:29 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28613F7C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:08:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v35so36740101ybi.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmS9XqFWOa3npmqi6akNlXoA1MxlQ02g/X1bQSimlGc=;
        b=eTkTfF7gsKMtnFv0vmxEwLrqozg5VjCqWuUXhurTUUzeR+U70FDajhoT65QVvBq2jk
         +gYcsgOMJ/1DuyZzyUEYPWah83ud2Xu5pv0Lqv7OZo96rCssZtIIVpY7jJcZRE/Jw5OP
         aaf/roqvZz0TbF5bcE36CTJLbsk+mCqRtidrsLWZowjhS0VvlnIPbnHN46FkiZET02Iu
         CORiW9OhJPibBlqvEDZYArUrFavapZu5TFLXG3NsIs7vY8IsBJIwPjeVyCYY/ZuFOStW
         uGnh+eTIOxFP/28ODOJyNjRsJizlUEp4hAXov/29um/mF2h13qzNWzb7QT/lZBftyhfB
         SzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmS9XqFWOa3npmqi6akNlXoA1MxlQ02g/X1bQSimlGc=;
        b=Z3CW1D9seuYe6wKZ24j1fLzdLGLYLo5S5Tedsa0Rxl66f/IvVfXEoIh1m37600a3sy
         +nitEghVuV3im2O7IwCSYN4f5gwbZmqnRTD/4nycsrr3d7GfhJp0vlTVx7/+RQ8vq0Gm
         IVmDwtv6jBkNH0KUlyMk1iU9+yLB8FBbBDkqgcGL9KfapQOCE9OpC8s855et+0DFCjVp
         H9f/n4jllC3pya5qmdRsUMjCf+3s2AFb1F/UDi0Z/16sP92CKyrIcbYQLwbRIwXfLOQP
         qM5g9z9MJmWIg0mYhXd8Kl7ADehmfEYd50vh585S8Yro2I3pZuASwQ6qD+GW0pm3bv86
         vLuA==
X-Gm-Message-State: AOAM531JNuPdZZOX5xF9H4KIog+QMXuNQJcZPE/NqztD4mOLktkAXGSX
        qFoHiZ/DvMRqAcNuAzpFoeVtyTzCoFQ1HE1gkSVP7g==
X-Google-Smtp-Source: ABdhPJx4K0OSi5k5jpLqjYDqBixWELdbP6OwP88DLE7SrBoeJU+r2PS2vf0aECo2EprR+alXYONOgw8yE7G4D9fF76E=
X-Received: by 2002:a25:24d:0:b0:633:6b37:bea1 with SMTP id
 74-20020a25024d000000b006336b37bea1mr29032850ybc.427.1647997680003; Tue, 22
 Mar 2022 18:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220309144000.1470138-1-longman@redhat.com>
In-Reply-To: <20220309144000.1470138-1-longman@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 23 Mar 2022 09:06:03 +0800
Message-ID: <CAMZfGtWS581YW4Y8oNU=E_zPnpK=mMdYVSG1F3U3fJNAzBzc+g@mail.gmail.com>
Subject: Re: [PATCH-mm v3] mm/list_lru: Optimize memcg_reparent_list_lru_node()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:40 PM Waiman Long <longman@redhat.com> wrote:
>
> Since commit 2c80cd57c743 ("mm/list_lru.c: fix list_lru_count_node()
> to be race free"), we are tracking the total number of lru
> entries in a list_lru_node in its nr_items field.  In the case of
> memcg_reparent_list_lru_node(), there is nothing to be done if nr_items
> is 0.  We don't even need to take the nlru->lock as no new lru entry
> could be added by a racing list_lru_add() to the draining src_idx memcg
> at this point.

Hi Waiman,

Sorry for the late reply.  Quick question: what if there is an inflight
list_lru_add()?  How about the following race?

CPU0:                               CPU1:
list_lru_add()
    spin_lock(&nlru->lock)
    l = list_lru_from_kmem(memcg)
                                    memcg_reparent_objcgs(memcg)
                                    memcg_reparent_list_lrus(memcg)
                                        memcg_reparent_list_lru()
                                            memcg_reparent_list_lru_node()
                                                if (!READ_ONCE(nlru->nr_items))
                                                    // Miss reparenting
                                                    return
    // Assume 0->1
    l->nr_items++
    // Assume 0->1
    nlru->nr_items++

IIUC, we use nlru->lock to serialise this scenario.

Thanks.
