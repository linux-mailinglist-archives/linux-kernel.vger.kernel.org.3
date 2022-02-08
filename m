Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F904ACF83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiBHDPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBHDPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:15:17 -0500
X-Greylist: delayed 1891 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 19:15:13 PST
Received: from m159.mail.126.com (m159.mail.126.com [220.181.15.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9DA4C061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=5HZAe
        cUcBPRUdlmANLyfCJQ7HLdWBlaUrPt5Gc2l46Q=; b=USvsa+sbqhCANcMn8797r
        sH32k0TNdowlTqlkTbR4lupHCsiSl3eHy3UuTfvk6GUrJY9YHOLqbgESc6cefCAP
        pXFReqNKeYnHg5EjjERVHs07G42fzZ0XAie/FOA+PPe5rXtGw2nEryad0/3UKIVY
        eEF/kBKlXqUBxDDV66+QIA=
Received: from wonder_rock$126.com ( [61.177.116.114] ) by
 ajax-webmail-wmsvr9 (Coremail) ; Tue, 8 Feb 2022 10:43:07 +0800 (CST)
X-Originating-IP: [61.177.116.114]
Date:   Tue, 8 Feb 2022 10:43:07 +0800 (CST)
From:   "Deyan Wang" <wonder_rock@126.com>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, "Deyan Wang" <wonder_rock@126.com>
Subject: [PATCH] pstore/ram: Use reminder directly
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <131fd0c6.14a8.17ed7369c1b.Coremail.wonder_rock@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CcqowAC38Di72AFiEz8fAA--.32993W
X-CM-SenderInfo: xzrqvv5ubu0ubn6rjloofrz/1tbiYB6hgVpEGG6odAABsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGV5YW4gV2FuZyA8d29uZGVyX3JvY2tAMTI2LmNvbT4KClRoZSByZW1haW5kZXIgaXMg
bW9yZSBlZmZpY2llbnQsIHdlIGRpcmVjdGx5IHVzZSB0aGUgcmVtYWluZGVyLgoKU2lnbmVkLW9m
Zi1ieTogRGV5YW4gV2FuZyA8d29uZGVyX3JvY2tAMTI2LmNvbT4KLS0tCiBmcy9wc3RvcmUvcmFt
X2NvcmUuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9wc3RvcmUvcmFtX2NvcmUuYyBiL2ZzL3BzdG9yZS9y
YW1fY29yZS5jCmluZGV4IGZlNTMwNTAyOGM2ZS4uNjk5MjhhNTllMjhiIDEwMDY0NAotLS0gYS9m
cy9wc3RvcmUvcmFtX2NvcmUuYworKysgYi9mcy9wc3RvcmUvcmFtX2NvcmUuYwpAQCAtNjEsOCAr
NjEsOCBAQCBzdGF0aWMgc2l6ZV90IGJ1ZmZlcl9zdGFydF9hZGQoc3RydWN0IHBlcnNpc3RlbnRf
cmFtX3pvbmUgKnByeiwgc2l6ZV90IGEpCiAKIAlvbGQgPSBhdG9taWNfcmVhZCgmcHJ6LT5idWZm
ZXItPnN0YXJ0KTsKIAluZXcgPSBvbGQgKyBhOwotCXdoaWxlICh1bmxpa2VseShuZXcgPj0gcHJ6
LT5idWZmZXJfc2l6ZSkpCi0JCW5ldyAtPSBwcnotPmJ1ZmZlcl9zaXplOworCWlmICh1bmxpa2Vs
eShuZXcgPj0gcHJ6LT5idWZmZXJfc2l6ZSkpCisJCW5ldyAlPSBwcnotPmJ1ZmZlcl9zaXplOwog
CWF0b21pY19zZXQoJnByei0+YnVmZmVyLT5zdGFydCwgbmV3KTsKIAogCWlmICghKHByei0+Zmxh
Z3MgJiBQUlpfRkxBR19OT19MT0NLKSkKLS0gCjIuMjUuMQo=
