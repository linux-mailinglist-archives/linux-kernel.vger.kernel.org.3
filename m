Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941C56177B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiF3KQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiF3KQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:16:40 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEC4504F;
        Thu, 30 Jun 2022 03:16:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so2343592pjb.2;
        Thu, 30 Jun 2022 03:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0LVkgORs6ngGfjYpIi6ByVM3qFgrI0AIRiGjFoIOLRk=;
        b=ivPSRzkcZt1GgHxSMUeImsZkd4ybgFyoLsiiYbw59HNPxovCL5WieAm5NWyQ2JOb6j
         kn/JySIZ/SXP6BAcz2WlDCFK8BNTb90IY2PugTLlkFVUCaccR9ADOQpS0dxselvANGzm
         oKngqXFR5RV+buwUQgOhmqVQyBAW+Xa7zf1ME/zFCrFarYpMg987TeKTUUrVZjVpe+AK
         r5WizShhl2WLfJ72N69Kr+nywNl9SZbZStIa/NAYeHhck4T034PmVNtf5n4eCO3YPdW9
         pAC1yW8g2FwiZJxyxYtYP1uAiMXetfLLySF6jU9vmJNJrFEmY0f1Y2/5PpB+iGyHbcGD
         sT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0LVkgORs6ngGfjYpIi6ByVM3qFgrI0AIRiGjFoIOLRk=;
        b=eLmQ2qCj/YfF8kOKokTfeJ6fSFXIAMqHdRi/NbtX6JyWmmr8UU/t7g560aBz9GH19F
         jbI9Vejf1UEcK5/FT3JeEY/ybdqhdXxWt4XJ/5b8mVvQmoMDOf8FylniaaMwdjMDF+Vr
         11burx9yHJq0k+4mTQpsk5en+BXmrpdnFJbJrLIc/TmaD8gV+GIXu7lrb7dzSMGXt0Tv
         bogqvvjn7+d+wD6h/JmOWEfMBaOO7vcT3/L+xqb14Ui6hsDjx9hAJQBz0O492UT2o9Gi
         b0F/tceQP4EhaIr3OIfhEZG0WFCcBoisTYrxyJ322eF1/eNBrnuNV1UumJ+jtnDguDwy
         Dr+Q==
X-Gm-Message-State: AJIora+eShTvn4uYdEIymWKCUZT5pzYQX5PvmvlzQUBeuYuzEmLMoAS9
        QwA2UKwI7ma1VJ7E8sOsFZQEtYm5jg4=
X-Google-Smtp-Source: AGRyM1uGIQU2HXkwr4g8C+kPrDHWataMoplXIBeLEX8CJPk7MuEMoDCW026Q3lnEFBp8mE6oMJI3xA==
X-Received: by 2002:a17:902:e94f:b0:16a:214e:46c1 with SMTP id b15-20020a170902e94f00b0016a214e46c1mr13813582pll.89.1656584198830;
        Thu, 30 Jun 2022 03:16:38 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id k63-20020a632442000000b003fd3a3db089sm12696262pgk.11.2022.06.30.03.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:16:38 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B6DD91038FD; Thu, 30 Jun 2022 17:16:35 +0700 (WIB)
Date:   Thu, 30 Jun 2022 17:16:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the coresight tree
Message-ID: <Yr14AyVYbhjmRa+b@debian.me>
References: <20220630173801.41bf22a2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220630173801.41bf22a2@canb.auug.org.au>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:38:01PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the coresight tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/trace/coresight/coresight.rst:133: WARNING: Inline emphasis start-string without end-string.
> 
> Introduced by commit
> 
>   3c15fddf3121 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")
> 

I have sent the fix at [1]. Thanks.

[1]: https://lore.kernel.org/linux-doc/20220630101317.102680-1-bagasdotme@gmail.com/

-- 
An old man doll... just what I always wanted! - Clara
