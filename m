Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4711E5AC3A6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIDJhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 05:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiIDJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 05:37:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8C3FA1F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 02:37:00 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id v26so9295598lfd.10
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date;
        bh=3dCz4gBqjzOilHFtYTlf/ApX6Q5+noMG1nnD61cseRw=;
        b=jJb+uyhjvdbyqic5hW9XkTyprs/ZXewrWaUC2JqIYeIrSDDX72xyF+yE6S6FXKxkYP
         MAjpcp44tBa1M6V9qDnSdvmruLagKz3dCBxL80Rv1bfNn680xCy2MHQwh/7kfq7Q3O+P
         kV2geB6Cqix7dKPeQYs+4b4wDWsuk0cEA5VXXUMVYhUJuUJA2s+1Cy3BUagocAHNiR9X
         deOIq16sNjnIZ7Isx+8HgBwd/XvqPg1nmwowWtKURlWoLReL+VbS0TqgnsL9m8s1MiDo
         mGbN7ZgRFXJg/bu+jH5gzX6oh8vblXrFSnbzU1fE7EOjKzrLyFc5chZ81Zo0OlcAg+EO
         GpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=3dCz4gBqjzOilHFtYTlf/ApX6Q5+noMG1nnD61cseRw=;
        b=JHRhd5mCaZ/h2u8dSFMML0IwhDFirLnSSoC/32K2doL98S3QE8qeZcEV8gINtqK8Pf
         1NUvmehIYFhhCFU+LqOBYkHbGZvO2Z8o0pPlVWfXod/yoAm7cbe4g2Gw6ETXKcTMD9Ij
         5ro89unPo2JsqlrCUxtI0LbNfHPEk6q0sq+5xC/brZJqRlfW7LXH1ZL2LLPAcHHGoPln
         2h5Pv7SK0vnuGFwTDtwb6YerEfNxwPxPTx8IyRHWir39mUfXJEAyfdyWXFZQZa1CsYwz
         8nOOX9Kl6QjxbqzFQlHVAXPItUHHBXxFeWZbI9BrhOKPVeAS6JCT6+P7qA/XE7xIs5Md
         k0IA==
X-Gm-Message-State: ACgBeo256WLoH/xm0W/OqlVdVGn4w2s1Kq73ijr9WE1J7LEUNXQLjAM/
        Cg8UUIxrSVdwjY5wV3zKBWo=
X-Google-Smtp-Source: AA6agR76zNDnW4m4bvvHgjl0eb4Bf4A4SqJtDlpS0YKjnDZYoHmNdIAh/Fg0b3h/AqMVYj58GS8/wg==
X-Received: by 2002:a05:6512:acc:b0:494:66a9:4a7f with SMTP id n12-20020a0565120acc00b0049466a94a7fmr11299716lfu.479.1662284218889;
        Sun, 04 Sep 2022 02:36:58 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id r17-20020ac252b1000000b004946748ad4dsm842891lfm.159.2022.09.04.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 02:36:58 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Sun, 4 Sep 2022 11:36:55 +0200
To:     Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Song Liu <song@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Message-ID: <YxRxt92Oe0PjfjPY@pc636>
References: <20220831052734.3423079-1-song@kernel.org>
 <20220831160111.a6e7d17785ca21ce7c43981c@linux-foundation.org>
 <CAPhsuW4SGguyoFKpN8S=jFCWfLiDM-f5QwV7UPwkQ=LjQEXaNg@mail.gmail.com>
 <CA+KHdyUDGkUBtnAcvu+NB=S7chp_1N3XviTkkMoP-8LrLJQgbg@mail.gmail.com>
 <YxF69izHufARLKqA@MiWiFi-R3L-srv>
 <CA+KHdyWijMSuNaT4vQ-tqyrJC_GxL++rDj-s1WZMkDi=8m3p1A@mail.gmail.com>
 <YxKzzsyK99bwnbAy@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YxKzzsyK99bwnbAy@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 09/02/22 at 06:45pm, Uladzislau Rezki wrote:
> > > > Even without this patch, the debug path would work correctly. The
> > > > difference is just only in
> > > > whether roots are hardcoded or passed over function paramter.
> > >
> > > Calling find_vmap_lowest_match() inside find_vmap_lowest_match_check()
> > > will fail compilation because the function interface has been changed.
> > >
> > Ah. That makes sense, though the commit message has to reflect it.
> > So it is only about compilation error if debug is ON.
> 
> Indeed, the current patch log sounds like an improvement or normal change.
> In fact it's a code fix.
> 
Then i think it is worth to mention about this in the commit message. At
least i have missed the main point of this change looking at the commit
message.

Song Liu, Could you please upload a v2 of it stating exactly what it fixes?

<snip>
urezki@pc638:~/data/raid0/coding/linux-next.git$ git diff
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e68c0081e861..7552f1f8350e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -713,7 +713,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 /*** Global kva allocator ***/
 
 #define DEBUG_AUGMENT_PROPAGATE_CHECK 0
-#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
+#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 1
 
 
 static DEFINE_SPINLOCK(vmap_area_lock);
urezki@pc638:~/data/raid0/coding/linux-next.git$ make -j64 bzImage
  DESCEND objtool
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  CC      mm/vmalloc.o
mm/vmalloc.c: In function ‘find_vmap_lowest_match_check’:
mm/vmalloc.c:1328:32: warning: passing argument 1 of ‘find_vmap_lowest_match’ makes pointer from integer without a cast [-Wint-conversion]
 1328 |  va_1 = find_vmap_lowest_match(size, align, vstart, false);
      |                                ^~~~
      |                                |
      |                                long unsigned int
mm/vmalloc.c:1236:40: note: expected ‘struct rb_root *’ but argument is of type ‘long unsigned int’
 1236 | find_vmap_lowest_match(struct rb_root *root, unsigned long size,
      |                        ~~~~~~~~~~~~~~~~^~~~
mm/vmalloc.c:1328:9: error: too few arguments to function ‘find_vmap_lowest_match’
 1328 |  va_1 = find_vmap_lowest_match(size, align, vstart, false);
      |         ^~~~~~~~~~~~~~~~~~~~~~
mm/vmalloc.c:1236:1: note: declared here
 1236 | find_vmap_lowest_match(struct rb_root *root, unsigned long size,
      | ^~~~~~~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:250: mm/vmalloc.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:2003: mm] Error 2
make: *** Waiting for unfinished jobs....
urezki@pc638:~/data/raid0/coding/linux-next.git$
<snip>

Thank you in advance!

--
Uladzislau Rezki
