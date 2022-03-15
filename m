Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4A4D9508
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345295AbiCOHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiCOHMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:12:44 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D4A4707B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kRXc10mj4iAzNDgbV827VRY+diRakdhxQqhu23sesQY=;
  b=WhUAh8KUR42l/eMMBxti1B9jFIaBRKg7WcRfh5uo8eh2cksLquqzKq8k
   k024UQWQM8fi6SwNA0Dj92BtaHovgeukny/x36c4qtmbdAlfryqkGuJW6
   T8lS7zIXkt4AvpHe/FIj+vwYtZmkjtQTamWKdsv8Bm+qcyZLCLRuFolVW
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,182,1643670000"; 
   d="py'?scan'208";a="26137696"
Received: from 203.107.68.85.rev.sfr.net (HELO hadrien) ([85.68.107.203])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 08:11:30 +0100
Date:   Tue, 15 Mar 2022 08:11:30 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/30] fix typos in comments
In-Reply-To: <b9c4dba1af41d8ef618267a1bd2a8497b3aa51a9.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2203150803540.2907@hadrien>
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <b9c4dba1af41d8ef618267a1bd2a8497b3aa51a9.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-762518402-1647328290=:2907"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-762518402-1647328290=:2907
Content-Type: text/plain; charset=US-ASCII



On Mon, 14 Mar 2022, Joe Perches wrote:

> Care to describe _how_ coccinelle was helpful in finding
> these typos in comments?

First, Coccinelle can bind a metavariable to the comments before, within
and after anohter kind of term.  So I collected the comments before,
within, and after statements and declarations.

Second, I also used Coccinelle to collect all of the identifiers
referenced in the same file, and discarded all of these words from
consideration.

Otherwise, it's the python library enchant for a dictionary, and some
hacks to reduce the number of false positives, including dropping words
that occur multiple times.  The results are still maybe 90% false
positives, though.

The semantic patch is attached.  It gives around 30K results for the
current linux-next.

julia
--8323329-762518402-1647328290=:2907
Content-Type: text/x-python; name=nlp2.py
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2203150811300.2907@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=nlp2.py

ZnJvbSBfX2Z1dHVyZV9fIGltcG9ydCBwcmludF9mdW5jdGlvbg0KZnJvbSBu
bHRrLnN0ZW0gaW1wb3J0ICoNCmZyb20gc3lzIGltcG9ydCBhcmd2DQppbXBv
cnQgZW5jaGFudA0KDQpkID0gZW5jaGFudC5EaWN0KCJlbl9VUyIpDQp3aXRo
IG9wZW4oYXJndlsxXSkgYXMgZjoNCiAgZm9yIGxpbmUgaW4gZjoNCiAgICAg
d29yZCA9IGxpbmUuc3BsaXQoKVswXQ0KICAgICBpZiBub3QoZC5jaGVjayh3
b3JkKSk6DQogICAgICAgICBwcmludCh3b3JkKQ0K

--8323329-762518402-1647328290=:2907
Content-Type: text/plain; charset=US-ASCII; name=checkspell.cocci
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2203150811301.2907@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=checkspell.cocci

