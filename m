Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFC55F901
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiF2HbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2HbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:31:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946F1E3C0;
        Wed, 29 Jun 2022 00:31:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 764FDB821C0;
        Wed, 29 Jun 2022 07:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A273C341CC;
        Wed, 29 Jun 2022 07:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656487871;
        bh=oMeQKpTJ3BlHRwci50rWw9zWWSKNybDyV9xN21PWkBI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=mU880ru7zaucB8jBICSqnu/jCaB0EgyVGWoiMZn5EwJERBGcPpm/gmUhzoL5zGmWN
         /cOPLYPOkOkrqwCpZDc9S4WH7QaHVYXt0nL/uiHBENhsAuYRiaXcigrX49QmI40GT4
         v88z3GP0iO7UIg1Fb2YunniT+KUFPHbsZcqJSaJZCL/guzPFnnaCQKipdTKntTApkh
         v1P2n//9zJu22GgaGv0X/xXjPPpUm7246C44XeOUmnLliOZfBVPMAI/HPgPGHS3z8t
         HkFx+DQ1tZIyAWDkZQWh7Bev3sX9BOad9pPLLY9Upxr/OKdCEg9osp+Bduz0dovoJL
         OIJT6SQAI43Vw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220628064301.v3.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
References: <20220628064301.v3.1.Ie7b480cd99e2c13319220cbc108caf2bcd41286b@changeid>
Subject: Re: [PATCH v3] soc: qcom: cmd-db: replace strscpy_pad() with strncpy()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Date:   Wed, 29 Jun 2022 00:31:09 -0700
User-Agent: alot/0.10
Message-Id: <20220629073111.3A273C341CC@smtp.kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-06-28 06:43:13)
> Commit ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with
> strscpy_pad()") breaks booting on my sc7280-herobrine-herobrine
> device. From printouts I see that at bootup the function is called
> with an id of "lnbclka2" which is 8 bytes big.
>=20
> Previously all 8 bytes of this string were copied to the
> destination. Now only 7 bytes will be copied since strscpy_pad() saves
> a byte for '\0' termination.
>=20
> We don't need the '\0' termination in the destination. Let's go back
> to strncpy(). According to the warning:
>   If a caller is using non-NUL-terminated strings, strncpy() can still
>   be used, but destinations should be marked with the __nonstring
>   attribute to avoid future compiler warnings.
> ...so we'll do that.
>=20
> While we're at it, let's change the query array to use
> "sizeof(ent->id)" so it can't possibly go out of sync with our later
> copy.
>=20
> Fixes: ac0126a01735 ("soc: qcom: cmd-db: replace strncpy() with strscpy_p=
ad()")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
