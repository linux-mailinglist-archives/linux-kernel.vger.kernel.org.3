Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22CA54BF91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242631AbiFOCHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiFOCHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:07:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE99FFE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:07:26 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x17so13422833wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pka2Wf3vF4GgaDRWibWr079VJVrRTWnpwOYpLbvjDbs=;
        b=I9lCrgw50jYr/zbSokAJMRemwaludazv+GM8VWtF36MwEVXl5X7SPH+6w41n5np1/s
         aLFPX857Tjt538NSgzqurAYE5pBQOByU5FPDFHGWCitBZq1I9lzarzB5Msfg40UDBAi1
         ujwSx+JjugS5Wh6d6j0AqJdOIWiJ4sT9GBVd/XM4ElMWvjKgWiCRoqBFKV9nLJNcawNp
         btWTTK2vhhrnmP880PjIhbX66F6pr14AM55cZtD1eHnDoxTlr9AdT/vtlAmRd5gCsDTd
         4/4oUUMvwfExzdu3ts39FrqR7ahvIvD7XsjGxjBWxynrSEgiNSKjY9hkTHg93uTHqCGf
         auSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pka2Wf3vF4GgaDRWibWr079VJVrRTWnpwOYpLbvjDbs=;
        b=5sl2zZbUg7CVeIfs7Xix5IVuNAXe0NdIhjSJFxQVst5E61iGOx0G2raHBUN9yMoXWr
         BuoZxYu7dK19e9gx0ECw/Phd7/LUxe3pempQHHKGJW5RdO3S6ZVSQb3ThWR3CXXT47Ek
         DUxpIzZz1FqCURp/Wup+gPdJoCw4UUkALKIri8W8zUaZwWz+XlhNsxAOKfCNmig9geW4
         pJRueG955IxKpIS88qMfeCi6Ax1pvg95z667HIZDvMtazJ6knNSjNh9RVUi0vKBTqZQM
         4IsOVEp5jZ+nTz8F7jhMBFKJ8YTAhWOtd5gYwQ0UGaoR92XGq0z7qDq3IPa+AcVIcc5a
         7E/Q==
X-Gm-Message-State: AJIora/754DO1fD+aim7rPOfHro0VhSMZi9trQvsfKN07f5A+NKR6I8I
        6kAwMV2zv1XDXaNphks5i98A5eF7FLkCLw2iEwfq
X-Google-Smtp-Source: AGRyM1u/SjHMDbnC03CAUgMJ1rqh1VaHc6RFE84uufAQpvDP3zd1dOKS/VWzDHy3BOe+tRjYspRfWlm44PW8kCU90kA=
X-Received: by 2002:a05:6000:1448:b0:219:ebf7:79ff with SMTP id
 v8-20020a056000144800b00219ebf779ffmr7723237wrx.70.1655258845363; Tue, 14 Jun
 2022 19:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220614121030.115491-1-xiujianfeng@huawei.com>
In-Reply-To: <20220614121030.115491-1-xiujianfeng@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Jun 2022 22:07:14 -0400
Message-ID: <CAHC9VhR8k-MDnHsMcdYb5SondWGem19CRPx5p23WtkcrHFaBnQ@mail.gmail.com>
Subject: Re: [PATCH -next] lsm_audit: Clean up redundant NULL pointer check
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 8:13 AM Xiu Jianfeng <xiujianfeng@huawei.com> wrote:
>
> The implements of {ip,tcp,udp,dccp,sctp,ipv6}_hdr(skb) guarantee that
> they will never return NULL, and elsewhere user don't do the check
> as well, so remove the check here.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/lsm_audit.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
