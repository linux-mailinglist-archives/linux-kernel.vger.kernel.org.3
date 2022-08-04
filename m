Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967F958A3D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbiHDXPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 19:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiHDXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 19:14:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3A91A395
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 16:14:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id z16so1350344wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 16:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UqlbzCJAY8VENrCVMz+v3dILFUlDvFsp0zoGxXFbGcI=;
        b=Miutd2BoNbFQIGTrdQElo7qVwUmVmzuXCh+XUR7Yq/r3hsQXVGt/UMCp83I70JjSZW
         51vh73wQ5UbgKHxVkxlmg/DGtkvU1agW9/Aioce/UZEYdLzv7tesUpFcf8yCNpqFvwNz
         4UgYBqPJIcJs7aUG/GYCOCxQyjtpj25t5vwMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UqlbzCJAY8VENrCVMz+v3dILFUlDvFsp0zoGxXFbGcI=;
        b=Rlg0igU4Zr5KEZIxH9YNSmkOXA8rGughbawX+NlD5UwwMsgJFlStfRTtODfUCikwrN
         Jw4ccpQcVdV8T2fCl/+bValkVRE3DkE45gwLhAPUQ5FsvBr5X5KL/b/IiOdU0YrelVlh
         pxvrNK60J033x6BexBIFiWSeQ1IOGWqKXcviPEvjJQcQmtANIp/GYI6ee5wHBMJsuh9C
         NtPk34UOakn6UIu50GDW1r5soOSDHUDvyHBwjPOnMKQ02dnIwX5t7mL4W/7UvwaEsXTF
         kfNY3asea2hZ9Z0Ie3ibXyskYt142rQM3JZJHptNSJZUq/B2J83oVOHQwB4vjqUPxQCa
         41Dw==
X-Gm-Message-State: ACgBeo1lx29j6Zbmj2qn8lfXPpe0lXQU36gQlOPabpSLUp3shm92pRSs
        wvDwKqu0kPJ48X+3rrY1rJS8y6sqlAie+7q4hF0nyw==
X-Google-Smtp-Source: AA6agR5JyIrjylEqZg67TMMxn/Wb04OVkD08N9V2JPdB3PSyaEC5/ojwg3RaR5Cl1QgNCInOw+EnsSp+TB32Oyce4Lc=
X-Received: by 2002:adf:fe81:0:b0:21a:3574:ec8e with SMTP id
 l1-20020adffe81000000b0021a3574ec8emr2732465wrr.410.1659654894641; Thu, 04
 Aug 2022 16:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <YuuBrUmiRYoaSmPw@google.com> <20220804142856.306032-1-jrosenth@chromium.org>
 <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
In-Reply-To: <CAE-0n51UcauP1ojoskV9_2+CFPoJrs08jGHVPCZdSA_oXX1zUw@mail.gmail.com>
From:   Julius Werner <jwerner@chromium.org>
Date:   Thu, 4 Aug 2022 16:14:43 -0700
Message-ID: <CAODwPW_mYQ1gcd2Xw5s+7dL2kLcYn-VTxKHUH1iM1V4mn7pT_w@mail.gmail.com>
Subject: Re: [PATCH v7] firmware: google: Implement cbmem in sysfs driver
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Quoting Jack Rosenthal (2022-08-04 07:28:56)
> > cbmem entries can be read from coreboot table
> > 0x31 (LB_TAG_CBMEM_ENTRY).  This commit exports access to cbmem
> > entries in sysfs under /sys/firmware/coreboot/cbmem-*.
> >
> > Link: https://issuetracker.google.com/239604743
>
> Is what you intend to use from here essentially an nvram? If so, it may
> make more sense to expose just that entry in drivers/nvmem/ as a
> read-only sort of nvmem.

No, it is not NV. It's just a normal memory buffer allocated and
filled by firmware on boot and placed in a region of normal DRAM
that's marked as reserved.

> It isn't clear to me what the structure of this path is. I'd expect to
> see an entry for each 'address', 'size', 'id', 'mem' with a different
> What/Date/Contact/Description. If those attributes are all within a
> directory in sysfs then there could be a top-level description for that
> as well.

CBMEM buffers are used by coreboot for all sorts of things and we
regularly define new ones. We can't maintain a full list of all IDs in
kernel sources because it would be a ton of churn for no reason --
best we could do is to add a link to the ID list in the coreboot repo
(e.g. https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/master/src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h).
We really only care about one of these right now and many of them will
never be relevant to the kernel, but I still thought that while we're
doing this we might as well provide a generic interface to all of them
because others may become useful in the future (and then you don't
have to update the kernel every time you get a new use case for some
userspace tool wanting to interact with some resident data structure
from coreboot).

> Do you need to be able to write cbmem entries?

Yes, see the use case in the bug (using the vboot workbuffer from
coreboot as a write-through cache for the vboot nvdata on flash).
