Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A734F1093
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 10:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377920AbiDDIOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344077AbiDDIOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:14:34 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831992FFDC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 01:12:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b19so13165093wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KUYaNEQe34m5nOz7Zxkxlzwl60Qyx6SmSc4/ZeE2sI=;
        b=OyiZylLrN5ZiRuFLVbMbZYHLj62zDMwd2urabqGZzwATM7FAHvAyaauPvXzCW9PJhb
         f1km0830T1d9mjpXHyTEAHFYJk5BN/4k/zao0wNtp7iQT20ds3gTulXnyu2Zxt8t+fjT
         BLpkk1BTvubc36HStJVXNBMSby+H/BDr8xBMF8mwUUd/s94CZNNUcmN4ZNo7vW7Dm0YE
         RHxZhbRha6RmbjFfafonVkpicxA0srIBbZO8cKhXdmw1KsS4DR9j5JuHEWVmi7CiJp2c
         GImq1qIJnZOz+Lh/eQMIgzgT6dUG2/f+Iw7lnBBTkPgpsVI47RA1r+WhK50c/0vEw9pH
         Vh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KUYaNEQe34m5nOz7Zxkxlzwl60Qyx6SmSc4/ZeE2sI=;
        b=wQfwZiEEEUJA2UnzwLRtjdnJfimAqVC+4Z3Fj0AvJit5PdXfvhANCFONdKbZcfcGZZ
         ipxm0SCvTbvjJBH3/Kyk+JNyqI8DgbsE5w1/jFJpU6wFfRBe5gur8IfuR2DNu6+LAXhO
         zWDPav+3R513Sa42+L6LqBB7FB8F+bSLD7RcOViSucHcTzmmrWIACcnbvOyem4vw+zFo
         /qcbyadmK6PY5Mz2xDJHLo6eoab8b9xKaagWwTz6EG53Gb3WgVutAwBNEQMzJB72hw0D
         1Nb/IXwjWLYqsoapYrmLU/+fJBvFMMC5UEvevBJBPQX08h6gP3NPqHOZwYcq31DGCFWu
         XdwA==
X-Gm-Message-State: AOAM533C334NbxFW7G9aDTGdjFrKp9n37jwWltv6qCMgsoegs16rkFPR
        ODcBhrPFQBRLNfC8Mi4qbOVThg==
X-Google-Smtp-Source: ABdhPJw3MtEPc84beBjhrO06hI241G1wbvcyCar+JXX7Es91MBpaPzSHy40gU1H09PqfvpRlqi9Ayw==
X-Received: by 2002:a05:6000:1a86:b0:205:a82d:4769 with SMTP id f6-20020a0560001a8600b00205a82d4769mr15816745wry.424.1649059956978;
        Mon, 04 Apr 2022 01:12:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1add:1b28:2457:eb46])
        by smtp.gmail.com with ESMTPSA id s12-20020a7bc38c000000b0038e708d163dsm3297510wmj.0.2022.04.04.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 01:12:36 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Qianggui Song <qianggui.song@amlogic.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson-s4: add gpio_intc node
Date:   Mon,  4 Apr 2022 10:12:32 +0200
Message-Id: <164905994877.1805420.15536867817056125438.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310092645.4303-1-qianggui.song@amlogic.com>
References: <20220310092645.4303-1-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 10 Mar 2022 17:26:45 +0800, Qianggui Song wrote:
> Add gpio interrupt controller node
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt64)

[1/1] arm64: dts: meson-s4: add gpio_intc node
      https://git.kernel.org/amlogic/c/393633936976fb8bd2c26ae76fa8d30822bb7fee

-- 
Neil
