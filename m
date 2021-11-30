Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B3D4630CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhK3KSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhK3KRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:17:49 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A16BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:14:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so43200498wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 02:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=dBYQclrL1vKJA2hPRXt6KeF9g/jxE7KFkoJRa+VO53I=;
        b=1AfopWS6zkTVa6jdKQAeJJGCeMD6fHQz81yeyoe5PnEej7snZTuH+i2brOhwwuuAKl
         Ad415D20Z29yvG1BpKgjlqjo2EaqbXSgSqpXOvJRlMztKmI4bxG+dQAFegsm+RPTbBi2
         1skDls09LikfsHP40q7JVyi0tnfCtKX/flqYJzfbKJA9QZAatjWyotuq+3AfZANvvkKH
         jJviAflgtTO+clMQg9JcSbSzH129XygWrX/qjFVBFk6/TFo9Gtf3ye4oGKmIGB/K8Svb
         pxexwZQvUToX5cjLUqg2Zzv6hjlwyH9sZCoJtUtbPC7FVF74YUpuR6GQ4d7as9shHY4k
         hUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=dBYQclrL1vKJA2hPRXt6KeF9g/jxE7KFkoJRa+VO53I=;
        b=OhtesihVlWLnT5VL0pYOKo75a9DHZd8ZXAl0VFLas/c4uc7tsVhdwG3Cg0MkfbyVWW
         UjVpbRKZ+eUbwRia5r3x20sQGIyDzk6KrGPuoMMvHoBdI/A5CWwEFVHyhGm8B7HT41vo
         lk9i/BEoR5KX2A0AReAS9UL5uEo/+OYufnxQtG18HEyj9xB/Eg9ViGow3p1Lp2zv90qH
         upeydx5dizj8PQgAKDOHwR746e/txbovEtEGpDjEy3p0E3o6+ciS/i4FHexJt37elN9o
         NjjZJfo3qNe7COe9bLx6TEUzgvZixsTqWzQ+Nh/hgV//mImdv/QX1W8XgS3PzhmnB2sw
         gtQw==
X-Gm-Message-State: AOAM533scaZzX04z7CWEXbhPq9DWcS+lpyWyETFPVJUHUnHRXzycI0q3
        V1txG28FFKhuVfCkA7ImfUOOAw==
X-Google-Smtp-Source: ABdhPJxYuug+7fh9iF3Xer/mVNntASv0BCC/qpNTVPpvQln8yYOB0AEfumefDIRmDn+iSntMtA/T7g==
X-Received: by 2002:adf:a285:: with SMTP id s5mr40497412wra.468.1638267268433;
        Tue, 30 Nov 2021 02:14:28 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id e24sm11990465wra.78.2021.11.30.02.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 02:14:28 -0800 (PST)
References: <20211130093617.103147-1-jbrunet@baylibre.com>
 <alpine.DEB.2.21.2111301104440.30606@lnxricardw1.se.axis.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ricard Wanderlof <ricardw@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: meson: use dev_err_probe
