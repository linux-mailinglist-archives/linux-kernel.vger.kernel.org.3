Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0399259EF00
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiHWWZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 18:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiHWWZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 18:25:18 -0400
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC73C6B8E2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 15:25:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id B863820134;
        Wed, 24 Aug 2022 00:25:15 +0200 (CEST)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5Q1gtM_Rm0JG; Wed, 24 Aug 2022 00:25:15 +0200 (CEST)
Received: from begin.home (lfbn-bor-1-376-208.w109-215.abo.wanadoo.fr [109.215.91.208])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id A63912011A;
        Wed, 24 Aug 2022 00:25:15 +0200 (CEST)
Received: from samy by begin.home with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1oQcKh-00GY2a-17;
        Wed, 24 Aug 2022 00:25:15 +0200
Message-ID: <20220823222514.929670068@ens-lyon.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Aug 2022 00:25:02 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: [patch 1/2] speakup-dummy: Add support for PUNCT variable
References: <20220823222501.483597563@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to debug the update of the punctuation level.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Index: linux/drivers/accessibility/speakup/speakup_dummy.c
===================================================================
--- linux.orig/drivers/accessibility/speakup/speakup_dummy.c
+++ linux/drivers/accessibility/speakup/speakup_dummy.c
@@ -27,6 +27,7 @@ static struct var_t vars[] = {
 	{ INFLECTION, .u.n = {"INFLECTION %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ VOL, .u.n = {"VOL %d\n", 8, 0, 16, 0, 0, NULL } },
 	{ TONE, .u.n = {"TONE %d\n", 8, 0, 16, 0, 0, NULL } },
+	{ PUNCT, .u.n = {"PUNCT %d\n", 0, 0, 3, 0, 0, NULL } },
 	{ DIRECT, .u.n = {NULL, 0, 0, 1, 0, 0, NULL } },
 	V_LAST_VAR
 };
@@ -42,6 +43,8 @@ static struct kobj_attribute pitch_attri
 	__ATTR(pitch, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute inflection_attribute =
 	__ATTR(inflection, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute punct_attribute =
+	__ATTR(punct, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute rate_attribute =
 	__ATTR(rate, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute tone_attribute =
@@ -69,6 +72,7 @@ static struct attribute *synth_attrs[] =
 	&caps_stop_attribute.attr,
 	&pitch_attribute.attr,
 	&inflection_attribute.attr,
+	&punct_attribute.attr,
 	&rate_attribute.attr,
 	&tone_attribute.attr,
 	&vol_attribute.attr,

