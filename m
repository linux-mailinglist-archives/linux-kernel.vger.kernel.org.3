Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA30B550738
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiFRWCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 18:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiFRWCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 18:02:35 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBDC12626
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:02:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l4so6964576pgh.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnu4b3CF1nM6tAT3DrHQF/VxxJxGGRTRzb4IiQ47yXE=;
        b=NIDF2nVHmymvuH5AbZvqRSDSLOcMl4QowgO/aVmuWc6pXPVkmtyTv8IIVURSZqk2Ig
         qfa0CuIi0+Cqo6AUwirCmMnk595ie5X9R64nFec1KSlVr0GV9rRCqD6seE2MZkzYWejO
         wcmOEbtdh/Ditsh516gxodZkO/YwiE+CYXQihLvAABrabkL0bAEjmQFz6bMwanwxA5cL
         gLTODjhHXfJQWXDlZM/yCfYt4AIysCXn3h5mvbg1zcUVJPeMC33BALUR2ZizE7gNGyul
         5tN+oIA4bvtD/RrFX9Ps6MXSKdnXlcAw9d0TfC3TaspyiIB1WGRu9jnoIqMo6ZkINIhe
         F7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnu4b3CF1nM6tAT3DrHQF/VxxJxGGRTRzb4IiQ47yXE=;
        b=uYlIcjhfhLFxApFdTgOLGHyTbSUGBfUrKMVlE4pvVBChKRTdvaftEHb7YEuH+V5hmL
         VA1PSjpxEdDAxVbMDOdEFJRCUwDE692VGFw/YLVIYYE1LAo0e3Pcmb8C1rhYmqvlMl13
         dp3x2hCHv5uOVnfiHZEu+GdjhxxE+XPdGjIJymVDa6BWF6TfqaayLlnVu+iNZkegOUPt
         WQ6EpDCTKXm0bRQauQ9suvaVMtM/uzUBYaCrnCrKgejrmaJ0o+UR5yVA6HSOZ2Hi6waK
         vpd239WVfvdh1hdJV/HKF2erjhOzNwG43LsZ88IQUj3Mbl+CQSB4gCYkZYIT8fpZxBTc
         +nWA==
X-Gm-Message-State: AJIora+3rPkqlRudkaJfmIedrSHfAj6OYdNA0yA8SkqIv7HgNwpeHJzG
        4TNhQHyjAWRzwW+r8b62a0GTQpOwJ2MDK6toTcg=
X-Google-Smtp-Source: AGRyM1teNFNnBa0qxxBVj0fmrIcaFKogHQEbvhZY14rwR5kaaA6hsRTAronPebbeTP+T/JB+jzJWP4fIfZzvlO/TYIU=
X-Received: by 2002:a05:6a00:170c:b0:51b:f057:85c2 with SMTP id
 h12-20020a056a00170c00b0051bf05785c2mr16785125pfc.18.1655589753826; Sat, 18
 Jun 2022 15:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220617124432.4049006-1-windhl@126.com>
In-Reply-To: <20220617124432.4049006-1-windhl@126.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 18 Jun 2022 15:02:25 -0700
Message-ID: <CAMo8BfJ9N1JayakwAUxBQ5EyJ7PmoDKv=39D1pyxsaTroEpksQ@mail.gmail.com>
Subject: Re: [PATCH] xtensa: kernel: Fix refcount leak bug in time.c
To:     Liang He <windhl@126.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 5:44 AM Liang He <windhl@126.com> wrote:
>
> In calibrate_ccount(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when
> it is not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  arch/xtensa/kernel/time.c | 1 +
>  1 file changed, 1 insertion(+)

Thanks. Applied to my xtensa tree.

-- Max
