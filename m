Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335E75207C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiEIWg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiEIWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:36:19 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352752B9C8B
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:32:24 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id e5so13182136pgc.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=wogL5SNF6fBWUFbVfNImZXe0oagV0GR5P/uvXUVTGHw=;
        b=IJlSe/QYx+QBVtXsevt86SPgzwgnfYUoN/+MtyvqGNjARDi5TpCiQz6TJD5R7+mW5m
         x1JKsPS1APmscP3dprFiIQRfFzjXXfYVyAdBp2oqTtlD1pomh7P+T8/J1bw9I193p9rb
         iVTOupRBY/ZlX0QdHDGqSv2jYXcpZIJ3YFVWw8NHqfqSpy1JsSbHDLG1NlA8aj1y3A0B
         deI6rVkM4HytF4YzYO3kSyKYzQRH/4jZ9v0kI2MOFYw1Tqmz4RjwXhlBTcoq+tlKfZ7W
         HZ2zuhLgAk5S9uqogxOl7tNwVp13lu6ZXSnuV0Irnw4mmHrGSywUR+iz7poAhIuNIWUQ
         /hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=wogL5SNF6fBWUFbVfNImZXe0oagV0GR5P/uvXUVTGHw=;
        b=sxtqWk/hQ/SIlyPrRXTv39Oflfb3Zs8hwkxL1YjrtqK2u8zepRDASmszn66oEEzC0n
         aJoZ1F0qRU2GU+uq0Bk1kjEIbhOZSP3mD54Ypy8J5+JpoZgW99T734ISlxthAnrM8uLl
         ySyNOwKJnGoHdhsZDLLpG12deWOi2W/fE44yds+wjRcgSmcFV5N1H5f3uH3cle40BfDB
         DBzid72OZAhN6Gpu79pLDZ+KMDL1lS8YSNCh6GVoDvi5AhPmlCRyGnWklwtBS0P7ND0p
         fbA2hVACVYAE02ASg1fCpk+WPFDRUUf3c3gIn0gLfba92pSCOtytnVgr9oixgvCQHk99
         B+Lg==
X-Gm-Message-State: AOAM531Ty/Oym2vZTFHODQFja1ZiXebjHBB/SVhXIWELMXBPfm8l1tYV
        Y+uMV6iXILoHO22j5l1d6eQTqw==
X-Google-Smtp-Source: ABdhPJyAwHjkK3tRBZ297rtg0Bed+Rov0Lqf/ttVjbMRkoVNvpEnT2Uuc+cDP/CXmoRrMY/G7ikPDg==
X-Received: by 2002:a63:f710:0:b0:3c6:3561:42a5 with SMTP id x16-20020a63f710000000b003c6356142a5mr14416105pgh.295.1652135543686;
        Mon, 09 May 2022 15:32:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b0015e8d4eb1besm423397plx.8.2022.05.09.15.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:23 -0700 (PDT)
Subject: [PATCH v5 0/7] Generic Ticket Spinlocks
Date:   Mon,  9 May 2022 15:29:49 -0700
Message-Id: <20220509222956.2886-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes since v5 have been very minor, just some tags and a few
wording changes to the qspinlock comment.  There's also a PR for Arnd's
tree, assuming that lands I'll take the RISC-V bits into my tree and
assuming the csky and openrisc folks don't say anything I'll take those
too (though now that we're got a multi-tree merge going that doesn't
matter so much, but I said I'd take them so I'm going to default to
that as everyone else may have tuned out).

Changes since v4 <20220430153626.30660-1-palmer@rivosinc.com>:
* Some wording cleanups for the qspinlock comment.
* Collected reviewed/tested tags.

Changes since v3 <20220414220214.24556-1-palmer@rivosinc.com>:
* Added a smp_mb() in the lock slow-path, to make sure that is RCsc.
* Fixed the header guards.

Changes since v2 <20220319035457.2214979-1-guoren@kernel.org>:
* Picked up Peter's SOBs, which were posted on the v1.
* Re-ordered the first two patches, as they
* Re-worded the RISC-V qrwlock patch, as it was a bit mushy.  I also
  added a blurb in the qrwlock's top comment about this dependency.
* Picked up Stafford's fix for big-endian systems, which I have not
  tested as I don't have one (at least easily availiable, I think the BE
  MIPS systems are still in that pile in my garage).
* Call the generic version <asm-genenic/spinlock{_types}.h>, as there's
  really no utility to the version that only errors out.

Changes since v1 <20220316232600.20419-1-palmer@rivosinc.com>:
* Follow Arnd suggestion to make the patch series more generic.
* Add csky in the series.
* Combine RISC-V's two patches into one.
* Modify openrisc's patch to suit the new generic version.


