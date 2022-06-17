Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E6254F12B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 08:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380308AbiFQGqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 02:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243756AbiFQGqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 02:46:01 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290B924962;
        Thu, 16 Jun 2022 23:45:58 -0700 (PDT)
Received: from SHSend.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by SHSQR01.spreadtrum.com with ESMTPS id 25H6jC1l078478
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO);
        Fri, 17 Jun 2022 14:45:12 +0800 (CST)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from BJMBX01.spreadtrum.com (10.0.64.7) by BJMBX01.spreadtrum.com
 (10.0.64.7) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 17 Jun
 2022 14:45:12 +0800
Received: from BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7]) by
 BJMBX01.spreadtrum.com ([fe80::54e:9a:129d:fac7%16]) with mapi id
 15.00.1497.023; Fri, 17 Jun 2022 14:45:12 +0800
From:   =?gb2312?B?u8azr9H0IChaaGFveWFuZyBIdWFuZyk=?= 
        <zhaoyang.huang@unisoc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?zfW/xiAoS2UgV2FuZyk=?= <Ke.Wang@unisoc.com>
Subject: =?gb2312?B?tPC4tDogW1JGQyBQQVRDSHYyXSBibG9jazogc2V0IGJkaSBjb25nZXN0ZWQg?=
 =?gb2312?Q?when_no_tag_available?=
Thread-Topic: [RFC PATCHv2] block: set bdi congested when no tag available
Thread-Index: AQHYgZWpf5cuF+nA30elLdOCJqp1u61TJmwa
Date:   Fri, 17 Jun 2022 06:45:11 +0000
Message-ID: <1655448311673.39746@unisoc.com>
References: <1655382631-3037-1-git-send-email-zhaoyang.huang@unisoc.com>,<281b7645-5ce3-0339-78d9-bbc737e4c50e@kernel.dk>
In-Reply-To: <281b7645-5ce3-0339-78d9-bbc737e4c50e@kernel.dk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.1.146.141]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: SHSQR01.spreadtrum.com 25H6jC1l078478
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpPbiA2LzE2LzIyIDY6MzAgQU0sIHpoYW95YW5nLmh1YW5nIHdyb3RlOgo+IEZyb206IFpoYW95
YW5nIEh1YW5nIDx6aGFveWFuZy5odWFuZ0B1bmlzb2MuY29tPgo+Cj4gSW4gcHJldmlvdXMgdmVy
c2lvbiwgYmxvY2sgbGF5ZXIgd2lsbCBzZXQgYmRpIHRvIGJlIGNvbmdlc3RlZCB3aGVuCj4gZ2V0
X3JlcXVlc3QgZmFpbCwgd2hpY2ggbWF5IHRocm90dGxlIGRpcmVjdF9yZWNsYWltLiBNb3ZlIHRo
ZW0gYmFjawo+IHVuZGVyIGN1cnJlbnQgYmxrLW1xIGRlc2lnbi4KCmJkaSBjb25nZXN0aW9uIGRv
ZXNuJ3QgZXhpc3QgYW55bW9yZSwgbm90IHN1cmUgd2hhdCB0aGlzIHBhdGNoIGlzCmFnYWluc3Q/
Cgpvay4gV2hhdCBpIGFtIHRyeWluZyB0byBzb2x2ZSBpcyBpbnRyb2R1Y2luZyByZWNsYWltIHRo
cm90dGxlIHdoZW4gZXhjZXNzaXZlIG51bWJlciBvZiBJT3MgY29uc3VtZSBhbGwgdGFncyBvbiBo
d2N0eC4gSXQgaXMgY291bGQgYmUgaW50cm9kdWNlZCBieSBwYWdlIHRocmFzaGluZyBvciBhY2Nl
c3Mgb2YgbWFwcGVkIGxpYiBmaWxlcy4gCi0tCkplbnMgQXhib2UKCg==
