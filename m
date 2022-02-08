Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7734AD2F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349026AbiBHIQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243602AbiBHIQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:16:57 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6CAC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:16:55 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id p5so47504114ybd.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJJ/QmkZmKB9nC5m/e9706XmQamovGaywX2hjcu8BhM=;
        b=j/v+Y0RXSLg3KgaP2obPl90Z4S4zf/lHLTpZA7iKyGWQpWPW9zGbU3phv6GRvIOW84
         uDjp6UOpjBl+R+8y6ZHrWovaw0RVlaJ0hyJuoXQZkt5WKDIGxgrPTSsHg1JFEIGX7w+d
         0yORCZ9C+0OlXQv4bUwDjLkB/fbAV4oZxPWY+2h+49Bqh2D8kk63xXA1vFav6fkTLDoC
         19zBZLOj2y4/BvJNDZXxdV2wxuRHdiySg39QiFh7ThUDNvIltVdy5PpbP5pU7DyjDiOo
         cSrmOnF23Nh0nrrcCmYWYoztyoD7256mEKhu+suzICNsngNAtCpAb3ig43gQs1+O+/28
         JbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJJ/QmkZmKB9nC5m/e9706XmQamovGaywX2hjcu8BhM=;
        b=q5xjp/naPyAWC8lnSzw/kUzHGp2UoV6EgGvmn8ufZ8vO/y/9MORL3ZQ328w43XXGB2
         7hbeHZepAuLdiLMvvoEsA9MFzLXC4qrMBqsxEB/puTnvZuVkB6ukK0698Wk7yvczjZGJ
         +XH+2otbO3JBIX9Qdyhz6+DKEiWroZcPGntoU0EKvcqAlqJ//mTBbfObjnY9COhMocoI
         BeOMAoeVlLK8TrCjruZe0AH5okb0auwhZJHrnIzyhoToji21NldkNn2nvhLjt/mxfAq8
         M3YDUhPSuey8fXYJT+oGhdleKfGmrRSRB6u+kHg7WyblZ8Hb8rupD3b0JpSCPuZpRAIp
         DUCA==
X-Gm-Message-State: AOAM530p3pn/+cQViXQ3fCSKWF4KHH9ptGdmsON3tBo3Oip5JLEPv5uD
        ausvOY27+mQZUe/4ss0wTsRYO4Q0YySga6F7+DuGTg==
X-Google-Smtp-Source: ABdhPJzgemmplhwCixleu/B5oMiQEwCk+7BqdDzS8ESHlx7ec8z9yqAKzUPQDkSmqrpk+ytqyxOH0KgUPllzJyxdaQg=
X-Received: by 2002:a25:e406:: with SMTP id b6mr3429516ybh.703.1644308214394;
 Tue, 08 Feb 2022 00:16:54 -0800 (PST)
MIME-Version: 1.0
References: <5f26643fc70b05f8455b60b99c30c17d635fa640.1644231910.git.christophe.leroy@csgroup.eu>
In-Reply-To: <5f26643fc70b05f8455b60b99c30c17d635fa640.1644231910.git.christophe.leroy@csgroup.eu>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 8 Feb 2022 16:16:17 +0800
Message-ID: <CAMZfGtXU+C1c_eXAf9uTpeOVmgx7RQOL7vV9Wu-BJX0g4c+a+g@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove usercopy_warn()
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Stephen Kitt <steve@sk2.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 7:16 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Users of usercopy_warn() were removed by
> commit 53944f171a89 ("mm: remove HARDENED_USERCOPY_FALLBACK")
>
> Remote it.
>
> Cc: Stephen Kitt <steve@sk2.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
