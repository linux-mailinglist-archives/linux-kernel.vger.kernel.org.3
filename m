Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8B4F147A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiDDMNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiDDMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:13:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27133DDC2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 05:11:26 -0700 (PDT)
Message-ID: <20220404103741.809025935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649074284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lT+um8z5SG3CTHabwF5ke5cjDRy68kGpOn+qVucotLE=;
        b=sLuUrJpoDTdincrHOiBiapsKY9HDJeKoikwvfHtPcmSytw5ocCX9W+ilqCXpH+22s4iLnC
        VY5+Xifk76bibpVfUXjzVu0n56gHAjUzP/Yc4GRlN3lpBAlqPtMzymwzawEaMQYF0+nsye
        y0oskgl76PfbXgmS3W83KgGCGB1u61RY/uG1fU6kZ/aVpwQpATkRrpwnR+50C4zx0+R5q6
        4VGyk/R7rBqVg/NHVw+APMJacksyMJLbhuPTM3McFNS6vOj4iUAeEXTCHGCHVj3xJeaIaN
        K9jS2cpdPx2nCnSc+pANgZsZdx+EpD97+iZcmHbQ2hxAZSDKhjRC6Hzx5u6msw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649074284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lT+um8z5SG3CTHabwF5ke5cjDRy68kGpOn+qVucotLE=;
        b=0CCQGL4q4xmoJCuTHtJtiM0plL9rZR7KlPcstCPM5U4zM9Z+onN71POjURWI9oMuIf2JVW
        wXzNqgILJektdTBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [patch 0/3] x86/fpu/xsave: Add XSAVEC support and XGETBV1 utilization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Mon,  4 Apr 2022 14:11:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkczoKCiAgMSkgWFNBVkVDIHN1cHBvcnQKCiAgICAgSHlwZXJ2aXNvcnMg
ZXhwb3NlIFhTQVZFQyBidXQgbm90IFhTQVZFUyB0byBndWVzdHMsIGJ1dCB0aGUga2VybmVsCiAg
ICAgZG9lcyBub3Qgc3VwcG9ydCBYU0FWRUMuIFdoaWNoIG1lYW5zIGl0IGNhbm5vdCBtYWtlIHVz
ZSBvZiB0aGUKICAgICBjb21wYWN0ZWQgc3RvcmFnZSBmb3JtYXQuCgogIDIpIFV0aWxpemUgWEdF
VEJWMQoKICAgICBYR0VUQlYxIHJlYWRzIGEgYml0bWFwIHdoaWNoIGNvbnRhaW5zIHRoZSBjdXJy
ZW50IGFjdGl2ZSBYU1RBVEUKICAgICBjb21wb25lbnRzLiBUaGlzIGJpdG1hcCBjYW4gYmUgdXNl
ZCB0byBvcHRpbWl6ZSB0aGUgYmVoYXZpb3VyIG9mCiAgICAgWFNBVkVTIGFuZCBYU0FWRUMgYnkg
cmVxdWVzdGluZyBvbmx5IHRoZSBhY3RpdmUgY29tcG9uZW50cyB0byBiZQogICAgIHNhdmVkLgoK
ICAgICBXaGlsZSB0aGUgaW5pdCBvcHRpbWl6YXRpb24gb2YgWFNBVkVDIGFuZCBYU0FWRVMgc2tp
cHMgd3JpdGluZyB0aGUKICAgICBzdGF0ZSBvZiBjb21wb25lbnRzIHdoaWNoIGFyZSBpbmFjdGl2
ZSwgdGhlIGJ1ZmZlciBsYXlvdXQgaXMgc3RpbGwKICAgICBwcm92aWRpbmcgdGhlIHNwYWNlIGZv
ciB0aGUgaW5hY3RpdmUsIGJ1dCByZXF1ZXN0ZWQgdG8gc2F2ZQogICAgIGNvbXBvbmVudHMuIFdo
aWNoIGlzIHN1Ym9wdGltYWwgaW4gdGVybXMgb2YgcHJlZmV0Y2ggYW5kIGRUTEIgd2hlbgogICAg
IHRoZSBhY3RpdmUgY29tcG9uZW50IGJpdG1hcCBpcyBzcGFyc2UuCgpUaGFua3MsCgoJdGdseAot
LS0KIGluY2x1ZGUvYXNtL2NwdWZlYXR1cmVzLmggfCAgICAyIAoga2VybmVsL2ZwdS94c3RhdGUu
YyAgICAgICB8ICAxNDUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLQoga2VybmVsL2ZwdS94c3RhdGUuaCAgICAgICB8ICAgNDIgKysrKysrKysrKy0tLQogMyBm
aWxlcyBjaGFuZ2VkLCAxNTIgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCg==