Date:   Tue, 30 Nov 2021 11:13:33 +0100
In-reply-to: <alpine.DEB.2.21.2111301104440.30606@lnxricardw1.se.axis.com>
Message-ID: <1jmtlmeyrg.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUdWUgMzAgTm92IDIwMjEgYXQgMTE6MDYsIFJpY2FyZCBXYW5kZXJsb2YgPHJpY2FyZHdA
YXhpcy5jb20+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgMzAgTm92IDIwMjEsIEplcm9tZSBCcnVuZXQg
d3JvdGU6DQo+DQo+PiBVc2UgZGV2X2Vycl9wcm9iZSgpIGhlbHBlciBmdW5jdGlvbiB0byBoYW5k
bGUgcHJvYmUgZGVmZXJyYWwuDQo+PiBJdCByZW1vdmVzIHRoZSBvcGVuIGNvZGVkIHRlc3QgZm9y
IC1FUFJPQkVfREVGRVIgYnV0IG1vcmUgaW1wb3J0YW50bHksIGl0DQo+PiBzZXRzIHRoZSBkZWZl
cnJhbCByZWFzb24gaW4gZGVidWdmcyB3aGljaCBpcyBncmVhdCBmb3IgZGVidWdnaW5nLg0KPj4g
DQo+PiBTaWduZWQtb2ZmLWJ5OiBKZXJvbWUgQnJ1bmV0IDxqYnJ1bmV0QGJheWxpYnJlLmNvbT4N
Cj4+IC0tLQ0KPj4gwqBzb3VuZC9zb2MvbWVzb24vYWl1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTcgKysrKysrKy0tLS0tLS0tLS0NCj4+IMKgc291bmQvc29jL21lc29uL2F4Zy1m
aWZvLmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysrLS0tLS0tDQo+PiDCoHNvdW5kL3NvYy9t
ZXNvbi9heGctcGRtLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgOSArKystLS0tLS0NCj4+IMKg
c291bmQvc29jL21lc29uL2F4Zy1zcGRpZmluLmPCoMKgwqDCoMKgwqAgfMKgIDYgKystLS0tDQo+
PiDCoHNvdW5kL3NvYy9tZXNvbi9heGctc3BkaWZvdXQuY8KgwqDCoMKgwqAgfMKgIDYgKystLS0t
DQo+PiDCoHNvdW5kL3NvYy9tZXNvbi9heGctdGRtLWZvcm1hdHRlci5jIHwgMTggKysrKysrLS0t
LS0tLS0tLS0tDQo+PiDCoHNvdW5kL3NvYy9tZXNvbi9heGctdGRtLWludGVyZmFjZS5jIHzCoCA5
ICsrKy0tLS0tLQ0KPj4gwqBzb3VuZC9zb2MvbWVzb24vbWVzb24tY2FyZC11dGlscy5jwqAgfMKg
IDQgKystLQ0KPj4gwqBzb3VuZC9zb2MvbWVzb24vdDkwMTUuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqAgOCArKysrLS0tLQ0KPj4gwqA5IGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMo
KyksIDU0IGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvc291bmQvc29jL21lc29u
L2FpdS5jIGIvc291bmQvc29jL21lc29uL2FpdS5jDQo+PiBpbmRleCBiYTE1ZDU3NjJiMGIuLjM3
MDM2YWRmMTRjZSAxMDA2NDQNCj4+IC0tLSBhL3NvdW5kL3NvYy9tZXNvbi9haXUuYw0KPj4gKysr
IGIvc291bmQvc29jL21lc29uL2FpdS5jDQo+PiBAQCAtMjE5LDMxICsyMTksMjkgQEAgc3RhdGlj
IGludCBhaXVfY2xrX2dldChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+PiDCoA0KPj4gwqDCoMKgwqDC
oMKgwqDCoCBhaXUtPnBjbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAicGNsayIpOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoCBpZiAoSVNfRVJSKGFpdS0+cGNsaykpIHsNCj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChQVFJfRVJSKGFpdS0+cGNsaykgIT0gLUVQUk9CRV9ERUZFUikNCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZXJyKGRl
diwgIkNhbid0IGdldCB0aGUgYWl1IHBjbGtcbiIpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoYWl1LT5wY2xrKSwNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiQ2Fu
J3QgZ2V0IHRoZSBhaXUgcGNsa1xuIik7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gUFRSX0VSUihhaXUtPnBjbGspOw0KPj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+
DQo+IEEgbWlub3IgdGhpbmcsIGJ1dCBkZXZfZXJyX3Byb2JlIHJldHVybnMgaXRzIGVyciBhcmd1
bWVudCwgc28gdGhpcyANCj4gY29uc3RydWN0IGNhbiBiZSB3cml0dGVuIG1vcmUgdGVyc2VseSBh
czoNCj4NCj4gCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoYWlvLT5wY2xrKSwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDYW4ndCBnZXQgdGhlIGFp
byBwY2xrXG4iKTsNCj4NCj4gYW5kIHRoYXQgYWxzbyBzZWVtcyB0byBiZSBpbiBjb21tb24gdXNh
Z2Ugd2hlbiBicm93c2luZyBleGlzdGluZyBjb2RlLg0KDQpNaXNzZWQgdGhhdA0KVGhhbmtzIFJp
Y2FyZCwgSSdsbCB1cGRhdGUgdGhlIGNoYW5nZS4NCg0KPg0KPiAvUmljYXJkDQoNCg==
