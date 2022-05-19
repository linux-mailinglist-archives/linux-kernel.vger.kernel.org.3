Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE952CB8E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 07:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiESFnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 01:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiESFnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 01:43:18 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB4A5000
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:43:17 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c2so3857583plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 22:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6z/Bc5UCAfAeTzRfuIMJWHJqH0NGV84MAGaXVzlC2gw=;
        b=iYklmhIxxcBAg2/vfEqx7EfCepTuDYi24pzQZ93iZPutwkc+6GNmiuWkRp4WSUW1ya
         f/jfz/Se1RPPSr78BVC2yxVHvo+u/ri3lBc67M9oXg9qkAJOo7O5E//zEJ2LbV1GkhZs
         CbBSsrRrh99IMN8FJB7Y+n1CoWRLQKbzzKDYetu4vJPPbfVNPn5PDJhiCjqFBIcV+jbY
         yjHTuITb9PGP6NBOf1aoOOfBWmJPl0/Ic4kCxNcIPALoEg9CwyWzGXEXerzi5uPx7nhX
         745qUbJI7IX6gxT3jJCXA77uajMX2tNeZM9/dGV9iA0ED0FTiHB3VKCFrrPZAFz/qG4V
         mtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6z/Bc5UCAfAeTzRfuIMJWHJqH0NGV84MAGaXVzlC2gw=;
        b=psTSOLG4vL9Ht6IPIRRNk455Qxp7AfccCSHax1WLDGEnceEXf9vX2C1o7TsFJb7UHm
         unwkWJEI6SQ5jhc/lWDGAdl6SFzHoR/qjTvFzXGfi/SgDRvASHKtBBr1BcoCB/+Bq8oL
         rFnO3axV1yqPTOwIRUj+2zkdetlczH0v7ryRqjxZsTLgmk4+PEBamLP6PYpIXrTsclkW
         krhplriCaN39zAZCqDeNexuF2/LNsUw0ZmuGG5pkiULUBFucb1FwDhUAs+xDnDlv6exZ
         cDgypA/ocIJYniepabPc240YzLRrrPEGjp6+f0WdotiPlJtG8eDGdXMiTGuFiztOtfKi
         bfjA==
X-Gm-Message-State: AOAM5334zIBTgdFxRhppk5qbc+COa8qAuxmt37sWUqDkmuSjrSVbvJDS
        ZM6s2ox2fxZNKwUo1dBzgJmz2snqEk2XTXq2a2hB3g==
X-Google-Smtp-Source: ABdhPJwVrFgLJ/iOPmvarT2Xzx/jUomRSAH5rMsUBTKCfWAyxNrNKIq+GvtzXJtlJ8wYWG2H/jQ8POCBdgYFz8vIuXI=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr3193505plr.6.1652938996847; Wed, 18 May
 2022 22:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220517164713.4610-1-kristen@linux.intel.com> <9c269c70-35fe-a1a4-34c9-b1e62ab3bb3b@intel.com>
In-Reply-To: <9c269c70-35fe-a1a4-34c9-b1e62ab3bb3b@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 May 2022 22:43:05 -0700
Message-ID: <CALvZod40TpW0rX1jvj6GZWtr=nscJFkw_zdvZjbh7GPgd8pLWQ@mail.gmail.com>
Subject: Re: [PATCH] x86/sgx: Set active memcg prior to shmem allocation
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     linux-sgx@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Fixing the CC list and sending again)

On Tue, May 17, 2022 at 09:47:13AM -0700, Kristen Carlson Accardi wrote:
>
[...]
> +int sgx_encl_alloc_backing(struct sgx_encl *encl, unsigned long page_index,
> +                        struct sgx_backing *backing)
> +{
> +     struct mem_cgroup *old_memcg;
> +     int ret;
> +
> +     old_memcg = sgx_encl_set_active_memcg(encl);

This function is leaking memcg reference. Please change
sgx_encl_set_active_memcg() to sgx_encl_get_mem_cgroup() or something
which will return the memcg with the refcount elevated. Then use
set_active_memcg(returned_memcg) here.

> +
> +     ret = sgx_encl_get_backing(encl, page_index, backing);
> +
> +     set_active_memcg(old_memcg);

mem_cgroup_put(returned_memcg) here.

> +
> +     return ret;
> +}
