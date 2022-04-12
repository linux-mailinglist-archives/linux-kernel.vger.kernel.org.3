Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B0F4FE9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiDLU5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiDLU5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 16:57:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774C3147AF6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 13:52:18 -0700 (PDT)
Message-ID: <20220412203649.956258017@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649796705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nesHZNDT3sUuc3fCT2z5sPsvaaorcroJLfA5/Nlliq8=;
        b=0demtT4Iije9Dc0IjE+s7OPEb4YOOEVPc9wx5Xk2gL5NdSEJmVTKiyMVcAgVOBZYlAdikH
        fgxu3m8w9UAJgj2in8KGOkNdRtzt8LPAcpxVO109HKN8Ur0frF1aqjXl7JMuXnkjkDU1t9
        zKPJXNskbbs2CSEs2LSgp1wD3DNuLm3bx0E9STP+B99AmEFbLk9UmieCslLgAz4AFnI/2U
        wLe4MVp+u87iKQzQO6BTknhP66tEu+iiVnE0oSVlb8U/7V9PrOLXeVlhq+UJdddjGa6ToX
        a12nJ8HgMpSYfm8SkEOGTyiZaQj4248/D/EBGO+m5gLDdL70hDFoh1DHtHiiWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649796705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nesHZNDT3sUuc3fCT2z5sPsvaaorcroJLfA5/Nlliq8=;
        b=OOs28YIiMrE3aSMfFnEtFmx4+loStFeK30OPPqIWZgaOZ4kiTjh4R30A7sbugJxK2cXvt1
        KLjz2hMle2l28GDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V4 0/2] smp: Make softirq handling RT friendly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 12 Apr 2022 22:51:45 +0200 (CEST)
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
CgpUaGUgZm9sbG93aW5nIHNlcmllcyBhZGRyZXNzZXMgdGhpcy4gQ2hhbmdlcyB2cy4gVjMsIHdo
aWNoIGNhbiBiZSBmb3VuZApoZXJlOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL1lnS2dM
NmFQajhhQkVTNkdAbGludXRyb25peC5kZQoKICAtIFJlbmFtZSBmbHVzaF9zbXBfY2FsbF9mdW5j
dGlvbl9mcm9tX2lkbGUoKSBhbmQgYWRkIGNvbW1lbnRzCgogIC0gQ29uZmluZSB0aGUgUlQgc3Bl
Y2lmaWNzIGluIHRoZSBzb2Z0aXJxIGNvZGUKClRoYW5rcywKCgl0Z2x4Ci0tLQogaW5jbHVkZS9s
aW51eC9pbnRlcnJ1cHQuaCB8ICAgIDkgKysrKysrKysrCiBrZXJuZWwvc2NoZWQvY29yZS5jICAg
ICAgIHwgICAgMiArLQoga2VybmVsL3NjaGVkL2lkbGUuYyAgICAgICB8ICAgIDIgKy0KIGtlcm5l
bC9zY2hlZC9zY2hlZC5oICAgICAgfCAgICA0ICsrLS0KIGtlcm5lbC9zbXAuYyAgICAgICAgICAg
ICAgfCAgIDMyICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCiBrZXJuZWwvc29mdGly
cS5jICAgICAgICAgIHwgICAxMyArKysrKysrKysrKysrCiA2IGZpbGVzIGNoYW5nZWQsIDUwIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQoKCgoK
