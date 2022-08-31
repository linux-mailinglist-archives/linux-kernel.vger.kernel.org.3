Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04965A72D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 02:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiHaAlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 20:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHaAky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:40:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D456AB431
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:39:30 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3413ad0640dso138483697b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N8Oxj5DujnXo7rvapZytc+LXQgd6/nViospKaNQPbC0=;
        b=dprPJsEs0nyRfX2TmM30zqXiIt1fakuHFmqZqLq6mobPb38GIthrMFg0P+1zdnlcWB
         z8RzGHgnfVyyWttJ9IV81fHda39EWxlKO+LZF7EjQKkg8i5VWWzZO15QJoeQIJZbYu4O
         gU0/F0JxaUZCfyMRH9EHWizrP4cf7KRFrWjaKLMECmSWQ433MCAisf71Ng2mcKcDbnOQ
         TTdKVasnrJOHmjqfULXJZwONo7O4Yak84eHQMdq6GvwhL3kFf7fKIhUtiYs4zPtVrk3c
         wy+EocniYedH74c5MRfbU+CfDUp0mrcUlm38y/k5IlYKupG4h3hDsLbFSZ6X12mDqs6U
         MUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N8Oxj5DujnXo7rvapZytc+LXQgd6/nViospKaNQPbC0=;
        b=JyTu/bgltk2qlPCOVuYUnnikFbTT58DMIxVviQarplA9F6fSCrackyrDtS+GrerbzC
         auPw1qqH/H0jfqfr2QRvGnA1ElibwwxJq3WVgD7lqflQs256MQp5vV7Z1K/YZvTWZjZ9
         d4QJ2rKxWv5DzwFKYgDdXp6PwDlIBbIFT5zCftUzDaYtcOZb6MSMZAfC0gFbPxtuaVdV
         yQ6axPJBYFELFac+BxyLRkG6MWQY4rSVQRCDkY9SXeSxKwHOx73kJ0WwmGotbFGYYKAD
         MV6wCVjBtNg3+oYYpNvH6lI66cy0OBubv63h7fHFHY4660pbpGWeg8hWDIZleADk3KsC
         ex4w==
X-Gm-Message-State: ACgBeo1bjjKErHKkIy72hzN2d2C3qrfl4188wZK0Jx7jtMzRUJnb9FeA
        mlNKA2MJSeVv5pOEk+r9PI50iRC/ykTpXrR8coxqlRkFFWTqkQ==
X-Google-Smtp-Source: AA6agR58rUt9NhpoySWQE301RGdtiuQIU0akoy1NmgAsJLQHKYYXLilzuSVHfq2bDR4T5R2ZYp/DUqimzetQhGtV5I8=
X-Received: by 2002:a0d:d756:0:b0:33d:cbf9:3faf with SMTP id
 z83-20020a0dd756000000b0033dcbf93fafmr15867325ywd.224.1661906295777; Tue, 30
 Aug 2022 17:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
In-Reply-To: <Yw49m7Hpq+NIZYWw@arm.com>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Wed, 31 Aug 2022 09:38:02 +0900
Message-ID: <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for crashkres_low.
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Baoquan He <bhe@redhat.com>, will@kernel.org,
        nramas@linux.microsoft.com, thunder.leizhen@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Does this need a Fixes tag and cc stable?
>
> --
> Catalin

IMHO, it seems good to add two tags like:
   Fixes: 3751e728cef29 ("arm64: kexec_file: add crash dump support")
   Cc: stable@vger.kernel.org

BTW, To add above two tags, should I resend the patch again with
former tags (Acked-by & Reviewed-by)?


Thanks.

-- 
Best regards,
Levi
