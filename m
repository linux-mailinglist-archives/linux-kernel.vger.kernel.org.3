Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2F74B926B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 21:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiBPUfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 15:35:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiBPUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D562A417D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:46 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so3471086pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 12:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Pdsfe0gyEmDKM5R6mqr1jUT1ZdiKllfIVbOCvrOVopY=;
        b=GqO3BGtvS7W0omx157sqs6ni6O3amemk/DItS/LHtrqA4L13kV5lyQ7j6RIiUaNOhw
         y29Ks3MP3wxKHWL6hgE1e7JTiWVe7ZwqdhO23Bqcxll4rswcr9rzkypRIQC70LMjVedU
         926c/yyIwb2MXUtVMMunPN59htdYvKUKDXdw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Pdsfe0gyEmDKM5R6mqr1jUT1ZdiKllfIVbOCvrOVopY=;
        b=ZmEnXIuRGVbfD0fwjWT0wEjyKNxxhvWuzPNu+NVNzXUSp7F19k6mjs2IRSQmG8uS/J
         /B2wM6fdg3VYe3C0FD577tCSFggvzemTsYSag+6Dzvu918xC2q6FXrkgffyuqm89uFex
         f4/6A5RGL4OXTr8g56yt9XRoG0egY8XXRIwBr987ehRy33/k1q6BLdPojsnrxZkNgT/R
         e6+DiuIHmuIh+CbBkyMbQgLTr3MZH5VuG5E07ezFzawlQi1z+0n/pzzNu2ashKaD5LkL
         KrQvCb+rWNXu6gTGz3WRwGqwFh7NZg3Wj5Twt8IdfvUzMK0LEK7Sq8ux5PRGIiCkls9Q
         kd0Q==
X-Gm-Message-State: AOAM5308oZQg4EixEkgw/HtnXqRQ3mZrCbcH0+feLEyO/Ky4mS+cGsMW
        W/vb2AF7YODpx6qjkIuAkfvnOA==
X-Google-Smtp-Source: ABdhPJwdgVBQz/qyf2UdTRXGoq4ewW/DaZkx7WmJn3WoZHGknxkEs553N90vxJHp1bw1lio6Ff29gg==
X-Received: by 2002:a17:902:9007:b0:14f:3680:66d1 with SMTP id a7-20020a170902900700b0014f368066d1mr570949plp.91.1645043685753;
        Wed, 16 Feb 2022 12:34:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a15sm5814755pgd.11.2022.02.16.12.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:45 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] brcmfmac: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.3BCDC5D2@keescook>
References: <20220216194935.GA904103@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194935.GA904103@embeddedor>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 01:49:35PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
