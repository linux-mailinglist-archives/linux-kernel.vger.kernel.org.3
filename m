Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31C255AB2A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiFYPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbiFYPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:00:19 -0400
X-Greylist: delayed 1826 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Jun 2022 08:00:17 PDT
Received: from m1548.mail.126.com (m1548.mail.126.com [220.181.15.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8F7412D1B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ypGs7
        lpxxQx6BOfxMJzF+1MxsCsKZeK+VXcMIsiX7Pk=; b=WJy48bo8MhKICciRJViaQ
        zb6n+kEhfGkKu0scV35OL8dPH9uM48Ja4pzhjMXmVCKuV7+MZETAc5+75OMw6oC/
        JL35zggaw+6PbHsE9Wvhw3ghRd9jaCErmjvfl3Ott1nVntK8EM6l3ThpqD8XzpPX
        r2zEuBByFvAdx1EihTCK5M=
Received: from cheny_wen$126.com ( [120.231.117.174] ) by
 ajax-webmail-wmsvr48 (Coremail) ; Sat, 25 Jun 2022 22:29:02 +0800 (CST)
X-Originating-IP: [120.231.117.174]
Date:   Sat, 25 Jun 2022 22:29:02 +0800 (CST)
From:   cheny_wen@126.com
To:     "Gao Xiang" <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Even <chenyuwen1@meizu.com>
Subject: Re:Re: [PATCH] erofs: Wake up all waiters after z_erofs_lzma_head
 ready.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <YrbZEIxC62XjVBwL@B-P7TQMD6M-0146.local>
References: <20220625085738.12834-1-cheny_wen@126.com>
 <YrbZEIxC62XjVBwL@B-P7TQMD6M-0146.local>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Message-ID: <68c6768b.6289.1819b4421df.Coremail.cheny_wen@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MMqowADH3navG7dihL0yAA--.33177W
X-CM-SenderInfo: xfkh05hbzh0qqrswhudrp/1tbimxQrhlx5hG+kegABsz
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkKJm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7Jm5ic3A7SSZuYnNwO2hhdmUmbmJzcDtzZW50Jm5i
c3A7YSZuYnNwO25ldyZuYnNwO2VtYWlsJm5ic3A7ZnJvbSZuYnNwO21laXp1Jm5ic3A7ZW1haWwm
bmJzcDt3aGljaCZuYnNwO3NpZ25lZCZuYnNwO3RoZSZuYnNwO3BhdGNoLgoKdGhpbmtzJm5ic3A7
Zm9yJm5ic3A7eW91ciZuYnNwO2hlbHAuCuWcqCAyMDIyLTA2LTI1IDE3OjQ0OjQ477yMIkdhbyBY
aWFuZyIgPGhzaWFuZ2thb0BsaW51eC5hbGliYWJhLmNvbT4g5YaZ6YGT77yaCkhpLA0KDQpPbiBT
YXQsIEp1biAyNSwgMjAyMiBhdCAwNDo1NzozOFBNICswODAwLCBFdmVuIHdyb3RlOg0KPiBGcm9t
OiBFdmVuIDxjaGVueXV3ZW4xQG1laXp1LmNvbT4NCj4gDQo+IFdoZW4gdGhlIHVzZXIgbW91bnRz
IHRoZSBlcm9mcyBzZWNvbmQgdGltZXMsIHRoZSBkZWNvbXByZXNzaW9uIHRocmVhZA0KPiBtYXkg
aHVuZy4gVGhlIHByb2JsZW0gaGFwcGVucyBkdWUgdG8gYSBzZXF1ZW5jZSBvZiBzdGVwcyBsaWtl
IHRoZQ0KPiBmb2xsb3dpbmc6DQo+IA0KPiAxKSBUYXNrIEEgY2FsbGVkIHpfZXJvZnNfbG9hZF9s
em1hX2NvbmZpZyB3aGljaCBvYnRhaW4gYWxsIG9mIHRoZSBub2RlDQo+ICAgIGZyb20gdGhlIHpf
ZXJvZnNfbHptYV9oZWFkLg0KPiANCj4gMikgQXQgdGhpcyB0aW1lLCB0YXNrIEIgY2FsbGVkIHRo
ZSB6X2Vyb2ZzX2x6bWFfZGVjb21wcmVzcyBhbmQgd2FudGVkIHRvDQo+ICAgIGdldCBhIG5vZGUu
IEJ1dCB0aGUgel9lcm9mc19sem1hX2hlYWQgd2FzIGVtcHR5LCB0aGUgVGFzayBCIGhhZCB0bw0K
PiAgICBzbGVlcC4NCj4gDQo+IDMpIFRhc2sgQSByZWxlYXNlIG5vZGVzIGFuZCBwdXNoIG5vZGVz
IGludG8gdGhlIHpfZXJvZnNfbHptYV9oZWFkLiBCdXQNCj4gICAgdGFzayBCIHdhcyBzdGlsbCBz
bGVlcGluZy4NCj4gDQo+IE9uZSBleGFtcGxlIHJlcG9ydCB3aGVuIHRoZSBodW5nIGhhcHBlbnM6
DQo+IHRhc2s6a3dvcmtlci91MzoxIHN0YXRlOkQgc3RhY2s6MTQzODQgcGlkOiA4NiBwcGlkOiAy
IGZsYWdzOjB4MDAwMDQwMDANCj4gV29ya3F1ZXVlOiBlcm9mc191bnppcGQgel9lcm9mc19kZWNv
bXByZXNzcXVldWVfd29yaw0KPiBDYWxsIFRyYWNlOg0KPiAgPFRBU0s+DQo+ICBfX3NjaGVkdWxl
KzB4MjgxLzB4NzYwDQo+ICBzY2hlZHVsZSsweDQ5LzB4YjANCj4gIHpfZXJvZnNfbHptYV9kZWNv
bXByZXNzKzB4NGJjLzB4NTgwDQo+ICA/IGNwdV9jb3JlX2ZsYWdzKzB4MTAvMHgxMA0KPiAgel9l
cm9mc19kZWNvbXByZXNzX3BjbHVzdGVyKzB4NDliLzB4YmEwDQo+ICA/IF9fdXBkYXRlX2xvYWRf
YXZnX3NlKzB4MmIwLzB4MzMwDQo+ICA/IF9fdXBkYXRlX2xvYWRfYXZnX3NlKzB4MmIwLzB4MzMw
DQo+ICA/IHVwZGF0ZV9sb2FkX2F2ZysweDVmLzB4NjkwDQo+ICA/IHVwZGF0ZV9sb2FkX2F2Zysw
eDVmLzB4NjkwDQo+ICA/IHNldF9uZXh0X2VudGl0eSsweGJkLzB4MTEwDQo+ICA/IF9yYXdfc3Bp
bl91bmxvY2srMHhkLzB4MjANCj4gIHpfZXJvZnNfZGVjb21wcmVzc19xdWV1ZS5pc3JhLjArMHgy
ZS8weDUwDQo+ICB6X2Vyb2ZzX2RlY29tcHJlc3NxdWV1ZV93b3JrKzB4MzAvMHg2MA0KPiAgcHJv
Y2Vzc19vbmVfd29yaysweDFkMy8weDNhMA0KPiAgd29ya2VyX3RocmVhZCsweDQ1LzB4M2EwDQo+
ICA/IHByb2Nlc3Nfb25lX3dvcmsrMHgzYTAvMHgzYTANCj4gIGt0aHJlYWQrMHhlMi8weDExMA0K
PiAgPyBrdGhyZWFkX2NvbXBsZXRlX2FuZF9leGl0KzB4MjAvMHgyMA0KPiAgcmV0X2Zyb21fZm9y
aysweDIyLzB4MzANCj4gIDwvVEFTSz4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEV2ZW4gPGNoZW55
dXdlbjFAbWVpenUuY29tPg0KDQpUaGFua3MgYSBsb3QgZm9yIGNhdGNoaW5nIHRoaXMhDQoNClRo
ZSBwYXRjaCBpdHNlbGYgbG9va3MgZ29vZCwgYnV0IGNvdWxkIHlvdSB1c2UgeW91ciByZWFsIG5h
bWUgdG8gc2lnbg0Kb2ZmIHRoZSBwYXRjaCBhbmQgcmVzZW5kIGEgdmVyc2lvbj8gc2VlLA0KaHR0
cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92NC4xNy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0
Y2hlcy5odG1sI2RldmVsb3Blci1zLWNlcnRpZmljYXRlLW9mLW9yaWdpbi0xLTENCg0KT3RoZXJ3
aXNlIGl0IGxvb2tzIGdvb2QgdG8gbWUsDQpSZXZpZXdlZC1ieTogR2FvIFhpYW5nIDxoc2lhbmdr
YW9AbGludXguYWxpYmFiYS5jb20+DQoNClRoYW5rcywNCkdhbyBYaWFuZw0K
