Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE42A4E9BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbiC1Pxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238069AbiC1Px2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:53:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78EB100
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:51:47 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id t11so26796700ybi.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tin/HUePoSP0WPbVMV76tjgbiayi43biSRQ1KKujeeI=;
        b=VNxDfv9rBJgC22+4VxJ3bPmC9grmNM3f51riUtLc6J4fSzEVRfhWmKJJCdhU3HDLC+
         Gdf5Whhi6H3kM3ibXjkSniuU7P0XsuE2QGWHwUCBXOUKf6+R2REHdtB4ezUD2VpcgUTx
         jSFLlHlJSBqlLuCd7PpKt1YUkEsY1wkgJXrN3+dp5YFBliRbebGpRrQMSmgQmONdY9Jw
         I7wIhW2raJQdAuRFLQfTwFYrek37UVs+1mXAlHCIRHKxXfzS6DLzgpvV2wfByHJcyZ5b
         T+oOCLVSOMlb8boGl/pqF6PTYSUGgAAYxABlEsp7juBrPqWqXrhj85CPml95zXhbl1TZ
         G4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tin/HUePoSP0WPbVMV76tjgbiayi43biSRQ1KKujeeI=;
        b=EtbG4ZWxVAEmkMkRzjEIK04bx2GGtBgNb2zZBptvbVGomKcWslTZE+ncR7hO1vCMkc
         MFKuo3M/1zSkCJ57Xa5VBKP3XUy8yo20Bhs/ioPySfHycTIQsQK6ynE1yJMt3vbm9rb1
         JasM4/H7gX/Dr1hOtRbgnhM4CGRUWJE9lQhL8lbI94seA4UR11cgR5ACTOp9/Ms1rYzM
         IHkkStdStrl3Jec/evhxqQjOPVuOYlM7Ru1PBkV4Mb+9dTSLvZehSKjqEulckzT/y7Rk
         JvZW/QBKM9Vt5UOfiQtmCyy8JRsTAOeBB+uBo8Sss5XLjtw6YwGUInFuiJXZDvF4hlJ1
         waNg==
X-Gm-Message-State: AOAM533EsgvQHKRgedNyoHYlqCTtiV5Nipz/+C/FI9BxTH14DcCg2xxi
        T3mF1BARo4jaZPR3P+GuoKlzjAIy1nZhS4igRHO5wA==
X-Google-Smtp-Source: ABdhPJyilVVQ5cCmaPeT9S7msms3MRvaqGlzWNB4u+LOLVUKuZ8HqSE6nFMjwXJcsHGCSnelBrifFpRBN9ozY7Pghww=
X-Received: by 2002:a05:6902:120c:b0:639:86b2:76ba with SMTP id
 s12-20020a056902120c00b0063986b276bamr19563008ybu.254.1648482707142; Mon, 28
 Mar 2022 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220328132843.16624-1-songmuchun@bytedance.com> <CANpmjNO=vMYhL_Uf3ewXvfWoan3q+cYjWV0jEze7toKSh2HRjg@mail.gmail.com>
In-Reply-To: <CANpmjNO=vMYhL_Uf3ewXvfWoan3q+cYjWV0jEze7toKSh2HRjg@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Mar 2022 23:51:11 +0800
Message-ID: <CAMZfGtWfudKnm71uNQtS-=+3_m25nsfPDo8-vZYzrktQbxHUMA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: kfence: fix objcgs vector allocation
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 11:43 PM Marco Elver <elver@google.com> wrote:
>
> On Mon, 28 Mar 2022 at 15:28, Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > If the kfence object is allocated to be used for objects vector, then
> > this slot of the pool eventually being occupied permanently since
> > the vector is never freed.  The solutions could be 1) freeing vector
> > when the kfence object is freed or 2) allocating all vectors statically.
> > Since the memory consumption of object vectors is low, it is better to
> > chose 2) to fix the issue and it is also can reduce overhead of vectors
> > allocating in the future.
> >
> > Fixes: d3fb45f370d9 ("mm, kfence: insert KFENCE hooks for SLAB")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Reviewed-by: Marco Elver <elver@google.com>

Thanks.

>
> Btw, how did you test this?
>

Yeah. No problem.
