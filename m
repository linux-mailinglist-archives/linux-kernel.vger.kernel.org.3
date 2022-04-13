Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3964FF7A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiDMNdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbiDMNdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:33:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5903F5AA64
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:31:02 -0700 (PDT)
Message-ID: <20220413132836.099363044@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649856660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nPmddVCNU1012EC5RTKnLjc8m5jDKOe59Wb9jORhc2w=;
        b=2Qu1J8qWnewbOT2gySYErsIYB5de8bnfiMou2TvOnUFqoEg0cjMu2a8nZlHPRWch+Nm+Al
        Ym9uvxfAtCeyChiFx/yXVytCig7M+eRR8We4A5HPnKlzlvuO8aTpT/AtWABe0Q/o6iBr01
        4dwn0S871EYcZ1wlg5pNi/JUgaeUu1luvv8/pqYF5REDR0Si8f6KzCqCmrrwPr8X3sKiWz
        tR+U4A6wrewKbNAo4bQsRftwDbYotiAtil0jPEAZbr3loT30/ozdgf6y8kplsdTxRihQHq
        8Z77fLPkpj5NsNc8qRLLu90+Q6eD3AqusuZ+y49vZLPYnFqBkyHC4p9Uxo68gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649856660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nPmddVCNU1012EC5RTKnLjc8m5jDKOe59Wb9jORhc2w=;
        b=RTSAf+tublL6ZsHUOutOkrQ90CDk11akFQ/i6I/h2YwMTogcodmGVjq1rVJ3ZA5CjmygFf
        GS675Nm9qhlISUCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V5 0/3] smp: Make softirq handling RT friendly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 13 Apr 2022 15:31:00 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGludm9jYXRpb24gb2YgZG9fc29mdGlycSgpIGluIGZsdXNoX3NtcF9jYWxsX2Z1bmN0aW9u
X2Zyb21faWRsZSgpCmJyZWFrcyBvbiBSVCBiZWNhdXNlIFJUIGRvZXMgbm90IHByb3ZpZGUgZG9f
c29mdGlycSgpLgoKQXNpZGUgb2YgdGhhdCBmbHVzaF9zbXBfY2FsbF9mdW5jdGlvbl9mcm9tX2lk
bGUoKSBpcyBhIG1pc25vbWVyIHNpbmNlIHRoZQpmdW5jdGlvbiBpcyBpbnZva2VkIG5vdCBvbmx5
IGZyb20gaWRsZSwgYnV0IGFsc28gZnJvbSB0aGUgc2NoZWR1bGVyCm1pZ3JhdGlvbiB0aHJlYWQu
CgpUaGUgZm9sbG93aW5nIHNlcmllcyBhZGRyZXNzZXMgdGhpcy4gQ2hhbmdlcyB2cy4gVjQsIHdo
aWNoIGNhbiBiZSBmb3VuZApoZXJlOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjIw
NDEyMjAzNjQ5Ljk1NjI1ODAxN0BsaW51dHJvbml4LmRlCgogIC0gRml4IGEgYm9hdGxvYWQgb2Yg
bWlzc2luZyBwcm90b3R5cGVzIHdhcm5pbmcgcmVsYXRlZCB0byB0aGUKICAgIHNjaGVkdWxlciBh
bmQgaXRzIGhlYWRlciBmaWxlcy4KClRoYW5rcywKCgl0Z2x4Ci0tLQogaW5jbHVkZS9saW51eC9p
bnRlcnJ1cHQuaCAgICB8ICAgIDkgKysrKysrKysrCiBpbmNsdWRlL2xpbnV4L3NjaGVkLmggICAg
ICAgIHwgICAgMiArKwoga2VybmVsL3NjaGVkL2J1aWxkX3BvbGljeS5jICB8ICAgIDIgKysKIGtl
cm5lbC9zY2hlZC9idWlsZF91dGlsaXR5LmMgfCAgICAxICsKIGtlcm5lbC9zY2hlZC9jb3JlLmMg
ICAgICAgICAgfCAgICA1ICsrKystCiBrZXJuZWwvc2NoZWQvZGVhZGxpbmUuYyAgICAgIHwgICAg
MiAtLQoga2VybmVsL3NjaGVkL2ZhaXIuYyAgICAgICAgICB8ICAgIDEgKwoga2VybmVsL3NjaGVk
L2lkbGUuYyAgICAgICAgICB8ICAgIDIgKy0KIGtlcm5lbC9zY2hlZC9zY2hlZC5oICAgICAgICAg
fCAgICA4ICsrLS0tLS0tCiBrZXJuZWwvc2NoZWQvc21wLmggICAgICAgICAgIHwgICAgNiArKysr
KysKIGtlcm5lbC9zbXAuYyAgICAgICAgICAgICAgICAgfCAgIDMyICsrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tCiBrZXJuZWwvc29mdGlycS5jICAgICAgICAgICAgIHwgICAxMyArKysr
KysrKysrKysrCiBrZXJuZWwvc3RvcF9tYWNoaW5lLmMgICAgICAgIHwgICAgMiAtLQogMTMgZmls
ZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgoK
