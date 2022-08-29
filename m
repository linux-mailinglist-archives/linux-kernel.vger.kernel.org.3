Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488215A467D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiH2Jvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiH2Jv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:51:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30C5E326
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:51:25 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h1so3977201wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:from:to:cc;
        bh=tOx2tqybefFHeIMLUW+su+XgGbavJfHYGjEPqAfEtak=;
        b=RYKk0fDG8yPKxONFHoSpdDlNNVRBa8zF+ikdW+hDUIfh+D0dOUIanORctEiBjEypK8
         gPTFoc9XdwBgOrXm1/IDyKsi/bdf+i8ThBebydsCJYVUngxxDUhhxQqFL9Yw5WqHE2Qr
         VihDTL9zqrh2gbyVAic3nQ6VJY4525qfn+LE4e6Ffrok2xQ2wV0T6zykyENEKPcM3ZHB
         tB4CYIkfgpRkfI8DIK4bHFVtI3oXP1A2ietFu9qDfyfw0S/owqfBFzXp9VfVxC9OBHS6
         uX1KZG/3Ip8xcIoNrjSjnEmYP+Jgoh6GMpnh+/nj1MsXIrCUy0b0hNTUrOPtoAIwyzBb
         jb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc;
        bh=tOx2tqybefFHeIMLUW+su+XgGbavJfHYGjEPqAfEtak=;
        b=UoQZlF0CRbCz1fVOfMJmvOiLMB82097uHbv96gyLrobmmh3TJLs5P0ZLuFbJFoNdoM
         FSQVApmi4zpupJoi0VJUPkj/aaVLS5Pp3bHGVWdAFYx9a3ucOkvpBPI9YeBVLjweqe08
         lYXbXbMIfy6h2K7qkcRBTrPndq3/u5jUB42R+Z4fWR+9x0p/J670/TxmQfZw/CaFN6fd
         +8VhbEY60rvFj8TRUjUSnHILcrjy26FxG+rYItLp8F2XXfgI2nG7zT7FpIkCLOfcoSGy
         YxbbGLc5y+nRMW0CnMy25nsM/165Qf9dMK1mCrH+5cZJRGGFi5O9US+E7TpGIbsDT0so
         rElw==
X-Gm-Message-State: ACgBeo0/Zl0jpaBqahO6c3TFUFwmi8lFPhnsr5ccMiUHfrSXWMPNpDiK
        7jxpMLZBFI98dASbFyO7/Bvb+52vwW14TQ==
X-Google-Smtp-Source: AA6agR64cwUPnhx/Tf1ejw/jlZS5h7uLh23KiCPqziDo8ptC4sx4Y1k3FIdRq0G7ItXcWgl0sii7YQ==
X-Received: by 2002:a05:600c:1e1c:b0:3a5:b668:4e2 with SMTP id ay28-20020a05600c1e1c00b003a5b66804e2mr6401869wmb.112.1661766683496;
        Mon, 29 Aug 2022 02:51:23 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e15-20020adffc4f000000b0021e51c039c5sm6498175wrs.80.2022.08.29.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 02:51:23 -0700 (PDT)
References: <20220805085716.5635-1-yu.tu@amlogic.com>
 <20220805085716.5635-4-yu.tu@amlogic.com>
 <1jiln0yzgj.fsf@starbuckisacylon.baylibre.com>
 <ed4038fb-c230-fc27-800c-c99bd1770a1c@amlogic.com>
 <4e3cdd6b-5861-8a4f-1df7-af763f77bad5@amlogic.com>
User-agent: mu4e 1.8.7; emacs 28.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH V3 3/6] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Mon, 29 Aug 2022 11:48:21 +0200
In-reply-to: <4e3cdd6b-5861-8a4f-1df7-af763f77bad5@amlogic.com>
Message-ID: <1jsflftm1y.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24gMTUgQXVnIDIwMjIgYXQgMjE6MjAsIFl1IFR1IDx5dS50dUBhbWxvZ2ljLmNvbT4g
d3JvdGU6DQoNCj4+Pj4gKw0KPj4+PiArc3RhdGljIHN0cnVjdCBjbGtfcmVnbWFwIHM0X2hkbWlf
cGxsX2RjbyA9IHsNCj4+Pj4gK8KgwqDCoCAuZGF0YSA9ICYoc3RydWN0IG1lc29uX2Nsa19wbGxf
ZGF0YSl7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuZW4gPSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLA0KPj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAuc2hpZnTCoMKgID0gMjgsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC53aWR0aMKgwqAgPSAxLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4gK8Kg
wqDCoMKgwqDCoMKgIC5tID0gew0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVnX29m
ZiA9IEFOQUNUUkxfSERNSVBMTF9DVFJMMCwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
LnNoaWZ0wqDCoCA9IDAsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53aWR0aMKgwqAg
PSA4LA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5uID0g
ew0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAucmVnX29mZiA9IEFOQUNUUkxfSERNSVBM
TF9DVFJMMCwNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLnNoaWZ0wqDCoCA9IDEwLA0K
Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAud2lkdGjCoMKgID0gNSwNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0sDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAuZnJhYyA9IHsNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgLnJlZ19vZmYgPSBBTkFDVFJMX0hETUlQTExfQ1RSTDEsDQo+Pj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5zaGlmdMKgwqAgPSAwLA0KPj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAud2lkdGjCoMKgID0gMTcsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCB9LA0K
Pj4+PiArwqDCoMKgwqDCoMKgwqAgLmwgPSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IC5yZWdfb2ZmID0gQU5BQ1RSTF9IRE1JUExMX0NUUkwwLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAuc2hpZnTCoMKgID0gMzEsDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53
aWR0aMKgwqAgPSAxLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4gK8KgwqDCoMKgwqDC
oMKgIC5yc3QgPSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC5yZWdfb2ZmID0gQU5B
Q1RSTF9IRE1JUExMX0NUUkwwLA0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2hpZnTC
oMKgID0gMjksDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC53aWR0aMKgwqAgPSAxLA0K
Pj4+PiArwqDCoMKgwqDCoMKgwqAgfSwNCj4+Pj4gK8KgwqDCoCB9LA0KPj4+PiArwqDCoMKgIC5o
dy5pbml0ID0gJihzdHJ1Y3QgY2xrX2luaXRfZGF0YSl7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoCAu
bmFtZSA9ICJoZG1pX3BsbF9kY28iLA0KPj4+PiArwqDCoMKgwqDCoMKgwqAgLm9wcyA9ICZtZXNv
bl9jbGtfcGxsX3JvX29wcywNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIC5wYXJlbnRfZGF0YSA9IChj
b25zdCBzdHJ1Y3QgY2xrX3BhcmVudF9kYXRhIFtdKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHsgLmZ3X25hbWUgPSAieHRhbCIsIH0NCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIH0sDQo+
Pj4+ICvCoMKgwqDCoMKgwqDCoCAubnVtX3BhcmVudHMgPSAxLA0KPj4+PiArwqDCoMKgwqDCoMKg
wqAgLyoNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBEaXNwbGF5IGRpcmVjdGx5IGhhbmRsZSBo
ZG1pIHBsbCByZWdpc3RlcnMgQVRNLCB3ZSBuZWVkDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
Tk9DQUNIRSB0byBrZWVwIG91ciB2aWV3IG9mIHRoZSBjbG9jayBhcyBhY2N1cmF0ZSBhcw0KPj4+
PiArwqDCoMKgwqDCoMKgwqDCoCAqIHBvc3NpYmxlDQo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICov
DQo+Pj4NCj4+PiBJcyBpdCByZWFsbHkgPw0KPj4+DQo+Pj4gR2l2ZW4gdGhhdCBIRE1JIHN1cHBv
cnQgZm9yIHRoZSBzNCBpcyB0aGVyZSB5ZXQsIHRoZQ0KPj4+IGFkZHJlc3NlcyBoYXZlIGNoYW5n
ZXMgYW5kIHRoZSByZWdpb24gaXMgbm8gbG9uZ2VyIGEgc3lzY29uLCBpdCBpcyB0aW1lDQo+Pj4g
Zm9yIHRoZSBIRE1JIGRyaXZlciB0byBnZXQgZml4ZWQuDQo+IFRoZSBIRE1JIFBMTCBpcyBjb25m
aWd1cmVkIGluIHRoZSBVYm9vdCBwaGFzZSBhbmQgZG9lcyBub3QgY2hhbmdlIHRoZQ0KPiBmcmVx
dWVuY3kgaW4gdGhlIGtlcm5lbCBwaGFzZS4gU28gd2UgdXNlIHRoZSBOT0NBQ0hFIGZsYWcgYW5k
DQo+ICJyb19vcHMiLg0KDQpUaGF0J3Mgbm8gcmVhc29uIHRvIHB1dCBOT0NBQ0hFIG9yIHJvLW9w
cw0KDQpJZiB5b3Ugd2FudCB0aGUgZnJlcXVlbmNpZXMgdG8gYmUgc3RhdGljYWxseSBhc3Npbmdl
ZCwgdGhlIGNvcnJlY3Qgd2F5DQp3b3VsZCBiZSB0aHJvdWdoIGFzc2lnbmVkLXJhdGUgaW4gRFQg
SSBndWVzcy4NCg0K
