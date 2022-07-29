Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7BE5849CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 04:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiG2CeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 22:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiG2CeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 22:34:03 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454937B1F0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:33:59 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2ef5380669cso37831147b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 19:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhKqWbjoKDCkljIXjd3L5hRrxiXqibk3EBcu7l45Nl0=;
        b=0UyNGR35PMfbACWYluMYhSrKoeO7t3MQF9pr5+Uy3iUinWpuXCs2Pp2kU+WZvbdi41
         Px/sk01RbCmHEDbBCNN0R3AsnzjdnqLVZusBAG41xhITboYh6fD1GvPRW93HAjGTgJMr
         NTw+Ei5wjRa0UtppH/nsYrcStfSl5rFr5Pvrecm2GL/VasxoUjGG9cZXNn2YBRN/wn3Z
         7E9lwFLhWok6Ech10K+mM4ptlrGdUlJJug3yfljaCHKl47khufKy7KNymkr4VYjcFXeG
         R+a5drl20TxEuyTUcnBOVI6OXJir6EAaiUkIFy+yuu0/tJUqAapThMZiGQeRA1ghPjHz
         j/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhKqWbjoKDCkljIXjd3L5hRrxiXqibk3EBcu7l45Nl0=;
        b=pHIKIawFrPvjqE61247KUhVvsaplwgOT00QK9QgtgZPUcOK+rvMoLIApunXmIZceVE
         xnsb0kDKJ5d9Vj9S5YKHY5lHQ8JZxuZ7fFFHWuBKUnSpZbVqpWFAsgBu0v3h1fFSz8qQ
         H5065x7E+FNKIUqyAg5BNxDF1T7loQzFw075g5qHMSvlmhObuJhvAM3V4SxzkptsJey4
         8qdA/lbeuTUbEuswKuKCDweiav6H/jAA4+Y+NqYA/m0pXRy3mAZe301NKqpHEyjQjTg7
         RIr+9FGxLEDXYloxXeT/D3oQLHxsWsvDe0qrRvpjblw+bNEC13zA40pDeAFPKHmyOqsx
         nVng==
X-Gm-Message-State: ACgBeo3yxx2HLVn+ngScyyO5ktOF2K8D1Rln/iBX5Uq1fX8dc0MWuvzM
        ebgW+psqRv486jnvFD/7rIvqsIMh8WYPjOUfkhgMDg==
X-Google-Smtp-Source: AA6agR48qYuFMVFSm9BB/b98bUBorupQvIHSeW37mOpWAs8ai7c+L+x/iSr4a75JK/OJQnaYWFb86y2tAKc8RgFc5A8=
X-Received: by 2002:a05:690c:826:b0:321:57d:27f0 with SMTP id
 by6-20020a05690c082600b00321057d27f0mr1428734ywb.141.1659062038535; Thu, 28
 Jul 2022 19:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220728032000.127-1-xieyongji@bytedance.com> <20220728032000.127-3-xieyongji@bytedance.com>
In-Reply-To: <20220728032000.127-3-xieyongji@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 29 Jul 2022 10:33:22 +0800
Message-ID: <CAMZfGtVGjn1bkC345EykA0b86HoR2m6tmc_JYs7GnEvBCh9ETA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] vduse: Use memcpy_{to,from}_page() in do_bounce()
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, xiaodong.liu@intel.com,
        maxime.coquelin@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:20 AM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> kmap_atomic() is being deprecated in favor of kmap_local_page().
>
> The use of kmap_atomic() in do_bounce() is all thread local therefore
> kmap_local_page() is a sufficient replacement.
>
> Convert to kmap_local_page() but, instead of open coding it,
> use the helpers memcpy_to_page() and memcpy_from_page().
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
