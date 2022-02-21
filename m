Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6A4BEBF8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 21:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiBUUjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 15:39:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBUUjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 15:39:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE6237DC;
        Mon, 21 Feb 2022 12:39:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA748B81719;
        Mon, 21 Feb 2022 20:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34678C340E9;
        Mon, 21 Feb 2022 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645475961;
        bh=4UgHp0D2dDI4dxyLYTBIGgNqsShAcd1aE/cjFXj66u0=;
        h=From:To:Cc:Subject:Date:From;
        b=cu7VsrIC5vR/TgzV+enBuaUmdcKljGD5Zx6UmMRoYrEw3G2KYAleb11NAacEDazQ8
         GobGs2GVqV1wAYdqctdh3WEPXCRtaCr8ZAVp1nLNUa7YaaOyYactHf2xws/5ulvGj8
         ZHfkg7XCo7Z5e9qYNfEwG18w6pw+Y9bQ8Q5gNSVsKNzZS1Ql1TJt2rJdyUrWMR4BhM
         YkRA98jAET8jFAHsglN21v+oSRdUZdZLBd3Xn4kM9/Bz4tGrbzhH1oKueOvGWMGoDJ
         aGsbyLTLdkEZvIGUyvZnBH7uS8VrtTFM1uwHpyKnAjQKC3XWph5l8rqRRoIdiw9IuG
         CrebUSSqk7pXw==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Date:   Mon, 21 Feb 2022 20:39:17 +0000
Message-Id: <20220221203917.1899359-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/dwc3/dwc3-pci.c

between commit:

  d7c93a903f33f ("usb: dwc3: pci: Add "snps,dis_u2_susphy_quirk" for Intel Bay Trail")

from the usb.current tree and commit:

  582ab24e096fd ("usb: dwc3: pci: Set "linux,phy_charger_detect" property on some Bay Trail boards")

from the usb tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 4e7efa97724bd,a614b9f73e2cd..0000000000000
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
diff --cc drivers/usb/dwc3/dwc3-pci.c
index 06d0e88ec8af9,4330c974b31ba..0000000000000
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@@ -120,13 -119,14 +120,21 @@@ static const struct property_entry dwc3
  	{}
  };
  
 +static const struct property_entry dwc3_pci_intel_byt_properties[] = {
 +	PROPERTY_ENTRY_STRING("dr_mode", "peripheral"),
 +	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
 +	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
 +	{}
 +};
 +
+ static const struct property_entry dwc3_pci_intel_phy_charger_detect_properties[] = {
+ 	PROPERTY_ENTRY_STRING("dr_mode", "peripheral"),
+ 	PROPERTY_ENTRY_BOOL("snps,dis_u2_susphy_quirk"),
+ 	PROPERTY_ENTRY_BOOL("linux,phy_charger_detect"),
+ 	PROPERTY_ENTRY_BOOL("linux,sysdev_is_parent"),
+ 	{}
+ };
+ 
  static const struct property_entry dwc3_pci_mrfld_properties[] = {
  	PROPERTY_ENTRY_STRING("dr_mode", "otg"),
  	PROPERTY_ENTRY_STRING("linux,extcon-name", "mrfld_bcove_pwrsrc"),
@@@ -169,10 -169,10 +177,14 @@@ static const struct software_node dwc3_
  	.properties = dwc3_pci_intel_properties,
  };
  
 +static const struct software_node dwc3_pci_intel_byt_swnode = {
 +	.properties = dwc3_pci_intel_byt_properties,
 +};
 +
+ static const struct software_node dwc3_pci_intel_phy_charger_detect_swnode = {
+ 	.properties = dwc3_pci_intel_phy_charger_detect_properties,
+ };
+ 
  static const struct software_node dwc3_pci_intel_mrfld_swnode = {
  	.properties = dwc3_pci_mrfld_properties,
  };
