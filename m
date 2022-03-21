Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19934E21ED
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244730AbiCUISl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345524AbiCUISc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:18:32 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15C4FC43
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:17:08 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by gnuweeb.org (Postfix) with ESMTPSA id 6B53E7E2DA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647850627;
        bh=aRuKNv6OImAv6rU0npvnV+udgUusMFxeqroXXsjRtvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ktj7zhbZv2g1vsGMBDNOdMYLaOD1Vd3XL801A+afLd/uXm/2xBBn1csbfbW3c2f/E
         gkdITSA4cdsjUs14QVvZRQT+Dpp11+jGCK8LSeyoRBlOCrZDN4P8bl5q06gtkjbtkT
         Z58gVIsr+byZ4V6YOhDMjbKd0RhFTPbZsLc85q2mNU2J4rojy4f6iucZVbxPICV+xX
         fX2h5wnCSGw/khdp092Sey0NxyjnQZpbnn1iYn6fem/bAxhmFTwviAEfJSC9ESCbUG
         OM7q77ln8TbowaYDR2mPE2WAyfds31/lKEN9IfNofki6tyvlj+TwH2dKSrsUu37IxL
         Id/rsBCOkBceA==
Received: by mail-lj1-f171.google.com with SMTP id s25so18739411lji.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:17:07 -0700 (PDT)
X-Gm-Message-State: AOAM533tL4DKazY4cqdhK2PIb7KzHnCcvsKM5xcHRq9zeJU3psAiI1T0
        Qr0l40kjy5uXRPbnIxRRdUMPiIc7p1Cn1yuszXI=
X-Google-Smtp-Source: ABdhPJw8JJLln1bH9vT0H8vH/0meIvWmGJy1t2F2kpKKJa9tzHDAbYlqgKYMoh3cJZKrOldl2Y0UGoeeks4nlypoNrY=
X-Received: by 2002:a2e:3013:0:b0:247:ea0d:11e2 with SMTP id
 w19-20020a2e3013000000b00247ea0d11e2mr14639310ljw.2.1647850625490; Mon, 21
 Mar 2022 01:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
 <20220320093750.159991-7-ammarfaizi2@gnuweeb.org> <20220321075308.GD29580@1wt.eu>
In-Reply-To: <20220321075308.GD29580@1wt.eu>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Mon, 21 Mar 2022 15:16:54 +0700
X-Gmail-Original-Message-ID: <CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com>
Message-ID: <CAOG64qMpEMh+EkOfjNdAoueC+uQyT2Uv3689_sOr37-JxdJf4g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()` and `strndup()`
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 2:53 PM Willy Tarreau wrote:
> Here it can cost quite a lot for large values of maxlen. Please just use
> a variant of the proposal above like this one:
>
>         size_t len;
>         char *ret;
>
>         len = strlen(str);
>         if (len > maxlen)
>                 len = maxlen;
>         ret = malloc(len + 1);
>         if (ret)
>                 memcpy(ret, str, len);
>         return ret;

Maybe better to use strnlen(), see the detail at man 3 strnlen.

  size_t strnlen(const char *s, size_t maxlen);

The strnlen() function returns the number of bytes in the string
pointed to by s, excluding the terminating null byte ('\0'), but at
most maxlen. In doing this, strnlen() looks only at the first maxlen
characters in the string pointed to by s and never beyond s[maxlen-1].

Should be trivial to add strnlen() with a separate patch before this patch.

So it can be:

    size_t len;
    char *ret;

    len = strnlen(str, maxlen);
    ret = malloc(len + 1);
    if (__builtin_expect(ret != NULL, 1)) {
        memcpy(ret, str, len);
        ret[len] = '\0';
    }
    return ret;

Thoughts?

-- Viro