QGluaXRpYWxpemU6b2NhbWxADQpAQA0KDQpsZXQgc2VlbiA9IEhhc2h0Ymwu
Y3JlYXRlIDEwMQ0KbGV0IGJzZWVuID0gSGFzaHRibC5jcmVhdGUgMTAxDQps
ZXQgd3NlZW4gPSBIYXNodGJsLmNyZWF0ZSAxMDENCmxldCBpZHMgPSBIYXNo
dGJsLmNyZWF0ZSAxMDENCmV4Y2VwdGlvbiBOb3RPSw0KDQpsZXQgb2t3ID0g
WyJhcmVuIjsiaXNuIjsid2FzbiI7ImRvZXNuIjsiZGlkbiI7IndlcmVuIjsi
c2hvdWxkbiI7ImNvdWxkbiI7IndvdWxkbiI7Imhhc24iOyJoYXZlbiI7Imxp
bnV4IjsiaG90cGx1ZyI7ImNwdSI7ImlmZGVmIjsiaWZuZGVmIjsiZW5kaWYi
OyJzdHJ1Y3QiXQ0KDQpsZXQgYWRkIGkgPQ0KICAoaWYgbm90IChIYXNodGJs
Lm1lbSBpZHMgaSkgdGhlbiBIYXNodGJsLmFkZCBpZHMgaSAoKSk7DQogIGxl
dCBwaWVjZXMgPSBTdHIuc3BsaXQgKFN0ci5yZWdleHAgIl8iKSBpIGluDQog
IExpc3QuaXRlcg0KICAgIChmdW4gaSAtPiBpZiBub3QgKEhhc2h0YmwubWVt
IGlkcyBpKSB0aGVuIEhhc2h0YmwuYWRkIGlkcyBpICgpKQ0KICAgIHBpZWNl
czsNCiAgZmFsc2UNCg0KbGV0IGhhc3Zvd2VsIHMgPQ0KICBsZXQgdm93ZWxz
ID0gWydhJzsnZSc7J2knOydvJzsndSc7J3knOydBJzsnRSc7J0knOydPJzsn
VSc7J1knXSBpbg0KICB0cnkNCiAgICBTdHJpbmcuaXRlcg0KICAgICAgKGZ1
biBjIC0+DQoJaWYgTGlzdC5tZW0gYyB2b3dlbHMNCgl0aGVuIHJhaXNlIE5v
dE9LKQ0KICAgICAgczsNCiAgICBmYWxzZQ0KICB3aXRoIE5vdE9LIC0+IHRy
dWUNCg0KbGV0IG9ubHlfbGV0dGVycyBzID0NCiAgbGV0IGlzbG93ZXIgYyA9
ICdhJyA8PSBjICYmIGMgPD0gJ3onIGluDQogIGxldCBpc3VwcGVyIGMgPSAn
QScgPD0gYyAmJiBjIDw9ICdaJyBpbg0KICB0cnkNCiAgICBTdHJpbmcuaXRl
cmkNCiAgICAgIChmdW4gaSBjIC0+DQoJbGV0IG9rID0NCgkgIGlmIGkgPSAw
DQoJICB0aGVuIGlzbG93ZXIgYyB8fCBpc3VwcGVyIGMNCgkgIGVsc2UgaXNs
b3dlciBjIGluDQoJaWYgbm90IG9rDQoJdGhlbiByYWlzZSBOb3RPSykNCiAg
ICAgIHM7DQogICAgdHJ1ZQ0KICB3aXRoIE5vdE9LIC0+IGZhbHNlDQoNCmxl
dCBjaGVjayBiYWQgbG9jIHAgYyA9DQogIGlmIG5vdChIYXNodGJsLm1lbSBz
ZWVuIGMpDQogIHRoZW4NCiAgYmVnaW4NCiAgSGFzaHRibC5hZGQgc2VlbiBj
ICgpOw0KICBsZXQgcGllY2VzID0gU3RyLnNwbGl0IChTdHIucmVnZXhwICJc
XGIiKSBjIGluDQogIExpc3QuaXRlcg0KICAgIChmdW4gd29yZCAtPg0KICAg
ICAgaWYgU3RyaW5nLmxlbmd0aCB3b3JkIDw9IDIgfHwgbm90KG9ubHlfbGV0
dGVycyB3b3JkKSB8fCBIYXNodGJsLm1lbSBpZHMgd29yZCB8fCBMaXN0Lm1l
bSB3b3JkICFiYWQgfHwgbm90KGhhc3Zvd2VsIHdvcmQpDQogICAgICB0aGVu
ICgpDQogICAgICBlbHNlDQoJbGV0IHdvcmQgPSBTdHJpbmcudW5jYXBpdGFs
aXplX2FzY2lpIHdvcmQgaW4NCglpZiBMaXN0Lm1lbSB3b3JkIG9rdw0KCXRo
ZW4gKCkNCgllbHNlDQoJbGV0IHJlcyA9DQoJICB0cnkgSGFzaHRibC5maW5k
IHdzZWVuIHdvcmQNCgkgIHdpdGggTm90X2ZvdW5kIC0+DQoJICAgIGxldCBj
bWQgPQ0KCSAgICAgIFByaW50Zi5zcHJpbnRmICJweXRob24gc3BlbGwucHkg
JXMiIHdvcmQgaW4NCgkgICAgbGV0IHYgPSBDb21tb24uY21kX3RvX2xpc3Qg
Y21kIGluDQoJICAgIEhhc2h0YmwuYWRkIHdzZWVuIHdvcmQgdjsNCgkgICAg
diBpbg0KCUxpc3QuaXRlcg0KCSAgKGZ1biB3ZCAtPg0KCSAgICBiYWQgOj0g
d29yZCA6OiAhYmFkOw0KCSAgICBDb21tb24uaGFzaGFkZCBic2VlbiB3b3Jk
IChsb2Msd29yZCxwKSkNCgkgIHJlcykNCiAgICBwaWVjZXMNCiAgZW5kDQoN
CkBzY3JpcHQ6b2NhbWxADQpAQA0KSGFzaHRibC5jbGVhciBzZWVuDQoNCkBp
ZGVudGlmaWVyQA0KaWRlbnRpZmllciBpIDogc2NyaXB0Om9jYW1sKCkgeyBh
ZGQgaSB9Ow0KQEANCmkNCg0KQHIxQA0KY29tbWVudHMgYzsNCnN0YXRlbWVu
dCBTOw0KcG9zaXRpb24gcDsNCkBADQoNClNAY0BwDQoNCkBzY3JpcHQ6b2Nh
bWxADQpjIDw8IHIxLmM7DQpwIDw8IHIxLnA7DQpAQA0KDQpsZXQgYmFkID0g
cmVmIFtdIGluDQpMaXN0Lml0ZXINCihmdW5jdGlvbiBjLT4NCmxldCAoY2Is
Y2ksY2EpID0gYyBpbg0KTGlzdC5pdGVyIChjaGVjayBiYWQgImJlZm9yZSIg
cCkgY2I7DQpMaXN0Lml0ZXIgKGNoZWNrIGJhZCAid2l0aGluIiBwKSBjaTsN
Ckxpc3QuaXRlciAoY2hlY2sgYmFkICJhZnRlciIgcCkgY2EpDQpjDQoNCkBy
MkANCmNvbW1lbnRzIGM7DQpkZWNsYXJhdGlvbiBkOw0KcG9zaXRpb24gcDsN
CkBADQoNCmRAY0BwDQoNCkBzY3JpcHQ6b2NhbWxADQpjIDw8IHIyLmM7DQpw
IDw8IHIyLnA7DQpAQA0KDQpsZXQgYmFkID0gcmVmIFtdIGluDQpMaXN0Lml0
ZXINCihmdW5jdGlvbiBjLT4NCmxldCAoY2IsY2ksY2EpID0gYyBpbg0KTGlz
dC5pdGVyIChjaGVjayBiYWQgImJlZm9yZSIgcCkgY2I7DQpMaXN0Lml0ZXIg
KGNoZWNrIGJhZCAid2l0aGluIiBwKSBjaTsNCkxpc3QuaXRlciAoY2hlY2sg
YmFkICJhZnRlciIgcCkgY2EpDQpjDQoNCkBmaW5hbGl6ZTpvY2FtbEANCmJz
ZWVuIDw8IG1lcmdlLmJzZWVuOw0KQEANCg0KTGlzdC5pdGVyDQogIChmdW4g
YnNlZW4gLT4NCiAgICBIYXNodGJsLml0ZXINCiAgICAgIChmdW4gd29yZCBs
IC0+DQoJbWF0Y2ggIWwgd2l0aA0KCSAgWyhsb2Msd29yZCxwKV0gLT4NCgkg
ICAgQ29jY2lsaWIucHJpbnRfbWFpbg0KCSAgICAgIChQcmludGYuc3ByaW50
ZiAicHJvYmxlbSB3aXRoICVzIGNvbW1lbnQgd29yZDogJXMiIGxvYyB3b3Jk
KQ0KCSAgICAgIHANCgl8IF8gLT4gKCkpDQogICAgICBic2VlbikNCiAgYnNl
ZW4NCg==

--8323329-762518402-1647328290=:2907--
