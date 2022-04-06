Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B18D4F6AAA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 21:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiDFT7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 15:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiDFT7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:59:14 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8685A184B41;
        Wed,  6 Apr 2022 11:12:10 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l26so6009579ejx.1;
        Wed, 06 Apr 2022 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=rXbbQCVhuhsoQHUcvprMC174QHX0agKLOmkRY9IDpdE=;
        b=L2r2dk38UjYEmmQ6Zb889rsVtzKdkRW6mfhmbqlWGD+gzxr+uPHq8LAnvMl4I5ImOI
         OZ4wE6nBgFz+dD+/lkCnD4jl9ltKkvzLMAyiFjnpeCw1KhwZ09pCIpuuMJiE425oLlFk
         Zx6j3VI1DPJ1LpVEHrT6ghtUBRYIHNX5RunsVlKFK/dSnSzSoKU/RSnNKAHU3bWLUKtT
         PhFGNm0cRB+n4l+zHG+Dh7Zpm6/uQ+oGN3rHI8vpfWXgd2RlVCiYBhgM+zplPiRhLYBr
         yQ1bUfHmWwTrJF+wYtfolaGz8wuBY96lROeb+5E5/9ddpZ+H5aFr1+fY8ZZSHi9LivN+
         BSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=rXbbQCVhuhsoQHUcvprMC174QHX0agKLOmkRY9IDpdE=;
        b=0A8giAWBy6oJCWRNiQPGya19Tmfy6hIwjm3T/zdYa8CP5R6EQbgB0SIC8pox/WrjkO
         VfggltCyglhEvIxd0YZdxqMs7PadcW6hZks5TOJujtuinCyypy3mMMJKLEwlGVqbzsrP
         j/cUFMF9dJuNFWLhq1FKrXJBIqi1H8WNS6qvFaJPe6LHdRZFDRPgxHjIzWM8qXsKChYv
         uzyAFOCfOGMM1kR1b1zm1Jork7utnjHd7DGdFh58EoOx6pQFaigsv6HquUJ+QngiQAbC
         OHYYpxVAs+J3n9RAISDp9tCxLfsHh2j7dFt2MGgKcY/EfnTap3Skp3u4c8aTBwIUR7Yk
         z2cw==
X-Gm-Message-State: AOAM530WZWc6blwNakPlC3N3hq0YXPg/Xww8dobVWnamWG42gxIccVvY
        5iWRq0qcJDYHPXKF8KuCNq5YjmDgcmg=
X-Google-Smtp-Source: ABdhPJyH9XlY7jFrDCQzWHAwrBPcC67MWt7UOM/3j6QJrMSUpkz489pT0aMAcALwtywAOHYvRcig6A==
X-Received: by 2002:a17:906:dc8e:b0:6e7:1713:5de9 with SMTP id cs14-20020a170906dc8e00b006e717135de9mr9678902ejc.71.1649268729074;
        Wed, 06 Apr 2022 11:12:09 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id l11-20020a509dcb000000b0041cbaf0ce2asm6146675edk.6.2022.04.06.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:12:07 -0700 (PDT)
Message-ID: <310d20a04bdaf40672592d9ffa950606d2ceaff7.camel@gmail.com>
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Wed, 06 Apr 2022 20:12:07 +0200
In-Reply-To: <e72812a9-1e5b-a826-d490-62ed23d94116@acm.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
         <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
         <87r16bk013.fsf@linaro.org>
         <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
         <87ee2ajuky.fsf@linaro.org>
         <c18a2b359046a14250cafa5a619dbe53f2872b5a.camel@gmail.com>
         <e72812a9-1e5b-a826-d490-62ed23d94116@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTA2IGF0IDEwOjMyIC0wNzAwLCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6
