Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09895A6785
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiH3PfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiH3PfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 11:35:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCDC1C105;
        Tue, 30 Aug 2022 08:35:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m7so7137117lfq.8;
        Tue, 30 Aug 2022 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=8CZDm+Rx5pWirtBbG6z1Askq14xihhKzy8697kobm8Y=;
        b=YYbnFlTpKq5abMWPJiqxB9eZnai3g92csfa92BL6vjrXdIXwPrYG6tE4Wy2TKCg1l0
         I6GZC1qB8eBHJkftfwlnuXQn8M6kWKj8g1aVIUe7iShZpiAJNAP2Vx7RGsehynricOkB
         PI/cVoFcKSkU8voN3hPAe+muuoA519oYhsQe9tCH4DAHlxcS/TaLPBeO78iPQFE2OLQS
         i0zbfR18bxim0sJk4wgiUhnFHt5R8q2MZYdD4DKHbzYytqL3arH/i7RssulbS/QRHuJQ
         QA+AO5+U6BEBuNuUkzYUlKhT7Wh8RMsWUHnFbL3dWbBRpEMT0MarvwTn7U/vB1uIQ4TI
         rrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=8CZDm+Rx5pWirtBbG6z1Askq14xihhKzy8697kobm8Y=;
        b=tkAdpTmIJ/XifRi00yfcM/3W9HuLyNTPPnSrUZdz34jOJ46kLSf4FxAy4S7KPzGwbJ
         HeUdefOgcu5sXJsfagZ/Cx3nFvGjVtdXXwu/f2DZeZb/Z7Z/pKaYyEbkx0JAilFw5O2L
         82S1rG+wIgAYtSvOmqcd0llFo4KMl4GQqG85+KlDGJTCtV5en79aBZB7kPa9N6f/hZHD
         R4gMfmf6eOeIBIMxI0ali56ik9WEWusivSGog0fvC+YQCbxRb+XA55n2/7QgOsxPDse0
         HfFyPcskVtUJxYpAYoDAgu8uVW2BSN41N00jWEwrPGVaV0VjmPyWlv7Gtl84+wfslSs7
         Xq4w==
X-Gm-Message-State: ACgBeo0FcOjjYzeVvoqxQOB3Nbg1W3RvjZOG8gGp3y3+RC04IWfChxmw
        tG/8n3Feb7kTCIc2UAkfh+e6Aw0MRJBeGw==
X-Google-Smtp-Source: AA6agR4ExSlbec7qBnBfFEYvJAiDQyfz44r18jMrVkn3VL2AfoKRIVo4CKmar/de40oMm9/tPx+qNg==
X-Received: by 2002:a05:6512:1087:b0:492:e36c:d6c6 with SMTP id j7-20020a056512108700b00492e36cd6c6mr7454982lfg.502.1661873707631;
        Tue, 30 Aug 2022 08:35:07 -0700 (PDT)
Received: from ubuntu.armcompdev.pub.tds.tieto.com ([89.46.86.70])
        by smtp.gmail.com with ESMTPSA id h1-20020a05651c124100b0026181a42284sm1315165ljh.88.2022.08.30.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:35:07 -0700 (PDT)
Date:   Tue, 30 Aug 2022 15:35:00 +0000
From:   Marek Bykowski <marek.bykowski@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] of/fdt: Don't calculate initrd_start from the DT if
 'linux,initrd-end' is 0
Message-ID: <20220830153500.49206b5a@ubuntu.armcompdev.pub.tds.tieto.com>
In-Reply-To: <CAL_JsqKGgZOSdWQ2ithipvrRAYwt-vOL1z9-RM++-_h6pA=C_Q@mail.gmail.com>
References: <20220826220017.188066-1-marek.bykowski@gmail.com>
        <CAL_JsqKGgZOSdWQ2ithipvrRAYwt-vOL1z9-RM++-_h6pA=C_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Aug 2022 20:12:41 -0500
Rob Herring <robh+dt@kernel.org> wrote:

> 
> Shouldn't we just check that start < end?
> 
> Can we check this somewhere not DT specific (and also not arch
> specific)? Then we don't have to worry if any other method of setting
> initrd could have the same error.

Yes, we can switch from checking on the end being 0 to that proposed:
- if (!end)
-     return;
+ if (start >= end)
+     return;

Then the check would even go further as would also catch cases where
end < start.

My taking is early_init_dt_scan_chosen() that sets initrd size
incorrectly is DT specific but generic/arch agnostic. So that if
the error got introduced by a bootloader/U-Boot through the DT
chosen node, we should catch it in DT and react.

ARM64, for example, before going down for mapping for the incorrect
address (some extra large address resulting from the negative to
positive value conversion), has a check after DT parsing if
phys_initrd_size is other than 0 to proceed, and it is so that it
passes or in other words it doesn't catch the error.

Marek
