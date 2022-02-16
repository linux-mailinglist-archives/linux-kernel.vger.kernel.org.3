Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638834B8BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiBPOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:44:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiBPOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:43:59 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA38299247
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:43:46 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id l125so6531475ybl.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgrnaYKHskOlXJs/1klYY5AbJsq/3JrBvm/3jFaFCcI=;
        b=zHD4zlkqyouSou6Frxj+FBDEsmWPYp7dykicxCGusjzr0izk+5VCtn3WzEL7h3qAOJ
         cg1IBDSBhacvZmV2z0LdZ+PIvCn3IgF3pnk952jqa4gkIgDUzqTcnFdB/Xxv90wbopxH
         086lQq/DYuPkPF8KZORgOBhqi3iiH63VyWkXId716J5NJ4qzwA0xIWxjBL3VTl9gXbq3
         pL0LIFwYGfc2SKKcyRLFQNPXBk/62oI5rUl59IVNPEJLSecVgT81XCwQ6TDHU54kxsel
         iNXB9bqO702vkMOR0PldkEWvq2ABFqHy/RY55vMxLHXZdl6r7dhqNN2CNNINTCW4z/GE
         LEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgrnaYKHskOlXJs/1klYY5AbJsq/3JrBvm/3jFaFCcI=;
        b=uObZzp2KE2rQLVMtOK6tpbLIkLmlDAH8ehdefsy8h+gU2+XcajO4ZKOAhBXEmpslF9
         O+IpKEsfMk8gs11PIlcPGMNsvC517lU8VkGQI398w1nNdd2AryRTl+rJ8r9TYZZLShBc
         qMxB6C2K+1pCMU3wASodlsiiWxiqQHHSpI2jqHHZIiIYNxbvblCvXZ20orboUycMUWuj
         tgI6Ap26Zg0mpri1+QX/Sqn8PfqAMQRA9/oov50pbl/IOXR/Eczblgdglc0pI2qBM+90
         ADZti2SMMWK9DyU2mZ53X547HMqOCjfby10smfraeFPIpS/+DhBoHcDVk5P1KFviFnbw
         /20g==
X-Gm-Message-State: AOAM531Zn0oko5iAMcAw9BAR6HoIoK0MRH/G2uw02IwTxmaVHxBIQn/5
        Mql+T+Z+GxSk3jRoAfhczHeMHWp3B75MYfXryvvkFA==
X-Google-Smtp-Source: ABdhPJyLBkCsPf7RFdo7D+XfddRJsDaMRww/Kk9oVtiyazBgm6jBFbhC7N/2b+M538IJBrnMw29XJzhExOxOR6khim0=
X-Received: by 2002:a0d:dd8c:0:b0:2d0:c11f:6b0c with SMTP id
 g134-20020a0ddd8c000000b002d0c11f6b0cmr2551796ywe.385.1645022625857; Wed, 16
 Feb 2022 06:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20220203082546.3099-1-15330273260@189.cn> <20220203082546.3099-2-15330273260@189.cn>
 <20220203085851.yqstkfgt4dz7rcnw@houat> <f5381561-25da-61e3-5025-fa6dd61dd730@189.cn>
 <20220209084331.fpq5ng3yuqxmby4q@houat> <def50622-fe08-01f7-83bd-e6e0bc39fe1b@189.cn>
 <CAPj87rOgk8A8s6MTqxcTO5EkS=ABpHQV3sHsAp7Yn2t3-N_SoQ@mail.gmail.com> <adec818a-5c66-3b4a-6f27-bcb29b6c67d1@189.cn>
In-Reply-To: <adec818a-5c66-3b4a-6f27-bcb29b6c67d1@189.cn>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 16 Feb 2022 14:43:34 +0000
Message-ID: <CAPj87rOY0j7p5fduA+p-kT8HP7kc8f4j2Q=FkGutPPPvmV7zqQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] drm/lsdc: add drm driver for loongson display controller
To:     Sui Jingfeng <15330273260@189.cn>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        suijingfeng <suijingfeng@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Roland Scheidegger <sroland@vmware.com>,
        linux-mips@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>
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

On Wed, 16 Feb 2022 at 14:13, Sui Jingfeng <15330273260@189.cn> wrote:
> On 2022/2/16 21:46, Daniel Stone wrote:
> > Other systems have this limitation, and Mesa's 'kmsro' concept makes
> > this work transparently, as long as your driver can export dmabufs
> > when running in 'VRAM' mode.
>
> When using vram helper based driver, the framebuffer  is locate at video
> ram. the backing memory fb is manage by TTM.
>
> while bo of etnaviv is locate at system ram. Currently i can't figure
> out how does the buffer going to be shared.

kmsro will allocate from the KMS device (usually using dumb buffers),
export that BO as a dmabuf, then import into etnaviv. etnaviv already
uses this for imx-drm.

Cheers,
Daniel
