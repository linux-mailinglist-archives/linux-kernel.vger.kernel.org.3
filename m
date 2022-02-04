Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2AB4A9993
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 13:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244139AbiBDM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 07:58:18 -0500
Received: from mail6.pr.hu ([87.242.0.6]:34933 "EHLO mail6.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236192AbiBDM6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 07:58:15 -0500
Received: from [2a02:808:3:101::5] (helo=mail.pr.hu)
        by frontdoor.pr.hu with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <zboszor@pr.hu>)
        id 1nFyAA-0007F4-72; Fri, 04 Feb 2022 13:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pr.hu;
        s=pr20170203; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XnOhIpcm2yyxAYZ7l4yQqnys/a9MwsubYo/CVHdqUWI=; b=isSDT/AVKVARVo3SP2mCgwsPdG
        COmb0KLJqOj08xHb4w5ZyvgpNeTvnbwYr+8U3/wZeqBX1q81skuvv6sQL/FOqajrRDnQckDo7qteC
        0+OJVistacicUcuVpasA4uC71wT2DMd8bp30ItcojO9R2lERPC0GH+7WHqCrKYsC0t5Zf3GDz6Kxx
        t2f7SNV2O3i8bh+Ig3OrnJShXNqpzcdi3Rx5XLTeEyo21wtj1NLLOYPNAQBI9mNVdYY0LHOMUsvYw
        blKZaosp+bc1++6t5awJNTjQJKDY/2b8pBwy3qg6fOVKYbGfjrPRh3ItB/WF8v+KEtpGQZQmqJnbe
        PhayLNsw==;
Received: from host-87-242-32-51.prtelecom.hu ([87.242.32.51] helo=localhost.lan)
        by mail.pr.hu with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <zboszor@pr.hu>)
        id 1nFyA6-0002os-1T; Fri, 04 Feb 2022 13:58:04 +0100
From:   zboszor@pr.hu
To:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     zboszor@gmail.com
Subject: [PATCH] libata: add horkage for M88V29
Date:   Fri,  4 Feb 2022 13:57:50 +0100
Message-Id: <20220204125750.1771303-1-zboszor@pr.hu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -9.8 (---------)
X-Scan-Signature: a1aedbebb1ad86a93e9d56217add5c67
X-Spam-Tracer: backend.mail.pr.hu -9.8 20220204125804Z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zoltán Böszörményi <zboszor@gmail.com>

This device is a CF card, or possibly an SSD in CF form factor.
It supports NCQ and high speed DMA.

While it also advertises TRIM support, I/O errors are reported
when the discard mount option fstrim is used. TRIM also fails
when disabling NCQ and not just as an NCQ command.

TRIM must be disabled for this device.

Signed-off-by: Zoltán Böszörményi <zboszor@gmail.com>
---
 drivers/ata/libata-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 67f88027680a..4a7f58fcc411 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4028,6 +4028,7 @@ static const struct ata_blacklist_entry ata_device_blacklist [] = {
 
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
+	{ "M88V29*",			NULL,	ATA_HORKAGE_NOTRIM, },
 
 	/*
 	 * As defined, the DRAT (Deterministic Read After Trim) and RZAT
-- 
2.34.1

