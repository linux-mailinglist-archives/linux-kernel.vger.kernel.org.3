Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C1753C006
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239251AbiFBUoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 16:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbiFBUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 16:43:55 -0400
Received: from mail-vs1-xe64.google.com (mail-vs1-xe64.google.com [IPv6:2607:f8b0:4864:20::e64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93146BFE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 13:43:48 -0700 (PDT)
Received: by mail-vs1-xe64.google.com with SMTP id d39so5350230vsv.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 13:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=7Akd9F5RhYTnk2DKxtOSkM0eLGAw4F7uKrkIutX2DK4=;
        b=axPGKXxqPsNTIVE8lxCk3YMfTR4GkiX3P57rT125ZFC4gwnHZu6WSBJmzyINRS51wE
         wAACTsmY3kqus0AfpMGxz070BGLywWXcZsuScuJ0+h/nFb3xuYsW4aZBt719/5yasUja
         Q7B6nNV12op2+LRC7q93HA2vjUxE+YTIxbcxHllbbK4yfceZHGyMNjXR5L36efkD/TME
         fIZ3Z9SauuiG38nc5cni5gL03gi8vMRVdBIKMjk4gMDsr6DPqOZPxVloQ+WPISCTEm6U
         l0gLfspuY5Zv2LOqStAtRf7baREKMR7ZHf8518mDdKyuPSCN1GkMdjCZEF53EoWYiRFd
         iueg==
X-Gm-Message-State: AOAM531qXyOZ4UCwxzzlgW8o7+GPBd6jYqR+SWaAteBvnZ6iZ0HGzWJk
        4zkRTtqSeJvuvsJfz9sYm85s1h/Z/WHy5VMmkBnEF/yFLwT7NQ==
X-Google-Smtp-Source: ABdhPJy3IDFwnFyVykhJe/3nVfrbvJGF8lMN4Zlvjs1fxPlkyup88R5LVQ9hO8VaIzO8yn16AJTi2EUcVqOk
X-Received: by 2002:a05:6102:443:b0:335:e54a:8c46 with SMTP id e3-20020a056102044300b00335e54a8c46mr2824538vsq.3.1654202627699;
        Thu, 02 Jun 2022 13:43:47 -0700 (PDT)
Received: from netskope.com ([163.116.131.242])
        by smtp-relay.gmail.com with ESMTPS id az3-20020a056130038300b003693e1aaf96sm782853uab.19.2022.06.02.13.43.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 13:43:47 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-qt1-f197.google.com with SMTP id f40-20020a05622a1a2800b002fcc151deebso4535385qtb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Akd9F5RhYTnk2DKxtOSkM0eLGAw4F7uKrkIutX2DK4=;
        b=d69dWt6HJQoiZC+5MFqWXaicN4JpYi+RWnOOF/pOfRBKwVUmlrSJlrlXBSNIyKNVAi
         z9m12QvfNIs49nr8dth8DdwQsDsdPaes77zgEtQmm12frTzYYvX/FiH+h/o09yPWCgaK
         tDxxQep7h5p0hfLK/lADwNSh/rNY9WFDu6JIM=
X-Received: by 2002:a05:622a:102:b0:304:b7b8:45b3 with SMTP id u2-20020a05622a010200b00304b7b845b3mr5046501qtw.369.1654202625651;
        Thu, 02 Jun 2022 13:43:45 -0700 (PDT)
X-Received: by 2002:a05:622a:102:b0:304:b7b8:45b3 with SMTP id
 u2-20020a05622a010200b00304b7b845b3mr5046491qtw.369.1654202625418; Thu, 02
 Jun 2022 13:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220602173657.36252-1-varshini.elangovan@gmail.com>
In-Reply-To: <20220602173657.36252-1-varshini.elangovan@gmail.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 2 Jun 2022 13:43:34 -0700
Message-ID: <CAC1LvL1=Vf7khHRR+WHNmv1Ose=RnXbXQ6gJtfPDpz8ztia-JQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Add queue_index to xdp_rxq_info
To:     Varshini Elangovan <varshini.elangovan@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 2, 2022 at 10:37 AM Varshini Elangovan
<varshini.elangovan@gmail.com> wrote:
>
> Queue_index from the xdp_rxq_info is populated in cpumap file.
> Using the NR_CPUS, results in patch check warning, as recommended,
> using the num_possible_cpus() instead of NR_CPUS
>
> Signed-off-by: Varshini Elangovan <varshini.elangovan@gmail.com>
> ---
> kernel/bpf/cpumap.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 650e5d21f90d..756fd81f474c 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -102,8 +102,8 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
>
> bpf_map_init_from_attr(&cmap->map, attr);
>
> - /* Pre-limit array size based on NR_CPUS, not final CPU check */
> - if (cmap->map.max_entries > NR_CPUS) {
> + /* Pre-limit array size based on num_possible_cpus, not final CPU check */
> + if (cmap->map.max_entries > num_possible_cpus()) {
> err = -E2BIG;
> goto free_cmap;
> }
> @@ -227,7 +227,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>
> rxq.dev = xdpf->dev_rx;
> rxq.mem = xdpf->mem;
> - /* TODO: report queue_index to xdp_rxq_info */
> + rxq.queue_index = ++i;

I don't think this is correct. i is the frame index, not the queue index. There
is (as far as I can tell) no correlation between the two.

Additionally, i is the loop variable, and the ++ operator will change its
value, causing frames to be skipped.

>
> xdp_convert_frame_to_buff(xdpf, &xdp);

>
> --
> 2.25.1
>
