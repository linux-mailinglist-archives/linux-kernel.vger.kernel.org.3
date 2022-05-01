Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB8051677C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 21:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354311AbiEATfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350708AbiEATfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 15:35:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEC84E3AB
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 12:31:46 -0700 (PDT)
Message-ID: <20220501192740.203963477@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651433502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MaQUSR6/y9jldhWidtuVber3S3PCoxPwsYRbe7imfKI=;
        b=WDKBVB9ExqxCZRsNQEJdiPuCYnEl7NIRhiDzMdcijoIdqNXwRyocMEWQUd1EBG2713Udoq
        JHaYBckXLP8VUQH3W6mWcm3abIZsl+2QcXlQW7xWCgFUMFXwpg/BmUBJgbUCJcDOslngCh
        xLWr99YM/DaRSgVs420K18bvBHQ2kJj870t9xKfto/bu25CnSLeFf4Dz9AyZjmIriFjlUZ
        E0TdaZZ33y+EKwIP1bfbY3n/ALGzDct2OQgn+mzaTwwnC04bNorW3rNregt7Y/t+DyNz64
        JEWMv2yvGpN2LxpPy91hxqanAkLnppMLlCXkYDgMdPdY/esU9z6/sLDHMB2yRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651433502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MaQUSR6/y9jldhWidtuVber3S3PCoxPwsYRbe7imfKI=;
        b=93WThiy88bbgCd3nc7k70P+qti5eoSARb9c9R+j0z2XyhskpiSE544x4Hzua+IuDIdszgL
        rGBeQJpp8xvUSuBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [patch 0/3] x86/fpu: Prevent FPU state corruption
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sun,  1 May 2022 21:31:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlY2VudCBjaGFuZ2VzIGluIHRoZSByYW5kb20gY29kZSB1bmVhcnRoZWQgYSBsb25nIHN0
YW5kaW5nIEZQVSBzdGF0ZQpjb3JydXB0aW9uIGR1ZSBkbyBhIGJ1Z2d5IGNvbmRpdGlvbiBmb3Ig
Z3JhbnRpbmcgaW4ta2VybmVsIEZQVSB1c2FnZS4KClRoZSBmb2xsb3dpbmcgc2VyaWVzIGFkZHJl
c3NlcyB0aGlzIGlzc3VlIGFuZCBtYWtlcyB0aGUgY29kZSBtb3JlIHJvYnVzdC4KClRoYW5rcywK
Cgl0Z2x4Ci0tLQogYXJjaC91bS9pbmNsdWRlL2FzbS9mcHUvYXBpLmggICAgICAgfCAgICAyIAog
YXJjaC94ODYvaW5jbHVkZS9hc20vZnB1L2FwaS5oICAgICAgfCAgIDIxICstLS0tLS0tCiBhcmNo
L3g4Ni9pbmNsdWRlL2FzbS9zaW1kLmggICAgICAgICB8ICAgIDIgCiBhcmNoL3g4Ni9rZXJuZWwv
ZnB1L2NvcmUuYyAgICAgICAgICB8ICAgOTIgKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tCiBuZXQvbmV0ZmlsdGVyL25mdF9zZXRfcGlwYXBvX2F2eDIuYyB8ICAgIDIgCiA1IGZp
bGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQoKCgo=
