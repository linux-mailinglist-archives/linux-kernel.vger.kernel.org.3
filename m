Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29253F2F1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiFGA1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbiFGA1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:27:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C671D19CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:27:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e11so14043711pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wgiMZnLydACwnhKRavqmXkM3KhW0U0vaawv3CX7B558=;
        b=XwG2oerM4hfnROOVLbvYIF/tEaEmyqlL/x4/kt4BOEW0BDyRVuU18G7CcpEmnRvf7G
         iQ4ck1OLLRX6lEQZwjFQ9/xdNrSm6iHWQH86G0t/KyxbVM5kt3mNrpChHCi020Av4D4Y
         6iYQdXH6ESeHIsoRvqdv8AAO/4qZ7oZNWnQMG+yobSG0s+JrOhBTqjGXPzqrASIpGoKp
         qUEmjN7XITBqdtuDAlasYSGoOsDm/RDfLMy8m2PkRkxl+EGCxehFJmr6xwEdqtsPRdUr
         XVL1dOy6roAO+z4pjL2IuUle9hImMm486Qpoa4pwaoMRqM4vLD7yQHGUWao9bNN8ZEaN
         CYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wgiMZnLydACwnhKRavqmXkM3KhW0U0vaawv3CX7B558=;
        b=BKwRFO/Vqo5GA6FfgRB9SzU2d1s3xm3JUN9r6XL6MgS6VdYJyfoqsAJ/F7n9HdPLu3
         Chdw1EVkDcwhdzoUp9wICdXawk01mKHnJbzAtbK8cX0HHTy5S8uiB9XE+fTcHAG7vjB9
         RcUQVCl+UwxK/22Z8cP/JNPPtOOOONAwHCL20x3KfhtVIitDJRaXdi0vg2DHqA9h33ut
         +v7Fd7QjJh6ZZyaWbLcUGMjHFaRFeZDriCnSNRfWu3gdXrrYfcOPPEqQOuPEyi50sXc/
         6ksyFotcVWCoDyOcljGqCrkuiAk5I8ekd6g/vs29VFZTUjGffZQGwDEzbf/aznJuAxwC
         HELA==
X-Gm-Message-State: AOAM532UcgqeS6yv+TOgivFmY3Hoo1mUyphfDim9G7W2jvy2TFVqIY/3
        4Pi0+d7XfAzPyeyFsFGPTam6GA==
X-Google-Smtp-Source: ABdhPJwnBdZQBmY1zcDbaBIZM38yQjeNlnwWgBabh2he0SZ0vHLyFQ6avY3QsBeiGpQ+8/n6jxk3fw==
X-Received: by 2002:a63:d34f:0:b0:3fa:8a90:f395 with SMTP id u15-20020a63d34f000000b003fa8a90f395mr23741540pgi.107.1654561622571;
        Mon, 06 Jun 2022 17:27:02 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:ccc7:2cf6:b776:1e0d])
        by smtp.gmail.com with ESMTPSA id 69-20020a621648000000b0050dc76281e3sm8590039pfw.189.2022.06.06.17.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 17:27:02 -0700 (PDT)
Date:   Mon, 6 Jun 2022 17:26:58 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>, llvm@lists.linux.dev,
        Sebastian Ullrich <sebasti@nullri.ch>
Subject: Re: [PATCH] perf unwind: Fix uninitialized variable
Message-ID: <20220607002658.zkbs4c37ihmivcmn@google.com>
References: <20220607000851.39798-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220607000851.39798-1-irogers@google.com>
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

On 2022-06-06, Ian Rogers wrote:
>ret may be uninitialized on error goto paths.
>
>Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
>Fixes: dc2cf4ca866f ("perf unwind: Fix segbase for ld.lld linked objects")
>Signed-off-by: Ian Rogers <irogers@google.com>

Thanks. Sorry for my mistake...

Reviewed-by: Fangrui Song <maskray@google.com>

>---
> tools/perf/util/unwind-libunwind-local.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
>index 37622699c91a..6e5b8cce47bf 100644
>--- a/tools/perf/util/unwind-libunwind-local.c
>+++ b/tools/perf/util/unwind-libunwind-local.c
>@@ -174,7 +174,7 @@ static int elf_section_address_and_offset(int fd, const char *name, u64 *address
> 	Elf *elf;
> 	GElf_Ehdr ehdr;
> 	GElf_Shdr shdr;
>-	int ret;
>+	int ret = -1;
>
> 	elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
> 	if (elf == NULL)
>-- 
>2.36.1.255.ge46751e96f-goog
>
