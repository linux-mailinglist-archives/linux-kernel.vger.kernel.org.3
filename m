Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325035AE63E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiIFLMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiIFLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:11:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0F7859A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:11:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h1so6673858wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=G22FTacdNp/5st4PWx8yeyzweiOddCK7/04ygNQp0N0=;
        b=vB3qVosKKn+313MmCONMnAnc+rOAx2mVl9gmu4Oev03Ob1lqLo+2VpKJjBTJUO6fZ4
         Kcck2Q3R+4TbCXGFM5Ad15yivpBTdhLcQkPB9hdhwROVzKTN+SbSgruhvov375WAyD3h
         bxC+CFprcOXuvc4LKI32y6IDsXKD3G2levQoFfTpkO/WDMVDPBVQi6X3RR8iBtOU4Rdw
         Y4oVCIXDodJnJmIQ2SBcRU8XgSXu6Zo+6voGbr0TNhN8hJ8Egg5sgmxYvTBe5/ipjtbW
         /9i8APrHIJDqAzArmH/cp6NG6Jz/Ey+Xw7wQgseNG4yRjNsdZt/1U9bh1Ehm9FISqw0i
         carg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=G22FTacdNp/5st4PWx8yeyzweiOddCK7/04ygNQp0N0=;
        b=siTlUZO1KLZoT/mlbXaK1bbmaTAf9cReXlin/6mZdQRd+plAP7g84G4IpW/z7R2XCd
         ipIIKcepEd9zIbaPxox6wv5xewLgWSbv5Ha0QJcP+vFEwUuMZ2lJrXHyfDzeZNqk5yaf
         gI/z8/NkSsGr2W0dsmxhs2DcIZSbMVoNrB2dYMNxTTIPHTqEB8owC1jkjVNTd9HaSr1W
         nhCBNtf/nb88KHjuPZ6RxedPhm0oYU11Yzhkz9FPosa8eLCIZZq0ePAE5tdWGMP92HzW
         KoQrK+vppJjZkxYKsvKjVj03h5iLWu18EyOLnrzyuEWSL2osNbal8sjCy51PEfVfqqhe
         ghCw==
X-Gm-Message-State: ACgBeo0y7FsuisCYJ8N9e1w+ji5oL6IRwadz73AeOUkWa5+SEG4uval/
        dCNyMCK2ivu1P4gBXEESRYQLxQ==
X-Google-Smtp-Source: AA6agR7voJKZZcbQSCcq+9ZNRdGFJfjhieUYCaSI0ZPybs7lhYpqyA6Yk8tXADCmfxRYQ68zSyk14A==
X-Received: by 2002:a05:600c:4caa:b0:3a5:4a14:854a with SMTP id g42-20020a05600c4caa00b003a54a14854amr13635552wmp.107.1662462713945;
        Tue, 06 Sep 2022 04:11:53 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b14-20020a056000054e00b002252ec781f7sm12154902wrf.8.2022.09.06.04.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 04:11:53 -0700 (PDT)
Date:   Tue, 6 Sep 2022 14:11:51 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH v9 2/2] MAINTAINERS: Update fastrpc documentation file
 from txt to yaml
Message-ID: <Yxcq9xQFmpsTlqC4@linaro.org>
References: <20220906103055.2089519-1-abel.vesa@linaro.org>
 <20220906103055.2089519-2-abel.vesa@linaro.org>
 <872bffe6-416e-0d15-5994-0cf80c2063b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872bffe6-416e-0d15-5994-0cf80c2063b4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-06 12:57:58, Krzysztof Kozlowski wrote:
> On 06/09/2022 12:30, Abel Vesa wrote:
> > The documentation for fastrpc bingings is now YAML. So update the
> > MAINTAINERS file.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Abel, I sent you two messages about this patch that it is not
> bisectable. You did not respond to them, regarding maintainers entry, so
> I don't know what to think.

Hmm, for some reason I thought the MAINTAINERS file update needs to go through a
different tree.

Sorry for the missunderstanding.

Will squash it then.

> 
> This must be squashed.
> 
> Best regards,
> Krzysztof
