Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D985B505DC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347263AbiDRSCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiDRSCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:02:18 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C635249
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:59:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 38-20020a17090a09a900b001cb95d9ea46so9030093pjo.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vhWzWD0c06OV0aukljkj0PRAdTdjkN73lYC7OTBumvk=;
        b=TQbDokN3lq+qdZxam2TPeuTaXZ9+SEtwcvSVupju3yeggyb5ZcCUdNcWVeI9EifUsy
         A45oEQITmVblS9/19nN10sbzqNSqLTCKXK99nQbVlqX4KCWDj0eQ2iVaIXfd4yIMgWZQ
         h0vIli370QtN2a1Na+GTx4a2ZelbmUEtLkwqLhowKMCOBEVA1bz3W409U3JJYZ+0xmIk
         Eg8kghWqV7LI08pf82ZXpmoDfL0rfZRIxO+kUDcG0k9fIzra0r2+pJH0UfSqLs+nxVRN
         lLkXk8/Y14knw3nySUUP7aeX1U++V/f1GSw0uUJWQ1rEPNBdhng1fIb3/seQEmUV6GgR
         DMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vhWzWD0c06OV0aukljkj0PRAdTdjkN73lYC7OTBumvk=;
        b=ygvtk30Vs30sW9PDKd5rhaj1/Gs09iX7pi3l4ElTZmfIOsiy/s9zhyDxuS1oVU/8zt
         wGTn/CXoLxx6Kt9nPcKdorjf+Oqp8yhrbbMfkrKkVMmgG9lvq7Rnsvz2qMCeSR6KBvwJ
         HlomEcEKqe1kgAn6icQ0X85HUmfFNfxDwUOE60LZSmmZenF5qROC6elcx8RJghtuW37D
         7oCTpw1lUOwh+TIM7FLe0mMxKsgZZ23k8vZEZYsGoM2IeV0/sdgsx/iANsnMshVBtUeH
         GczoUShD77VP1VFvcmHmO3jDjwF1NLuuqVuiayfgqOmnVEGgXQ7hNQ1NlpwR4rS3ZbUq
         HEmw==
X-Gm-Message-State: AOAM532cF666/FEn2obdRgrdhTueYk/ASTSl511so+jMUx4+4+lgbvkJ
        drS0FjAzKCWX4cPV8yPifiWe1ftE46Lyvg==
X-Google-Smtp-Source: ABdhPJzWA97X0aRLo3oE+yWfJZyF6GWEv9k7Aug6u1Hjs2uzJwbuPs/WPufO7X8EmLmszuUEyzJU/yDKMhNHGw==
X-Received: from wonchungspecialist.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1440])
 (user=wonchung job=sendgmr) by 2002:a17:902:e881:b0:159:828:b6dd with SMTP id
 w1-20020a170902e88100b001590828b6ddmr3139776plg.127.1650304778564; Mon, 18
 Apr 2022 10:59:38 -0700 (PDT)
Date:   Mon, 18 Apr 2022 17:59:30 +0000
Message-Id: <20220418175932.1809770-1-wonchung@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 0/2] thunderbolt: Link USB4 ports to their USB Type-C connectors
From:   Won Chung <wonchung@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Won Chung <wonchung@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, USB port is linked to Type C connector, using the component
framework, if they share the same _PLD fields from ACPI table. Type C
port-mapper searches for devices with the same _PLD values, and
aggregate them as components.

When there is another device that share the same _PLD but does not
registers a component, Type C connector (component master) would never
be bound due to a component match entry device without a component
registered. There exists some cases where USB4 port also shares the same
_PLD with USB port and Type C connector, so we need to register a
component for USB4 ports too, linking USB4 port with Type C connector.
Otherwise, link between USB port and Type C connector would not
work either.

Due to the nature of the component framework, all registered components
are shared by all component match despite the relevance. MEI subsystems
also use the component framework to bind to i915 driver, which try to
match components registered by USB ports and USB4 ports. This can be
problematic since MEI assumes that there is a driver bound to the
component device, while USB4 port does not bind to any drivers. MEI's
component match callback functions should handle such case to avoid NULL
pointer dereference when USB4 port registers a component.

In summary this patch series
1. Fixes MEI subsystem's component match callbacks to handle a component
device without any driver bound
2. Registers a component for USB4 ports to link them to Type C
connectors, similar to USB ports.

Heikki Krogerus (1):
  thunderbolt: Link USB4 ports to their USB Type-C connectors

Won Chung (1):
  misc/mei: Add NULL check to component match callback functions

 .../ABI/testing/sysfs-bus-thunderbolt         | 10 +++++
 drivers/misc/mei/hdcp/mei_hdcp.c              |  2 +-
 drivers/misc/mei/pxp/mei_pxp.c                |  2 +-
 drivers/thunderbolt/usb4_port.c               | 38 +++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.36.0.rc0.470.gd361397f0d-goog

