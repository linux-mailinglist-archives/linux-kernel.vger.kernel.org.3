Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B74A9617
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357743AbiBDJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357504AbiBDJWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:22:10 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F2CC061744;
        Fri,  4 Feb 2022 01:22:09 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id p7so11741472edc.12;
        Fri, 04 Feb 2022 01:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=Vi1CagBmHHY6BWuDLD9sg2PwlEL1u/EnM6glaNaac0w=;
        b=fdr+7b0omHQhVg+MVYbYuFr5AGXC6irOiO1kRGS2LXcghsiKL5Cwlb0YiOT+2vDWEF
         EQwaxNWToC3KwINfmboeJzo0uGF5DzdM6aeOkSis2SP9Xj+x7Ss9HfsFg5Xs32pPPuy0
         VqFJcHtFJjIWCgEFk2ZpsbEFyO/2wpTLwyeE1Tk6bp2tfHTSgX9xErln8mE0GXPrPPx6
         GFSxM6zB9/SSGuxl9B/aZDEraBOiZbY2g3mn7Kle7jaz1XQj1zFIEyWO6KLZIDuYzem3
         /0D8NIFH1Z73EON/UXAFqKzP1U35in/m2IesT4/fSi//WTLRVj3WPxvPL3QCcm09M+yM
         BzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=Vi1CagBmHHY6BWuDLD9sg2PwlEL1u/EnM6glaNaac0w=;
        b=TxHuxPFX7bSyrNw+Ij+BE29LH3P3e4yp+0M2uCkZT2vrh7FJxvlzJ9mG84eplYtvVH
         ehXcz9KuWCVdClnssQAjRZ0cz8CPWobDAhFuTW6cJz96ijjyRYlFDkPw8/EwSLILBKNJ
         VJWv+tcCqItcGB/OcCTUzDACMETl3DTbgljHsXWPvBH5FYvWihyHBfygKO3FESfHW82x
         QD/Lsdm1Wr0u7OHAbEMnUGbVeM7kstKbGA/3zSmSh21RQA9A/U1caIzGSTY3PBnjlWj5
         nvQB1447sU2dnI1I4rhNBSJ3IpHuNbl7qtxEZmeqZN0H2y8o8jGIIAavfYLh+DiRVkmd
         nwXw==
X-Gm-Message-State: AOAM531dO8VaT6XkadNAWd3bu0RuDaMuhlGwQgbZ16L4mUwzLVhz+UqP
        xyRGxdkDNP5Kmq9OJFH6x8tbQh5+KDDyRg==
X-Google-Smtp-Source: ABdhPJywJPT0YdBYMmGbk+Cs5TIDA7OAW4W7IpWZcRFLV4e7cZ638gY4knaB060ey+M7WNn1lJ4IhA==
X-Received: by 2002:aa7:cb42:: with SMTP id w2mr2071329edt.376.1643966527835;
        Fri, 04 Feb 2022 01:22:07 -0800 (PST)
Received: from [192.168.2.27] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id s7sm446393ejo.212.2022.02.04.01.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 01:22:07 -0800 (PST)
Message-ID: <feb7e4b4-1a6f-71a7-0cdd-fda547408bea@gmail.com>
Date:   Fri, 4 Feb 2022 10:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Kozina <okozina@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
Subject: Partial direct-io loop regression in 5.17-rc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

It seems that there is a regression in direct-io over loop for partial
direct-io reads (or perhaps even for other situations).

If I run this code (loop over 6M file, dd direct-io read with 4M blocks)

IMG=tst.img
LOOP=/dev/loop66

truncate -s 6M $IMG
losetup $LOOP $IMG
dd if=$LOOP of=/dev/null bs=4M iflag=direct
losetup -d $LOOP


on older kernel (<=5.16) it reads the whole file
   6291456 bytes (6.3 MB, 6.0 MiB) copied, 0.201591 s, 31.2 MB/s


while on 5.17-rc (tested on today/s Linus' git) it reads only the full blocks:
   4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.201904 s, 20.8 MB/s

No error reported, exit code is 0.

I am not sure if the reproducer is intended behavior (there was
some discussion, though), but it is a major regression IMO.
If you do not want to support partial direct-io, it should return
an error then and not EOF (the last read returns 0)!

It was detected in our cryptsetup testsuite and we always use
direct aligned IO, but for the reported device sector size only (like 4k).
But here it breaks dd without any chance to detect error.

Bisect ends on your patch (and clean revert indeed fixes the issue):

ceaa762527f41a431b552bc000de4b626d2d8cb7 is the first bad commit
commit ceaa762527f41a431b552bc000de4b626d2d8cb7
Author: Jens Axboe <axboe@kernel.dk>
Date:   Thu Oct 28 08:57:09 2021 -0600

      block: move direct_IO into our own read_iter handler

      Don't call into generic_file_read_iter() if we know it's O_DIRECT, just
      set it up ourselves and call our own handler. This avoids an indirect call
      for O_DIRECT.

      Fall back to filemap_read() if we fail.

      Signed-off-by: Jens Axboe <axboe@kernel.dk>

   block/fops.c | 37 ++++++++++++++++++++++++++++++++-----
   1 file changed, 32 insertions(+), 5 deletions(-)


Please could you check what's wrong here?

Thanks,
Milan
