Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E302753FEBF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbiFGM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiFGM1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:27:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0BAD56
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:27:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u8so19605478wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnS9eZBppnZjRJEyPEWcwbc8qEUGNcbl9p3ctix2mdQ=;
        b=Jszx/Wi26USE9TtJWbMiiHrtAozvWbXe9c3sHzU7LSgZNED7VOPVQmXwkicOV9u6RT
         /wX0EMV6B19rD42E+0GzJ6YUnQgc9DtniJ9Ixff4M5oRQaw6rRM51B98kwscnMTjT45H
         T1ip3clG3PHk1wh/HVieVEzlNf6lvK/ZJLhgGgXinrM8DG/lLmsccix1OgrMV7rpbjwj
         9VHRhqjYrBRaihvRnR4fRqqZJ5YakE5G5kG9N6vKLWiVfRzcqowm9zISNFFko0nLesv5
         IHNF5f+8hQyLleVlNdc/9rHU0RCoZco/GincvPZJbvVltgITdRm2u2ts7cIL1ePL5QJT
         CopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnS9eZBppnZjRJEyPEWcwbc8qEUGNcbl9p3ctix2mdQ=;
        b=gcmqv4zKkMnzaFyE+HZY//VoXh8MKCitusjwXmXX49EatkuoplZvTA70rhUuo3cX6m
         71aaS2vkzfsN0I1JhHqdUn6zrC8/2eEJdLVjeib9nTHvI5DRMk2TvG5Ir4z/NsOfV6M5
         OlR4uKtNuH5eDWPouGbZDAjenC6fHhyz2YqhGbomi3DtoCXU0MFsDPnlcahX77/1YomE
         1V6x+zabKGQfelZZf0FxZ6ufpYH0eILsS2R4eGbk52EYFnMzPz4wkAabV+y5DNU9vyMa
         kup0maewo25pMvkKLLGVE3VXxm/DvSaRh/xwzzGOJRucWCxO5pAvP1dn1kMqrCVF1DrX
         RIEA==
X-Gm-Message-State: AOAM532tLvXjLA0+bspV0YLk4e8UGfd8Q7f2UQCEsYk+JwR8S5CfGcdw
        nFte2GUN65gNhidhHbDIV4yQog==
X-Google-Smtp-Source: ABdhPJz39mrIrz65dmQlmcX3m/aOeY5/aTHzZPbMkd34nx5R2i8IAXjv1ymugad1I8spt3xpgUJJcQ==
X-Received: by 2002:a5d:6483:0:b0:20f:d046:6382 with SMTP id o3-20020a5d6483000000b0020fd0466382mr27123834wri.342.1654604834197;
        Tue, 07 Jun 2022 05:27:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:87c5:1f51:1550:2ebc])
        by smtp.gmail.com with ESMTPSA id 186-20020a1c19c3000000b0039c4ec6fdacsm6553533wmz.40.2022.06.07.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:27:13 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org, Miaoqian Lin <linmq006@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 0/2] drm/meson: Fix refcount leak
Date:   Tue,  7 Jun 2022 14:27:11 +0200
Message-Id: <165460481589.1168988.17623464252935400226.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601033927.47814-1-linmq006@gmail.com>
References: <20220601033927.47814-1-linmq006@gmail.com>
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

On Wed, 1 Jun 2022 07:39:25 +0400, Miaoqian Lin wrote:
> The following patchset fix two refcount leak bugs.
> The cause of the bugs are missing of_node_put()
> after of_graph_get_remote_node().
> 
> changes in v2:
> - patch#2:Fixed patch in meson_encoder_hdmi_init, call of_node_put()
>   after of_find_device_by_node() and error paths before that.
>   noted by Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/2] drm/meson: encoder_cvbs: Fix refcount leak in meson_encoder_cvbs_init
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=7d255ddbbf679aa47e041cbf68520fd985ed2279
[2/2] drm/meson: encoder_hdmi: Fix refcount leak in meson_encoder_hdmi_init
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=d82a5a4aae9d0203234737caed1bf470aa317568

-- 
Neil
