Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528AD5258C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359649AbiELXxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357857AbiELXxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:53:15 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44871289BD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:53:14 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so8652418fac.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3Mucfvbm1V3fRO+SKrXZyQ232nLZLnjitHwpAR/NYAE=;
        b=knoF6NchK/QDemm3cpAqgru1YYu+JGMGJvh+a+STmaxzwFiGPkJjtdfVuIV1b4nFSi
         1ev6IRB8rk5lo9OVZx/KYM6rmnwhbItGoBy8s4z0530OrYdzWmDOi3FWFuFMmxFuykz7
         m/YkvvDI+jA08LrluR3vUEvS/5K/gBKmRMzwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3Mucfvbm1V3fRO+SKrXZyQ232nLZLnjitHwpAR/NYAE=;
        b=Cg4goayQ16mjO2aOr3cnoyGieVsdreNeNmDwivSbDv3E5FKitOTnQ6zcYDc6cqu8xy
         IG1S0nCDSRXvQb8+X4hzdxoCZVqS31C738S9t2YbhCYmlYLi/Q3tiR/DIz3RGv7KD0a+
         ilvTVWgruXp0uTItzzeMcb6lAKKiHam9UMMYztg/Ule+lrpCPldI0aoC4pOeneCFkAN2
         zVNyCDr3BGRylFDDqXqxE5lyzex4Wro8qnGRfo7ARn5ovq59ZrqKaWpt6S/3eufyFguy
         Pu09tyW0nP7CZlTUKC3zp7O3M+xsZLQqg5+AL1cVH541r0BaTG0RGr9pzolxO92Zx9uv
         fv1Q==
X-Gm-Message-State: AOAM533ssXt8e0ZYL3bTxwMD+fqzvCiFAwgjfcclb6vY9BJgSH6Qhu9/
        QLjA9/Y56f3yNGy1xwmRu/lOFvonecvAlsf4y8kThg==
X-Google-Smtp-Source: ABdhPJzTg8GVf5QngZ6Zz4JABMcWUgh0cOJ/BWALzUdo1IIWvQ7IqsBmZ1A5SSCGK3vFGZxr/06n/9No2ow8oyH1Ka0=
X-Received: by 2002:a05:6870:40c1:b0:ed:9a12:3f95 with SMTP id
 l1-20020a05687040c100b000ed9a123f95mr1216198oal.193.1652399593631; Thu, 12
 May 2022 16:53:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 May 2022 16:53:13 -0700
MIME-Version: 1.0
In-Reply-To: <CAE-0n52ofANUWOY5h=Jjy5SYv=bnxO3xyN4cm3qGVRYmDtkNBQ@mail.gmail.com>
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
 <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com>
 <CAE-0n50Y8tZD9Djn9TVaAiHxehFJ2cZKZ1Z09piDk47uw3nK+Q@mail.gmail.com>
 <Ynzf5jEIECLmELK7@google.com> <CAE-0n50+obQ5qgPNPtUY=OmTgU9bZQ3hNw+MaG9Wi3SQSc-i4A@mail.gmail.com>
 <CAE-0n52WVNru5fnyaB_7wcBOk4twL0Q92YpRbd40-o6ZBmbXWQ@mail.gmail.com>
 <Yn2YvIFNhaz5GmfI@google.com> <CAE-0n52ofANUWOY5h=Jjy5SYv=bnxO3xyN4cm3qGVRYmDtkNBQ@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 12 May 2022 16:53:13 -0700
Message-ID: <CAE-0n53VqYBP1Pq14ju5GWZ6VcKNS-DwLnM-1J_4Z3HExpMU1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-05-12 16:46:22)
>
> I think I covered that in v3 of this series[1].

Even better, see v4

https://lore.kernel.org/all/20220503204212.3907925-1-swboyd@chromium.org/