Cj4gPiBJdCdzIHRoZSBTQ1NJIEJTRyBkcml2ZXIsIGluIGZhY3QsIHdlIGRvbid0IGhhdmUgYSBk
ZWRpY2F0ZWQgVUZTCj4gPiBSUE1CCj4gPiBkcml2ZXIgaW4gdGhlIGtlcm5lbC4gUlBNQiBpcyBh
IHdlbGwga25vd24gTFUsIHdlIGFyZSB1c2luZwo+ID4gdXNlcnNwYWNlCj4gPiB0b29scyB0byBp
c3N1ZSBTQ1NJIGNvbW1hbmRzIGRpcmVjdGx5IHRvIHRoZSBVRlMgUlBNQiBMVSB2aWEKPiA+IGlv
Y3RsKCkKPiA+IGZyb20gdGhlIEJTRyBkZXZpY2Ugbm9kZSBpbiB0aGUgL2Rldi9zZy8gZm9sZGVy
Lgo+ID4gCj4gPiBIZXJlIGlzIHRoZSBCU0cgcGFydCBvZiB0aGUgY29kZSBpbiB0aGUgdXNlcnNw
YWNlIHRvb2xzOgo+ID4gCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9faGRyX3Y0Lmd1YXJkID0g
J1EnOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvX2hkcl92NC5wcm90b2NvbCA9IEJTR19QUk9U
T0NPTF9TQ1NJOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvX2hkcl92NC5zdWJwcm90b2NvbCA9
IEJTR19TVUJfUFJPVE9DT0xfU0NTSV9DTUQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqAgaW9faGRy
X3Y0LnJlc3BvbnNlID0gKF9fdTY0KXNlbnNlX2J1ZmZlcjsKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oCBpb19oZHJfdjQubWF4X3Jlc3BvbnNlX2xlbiA9IFNFTlNFX0JVRkZfTEVOOwo+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgIGlvX2hkcl92NC5yZXF1ZXN0X2xlbiA9IGNtZF9sZW47Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgwqAgaW9faGRyX3Y0LnJlcXVlc3QgPSAoX191NjQpY2RiOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgIGlvY3RsKGZkLCBTR19J
TywgJmlvX2hkcl92NCkpCj4gCj4gSGkgQmVhbiwKPiAKPiBJJ20gbm90IHN1cmUgd2hlcmUgdGhl
IGFib3ZlIGNvbWVzIGZyb20/IFRoZSBBbmRyb2lkIFJQTUIgY2xpZW50IHVzZXMKPiBzbGlnaHRs
eSBkaWZmZXJlbnQgY29kZS4gQWRkaXRpb25hbGx5LCB0aGUgcmV0cnkgbG9vcCBhcm91bmQgdGhl
IAo+IHN1Ym1pc3Npb24gb2YgU0cvSU8gY29tbWFuZHMgaXMgdmVyeSBpbXBvcnRhbnQuIFNlZSBh
bHNvIHRoZSAKPiBjaGVja19zZ19pb19oZHIoKSBjYWxsIGluIHNlbmRfdWZzX3JwbWJfcmVxKCku
IFNlZSBhbHNvIAo+IGh0dHBzOi8vY3MuYW5kcm9pZC5jb20vYW5kcm9pZC9wbGF0Zm9ybS9zdXBl
cnByb2plY3QvKy9tYXN0ZXI6c3lzdGVtL2NvcmUvdHJ1c3R5L3N0b3JhZ2UvcHJveHkvcnBtYi5j
Cj4gCj4gCkJhcnQsCgpJdCBpcyBmcm9tIHRoZSB1ZnMtdXRpbHMuCgpTbywgZG8geW91IHZvdGUg
dG8gYWRkIHRoZSBVRlMgUlBNQiBkcml2ZXIgYmFzZWQgb24gdGhpcyBuZXcgZnJhbWV3b3JrCnRv
IHJlc29sdmUgdGhpcyBjb25mbGljdD8KCgpLaW5kIHJlZ2FyZHMsCkJlYW4KCj4gVGhhbmtzLAo+
IAoKCj4gQmFydC4KCg==

