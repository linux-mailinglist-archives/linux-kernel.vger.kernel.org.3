Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90FB5919A4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 11:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbiHMJg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235803AbiHMJg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:36:56 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06641419AE;
        Sat, 13 Aug 2022 02:36:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1EAD53200904;
        Sat, 13 Aug 2022 05:36:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 13 Aug 2022 05:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660383413; x=1660469813; bh=YBdMl+uMyz9VQ5dxoNfLaUyHl
        tCFImwAh095f61YKAA=; b=hnK/2OAb660g0xS5wivCfDWryf8oHeUcEY/tmOspI
        QuvmTOfS+sfo7k3tqdWu90L0s5EGnnnwBVBLeZclqK7zoCAHqPwvJKmrC2PTLzTh
        d/YaGsqx53RCjs43lFUk2UF+xPebqXRE/yZKuxJSmv/dvRSpNWXVeR8Udo+hFD8e
        NjiDnzkiHmPkIpJXXWt4Xw/Eiw/fLucD4ZzBe/tfIGFqxMfo85sD8xOperJscH8O
        tOjUglhwoqlsyimhfOoEFsL1Lz5YiOuDty0obwV4inSc3bTxFf4WJVBfSxcM3NbL
        RSJByn4iZLkcwAXr9OpGEqigFe3NC61E8nym+W012FBZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660383413; x=1660469813; bh=YBdMl+uMyz9VQ5dxoNfLaUyHltCFImwAh09
        5f61YKAA=; b=eZ/vA/tNDAm6v2xe0OGHSep8Z8+4ONX6IGMXnkt3e0yPdE0NiLS
        9/TiL2w88rY6OJrzY1Vh8ElGg7tOx+h/6fYG7dgTGRhR6FabUXg9q6wjbuR6i4kz
        N11R3y82s9wc+Z07VsfyOkX/PUxLOyUZxF79ftC/rWjhYdoRn5qMmWCmKcVC36SQ
        fAXVHmucAacnZ4oOHpJbyoZnfPsB+uJMdqdn/ZlLIzXz0UQjMup19uYnXgAuwcXy
        iLSQ2xNH0FASqcVgns6lpCNczJH09mIADY4U/fn2FB0GcM/KOw4WLo5o7Vdygd73
        8oKngFJbYak+ZuWfyknBBjDBFy2b3onfMpg==
X-ME-Sender: <xms:tXD3Ys-nrAv_vPqTXFU-DTy4E6yD-K80AqL0iyJ1Ip-74K7UkM95nA>
    <xme:tXD3YkuJEZSLCWeK1-vIZc09kMX0HXW8AZF2DKQ-YojTkArZE6gqmHRvitpQfiwZz
    PTmU4SMrQD-LRsbCtI>
X-ME-Received: <xmr:tXD3YiAvVV-MvfmZN75mjng_jXPXgJQMa4oAT7JiMxlWMiZpf7gBWPqnt_PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:tXD3Ysc8_5X8M3QcPTkgWsjUxlRki2vcHn4Qeub06p0OBBg2WOGf3g>
    <xmx:tXD3YhNv_wNuEwJ8EAOPRgTJn06CKwkDv437bbHn344FsRRvSTIUKw>
    <xmx:tXD3Ymn595Ej_US3bUhtX2OVg8YfFroB4gaWpgjcNPaiAF9Y_tKchw>
    <xmx:tXD3YqYrdMGR07is2QBlwSZRo0HRxE9qklTBGsSEZiy6fna-1tyw5w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 13 Aug 2022 05:36:50 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 0/2] asus-wmi: TUF Fan extra (GPU)
Date:   Sat, 13 Aug 2022 21:36:40 +1200
Message-Id: <20220813093642.7440-1-luke@ljones.dev>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support to "boost" the second fan, typically GPU.
Also tries both fan boost and throttle policy on fn+f5 as
some laptops have one, or both but with an ampty body plus
valid return for one.

Changelog:
- Edit commit mesages
- Edit comments
- use sysfs_emit()

Luke D. Jones (2):
  asus-wmi: Modify behaviour of Fn+F5 fan key
  asus-wmi: Support the GPU fan on TUF laptops

 drivers/platform/x86/asus-nb-wmi.c         |  1 +
 drivers/platform/x86/asus-wmi.c            | 82 ++++++++++++++++++++--
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 3 files changed, 78 insertions(+), 6 deletions(-)

-- 
2.37.1

