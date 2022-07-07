Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F26569798
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbiGGBez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiGGBeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:34:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B32ED52;
        Wed,  6 Jul 2022 18:34:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r21so1116873eju.0;
        Wed, 06 Jul 2022 18:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxCHo3D2L32inESDJabeEycZy5m5Rdh810cC6pQMdqg=;
        b=lXe42GuO+U3rvvDUgyDolERy+GX5kuHYPenOR5YAaY8kQVA5TgDf74QJgSzGQjcQmh
         b0Bg2ypORQA1YzUlSIYNl8oy5A+w3F81uOWmycK8SDj3gnP9msEIf/6+UEg19OL+njUP
         0nF0D5JTeq5mm3GJcNeujyOnJzOQRYAE+l3YqbtpmrjNtvDZaDrM/ImM/rXPCFMlrWDA
         bW7RESGDrGilt7/oxP1lgChVS+w8WdORQ08I5VOUm6LjGOxu4iOE8eHWF2xYjZ7PvfUg
         rnVEibIDGUguxdJhbmNdTF/QEKeemvdHvQ/qBYb58PQL63/cbi1KjfZOWuSQp4h4gIsP
         2NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxCHo3D2L32inESDJabeEycZy5m5Rdh810cC6pQMdqg=;
        b=kfQpX55nUcm5HiQldMOPGp+w9TvEQ+wTdg+os3AAPlSBM1uFGu/edlTmQAqX9LYWCT
         KgD0acVaw9dBt0svj9xt2P4ZBtzTDh/6i/6jtH1xcogUlKp7cJ6krjZznYsjctraN7dH
         1DDX60CCgxJCPpGNyzo/FaM3cPECriudhbLu+nD+Wwl9nOgubBCwUdAFT3mqwgYAvk15
         Wu/tJffXO3T9XOaarEtB21PUjn0JgtNX9yvER8jt1YH3+/mQO2gicBfy74icVDgt4Leh
         isG+v85TZWaUjvhHn85JCC4SfW4YIX+5uowWhJgGdMZNIyc43acWZhn3RnptsC0HM7dF
         4pxQ==
X-Gm-Message-State: AJIora82mLvN7CqaUkBl1wE99UEUsaEUximw0XN3xupfqYQOxOBl1W16
        /BS27CtZtLq9vYsoHexeJJw=
X-Google-Smtp-Source: AGRyM1vLn9O7eoZ+Cej98u6DZUfP47Y9OMjZBn0mq4R5YaMvFqEsnTUqz1Ubsp1h48W3/2oruFWZYg==
X-Received: by 2002:a17:906:938a:b0:726:942a:54e8 with SMTP id l10-20020a170906938a00b00726942a54e8mr42270914ejx.225.1657157687071;
        Wed, 06 Jul 2022 18:34:47 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e19-20020a1709061e9300b00726f520bba0sm11822195ejj.216.2022.07.06.18.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:34:46 -0700 (PDT)
Message-ID: <62c63836.1c69fb81.e0cab.44fa@mx.google.com>
X-Google-Original-Message-ID: <YsY4NSThwDk04VYU@Ansuel-xps.>
Date:   Thu, 7 Jul 2022 03:34:45 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH v2 8/8] ARM: dts: qcom: add speedbin efuse nvmem binding
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
 <20220707010943.20857-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707010943.20857-9-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 03:09:42AM +0200, Christian Marangi wrote:
> Add speedbin efuse nvmem binding needed for the opp table for the CPU
> freqs.
> 

Slipped while fixing commit description, pls ignore. Sorry.

-- 
	Ansuel
