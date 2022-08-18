Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CDB598364
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244711AbiHRMqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiHRMqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:46:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76295EDD4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660826790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0hgk5ZZHKuX8lnQA8p46Sj63fPkeFC8iuqEyWiwfa0=;
        b=Pgjm30f+ZrbQDiGa4wdUdFLGPlZtgPLpPJzsufp1NICdbxH/DkB5taBzqdqdqkH2oPcY0w
        XmKmRbW6gZS4vTR9S0QdTj2uj0eJ59WH/pVNo5PP6rNdRaMFWiza/NO0MfXd10+iRlNezg
        Lz0ouUwG26ZLpEOo8VY8bTMbGJuVOAQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-O8YenrXGNFepmpah2LMHPw-1; Thu, 18 Aug 2022 08:46:29 -0400
X-MC-Unique: O8YenrXGNFepmpah2LMHPw-1
Received: by mail-pj1-f71.google.com with SMTP id t10-20020a17090a4e4a00b001fab2c791dcso977718pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/0hgk5ZZHKuX8lnQA8p46Sj63fPkeFC8iuqEyWiwfa0=;
        b=ssxkGWtw3GJPfTQqIFfeCuxUmV5Che8db5u28P4TkjEl1GNQVz4RtnuhjIwPoDYsbv
         w+twJ/iNtV4uPO/g7Gqgk2BrjXsy7R5sV0WoCDNhQ433qs2V0U8fHHSHfMYaxOxDAfmD
         0LuLrzPdkTH0/PR73Qw2L4ckpUwqOfZ5dSFaEFWbrtjiAtlsdOHdSnCR0RmXP/+nKAzJ
         q01BSvjK7wIo2sL5kgC33hYkEPn+Ku5UzECLMmg4kMzCWdiWsqI5zq9ysHLO3fAaIUWU
         TVOoBn3u2nk48V3QEm8W0U6aOKP+D2Ik8HDtiX3A5G+g7dx4TXRbuN9Mu5NML5sMGjEh
         2JRw==
X-Gm-Message-State: ACgBeo0dM5jKHq1l9+j7QNIxcQEilJ35/Audf6tKTXsWMfQeBs/7+LDL
        wMkOVgX2tf06CrKT03mFKCLB3YlRtIHtRviEqscRgWkYXzXa03VxZm3wX/9heNw/t1cAwyVYX9v
        u5jWEiFx1iO2UP5nikqQ1ul/X
X-Received: by 2002:a63:e348:0:b0:41b:444f:ff5f with SMTP id o8-20020a63e348000000b0041b444fff5fmr2274673pgj.333.1660826788624;
        Thu, 18 Aug 2022 05:46:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6lGnUPcCxmlc8exuoQJXfXctG3A34swT/87OOrV3UStb1MANlk6xi+njtUm5mXcwCVHbDX6w==
X-Received: by 2002:a63:e348:0:b0:41b:444f:ff5f with SMTP id o8-20020a63e348000000b0041b444fff5fmr2274658pgj.333.1660826788340;
        Thu, 18 Aug 2022 05:46:28 -0700 (PDT)
Received: from halaneylaptop ([2600:1700:1ff0:d0e0::1e])
        by smtp.gmail.com with ESMTPSA id b1-20020a170903228100b001714c36a6e7sm1302339plh.284.2022.08.18.05.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:46:27 -0700 (PDT)
Date:   Thu, 18 Aug 2022 07:46:25 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: thinkpad-x13s: Fix firmware location
Message-ID: <20220818124625.nfwrcostfqxs7ym5@halaneylaptop>
References: <20220817231236.3971-1-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817231236.3971-1-steev@kali.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 06:12:36PM -0500, Steev Klimaszewski wrote:
> The firmware for the Lenovo Thinkpad X13s has been submitted, accepted
> and merged upstream, so update to the correct path.
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>

Matches what I see in linux-firmware! Thanks Steev.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 84dc92dda0b8..e07cc9d1ff27 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -235,13 +235,13 @@ keyboard@68 {
>  };
>  
>  &remoteproc_adsp {
> -	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
> +	firmware-name = "qcom/LENOVO/21BX/qcadsp8280.mbn";
>  
>  	status = "okay";
>  };
>  
>  &remoteproc_nsp0 {
> -	firmware-name = "qcom/sc8280xp/qccdsp8280.mbn";
> +	firmware-name = "qcom/LENOVO/21BX/qccdsp8280.mbn";
>  
>  	status = "okay";
>  };
> -- 
> 2.34.1
> 

