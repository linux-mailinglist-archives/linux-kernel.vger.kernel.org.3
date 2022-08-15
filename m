Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C50592AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiHOHrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 03:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiHOHrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:47:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1029D1CFE8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 00:47:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 71C745C00B4;
        Mon, 15 Aug 2022 03:47:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Aug 2022 03:47:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1660549639; x=
        1660636039; bh=khmr8My1/aYtGWoyc1tu0pnFYFeZzQHpVSJzTcR8GWc=; b=l
        hv2dMSxbgNyYg+5kzn7scng8/sD8mR1YIAT42WGkQLmdEd+/I26aKgp3iW5tU0UK
        /OPloBRT0KQq6VdvkgOonbXByKBzTn7JRxY0WHbW2GemTEvI4ssjU/5l9OCZMCe2
        sv/XubdZdrCOEXN/gluaGP1A8DYawbsbmd6GxAZSi878j4Q4t6r8ENxl0caE8emX
        fKfHdj28NOG8EYPQ/cxlWaUC0BZpeN/jyodroHHllcHjltxy9Fs2z1hQZ7nBZb/s
        ljU5irohL+FSoW9OnsH7xZ+evh045J1xG2GpJRCfcrj2Zg/aLpHZMcNFs0tyMJBd
        odkoAt7K25oTJhi5yBIZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660549639; x=
        1660636039; bh=khmr8My1/aYtGWoyc1tu0pnFYFeZzQHpVSJzTcR8GWc=; b=W
        J726LH8dCVK/IiKs88VCwZbwbqIf51A1YKauLzBmfpMZtTIMz2lkcXg/hOXZnrVk
        OWrQN4Y38CkJSJ48jG59fwJ4c1iQ7wqdS+UOKEZ3QcijMJ1Q+D/EyPGoaufZTQnA
        IPT9lGgsMe6KLI17pIztTtFJjj/WayQb3CCtJMZER2dQsodLqnVzuPGrFZFOJN+e
        C9UDmHPorR6dfFmsQSWDr3UacvBZsfy/gtqJGsguBIyOslM1iOer80ThSPnhSuGL
        bmf2arvAJyoK8SerOJ9vGfdIR4XESosHwFituz9tYS6M+r4fBCjVqQ1AJJ2Rvs0d
        1ks+e7y4Ja9As3jQi4VPQ==
X-ME-Sender: <xms:B_r5YkrDBIW_EjmJuqR-3fvbb_dAuoPWhGByabUAkTRZkzSippV0RA>
    <xme:B_r5Yqq-qWad0PSINUNTlCjt-ghpSMen9KxF0GJM00LQKm92_LFqDvBDMx6e_jFV_
    YX3zRRl0hROxLYxgTU>
X-ME-Received: <xmr:B_r5YpNCq1-9CQzyZ8isH8CplhuIhEZSMtUTAjVjPGFaqhTu2NfXA9cWsNM1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgv
    segtvghrnhhordhtvggthheqnecuggftrfgrthhtvghrnhepueeigefghfffffeifeehud
    eiuedvteegueefffevgfetvdffheehkeffvedufeeinecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:B_r5Yr7WIriCAAvZP4-pzXbDltTmsUO_d_I1bSWwA8YWsevXOux4cw>
    <xmx:B_r5Yj7nL6vttUJ4MCWMM7yLAqcAq6oiE5SWEyVqXsoRDu778RHYZQ>
    <xmx:B_r5YrjFNV8yZ_HLg2uTCyNtS378VnB-y0SxZ3gf0IFzJuhKrM8-gQ>
    <xmx:B_r5YgEjs7Htgfnr0w-A7G_eKGuMCyjJyVRYKnJCLQIgaaJzwlcWlQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 03:47:18 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     jernej.skrabec@gmail.com, wens@csie.org, samuel@sholland.org,
        mripard@kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm/sun4i: dsi: Prevent underflow when computing packet sizes
Date:   Mon, 15 Aug 2022 09:47:14 +0200
Message-Id: <166054963291.173470.13302885096018416390.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812031623.34057-1-samuel@sholland.org>
References: <20220812031623.34057-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 22:16:23 -0500, Samuel Holland wrote:
> Currently, the packet overhead is subtracted using unsigned arithmetic.
> With a short sync pulse, this could underflow and wrap around to near
> the maximal u16 value. Fix this by using signed subtraction. The call to
> max() will correctly handle any negative numbers that are produced.
> 
> Apply the same fix to the other timings, even though those subtractions
> are less likely to underflow.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
