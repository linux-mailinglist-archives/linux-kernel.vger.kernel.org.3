Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3781F4E6453
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350570AbiCXNsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350553AbiCXNsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:48:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC27CDD0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 06:47:10 -0700 (PDT)
Message-ID: <20220324134548.432837672@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648129627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U5/Yi0KhBQTzqCdz/Hls2ZZAOKvQZj/KKEG8U78c5Ts=;
        b=SX3giZMCQwC0RItcp/p4A1uTwY87XwTGCuYbHaIPyf9DKJyeoAzF4GMD+QqRBcUrvFvV8A
        tp/sos1FejFANEP6VvDmjlPFvhFKzVcMxAPnoZucFrv/Nf418SKHto7SAwR2JopJ6nMFNb
        nH/Vz/N9LUvK29rb1268fXiVf8ANUskQfcEv6hPL+TQupi1PYru4ivipdkLShT9A2KEyRI
        UVWp1+cQCk+YxxUZX2sO5QH5l9wPqZSg/g0G4u4sTTRVWXXpxc73xW9n0PadQ8CiRs5Lb7
        lqP0NfxUvdG9iV65Wu4o4+0J6LEzQh5GBVpXFM0uD2/44rz65tQB/JrHG/GDVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648129627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U5/Yi0KhBQTzqCdz/Hls2ZZAOKvQZj/KKEG8U78c5Ts=;
        b=WgUcQqTcJgMNoJiT6kMMhSYI8YmfhZGgQ5HPpfKZqHx2ynrbowi8YsKMNxQnAUscQE8vLA
        iMcTgS23chQxZQCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Chang S. Bae" <chang.seok.bae@intel.com>,
        Paolo Bonzini <bonzini@gnu.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [patch 0/7] x86/fpu: Cure supervisor mode (ENQCMD) fallout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Thu, 24 Mar 2022 14:47:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9sa3MhCgpUaGUgKHJlKWVuYWJsaW5nIG9mIEVOUUNNRCBvciB0aGUgZW5hYmxpbmcgb2YgYW55
IHN1cGVydmlzb3Igb25seSBzdGF0ZQpyZXN1bHRzIGluIGEgcG9zc2libGUgaW5jb25zaXN0ZW5j
eSBvZiB0aGUgaG9zdCBhbmQgZ3Vlc3QgRlBVIFhTVEFURSBsYXlvdXQKb24gc3lzdGVtcyB3aGlj
aCBzdXBwb3J0IHRoYXQgZmVhdHVyZS4KClRoZSByZWFzb24gaXMgdGhhdCBvbiB0aGUgaG9zdCB0
aGUgRlBVIHN0YXRlIGhhcyB0byBpbmNsdWRlIHN1cGVydmlzb3IKZmVhdHVyZXMgd2hpbGUgdGhl
IGd1ZXN0IEZQVSBzdGF0ZSBpcyBzdHJpY3RseSB1c2VyIGZlYXR1cmVzIG9ubHkuCgpUaGUgcHJv
YmxlbSBpcyByZXN0cmljdGVkIHRvIGEgZmV3IHBsYWNlczoKCiAgMSkgVGhlIHNpemUgY2FsY3Vs
YXRpb24gaW4gdGhlIGR5bmFtaWMgc3RhdGUgcGVybWlzc2lvbiBQUkNUTCB3aGljaCBsYWNrcwog
ICAgIGFkZGluZyB0aGUgc3VwZXJ2aXNvciBzdGF0ZSBzaXplIGZvciBjYWxjdWxhdGluZyB0aGUg
a2VybmVsIGJ1ZmZlcgogICAgIHNpemUuCgogIDIpIFRoZSBvZmZzZXQgY2FsY3VsYXRpb25zIGlu
IHRoZSBjb3B5IHRvL2Zyb20gVUFCSSBmdW5jdGlvbnMgd2hpY2gKICAgICB1c2UgcHJlY2FsY3Vs
YXRlZCBvZmZzZXRzIHdoaWNoIGFyZSBvbmx5IHZhbGlkIGZvciB0aGUgaG9zdC4KClRoZSBjdXJl
IGlzIHRvIHVzZSBydW50aW1lIGNhbGN1bGF0aW9uIGZvciB0aGUgb2Zmc2V0cyBiYXNlZCBvbiB0
aGUKWENPTVBfQlYgYml0bWFzayBpbiB0aGUgWFNUQVRFIGhlYWRlciBpbiBjYXNlIG9mIGNvbXBh
Y3RlZCBidWZmZXJzLiBGb3IKbm9uLWNvbXBhY3RlZCBmb3JtYXQgbm90aGluZyBjaGFuZ2VzLgoK
VGhlIGZvbGxvd2luZyBzZXJpZXMgYWRkcmVzc2VzIHRoaXMgYW5kIGl0IHR1cm5zIG91dCB0byBi
ZSBhbiBvdmVyYWxsCnZhbHVhYmxlIGNsZWFudXAgYW5kIHNpbXBsaWZpY2F0aW9uIG9mIHRoZSBj
b2RlOgoKIGNvcmUuYyAgIHwgICAgMyAKIHhzdGF0ZS5jIHwgIDIxMSArKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMg
Y2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKSwgMTUyIGRlbGV0aW9ucygtKQoKVGhlIHJlc3VsdCBv
ZiB0aGUgY29uc29saWRhdGlvbiBvZiB0aGUgYnVmZmVyIHNpemUgY2FsY3VsYXRpb24gKGxhc3Qg
cGF0Y2gKaW4gdGhlIHNlcmllcykgaXMgYSBzaWduaWZpY2FudCByZWR1Y3Rpb24gb2YgY3ljbGVz
IHNwZW50IGZvciBpbml0aWFsaXppbmcKWFNUQVRFIGR1ZSB0byB0aGUgYXZvaWRhbmNlIG9mIGEg
Z2F6aWxsaW9uIHJlZHVuZGFudCBDUFVJRCBpbnZvY2F0aW9uczoKCiBCZWZvcmU6IFhTVEFURSBp
bml0OiAxNzQzNDQgY3ljbGVzCiBBZnRlcjogIFhTVEFURSBpbml0OiAgNzM4OTAgY3ljbGVzCgpJ
dCBidWlsZHMsIGJvb3RzIG9uIGhvc3QgYW5kIGd1ZXN0LCBidXQgaXMgbm90IHlldCBleHRlbnNp
dmVseSB0ZXN0ZWQuClRlc3Rpbmcgd2l0aCBhIEFNWCArIFBBU0lEIGVuYWJsZWQgbWFjaGluZSBo
YXMgbm90IGJlZW4gZG9uZSBhdCBhbGwgYXMgSQpkb24ndCBoYXZlIGVhc3kgYWNjZXNzIHRvIHN1
Y2ggYSBiZWFzdC4KClRoZSBzZXJpZXMgaXMgYmFzZWQgb246CgogICBnaXQ6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGlwL3RpcC5naXQgeDg2L3VyZ2VudAoKYW5k
IGF2YWlsYWJsZSBmcm9tIGdpdDoKCiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90Z2x4L2RldmVsLmdpdCB4ODYvZnB1CgpUaGFua3MsCgoJdGdseAoKCg==
