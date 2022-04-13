Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3AB4FFF28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 21:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238282AbiDMT3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiDMT3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 15:29:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E748372450
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:26:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3338386pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jf/ZCTZ5Gt2jVqN46dFAbZd9GqgtwDVJ36AS2dLx9QE=;
        b=fDivrUePV7M5M2U9uoSiSeosNah6RKsS1lEZDEDtTtdJ5JoDGOjQVirldSum93E/03
         aor33I8b33rmWXERSUDFzQDlz4xm+t3bXDzkQr1IoDv2fc9FJmmsJpZgtzm4kZkM5y8S
         4AV0eKhTgzGC6KzpOIPEs5CzCZmL+rf86NQeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jf/ZCTZ5Gt2jVqN46dFAbZd9GqgtwDVJ36AS2dLx9QE=;
        b=LLU7zpKhips1A0MPblamWwNX4a5VwFGCDldxsqrvm1GAm3z2lCvg237CbYwra0CuC8
         golNAq21XPEaEaLTSVNrlavspsuz6iHuVrSlvJYc0loVbVmJOy1FPOHpkwIY/UIuo2r+
         nk35Ftk8i0EZlW5OUpifSd/yaTPyamjLkNw1CeXwffT+ont15yA9I7EmlUo5ESVKPK4B
         PWo6Xr1pRp6PiG5fqOmlklmULgZAUcmpT6yAUH/qtvCGvA4qEk6v/3Nb3lVZP0rwYsx2
         cSjU62Jm0f85fNU7+O+p+ZaZ9YK5H85P7eYyf9I6JZGyRWWH5hvc1IheEVAaNlxF+HLm
         Ksrw==
X-Gm-Message-State: AOAM5338LKDH72Yb9KvaVtWnLYEvG+PHOJ+4TPVdKGYarlBqGrTQgpa2
        0bp9YudAMPB6fqcgiMEmiNAbCA==
X-Google-Smtp-Source: ABdhPJwsDOGUzvY9tZ6EmHG6uOb71mNsqBiP8D5hYRNo/rNgxu/k9B4PViksdjKiE4djMDXlMlspSw==
X-Received: by 2002:a17:902:d884:b0:153:ce8e:66fe with SMTP id b4-20020a170902d88400b00153ce8e66femr44113768plz.157.1649878003377;
        Wed, 13 Apr 2022 12:26:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm45505437pfl.135.2022.04.13.12.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:26:42 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     samitolvanen@google.com
Cc:     Kees Cook <keescook@chromium.org>, nathan@kernel.org,
        linux-arm-kernel@lists.infradead.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        mark.rutland@arm.com, ndesaulniers@google.com, will@kernel.org,
        catalin.marinas@arm.com
Subject: Re: [PATCH v2] cfi: Use __builtin_function_start
Date:   Wed, 13 Apr 2022 12:26:33 -0700
Message-Id: <164987798634.655998.2445977983913600905.b4-ty@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405221618.633743-1-samitolvanen@google.com>
References: <20220405221618.633743-1-samitolvanen@google.com>
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

On Tue, 5 Apr 2022 15:16:18 -0700, Sami Tolvanen wrote:
> Clang 14 added support for the __builtin_function_start function,
> which allows us to implement the function_nocfi macro without
> architecture-specific inline assembly and in a way that also works
> with static initializers.
> 
> Change CONFIG_CFI_CLANG to depend on Clang >= 14, define
> function_nocfi using __builtin_function_start, and remove the arm64
> inline assembly implementation.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] cfi: Use __builtin_function_start
      https://git.kernel.org/kees/c/e6f3b3c9c109

-- 
Kees Cook

