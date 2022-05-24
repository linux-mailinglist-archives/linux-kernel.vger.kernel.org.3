Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A25532408
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbiEXH1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiEXH1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:27:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE421FCF0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:01 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 39C473F1D3
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653377220;
        bh=shKDtZWbPRAYSxVbqGScFYHLBdbSbIz7UNIH95Lp9To=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=bl+cK1RZRTxQbyr2+hZsgoUV+PH5NxaoyA5VwrFp52DbYo1vzoXGUPlAq6XDTxsci
         gXHxJUBYQhbLUCfzEIJVHhVdoNiXi7U7VS+72Emq/OhUMO/auh8WGSDPBRgkHd78wp
         SBFNHUKBCHVHKFOTOqCFRDltm5C9MZu3TdcJhOPJPhL1zzibFJizYMzp81KbnTlmXQ
         TvPXgghNR5i6xiUEgucF21dqjykjD7LyydmGMQhnhow81oYaS3U2mtEG/16lLELDKy
         i+KkcwlnHR4jyjmp37h4szKFGTFxkZmYyDFH1CWJqVn/7KIZNXksriExTL4x4rKEng
         cLIoDTKsvjj5w==
Received: by mail-ed1-f71.google.com with SMTP id g10-20020a056402180a00b0042ab515d6c5so12053930edy.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=shKDtZWbPRAYSxVbqGScFYHLBdbSbIz7UNIH95Lp9To=;
        b=W4WusxkKyRLAqvJlqoAOedJReHt8FddvKci5G0rjR4jhvwQ4K/CVCMEQPAoM4dd02c
         7j0N1lmenLXzhxxgbdxP+6M4L/5JVdfuzqV/bToqLEbl9iulvQhYspUp2FLlYGEYHJsv
         sBFPmh/OXgNkbzaga93Cy83CX2oHw7gs4Wx6NnMleYZGh2RIk5Tg/8ndXo8kP3WXTIVX
         sIyRgysFqxvLHBp7fB9zVRTpujdYI/NzH6DjYciNyjXlHIYBWSGGu+YkI4PBgIrfcJIh
         /jA2qcrm4ZJOju+AYFFymVlLOhqcdrrLSZb4Wi/m4P15t9JaZhadVBA+Plo1Hj6d4lfo
         tvAQ==
X-Gm-Message-State: AOAM532yS5OXh5s1z1q34QDkHzTpT51Z0roSEIifM8FrmpDEQC/mrgF9
        GX4xThxqqUA8NjFB7/mpOMjTCXgmrzbz0/ciHv1fbrGUwMloB8wSiiLHMnfK0/5N4GdaZn9kxtr
        BoNtWpUg6+FFKjbGhQEhO+mK96RGqM0qhGAh8Ktq9zA==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr22247273ejc.112.1653377219988;
        Tue, 24 May 2022 00:26:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT1vbxy1UAwwOsUFCu5M24qz9FKj3AUytk4VHpaciYfk2Y1MKhvLkbrk4yzFOCN+HMs8SrGQ==
X-Received: by 2002:a17:907:948c:b0:6f5:183f:eb6 with SMTP id dm12-20020a170907948c00b006f5183f0eb6mr22247262ejc.112.1653377219832;
        Tue, 24 May 2022 00:26:59 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b006f3ef214dd2sm6924353ejw.56.2022.05.24.00.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:26:59 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     ysato@users.sourceforge.jp, uclinux-h8-devel@lists.sourceforge.jp
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH 0/2] h8300: Kconfig: Style cleanups
Date:   Tue, 24 May 2022 09:26:54 +0200
Message-Id: <20220524072656.20152-1-juergh@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The majority of the Kconfig files use a single tab for basic indentation
and a single tab followed by two whitespaces for help text indentation.
Fix the lines that don't follow this convention.

Juerg Haefliger (2):
  h8300: Kconfig: Fix indentation
  h8300: Kconfig.cpu: Fix indentation

 arch/h8300/Kconfig     | 4 ++--
 arch/h8300/Kconfig.cpu | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.32.0

