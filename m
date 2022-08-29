Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733845A549C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH2Tgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 15:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2Tgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:36:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5AB77578
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:36:49 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id j5so5095965plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gdVPPdyI0n1zo4MzKShQZwlXGpQ/Ru9oFsJ+zNUS/Y4=;
        b=DmCS/k4KU3N5Bw3EjprskZJAooaeZ7UUHT+j9y5jaQ+nwSkreIN9COYrW9PvCraTEa
         NAwuFBgRFPp1rfNWhGM7d9WhmbW1rVEVa7SG1BQdCKGkrViqWWrgCkq7K1J7VV6+au+6
         7RTXRL/u7XbUzWx+kn92LfsGH4tNiHgQ/ADXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gdVPPdyI0n1zo4MzKShQZwlXGpQ/Ru9oFsJ+zNUS/Y4=;
        b=R02bmtGKf9L0Z9X/PhiR6a3IQSV9aAcNxb3dGH9A9YN8iYFM84HH7JVi5s7xucn/em
         GaJmmroPOi82EROtjVxtrfYcsFeqSVy3oSt96dCT3bc0hG89NXZl1xtT4i8bfO3qTV7J
         TwHnH8HwxlYTzwqAT3NoLOIOHDq4zs+ISI6EXMrpdgzDQq1CirWyqGyCsN925b0gyX8F
         u4clZYS/3f4XEhZtxKl0/AXWxQRPDgc072IUqST8aULTxUgnvCFfrsH4/jHyjktXH2B8
         uJxtzF8pwqKr8I5veORmmxmyKs73iHcAPzk4d18W3++005a5BsCi+Gv3xElEdNGboOQM
         jURQ==
X-Gm-Message-State: ACgBeo3+Ea7KORyvmVK+UhuqkP24F2jKsuTaZkGravBq5rOfm0OsjJ6/
        XFzxANln3fXWORcA36NH00Y1Dw/8beGStg==
X-Google-Smtp-Source: AA6agR4R20/vKWd/30xk860pm0+XFiM+l4nAbu66cbo97KKhN2+AGRLr5WvCadf+4vVPfDxvTYUPPw==
X-Received: by 2002:a17:90b:2807:b0:1fd:ea9f:5a89 with SMTP id qb7-20020a17090b280700b001fdea9f5a89mr3710972pjb.52.1661801809411;
        Mon, 29 Aug 2022 12:36:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709026b4300b0016eef326febsm7922710plt.1.2022.08.29.12.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:36:48 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     bvanassche@acm.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Define is_signed_type() once
Date:   Mon, 29 Aug 2022 12:36:13 -0700
Message-Id: <166180177086.3333436.3960451393812053423.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826162116.1050972-1-bvanassche@acm.org>
References: <20220826162116.1050972-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 09:21:14 -0700, Bart Van Assche wrote:
> The changes in this patch series are as follows:
> - Add a unit test for the is_signed_type() macro.
> - Define the is_signed_type() macro once.
> 
> Please consider these patches for the next merge window.
> 
> Thanks,
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] testing/selftests: Add tests for the is_signed_type() macro
      https://git.kernel.org/kees/c/5e3ad11bfc5a
[2/2] overflow, tracing: Define the is_signed_type() macro once
      https://git.kernel.org/kees/c/6bf7edc1e6f0

I tweaked the kunit test to have a matching filename to the other kunit
tests (i.e. ending with _kunit.c instead of _test.c)

-- 
Kees Cook

