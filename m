Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF15495197
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376752AbiATPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:38:54 -0500
Received: from mail-108-mta15.mxroute.com ([136.175.108.15]:33891 "EHLO
        mail-108-mta15.mxroute.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346434AbiATPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:38:52 -0500
Received: from filter004.mxroute.com ([149.28.56.236] filter004.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta15.mxroute.com (ZoneMTA) with ESMTPSA id 17e781f463c000bdf2.004
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Thu, 20 Jan 2022 15:33:42 +0000
X-Zone-Loop: 614ce73194fc52b04ab1156fe3546e016d25a18f7987
X-Originating-IP: [149.28.56.236]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ds0.me; s=x
        ; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
        :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=2v4DZOWcBj4ZyoLreQSqIsp5ilmMxSdh4/YlkMV5FoQ=; b=x
        AXMsNMrtSd3uKUlB/opiUwvz4n//3saEcZ/iYeXr47XtWPaRq4sZiwSvVP/AEAOJylcasNojwevD+
        xOjwFxSVMEwttzNPYQwFe/MkLMg5UcqLjPhcY7dfpOOzfOrn8oFrGgwWLVVGo3ZGvTUWwcFZUjzpQ
        TIjaZ3toucw+I1MxV1U3q6H0E0gyhs+NN4xCKvAE/rlUafDtGIrhZlpFPrOAavAXomVJ7MW032pRw
        35cOEKekW6TBZwjQzOpj9IZqANpbaC9hoKODoJmrqWAomhW05S/4elUDGNXdplam1xHQU6R3tCoJ4
        RCzxr+GL56zU4SaN5xEQDCE+0nPhTpKWg==;
From:   Myrtle Shah <gatecat@ds0.me>
To:     linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: Fixes for XIP support
Date:   Thu, 20 Jan 2022 15:33:36 +0000
Message-Id: <20220120153338.4093003-1-gatecat@ds0.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: dave@ds0.me
X-Zone-Spam-Resolution: no action
X-Zone-Spam-Status: No, score=5, required=15, tests=[ARC_NA=0,
 MID_CONTAINS_FROM=1, FROM_HAS_DN=0, RCPT_COUNT_THREE=0,
 R_MISSING_CHARSET=2.5, RCVD_COUNT_ZERO=0, FROM_EQ_ENVFROM=0, MIME_TRACE=0,
 BROKEN_CONTENT_TYPE=1.5, TO_DN_NONE=0, NEURAL_SPAM=0]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the spam, resending as this appeared to break
the first time.

These are some initial patches to bugs I found attempting to
get a XIP kernel working on hardware:
 - 32-bit VexRiscv processor
 - kernel in SPI flash, at 0x00200000
 - 16MB of RAM at 0x10000000
 - MMU enabled
 
The system isn't actually booting yet; but at least the
initial memory management setup completes with these
patches as opposed to crashing almost straight away.


