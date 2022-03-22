Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA234E4648
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiCVSwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiCVSwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:52:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CDA85955;
        Tue, 22 Mar 2022 11:51:08 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h63so21264192iof.12;
        Tue, 22 Mar 2022 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlocYw11wEUDko7lW9ol2D7OrBgmFM7X8i5I28iZY0E=;
        b=AIy1pqIIOA1UydRLjpLRiADUTnZjQkIrGps0EE6mU0UkW1kamh/5BOOcPm57TRUD7g
         JDv3yXGIMeTKswXof021i3kfYWLO4Atx/2ie/9SrB+cecQS3bg1RDmiVUPGd/VBZ/bxP
         fAv53g47dhg51+lyt+156sQtTDMVBdFLYqEiONawCMyV1Iqr1IKDQOwuh2mGpj94dZhD
         KYM1p4RogciLNd1NJTpUyX885Bs7qXlE84rP+FSBk9aFHcu8AyQ9Stp0j8utczFCgmVY
         KPfJjJj+M+556NhhOZB9BaX5SQIVWKkjpeP9J1qrdS96yZi5xghj7llKYgpkJqUaJ9Ow
         l6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlocYw11wEUDko7lW9ol2D7OrBgmFM7X8i5I28iZY0E=;
        b=pXuovlPHZMnpxxr/HQ3XkoLKLXrRX2Ijq/zxf8KD3ItucQSj5BpxAVRbQl9vJWNHEY
         oENKSWgjQGM6o2X9t1RgwoxaHD7xhox6rTMgvvkAYCAAg1LKXXd7HIL2fq/WxM6ajerH
         PnK6/h/OzSEUzBhBLs6PRDQw52EtNAlaMhOj7aTLpNiactgGlJcj8dd0YrIEwr8khJoJ
         zJ/jLuhPTjtz1shQQDzdf6k0Rj33qUtN+rYMk8wq7+g9Cpsexqw4DApe6dsSgCohB5O0
         tCcSjExeSaDfdxLpSjR1XQVFzpVoa92UNJtUnF6TJwVYcTm5uqGwUU2AIk9anipWy+8m
         3WCg==
X-Gm-Message-State: AOAM532rqKv7MXwndlRq4KevauTSJ3VWzTb2olsmlP+bN4LGeJPa3QvL
        iLe62zoXh5AEvT5J8B7VkNSqo3olq62Tef02frU=
X-Google-Smtp-Source: ABdhPJxfIVBQEfl46oCTC0NI/KkCvg1dn0UULUbfHVpnmndy0pkQgmjRlUoGe5oEFqOCLH0o/lsFqYwWeDJErB4KmV8=
X-Received: by 2002:a05:6602:15cf:b0:614:52d4:952 with SMTP id
 f15-20020a05660215cf00b0061452d40952mr12907233iow.185.1647975068042; Tue, 22
 Mar 2022 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220302150424.1305301-1-thierry.reding@gmail.com>
 <42f99db6-f450-f2dd-fccd-17868b16b561@nvidia.com> <c84a0362-8cb0-2925-5a74-ad9c6c3ffe5f@nvidia.com>
 <a32c7181-79b1-07e7-81c5-9c692e4f958d@nvidia.com>
In-Reply-To: <a32c7181-79b1-07e7-81c5-9c692e4f958d@nvidia.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 22 Mar 2022 13:50:57 -0500
Message-ID: <CABb+yY2hyM9G_fGTtm9vpxwH61SbTwEQtjwKT=w7Fb3x8gwzew@mail.gmail.com>
Subject: Re: [PATCH v2] mailbox: tegra-hsp: Flush whole channel
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 1:29 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Jassi,
> >
> > Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> Any feedback?
>
https://git.linaro.org/landing-teams/working/fujitsu/integration.git/commit/?h=mailbox-for-next&id=60de2d2dc284e0dd1c2c897d08625bde24ef3454

thnx
