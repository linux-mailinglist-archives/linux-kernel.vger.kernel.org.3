Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AACC4F1E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355423AbiDDWLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383010AbiDDVcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 17:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1C8125C5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649107401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DfDyjcnnLyc2bSZ6jJAVhGllQHcKHgp84LgGIl4EXgM=;
        b=O/xKp+aaN01eINcwTDKyUl7NxBl5p8xF0gD53R5bsy6IveDGmG5wJhuJ1FY8pX4TQNnSEF
        BY09Z92CyZkTnant4pRtPKTIUgibfxGkyCJmn0gXOYOxJiI5fG7nh7tryVBjjLADr6vDDe
        zS0WUN6tlzAVqVXbH0JbuJGTUYEs2KE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-XgC7n7FANbSBzhYDzNhhrg-1; Mon, 04 Apr 2022 17:23:20 -0400
X-MC-Unique: XgC7n7FANbSBzhYDzNhhrg-1
Received: by mail-qv1-f72.google.com with SMTP id ke13-20020a056214300d00b00443901b0386so8912364qvb.14
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=DfDyjcnnLyc2bSZ6jJAVhGllQHcKHgp84LgGIl4EXgM=;
        b=SPGxmuT8uTmfTYtt/hf3O05wPTzleezG5xeXXVTeqOxZn2OotkH8PhIBR/HbgdIYJ0
         UUAP8SQH11JW0jjzFkB9unnN767fH+RjvlXAKomQu2AF9PPIrly9f8xxRAruyRo3neH0
         9LQqrX1P7l4QHNt0/974PZgxLCXlNnD/aKkTnVzQkERlXucXQ7jOq2whRzH5LRmldbqQ
         fuJokKXhNQnIQRsDX/yTNHFbtrIN+z8nAeiM3eA1BsRYRjqEJWTwd9a7EJOm5mFCAvMt
         nmlI6BfPuS5DmU4b2JWy3CpUmDjpLo1M+W/rGd6I2Js2pZdTDi3rA9Z1klTd1IN2Wh0O
         4uIw==
X-Gm-Message-State: AOAM533z+JhDEBcKlYWtm4W0p+vyf8qfvOYOSmq4shy98RJH0gWO2jGO
        3E7bZLMw8VtlHIaM5Y/Z5qfwHulwVXeYeRdYruqfWtICkZz2yF9dUM/jEGYOKIVy1iREsDkCMbd
        aRLy8kWfhk6zcztX9vqzfPOba
X-Received: by 2002:a05:620a:2487:b0:67b:3113:f83f with SMTP id i7-20020a05620a248700b0067b3113f83fmr179301qkn.604.1649107399545;
        Mon, 04 Apr 2022 14:23:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA/j5T9RBShOaLAqidOK7ozpdzXqamqb+Gc1f+d2xjbvub/SnKUIk0rJFYk2A/f+j9+SQqNg==
X-Received: by 2002:a05:620a:2487:b0:67b:3113:f83f with SMTP id i7-20020a05620a248700b0067b3113f83fmr179283qkn.604.1649107399340;
        Mon, 04 Apr 2022 14:23:19 -0700 (PDT)
Received: from [192.168.8.138] (pool-71-126-244-162.bstnma.fios.verizon.net. [71.126.244.162])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b002e02be9c0easm8354800qts.69.2022.04.04.14.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:23:18 -0700 (PDT)
Message-ID: <74509d19d84b879b624fa9f40bc8186fd09e750a.camel@redhat.com>
Subject: Re: [PATCH] clk: base: fix an incorrect NULL check on list iterator
From:   Lyude Paul <lyude@redhat.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, bskeggs@redhat.com,
        kherbst@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     martin.peres@free.fr, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Mon, 04 Apr 2022 17:23:17 -0400
In-Reply-To: <20220327075824.11806-1-xiam0nd.tong@gmail.com>
References: <20220327075824.11806-1-xiam0nd.tong@gmail.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.DarkModeFix.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should probably be prefixed with the title "drm/nouveau/clk:", but I can
fix that before pushing it.

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push it to the appropriate repository shortly


On Sun, 2022-03-27 at 15:58 +0800, Xiaomeng Tong wrote:
> The bug is here:
>         if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
>                 return cstate;
> 
> The list iterator value 'cstate' will *always* be set and non-NULL
> by list_for_each_entry_from_reverse(), so it is incorrect to assume
> that the iterator value will be unchanged if the list is empty or no
> element is found (In fact, it will be a bogus pointer to an invalid
> structure object containing the HEAD). Also it missed a NULL check
> at callsite and may lead to invalid memory access after that.
> 
> To fix this bug, just return 'encoder' when found, otherwise return
> NULL. And add the NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1f7f3d91ad38a ("drm/nouveau/clk: Respect voltage limits in
> nvkm_cstate_prog")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index 57199be082fd..c2b5cc5f97ed 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -135,10 +135,10 @@ nvkm_cstate_find_best(struct nvkm_clk *clk, struct
> nvkm_pstate *pstate,
>  
>         list_for_each_entry_from_reverse(cstate, &pstate->list, head) {
>                 if (nvkm_cstate_valid(clk, cstate, max_volt, clk->temp))
> -                       break;
> +                       return cstate;
>         }
>  
> -       return cstate;
> +       return NULL;
>  }
>  
>  static struct nvkm_cstate *
> @@ -169,6 +169,8 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct
> nvkm_pstate *pstate, int cstatei)
>         if (!list_empty(&pstate->list)) {
>                 cstate = nvkm_cstate_get(clk, pstate, cstatei);
>                 cstate = nvkm_cstate_find_best(clk, pstate, cstate);
> +               if (!cstate)
> +                       return -EINVAL;
>         } else {
>                 cstate = &pstate->base;
>         }

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

