Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B250C9AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbiDWLsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbiDWLsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:48:12 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A183002
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 04:45:13 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KlqFz34jpzMqFML;
        Sat, 23 Apr 2022 13:45:11 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KlqFy3YgyzlhMBp;
        Sat, 23 Apr 2022 13:45:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1650714311;
        bh=5oQ+gRaiMvtEmoQjhrcqrcZbqQiRRGUiVauT8l/YIQU=;
        h=Date:To:Cc:From:Subject:From;
        b=X84gzasPjND065BI1BzERxp7HpevtXwsQbaIe15uCtTStL6S1Q/V7CFIArfwtt8pp
         FwdxXUNUr71+nSLSL/qrQ1paWTurUsMBrs7qfuKngfKjiBoXTvGUq2jAODf47ZE5rD
         YDzZO6MjIb62DtLBmJjhHe8yitj0g4lI8apNWiRU=
Message-ID: <8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net>
Date:   Sat, 23 Apr 2022 13:45:32 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: clang-format inconsistencies with checkpatch.pl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to use clang-format (with a pinned version, probably 14) to 
keep a consistent coding style, or at least start with one. However, 
there is some inconsistencies with the checkpatch.pl script:

In some cases, goto labels are indented, which checkpatch.pl doesn't like.

checkpatch.pl complains about some functions (e.g. FIXTURE or 
FIXTURE_VARIANT_ADD) that get an open brace just after but without a space.

I also noticed that there is some clang-format configuration lines that 
are commented because of incompatibilities with versions older than 6. 
Shouldn't we require a minimal version, at least the 6th?

About checkpatch.pl, it incorrectly warns about space between function 
name and open parenthesis for *for_each* functions (specifically 
interpreted as "for" statements in .clang-format, e.g. list_for_each_entry).

Regards,
  Mickaël
