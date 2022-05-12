Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082AD525250
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356381AbiELQRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356360AbiELQQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:16:51 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB61689B0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:16:51 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i38so10625823ybj.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7wTiXZa6qZi+HuOeJOMfyweTiYDquNYmgNLPQKJ4no=;
        b=GEVkY8kLTlT3Zy8fuo/W1ScuRvPz67G/Ak9nk9vrqHlwVlQdbmYVORGQ0loita8kIW
         itcV+avbnkCZGJ++sfsBPqncwNp+TByA22jLgIe+QDW2nNo8e2kjxpwARrUecL95MFwx
         P8rFf44fate+74wX19swxBtY9pkFwIygNInH5B/kYFpeML071eBRea9GYDUm0dnUOGpd
         mE8nYc/etwptKy04i9rivVhNdkB7CeRR78jmTlQD+Li+JpUsIbbn/tB+uIUExhB/9V7A
         IM+NsA0rCEy/a9/Lx1Ryw3rs8i2Hy74RKxdoapJstrbZENaWdy6APZiT3KT1p9ueqiUK
         QBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7wTiXZa6qZi+HuOeJOMfyweTiYDquNYmgNLPQKJ4no=;
        b=KqZokWO/xufnR45Q5L4C1sLgmbqU906M/fYAO171+2H/p3QX1kJwOFgZEw00Pk22LI
         re/XYH3HU1Z+WxVe2zTNv9tscbhWwylh5FKQgd/JIx57nr/MlKY3HisXze/Qvr+yalO4
         4XIyXcP2Ubs9UI2oY7IpywO48bre0lcepxRuquOW/6pHczW264bYxCGrv4h2kaQC8UyR
         mBJ+6Z39+JJyyd4tyDrbdNQCTEwMRBvwUH/iSrnxDvOmnzdyhf8puWhflQV/wIB052SW
         7tfDIpBHK4V7Sm+WnNuqNTfJLUIMlNdp8LaDmuMoSSbJ8KUd/MIDGPjeqUuvS2h6vZVt
         RO8g==
X-Gm-Message-State: AOAM532UseXH//z0jHX37AEOWp1aL7UKzoWe/VqZ0JJsJ10N6DX1vLw3
        e+lnCqxnluEzGuU8CjA+kZO5+08R0IjHEaf64/QJKA==
X-Google-Smtp-Source: ABdhPJx5oca/jxocNO5zQOTpuEEq6nsI4kR18n5qlHJZYFRK/0yDJXKbyWMk3qgxNIwVCl2vX4j6nbmRDS9hDaAYB7I=
X-Received: by 2002:a25:230a:0:b0:64b:49c:c67c with SMTP id
 j10-20020a25230a000000b0064b049cc67cmr604298ybj.598.1652372210156; Thu, 12
 May 2022 09:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123313.218063-1-imagedong@tencent.com>
 <20220512123313.218063-3-imagedong@tencent.com> <20220512091558.350899ff@kernel.org>
In-Reply-To: <20220512091558.350899ff@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 May 2022 09:16:38 -0700
Message-ID: <CANn89iLEkgat-es15Sb2naWn8VProMK1_wr7jBe4L4bXs4JVWA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] net: skb: check the boundrary of drop
 reason in kfree_skb_reason()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kees Cook <keescook@chromium.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Willem de Bruijn <willemb@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
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

On Thu, May 12, 2022 at 9:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 12 May 2022 20:33:11 +0800 menglong8.dong@gmail.com wrote:
> > +     if (unlikely(reason <= 0 || reason >= SKB_DROP_REASON_MAX)) {
> > +             DEBUG_NET_WARN_ON_ONCE(1);
> > +             reason = SKB_DROP_REASON_NOT_SPECIFIED;
> > +     }
>
> With drop_monitor fixes sending an invalid reason to the tracepoint
> should be a minor bug, right?
>
> Can we just have a:
>
>         DEBUG_NET_WARN_ON_ONCE(reason <= 0 || reason >= SKB_DROP_REASON_MAX);
>
> and avoid having this branch on non-debug builds?

Exactly what I was going to say.
