Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944D45312D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiEWPpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiEWPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:45:38 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 78FA4278;
        Mon, 23 May 2022 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID; bh=SarvGZ87dmgOXP19qr9K62mIuiEHpy939i/H
        e2PcsV4=; b=BDl0MMOX444Z1IqDHYOSkLhUEaBjg2/X0DSqp9YWgUoOhnopLLHX
        9jSL8ni2ZN64xMMjzIlTvl9e66yzacczk1Xavi/sxgDDU9zqW9rYqb/bchhU30x5
        FdSlU/aHee61++QwZ+wIAr9dTZdSd6piQdDOCNsUC5FDOxry84PvSFQ=
Received: by ajax-webmail-front02 (Coremail) ; Mon, 23 May 2022 23:45:16
 +0800 (GMT+08:00)
X-Originating-IP: [10.129.37.75]
Date:   Mon, 23 May 2022 23:45:16 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?5YiY5rC45b+X?= <lyz_cs@pku.edu.cn>
To:     "andy shevchenko" <andy.shevchenko@gmail.com>
Cc:     "andy gross" <agross@kernel.org>,
        "bjorn andersson" <bjorn.andersson@linaro.org>,
        "jonathan cameron" <jic23@kernel.org>,
        "lars-peter clausen" <lars@metafoo.de>,
        "stanimir varbanov" <svarbanov@mm-sol.com>,
        "ivan t. ivanov" <iivanov@mm-sol.com>,
        "jonathan cameron" <jonathan.cameron@huawei.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
        fuyq@stu.pku.edu.cn
Subject: Re: Re: [PATCH] hv_netvsc: Fix potential dereference of NULL
 pointer
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210104(ab8c30b6)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-1ea67e80-64e4-49d5-bd9f-3beeae24b9f2-pku.edu.cn
In-Reply-To: <CAHp75Vc+fubwb0PGqVyDs5Np10ZW06F2REVKK=G26zOKT8gvFQ@mail.gmail.com>
References: <20220520181323.00002892@huawei.com>
 <1653103862-36104-1-git-send-email-lyz_cs@pku.edu.cn>
 <CAHp75Vc+fubwb0PGqVyDs5Np10ZW06F2REVKK=G26zOKT8gvFQ@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2f9c2f19.3e20a.180f19810d9.Coremail.lyz_cs@pku.edu.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 54FpogDnaXYMrIti7nH2Bg--.38396W
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEMBlPy7vKeCwAas6
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgoKPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KPiBGcm9tOiAiQW5keSBTaGV2Y2hlbmtv
IiA8YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4KPiBTZW50IFRpbWU6IDIwMjItMDUtMjMgMjM6
MjE6NTQgKE1vbmRheSkKPiBUbzogIllvbmd6aGkgTGl1IiA8bHl6X2NzQHBrdS5lZHUuY24+Cj4g
Q2M6ICJBbmR5IEdyb3NzIiA8YWdyb3NzQGtlcm5lbC5vcmc+LCAiQmpvcm4gQW5kZXJzc29uIiA8
Ympvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc+LCAiSm9uYXRoYW4gQ2FtZXJvbiIgPGppYzIzQGtl
cm5lbC5vcmc+LCAiTGFycy1QZXRlciBDbGF1c2VuIiA8bGFyc0BtZXRhZm9vLmRlPiwgIlN0YW5p
bWlyIFZhcmJhbm92IiA8c3ZhcmJhbm92QG1tLXNvbC5jb20+LCAiSXZhbiBULiBJdmFub3YiIDxp
aXZhbm92QG1tLXNvbC5jb20+LCAiSm9uYXRoYW4gQ2FtZXJvbiIgPGpvbmF0aGFuLmNhbWVyb25A
aHVhd2VpLmNvbT4sIGxpbnV4LWFybS1tc20gPGxpbnV4LWFybS1tc21Admdlci5rZXJuZWwub3Jn
PiwgbGludXgtaWlvIDxsaW51eC1paW9Admdlci5rZXJuZWwub3JnPiwgIkxpbnV4IEtlcm5lbCBN
YWlsaW5nIExpc3QiIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwgZnV5cUBzdHUucGt1
LmVkdS5jbgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh2X25ldHZzYzogRml4IHBvdGVudGlhbCBk
ZXJlZmVyZW5jZSBvZiBOVUxMIHBvaW50ZXIKPiAKPiBPbiBTYXQsIE1heSAyMSwgMjAyMiBhdCA2
OjI3IEFNIFlvbmd6aGkgTGl1IDxseXpfY3NAcGt1LmVkdS5jbj4gd3JvdGU6Cj4gPgo+ID4gVGhl
IHJldHVybiB2YWx1ZSBvZiBuZXR2c2NfZGV2aW5mb19nZXQoKQo+ID4gbmVlZHMgdG8gYmUgY2hl
Y2tlZCB0byBhdm9pZCB1c2Ugb2YgTlVMTAo+ID4gcG9pbnRlciBpbiBjYXNlIG9mIGFuIGFsbG9j
YXRpb24gZmFpbHVyZS4KPiAKPiA+IEZpeGVzOiAwZWZlZWE1ZmIgKCJodl9uZXR2c2M6IEFkZCB0
aGUgc3VwcG9ydCBvZiBoaWJlcm5hdGlvbiIpCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3po
aSBMaXUgPGx5el9jc0Bwa3UuZWR1LmNuPgo+CgpUaGFua3MgZm9yIHlvdXIgcmVwbHkgYW5kIGFk
dmljZS4KCj4gRm9yIHRoZSBmdXR1cmUgaW5kZXBlbmRlbnRseSBvZiB0aGUgc3Vic3lzdGVtIG9y
IG1haWxpbmcgbGlzdCwgdGhlIHRhZwo+IGJsb2NrIChhYm92ZSkgbXVzdG4ndCBoYXZlIGxhbmsg
bGluZXMuCj4KPiAtLSAKPiBXaXRoIEJlc3QgUmVnYXJkcywKPiBBbmR5IFNoZXZjaGVua28K
