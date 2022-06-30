Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6845626A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiF3XLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiF3XLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:11:16 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A034259268
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:11:09 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w2-20020a056830110200b00616ce0dfcb2so569254otq.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/9jdD7+1+i1Lm60svXWsJgxbEFp2/Oeat9F5av8m7uY=;
        b=ynbe5POgPeLGuOGH8qwfK+MAkOMQKMg/sOvFUIv2Lp8h7jwzaq3Iz9Q7XwCDuppnN2
         tpYB14FFIzI4i6s90p8TCDyoGEdNHcKmwroQZQYEyC/AlK/+f8SClpsJe6Bxm28Jytn1
         UgcHN5pqFnUtP44Pwk3l7LfPteUOYjgIjre4UZPNOKUBPhNEy4nKXNCcKvJP+oX9cUjR
         DJYRWGwlKU8BIc0GGrWF9ztt+54fHSbBcIzeOkMwZBi2iCuWQB3jjMRflT2o/C4KIjDc
         /1HwInPB+slMTrIH2zr9z9OwUwcr4uAhK7KcbuvvhgyysIkv7OGiPjgk6bKbpkR0ajEQ
         TscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/9jdD7+1+i1Lm60svXWsJgxbEFp2/Oeat9F5av8m7uY=;
        b=HkDllGfbGztdyn0zO2F5eabciNmn+zVOd5vhFLI7px0d+vj1mNJ2dtZWdBxwiUyRED
         6j/lRCHsnb+2to1E2zfllQ8U1KlpL/UpWB6RP6jx+eZgoAD7idqiDdbMTGP+a9796GUQ
         LCmO6NewnTI5Rl9HQRewV4Q13zHTZ7FcEbQ/2nqnpHCQ1ZBPANgIvGdtUOlbDwVTUILw
         Q96LgSuw9O5IJEDNjtjpYIuvYJbg2o8RJvP8wVlnBmWz8d9iCtlk91lC7mwdesVDu+sH
         Ytcj6kdMv5L2v0getaoNANIXbm1VSyDkzYyA438iybUm5/IyI49VGbxOro0i7Pv1DFh+
         9Cnw==
X-Gm-Message-State: AJIora8IcOe/Un2MT3bruE4QDnqd33HdkgV+Q6rPrWlFIwZ2uaeKsUOe
        xM9LsfZ/KhdNQLcp5Nauy+Okbg==
X-Google-Smtp-Source: AGRyM1vBfSGHeJKr39L7bBI0Wp641fmclQNLEE0MJMll9iNLLlO+JE+GUgn5SMqOlb0/rNJ9hdKpRw==
X-Received: by 2002:a9d:754a:0:b0:616:bd96:a37e with SMTP id b10-20020a9d754a000000b00616bd96a37emr5265514otl.325.1656630668992;
        Thu, 30 Jun 2022 16:11:08 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n2-20020a4aa7c2000000b00420c4e021e8sm11439551oom.38.2022.06.30.16.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:11:08 -0700 (PDT)
Date:   Thu, 30 Jun 2022 18:11:06 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/3] input: add event codes for user programmable switch
 events
Message-ID: <Yr4timTL6mBlik0m@builder.lan>
References: <20220516142158.1612109-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516142158.1612109-1-caleb@connolly.tech>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16 May 09:22 CDT 2022, Caleb Connolly wrote:

> Add SW_PROG{1,2,3,4} for device switches which are handled by userspace.
> 
> This can be used for devices with "generic" switches which are intended
> to be user-programmable, for example OnePlus phones contain a tri-state
> key which can be used for switching between mute/vibrate/ring, or
> programmed by the user to perform any arbitrary actions.
> 
> These are analogous to the keys KEY_PROG{1,2,3,4} found on some
> keyboards.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>

This looks reasonable to me.

Dmitry, what do you think?

Regards,
Bjorn

> ---
> See the next patch in this series for an example usecase.
> ---
>  include/linux/mod_devicetable.h        | 2 +-
>  include/uapi/linux/input-event-codes.h | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 5da5d990ff58..45364fbeaaf7 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -326,7 +326,7 @@ struct pcmcia_device_id {
>  #define INPUT_DEVICE_ID_LED_MAX		0x0f
>  #define INPUT_DEVICE_ID_SND_MAX		0x07
>  #define INPUT_DEVICE_ID_FF_MAX		0x7f
> -#define INPUT_DEVICE_ID_SW_MAX		0x10
> +#define INPUT_DEVICE_ID_SW_MAX		0x14
>  #define INPUT_DEVICE_ID_PROP_MAX	0x1f
> 
>  #define INPUT_DEVICE_ID_MATCH_BUS	1
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index dff8e7f17074..339153886a13 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -917,7 +917,11 @@
>  #define SW_MUTE_DEVICE		0x0e  /* set = device disabled */
>  #define SW_PEN_INSERTED		0x0f  /* set = pen inserted */
>  #define SW_MACHINE_COVER	0x10  /* set = cover closed */
> -#define SW_MAX			0x10
> +#define SW_PROG1		0x11  /* set = program 1 (user defined) */
> +#define SW_PROG2		0x12  /* set = program 2 (user defined) */
> +#define SW_PROG3		0x13  /* set = program 3 (user defined) */
> +#define SW_PROG4		0x14  /* set = program 4 (user defined) */
> +#define SW_MAX			0x14
>  #define SW_CNT			(SW_MAX+1)
> 
>  /*
> --
> 2.36.1
> 
> 
