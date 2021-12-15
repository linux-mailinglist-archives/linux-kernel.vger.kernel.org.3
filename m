Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3280F4760A8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbhLOSYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245460AbhLOSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:24:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A55DC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:24:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so44670871ybj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=xJI5EdwovLjkYqJ4qqI2SnNcs8iB8guxmTYndVvJUQQ=;
        b=Ct/AC0OBbFoa0TM04Vmgnm5ceUlUK/P0vpY5Jr8k0zShdwRkNjuL3WfMPsz8dG55be
         nSt4Qua7JfIhSTFjmbuI3FDN/HLzIjZ3LUv81SSAbFNg+oYNZnlfC376DMh6dt9RfNm+
         dztyjD4eWOBbrHPyXNmwsWwedh6MJTCBXMJIstuMLpp4FqkcPTAJzT36JPkgSO3RT1r6
         Vo7nQgzVj4xCmF5l6RyF5Hicz9wJ09mfoGmVY+gaFuHIRGkie/HEvgXKD0Ax47i7CMHZ
         gYdGzTiSo46TqWeI1dZfd9WVuL+VcsT8my23lQ4y4gOIWwYLl3yNx42IzHVNWjmjLBbf
         a0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=xJI5EdwovLjkYqJ4qqI2SnNcs8iB8guxmTYndVvJUQQ=;
        b=Hfw+LGTGiEjhNoA62hWBlCYLax9I/DYe9LyO73GGLCZoa1Gi5RT/87/GsrV04CBheM
         VKyKtjlmeB/4DxL/60qHcJMjBzpDSno0X1gSn8qGLEiz7sMiy8ZezYqpb8Qo3yevuq1p
         JZwGzC3hos3PmnTkTaTwj9RSdlnvHeFpd9qmnTq8tzNLbcv2Gwla57P1Ty4So77Avzqg
         8ENpECXKBtoFWPBkYS4jvKPFtj+5SDg+NT2g7YAE1T1Q9iwRv7D54VbObZi5CGN0opHp
         /bmRyaIFhCuGzp6PH0VqXdKD7vY/0NgBqrNqDSwPwyoc5IfRLb1NG93Cu9ko1FO58AeR
         l+/Q==
X-Gm-Message-State: AOAM533NouY5y4uH7hauKB/T86zYFd/MAXQoqdmuZL4pI3B5KEeCIIij
        9bsX48DZEUOgeBdd4DCATfZ5A0E=
X-Google-Smtp-Source: ABdhPJxiUSapot8BkfCreYvqxut3YGFSlrSfzX4Kwry/rWuBLllzC5m4eNPqu7GLdHjLteustdhlYYw=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:fc03:a91c:4fe0:3b78])
 (user=sdf job=sendgmr) by 2002:a25:cad5:: with SMTP id a204mr7846609ybg.234.1639592668264;
 Wed, 15 Dec 2021 10:24:28 -0800 (PST)
Date:   Wed, 15 Dec 2021 10:24:25 -0800
In-Reply-To: <634c2c87-84c9-0254-3f12-7d993037495c@gmail.com>
Message-Id: <Yboy2WwaREgo95dy@google.com>
Mime-Version: 1.0
References: <462ce9402621f5e32f08cc8acbf3d9da4d7d69ca.1639579508.git.asml.silence@gmail.com>
 <Yboc/G18R1Vi1eQV@google.com> <b2af633d-aaae-d0c5-72f9-0688b76b4505@gmail.com>
 <Ybom69OyOjsR7kmZ@google.com> <634c2c87-84c9-0254-3f12-7d993037495c@gmail.com>
