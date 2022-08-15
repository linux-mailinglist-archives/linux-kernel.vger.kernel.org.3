Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4F593391
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 18:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiHOQw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 12:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiHOQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 12:52:02 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113DD255B9;
        Mon, 15 Aug 2022 09:52:00 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id h4so5871655qtj.11;
        Mon, 15 Aug 2022 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Pp4w1wvXBL8J84CnOzUJib5hp7Pj7DVn3pgQNVAcZ6A=;
        b=T7cM+oC0OxACPn8xuk9weuFEfLAfWNUhlJNU3viU8oAcwVjJOr2erKXnfq4X1W2nnY
         R2Bbchnb4ysphSz/MPI30iay5n+0+f72X+f941/pfkm/EmfqYkN1O1kRxTMpso0u5HMX
         v0zygoGbRSiuxEiDbal8xhgq8diEvPPRdanCsHdz11NaMhBZxe4R/nwFEcFzSXqmFY36
         phipKQ6JA6W+NIgr7AJk4G5vpfmyRHskmOPUkXkYZEaIsATD7K+bu5klU+ENp85aLKlv
         ruXgebLoCsk5+5G9+sj7nT2ZCmmnbPCRBwCmgkTiIZ2femK3sM1rkyasImVRkZ50K9iv
         SXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Pp4w1wvXBL8J84CnOzUJib5hp7Pj7DVn3pgQNVAcZ6A=;
        b=3H4yKfD+Icd3zyf49TM9WpYyjqVayUoHs5FPz4KakvS0v7+x/IK5eki29MX9pVck5r
         wq3BzJlkRcZfWr9FW5oBLyk4P94MAhW4Gvwtv17tGO5SGe47NaDTBCjmfv+vD2I6ghJn
         LIxqKP1u3SDzd7jmA+MdTnGXZ6HQLJ+1zaWfsFci7r4tj7XpmRbNa9o/gzOBza1wGDYX
         eGUdFmeduqD+o09L80HRgRe61CDRsnn/oNM+ed38hUkPDTqpYlfZe5qDqWyG6mW17g/r
         pJh/fy3OHx/9wHN3jlX1RIzNpPi+t1+j0o/wNMY3XCkC8pTa3fw7AB5cvEf4kp+G6q9a
         3Nvw==
X-Gm-Message-State: ACgBeo2td86zpX5kvCtLKf/4vpXF158BzsqpOuMshI3oWrYHVCuPKfMl
        UzXIc/BjFHXY+XZgX8G3jQy/UhAdsM8=
X-Google-Smtp-Source: AA6agR6y6q1BePEBYTRmOmlA0Y95fq0R9xct4H6UhvHP1q2QmEQk/RhJV5mhdGwRaBZyNmdK+AogpA==
X-Received: by 2002:ac8:4e49:0:b0:343:620e:fd53 with SMTP id e9-20020ac84e49000000b00343620efd53mr15309877qtw.71.1660582319124;
        Mon, 15 Aug 2022 09:51:59 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id az14-20020a05620a170e00b006b627d42616sm9424905qkb.35.2022.08.15.09.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 09:51:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        krzysztof.kozlowski@linaro.org, rafal@milecki.pl,
        Anand Gore <anand.gore@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] arm64: dts: Add BCM4908 generic board dts
Date:   Mon, 15 Aug 2022 09:51:55 -0700
Message-Id: <20220815165155.2501002-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803175455.47638-6-william.zhang@broadcom.com>
References: <20220803175455.47638-1-william.zhang@broadcom.com> <20220803175455.47638-6-william.zhang@broadcom.com>
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

On Wed,  3 Aug 2022 10:54:51 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add generic bare bone bcm94908.dts file to support any 4908 based
> design. It supports cpu subsystem, memory and an uart console. This can
> be useful for board bring-up and cpu subsystem and memory related kernel
> test as well.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
