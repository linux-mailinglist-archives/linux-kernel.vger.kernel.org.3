Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B767550370
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 10:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiFRIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFRIGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 04:06:39 -0400
Received: from m1550.mail.126.com (m1550.mail.126.com [220.181.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0552726543
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=ziDry
        BconZfbcDrkQjVtFWCm4II6YDZsPgZ8pg5lf4U=; b=jNf4loNn/WBLUTy1DgT37
        f+68unl2kHORyj9TbymIOwtlh9/aw4s1BbC29lUZYYRaIwt5dOAv8qJVNK1QDr8h
        XDlg+/u4Wl7wE/A+Y/mQRk49i1WCzednsQccYhAHh97hEudXV4kza1BkboBti2nE
        GU2XakAgj5ysfnjwTXhrTQ=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr50
 (Coremail) ; Sat, 18 Jun 2022 16:03:28 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Sat, 18 Jun 2022 16:03:28 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "dmitry.osipenko@collabora.com" <dmitry.osipenko@collabora.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re:Re: [PATCH] powerpc: kernel: Change the order of of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <a6a5e5b3-ffd1-904b-bba1-22baff5f7b67@csgroup.eu>
References: <20220617112636.4041671-1-windhl@126.com>
 <a6a5e5b3-ffd1-904b-bba1-22baff5f7b67@csgroup.eu>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <61c85548.1a55.18175d69e21.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: MsqowADnPPHRhq1ide84AA--.58025W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbizhEkF18RPUWxtgAAsd
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKCgrlnKggMjAyMi0wNi0xOCAxNToxMzoxM++8jCJDaHJpc3RvcGhlIExlcm95IiA8Y2hyaXN0
b3BoZS5sZXJveUBjc2dyb3VwLmV1PiDlhpnpgZPvvJoKPgo+Cj5MZSAxNy8wNi8yMDIyIMOgIDEz
OjI2LCBMaWFuZyBIZSBhIMOpY3JpdMKgOgo+PiBJbiBhZGRfcGNzcGtyKCksIGl0IGlzIGJldHRl
ciB0byBjYWxsIG9mX25vZGVfcHV0KCkgYWZ0ZXIgdGhlCj4+ICdpZighbnApJyBjaGVjay4KPgo+
V2h5IGlzIGl0IGJldHRlciA/Cj4KPgo+Cj4vKioKPiAgKiBvZl9ub2RlX3B1dCgpIC0gRGVjcmVt
ZW50IHJlZmNvdW50IG9mIGEgbm9kZQo+ICAqIEBub2RlOglOb2RlIHRvIGRlYyByZWZjb3VudCwg
TlVMTCBpcyBzdXBwb3J0ZWQgdG8gc2ltcGxpZnkgd3JpdGluZyBvZgo+ICAqCQljYWxsZXJzCj4g
ICovCj52b2lkIG9mX25vZGVfcHV0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSkKPnsKPglpZiAo
bm9kZSkKPgkJa29iamVjdF9wdXQoJm5vZGUtPmtvYmopOwo+fQo+RVhQT1JUX1NZTUJPTChvZl9u
b2RlX3B1dCk7Cj4KPgo+Cj5DaHJpc3RvcGhlCgpIaSwgQ2hyaXN0b3BoZS4KClRoYW5rcyBmb3Ig
eW91ciByZXBseSBhbmQgSSB3YW50IHRvIGhhdmUgYSBkaXNjdXNzaW9uLgoKSW4gbXkgdGhvdWdo
dCwgeHh4X3B1dChwb2ludGVyKSdzIHNlbWFudGljIHVzdWFsbHkgbWVhbnMgCnRoaXMgcmVmZXJl
bmNlIGhhcyBiZWVuIHVzZWQgZG9uZSBhbmQgd2lsbCBub3QgYmUgdXNlZCAKYW55bW9yZS4gSXMg
dGhpcyBzZW1hbnRpYyBtb3JlIHJlYXNvbmFibGUsIHJpZ2h0PwoKQmVzaWRlcywgaWYgdGhlIG5w
IGlzIE5VTEwsIHdlIGNhbiBqdXN0IHJldHVybiBhbmQgc2F2ZSBhIGNwdSAKdGltZSBmb3IgdGhl
IHh4eF9wdXQoKSBjYWxsLgoKT3RoZXJ3aXNlLCBJIHByZWZlciB0byBjYWxsIGl0ICd1c2UoY2hl
Y2spLWFmdGVyLXB1dCcuICAKCkluIGZhY3QsIEkgaGF2ZSBtZWV0IG1hbnkgb3RoZXIgJ3VzZShj
aGVjayktYWZ0ZXItcHV0JyBpbnN0YW5jZXMKYWZ0ZXIgSSBzZW5kIHRoaXMgcGF0Y2gtY29tbWl0
LCBzbyBJIGFtIHdhaXRpbmcgZm9yIHRoaXMgCmRpc2N1c3Npb24uCgpUaGlzIGlzIGp1c3QgbXkg
dGhvdWdodCwgaXQgbWF5IGJlIHdyb25nLgoKQW55d2F5LCB0aGFua3MgZm9yIHlvdXIgcmVwbHku
CgpMaWFuZwoKPgo+Cj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBMaWFuZyBIZSA8d2luZGhsQDEyNi5j
b20+Cj4+IC0tLQo+PiAgIGFyY2gvcG93ZXJwYy9rZXJuZWwvc2V0dXAtY29tbW9uLmMgfCAyICst
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+IAo+
PiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9zZXR1cC1jb21tb24uYyBiL2FyY2gv
cG93ZXJwYy9rZXJuZWwvc2V0dXAtY29tbW9uLmMKPj4gaW5kZXggZWIwMDc3YjMwMmUyLi43NjE4
MTdkMWY0ZGIgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvc2V0dXAtY29tbW9u
LmMKPj4gKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9zZXR1cC1jb21tb24uYwo+PiBAQCAtNTYz
LDkgKzU2Myw5IEBAIHN0YXRpYyBfX2luaXQgaW50IGFkZF9wY3Nwa3Iodm9pZCkKPj4gICAJaW50
IHJldDsKPj4gICAKPj4gICAJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxM
LCAicG5wUE5QLDEwMCIpOwo+PiAtCW9mX25vZGVfcHV0KG5wKTsKPj4gICAJaWYgKCFucCkKPj4g
ICAJCXJldHVybiAtRU5PREVWOwo+PiArCW9mX25vZGVfcHV0KG5wKTsKPj4gICAKPj4gICAJcGQg
PSBwbGF0Zm9ybV9kZXZpY2VfYWxsb2MoInBjc3BrciIsIC0xKTsKPj4gICAJaWYgKCFwZCkK
