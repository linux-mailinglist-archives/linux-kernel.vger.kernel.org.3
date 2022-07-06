Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF836568586
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiGFK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiGFK2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:28:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E965B26541;
        Wed,  6 Jul 2022 03:27:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sb34so26247468ejc.11;
        Wed, 06 Jul 2022 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrf7eRxXaX9GHkQGDtqblfgAf3cTIp7nBk4kt/XYpbg=;
        b=l7zVez+bUSMxXQaNR1Jwjnqj0xNlULk790ESjdcfTxECiQs524tPYiv6NOTnP8HFFK
         2rpdiKj9/9Qg5RdbT5fqjkpvMpxp5wqKS+oltGIKXZql/Ohi8Xn3GsZ0zLDP/zD7CZLi
         homJqMQ8jw+97uG8LR2fVniAP5lWRerCeYC1X/UtegI+LQtG16r6snCzaRXICBKoX2WE
         svoVAT9OCHPMvuea1wcnLaRbSPlogMYm2NBDt2/xilC4Lnn90Si41uodWVVhAyD3TjXO
         A6d1foj/NNK9kFRICm38ssz6KdNmb92C0HhkN9+cz9hhG/AX40wThidvLFl9tibhflIh
         VUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrf7eRxXaX9GHkQGDtqblfgAf3cTIp7nBk4kt/XYpbg=;
        b=JNjI8iym7Q8r0zq60vpZXdn7YHQ4sYFYRo9ASWGBj2BUpGfmEUhL632IIXgp2kg1Hd
         B5zCcep962xj58xENU9Z1VJRM1f1bbc4p4YNUT9rOPMR/P/Jq76prm/PmWiqCxc1ZdKw
         P4ytU+hReKq+Jn01V6mpphiwmFxdFZd+IG2oyX3VVGnDpCKWItCSmdkGLMvWiEnNqSsA
         oQOUaKVs5fdyRhyOTtclw0X3FjqVlC/U7AWMhzbQALLWvJyiu5Z+E1ZTf7ertwkmeSqQ
         rL/rAHEgTn2Ld+dQ2FSgBL5vsjgr+vEUsl8ySVd4UZjewnDXx5ByurmiN+Osw3zBtqdV
         lkNA==
X-Gm-Message-State: AJIora+vNN+2xSGlxRCrYW6XHBVI0zg84/ANd3fkyTtf4o11N8o3KoWA
        3rdm0GAbPTp+ivbIGOPC7l4=
X-Google-Smtp-Source: AGRyM1uV8klfxOZtkNXehCupH/7CcG+HJ+DinCI0tfrbaOf1C+ligau7apYkgHDeKVHe75F7rB+6gQ==
X-Received: by 2002:a17:906:4fc6:b0:722:e739:53cb with SMTP id i6-20020a1709064fc600b00722e73953cbmr38557664ejw.128.1657103277374;
        Wed, 06 Jul 2022 03:27:57 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906505100b006fece722508sm17109947ejk.135.2022.07.06.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:27:56 -0700 (PDT)
Message-ID: <62c563ac.1c69fb81.d3170.dfa4@mx.google.com>
X-Google-Original-Message-ID: <YsVfyMySheM7+0TP@Ansuel-xps.>
Date:   Wed, 6 Jul 2022 12:11:20 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan McDowell <noodles@earth.li>
Subject: Re: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for
 ipq8064-rb3011
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-5-ansuelsmth@gmail.com>
 <ad7b4082-fe79-3f01-eaa6-b9809a55aac3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7b4082-fe79-3f01-eaa6-b9809a55aac3@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:34:50AM +0200, Krzysztof Kozlowski wrote:
> On 05/07/2022 15:39, Christian Marangi wrote:
> > Mikrotik RB3011 have a special configuration where the regulators are
> > not the common smb208 controlled by RPM but they use a TPS563900
> > controlled via i2c. Disable the smb208 for this specific device.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > Reviewed-by: Jonathan McDowell <noodles@earth.li>
> > Tested-by: Jonathan McDowell <noodles@earth.li>
> 
> This is the first version of patchset. How did the Rb/Tb tags appear?
> 
> Best regards,
> Krzysztof

Will add in the cover letter where this comes from. Didn't add this as
this series contains less patch and other changes than the prev series
but now I will do so we know where these tags comes from.

-- 
	Ansuel
