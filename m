Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6EB4B8A63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiBPNiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 08:38:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiBPNiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:38:09 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C03E2A39E9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:37:56 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id e13so2518598vsh.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 05:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpeVDWXHMTDc+cpXQL9k9Xn0bqj82ewZzqV/e9KI54k=;
        b=eBP91KuyrWCunQKewYuQ566BwtLHTGen0u7EidMaMnjpn6RJcOvYD/ds1ffBpa6fKR
         dSgD63hLMBcJkJc440HlL+SqPdlaGd7v1sIVB7aaDNPa5wCTNPkIGhFSgQORgkbSxYKl
         kcPKHTbf4Zce4lrT8J6L5usvIUb336Bq2PmOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpeVDWXHMTDc+cpXQL9k9Xn0bqj82ewZzqV/e9KI54k=;
        b=pAh7RMJam1zhUQ2zfQFZDSfBDK29rgmHRCgrQ25XI8bF+nLTTXKxYFpp+Jwh9zr/zr
         PIlhH+Lv/UQrf4+XCFGDxD9zFxmcVmHg1UHfFmI3SFvhK4y2U98q8Fc1srpbypTzAoX3
         S/Lu8cE8BWNnaWkzB0SFu/MJqbYXOS9vByoX6r+C/yiKyLsXFaVwnG4AlTdU4pLmzRqX
         yrOg8/GORojg7PLUYirlozwn2GOWRpN4TZIgQESdGR8EkHO2caa0rHj4MHh5k/ZZNBBB
         5BiSnLfxQjiyHrPfMHuvi6UPreEHVJLrN0eEJwCAhmAevmRDcZZccgt6xs0ibpNRkQFM
         whCg==
X-Gm-Message-State: AOAM533YwVeqjCNM3r+0kYOTqr6XKpEoZj29jnH/vlrloUO7hkri23JI
        tj1auFl3gy9q5bq6bmXRUU11RPe8w1cIU+Yo3tx/jw==
X-Google-Smtp-Source: ABdhPJx0ME4NtqTHyYhVWQLW19f8lbHkntNGob5sMRy/fhsm1HUPUGe5BQQVLyXtNsfHMp29I0F0DmFm5pfkPVz/CtA=
X-Received: by 2002:a05:6102:32c7:b0:31b:8f98:5fd with SMTP id
 o7-20020a05610232c700b0031b8f9805fdmr982294vss.24.1645018675428; Wed, 16 Feb
 2022 05:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20220214210708.GA2167841@xavier-xps> <CAJfpegvVKWHhhXwOi9jDUOJi2BnYSDxZQrp1_RRrpVjjZ3Rs2w@mail.gmail.com>
 <YguspMvu6M6NJ1hL@zeniv-ca.linux.org.uk> <YgvPbljmJXsR7ESt@zeniv-ca.linux.org.uk>
 <YgvSB6CKAhF5IXFj@casper.infradead.org> <YgvS1XOJMn5CjQyw@zeniv-ca.linux.org.uk>
 <CAJfpegv03YpTPiDnLwbaewQX_KZws5nutays+vso2BVJ1v1+TA@mail.gmail.com>
 <YgzRwhavapo69CAn@miu.piliscsaba.redhat.com> <20220216131814.GA2463301@xavier-xps>
In-Reply-To: <20220216131814.GA2463301@xavier-xps>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 16 Feb 2022 14:37:44 +0100
Message-ID: <CAJfpegsQO-35p6uoG2ZfuCOLPFwnkbTcLc3K8r+HiS2un9au_w@mail.gmail.com>
Subject: Re: race between vfs_rename and do_linkat (mv and link)
To:     Xavier Roche <xavier.roche@algolia.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 14:18, Xavier Roche <xavier.roche@algolia.com> wrote:
>
> On Wed, Feb 16, 2022 at 11:28:18AM +0100, Miklos Szeredi wrote:
> > Something like this:
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3f1829b3ab5b..dd6908cee49d 100644
>
> Tested-by: Xavier Roche <xavier.roche@algolia.com>
>
> I confirm this completely fixes at least the specific race. Tested on a
> unpatched and then patched 5.16.5, with the trivial bash test, and then
> with a C++ torture test.

Thanks for testing.

One issue with the patch is nesting of lock_rename() calls in stacked
fs (rwsem is not allowed to recurse even for read locks).

So the lock needs to be per-sb, but then do_linkat() becomes more
complex due to not being able to use the filename_create() helper.
But it's still much simpler than the special lookup loop described by
Al.

Thanks,
Miklos
>
> Before:
> -------
>
> $ time ./linkbug
> Failed after 4 with No such file or directory
>
> real    0m0,004s
> user    0m0,000s
> sys     0m0,004s
>
> After:
> ------
>
> (no error after ten minutes of running the program)
>
> Torture test program:
> ---------------------
>
> /* Linux rename vs. linkat race condition.
>  * Rationale: both (1) moving a file to a target and (2) linking the target to a file in parallel leads to a race
>  * on Linux kernel.
>  * Sample file courtesy of Xavier Grand at Algolia
>  * g++ -pthread linkbug.c -o linkbug
>  */
>
> #include <thread>
> #include <unistd.h>
> #include <assert.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <iostream>
> #include <string.h>
>
> static const char* producedDir = "/tmp";
> static const char* producedFile = "/tmp/file.txt";
> static const char* producedTmpFile = "/tmp/file.txt.tmp";
> static const char* producedThreadDir = "/tmp/tmp";
> static const char* producedThreadFile = "/tmp/file.txt.tmp.2";
>
> bool createFile(const char* path)
> {
>     const int fdOut = open(path,
>                            O_WRONLY | O_CREAT | O_TRUNC | O_EXCL | O_CLOEXEC,
>                            S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
>     assert(fdOut != -1);
>     assert(write(fdOut, "Foo", 4) == 4);
>     assert(close(fdOut) == 0);
>     return true;
> }
>
> void func()
> {
>     int nbSuccess = 0;
>     // Loop producedThread a hardlink of the file
>     while (true) {
>         if (link(producedFile, producedThreadFile) != 0) {
>             std::cout << "Failed after " << nbSuccess << " with " << strerror(errno) << std::endl;
>             exit(EXIT_FAILURE);
>         } else {
>             nbSuccess++;
>         }
>         assert(unlink(producedThreadFile) == 0);
>     }
> }
>
> int main()
> {
>     // Setup env
>     unlink(producedTmpFile);
>     unlink(producedFile);
>     unlink(producedThreadFile);
>     createFile(producedFile);
>     mkdir(producedThreadDir, 0777);
>
>     // Async thread doing a hardlink and moving it
>     std::thread t(func);
>     // Loop creating a .tmp and moving it
>     while (true) {
>         assert(createFile(producedTmpFile));
>         assert(rename(producedTmpFile, producedFile) == 0);
>     }
>     return 0;
> }
