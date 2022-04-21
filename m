Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC58050A594
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiDUQeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiDUQdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:33:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40B54990A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:29:11 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so3788723wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=vrEs/2pEILP9d1ISDp34/8wtCsJViJ6D/+Hs3vTnWsI=;
        b=kiRnNazcdTuefZZxff/Lv7MqYKxC82ka2qvvv0JcQaQ5eXgb3C1Td1A6Yjqd9oSHjW
         cMbnQC3KtAdteb6sdIvj+QXOwx4ornXjnKbeU5vSxw0jCC17VrGZfmOrM4sXwlVVndEH
         JPAKQS8ZxSqC6VQv1Z9KYKx9e6oAIIg3+US9C7QWCuam4Z+S244I7ecKXVgyO9+PsZvW
         esjoVzMxM+KA87KPOtThU5FRSN9h4WqEZXzc7y2IlFAi9oejv6HKiIsgCkuGcnDbUzeV
         qWmJ6gqtGwT9I3hN8m64D4R4cyImSkG161BjeGoRFRYFJOzDk+XHe3yAisQDlDb7PhdY
         Xa9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=vrEs/2pEILP9d1ISDp34/8wtCsJViJ6D/+Hs3vTnWsI=;
        b=GLGqAxitR+/xm/7/w6Hx8Gmt1XgykhTQCtFxgpHAgewYKIbTDPZ3FlSDSnbRtVFMmK
         RcDI1ZAHNFTR9hZCA2UW14GJfQsoOpVsenkzPTg84Qo8xhMv5tH5xIgNh/vg9hN6o+AP
         95GFw/UDRCqYj9BXMUtWyvmVTeulkqaIzYYPlIxYiJVBA8G0sJkKPPSL8013GYyih/XE
         EB/7/2bF1L9eNs43WBj/cN9rcPaD4zhfj0ddGpg09ybyhBw9T+gQUHTt3A9n4Z+dnok7
         KN/TT19gACoJiaGMrTpSfx0LViqmGuFjyeJX2lxk+W97oXG08mRGJlsv3Aab3/v9TWSH
         LKdw==
X-Gm-Message-State: AOAM533jXD3QLRiAENsoSKQ3xWSJ8TT+MgnQFvk16TkQluuEfbGOTo7d
        OXz6qUHRWXQGwLIJBEz5xbKwyg==
X-Google-Smtp-Source: ABdhPJyQaNKtS9rLLBu7H6jeDjbWV36SMhQuTvDDlstfthSmDE74vKvCmC4ESH0lxl25edccn/nitw==
X-Received: by 2002:a05:600c:a06:b0:37b:fdd8:4f8 with SMTP id z6-20020a05600c0a0600b0037bfdd804f8mr9664089wmp.41.1650558550287;
        Thu, 21 Apr 2022 09:29:10 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm2576235wmb.48.2022.04.21.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 09:29:09 -0700 (PDT)
References: <20220421155725.2589089-1-narmstrong@baylibre.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH 1/2] Revert "ASoC: meson: axg-tdm-interface: manage
 formatters in trigger"
Date:   Thu, 21 Apr 2022 18:17:02 +0200
In-reply-to: <20220421155725.2589089-1-narmstrong@baylibre.com>
Message-ID: <1jwnfixuwc.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 21 Apr 2022 at 17:57, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This reverts commit bf5e4887eeddb48480568466536aa08ec7f179a5 because
> the following and required commit e138233e56e9829e65b6293887063a1a3ccb2d68
> causes the following system crash when using audio:
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:282
>
> Reported-by: Dmitry Shmidt <dimitrysh@google.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

For both:
Acked-by: Jerome Brunet <jbrunet@baylibre.com>

The main reason for the this was to be able to configure the start order
between the DPCM Backend and Frontend. Only the trigger() callback has
that capability for now.

This HW require the BE to start before FE, otherwise channels get randomly
shifted in the output stream if there is more than 2 slots on the link,
mainly on the capture path.

This HW require mutexes to handle the TDM formatters (because it uses
the CCF API). This why I moved to non-atomic to use trigger(),
forgetting that doing so would make period_elapsed() take a mutex from
the IRQ ... :/

To properly fix this, I'll need to extend ASoC so the prepare() callback
BE/FE call order can also be configured.

