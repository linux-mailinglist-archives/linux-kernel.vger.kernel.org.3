Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352235B0FC0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiIGWTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIGWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:19:08 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C37DA74D1;
        Wed,  7 Sep 2022 15:19:07 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j17so11549078qtp.12;
        Wed, 07 Sep 2022 15:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=g5BXvyyoRCIgsReMPkjX53sa1oRrOY6KLwL7WymMjiA=;
        b=OpCQdVbI+ZMb4UMDXOG+3jnDJkPyTNTvyI3xz64n3AaAuWFPToZu3P2MwahnImM4x0
         ImZF0PXvQ+cf3wMyJdGHsFcxnc5xjmgWkElz64/BhPJmrdTscvcwxnx4gIfMd3YZt3+b
         l9SPOAR8AGU7ss2kPX54slDhKafeoMkNA+wQ1lvMgZn7DVrv8MP7lN9F3T/LDFFFOoS/
         PXNiH0qL3ZG4wXrxY2gRHPLfxca/4qRMyiB/O5W639uwBGZB/br/S85VNWkV2MQyzHHv
         VklFDIAzbXepK+GrUIqJCYtbGXA/UUY3hai6PAxwiUVX8SVu0HdopyyupgdWDRrpaAXC
         n8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=g5BXvyyoRCIgsReMPkjX53sa1oRrOY6KLwL7WymMjiA=;
        b=E7BU+ldjrlpcn10Hvu978/LauPaz1GRM84WV86BNqynwhuBiLm7PQ49c/PrEz62o15
         FN113k29ogPBRuZMjSU5R1uRpJnuKwuC7n1PkQPcAXduCF+qFR3e7TzCtRDf31YVNpUg
         crPGZzRMy08KPnKUZJlke8iPMqzyqL+PbOBOLhmIB4tmiNcI8jniomzWC3bY1hcoHDpN
         3vQAKTSM5CkU/raclFVIK6+6FFWir318eykMG6OlEc1aYLOhlhyZnfZz58mnM/VB2hQq
         9czUwj186K/DBbQl0YdoX34/IuK4wKgRVbQZ5h7Q1narB468Sia2SZWij9jGsj1xRoQl
         /yIA==
X-Gm-Message-State: ACgBeo1nV2tjylAd7bxbx+zOdcE2Ju0UZaxV3iePeKI4RaJZdgRxchQW
        tX7ijYuENK5JJb1rv00/TTn8MsGk/G4=
X-Google-Smtp-Source: AA6agR6Qfk0zI+RqDXBOTYdUPL3FaLm85b07XqeNvOJfBGEokYtcCZAGPv222eM6G72hjOQsew2ubw==
X-Received: by 2002:ac8:7c44:0:b0:344:5653:df43 with SMTP id o4-20020ac87c44000000b003445653df43mr5305055qtv.359.1662589146661;
        Wed, 07 Sep 2022 15:19:06 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4aff])
        by smtp.gmail.com with UTF8SMTPSA id e5-20020ac80105000000b00342b7e4241fsm13583504qtg.77.2022.09.07.15.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 15:19:06 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     robh@kernel.org
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, caleb@connolly.tech,
        jo@jsfamily.in, Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
Date:   Wed,  7 Sep 2022 18:18:33 -0400
Message-Id: <20220907221832.136715-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220907175300.GA3779566-robh@kernel.org>
References: <20220907175300.GA3779566-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You just changed the clocks from 5 to 3. Please test your changes:

Right. I'll make sure to set up CI locally before my next series.

> What you want here I think is 'minItems: 3' and then restrict the clocks 
> to 3 or 5 in the if/then schema.

Yes, thanks for directing me. I found what I needed in
Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml.
