Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4934900EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 05:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237121AbiAQE5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 23:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbiAQE5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 23:57:33 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FCC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:57:32 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j7so12037175edr.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 20:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EGUJeiLB/ZPJRzDyzkwCPPzWg09D1+bq1HUpUmr8PxU=;
        b=f6lgSAggijjILJia0DzHVLMwMwk7oYL3zRnoTBcXP/i35YHHrcZ7EM0wBVF+4UuaJ8
         ybFKaroRdcV5882qfqINNZfYMw1T2BP4Xui2oFghguPCYzuBu8os0WXRm4Tj/aoihLOb
         mqAqKKt8xBLigi64q5wbrPCFqr4wNdVhb/LGpMPqZ0JrERPqdNko+IncqQJk5NsjIjSQ
         xMnZ7GrEo4kqpcWSfTE/lR++y00aekdUDQbCn6B+i+vEVJCoWRtQQrTsHW+zWs4oKSL1
         6SEb//XKvchG+DXjxd+NSSQ3ijrjkkq5fPpdjteZeNB6m++AsYhk35m52/mnuFKEUkzz
         1M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EGUJeiLB/ZPJRzDyzkwCPPzWg09D1+bq1HUpUmr8PxU=;
        b=z1BhvF+ZrNsHp5sCdHE1UXx2r8fpF1pNzQi2zOtMhVOeJ2oFOhjpFObJgNBCdV0A01
         1NciRF7kz645jzvKWjrFVBjgW0Q9dN7lftFwEoj1cERnstbbOBbRNEKKhjK6TBXFrWQJ
         CGlrRXvqG9+WGB3rMGlGkSRHpNcjxCL1wey82Tcg2RsLATJ0Nqt84Rhym3gRTXBFGZjZ
         ysif+P6Q+n3/IiEoh1hHXKaNXs4w6H74BHL8OO5FSHBcrNO4eEYQnbsMDqmVNsPQSrb+
         mA3FdYi6TBNe/VNpACPFDnFu162ojos6z79+am5mNDVS9Re2sv5a0wQQ2sIdQ3lTMUlE
         XgJA==
X-Gm-Message-State: AOAM530Tu6JIOybRmtcPygobE/pIc9VKfXpWwYq5Xx/p9RIpffgtqGEq
        Q3wbq4UYnXNEplzteKh75werPSBuxGl33eZIrfBrA6OqKyk=
X-Google-Smtp-Source: ABdhPJzRrBucnkT9XWULYbT2rdGgErs/b/9j21jp0VlNbDIZuTtrH7RK8DHQpoXyeDoovlM2wnRi+NV+gIA2Z2Bi7UY=
X-Received: by 2002:a17:907:8687:: with SMTP id qa7mr15101880ejc.106.1642395450332;
 Sun, 16 Jan 2022 20:57:30 -0800 (PST)
MIME-Version: 1.0
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Date:   Mon, 17 Jan 2022 10:27:14 +0530
Message-ID: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
Subject: Issue using faddr2line on kernel modules
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jpoimboe@redhat.com
Cc:     Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

Am researching using the cool faddr2line script to help debug Oops'es
from kernel modules..
I find it works just fine when used against the unstripped vmlinux
with debug symbols.

My use case is for a kernel module which Oopses, though. Here's my scenario:
I built a module on a custom debug kernel (5.10.60) with most debug
options enabled...
KASLR is enabled by default as well.

A test kernel module Oopses on my x86_64 guest running this kernel with:
RIP: 0010:do_the_work+0x15b/0x174 [oops_tryv2]

So, i try this:

$ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x15b/0x174
bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
$

(It works fine with addr2line though!).
Now I think I've traced the faddr2line script's failure to locate
anything down to this:
...
done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 ==
fn { found=1; line    =$0; start=$1; next } found == 1 { found=0;
print line, "0x"$1 } END {if (found == 1) print     line, end; }')

The nm output is:
$ nm -n ./oops_tryv2.ko |grep -i do_the_work
0000000000000000 t do_the_work
$

nm shows the text addr as 0x0; this is obviously incorrect (same 0x0
with objdump -d on the module).
Am I missing something? Any suggestions as to what I can try, to get
faddr2line working?

TIA,
Regards,
Kaiwan.
