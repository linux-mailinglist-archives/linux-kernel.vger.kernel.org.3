Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578F958324D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbiG0SqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiG0SqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:46:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FD962A42;
        Wed, 27 Jul 2022 10:43:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z18so10059795edb.10;
        Wed, 27 Jul 2022 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=C2Ju39ZLdGUdTnSwgOEZB94uWj4r/akcygfkFhuyTdA=;
        b=iVeMmgCrZrtHa1AAHFSj5VzI8wh9aQnb0x3HAs3cA5lSln5st+kTZWbCfk4bM+Nbrt
         7F1YufeHs69Wyu2UhGoskeRwJDm+G01f76DTt165iM0pSQZnbD/8KjSefw7uEsj3jW/H
         kIlx1UtaAKp9OQMj74ufsLa0bDeoR1/mMjM0M7BQBiRZ9VEeW/95U5pmG6o4lJGGOfVo
         SRzUUzAQ1Mpqs+Mb5OswjO0FRIkDprxDSmPYj1tNG8957jtIFB3SdxWPfcW1hPxpHD43
         Dtu7PuH9D8Ha27HXj4vJPYqcJas7IY0OC5MpuHTamCppSezlaHF0TmTOSoVZ2Ig0wrkJ
         uKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=C2Ju39ZLdGUdTnSwgOEZB94uWj4r/akcygfkFhuyTdA=;
        b=oxI99tUMEnCdLJr/zGZNUerekpw3Vgh+93OB6QFWUYDilNmBKjfe9keIvu1QNoY1ws
         RIKJHhFHmrJKMJjDk4Mzh4uKfXxtBzWlR6l4gDoY1V0pycZ/CncarNU4AvYBdJjmcmYD
         Ta1Ht3TRlFlTqrWYl36LU17ZqrFgk1YohTj11UjuNG4a1F96RUhAncjy2ycGXrjEEdtz
         DLzpr7FBF9Zop2/SiJJjv9Fvyujol2WymsKKEfNDWQBDbaOxv/EQEkhDZBhxNLJcvxOg
         FXMimEVcaplZpRZUsMzjHwLfyE74WjLhtetuJAvS3dbdgX5QUinnkXCqEGg7zcJOh5nm
         Z3sQ==
X-Gm-Message-State: AJIora/HmHQphDwC0b6TP30XUmxxBYkWaTXLsjtAW9GnAVcIuy91raIV
        +hDIxm0lEoTfqNaojoaf2tU=
X-Google-Smtp-Source: AGRyM1uKNauI17QJV0ufqjFQBZKjgQLkYqFfiUDe8XdhtEZ0bep5kJzH3x2r1J1F0TlIwkONs9YFeg==
X-Received: by 2002:a05:6402:3514:b0:43b:d87c:7a99 with SMTP id b20-20020a056402351400b0043bd87c7a99mr23245114edd.43.1658943784036;
        Wed, 27 Jul 2022 10:43:04 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id j16-20020a50ed10000000b0043ab36d6019sm10506558eds.9.2022.07.27.10.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:43:03 -0700 (PDT)
Message-ID: <1f8e95da0c92f92937b5455a45430c939539d524.camel@gmail.com>
Subject: Re: [PATCH v4 4/7] scsi: ufs: wb: Add explicit flush sysfs attribute
From:   Bean Huo <huobean@gmail.com>
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jul 2022 19:43:02 +0200
In-Reply-To: <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
References: <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
         <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
         <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
         <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p5>
         <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIyLTA3LTI3IGF0IDE2OjA4ICswOTAwLCBKaW55b3VuZyBDSE9JIHdyb3RlOgo+
