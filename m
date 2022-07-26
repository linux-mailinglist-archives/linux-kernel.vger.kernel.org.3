Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C401581818
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiGZRIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiGZRIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:08:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5198A14D02
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:07:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h9so21076786wrm.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqEbmzhKx0NMjg0VvinCoPEfypWpQp7BkQaC0Xs8ciA=;
        b=NhvjhaDnJnixTK5JKS13CF/cGWT95PlYz5ESq87WVqMG6WDROqjbUK6xqAdGJULCpz
         mZAEIbbjJbwrPzrktT3T+hs2SojuMjASB5/5RaZoK38FRiqIXI9nm4IqEXTYfpBUQxtF
         OPtgT59X4RnD04NW5HDTK6tYnDxxB2LsL5xk2MnnjXPyXCal1tupwafaj+/mzZ6Fj9W/
         JfPOIe+myCgsz1tzJGLmJmP3pdNNjuat7gTHpEFrvR0In+IQ2op4pUbfhe/IF2sD+2gR
         IfxFyDXvhZ3ePvPndTkPjf9k+OU+nebEjUnlZWBsRDd2q5POSB7gmnFOjIdy0UhQpO3n
         T4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DqEbmzhKx0NMjg0VvinCoPEfypWpQp7BkQaC0Xs8ciA=;
        b=TdS/EfqFoRFpXcQJahPE6F1QOwJ7RVfyE84e5Jl0O07AL5Hzgux+tJ+gV+iySJQZeX
         ii1AkTQvX7NdBb6//Oi2rrSNbiJte/vcVkRj/JTbIayBEuDJLjaD+U7hUZah9pwkSTo/
         D6vf6Tcm+siBapKuO9F0Dly+eriQ+5EHufJU7guR54AsE1otLKnW8+vILK9NkPmWmKsh
         DedQRcUFOc+EiLXR2Cv0zSDxpNuFx9pyZLza0Te1wCiiBLAFInnSAJbQJbR7b3KDoBuI
         /ubG+rzxZhQN6bEvzvp3Xr3GOcqu4rcHfYQbri8nj1oBif8TMaMHAbsYZ42lBoTIMzNb
         vukQ==
X-Gm-Message-State: AJIora+guLYx+ID1qeB4ARBpno2hqkiI2v9OwsLRGqsdgUEH8vs2/Hm4
        4Gmlh5MnHffUZlh8L7AG09hxHA==
X-Google-Smtp-Source: AGRyM1ujJrahHNmwiwz/mBnF/zHJW0mN4KLDNf4jcWEuw6EW0rtMpqQBl3Uq7RHHGJqWG90H0YU3xw==
X-Received: by 2002:adf:e193:0:b0:21e:626c:d082 with SMTP id az19-20020adfe193000000b0021e626cd082mr11227518wrb.159.1658855276724;
        Tue, 26 Jul 2022 10:07:56 -0700 (PDT)
Received: from henark71.. ([109.76.124.168])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d52d1000000b0021d68a504cbsm14859618wrv.94.2022.07.26.10.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:07:55 -0700 (PDT)
From:   Conor Dooley <mail@conchuod.ie>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atul Khare <atulkhare@rivosinc.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Fix SiFive dt-schema errors
Date:   Tue, 26 Jul 2022 18:07:24 +0100
Message-Id: <20220726170725.3245278-1-mail@conchuod.ie>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hi all,
As these are the last remaining dtbs_check warnings for the default
riscv defconfig I am reviving the series. Atul has been hit by some
hardware issues so has not had a chance to send an applicable version
of these patches. All I have done here is rebase on linux-next, so by
the time the merge window reopens it will hopefully apply..

On Atul's V2, Rob had a comment about changing the cache-sets in the
patch 1/2:
There is not any way to express power of 2, so you have to list values.
Rather than just adding 1 more value, I would add at least a few more so
we're not adding these one by one. This is for a specific cache
implementation, so it can't really be *any* power of 2. Designs have
some limits or physics does. /endquote

I don't think that there's value in speculatively adding values to this
enum especially as (I think at least) the scala for this cache IP has
been released publicly:
https://github.com/sifive/block-inclusivecache-sifive/blob/master/design/craft/inclusivecache/src/Parameters.scala#L32

The two compatibles in the file match only against two specific cache
implemenations: the fu540's & the fu740's. I would seem to me that, it
would be better to lock this to a single value per compatible since the
1024 applies to the fu540 & the new value of 2048 applies only to the
fu740.

I have not made that change, I simply wanted to repackage this series
in a way that could be more easily applied & restart the discussion.

Thanks,
Conor.

Atul Khare (2):
  dt-bindings: sifive: add cache-set value of 2048
  dt-bindings: sifive: add gpio-line-names

 Documentation/devicetree/bindings/gpio/sifive,gpio.yaml      | 4 ++++
 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)


base-commit: 058affafc65a74cf54499fb578b66ad0b18f939b
-- 
2.37.1