Subject: Re: [PATCH v3] cgroup/bpf: fast path skb BPF filtering
From:   sdf@google.com
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMTUsIFBhdmVsIEJlZ3Vua292IHdyb3RlOg0KPiBPbiAxMi8xNS8yMSAxNzozMywgc2Rm
QGdvb2dsZS5jb20gd3JvdGU6DQo+ID4gT24gMTIvMTUsIFBhdmVsIEJlZ3Vua292IHdyb3RlOg0K
PiA+ID4gT24gMTIvMTUvMjEgMTY6NTEsIHNkZkBnb29nbGUuY29tIHdyb3RlOg0KPiA+ID4gPiBP
biAxMi8xNSwgUGF2ZWwgQmVndW5rb3Ygd3JvdGU6DQo+ID4gPiA+ID4g77+9IC8qIFdyYXBwZXJz
IGZvciBfX2Nncm91cF9icGZfcnVuX2ZpbHRlcl9za2IoKSBndWFyZGVkIGJ5ICANCj4gY2dyb3Vw
X2JwZl9lbmFibGVkLiAqLw0KPiA+ID4gPiA+IO+/vSAjZGVmaW5lIEJQRl9DR1JPVVBfUlVOX1BS
T0dfSU5FVF9JTkdSRVNTKHNrLCAgDQo+IHNrYinvv73vv73vv73vv73vv73vv73vv73vv73vv73v
v73vv73vv73vv73vv73vv73vv73vv70gXA0KPiA+ID4gPiA+IO+/vSAoe++/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBcDQo+
ID4gPiA+ID4g77+977+977+977+977+9IGludCBfX3JldCA9IDA777+977+977+977+977+977+9
77+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+977+9
77+977+977+977+977+977+977+977+9IFwNCj4gPiA+ID4gPiAt77+977+977+9IGlmIChjZ3Jv
dXBfYnBmX2VuYWJsZWQoQ0dST1VQX0lORVRfSU5HUkVTUykp77+977+977+977+977+977+977+9
77+977+977+977+977+977+9IFwNCj4gPiA+ID4gPiAr77+977+977+9IGlmIChjZ3JvdXBfYnBm
X2VuYWJsZWQoQ0dST1VQX0lORVRfSU5HUkVTUykgJiYgc2sgIA0KPiAmJu+/ve+/ve+/ve+/ve+/
ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBcDQo+ID4gPiA+ID4gK++/ve+/ve+/ve+/ve+/ve+/
ve+/vSBDR1JPVVBfQlBGX1RZUEVfRU5BQkxFRCgoc2spLCAgDQo+IENHUk9VUF9JTkVUX0lOR1JF
U1MpKe+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/ve+/vSBcDQo+ID4gPiA+DQo+ID4gPiA+IFdo
eSBub3QgYWRkIHRoaXMgX19jZ3JvdXBfYnBmX3J1bl9maWx0ZXJfc2tiIGNoZWNrIHRvDQo+ID4g
PiA+IF9fY2dyb3VwX2JwZl9ydW5fZmlsdGVyX3NrYj8gUmVzdWx0IG9mIHNvY2tfY2dyb3VwX3B0
cigpIGlzIGFscmVhZHkgIA0KPiB0aGVyZQ0KPiA+ID4gPiBhbmQgeW91IGNhbiB1c2UgaXQuIE1h
eWJlIG1vdmUgdGhlIHRoaW5ncyBhcm91bmQgaWYgeW91IHdhbnQNCj4gPiA+ID4gaXQgdG8gaGFw
cGVuIGVhcmxpZXIuDQo+ID4NCj4gPiA+IEZvciBpbmxpbmluZy4gSnVzdCB3YW50ZWQgdG8gZ2V0
IGl0IGRvbmUgcmlnaHQsIG90aGVyd2lzZSBJJ2xsIGxpa2VseSAgDQo+IGJlDQo+ID4gPiByZXR1
cm5pbmcgdG8gaXQgYmFjayBpbiBhIGZldyBtb250aHMgY29tcGxhaW5pbmcgdGhhdCBJIHNlZSBt
ZWFzdXJhYmxlDQo+ID4gPiBvdmVyaGVhZCBmcm9tIHRoZSBmdW5jdGlvbiBjYWxsIDopDQo+ID4N
Cj4gPiBEbyB5b3UgZXhwZWN0IHRoYXQgZGlyZWN0IGNhbGwgdG8gYnJpbmcgYW55IHZpc2libGUg
b3ZlcmhlYWQ/DQo+ID4gV291bGQgYmUgbmljZSB0byBjb21wYXJlIHRoYXQgaW5saW5lZCBjYXNl
IHZzDQo+ID4gX19jZ3JvdXBfYnBmX3Byb2dfYXJyYXlfaXNfZW1wdHkgaW5zaWRlIG9mIF9fY2dy
b3VwX2JwZl9ydW5fZmlsdGVyX3NrYg0KPiA+IHdoaWxlIHlvdSdyZSBhdCBpdCAocGx1cyBtb3Zl
IG9mZnNldCBpbml0aWFsaXphdGlvbiBkb3duPykuDQoNCj4gU29ycnkgYnV0IHRoYXQgd291bGQg
YmUgd2FzdGUgb2YgdGltZS4gSSBuYWl2ZWx5IGhvcGUgaXQgd2lsbCBiZSB2aXNpYmxlDQo+IHdp
dGggbmV0IGF0IHNvbWUgbW9tZW50IChpZiBub3QgYWxyZWFkeSksIHRoYXQncyBob3cgaXQgd2Fz
IHdpdGggaW9fdXJpbmcsDQo+IHRoYXQncyB3aGF0IEkgc2VlIGluIHRoZSBibG9jayBsYXllci4g
QW5kIGluIGFueXdheSwgaWYganVzdCBvbmUgaW5saW5lZA0KPiB3b24ndCBtYWtlIGEgZGlmZmVy
ZW5jZSwgdGhlbiAxMCB3aWxsLg0KDQpJIGNhbiBwcm9iYWJseSBkbyBtb3JlIGV4cGVyaW1lbnRz
IG9uIG15IHNpZGUgb25jZSB5b3VyIHBhdGNoIGlzDQphY2NlcHRlZC4gSSdtIG1vc3RseSBjb25j
ZXJuZWQgd2l0aCBnZXRzb2Nrb3B0KFRDUF9aRVJPQ09QWV9SRUNFSVZFKS4NCklmIHlvdSBjbGFp
bSB0aGVyZSBpcyB2aXNpYmxlIG92ZXJoZWFkIGZvciBhIGRpcmVjdCBjYWxsIHRoZW4gdGhlcmUN
CnNob3VsZCBiZSB2aXNpYmxlIGJlbmVmaXQgdG8gdXNpbmcgQ0dST1VQX0JQRl9UWVBFX0VOQUJM
RUQgdGhlcmUgYXMNCndlbGwuDQo=
