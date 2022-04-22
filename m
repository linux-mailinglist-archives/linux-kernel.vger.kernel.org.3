Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B01750C19B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiDVVzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiDVVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:55:39 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE80C3FF3FD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:15 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id s27so42857vsr.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zgxP3Y3a99Tnmri+jyb9sL4QOG+vYvVcmyAwcXdnRGY=;
        b=fxt+XfICNoW4Ai+vNBE7lxyV3DSyUv32OUMieEmeLit/VJrX/ghs9XewgnWVp/3dsK
         mU4wCC8/p93DzvqSGJF0O4CpcQD0uguHuGWV7k9wvf1kvDxSDpTPyXfbFv1LmHgbXatA
         vjfxW81pX69la7kbWCM4eg3A9dVcCc3sn//lV/uhwZ8dSEVMXXIHQOjeLkBO2z3NQJBs
         fXhZAXbXX7lnNU2wG3mzwkeU7Tv6ggSGFatKDlbuR45yXST/fzWKfO+SEopbxgIPoATZ
         dqZpL5og2hm0y6bcrOaMbvCo85OEUoeEmv4EqMjuP8lEQC17YIWyEpqlw2IuBUnv36nI
         cAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgxP3Y3a99Tnmri+jyb9sL4QOG+vYvVcmyAwcXdnRGY=;
        b=WMM8hDnTzC1orR4+/SKFKGvxs300o9qdQ5JNrOyTi/oh4IV3l1V/jGtyNtMhR5aZWz
         Vif6e0Q/WlMGqahhG0/m3EreJ/Lm9q5RybMOZxb45K1/Quc/R35vm3nSV6JFdp57Hy6x
         4qcCd//uKq3OVL4nBYozoaTA9VZyuTOTvGHOTrsHKb8RgbN0tBlgU62i9LRbCHV2G0uK
         91J4aL1m41it3I288kwT5xt7ULTCnuKfCE13fv34uwvwMvNiILPlpSrX+Sn4q/iUr3GS
         8DVywfTrUNVKH5DUgXv19tq5LsdYT8d0WH21K2wETO9yqdgmFblliTXFAKNB0K0Y1dtc
         t01g==
X-Gm-Message-State: AOAM532RCThmjIK2AWTjVtQo/pdpW6radzxIKesIv26ErqWN0jG3UaFD
        pUymfA0JOyh08kllOiuioicUnJzmJ/H1smFvBUjFaA==
X-Google-Smtp-Source: ABdhPJxVFZxS2z4mhjODNSUBGfoul3uUe+CTf4GBu7DjSwd2RQ4DhWtDa1dfiBlSye9HuxVs7NlA+tWpgXqNMnf7QIw=
X-Received: by 2002:a67:fd0b:0:b0:31b:e36d:31b1 with SMTP id
 f11-20020a67fd0b000000b0031be36d31b1mr2255337vsr.44.1650659682441; Fri, 22
 Apr 2022 13:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220422195516.10769-1-jvgediya@linux.ibm.com> <20220422195516.10769-5-jvgediya@linux.ibm.com>
In-Reply-To: <20220422195516.10769-5-jvgediya@linux.ibm.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 22 Apr 2022 13:34:31 -0700
Message-ID: <CAAPL-u83O5W8B-G9xqZFWGuJNNc5nNkQ6iTVtJ-Gn01o4uFoPA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] device-dax/kmem: Set node state as N_DEMOTION_TARGETS
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        gthelen@google.com, dan.j.williams@intel.com
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

On Fri, Apr 22, 2022 at 12:55 PM Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
>
> Set dax-device node as N_DEMOTION_TARGETS so that it
> can be used as demotion target.
>
> In future, support should be added to distinguish the
> dax-devices which are not preferred as demotion target
> e.g. HBM, for such devices, node shouldn't be set to
> N_DEMOTION_TARGETS.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> ---

Acked-by: Wei Xu <weixugc@google.com>

>  drivers/dax/kmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index a37622060fff..f42ab9d04bdf 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -147,6 +147,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>
>         dev_set_drvdata(dev, data);
>
> +       node_set_state(numa_node, N_DEMOTION_TARGETS);
> +
>         return 0;
>
>  err_request_mem:
> --
> 2.35.1
>
