Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6775855D542
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241843AbiF0Xtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240866AbiF0Xtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:49:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABFBE0B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:49:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so10916050pjv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AqgAK6vW0sjwljhDhF+wDDYOvFeDeqUAJsWDqLfwnOY=;
        b=XwGc2CSDj85YQw3/ioBITivk3gVbW4vBmhsm/WgaJYuwbcetHTmEcccRdL5+qdaiE9
         Jr7rtHML6/RJK82HnK30L18MtdtwDN60y/8phzk7bLAnRweyXiHbZw9jqYH84rZfMTOz
         d/HJJ4EX+bu7oZOiv+fe9DBrPxU0v8NbCUnmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AqgAK6vW0sjwljhDhF+wDDYOvFeDeqUAJsWDqLfwnOY=;
        b=ZVCA6LMplPM7iWPvEAkLFVSH910auzDPMhYmTLBX9XzWHJXkxldygMTkclUZgWp2nt
         vA7P8YuQylGfwRfijgcGKfCfjZLLjBLpFENDgeALYlfAvJwcbzfm6Nui3ge8jTjzC7lA
         jVNNLJmLDxpsVaAedR1JUcMI1gBsD8bvxGDCbfLn+iyCF3zd7ZFXujhGMLZwQ/YMuoys
         n3mRx6btd3iAaLUGKWSMYbGNEmGYfm13bJbMzmuh+xHSODzYsmbwFYWZhPtf8JNbI5in
         ApN4qhuTYY1EQN0vzAijGgJaI2n1xUu9LG1V9B/7ZBj7e7OnezmEtDjvHGfHApBtCMZs
         AO1g==
X-Gm-Message-State: AJIora9HHvPfq58W9yG2N5P/1FShRXHvSYQ7X4B3rTaPuw+nfZzNTo4U
        +5AcZDZogHrtFwHv3FJPHstU7A==
X-Google-Smtp-Source: AGRyM1s/Xm5LgTVErGnjTuMVaP9oB8WtNcqcZYYUR5VgkZ7hJjKQh5Eh7nLPgHV2RLHc01b93JXeUw==
X-Received: by 2002:a17:902:f688:b0:16a:81d4:17e0 with SMTP id l8-20020a170902f68800b0016a81d417e0mr1962080plg.174.1656373786783;
        Mon, 27 Jun 2022 16:49:46 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:f31c:687c:3a61:62c5])
        by smtp.gmail.com with UTF8SMTPSA id s1-20020a170903214100b0016a01637620sm7762769ple.76.2022.06.27.16.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 16:49:46 -0700 (PDT)
Date:   Mon, 27 Jun 2022 16:49:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: cmd-db: replace strscpy_pad() with strncpy()
Message-ID: <YrpCGa3OTtgBr0vN@google.com>
References: <20220627161642.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627161642.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 04:17:00PM -0700, Douglas Anderson wrote:
> Commit ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with
> strscpy_pad()") breaks booting on my sc7280-herobrine-herobrine
> device. From printouts I see that at bootup the function is called
> with an id of "lnbclka2" which is 8 bytes big.
> 
> Previously all 8 bytes of this string were copied to the
> destination. Now only 7 bytes will be copied since strscpy_pad() saves
> a byte for '\0' termination.
> 
> We don't need the '\0' termination in the destination. Let's go back
> to strncpy(). According to the warning:
>   If a caller is using non-NUL-terminated strings, strncpy() can still
>   be used, but destinations should be marked with the __nonstring
>   attribute to avoid future compiler warnings.
> ...so we'll do that.
> 
> Fixes: ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with strscpy_pad()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
