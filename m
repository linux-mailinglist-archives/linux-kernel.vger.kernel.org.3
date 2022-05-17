Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1108052AD77
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiEQVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiEQVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 17:22:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1FC3EBBD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q18so18413452pln.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pyuUYM2nhfs1gICpi/ez0EJClISm0Vub2nnFcMFlfJE=;
        b=A9UDQ/9LPNxHRuAqHkEFWdqVmK+zKul9hMQlG3pY6UDl5Vv5FyIL3crIFn/KCFNuR+
         zrd5xZNVvHNso+FSjYZn573hSuGL2f0Pex6TwP2xkfJUChFUDBw5tJ5Jyie9EK0EmLCJ
         ZiKykHLBKWbbT7uvUEe4EB9pO0QI192mU9NyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pyuUYM2nhfs1gICpi/ez0EJClISm0Vub2nnFcMFlfJE=;
        b=8J3VfEbQFVWPB+Oowz209RSLLMSme0k95k/+jl+/tMZ9GAwFPrJQ/lv7KTjX1KqZ8i
         krOhPSyW8EI4Aps35MLuYmBQVngV6mdqR1K+pQejO5rEn3RV9vSlzzhogJ9NgWHMt6S9
         jPINGoMxfiBb2osWg8pSxulDGknxiHEt1MzY5ka/3L380elJCHdqvk7hhDIEC1zfOMda
         fGiRWbc4NqY26/q/kQ5CaSYABy1k7qjnr42jTJxCnUdK8pG9MKqsWKtbX3Ll6uF4EYtw
         9EoSAWArilxdocWyOcfbJI81Wh/vb6xXwCF5iMidx59ioVgcTQBeyYnV3F9M7gOTsPV3
         6lLQ==
X-Gm-Message-State: AOAM532tU3o6cQKu6/jFPjg00POuz8pI7svTAOGJuTBkkcsxT9KLIYcx
        MV/t7b/mQOIp2/VgPpBz2/H8aQ==
X-Google-Smtp-Source: ABdhPJwdf06LARTfcGEJ4oQdkjhe+AFA07h1wXiXiTaEg9WDBgitDF0Gsrlujdp1pPcx/Re8RN3qnA==
X-Received: by 2002:a17:902:9345:b0:15f:186b:e478 with SMTP id g5-20020a170902934500b0015f186be478mr24168187plp.117.1652822557024;
        Tue, 17 May 2022 14:22:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o137-20020a62cd8f000000b005106b52a823sm188918pfg.145.2022.05.17.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 14:22:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] bitmap: Fix return values to be unsigned
Date:   Tue, 17 May 2022 14:22:32 -0700
Message-Id: <20220517212234.868181-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; h=from:subject; bh=wvKVL3ZvHJApmM6H5ZjVHfC77q4Z7C8eeNJCjVYEji4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBihBIZFUAj5RR+FhK+1sNHu7PZ2NCF+xbZ1D77mdwO 1SIWNbeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYoQSGQAKCRCJcvTf3G3AJjTDD/ 44XrBbkZDtGl9HsnBqQ1WY0Jx4vUrZlNOSzn+9PHpz6IwOqzd/hF3arbAQAUjPBATQnuMJIdv4CD5K jG2EBFa7MAHpP2Nl1lje4gyCiqnjgI/zJ6pYo4hTQtoHl8FB9Sn63eES/RzS8ND5kD40xFDxpwqgjx 5Od2WzSASVP3UcV6SsFP6mZ4Ec9FNlJIApSCpLGhXuokM243jirRvdWTPoDN8f6TXx79FyC8VQOkC0 y6ngueFZvLmS3W/SIUipiYSvuv/1WKspeU698IsV1kRSpX347MirUs7ZUoJbFq7YNE8n1OAYjC5ZIa IDzFzotBG1I3NedN7wnPeZXjfNA+hbYTfBNXo+8wWro/2+mE/QVU8aq4ORRk1SaQuDQKj9lNKNdDow zordWpC1DRlueK+L+dgBImDdWZW0wEG0hkYWBAHrJkcTvrB7s1XaYCWGCAlVZHrFsGswJmMpWbJef2 aCb19DUaDODAl6ibayTZ2TVgFu0a94NeVS8tNXboL8EeJLNF0EYS37h7ssSVT14CiFkQdGSOSxgey2 iy0hhiDqC+LLpaeMbSpQKbOaXkiJTfmFcEzutgVKgHFm4v3Q0RzgM2daVWd3ERDuhYqRaFOdth7NJG +yUu6/PKLPhR+H8J7GcWDi4qkWKZ9g07hYz4TvmjHm4Sk67Nw6Cmjs5pXlug==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As mentioned in the last patch:

Both nodemask and bitmap routines had mixed return values that provided
potentially signed results that could never happen. This was leading to
the compiler getting confusing about the range of possible return values
(it was thinking things could be negative where they could not be). Fix
all the nodemask and bitmap routines that should be returning unsigned
(or bool) values. Silences GCC 12 warnings:

 mm/swapfile.c: In function ‘setup_swap_info’:
 mm/swapfile.c:2291:47: error: array subscript -1 is below array bounds of ‘struct plist_node[]’ [-Werror=array-bounds]
  2291 |                                 p->avail_lists[i].prio = 1;
       |                                 ~~~~~~~~~~~~~~^~~
 In file included from mm/swapfile.c:16:
 ./include/linux/swap.h:292:27: note: while referencing ‘avail_lists’
   292 |         struct plist_node avail_lists[]; /*
       |                           ^~~~~~~~~~~

This splits up the patch into the bitmap and nodemask halves, and drops
a needless change to the random node helper.

I note that Alexey and Rasmus touched on this area in the past, fixing
up node ids to be unsigned:

ce0725f78a56 ("numa: make "nr_online_nodes" unsigned int")
b9726c26dc21 ("numa: make "nr_node_ids" unsigned int")
33c4fa8c6763 ("linux/nodemask.h: update bitmap wrappers to take unsigned int")

If anyone else would like to carry this, please let me know. I'm happy
to carry it in my tree.

-Kees

Kees Cook (2):
  bitmap: Fix return values to be unsigned
  nodemask: Fix return values to be unsigned

 include/linux/bitmap.h   | 14 +++++++-------
 include/linux/nodemask.h | 38 +++++++++++++++++++-------------------
 lib/bitmap.c             | 28 ++++++++++++++--------------
 lib/nodemask.c           |  2 +-
 4 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.32.0

