Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148FE52B340
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiERHYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiERHYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:24:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1964D9C5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:24:00 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k126so597779wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4huS1qwBfiQNftZ7pKsoc9bDCoDHvonAE+NZgu2h6c=;
        b=mycV6ZeRycT/wvEF8CfEOMQzj0VfQb3FGo7c12/Ep8ZqxNC4W2svH+pgfN95xKMgYn
         ufrTLl0vwd5hh4bNSD4f6D/Vz+7AxvTj30OA+7XweZrp2C4RhRSterHoxVAZWAJYBhgY
         rsjDHCcMqzCUYWv0q8ULwqSsrXHSySBgleLvoys/Zl7q1FfRHe9N/w10jsIcdG4Vws/V
         usqVnzRcc63YChfLUXpXTGnKI2/WeOSz7iVMTsJ+wQv0Qn4gXepNahyFUMLCI7JH1gKo
         hx4TIbFBZpbcUvE50tpbuJ55KIBSpddZfxc5LNrl+9ghRAqus9Ps4s8HHdyDXgTa3ht5
         DZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4huS1qwBfiQNftZ7pKsoc9bDCoDHvonAE+NZgu2h6c=;
        b=41Pz7U8GF7Gqs49M46u2VGD0QXVDqJopv1hWICMppSV6X719wpoUJQgHi25KKJjGjD
         Y6805m9Ckesl367lizZusg+9yr8xxSb7PmXwAqVERColWG2sUuVcGRhz9+eGjp903hNM
         OMjZrjV89T7N6E22aKCToTbiiHgH0CQeysJgGjcckN9rt7jPyngvIGUlSwB18rP+ssZG
         KlllUSyuIvcdiTkET8JJHM8GQ38SfUJYWPa1FT/bGnva3eOgOwND/JffSWQQ1XQoMCC8
         kgP3s7Xo/Ldih/zBR2qBx3SGBGrG2lF3v2D6MZGlbdVUvbkecKDlJD9jq+GvqSNwsOkG
         9WqQ==
X-Gm-Message-State: AOAM531GSLuxs61PbvJ6AWV4DJ/w7frl0Pmj/UgJ+QuMHfKbduAIemJt
        DFWXoS2nmi/rzA5M+8qam5mC6w==
X-Google-Smtp-Source: ABdhPJxFJIKOj6RpfneFWB//eZ12oKA+Q0wI6It3Ms/9Bkk+MKHxerFLHNbKUh8rG8+aOHrrGwmJ9A==
X-Received: by 2002:a1c:4b14:0:b0:394:2ece:c049 with SMTP id y20-20020a1c4b14000000b003942ecec049mr36055344wma.158.1652858638809;
        Wed, 18 May 2022 00:23:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:dea9:338d:d500:c574])
        by smtp.gmail.com with ESMTPSA id e2-20020adfa742000000b0020d0b2de858sm1112113wrd.33.2022.05.18.00.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 00:23:58 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org, Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        David Airlie <airlied@linux.ie>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
Date:   Wed, 18 May 2022 09:23:54 +0200
Message-Id: <165285860562.1281822.5287516325245345657.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511054052.51981-1-linmq006@gmail.com>
References: <20220511054052.51981-1-linmq006@gmail.com>
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

On Wed, 11 May 2022 09:40:51 +0400, Miaoqian Lin wrote:
> of_find_device_by_node() takes reference, we should use put_device()
> to release it when not need anymore.
> Add missing put_device() in error path to avoid refcount
> leak.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/meson: Fix refcount leak in meson_encoder_hdmi_init
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=7381076809586528e2a812a709e2758916318a99

-- 
Neil
