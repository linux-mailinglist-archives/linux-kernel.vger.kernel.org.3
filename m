Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E09C59C2BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbiHVP1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236407AbiHVP0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:26:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6A3ECC0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:24:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id vw19so8261468ejb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+T86Wl72f+FeWeRtOGkVlmWRkAxRXlHA5m5R3vqpGWs=;
        b=Ol0z0PkAjZXBna32Isqt8G4NNZVcvypCiD7npmdqQUrUng9iYrmXQC6mZ9uyeKe+HU
         cL69L/rzWsjJlHO2ALmaAx1ltJf+3dbncIBnOawpF4XoHXnqoZeovsw5Xc+gbrZTFEjY
         dCjgW6BBlBQ0ZCL3PY9LQlTsHnuxHWVSPkhNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+T86Wl72f+FeWeRtOGkVlmWRkAxRXlHA5m5R3vqpGWs=;
        b=k6Xn5921p7BRXdzkynhH/OX2HKPF86D7l0l5KmVoQORBKPPXA5Ns/RBDgoIczlVm8c
         xygjL2LiXoh2FoyiphzKZ3cV6qM4BhQMVnynZPYOBfn7npSqpxmLQMxC22lFY4Av+ehx
         N2TSFMmr5OFa6WOSsxNkGLoVowBDEMUrUaIRqqBl88VqcKsBxbF6BvOqpepO70kyryYR
         JVkFSxpxSw5hEhHIu3RX6m5RAlkqkE52pTfPSeufrRb4bRHCI3aN/Smlh2Ha+vFOy55M
         DP6z8Ey4BZiiZGQhgDgf+4/FVCIFODl4XW2qDL4m9vbaxaHdoAlQzHIAXw2lTkU3MFhv
         6gew==
X-Gm-Message-State: ACgBeo3Jk4LV2RO9IfU3HDnCXvBLsLBw5ARuGRu4IJVVCcsI+R+j89lO
        fILLBnLHBaf5viB4LP1C1Dv7q1MamE+2hKKdnqu9BA==
X-Google-Smtp-Source: AA6agR5j8M3rqBkCxM8dnHG6ED3RCNQdniNKcKwM4yLtbj+oQVl6x+Revnno5eoSlvEEgoKpvmg1Nap22zvMyWaen9w=
X-Received: by 2002:a17:906:8a4a:b0:73d:8471:e34b with SMTP id
 gx10-20020a1709068a4a00b0073d8471e34bmr2856240ejc.523.1661181874865; Mon, 22
 Aug 2022 08:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220822115257.7457-1-goriainov@ispras.ru>
In-Reply-To: <20220822115257.7457-1-goriainov@ispras.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 Aug 2022 17:24:24 +0200
Message-ID: <CAJfpeguyD-znkZVwmiYZCK6tMsoJc+UzMKnkWxb7TToT1DFb4Q@mail.gmail.com>
Subject: Re: [PATCH] ovl: Fix potential memory leak
To:     Stanislav Goriainov <goriainov@ispras.ru>
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 at 13:53, Stanislav Goriainov <goriainov@ispras.ru> wrote:
>
> ovl: Fix potential memory leak in ovl_lookup()
>
> If memory for uperredirect was allocated with kstrdup()
> in upperdir != NULL and d.redirect != NULL path,
> it may be lost when upperredirect is reassigned later.

Can't happen because the first assignment of upperredirect will only
happen if upperdentry is non-NULL, while second one will only happen
if upperdentry is NULL.   I understand why static checker fails to see
this: it doesn't know that dentry->d_name will never contain '/'.  In
this case the looped call to ovl_lookup_single() can be ignored and it
is trivial to prove that d.redirect can only be set if *ret is
non-NULL.

Thanks,
Miklos
