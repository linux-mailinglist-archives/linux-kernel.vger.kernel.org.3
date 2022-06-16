Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9354DA0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349736AbiFPFzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFPFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:55:05 -0400
Received: from m1524.mail.126.com (m1524.mail.126.com [220.181.15.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15CA75AEEF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=TGNnE
        bgER54kno8uDuAkCA8vdekRFZ7/trMUSYHqvqQ=; b=IUfc4qgjpBpoP5kuZQmg8
        jTEQzFxleena42Hp6/tFgCaKBXHyU+B6q7jETb62bb2G60os1f5rXTg4fY0Cxyib
        eqiInswgCH/N7+8Oiwk7JK6+dokA8Ymd0cBwblFQ6HQHbGFUKG2m7y5KtQXhsvC9
        0Z0eYRa6eyq3JGz26qK2X4=
Received: from windhl$126.com ( [124.16.139.61] ) by ajax-webmail-wmsvr24
 (Coremail) ; Thu, 16 Jun 2022 13:54:38 +0800 (CST)
X-Originating-IP: [124.16.139.61]
Date:   Thu, 16 Jun 2022 13:54:38 +0800 (CST)
From:   "Liang He" <windhl@126.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "kernel test robot" <lkp@intel.com>
Subject: Re:[PATCH v2] soc: sifive: (sifive_l2_cache) Add missing
 of_node_put()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20220113(9671e152)
 Copyright (c) 2002-2022 www.mailtech.cn 126com
In-Reply-To: <20220616044915.3978097-1-windhl@126.com>
References: <20220616044915.3978097-1-windhl@126.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <28cd6700.3e2d.1816b13f1fa.Coremail.windhl@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: GMqowABHViafxapiUgE3AA--.30098W
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3B8iF1pEDuvuPAAAsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIyLTA2LTE2IDEyOjQ5OjE1LCAiTGlhbmcgSGUiIDx3aW5kaGxAMTI2LmNvbT4gd3Jv
dGU6Cj5JbiBzaWZpdmVfbDJfaW5pdCgpLCBvZl9maW5kX21hdGNoaW5nX25vZGUoKSB3aWxsIHJl
dHVybiBhIG5vZGUgcG9pbnRlcgo+d2l0aCByZWZjb3VudCBpbmNyZW1lbnRlZC4gV2Ugc2hvdWxk
IHVzZSBvZl9ub2RlX3B1dCgpIGluIGVhY2ggZmFpbCBwYXRoCj5vciB3aGVuIGl0IGlzIG5vdCB1
c2VkIGFueW1vcmUuCj4KPlJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4KPgo+U2lnbmVkLW9mZi1ieTogTGlhbmcgSGUgPHdpbmRobEAxMjYuY29tPgo+LS0tCgoK
U29ycnksIHBsZWFzZSBpZ25vcmUgdGhpcyB2ZXJzaW9uIGFzIGl0IHN0aWxsIGhhcyBhIGJ1Zy4g
IEkgd2lsbCBoYXZlIGEgc3RyaWN0IGNoZWNrIGFuZCBjb21waWxlIHRoZSBjb2RlIGJlZm9yZSBt
eSBuZXh0IGNvbW1pdC4=
