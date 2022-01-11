Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2148A437
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 01:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiAKAQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 19:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242685AbiAKAQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 19:16:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D06C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 16:16:22 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso2673958pjg.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 16:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:from:date:subject:to:cc;
        bh=RXbgYQuhy+HAtohgMpCvhNrYOo86LBqxSJ6LSA+CYko=;
        b=lZilM5t9I6BxxLEVSWWIXV4BOAjVn1VsP7QkuuQNgIwGB1jZP2x7cdg+PjkwAvV0iR
         Qh5fhHgRamyVvNODTnjNhRWCrup8ZbPiYVotBxX717wpOUVH8HkbplJyfMHWkLn9NW3L
         B16H6WC+Vc5R+5CcND1hwq3A7ybQCf+sdgxwiNADBh/NDY44NCvlnQgrFQtXv7AZPLNP
         5DruaqQir2RB+ib+qvSIA2Ny/iSgJnVPvk90Kko+wus9g6lR40aL8igeelGoRYJVg479
         uEHicHEKCb5oEh641FGggFZQ2I4N0sA4Av7BzKK9Uf3XlKqZuYH8n7dTEdjK3agejVjk
         G3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:to:cc;
        bh=RXbgYQuhy+HAtohgMpCvhNrYOo86LBqxSJ6LSA+CYko=;
        b=Ebwi+cs1Nea2MRy5/7uTKPvHlE9YUV1Vkz7ztvMeZZNCoSNbJ0kNA6QhvP2YVyN55c
         dUWvlk7GYTF/RQkg4KSpG6yiMBRoa2ZnA9gHOQIGYn+JcknRgdfPn6qh+T1yMjOIUjCI
         2PzgcoBTr9+/Kj1iW8M1xEAITNu9zhsf90Y2E9+q7DrH8/BbaxuGZpKwYZFXHRM4YZW4
         FrtUEy+VPDzjsBQvl9SRKTaGyPYSQG2RyonZtUxlUjWDNuFOyYqCVgiHwoYGboKvVDUP
         xEVPjT/Aw5fZ1PGwhI6QOfvBdsn/7yVWEU/HcsyP514lZRT7oN5Og31VRLcizYdtShY1
         69DQ==
X-Gm-Message-State: AOAM530B1r/J8Pke5F13OqoL9TdgF3tVuVAjHhcUE4f2GktPg6l0j49W
        ifzAoBmunNgLpM5VCgyo90Zf90aLbdYFmdPP
X-Google-Smtp-Source: ABdhPJyx9U1ERclB311uUhn7B8cDyDV4IsIkutwp13YRPkqVKOBbirk/QdGbzFxVh74rek+hIz8M2w==
X-Received: by 2002:a17:902:be15:b0:149:a608:7098 with SMTP id r21-20020a170902be1500b00149a6087098mr1959506pls.63.1641860181723;
        Mon, 10 Jan 2022 16:16:21 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id n15sm168063pjj.12.2022.01.10.16.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 16:16:21 -0800 (PST)
Message-ID: <61dccc55.1c69fb81.77e64.0d94@mx.google.com>
From:   Daniel Beer <daniel.beer@igorinstitute.com>
Date:   Tue, 11 Jan 2022 13:11:34 +1300
Subject: [PATCH 0/2] ASoC: add support for TAS5805M digital amplifier
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Liu <andy-liu@ti.com>,
        Daniel Beer <daniel.beer@igorinstitute.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of patches implements support for the TAS5805M class D audio
amplifier. This driver, and the example configuration in the device-tree
file, were originally based on a 4.19 series kernel and have been
modified very slightly from the tested version (digital_mute has been
replaced with mute_stream, and the new IS_ENABLED macro is used).

Daniel Beer (2):
  ASoC: add support for TAS5805M digital amplifier
  ASoC: dt-bindings: add bindings for TI TAS5805M.

 .../devicetree/bindings/sound/tas5805m.yaml   | 201 +++++++
 sound/soc/codecs/Kconfig                      |   9 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/tas5805m.c                   | 534 ++++++++++++++++++
 4 files changed, 746 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5805m.yaml
 create mode 100644 sound/soc/codecs/tas5805m.c

-- 
2.30.2

