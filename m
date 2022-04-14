Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03C550078E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiDNHwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbiDNHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E1E5621E14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649922612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=1Y+vrudYuOScug1x3eREZTNTaJiy+mJqX5LykZZBtpI=;
        b=JTniA15eTOg43+ebqQDZRHk/pgiVO/Nm9LAW6j9+eFrrZdXy+Yb5j4rprAI24El2axUfUk
        mXUCtmhMPfCfUpiU+y2NC0KkM/cvkoUs643qTscG8gi5rePiUI1VJWmwKi84B0tA7T0ToK
        NRIjzS6+rDZRNQ7tQJbTNhuOwkXIUD0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-4IwiZOY4O4qhw5xOJEg4aw-1; Thu, 14 Apr 2022 03:50:11 -0400
X-MC-Unique: 4IwiZOY4O4qhw5xOJEg4aw-1
Received: by mail-lf1-f70.google.com with SMTP id v13-20020ac2592d000000b0046bc30fe894so1997439lfi.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 00:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1Y+vrudYuOScug1x3eREZTNTaJiy+mJqX5LykZZBtpI=;
        b=sx+gW/R2tKhPjGehEMC0DuwkgDWO5/s7asE/bBGJkKGM+tYTiK92/ekDSEvaOUn+4e
         JuJxBj0qmbKza82S7RWouCXrO/cDygK0cSJgygbjmiQiXgTWtI4KlzIECzkofrywM3zI
         OeXI+LPumgbuWhujOlT2l9CdcRqziAU0zT+jgY33EBNR7jNQ6e/Z7WWfLLBqJt4thq1b
         YlE87OMl3qdyZrT28DmlNJhVvhAifyyisHQ0esmShy9NLVjYtPG8sRcZ6PomRjt5rgBH
         GOfEZ4m6rSFWFXvAYJ4hd4wiCsQOoPjmvHq1Y5tN3dy6pkSV9nFskSkm2XApwnPtGUH/
         Ef+Q==
X-Gm-Message-State: AOAM5322lwl61OjWvhF6Iq8z9AJqwJUDAQcZ5ertZouxWDgepTDtHXec
        xIJ1naJQFvWdt2MsuU93xWEWwE8iDEJV9VovdVFaRwjAOJlb3db2/GowYlFDk6KnkMGXudEdbxS
        EmWBkNYGfzL5ZNlgfclzmRU6Q1+rUsZC0M9IwX9z2
X-Received: by 2002:a05:651c:451:b0:24b:626d:7b20 with SMTP id g17-20020a05651c045100b0024b626d7b20mr909792ljg.333.1649922609651;
        Thu, 14 Apr 2022 00:50:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoX/VLz7iTlARKUVkS321BZXmFkijVyh4oN8/MDT5jXLJnnQQHsn7ZID68qP3+f1a4DWhnfBTPV74z8wBO4Fc=
X-Received: by 2002:a05:651c:451:b0:24b:626d:7b20 with SMTP id
 g17-20020a05651c045100b0024b626d7b20mr909784ljg.333.1649922609477; Thu, 14
 Apr 2022 00:50:09 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Thu, 14 Apr 2022 09:49:58 +0200
Message-ID: <CA+QYu4oi-Lmfj1uh0f-JE0WRmmyjtU94xP8OpbLxAGjPkm69Ew@mail.gmail.com>
Subject: testing/radix-tree: undefined reference to `kmem_cache_alloc_lru'
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     CKI Project <cki-project@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Trying to build testing/radix-tree on mainline kernel fails with:

make -C tools/testing/radix-tree/
<snip>
cc -fsanitize=address -fsanitize=undefined  main.o xarray.o
radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o slab.o
regression1.o regression2.o regression3.o regression4.o tag_check.o
multiorder.o idr-test.o iteration_check.o iteration_check_2.o
benchmark.o  -lpthread -lurcu -o main
/usr/bin/ld: xarray.o: in function `xas_split_alloc':
/root/linux/tools/testing/radix-tree/../../../lib/xarray.c:1019:
undefined reference to `kmem_cache_alloc_lru'
/usr/bin/ld: xarray.o: in function `xas_nomem':
/root/linux/tools/testing/radix-tree/../../../lib/xarray.c:305:
undefined reference to `kmem_cache_alloc_lru'
/usr/bin/ld: xarray.o: in function `xas_alloc':
/root/linux/tools/testing/radix-tree/../../../lib/xarray.c:374:
undefined reference to `kmem_cache_alloc_lru'
/usr/bin/ld: xarray.o: in function `__xas_nomem':
/root/linux/tools/testing/radix-tree/../../../lib/xarray.c:337:
undefined reference to `kmem_cache_alloc_lru'
/usr/bin/ld: /root/linux/tools/testing/radix-tree/../../../lib/xarray.c:340:
undefined reference to `kmem_cache_alloc_lru'
collect2: error: ld returned 1 exit status
make: *** [<builtin>: main] Error 1

Thanks,
Bruno Goncalves

