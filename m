Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2A147959C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhLQUnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:43:04 -0500
Received: from whuk3.redbackinternet.net ([109.203.107.222]:55070 "EHLO
        whuk3.redbackinternet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbhLQUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=fbautosys.co.uk; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/noTrHAL8XwEimLGesuhnZd8yluMUxKQ52LRSIOXPFU=; b=ZdKCqrheKtifSvm7XknBTnKlzX
        r1UcVtd+No1Afb/Qt54gpX7nkVJselVVETl6Y0E840mTGjjLvLTRKJCuhPEd7OpUVYqwi0eYb7GcX
        9hb9Utpe6nrfzMNsrgujxSRzzj29eTx089Uj+0u61iruayqGn/Ci7rD4Lgx1jMfU5sv7KMhn/Kdct
        /GSdjpGiSoyAdJuJsNgxRH28BPKipAr7jtxgy8M+eHvpR1EB/ZJWVkqeZhPig9aPfFpIuxPaYscem
        eHQIugUr0Ycgj0w04WraxO3KipiDFRseAyYLOJOh8qMHb77LxLT6tK8Oh8S1txCgZCFnFGC9k3jAE
        XGFl/3Qw==;
Received: from 24.54.187.81.in-addr.arpa ([81.187.54.24]:28253 helo=kernelcomp.corp.firebladeautomationsystems.co.uk)
        by whuk3.redbackinternet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linuxkernel@fbautosys.co.uk>)
        id 1myJgK-0001AJ-Cd; Fri, 17 Dec 2021 20:18:21 +0000
From:   linuxkernel@fbautosys.co.uk
To:     linux-kernel@vger.kernel.org
Cc:     broonie@kernel.org
Subject: [RFC PATCH 0/5] Add Parity bit Calculation to regmaps
Date:   Fri, 17 Dec 2021 20:17:53 +0000
Message-Id: <20211217201758.1743750-1-linuxkernel@fbautosys.co.uk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - whuk3.redbackinternet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - fbautosys.co.uk
X-Get-Message-Sender-Via: whuk3.redbackinternet.net: authenticated_id: linuxkernel@fbautosys.co.uk
X-Authenticated-Sender: whuk3.redbackinternet.net: linuxkernel@fbautosys.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Tyerman <c.tyerman@firebladeautomationsystems.co.uk>

this patch set adds parity bit calculation to regmaps

this allow support for devices that require parity bits in their
communications.

e.g. the texas instruments TPS92518-Q1 which requires a parity bit in the
7th bit of a 16 bit spi frame 
or the TPS92518-Q1 which requires a parity bit in the 1st bit of a 16 bit 
spi frame

parity aimed to work devices where parity in reg block
e.g. TPS65311-Q1 and TPS92518-Q1

TPS65311-Q1 frame format	[PWRRRRRRDDDDDDDD]
TPS92518-Q1	frame format	[WRRRRRPDDDDDDDDD]
P - parity bit, W - Read/Write bit, R - register, D -register data

TPS65311-Q1 parity mask 0x8000 (1000000000000000)
TPS92518-Q1	parity mask	0x0200 (0000001000000000)


calculates parity bit based up parity function defined by
regmap_config->parity_calc

regmap_config->parity_calc defaults to regmap_parity_calc_even()

adds alternate parity function regmap_parity_calc_odd()

calculates parity bit for writes if regmap_config->parity_write_mask is > 0
calculates parity bit for reads if regmap_config->parity_read_mask is > 0

parity is not calculated when bus implements reg_update_bits()


Altered the regmap_format_X_X_write functions to account for padding bits
allowing masks to write to either end of register address for formatted writes

Altered formatted_write to apply write and parity masks

Added parsers for 9 bit data format which are written by formatted write


Christopher Tyerman (5):
  Add Parity bit Calculation to regmaps
  Altered regmap_X_X_write functions to account for padding bits
  Added setting of writemap to formatted write
  Add Parity Calculation to formatted write
  Add parser for X_9 formats

 drivers/base/regmap/internal.h |   6 +
 drivers/base/regmap/regmap.c   | 250 +++++++++++++++++++++++++++++++--
 include/linux/regmap.h         |  32 +++++
 3 files changed, 280 insertions(+), 8 deletions(-)


base-commit: 02d6fdecb9c38de19065f6bed8d5214556fd061d
-- 
2.25.1

