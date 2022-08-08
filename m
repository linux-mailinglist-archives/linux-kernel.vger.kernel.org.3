Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B2358C61F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbiHHKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiHHKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:13:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5398E58
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 03:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659953609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zO6mD63vNeVl3wGGqhk3OPw3u2xEnnAeJveHUDbY6L0=;
        b=I4uxBJ5U4ZPjzrg/NahVrcvUL+PS2ClGJLNwmbn31dloyZA2fLDENvXNqKhiD9N95QHKGv
        hXD6LvOtsoZBMtU8eRZ9h56HjiB+NXjTR0KGMs6IG1pKeUOpH/vvuc+XcEazKwDdFnxHlZ
        jcrnc5a6r3IIR5R+Y5AZFnpYTUhCSkc=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-aTzMf9meNemFQGSACmIVTg-1; Mon, 08 Aug 2022 06:13:29 -0400
X-MC-Unique: aTzMf9meNemFQGSACmIVTg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-3225b644be1so74038637b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 03:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=zO6mD63vNeVl3wGGqhk3OPw3u2xEnnAeJveHUDbY6L0=;
        b=dEdV9sdccrYrS0B3JTFxPu/uvCSPoEA+HtxQfo+hVap7Tw8CQ4LrJDHnU8tWfoBH2j
         qCsAH0UHwqizJgUfundSoYJm817rIh793QI84oVTIPE1vPxiBf5V5adYpo1DOnaE5lxT
         CoDRTBuY0YJBY26oaXqG07MlArffTY08aOuqAerxrjXWEf5isfTB6iaBsZ7q5O8xrzFW
         OUmd5LTF6iZcbQYXqsuUkftToKyFTBXnhEOzFhDS4ZUhdVA9fV35dEqnZ1ZERKFme5Nn
         X9kIVtHEN+hMGnO3AmgvBYxK5m2xORBpAoMrQ/lpp80tv5iJiZ6R8kLTyBInd+CQeH0K
         QLfQ==
X-Gm-Message-State: ACgBeo0aDyvuq0pSqyslDxoydUKyBlLq7b00MpEqm2nfUFdlHUNNPfrx
        l8dglO91/P57BPtzMRFht6ivCxZoYRaBUcqZV96jXHd82lqDbKPOif8JnD/AKOJXCwv6dXGhP5q
        +O2CpPlFBfKe+450TLlCO2GBXorlrCnWKjBRcGx81
X-Received: by 2002:a81:c30a:0:b0:328:4a6c:bc89 with SMTP id r10-20020a81c30a000000b003284a6cbc89mr17108394ywk.29.1659953608306;
        Mon, 08 Aug 2022 03:13:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4gocRIbQS2ArVfaEK1aw4hYUpKoWxZaNHGdF60biSm6CliwAsUJATbgxg7roEmvR2O8zkLMOdpsAjelwFhieY=
X-Received: by 2002:a81:c30a:0:b0:328:4a6c:bc89 with SMTP id
 r10-20020a81c30a000000b003284a6cbc89mr17108379ywk.29.1659953608123; Mon, 08
 Aug 2022 03:13:28 -0700 (PDT)
MIME-Version: 1.0
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 8 Aug 2022 12:13:17 +0200
Message-ID: <CAFqZXNtNjQLpzu4CFiMawfkKeVFULw4ti3MdZL1QejPrzeJv8Q@mail.gmail.com>
Subject: Binder regression caused by commit a43cfc87caaf
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

FYI, since commit a43cfc87caaf ("android: binder: stop saving a
pointer to the VMA") (found by git bisect) the binder test in
selinux-testsuite [1] started to trigger a lockdep assert BUG() in
find_vma() - see the end of [2] for an example.

A minimal reproducer is:
```
git clone https://github.com/SELinuxProject/selinux-testsuite.git
cd selinux-testsuite/tests/binder
make
setenforce 0  # if SELinux is enabled
./init_binder.sh || true
./manager -n -v & sleep 2
./service_provider -n -v
```
Requires the equivalent of libselinux-devel, make, gcc, and git-core
Fedora packages.
The last command will trigger the BUG; on good kernels it will
successfully enter the ioctl loop.

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://s3.us-east-1.amazonaws.com/arr-cki-prod-datawarehouse-public/datawarehouse-public/2022/08/07/redhat:606549366/build_x86_64_redhat:606549366_x86_64/tests/5/results_0001/console.log/console.log

-- 
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

