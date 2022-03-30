Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7616D4EBC20
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbiC3HxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244029AbiC3HxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:53:19 -0400
X-Greylist: delayed 969 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 00:51:32 PDT
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [IPv6:2a02:9e0:8000::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1AC0D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=Uluet/jX37T1xgs3caJvnu+3kL5bR9aXLM+3qwz3Ut0=;
        b=BGbLA8eKyyGd5yvbXSXEXi7rFMNNWKsKsVh0R5+JnpGLnT90jck/dj5i24O1TDJ8JeVRcoCykqQDq
         d40Selw91O0Xaq+4JAhb3aRvpAiQoSy48l6Ms2l8tc0POdQ7Z+wP22m+3aby7rAHOmqUx5IZuat15S
         d/9YpgrKjE96LFgN++FuuDhwRBPuIo2eWu5mhazvJSQ9uWCBoXN3lFFVDjHnO1DveF6EwsR9LjTACZ
         eG+zmdPmUITUNw8QDEIcQUE/AE4Y/AnOKR5yg8CBbiXdz8LgYBk2Iql207xawxxPrHTPuuRDqg/Oq5
         I7ARFhrv4NZzwixB76dBkEgWIDIc5wQ==
X-MSG-ID: f2076e64-affb-11ec-b450-0050569d3a82
From:   David Jander <david@protonic.nl>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Jander <david@protonic.nl>
Subject: [PATCH 0/2] drivers: auxdisplay: ht16k33.c: Add option to refuse claiming primary fb
Date:   Wed, 30 Mar 2022 09:34:38 +0200
Message-Id: <20220330073440.3986724-1-david@protonic.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case there is also a display with a frame-buffer device, the probe
order of the auxdisplay fb and the main fb is not predictable, possibly
leading to the situation where the holtek auxdisplay becomes /dev/fb0.
This is problematic because there is currently no way to automatically
rename these devices, and too much user-space software that assumes fb0
to be the main display.
In such a situation, adding "holtek,refuse-primary-fb" to the DT, the
auxdisplay driver returns -EPROBE_DEFER to wait for the primary fb device
to get probed first.

David Jander (2):
  drivers: auxdisplay: ht16k33.c: Add option to refuse claiming primary
    fb
  dt-bindings: auxdisplay: holtek,ht16k33.yaml: Add
    holtek,refuse-primary-fb

 .../devicetree/bindings/auxdisplay/holtek,ht16k33.yaml    | 3 +++
 drivers/auxdisplay/ht16k33.c                              | 8 ++++++++
 2 files changed, 11 insertions(+)

-- 
2.32.0

