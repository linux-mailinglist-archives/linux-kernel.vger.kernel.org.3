Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997F54FDEBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiDLL7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345871AbiDLL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:56:56 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB05AA7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:41:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c10so5965915wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nST2CJez2iVLsyrt/7bqoBrsZt1B2xdjNSFZ+8nf/0U=;
        b=sxLpo/DCzc+OuotFT3EIJUNlVlyf+C37xOk9T1xL2c/tlx3Gafkn5qQZXg6Ti0UaLz
         wpGuix74WAl18sp9ZvjCTQrPwJ0C6KSB+GKoZ7r/BwCY96aBrdH767J6Z9gYuU1yT9jO
         FZ/w3bnkSsut8HU3Bi3uzk1SnGj8TQaXDgm9XII+k58Im3KIChHnOeztyWvTAi/v2W6A
         XXkb3k08ROxMiHCIy5yBKcDH9wlmW+QfSYH+IvephHz4dKl1akgtXjB2h76M2XMcSJLh
         RNoyHIFxlslecoL689hYcs9h3EntFqizPHfPR9RYgYD0h1HgSjX2S74RnlHEh9O8H+DU
         RiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nST2CJez2iVLsyrt/7bqoBrsZt1B2xdjNSFZ+8nf/0U=;
        b=e/4Xz2+Z74sazIIPIbThg3JfpuUNQwi/GcD+g1rihiOonFTs9y2sro0fJdd3ISNBLg
         Y2fA7UM7Jb+FdhAYr6/PbW7oBdNSlRs1CiTfp7gonV3ks/04j2FSVX2mjcas+OERGt4Q
         mPmAiOv2gW1ixl90vr7iYblauud90f2OPQ3QtPKLz90iaUTLIM6O3VwPaUxZS99xkRU2
         JUZ7jix5XpEn1PjwRoCWOISboNXNlp3U/AmM8LLvcnH7d3EcY5pnrCfKRPjvnNW9Z0hh
         ztyHbva15wXk4/+dOMhAVskokY3CmqfHR6SBNr1YpXRiWvls7AUFuEBzKEW0yROEjXTx
         VLSA==
X-Gm-Message-State: AOAM530CDT8b7PqO709MWcAz6KTGcoMbxA0iRBt6X+vXZFTr5UGgXWr0
        NH8A88SyFNAlIeiqbd9HGjIoeXMuaVBZ3I4YIZTu3Q==
X-Google-Smtp-Source: ABdhPJzNClNcR3j8j+NnaIHmAra6bFvY2xXUBBkoQMXGPnSO0pddRT1buUtEcplNexu17u6VffwUjaMC8iTvABO9S2Q=
X-Received: by 2002:a05:6000:2c9:b0:204:1675:843e with SMTP id
 o9-20020a05600002c900b002041675843emr28364968wry.699.1649760081801; Tue, 12
 Apr 2022 03:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220304171913.2292458-1-james.clark@arm.com> <20220304171913.2292458-15-james.clark@arm.com>
In-Reply-To: <20220304171913.2292458-15-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 12 Apr 2022 11:41:10 +0100
Message-ID: <CAJ9a7VgJ-Z0u=u9NwnA_3cxftyXzhTa3QsJVhRUTYfGxiXzaQQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] coresight: etm4x: Cleanup TRCBBCTLR register accesses
To:     James Clark <James.Clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        Anshuman.Khandual@arm.com, mathieu.poirier@linaro.org,
        leo.yan@linaro.com, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2022 at 17:19, James Clark <james.clark@arm.com> wrote:
>
> This is a no-op change for style and consistency and has no effect on
> the binary output by the compiler. In sysreg.h fields are defined as
> the register name followed by the field name and then _MASK. This
> allows for grepping for fields by name rather than using magic numbers.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 4 ++--
>  drivers/hwtracing/coresight/coresight-etm4x.h       | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index 25f76a656308..3ae6f4432646 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -707,10 +707,10 @@ static ssize_t bb_ctrl_store(struct device *dev,
>          * individual range comparators. If include then at least 1
>          * range must be selected.
>          */
> -       if ((val & BIT(8)) && (BMVAL(val, 0, 7) == 0))
> +       if ((val & TRCBBCTLR_MODE) && (FIELD_GET(TRCBBCTLR_RANGE_MASK, val) == 0))
>                 return -EINVAL;
>
> -       config->bb_ctrl = val & GENMASK(8, 0);
> +       config->bb_ctrl = val & (TRCBBCTLR_MODE | TRCBBCTLR_RANGE_MASK);
>         return size;
>  }
>  static DEVICE_ATTR_RW(bb_ctrl);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 3b81c104a44b..15704982357f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -220,6 +220,9 @@
>
>  #define TRCSSPCICRn_PC_MASK                    GENMASK(7, 0)
>
> +#define TRCBBCTLR_MODE                         BIT(8)
> +#define TRCBBCTLR_RANGE_MASK                   GENMASK(7, 0)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> --
> 2.28.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
