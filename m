Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A414D4239
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbiCJIKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235113AbiCJIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:10:14 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1270413395D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:09:14 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m12so5878221edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWbAcZy/i8HBYK2+LI1DmtpGjLhVyIVjDAmA+olRSX0=;
        b=r6m/oi9HM5b3ptgnBPdqU/JT11+emPMCtpY8bhdnL6IBAKJN+vphDQcvrhnJTPc3pR
         1JsCGgXBT8DO2kGWTbC0J+9Z3EF3A1Tp90hZAOCvXwlJkOLfxDgGSS5Pce72/04ugPzQ
         +WnXeDRI7/T/T/lhFL0US+S7Z5tXpNe0WU+/m+G/P7ZZrvOJNGBx2WcsIgtZZQw5yIrK
         UbvFaNl8O93Sd8kRmpWwK+FbCU9LXfog05Qc632veitsNPPygsBjRmw5wWM9NIsRTIpS
         6Az7Jceq2XZi1vWGRXTwAUJYPWZpcrMA1R0yKz/ZJ3fGc1Cg3uz+4B2170k94UUMLIMf
         /KGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWbAcZy/i8HBYK2+LI1DmtpGjLhVyIVjDAmA+olRSX0=;
        b=fIfHI7inxqE07wGWPN2bXAK0fYl/8dy6LHCMTrneV8peTQpdxVn7Q19l1tvRSP2BQX
         jS5t3KrOKUFN8CxFmzj0/TOTRLBTEQRehPiCYGHBgeBG/VedwzIF9xbwPJKOLSB4e10I
         WU+Au0EFbDqaUFxSxGnAOsN/7ioP4XHEON1xvPxbZaqkqtwyPEBPZpIzupvAZqM0woFX
         QXF/gFX/1eX/zS3mWi7J7Ti8kp+5TX+LwNsoK5UFIdwAn3VHApbmMuzMDJY28HbOKkXQ
         b1g8Ysg4lWfa4oN8muBrnLQiFbzipRyKX33DrD+gWdvbLc65Wziwl10/kWRNa5mAL0CF
         LLLA==
X-Gm-Message-State: AOAM530+AZ6vRt5F5AxH9SuIhm7p5w2dS5zyej+e4Iyp74PUd9YB34dv
        SysCd8W6SL6Ij6vto04iMq+PQ/2Ceu081DFoR9vT648vni07CA==
X-Google-Smtp-Source: ABdhPJxKFn6YeDUx1PfZdbOvWIU7l3YrlqtrpTJvp5FIfH8MbYGg9inD0E2JsB/SRJMRmxjPhbDJO14wMifzXIGlkxQ=
X-Received: by 2002:a05:6402:26d3:b0:416:4186:6d7d with SMTP id
 x19-20020a05640226d300b0041641866d7dmr3159206edd.129.1646899752425; Thu, 10
 Mar 2022 00:09:12 -0800 (PST)
MIME-Version: 1.0
References: <20220309083753.1561921-1-liupeng256@huawei.com> <20220309083753.1561921-2-liupeng256@huawei.com>
In-Reply-To: <20220309083753.1561921-2-liupeng256@huawei.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 10 Mar 2022 03:08:59 -0500
Message-ID: <CAFd5g466XMWRszdn=Wdg4GXNv=KR-CZmWYZ0j0bG7_1QXtu-LQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] kunit: fix UAF when run kfence test case test_gfpzero
To:     Peng Liu <liupeng256@huawei.com>
Cc:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Mar 9, 2022 at 3:19 AM 'Peng Liu' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Kunit will create a new thread to run an actual test case, and the
> main process will wait for the completion of the actual test thread
> until overtime. The variable "struct kunit test" has local property
> in function kunit_try_catch_run, and will be used in the test case
> thread. Task kunit_try_catch_run will free "struct kunit test" when
> kunit runs overtime, but the actual test case is still run and an
> UAF bug will be triggered.
>
> The above problem has been both observed in a physical machine and
> qemu platform when running kfence kunit tests. The problem can be
> triggered when setting CONFIG_KFENCE_NUM_OBJECTS = 65535. Under
> this setting, the test case test_gfpzero will cost hours and kunit
> will run to overtime. The follows show the panic log.
>
>   BUG: unable to handle page fault for address: ffffffff82d882e9
>
>   Call Trace:
>    kunit_log_append+0x58/0xd0
>    ...
>    test_alloc.constprop.0.cold+0x6b/0x8a [kfence_test]
>    test_gfpzero.cold+0x61/0x8ab [kfence_test]
>    kunit_try_run_case+0x4c/0x70
>    kunit_generic_run_threadfn_adapter+0x11/0x20
>    kthread+0x166/0x190
>    ret_from_fork+0x22/0x30
>   Kernel panic - not syncing: Fatal exception
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>   Ubuntu-1.8.2-1ubuntu1 04/01/2014
>
> To solve this problem, the test case thread should be stopped when
> the kunit frame runs overtime. The stop signal will send in function
> kunit_try_catch_run, and test_gfpzero will handle it.
>
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Thanks for taking care of this.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
