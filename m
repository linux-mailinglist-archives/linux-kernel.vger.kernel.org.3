Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86354FC6B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiDKV0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiDKV0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:26:39 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7611C1B;
        Mon, 11 Apr 2022 14:24:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so28905409lfa.6;
        Mon, 11 Apr 2022 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W07LTDRQTymKjPFZm77aBEtSzK9heBCBPkTFYPnHBGQ=;
        b=D8N5US+NdVQZMy2EJ5v7Xz6ZD9q6Hd5yAEmkIT4EjBlI0MaZvgipuDjOLIecaMhXEY
         EPVbV7avstzga0x2QyLBumJ/04DfAUQSdyj3v5SXyvrkb0s8Gcq4t3qDiKy1AVAwny81
         A993XTEO/cta909Ukxl4q/I11MBtdqzEmTc5DIG/lG1CikSYsOoo33+h5yfriq2u18Ss
         Cor/q+sD/AOxpslaUcgNiimjWsOtmflglBAD7ztg2QG/HCml5nmZ1/DmXDzvZr6/eB3B
         hPSpxGSZ6Az6UwlvRlUuN3Nr4jzHfUmmTlwgrd/TNsCDZysrXgwMHElqz+nV23MAxEmC
         xLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W07LTDRQTymKjPFZm77aBEtSzK9heBCBPkTFYPnHBGQ=;
        b=ti+8Mc6L+Je3nmpqqCt3byVNLb/6tggF6eMp4LG/533PzPkBgfmqZBXY8q2dkI4OC+
         RDEq/n4EaoMOPVI6tbzItxMkT6rFkxPFeCj0y2Gi/mqzr/3rFMlHMVMIA8vdh+XTb7EI
         Ml8Y3kgsNsOAw91ibBlpkuehVyIp2QSLXmNeIAE+z0UQObT8nvOvusYRtCL6JPJJRG3C
         SwCwbZ039AHk+asXWIp6/g19V1xe4LAAsfAJUnjbBDXqlNNrEJdVEmdtKQfjgfONgSJR
         2IQsORtFV53LgmdwNVtVfN5GkfZNsTmVpYZha5DDje9SBLmkGCk8wEKR+8t05eNCsbb4
         o+Sw==
X-Gm-Message-State: AOAM532zr4jwkBByQQqj+TQFqdeLJlVQvDFzpvg+yvcLzn1n9IRVJQjf
        7CadpWt2eU+7l07D1tuvGFI=
X-Google-Smtp-Source: ABdhPJw1EDfVylJkSFMhb+KePBf/A0pmLkpS8KaCP2Pczay4AqN39f+VBLDlVnKx/RkXKgLfQXkupw==
X-Received: by 2002:a05:6512:2292:b0:46b:a65c:91b9 with SMTP id f18-20020a056512229200b0046ba65c91b9mr4597915lfu.663.1649712261053;
        Mon, 11 Apr 2022 14:24:21 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id w10-20020a2e9bca000000b0024b598ff427sm830391ljj.73.2022.04.11.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 14:24:20 -0700 (PDT)
Date:   Tue, 12 Apr 2022 00:24:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Brad Larson <brad@pensando.io>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: arm: add Pensando boards
Message-ID: <20220411212418.44p3dvqiez4romqz@mobilestation>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-2-brad@pensando.io>
 <05febd3f-bfdb-13c2-8cce-b9dc422c5eae@linaro.org>
 <CAK9rFnyRrS_LvoZ_j66cKDHgecqcqzJN5krSxdCquBanViKyHg@mail.gmail.com>
 <49c1d200-8c07-b306-a400-86ee6a637bb4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49c1d200-8c07-b306-a400-86ee6a637bb4@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 12:39:59PM +0200, Krzysztof Kozlowski wrote:
> On 09/04/2022 04:19, Brad Larson wrote:
> > On Thu, Apr 7, 2022 at 11:45 AM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>> Change from V3:
> >>> - Add description and board compatible
> >>
> >> That's a bit confusing... the subject is for v1.
> > 
> > Goal was to identify in the cover letter patch the key changes from
> > the V3 patchset to this V4 patchset.  Then in each patch that had a
> > material change highlight that in the patch itself.  Will try and make
> > it more clear.
> 

> This is fine, I am talking about the subject - it is marked as a v1, so
> it's confusing to see a changelog.
> 
> One way to achieve this is: "git format-patch -v4 -11 ..."

v2 was submitted by Brad one year ago:
https://patches.linaro.org/project/linux-spi/cover/20210329015938.20316-1-brad@pensando.io/
most likely he has just forgotten to add the proper suffix.

-Sergey

> 
> Best regards,
> Krzysztof
