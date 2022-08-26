Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B995A1DC2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 02:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiHZAm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiHZAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 20:42:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6230E9D134;
        Thu, 25 Aug 2022 17:42:25 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C60B55C00B1;
        Thu, 25 Aug 2022 20:42:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 25 Aug 2022 20:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661474544; x=1661560944; bh=wt
        WOKiSFlox/P8ySjbRAbPtlraMyGOdNoROkHyixP3g=; b=eLR/Fjh69hb8fEUdDf
        4y0NjIbpOz0RE6b7nzyYg/YqMKjI/hL+hWETiGR49Ls7E1RTbsClWeAs4E1vet3R
        f4AEjnsBu8FjVd25wLeEUcQrgo4KMwRRlskyrz9FxZh1IFkgnJJaxt5uDElGJNpM
        Pu+ek4K3YwhUTDjwHwiiZUpGUeGpMLfd5e0cH2iGpLTgTSZ8g+qP16AWRmdIUPDE
        GveCL9w8wQshiaq7rc1cddtSYLVZv3zPAzDifTdXAj1vC4X/6qVL0I23zpbmfBmZ
        D/W6mnrEI5EyJttaUNZ55f+uXODiCh8mnF8CdP23DN8Oppn3eOHaTa4w96mYRxOo
        l0Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661474544; x=1661560944; bh=wtWOKiSFlox/P
        8ySjbRAbPtlraMyGOdNoROkHyixP3g=; b=iOe/b28UORRABpFJorFrpZKpWHbr6
        sT1BbFSz38VhOaxY+nViaI1sJabE3ND+6UpDoTptKHC6hak6oOJl3Z35OTtCryHE
        uVNKhNUlKFX2MSRgvgfQLnzqMqpdFjQBcnujtHpZfbqVV03jqCfutKNkwKYT+ifG
        eTZH7DfFI339wISJ4cslp96Kj/Op7N16U3Y2nSH+e7JnBA7rneIBdylFWUdFGeWb
        brxXHsxxx+BDKLlxtVvLcWjW619Vhu6VG3XCsMMW06PnR/V2rEZGvtJZBbEPkuOa
        CSiG+EdJLCH7GuWRRwHHCwqnxQF8xz9PSCaH4cZonNHqwTYgC1v2kayjw==
X-ME-Sender: <xms:8BYIY6dU6X9Svvg0OT65-kX2-baHbxmnrwErfTN8bud5uR1VZ7PxSg>
    <xme:8BYIY0MxUTysThCFNtqGAYDn7Ig06sEnx8D5JD3RzKCCxCosyh88UnSm1YAhL57-8
    grYrcJ34JtcvQvWK60>
X-ME-Received: <xmr:8BYIY7iD-BuThV72v9tKQZ6p4nvPIXqdgdsy31rF3DOXqdDkpI0UVg_5vc98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:8BYIY3_RqnHgEZK9q4y8OBly7ifC0TScHNnw1ddqGjPNAoLMu9vGJA>
    <xmx:8BYIY2sRS10HeVfsWBXw2vYXHUrWW34dgWVQKa0qzaafs1XYZOc3Yw>
    <xmx:8BYIY-EoJ4RL1E88O7tsr0IsOl9zpnG-MjapKuYX-O4CTDeLBUhjMg>
    <xmx:8BYIY_7AwFyLE5hQzxLeXolaS5tkLlOonVHilSLbIoCNp9toi3hm7A>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Aug 2022 20:42:22 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 1/2] asus-wmi: Modify behaviour of Fn+F5 fan key
Date:   Fri, 26 Aug 2022 12:42:09 +1200
Message-Id: <20220826004210.356534-2-luke@ljones.dev>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220826004210.356534-1-luke@ljones.dev>
References: <20220826004210.356534-1-luke@ljones.dev>
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

Some more recent TUF laptops have both fan_boost and thermal_throttle.
The key code for Fn+F5 is also different and unmapped.

This patch adjusts the asus_wmi_handle_event_code() match to match
for both 0x99 and 0xAE, and run both mode switch functions for
fan_boost and/or thermal_throttle if either are available.

It is required that both are tried, as in some instances the ACPI
set-method for one may not have any code body within it even though
it was returned as supported by the get method.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 drivers/platform/x86/asus-nb-wmi.c |  1 +
 drivers/platform/x86/asus-wmi.c    | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index cb8af61d684c..fcfe6dddd645 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -577,6 +577,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xA5, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + TV + HDMI */
 	{ KE_KEY, 0xA6, { KEY_SWITCHVIDEOMODE } }, /* SDSP CRT + TV + HDMI */
 	{ KE_KEY, 0xA7, { KEY_SWITCHVIDEOMODE } }, /* SDSP LCD + CRT + TV + HDMI */
+	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
 	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
 	{ KE_KEY, 0xB5, { KEY_CALC } },
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f608a4467d99..ea45e10302f7 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -3190,14 +3190,13 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 		return;
 	}
 
-	if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
-		fan_boost_mode_switch_next(asus);
+	if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
+		if (asus->fan_boost_mode_available)
+			fan_boost_mode_switch_next(asus);
+		if (asus->throttle_thermal_policy_available)
+			throttle_thermal_policy_switch_next(asus);
 		return;
-	}
 
-	if (asus->throttle_thermal_policy_available && code == NOTIFY_KBD_TTP) {
-		throttle_thermal_policy_switch_next(asus);
-		return;
 	}
 
 	if (is_display_toggle(code) && asus->driver->quirks->no_display_toggle)
-- 
2.37.2

