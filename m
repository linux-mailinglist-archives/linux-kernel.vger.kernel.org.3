Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0305152B345
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiERHYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiERHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:24:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4BB4D9CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:23:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u27so515196wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tF/YGASfOyaH8iI5vv3uSJNrq2Gg87HO0wZHDFyPngk=;
        b=RG9tkY0SlpJCC4fUyPDBYyPxc1bnRxdq9yhw1UbK4P0ZWnyS49MbdRzXriqpHINzhg
         QB1s8sAKM5MrBJ2M+GOs8vTMSMfcTia4GuWHEjdPj+lj83iWaGO686JHHKdsEu+moN/S
         MoDOlYHmHlEuU18sVUuboGdeJJQsihjlQSoYroG8sVf4fJKqMLfhnmpksK1oFzMHCNtr
         wAvYxKXJR5Hs5sJoG3HHUsOJ5klf7Na/hNv8+QVci/I/C/FcdBB6Jr7Jfrj6uRYVfXr1
         D3YBFwtWVHjsvv6EYzSBbn6vNgzhLCtKReBZvWyNCNi7sYGyKHl1Tq29PhaTYEZaCDxf
         XeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tF/YGASfOyaH8iI5vv3uSJNrq2Gg87HO0wZHDFyPngk=;
        b=rV+XRJGUJZJp69p13UoF+8QAJk9rauYZeznzx4wQ0as0gaxgcp2KhQU/jbjW45cztq
         I76fM2vAB37iAEcgmxA4E7uF4/epdXQDgS5q827/awvHkqTmRAPmnWB2QUbt8doVQRJp
         p8KlEdK7UiSHy0ioLsg24no3hAx40lT0aTdNMuqD2z5oSkS2uOw2ukNsWPkzPZpexDGl
         v74rIU36WBl3gOjPheO8ykwkzKb8rgvEjP4LJDO5Sq4rFujJiPlJ93Tb/sfrE1BvmQUp
         8zYEQxnC8bkDFjomlYB7MzGULNqaasNMgHQmP1z/LmTNrezi7HzmjjUzRYZ1o1JILEg2
         1HVg==
X-Gm-Message-State: AOAM531ajJQ4CdCj+wyzJg7PMwbL48aJnjEFDhVdxI5XXsKfRhrSKQaB
        zMc8tyw2URRTg0Fevv6q0HwgI6Aei5wUKMZV
X-Google-Smtp-Source: ABdhPJwD/OM2Sk3G/iloBGcUeXj5wnTIB9bygC4e5ck1U/lgfHV5xDqpe3z/o37CfegDOS5NY6oiMA==
X-Received: by 2002:a05:6000:1d90:b0:20c:9efd:bd6b with SMTP id bk16-20020a0560001d9000b0020c9efdbd6bmr22300308wrb.605.1652858637676;
        Wed, 18 May 2022 00:23:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:dea9:338d:d500:c574])
        by smtp.gmail.com with ESMTPSA id e2-20020adfa742000000b0020d0b2de858sm1112113wrd.33.2022.05.18.00.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 00:23:57 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Dongjin Kim <tobetter@gmail.com>,
        Furkan Kardame <f.kardame@manjaro.org>
Subject: Re: [PATCH] drm/meson: add YUV422 output support
Date:   Wed, 18 May 2022 09:23:53 +0200
Message-Id: <165285860562.1281822.12934298648827697620.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516072245.10745-1-christianshewitt@gmail.com>
References: <20220516072245.10745-1-christianshewitt@gmail.com>
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

On Mon, 16 May 2022 07:22:45 +0000, Christian Hewitt wrote:
> From: Dongjin Kim <tobetter@gmail.com>
> 
> Support YUV422 output from the Amlogic Meson SoC VPU to the HDMI
> controller. Without this YUV422 format out of the HDMI encoder
> leads to using the dw-hdmi YUV444 to YUV422 color conversion which
> gives wrong colors and a green line on the left edge of the screen.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: add YUV422 output support
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c193a003dc46ae601f46908b41d6f485b87db1ad

-- 
Neil
