Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D802F543520
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242570AbiFHOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243335AbiFHOsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:48:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E88285A9D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:48:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h62-20020a1c2141000000b0039aa4d054e2so13516286wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AsTSbqFq1Bopw0lIZVLog4Y2QM1oEyRUOLCTFHozoZk=;
        b=eLn6iBll/WTIQUuGDQ+QCpgV81cFMNL+AKveFF9S3470O834KXDumV4UKBWTw1pEPs
         cHKslrjXiv+/5341NX17Cx5T57aIRk0z4s4Gks8H3olH7xqVfzG/2jVnqhzsVjB9bT/U
         yRvHg6alelEnO6XUJ3LRQLok79r6p0UgSlsMAsjZvV0wpEchpqVu4gz7qy5f+7KrU3Fo
         g2tQKERXGg/kiRwYF0yFN12s2vm7ClyJRCJFy04KTw74CJjcJVJnZLH4Z4+/RXI4iq2w
         XbAVS6p966Ue0vecFY6b5IQ4BTvmWRLjIas4aWtv7YxVgL20j1xXXrEi12mJvabaTL8p
         vL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AsTSbqFq1Bopw0lIZVLog4Y2QM1oEyRUOLCTFHozoZk=;
        b=g8+DGr++GwsqbR4GRP4Eugg1OHYKL8pYvCH9fwpaao3vw/2Zte+MjE16SjJwu0lGbT
         D01l4oPiKaZya48Q5LuNMBHVCe0jstsMMZWXniv/3HQ/vNYsm1d4R09WDBonYQ4OaDpc
         MKezrskZJwr7ujZ8A7EdA62G+kFeQYURKk/YFeGoe6zVIRI6ErpMkuFjmA8pnXcPInMe
         qfoBkRsTOcIHxx1oaOtXjHlxjz2leEpr67wj7gudxYaTkv2cbmQ5aB71k03kqSqzXQPq
         LydfSYrlaxzw/im3Oq211jheJlBQ02TzS3AbkoW4FYQFY1J6TXPeEe94RAb3MQfLKwsy
         YmBQ==
X-Gm-Message-State: AOAM53288lleDfkzoaszrcognrTG+WXFPSPPznqxMpOkh1fJfmBxb/mD
        hWQ4WycrlNzE1+yWXRtPXtnNjrRsREz/5qqB
X-Google-Smtp-Source: ABdhPJyNlX9mR+jfNuLkw5Yxng7DND6T3Ht+znaw7QZFDOMidaX+rthFvD7e9+uOs7qoh4Ru05/7Kw==
X-Received: by 2002:a05:600c:a44:b0:39c:1395:b44b with SMTP id c4-20020a05600c0a4400b0039c1395b44bmr48989879wmq.127.1654699692560;
        Wed, 08 Jun 2022 07:48:12 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d400d000000b0020ff7246934sm21433309wrp.95.2022.06.08.07.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:48:11 -0700 (PDT)
Date:   Wed, 8 Jun 2022 15:48:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] backlight: Use backlight helper
Message-ID: <20220608144810.gd6ckqfitoveztkh@maple.lan>
References: <20220607183411.1125030-1-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607183411.1125030-1-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

^^^
Subject seems a bit generic...

On Tue, Jun 07, 2022 at 08:34:11PM +0200, Stephen Kitt wrote:
> diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
> index 2194016122d2..c2d87e7fa85b 100644
> --- a/drivers/macintosh/via-pmu-backlight.c
> +++ b/drivers/macintosh/via-pmu-backlight.c
> @@ -71,12 +71,7 @@ static int pmu_backlight_get_level_brightness(int level)
>  static int __pmu_backlight_update_status(struct backlight_device *bd)
>  {
>  	struct adb_request req;
> -	int level = bd->props.brightness;
> -
> -
> -	if (bd->props.power != FB_BLANK_UNBLANK ||
> -	    bd->props.fb_blank != FB_BLANK_UNBLANK)
> -		level = 0;
> +	int level = backlight_get_brightness(bd);

Other than that LGTM.


Daniel.
