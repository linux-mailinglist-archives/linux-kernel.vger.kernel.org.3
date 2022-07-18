Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E2F577E67
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiGRJNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiGRJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:13:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B3A13DC5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:13:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y4so14376786edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hA5CapAKtzJV+uj8Z57awyfl7JxlzocwfCdrGAprc0c=;
        b=PCCmqYwutA0wD3JGFwJ69zHMjyuqe96uN2G7gFYghz0Eg6yKaVux7Yt32L89y5XpEf
         hB9wSKIOy0ok4mjUnXNfuB5YrBX13+jq+vB94MGxQrM1W/FqHKHnnHUzVquTrafV40l1
         xaMH6DriDtpn2QfU+rUy/kjQ8HDBlPF4jaxpwdA69EExRSs2NvcxzzTA0Pnvmr8pViDY
         2impSoclIysxvTuC7sPg7ygEYDnPonHjoYB8vUoRFz+d1zIJ2Sv2ZLwkivZHAFTWAsF4
         t6mXD6isv4Q4Ri/yCsmG0J/+BGAN8clIt7yNVXpB9KvOt55vInhRi9vB5puZUD5zLXzT
         xgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hA5CapAKtzJV+uj8Z57awyfl7JxlzocwfCdrGAprc0c=;
        b=TnZ/T6dUFamJ5heQDLJqUoUBoRpG4KEt6blY5okdU2jDhO1IQmm0p4ujVGKXAPHI0C
         NFiSIpFIVeSgLQAYAxl/jutoE306vzDtp3VZDIH9ng3InKKEOyj8ckYd9ZjDSCQMIInC
         ypRfq1Qm2I0wm6xGgqSMx3yl7e/xfHQ5lr3/uXi/x7yRHLbNpbU0uu/1ektzI6kfqdNv
         BBq1QCFtiQAzRAdDphI64qEfNbt9Lb/axp8m+SwIcGbNxdD+FqW9bsbIa1X5XrGQs+Qz
         ZP6z4jSIU4YLwHYMRa5QXvkZt5pVTWWKC/dxKiHgx7nCbkS3gi7XfirrHlLiEtDOsVUU
         DwlQ==
X-Gm-Message-State: AJIora8f5VltygkfiwBKlolFtNBRN+MW2Qg0WWYE/wPJYdYuifqWjlYC
        MYwhi790QdpWS1Nv8DX8HOENJh/1Yms7nUvTBNWKFw==
X-Google-Smtp-Source: AGRyM1s6m94QWLB9KMkFDB4SmUBYha9Gv9TmGVMrhJyxGiTH5MMtYlYqPYXfdOjZCC5ykqkZvKODf2udEWIxhkC/KmU=
X-Received: by 2002:a05:6402:3307:b0:43a:826c:d8b4 with SMTP id
 e7-20020a056402330700b0043a826cd8b4mr36416874eda.32.1658135584990; Mon, 18
 Jul 2022 02:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220712021527.109921-1-lihuafei1@huawei.com> <20220712021527.109921-6-lihuafei1@huawei.com>
In-Reply-To: <20220712021527.109921-6-lihuafei1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:12:54 +0200
Message-ID: <CACRpkdZVxyCsENJQ_-KZBMHjVrYCHzFG2UdCAe=mt_5Ts8_RFw@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: stacktrace: Convert stacktrace to generic ARCH_STACKWALK
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk, ardb@kernel.org,
        will@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 4:19 AM Li Huafei <lihuafei1@huawei.com> wrote:

> This patch converts ARM stacktrace to the generic ARCH_STACKWALK
> implemented by commit 214d8ca6ee85 ("stacktrace: Provide common
> infrastructure").
>
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>

Looks good to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

What I want to know is if this commit will avoid the problem mentioned
in review of commit 3? I.e. the generic stackwalk code will make sure we are
not running the task on another CPU, so that is why we could remove
that check?

Yours,
Linus Walleij
