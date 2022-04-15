Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD36502F42
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348789AbiDOTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 15:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347427AbiDOTWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 15:22:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3CC3EA8B;
        Fri, 15 Apr 2022 12:19:52 -0700 (PDT)
Message-ID: <20220415133356.179706384@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650050389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PCqHGYWha2qFzocY7lkicGkVazPbVuiY2oKAGLDRIdk=;
        b=id6wN8fokQD9vuyR0yBA6iQJVE56ax9xur7Pj1ITWMwyOhb3j/OecRzufFIpQ+M9W79q4l
        2fVezPQ7mvnNXZoz9bCTj6VxGc27EChT0GchKIacgkQU8+Kq/ns8acQOQqATpRw/13aYyS
        qDDfkESlUvgHazGMr5JzXC2CMD9yTboFbWemELApAMnAHOk53Yz2LAuBB5r/QZMMXO0SL7
        eok3QIq8BP8lQa3AgAsKAfsNwict5EU46XJbeEGeoT/17/ArHQEbuUUjTN2qoSNUfo1s0p
        1qW+W/vSuUz+gLBsH+DIM/HaLobz8wY+hKHlC81IBXxNtaj+W/11x5HOHHu2bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650050389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PCqHGYWha2qFzocY7lkicGkVazPbVuiY2oKAGLDRIdk=;
        b=D8rExBpcz27gnAebY69pf4uuu9Bo00GVd+WX/9/WyJ4bqlPi08HPrdqsXeU5S68gV1zxp1
        NhQwgotnoI4tneCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-pm@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Fri, 15 Apr 2022 21:19:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QVBFUkYvTVBFUkYgaXMgdXRpbGl6ZWQgaW4gdHdvIHdheXM6CgogIDEpIEFkIGhvYyByZWFkb3V0
IG9mIENQVSBmcmVxdWVuY3kgd2hpY2ggcmVxdWlyZXMgSVBJcwoKICAyKSBGcmVxdWVuY3kgc2Nh
bGUgY2FsY3VsYXRpb24gZm9yIGZyZXF1ZW5jeSBpbnZhcmlhbnQgc2NoZWR1bGluZyB3aGljaAog
ICAgIHJlYWRzIEFQRVJGL01QRVJGIG9uIGV2ZXJ5IHRpY2suCgpUaGVzZSBhcmUgY29tcGxldGVs
eSBpbmRlcGVuZGVudCBjb2RlIHBhcnRzLiBFcmljIG9ic2VydmVkIGxvbmcgbGF0ZW5jaWVzCndo
ZW4gcmVhZGluZyAvcHJvYy9jcHVpbmZvIHdoaWNoIHJlYWRzIG91dCBDUFUgZnJlcXVlbmN5IHZp
YSAjMSBhbmQKcHJvcG9zZWQgdG8gcmVwbGFjZSB0aGUgcGVyIENQVSBzaW5nbGUgSVBJIHdpdGgg
YSBicm9hZGNhc3QgSVBJLgoKV2hpbGUgdGhpcyBtYWtlcyB0aGUgbGF0ZW5jeSBzbWFsbGVyLCBp
dCBpcyBub3QgbmVjZXNzYXJ5IGF0IGFsbCBiZWNhdXNlICMyCnNhbXBsZXMgQVBFUkYvTVBFUkYg
cGVyaW9kaWNhbGx5LCBleGNlcHQgb24gaWRsZSBvciBpc29sYXRlZCBOT0haIGZ1bGwgQ1BVcwp3
aGljaCBhcmUgZXhjbHVkZWQgZnJvbSBJUEkgYWxyZWFkeS4KCkl0IGNvdWxkIGJlIGFyZ3VlZCB0
aGF0IG5vdCBhbGwgQVBFUkYvTVBFUkYgY2FwYWJsZSBzeXN0ZW1zIGhhdmUgdGhlCnJlcXVpcmVk
IEJJT1MgaW5mb3JtYXRpb24gdG8gZW5hYmxlIGZyZXF1ZW5jeSBpbnZhcmlhbmNlIHN1cHBvcnQs
IGJ1dCBpbgpwcmFjdGljZSBtb3N0IG9mIHRoZW0gZG8uIFNvIHRoZSBBUEVSRi9NUEVSRiBzYW1w
bGluZyBjYW4gYmUgbWFkZQp1bmNvbmRpdGlvbmFsIGFuZCBqdXN0IHRoZSBmcmVxdWVuY3kgc2Nh
bGUgY2FsY3VsYXRpb24gZm9yIHRoZSBzY2hlZHVsZXIKZXhjbHVkZWQuCgpUaGUgZm9sbG93aW5n
IHNlcmllcyBjb25zb2xpZGF0ZXMgdGhhdC4KClRoYW5rcywKCgl0Z2x4Ci0tLQogYXJjaC94ODYv
aW5jbHVkZS9hc20vY3B1LmggICAgICAgfCAgICAyIAogYXJjaC94ODYvaW5jbHVkZS9hc20vdG9w
b2xvZ3kuaCAgfCAgIDE3IC0KIGFyY2gveDg2L2tlcm5lbC9hY3BpL2NwcGMuYyAgICAgIHwgICAy
OCAtLQogYXJjaC94ODYva2VybmVsL2NwdS9hcGVyZm1wZXJmLmMgfCAgNDc0ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLQogYXJjaC94ODYva2VybmVsL2NwdS9wcm9jLmMg
ICAgICAgfCAgICAyIAogYXJjaC94ODYva2VybmVsL3NtcGJvb3QuYyAgICAgICAgfCAgMzU4IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBmcy9wcm9jL2NwdWluZm8uYyAgICAgICAgICAg
ICAgICB8ICAgIDYgCiBpbmNsdWRlL2xpbnV4L2NwdWZyZXEuaCAgICAgICAgICB8ICAgIDEgCiA4
IGZpbGVzIGNoYW5nZWQsIDQwNSBpbnNlcnRpb25zKCspLCA0ODMgZGVsZXRpb25zKC0pCgoK
