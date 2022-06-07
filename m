Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4E541C7B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382785AbiFGWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379253AbiFGVCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:02:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C21252BB;
        Tue,  7 Jun 2022 11:47:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48899B8220B;
        Tue,  7 Jun 2022 18:47:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0C4C385A2;
        Tue,  7 Jun 2022 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654627627;
        bh=4JWxKeMCzS1I9F8T8lOqSs2eeTmYuFxzWuEf3D1lwX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hero6S28mIn+sjbHJN1t4SyiS4dMBG/F9WHfCpxITsYuc1bGQn4FiURzNcP+B3mZf
         2sn5CfDnEpFFcf91QoamzzvoDz/hydCyXWQbtuGuYKwLJ3+biyaY61V/del7M59cuw
         rrgNMVLwudFM7kPma5JpFDmtOCW5rbapsJQ/A4gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Michael=20Niew=C3=B6hner?= <linux@mniewoehner.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5.18 036/879] platform/x86: intel-hid: fix _DSM function index handling
Date:   Tue,  7 Jun 2022 18:52:34 +0200
Message-Id: <20220607165003.725103749@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Niewöhner <linux@mniewoehner.de>

commit 1620c80bba53af8c547bab34a1d3bc58319fe608 upstream.

intel_hid_dsm_fn_mask is a bit mask containing one bit for each function
index. Fix the function index check in intel_hid_evaluate_method
accordingly, which was missed in commit 97ab4516205e ("platform/x86:
intel-hid: fix _DSM function index handling").

Fixes: 97ab4516205e ("platform/x86: intel-hid: fix _DSM function index handling")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Niewöhner <linux@mniewoehner.de>
Link: https://lore.kernel.org/r/66f813f5bcc724a0f6dd5adefe6a9728dbe509e3.camel@mniewoehner.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/intel/hid.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -238,7 +238,7 @@ static bool intel_hid_evaluate_method(ac
 
 	method_name = (char *)intel_hid_dsm_fn_to_method[fn_index];
 
-	if (!(intel_hid_dsm_fn_mask & fn_index))
+	if (!(intel_hid_dsm_fn_mask & BIT(fn_index)))
 		goto skip_dsm_eval;
 
 	obj = acpi_evaluate_dsm_typed(handle, &intel_dsm_guid,


