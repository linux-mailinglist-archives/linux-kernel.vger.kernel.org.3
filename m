Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556DE5B0FDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIGWec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIGWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:34:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D96616C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:34:26 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so384450pja.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 15:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Pp4y+VXW5QuKNOfWHvi4eGa5eVSczb0JEs1BHSpJSao=;
        b=FV41OpH/zYkOpWATnK6blHNr73aeb2iEyq49smzLx8q2obuklQVtsju0Ul3RTSamuK
         D1fToC27p9Pt6NEleAg6dp9SKDX3io+srHT/274GiN9NSJXFFKvRG9KNNwbtEhF9Qby6
         maYNTqXLg0tJfBKJIkR8RPgQBWLbExuHcPsbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Pp4y+VXW5QuKNOfWHvi4eGa5eVSczb0JEs1BHSpJSao=;
        b=B9Dd+5k9Yh+mHxX7TDCPhZ0iTCVHKtpSmEhRFf5dEVGKogCUURPw1Cg1aK0XXsW5XA
         gddVtjW3ffqcDoELbk+ofNn8pfWLC46G1FIUP/2AiCbpdRM3GAlP+yDhBLBc5KkMQzRv
         MLX9xhbr80YDcqJHK0JvSeKh4WhYpmgl6X01xFWgG6dg4ZwqXfHZa8KndmPJv9RlyCOm
         qIfc9prygdJezwJtPFCYqBlpTvCva/jxdRL2rkg80kTH99+DKqlCb6yGmL/M6Yrk1Zq9
         Z2UGjKSYW/aOkrrEsyZ4XJYyccJu/+qxW/ReOl97rbpk9V9tTOxvV6ZchlDWwSp1nwWr
         yYmA==
X-Gm-Message-State: ACgBeo3gzFhOSUSOzg1EA2cXlrtA1OgNdU/YArrjGQgpWLB/GAowNnt5
        6h225vpLJvsmrSCTor7WEqsg5A==
X-Google-Smtp-Source: AA6agR5bxK5DKuJ4g7Wu/Tuk9tp1HvYw8sClTJInhRq1N4MSQnfDWDR2wyiSwI1H2US21Pg7QsiEnw==
X-Received: by 2002:a17:90a:9f8f:b0:200:e27:398f with SMTP id o15-20020a17090a9f8f00b002000e27398fmr764902pjp.116.1662590066538;
        Wed, 07 Sep 2022 15:34:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902ce8600b001714e7608fdsm7529520plg.256.2022.09.07.15.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 15:34:25 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     snitzer@kernel.org, agk@redhat.com, mka@chromium.org
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sarthakkukreti@chromium.org,
        dm-devel@redhat.com, dianders@chromium.org
Subject: Re: [PATCH] dm: verity-loadpin: Only trust verity targets with enforcement
Date:   Wed,  7 Sep 2022 15:34:08 -0700
Message-Id: <166259004596.4128104.7200162640366282166.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
References: <20220907133055.1.Ic8a1dafe960dc0f8302e189642bc88ebb785d274@changeid>
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

On Wed, 7 Sep 2022 13:30:58 -0700, Matthias Kaehlcke wrote:
> Verity targets can be configured to ignore corrupted data blocks.
> LoadPin must only trust verity targets that are configured to
> perform some kind of enforcement when data corruption is detected,
> like returning an error, restarting the system or triggering a
> panic.
> 
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] dm: verity-loadpin: Only trust verity targets with enforcement
      https://git.kernel.org/kees/c/2e1875c05267

-- 
Kees Cook

