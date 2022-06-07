Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FEB541EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380370AbiFGWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378406AbiFGVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:22:15 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340B51660AC;
        Tue,  7 Jun 2022 12:00:08 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id f7so14933859ilr.5;
        Tue, 07 Jun 2022 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gmFsGC5asBOsMwTokySfFmYzyb+MMlB/ax36UF7roRM=;
        b=KRprMFMJQ8BOYYCx4BfqQEDBD1M4TY98wxdYru5+suebV78nXfhlLKrGnc8GaVErSP
         cjwIYbFU0/mGYM7apRJck5JB2BYQ6/ubIr49yDDlC2WBbGksnuJdw6dxc8K5QQ9NJ8FJ
         LB0gqVLUHL332MSl+0Ggup1JJ9BBGATmQcUsE1L91zB727xv6cHXfEryOy1UPzae8mHq
         lO2544zOWTuhEeJE6bv/A3JYhM2l6pHKhj9R1IZNatNsW08RpBcsS84yGLi5gskQ/zCT
         ebhawZivg1kJjrGwcIhAnVqhXya9oaFlDhC/SBBNHi9cibNN7nYHnHlTLybvCHF4N4qe
         1RVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gmFsGC5asBOsMwTokySfFmYzyb+MMlB/ax36UF7roRM=;
        b=vL3vWZSDMALOxknYlh+UZiiNtJUyylmi6iXVU/Yam53SqCcOoalR45jz10IH3E+nvW
         Uo7+lke2+kxdZnG2UcxvT1Vrew57Gj1JhERmx1MvyA0SY9qF8NQv6bUPtK12ItMs0SBT
         P4FpOMAVORH6w9zcE2xuE1mJ3PsIefoqg4F+8/CGhJvGi2WL4ooZwnkUX/dsLwHjQGQx
         hlUwUD4o8tPry1DhvYJEt+BdV8iSXgeS2+V+pPOFWZRwSv66gZF77KoS3uYacfDLtGdn
         BTDvppplE67W6C5ehkLRW3j99JLGAxKtOs6R5AaCkST3FGL72MHEB+pL5SgXgrwwit1W
         bVvA==
X-Gm-Message-State: AOAM532BFuXk334mmb7Zmq4qCh25wFCMh0EJK0Vwt52wD4cSTk9QB2eM
        atDx9ZUP8pg9IHZ14omJ712lvq2oTZdkxTKpBZcHb4Rbdml4tQ==
X-Google-Smtp-Source: ABdhPJxwLclFuAiiWhqiQoKXWYkJmP0Ngrn9iwSDQKmH+bDO8rFtb0bRQAPa6wYRnhdIUYRQyM1vNCrbUMeS0Q2A0LA=
X-Received: by 2002:a92:cc8b:0:b0:2d6:5389:e7f4 with SMTP id
 x11-20020a92cc8b000000b002d65389e7f4mr1465481ilo.245.1654628407330; Tue, 07
 Jun 2022 12:00:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220607000851.39798-1-irogers@google.com>
In-Reply-To: <20220607000851.39798-1-irogers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 7 Jun 2022 20:59:31 +0200
Message-ID: <CA+icZUWpSF6ge76JVp1qBC5QhC1AwNacs5Di=e1QSbAD+SVKUA@mail.gmail.com>
Subject: [Linux v5.19-rc1] tools/perf/a.out remains after make -C tools/perf clean
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I observed this some time ago - so this is not only Linux v5.19-rc1 related.

$ LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt
make: Entering directory '/home/dileks/src/linux-kernel/git/tools/perf'
 CLEAN   x86
 CLEAN   libtraceevent
 CLEAN   libapi
 CLEAN   libbpf
 CLEAN   libsubcmd
 CLEAN   libperf
 CLEAN   fixdep
 CLEAN   feature-detect
 CLEAN   python
 CLEAN   bpf-skel
 CLEAN   core-objs
 CLEAN   core-progs
 CLEAN   core-gen
 CLEAN   Documentation
make: Leaving directory '/home/dileks/src/linux-kernel/git/tools/perf'

$ git status -s
M tools/perf/util/unwind-libunwind-local.c
?? tools/perf/a.out

$ rm -v tools/perf/a.out
'tools/perf/a.out' deleted

$ git checkout -- tools/perf/util/unwind-libunwind-local.c

$ git status -s
[ empty ]

Thanks.

Regards,
-Sedat-
