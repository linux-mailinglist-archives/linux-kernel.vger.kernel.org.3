Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F50D471F51
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 03:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhLMC0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 21:26:48 -0500
Received: from out203-205-251-27.mail.qq.com ([203.205.251.27]:39452 "EHLO
        out203-205-251-27.mail.qq.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhLMC0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 21:26:47 -0500
X-Greylist: delayed 34406 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Dec 2021 21:26:47 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1639362403;
        bh=dJKtjTSKz62rNy49syVpqD28WJWax6LS+Mw42ExvDiE=;
        h=Date:From:To:Cc:Subject;
        b=EYeHawAcKyqBHxWP1v/ZIs45rHZJECPvyhgkqmU3JopjsHAyBfWevi4dkmtRe7Mzz
         7VWVWTzLPA9XmW46PT8mObdTyghBZmQ6MmuRXnNp46mvmWzPfwOuAvWUZKvdSBzg50
         DDXFYcdhTZPljcZjB+7PbrAnDZrQbdg/m7zkNaCE=
Received: from LAPTOP-4BSPBRI7 ([59.172.176.92])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 6A90BE4C; Mon, 13 Dec 2021 10:26:41 +0800
X-QQ-mid: xmsmtpt1639362401t6u5s3bdr
Message-ID: <tencent_C982943047E43271285358863729A5FF630A@qq.com>
X-QQ-XMAILINFO: M1xqn9pGP6LN76WbLmg5E+5W3cSr5Q2BaM6+cpZekx2T5StSOh/kW47VGafMPZ
         0nVODas39U+GjjKp1zZEzdK2GGnE7fBhyy2sCHnk2lIjgHTdl663jtqa4hJxN19dZozX61y0Ksdi
         JbqUUEtVMjg0vf0UWYC97ldrThhooIAUTCc/VyBr3/AIb6IfWObbX3iOMeLJ+v9LNSm6HY9sRUia
         34LRPoAq271C3M26VP5gWFzGWkH2rt5j970znP3IF5RH/wxAgSlwRD8cU/na7xRl622cjhWOE0+J
         IZX3fUIbMFtHzgGUv30lJ9vqKTp94Mib+z2NbKsOq3lnwI0pAgwEEYUaYkop90f/fIvQz6c17p6m
         8rcdn7fcjpoWArb7Bn3steomCXJoEleNwYro3IJsxQXTOYRWfobdoOILGKNhST1Tx5yyfCV2KI6U
         Z6Ypm3CtEXZ09JbS0x5rnq3LB5QaBgdWUuX4/Y7gcQzB19y+vriMP+fK0eU7Swzc4Ur8Ql+ATwck
         3OuNK972mKzeWPKvzK1qfxEJdlI61CDlQtypeo0dj+RsrIlXSzUSg1XN7gtQBk0cFPaeKTEztpWX
         gRlTTsOPCCXNSIdQ4T1sJ/JhWImNk5WPeVUnuUy7t61Jcf/+m5r7L1/8OTlolJ8JjbCzo2GEDHi/
         OizURGyvLWNfKD0mZ8H+4LHG8bluv6abpL9OjeEF3KyUJU8TYYggluHqRKF2b+fvqhvz6QYqK2Pk
         J/qw8o5lf/wkZ9nmdQgZj47G6X7LHFjIu7xVYYy6DTKrJlTxflYF7ILsh9gttU7PNbaxH36KoFaJ
         +EqD8CPP2UASVpFuA2x/ccvdlEkH4GmDobT65D8xZsXzxA1N3+Qoaax2dG2e4kYHs=
Date:   Mon, 13 Dec 2021 10:26:41 +0800
From:   "xkernel.wang@foxmail.com" <xkernel.wang@foxmail.com>
To:     mpe <mpe@ellerman.id.au>, agust <agust@denx.de>
Cc:     benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc52xx_gpt: fix a potential memory leak
X-Priority: 3
X-GUID: 0E828642-9115-4B73-A131-B82288F17D29
X-Has-Attach: no
X-Mailer: Foxmail 7.2.14.410[en]
Mime-Version: 1.0
Message-ID: <202112131026410462899@foxmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PiB3cm90ZToKPiA+IFdoZW4gc29t
ZSBpbnRlcm5hbCBtZW1vcnkgZXJyb3JzIGhhcHBlbmQgaW4gb2ZfaW9tYXAoKSwgd2Ugc2hvdWxk
IGZyZWUKPiA+IGdwdCB0byBwcmV2ZW50IG1lbW9yeSBsZWFrLgo+Cj4gQnV0IGl0J3MgYWxsb2Nh
dGVkIHdpdGggZGV2bV9remFsbG9jKCksIHNvIHRoZSBkZXZyZXMgY29yZSBpcyBtZWFudCB0bwo+
IGZyZWUgaXQgZm9yIHVzIGlzbid0IGl0PwoKWWVzLCBtYXliZSB5b3UgYXJlIHJpZ2h0LiBJIGRp
ZCB0aGF0IGFzIEkgbWVudGlvbmVkIHdoZW4gZ3B0LXJlZ3MgaXMgTlVMTCwgaXTCoAp3aWxsIHJl
dHVybiAtRU5PTUVNLCB3aGljaCBpcyB0aGUgc2FtZSB3aGVuIGdwdCBpcyBOVUxMLiBTbyBJIHN1
cHBvc2UgdG8gCmZyZWXCoGl0IGluIHRpbWUgaXMgYmV0dGVyOgo+CWdwdCA9IGRldm1fa3phbGxv
Yygmb2ZkZXYtPmRldiwgc2l6ZW9mICpncHQsIEdGUF9LRVJORUwpOwo+CWlmICghZ3B0KQo+CQly
ZXR1cm4gLUVOT01FTTsKCmNoZWVycwoK

.