IFRoZXJlIGlzIHRoZSBmb2xsb3dpbmcgcXVpcmsgdG8gYnlwYXNzICJXQiBGbHVzaCIgaW4gV3Jp
dGUgQm9vc3Rlci4KPiAKPiDCoMKgwqDCoMKgwqDCoMKgLSBVRlNIQ0lfUVVJUktfU0tJUF9NQU5V
QUxfV0JfRkxVU0hfQ1RSTAo+IAo+IElmIHRoaXMgcXVpcmsgaXMgbm90IHNldCwgdGhlcmUgaXMg
bm8ga25vYiB0aGF0IGNhbiBjb250cm9sICJXQgo+IEZsdXNoIi4KCj4gCj4gVGhlcmUgYXJlIHRo
cmVlIGZsYWdzIHRoYXQgY29udHJvbCBXcml0ZSBCb29zdGVyIEZlYXR1cmUuCj4gwqDCoMKgwqDC
oMKgwqDCoDEuIFdCIE9OL09GRgo+IMKgwqDCoMKgwqDCoMKgwqAyLiBXQiBIaWJlcm4gRmx1c2gg
T04vT0ZGIChpbXBsaWNpdGx5KQo+IMKgwqDCoMKgwqDCoMKgwqAzLiBXQiBGbHVzaCBPTi9PRkYg
KGV4cGxpY2l0KQo+IAo+IFRoZSBzeXNmcyBhdHRyaWJ1dGUgdGhhdCBjb250cm9scyB0aGUgV0Ig
d2FzIGltcGxlbWVudGVkLiAoMSkKPiAKPiBJbiB0aGUgY2FzZSBvZiAiSGliZXJuIEZsdXNoIiwg
aXQgaXMgYWx3YXlzIGdvb2QgdG8gdHVybiBvbi4KPiBDb250cm9sIG1heSBub3QgYmUgcmVxdWly
ZWQuICgyKQo+IAo+IEZpbmFsbHksICJGbHVzaCIgbWF5IGJlIG5lY2Vzc2FyeSBiZWNhdXNlIHRo
ZSBBdXRvLUhpYmVybjggaXMgbm90Cj4gc3VwcG9ydGVkIGluIGEgc3BlY2lmaWMgZW52aXJvbm1l
bnQuCj4gU28gdGhlIHN5c2ZzIGF0dHJpYnV0ZSB0aGF0IGNvbnRyb2xzIHRoaXMgaXMgbmVjZXNz
YXJ5LiAoMykKPiAKPiBSZXZpZXdlZC1ieTogQXZyaSBBbHRtYW4gPGF2cmkuYWx0bWFuQHdkYy5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogSmlueW91bmcgQ2hvaSA8ai15b3VuZy5jaG9pQHNhbXN1bmcu
Y29tPgo+IC0tLQouLi4KPiAKPiArc3RhdGljIHNzaXplX3Qgd2JfYnVmX2ZsdXNoX2VuX3N0b3Jl
KHN0cnVjdCBkZXZpY2UgKmRldiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpidWYsIHNpemVfdCBjb3Vu
dCkKPiArewo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCB1ZnNfaGJhICpoYmEgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgd2JfYnVmX2ZsdXNoX2Vu
Owo+ICvCoMKgwqDCoMKgwqDCoHNzaXplX3QgcmVzOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAo
dWZzaGNkX2lzX3diX2FsbG93ZWQoaGJhKSAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqAgIShoYmEt
PnF1aXJrcyAmIFVGU0hDSV9RVUlSS19TS0lQX01BTlVBTF9XQl9GTFVTSF9DVFJMKSkgewo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfd2FybihkZXYsICJJdCBpcyBub3QgYWxs
b3dlZCB0byBjb25maWd1cmUgV0IgYnVmCj4gZmx1c2ghXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiAr
CkhpIEoteW91bmcsCgpJIGRvbid0IHVuZGVyc3RhbmQgaGVyZSwgaWYgVUZTSENJX1FVSVJLX1NL
SVBfTUFOVUFMX1dCX0ZMVVNIX0NUUkwgaXMKbm90IHNldCAobWFudWFsIGZsdXNoIGlzIG5vdCBk
aXNhYmxlKSwgc28gd2UgY2Fubm90IG1hbnVhbGx5IGZsdXNoCmJ1ZmZlcj8gb3Igc2hvdWxkIHdl
IGNoZWNrIGlmIEF1dG8tSGliZXJuOCBpcyBzdXBwb3J0ZWQ/CgpLaW5kIHJlZ2FyZHMsCkJlYW4K


