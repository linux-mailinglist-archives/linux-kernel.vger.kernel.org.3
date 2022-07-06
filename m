Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF25685B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbiGFKhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiGFKhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:37:19 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEF82717B;
        Wed,  6 Jul 2022 03:37:18 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id sb34so26289953ejc.11;
        Wed, 06 Jul 2022 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=MdRqT9TlKdwtrSOPprK+WxAXXd6G2UIUMtOdNMZWkdg=;
        b=kUYGi0zyaBVHlWyW2J/RjJbjDeIvRLSOl1zOC96AGnE90aip4WIhWrH3IF+8Ngfa6s
         m+hVdOWs3loi+YVcBnxcJsSddoM8Ad8FfSiJEjTT1j/LgZ62Syhtxx9GsGdSaSizpUmO
         YQY1O1D386wLK3mgr7bqOGVABn6kvLYRsjbLk7am351BOTHd7k9wouiHeDZbIdx2aqYd
         Q+1uPAnYne6cG9i0a6rdbjhK+pwadpBzYVWEkRKpG66NU3D72tCYbQCrLBI8+ju/m6ja
         +mXn0Hid725+tgu6EG14lS1ThkbyxNckigH3OsStHi9Tyu8p1oYkIlixA5teJY6L1ksW
         2z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=MdRqT9TlKdwtrSOPprK+WxAXXd6G2UIUMtOdNMZWkdg=;
        b=m7tmm9p+hzgX0RGsgkmSWeLIM//B3mZuDSLmh2mevhXzjMvakFMAYZk5pmL8UybOnb
         Y5wxEtP75Qy5gwnp3gioBWE7TqZZzcOUwKq8ej7H4h477joi/NFkxYod9ZbpPNk8SZYy
         uKktt9PsZODz6wxBvIPRjcPxF6XWxpB0ys4WFBf8bJZukm8BeA4gdIZ1LEAoUWJXcWRV
         k3uvhX375Tb4eKWhqXebJVBg5AmYj4ut6xYrQqYW9sUSAVhe/QZYGJxrrKji24DDrOYF
         3stilLuB7+MwRH8gCG7bXPShAjROCYY/cPBn3XIl6Vmpb1wauadQpY/66aEwr4tAO/HX
         zDTQ==
X-Gm-Message-State: AJIora/wg2W5kspFVKBxpa/P8ppB/kQoPsHGgrjCQVCuT3bm/r2ZZqtQ
        RCu4EnZKQOQ/2nfcVXW/6r8=
X-Google-Smtp-Source: AGRyM1tAarnBTiCdC/ZPJSTY7R7C2gOasl5h7rc83XMHrb1C7HWHD3j5JXHa5OWdynIt1UhhJ6BSqA==
X-Received: by 2002:a17:907:2d9e:b0:726:a03a:16c4 with SMTP id gt30-20020a1709072d9e00b00726a03a16c4mr36829048ejc.742.1657103837343;
        Wed, 06 Jul 2022 03:37:17 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090637d300b006ff0b457cdasm17319454ejc.53.2022.07.06.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:37:16 -0700 (PDT)
Message-ID: <62c565dc.1c69fb81.a4566.e9b2@mx.google.com>
X-Google-Original-Message-ID: <YsVh+AKZ/ZAshXzt@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:20:40 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: DTS: qcom: fix dtbs_check warning with new
 rpmcc clocks
References: <20220705202837.667-1-ansuelsmth@gmail.com>
 <20220705202837.667-3-ansuelsmth@gmail.com>
 <18e40247-7151-b50a-97fe-00ee88f47d9b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18e40247-7151-b50a-97fe-00ee88f47d9b@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 09:44:04AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 22:28, Christian Marangi wrote:
> > Fix dtbs_check warning for new rpmcc Documentation changes and add the
> > required clocks.
> 
> There is no warning in the kernel, right? So the commit is not correct.
>

Oh ok, the warning is generated by the new Documentation.

> Only the second part of your sentence applies, but you should extend it.
> 

Ok will reword this.

> 
> 
> Best regards,
> Krzysztof

-- 
	Ansuel
