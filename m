Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8734E96CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 14:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbiC1MiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 08:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242549AbiC1MiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 08:38:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5AC4EA03
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:36:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p8so12501771pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 05:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ISEfxaNYWNVisu+9QZGXAX2bZb+iFFTUSbrI/VjohWU=;
        b=gJwGbRu12ZLWAHRt2TcJNBqbpeS1g9EVoDCJGFZu6aWM9hxxnJ3u2yH9ffkfiE80D6
         Wvdh7bEy5amQQUVmacUifyiotmmqcaG138rWwjzcma2qyL6EMl1jXEBTTq7TLeaHITWT
         lW6z1N/G0S6X/UVu0dQ8h0UVe09Oq1LFIJFAKNrhBqHeIYl5jfgCbsl7FkxNqS87bAQg
         DoE9Ch9sC7Gf1MrdCldAFQf/RBWCiCXcegeF5DI9E2uJK2onBPBCRfpkExg2gpvz0p1/
         ns8tBJNZA9OwskIywb4UsA6lCkcXuPtHegfpv6ZYSRS9SohPThSn2/7Ny+n0zbXjd5hz
         4T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ISEfxaNYWNVisu+9QZGXAX2bZb+iFFTUSbrI/VjohWU=;
        b=VQ4B+dXYRaPIrWgiiQtrXehyjPgCOFODvl9bOYVLwxANW3b6Lko+u3E0U2LQGvpzau
         IiIWMxNnYyw7mv82aXiBa9szCCgt80UEInWVlmplG7d/O3ObI6BSe3lYdZ8f1td9ezjJ
         kbNM5Ih0Y7AEYKyqt7+PDxtNuyMAWteiIzp9sp+7QnoqnSNY/sy+6PHwWlf6HvIBCbMq
         pC8wKKwFIgDuIVfWIzN0mOJa92Cfc8EaaUDgSYCQvOL6bOPukA2O//M1fAWKnd1bADfK
         9HQkmgecCOC/IqGzzViTEt3Fu0y8pQlGqJ3xWupF0KlOB40l02oHcIhLVdt4pWHmNYZ+
         VJpw==
X-Gm-Message-State: AOAM530t/RgWR2/FeSUKSpwqbwDrCd4BdkuoILRM/hvUsZNFYR89NlVp
        21eyqHuAeuY5TDUdIEszLv4DrW3Kvk5jPsAM
X-Google-Smtp-Source: ABdhPJxIPGIfNkoPiozRWEbOm1oSo8MflGjlwyo4NUYbR28pSYjyc8iTfJAojR4+S8z7amlPWyGtSA==
X-Received: by 2002:a63:2b4f:0:b0:398:49ba:a268 with SMTP id r76-20020a632b4f000000b0039849baa268mr4240877pgr.546.1648470985967;
        Mon, 28 Mar 2022 05:36:25 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm23577653pjb.36.2022.03.28.05.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:36:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cc17199798312406b90834e433d2cefe8266823d.1648306232.git.christophe.jaillet@wanadoo.fr>
References: <cc17199798312406b90834e433d2cefe8266823d.1648306232.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] block: Fix the maximum minor value is blk_alloc_ext_minor()
Message-Id: <164847098496.6880.2578259301021456744.b4-ty@kernel.dk>
Date:   Mon, 28 Mar 2022 06:36:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Mar 2022 15:50:46 +0100, Christophe JAILLET wrote:
> ida_alloc_range(..., min, max, ...) returns values from min to max,
> inclusive.
> 
> So, NR_EXT_DEVT is a valid idx returned by blk_alloc_ext_minor().
> 
> This is an issue because in device_add_disk(), this value is used in:
>    ddev->devt = MKDEV(disk->major, disk->first_minor);
> and NR_EXT_DEVT is '(1 << MINORBITS)'.
> 
> [...]

Applied, thanks!

[1/1] block: Fix the maximum minor value is blk_alloc_ext_minor()
      commit: d1868328dec5ae2cf210111025fcbc71f78dd5ca

Best regards,
-- 
Jens Axboe


