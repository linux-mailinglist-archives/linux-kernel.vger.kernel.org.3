Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D3B528C29
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344343AbiEPRjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiEPRjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:39:41 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0EB2612A
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:39:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z18so16762754iob.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=mh56sie1dPkPYUnwa6mvPMhYEaqSra4iS7JfXXMW55U=;
        b=qAJHetIbc57mNL80Bx30Z2qPkvcxnQSos1cYB90vvXD8rMCvUcp7tK+Ih0E+Uiaps6
         88iqtYzkzieHEKtlccMzu4XSr9aYh7Uc6X5fsNQvNZkoSSOtgEV0ItopxSe051SaPc8q
         utRyEINUgmS+GuC13Y0MWbXuUmUvv1g5GXftp0KAq+Bfvasck0TqP2+S2BRzI0KoX6pX
         Wwu88Nd/qrf9opIcav2IF2irJNp0+VDMN7wxGOoSy6A0+oAfSdXhLavHnf1IuP30OqnM
         ixsRa4y/YWE1SG8ReCh/DbVE+G2Aj6sHoj9DJWtaNvxEjj1GkQhPll2ZShQhxqgCIaI+
         +x5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=mh56sie1dPkPYUnwa6mvPMhYEaqSra4iS7JfXXMW55U=;
        b=V3Xmwis+bYvWGhQJ9d7RY/mvW2SY0iIfJ8LdL0uhimhdaUkXYYwwTJ+C47TO3qHsSc
         JvtQzdkO72VHyLc78HoTYzltGzTh31SJ5s1UpSfsF6wUW4+fIGVTZI8PvZqv20znP/Rw
         SNCADqGhz68vl/zhY48FFKslb/NDusrIsiYNJs+KTPjInhvZNAG27CzGJK8UYpKij7ju
         cFZhzKQjALf81+jGNLr13c7nXI2Ou2E4RuO3ANcg4wmw9Gyv18degmMJLYFMy4qDDv6U
         b77XrpttWBaIeEKplK9jzIFrs5JADPCIcellSOvJMFv676ijOjq3L4MOM83kXUPYD/Pb
         a8Tw==
X-Gm-Message-State: AOAM532Yhi4RPL4FqQxzZiCqeqJ1ptkOp4PzRe1k8WxhymwKaR9EFnU3
        UbxeWXZajysopUHLzfhEYGRlbg==
X-Google-Smtp-Source: ABdhPJwOSAmiOY0EvbJnF1yn1IJ4NBeO1tm5aNU1l6890ES/z1ezm2dDKuRp3U6XlZ2eqcTsaci5yw==
X-Received: by 2002:a05:6602:1501:b0:65a:c412:2eeb with SMTP id g1-20020a056602150100b0065ac4122eebmr8148723iow.29.1652722779743;
        Mon, 16 May 2022 10:39:39 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c11-20020a02c9cb000000b0032b75b98013sm2953165jap.148.2022.05.16.10.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 10:39:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     yukuai3@huawei.com, jack@suse.cz, paolo.valente@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        yi.zhang@huawei.com
In-Reply-To: <20220513023507.2625717-1-yukuai3@huawei.com>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
Subject: Re: [PATCH -next v2 0/2] block, bfq: make bfq_has_work() more accurate
Message-Id: <165272277894.181860.12420245970045700212.b4-ty@kernel.dk>
Date:   Mon, 16 May 2022 11:39:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 10:35:05 +0800, Yu Kuai wrote:
> Changes in v2:
>  - add reviewed-by tag for patch 1
>  - use WRITE_ONCE() for updating of 'bfqd->queued' in patch 2
> 
> This patchset try to make bfq_has_work() more accurate, patch 1 is a
> small problem found by code review.
> 
> [...]

Applied, thanks!

[1/2] block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
      commit: 181490d5321806e537dc5386db5ea640b826bf78
[2/2] block, bfq: make bfq_has_work() more accurate
      commit: ddc25c86b466d2359b57bc7798f167baa1735a44

Best regards,
-- 
Jens Axboe


