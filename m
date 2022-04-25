Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E41350DAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiDYITw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbiDYITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:19:24 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9665D64D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:16:19 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p65so25598832ybp.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvlUCJWkTnh5l62OzSLwcVwwIZnTQuRAwqmMP5qNiQI=;
        b=BTqz5xSnKN3FngdlGeXXOw/BMiUg1U8P3+QOKjn1KlBx/FS3glaq3yUW8qh/y1pCxk
         meH5JNw7HEhR8Z0BBtXzsRUSvCzYlgj3kr9yOROOkBrRODs0+nWpgh2ZcKbZpY4MeDc0
         O1OahTH89kEcdRiCGzLXZ2K+W65id0DDp4mSxGpmGISmNb9Rj80z8SW1e9NZuSaQpTME
         6Z/Viea+Gted9vqIzb742TMmqkKoOKhWM625d+FrpuaoHKa8DnSHlYs9TCfrWYLmmk8l
         hSoGOuYhLnlxHzeYiwwEw5g2wslNMwZKj45QiaqWtLi1XyurS7Lh59oEHpPpsFcRJkBA
         ym5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvlUCJWkTnh5l62OzSLwcVwwIZnTQuRAwqmMP5qNiQI=;
        b=s7+sjcD1jNEZU8S+FH2iYFM0/ezPYWCNA937VzAMFjieI+B6ZLAcsdB8za32YXxuhc
         CtWR+4V6IQNm55MfpFM5Pk2bNBcgRLPnPFarA0fFzoxsWDKN3MXg6PUY1woRWQuOoEQt
         Ay77nqeExcn7VQATJ/GXFTIUS6bXexsHv5vcl1/BFViZA7RKdOAvTebMJEFNYpUEgNng
         sdPeRxojhW7wCVgaJgFvfJTFxDFHmgMWPKwlc4WHv14pajAI4Ka1bhsjzvRite0hkMsN
         IhGvmxuvRvShiBTrL+s7pBKFkdP6dP3a3kVa589bjVPTKjpIiOLViJh/atJkDzzAX1q2
         Lb4A==
X-Gm-Message-State: AOAM5329Ha9F7N61bEHhTxnIRxwRuxE3zPOEgglbwc0qlamT953XaPf2
        DbPeeEyFwot9pubmLsibAWbmj2MEMT0XPj+POn/71A==
X-Google-Smtp-Source: ABdhPJzrV4xDmIK6JSyrgmTEvKn1apowsdLUQITQN1TkjlgTxrowrrlE6LP+mtgQMdcEMz4DFucxLnvd6qgt9KjyZg8=
X-Received: by 2002:a25:9b89:0:b0:63d:20e4:13e7 with SMTP id
 v9-20020a259b89000000b0063d20e413e7mr15601411ybo.168.1650874578954; Mon, 25
 Apr 2022 01:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220424105949.50016-1-huangshaobo6@huawei.com> <20220425022456.44300-1-huangshaobo6@huawei.com>
In-Reply-To: <20220425022456.44300-1-huangshaobo6@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 25 Apr 2022 10:15:43 +0200
Message-ID: <CANpmjNO=Qo_wnZ2CH=GqPzyUwQ3jGq_Z9FNQt+Sc_=1ZMV2PfQ@mail.gmail.com>
Subject: Re: [PATCH v3] kfence: enable check kfence canary on panic via boot param
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, young.liuyang@huawei.com,
        zengweilin@huawei.com, chenzefeng2@huawei.com,
        nixiaoming@huawei.com, wangbing6@huawei.com,
        wangfangpeng1@huawei.com, zhongjubin@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 at 04:25, 'Shaobo Huang' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> From: huangshaobo <huangshaobo6@huawei.com>
>
> Out-of-bounds accesses that aren't caught by a guard page will result
> in corruption of canary memory. In pathological cases, where an object
> has certain alignment requirements, an out-of-bounds access might
> never be caught by the guard page. Such corruptions, however, are only
> detected on kfree() normally. If the bug causes the kernel to panic
> before kfree(), KFENCE has no opportunity to report the issue. Such
> corruptions may also indicate failing memory or other faults.
>
> To provide some more information in such cases, add the option to
> check canary bytes on panic. This might help narrow the search for the
> panic cause; but, due to only having the allocation stack trace, such
> reports are difficult to use to diagnose an issue alone. In most
> cases, such reports are inactionable, and is therefore an opt-in
> feature (disabled by default).
>
> Suggested-by: chenzefeng <chenzefeng2@huawei.com>
> Signed-off-by: huangshaobo <huangshaobo6@huawei.com>

I missed one minor issue below (__read_mostly for param), but with
that in place:

Reviewed-by: Marco Elver <elver@google.com>

> ---
> v3:
> - use Marco's description replace the commit message
> - keep these includes sorted alphabetically
> - "in panic" replaced with "on panic" in title and comments
> - Blank line between /* === ... */ and function.
> v2:
> - it is only detected in panic.
> - it is disabled by default.
> - can only be enabled via boot parameter.
> - the code is moved to the specified partition.
>   https://lore.kernel.org/all/20220424105949.50016-1-huangshaobo6@huawei.com/
> v1:
>   https://lore.kernel.org/all/20220420104927.59056-1-huangshaobo6@huawei.com/
> Thanks again Marco for the suggestion.
> ---
>  mm/kfence/core.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 9b2b5f56f4ae..06232d51e021 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -21,6 +21,8 @@
>  #include <linux/log2.h>
>  #include <linux/memblock.h>
>  #include <linux/moduleparam.h>
> +#include <linux/notifier.h>
> +#include <linux/panic_notifier.h>
>  #include <linux/random.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched/clock.h>
> @@ -99,6 +101,10 @@ module_param_named(skip_covered_thresh, kfence_skip_covered_thresh, ulong, 0644)
>  static bool kfence_deferrable __read_mostly = IS_ENABLED(CONFIG_KFENCE_DEFERRABLE);
>  module_param_named(deferrable, kfence_deferrable, bool, 0444);
>
> +/* If true, check all canary bytes on panic. */
> +static bool kfence_check_on_panic;

This should be __read_mostly, like the other params.

Sorry for noticing this late.

> +module_param_named(check_on_panic, kfence_check_on_panic, bool, 0444);
> +

Thanks,
-- Marco
