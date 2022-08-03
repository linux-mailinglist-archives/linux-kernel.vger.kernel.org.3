Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D0C5894B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 01:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiHCXNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 19:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236179AbiHCXNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 19:13:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606A5C366;
        Wed,  3 Aug 2022 16:13:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A6D85C00E4;
        Wed,  3 Aug 2022 19:13:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 03 Aug 2022 19:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1659568421; x=1659654821; bh=2S3dkk1V93GUlpSfPmNI6IvpR
        /zYbDMOPvlGhBYJCkQ=; b=C4X0B4pdOIL+fivNkP6ayga6ub/DnUcC/wgylWGsc
        UWqnBMpZUv2/Iz++1UIoaVzqaGzvdiPbgZU3SJIkhCz2mS7G8XD0obnSjLYArDZH
        /WJTwggECZlrFXIrfe3GFy9ahgfF9JFfyGLtpbg+a8L88PAe6FL/fG6vJfhSyBlJ
        MhhgRoWiC850CNim9dgFgmM//txCYJ/tTxXi+i2pebF0Ih3lQGVlo4c+aZO9N2Gi
        e+SLf25pgkkf/SBnJb9RgBBkLSSJ8Kt321faLDrc2nyCRZym8tG/UyGi8zMMcqmO
        uYWG+pMBSVVtAxRPResyOSY1gwlirqsrXZXwsBB1l0YMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659568421; x=1659654821; bh=2S3dkk1V93GUlpSfPmNI6IvpR/zYbDMOPvl
        GhBYJCkQ=; b=mBp2tlY8XgzEAvZC1JWz+1RXYnvXy5LzDnyGsIHJRnBnNflgL5Z
        DgP8YOzfq1prXktHzqfhwwlzoGUmZRnngxoPmaaJpXJ8pJ5SfmgEKZRjY8m1t5uR
        0zvEFrrpQ36XXuI7QufnZ9QG/PKg2PNOGfKLQySXfvc2IPyFcaFYKTK121+WzHUq
        26k2ioNeQdxfPFjsOdzxZfivlWKmMdTfti1h+7NauxP82RW8DshZCD2AbnKz2guO
        E2SmfwpMn+rs3rfjnLZUzlsfpPLVvk0w4rEAeTqepOX1dH5/0rn2WKdpBdDTiAuX
        RiRTfIrKMJFtGwGKYnEf0V0VLK0OzZZhwnw==
X-ME-Sender: <xms:JAHrYpGPdBjy94j1_5TwIcnM0u_KbWuuxB61C688xC6uR8jsgipI6w>
    <xme:JAHrYuWCP4ItieE_7_HLYcmhXRtRgRPcfTptAmjW3z90nVz07379TvcgPtIV9LOvz
    KI64bNLHc_R9O_PBTM>
X-ME-Received: <xmr:JAHrYrLRIL2Vfd6tEVwUpRXHkffd_nty7WJe6TkphK1M-dNUutI0zORztsEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:JAHrYvGgWvTfE7gicJ1-WDIAsXyvZpxzlKuWTVHoteXHewUe_jFVdg>
    <xmx:JAHrYvXQng8kEde1V4m3kUTEaM_EKwjg_DXnEZSqamZRbDGN0JPqXw>
    <xmx:JAHrYqOyHe9sw0wkELS_NjyCr4CRXXFIE_-oLAUQC2CUlqEx2hN05w>
    <xmx:JQHrYsgndcLahdFoMV2BhvgpmAF3o5tYBGm7a7CyU4JXmHUIwqa98A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Aug 2022 19:13:38 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/1] asus-wmi: Add support for TUF laptop keyboard states
Date:   Thu,  4 Aug 2022 11:13:30 +1200
Message-Id: <20220803231331.48788-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the TUF series laptop power states. This means
control of if the LED's are on while awake, or an animation is
shown while booting or suspended.

Changelog:
- V2:
  + Adds sysfs attr for tuf_krgb_state_index to provide index labels

Luke D. Jones (1):
  asus-wmi: Add support for TUF laptop keyboard states

 drivers/platform/x86/asus-wmi.c            | 95 ++++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |  3 +
 2 files changed, 98 insertions(+)

-- 
2.37.1

