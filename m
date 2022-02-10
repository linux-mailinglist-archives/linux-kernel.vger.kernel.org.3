Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A164B03D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiBJDOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:14:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiBJDOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:14:51 -0500
Received: from m1325.mail.163.com (m1325.mail.163.com [220.181.13.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D73731EAE1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=+gO8T
        07vX7kDCL0Yg8uMsti+0sKsRe0cSU2LfwKZ0vU=; b=UjXOxjAhTRhvv/HWfi8Sl
        o93ECTeMd+ltLLHXROBlcE3guGUxSxzRdpQN7vry/EsObreJXuGWIuBDuDTa74h+
        fY92gdsqc6VBW0R2MWlARz5XivAnXj1LnOdB4OSo8RKK7XWYuAnVRNvKQrYwk09W
        evQb17++Lb3m0EPPH1dGw4=
Received: from chengchaohang$163.com ( [114.251.148.34] ) by
 ajax-webmail-wmsvr25 (Coremail) ; Thu, 10 Feb 2022 11:13:58 +0800 (CST)
X-Originating-IP: [114.251.148.34]
Date:   Thu, 10 Feb 2022 11:13:58 +0800 (CST)
From:   "chaohang.cheng" <chengchaohang@163.com>
To:     leon@kernel.org, maorg@nvidia.com, jgg@ziepe.ca,
        logang@deltatee.com, thunder.leizhen@huawei.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/scatterlist: Provide scatterlist hexdump.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <79b66b0e.24c5.17ee19f9409.Coremail.chengchaohang@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GcGowACnr+P3ggRi7AMmAA--.12311W
X-CM-SenderInfo: xfkh0wpfkd0xxdqjqiywtou0bp/xtbBEw+ivF3l-1bNiwABsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogImNoYW9oYW5nLmNoZW5nIiA8Y2hhb2hhbmcuY2hlbmdAaG9yaXpvbi5haT4KCkEgc2Nh
dHRlcmxpc3QgaGV4ZHVtcCBpcyBlc3NlbnRpYWwgZHVyaW5nIGRlYnVnLCBzb21ldGltZXMuCgpT
aWduZWQtb2ZmLWJ5OiBjaGFvaGFuZy5jaGVuZyA8Y2hhb2hhbmcuY2hlbmdAaG9yaXpvbi5haT4K
LS0tCiBpbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmggfCAxNyArKysrKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3NjYXR0ZXJsaXN0LmggYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKaW5kZXggN2Zm
OWQ2Mzg2YzEyLi5lZjhlY2FhYzAwMTYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvc2NhdHRl
cmxpc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L3NjYXR0ZXJsaXN0LmgKQEAgLTU2Myw0ICs1NjMs
MjEgQEAgYm9vbCBzZ19taXRlcl9za2lwKHN0cnVjdCBzZ19tYXBwaW5nX2l0ZXIgKm1pdGVyLCBv
ZmZfdCBvZmZzZXQpOwogYm9vbCBzZ19taXRlcl9uZXh0KHN0cnVjdCBzZ19tYXBwaW5nX2l0ZXIg
Km1pdGVyKTsKIHZvaWQgc2dfbWl0ZXJfc3RvcChzdHJ1Y3Qgc2dfbWFwcGluZ19pdGVyICptaXRl
cik7CiAKKy8qCisgKiBIZXhkdW1wIHNjYXR0ZXJsaXN0CisgKgorICogQHNnOiBzdHJ1Y3Qgc2Nh
dHRlcmxpc3QqIC4KKyAqIGl0IHN0YW5kcyBmb3IgdGhlIGhlYWQgb2YgYSBzY2F0dGVybGlzdCAu
CisgKgorICogbm90ZTogcHJpbnRfaGV4X2R1bXBfZGVidWcgaXMgYSBkeW5hbWljIGRlYnVnIC4K
KyAqCisgKi8KKyNkZWZpbmUgU0dfSEVYRFVNUChzZykJCQkJCQkJXAorZG8gewkJCQkJCQkJCVwK
KwlzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnNnX3RtcCA9IE5VTEw7CQkJCVwKKwlmb3IgKHNnX3RtcCA9
IHNnOyBzZ190bXA7IHNnX3RtcCA9IHNnX25leHQoc2dfdG1wKSkJCVwKKwkJcHJpbnRfaGV4X2R1
bXBfZGVidWcoIiIsIERVTVBfUFJFRklYX09GRlNFVCwJCVwKKwkJCTE2LCAxLCBzZ192aXJ0KHNn
X3RtcCksIHNnX3RtcC0+bGVuZ3RoLCB0cnVlKTsJXAorfSB3aGlsZSAoMCkKKwogI2VuZGlmIC8q
IF9MSU5VWF9TQ0FUVEVSTElTVF9IICovCi0tIAoyLjI1LjEK
