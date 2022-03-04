Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC84CDBF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbiCDSQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiCDSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:16:10 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639A1C666E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:15:22 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d07ae0b1c4so100444497b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KUxn8JdSU+FAiz+Yz45U+PNiIfEjVkTsbOETITn3KvI=;
        b=n0vwTpqyGaSeYU+QRRntw2mfKbgAEHYrx8YQnH8YGsbg4ge9sCog/6QN4ThJOAVrZ6
         0kj2ftdppdOZya/3BITeo1aOBkAbSA2WjA2/NNeg6lsu5hvwpe6e0wRvUQCyeZfs2Isj
         mKyDDw5r64ERuPobZkoNF5at2vYncMMBY2S9u4LCij/oJzuAJPDzyIRQilVpuYrzCKaP
         1D67t0mU6BPrqnjCU487jIe2eS0648F8whYX1KEF9DBj+zGGXzEAnBpnqq0px/4zFk1g
         HP1V9Tb0S1skyDE7NshToa7WOYx3Iu5Q5SbS4CbbyyJ8zGdMcyz5ybmhKBAjcVu3UNJ+
         1Vew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KUxn8JdSU+FAiz+Yz45U+PNiIfEjVkTsbOETITn3KvI=;
        b=H5+hsqHBOOpC22vCLpxWt2dwFxzg98e1Ui1Gt8/VYvnq2wmdCxVu2aB/ZO+HBh+ByR
         8KYxNMOq/CtLTfBqbmAUhqgiJaEVxbOHmHkq9nq4YRY0YZ5aDzFrOhJ7DRlOHi1nPsHD
         VwfXvDkRdF3fWoFiAQx+WFZpFplADQZnQXxfP55pGGtoIG1XRLr+XnoP2mX9RVhR31Lq
         Bzz2j1PQJln79lxuHUCYadJ5dBHsB4CiuziKNg/sjAH6CRf+GHVurz+JzEqt9viIwqsm
         ODoCnaB0BN5Rv2oQhCwnr+hsFjMAjfvoOBLSi97mHBak++hQLbJEluAyoh2nsCvy0RP/
         Ue6A==
X-Gm-Message-State: AOAM530Y/VuxA1PgMFQiuw/CH5WPVDHXe+YFmgqKkll2K3kVvrOBpHi1
        tEQTYYudYagxanxEJHmig0w5qJDxNoNcmMaqznWssw==
X-Google-Smtp-Source: ABdhPJxQ2cgTJae7kgiyUkeyJI57pYDeXpLqxHnVy712muMu1WjRdTNkJqGl6VTaB0njyjc21Ubww8pqNhE5xQsiykc=
X-Received: by 2002:a81:5549:0:b0:2dc:2826:e6ee with SMTP id
 j70-20020a815549000000b002dc2826e6eemr11829422ywb.327.1646417721537; Fri, 04
 Mar 2022 10:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20220303031505.28495-1-dtcccc@linux.alibaba.com>
 <CAG_fn=Wd5GMFojbvdZkysBQ5Auy5YYRdmZfjSVMq8gpDMRZ_3w@mail.gmail.com>
 <CANpmjNPBYgNMzQDKjNYFTkKnWwMe29gpXd2b9icFSnAwstW-jQ@mail.gmail.com> <7c14bb40-1e7b-9819-1634-e9e9051726fa@linux.alibaba.com>
In-Reply-To: <7c14bb40-1e7b-9819-1634-e9e9051726fa@linux.alibaba.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 4 Mar 2022 19:14:45 +0100
Message-ID: <CANpmjNN5RN_BtOeJx12iEWs5tZvk7yHQR39Ms3JQC+nzEA-7gg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Alloc kfence_pool after system startup
To:     Tianchen Ding <dtcccc@linux.alibaba.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 03:25, Tianchen Ding <dtcccc@linux.alibaba.com> wrote=
:
>
> On 2022/3/3 17:30, Marco Elver wrote:
>
> Thanks for your replies.
> I do see setting a large sample_interval means almost disabling KFENCE.
> In fact, my point is to provide a more =E2=80=9Cflexible=E2=80=9D way. Si=
nce some Ops
> may be glad to use something like on/off switch than 10000ms interval. :-=
)

Have you already successfully caught bugs by turning KFENCE on _in
reaction_ to some suspected issues? We really do not think that
switching on KFENCE _after_ having observed a bug, especially on a
completely different machine, is at all reliable.

While your patches are appreciated, I think your usecase doesn't make
sense to us (based on our experience). I think this flexibility is
nice-to-have, so I think the justification just needs changing, to
avoid misleading other folks. Please see comments on the other
patches.

Thanks,
-- Marco
