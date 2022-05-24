Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48A53240C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiEXH0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233920AbiEXH0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:26:02 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356B9548D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:26:00 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i187so27168167ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3ADQCREbWZJgoHzXNT4SqhngDOz5wX2IM0lbpMtxoc=;
        b=izrk844FQF3CPJ39B7iE/hbTnzveN5okwNk4FqFu3T1zGffBMkch2CEh0DsNMudTj8
         i86k+u6QavUQH7dqEokiALt3sjaUTnyuNdYas2IkOr2LYm9vYkVc2OOFa5F3zQqagyEe
         nTGOIUMCXwZdIO1e6I68RYwTEntPwuvN9Ek0B+WWxBr8Br86FV3lOVH/gihGoBNdsUbW
         K2G648t+WETJujvuYJq/6EGQgdT7YHmHCDZvR7kRUjz1d6rF/WmeVZ+zO92hvJp242v9
         sDxBVlzYE4SQHrY06X+QbDLrZcZfMc5x5Uo4sDn+3+hnj7bqL1ygPdgqEaWDk/RwOQTx
         M0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3ADQCREbWZJgoHzXNT4SqhngDOz5wX2IM0lbpMtxoc=;
        b=TJMOqeILYCjN4OndvWt93Uh90eQipBWxKOkU/S8lOK9lSu8z18hxdZFrpMfgpqfjsZ
         d3AVSCJjXjUReJ39PQ6ffmWieT/1Z8ngHuh6ma7G5dmCXLGOHf6pjRuMYltT0yZ0HSVr
         Yrl/L4T8j0bPjcq612VFtZcUY1U8zQBv4s+vQIcnVyCgbFux9gPeFB7smY4xnLd/bkpQ
         abOGGjGQ5ijYRYvPdfR44n+s9YhIg8P42C2lBq0O2jUOhMknYpAcxiziVoTLT0cMbqdp
         JdsR1pW994rM00bTPyKaK+bwkKHTPACELB6po1r801W+ZgbDjMYGpLWDSdeZGJzoRKww
         L6xA==
X-Gm-Message-State: AOAM53214juZkMLwaBe6n1t1tOBSZZlA+ARlbKJOjF9b1+GZdoo38jJ5
        ovBSWmVRlMMVLF+SGBPPuIzJTDPodXvS7GygXfluuw==
X-Google-Smtp-Source: ABdhPJxqmGs4DGjpwlmXW5yjEYYSk4jao8NINHIFisXpg712mVqO78RiARrF6d7rCCgG9J7Lhpc+C/7YDrfXZkix8LI=
X-Received: by 2002:a05:6902:704:b0:64d:f270:22b0 with SMTP id
 k4-20020a056902070400b0064df27022b0mr24774879ybt.626.1653377159322; Tue, 24
 May 2022 00:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220523141009.52965-1-linmq006@gmail.com>
In-Reply-To: <20220523141009.52965-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 May 2022 09:25:48 +0200
Message-ID: <CACRpkdb+-urzSHCuug0qa=oytNuyBZyFafBBJ+1D8Yatks7Qew@mail.gmail.com>
Subject: Re: [PATCH] power/reset: arm-versatile: Fix refcount leak in versatile_reboot_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 4:10 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node_and_match() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: 0e545f57b708 ("power: reset: driver for the Versatile syscon reboot")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
