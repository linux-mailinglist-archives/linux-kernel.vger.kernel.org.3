Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D54A57B6B5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240826AbiGTMqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240953AbiGTMqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:46:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6492A96B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:46:48 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q16so13188442pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=sEGQ7L1KrUZZSjc5lTCBdg4P620qJO0ftLSgZHwILC8=;
        b=rwUDwbnnw3bPn47kNfg7ezqzV/LZChu0a3v2CN0AynDdb4B+/tvtYW8/uAOhGtObcZ
         jdMz1+jCJ13tg2VyNFIzZPhKJMc7Ob2J0tf6XGCs9xkgJA/nrmYYJUXRUHBi0tUDuQmj
         v79GFiy1F8xNZ7qkRqvQzBaOyUzpSCbt2HEHzsViyqik+g6/sisTG7KHot3xgK9bWkbA
         SJQ83R0YkKJ6jYgdD1HuOk/8/NmH1MmCioP9T8sQD3DJRieSUOW7MGmgP6Ej+rLEdg//
         DEOGINokGsTjCA7yDSww75D/W4A1AhfCxEmU4SbMXhlSs0PN5n/iF3nOL2lr+c/vdHve
         w/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=sEGQ7L1KrUZZSjc5lTCBdg4P620qJO0ftLSgZHwILC8=;
        b=Yfnw9wwMY7m43TCqx4x3WnLOGO6TIufgX7XI8Mn1s33G2IKUUTUGFU9xlfaP3klK78
         50BaGfWpt9+GIHtfcCgy8k357pg7cHKaAyTtvJLYYHBno4yXkiil5d0GnC6SHkqlIc1F
         sKClk3yYpx2DbsjEp7E2vJx2qv070uDid4Ne57Pp4fej0HVbt9g7LqPCOUbaDTmbQpnZ
         Qqrw8ZhNY7/cX0sSGjEXaLCoPBzJsf2j7uQRMcpbkECIWPPPKURRsOo4JPwtbZoHQR2C
         iMTgae71/laRuhQmQoyn2DMldZiKd7j2qlWAOEXcVe1c60AJLo4Y+evlLeESMpsAluAu
         jepA==
X-Gm-Message-State: AJIora9j7EZ1d+V8j7sSf7W+KThgNHGsAsPvo7CdePIbPjxGz6BoQBKK
        XJXS/j2ZXCavpsceUdBzdYirmg==
X-Google-Smtp-Source: AGRyM1t7wriEhr2mqYC6echsB2BY8+c43mOtwnGP0h8SWWvTQ+c/TMAVrHpPIfdz3GHa7zH8ZeSiww==
X-Received: by 2002:a65:6d98:0:b0:41a:6331:cffe with SMTP id bc24-20020a656d98000000b0041a6331cffemr3365206pgb.297.1658321207565;
        Wed, 20 Jul 2022 05:46:47 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ru7-20020a17090b2bc700b001f219ace0acsm1544392pjb.16.2022.07.20.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 05:46:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org, hanjinke.666@bytedance.com
Cc:     linux-block@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220720093616.70584-1-hanjinke.666@bytedance.com>
References: <20220719165313.51887-1-hanjinke.666@bytedance.com> <20220720093616.70584-1-hanjinke.666@bytedance.com>
Subject: Re: [PATCH v4] block: don't allow the same type rq_qos add more than once
Message-Id: <165832120656.248441.6551351074316660910.b4-ty@kernel.dk>
Date:   Wed, 20 Jul 2022 06:46:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 17:36:16 +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In our test of iocost, we encountered some list add/del corruptions of
> inner_walk list in ioc_timer_fn.
> 
> The reason can be described as follow:
> cpu 0						cpu 1
> ioc_qos_write					ioc_qos_write
> 
> [...]

Applied, thanks!

[1/1] block: don't allow the same type rq_qos add more than once
      commit: 14a6e2eb7df5c7897c15b109cba29ab0c4a791b6

Best regards,
-- 
Jens Axboe


