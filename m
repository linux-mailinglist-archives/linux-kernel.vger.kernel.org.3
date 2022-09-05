Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A975AD2A6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 14:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiIEMaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiIEMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 08:30:15 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7F60693;
        Mon,  5 Sep 2022 05:26:28 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5587842wmb.4;
        Mon, 05 Sep 2022 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=tAW3My05WCTmzHfQ20v4+422b2rUR8g6mM7zB5mCK5c=;
        b=H4qfO4cL2opf/Oims/aoUBSsApZKqNzReLWDBf21NNU3zOzkUVzYu9/ukGsOp7JdbB
         9M+uMTZMSauTYXRMVl/5ps7yjrG3ZPGf1USr/PieL2z4r/6SWBSsARzsiKoNvrGMeLjf
         gmdgtaoeoQub7Hh4wZ2FfJwsajmPfapVUgwNg/vJDkOZezFwWpa5ZpsrRWaGNI+cXoyE
         mfCT48BrURA9yeWXhe+PmwQKxbEGHnc/j2xik+wbgRUFK9aoC/8IN/fwI9UmJxx3yCnw
         GO3nw40TKiUQl89+pHR42XU5m6b5QmimoPYdkH3pQNfn9fxcNGU9oMQoroOPyMRUaNlZ
         KRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=tAW3My05WCTmzHfQ20v4+422b2rUR8g6mM7zB5mCK5c=;
        b=RNwa+fezx0hZaoneXl67XYmysK/EuSwT0fzFPV8LLJ6Kq13ObFJ5ge0I8suD8Dr+DK
         tVpZEb2yTVrAhva/o+OuAHfUzn4USty/GP+NhspJUWoMBYwcL1VC2V9FE6CG/TlBuozc
         yzbtdEqhnR51jXXnRLC1CkhXiGppvnoKco6D34qxo2Cx3yu7/9PF6lWzxAqv47r/sOGa
         23irtPyEQQry53aTxUmjlGNBbEG2ql6nxRHwAB4dn9WXHFmwvzTp9sNK9FlHXu5aY5Dt
         PRNbWDbDaK4u/bumnabZZFkYipifl2rhEGoViqYcuQpOCoLnZd4cqXfrT5FL/8hqJ8hu
         cIwg==
X-Gm-Message-State: ACgBeo2mfz5jEiMGJuz0/Y+ohL4yhR2fmE0CbABftjUSag9uFy1TW+6K
        I5sY+YjO+GxU2vWgwGu6WTU=
X-Google-Smtp-Source: AA6agR5k4PoyPjWt82Qnzkt4tXrp7SK1j65iKZUj6dX3ITrjRqYQNa1z4jEW70ny5h5k3QSCdq4K2A==
X-Received: by 2002:a05:600c:2193:b0:3a5:346f:57d0 with SMTP id e19-20020a05600c219300b003a5346f57d0mr10430095wme.124.1662380768536;
        Mon, 05 Sep 2022 05:26:08 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id c11-20020a5d528b000000b0021e42e7c7dbsm8441891wrv.83.2022.09.05.05.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 05:26:08 -0700 (PDT)
Message-ID: <6e594dc2ce6103884b7768c2fed55eabec0d5ed8.camel@gmail.com>
Subject: Re: [RFC PATCH v3 1/4] ufs: core: prepare ufs for multi circular
 queue support
From:   Bean Huo <huobean@gmail.com>
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_xiaosenh@quicinc.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, bvanassche@acm.org, avri.altman@wdc.com,
        mani@kernel.org, quic_cang@quicinc.com, beanhuo@micron.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Sep 2022 14:26:06 +0200
In-Reply-To: <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
References: <cover.1662157846.git.quic_asutoshd@quicinc.com>
         <757bbfe36629b7c31ef2630971f8678a7801223f.1662157846.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
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

QXN1dG9zaCwKCgpPbiBGcmksIDIwMjItMDktMDIgYXQgMTU6NDEgLTA3MDAsIEFzdXRvc2ggRGFz
IHdyb3RlOgo+IFByZXBhcmF0b3J5IGNoYW5nZXMgZm9yIHVwY29taW5nIG11bHRpIGNpcmN1bGFy
IHF1ZXVlLgo+IAo+IENvLWRldmVsb3BlZC1ieTogQ2FuIEd1byA8cXVpY19jYW5nQHF1aWNpbmMu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IENhbiBHdW8gPHF1aWNfY2FuZ0BxdWljaW5jLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBBc3V0b3NoIERhcyA8cXVpY19hc3V0b3NoZEBxdWljaW5jLmNvbT4KPiAt
LS0KPiDCoGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgfCA5OSArKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tCj4gLS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDUzIGlu
c2VydGlvbnMoKyksIDQ2IGRlbGV0aW9ucygtKQo+IAo+IAo+IMKgCj4gQEAgLTIxMzQsMTQgKzIx
MzUsMTQgQEAgc3RhdGljIHZvaWQgdWZzaGNkX3VwZGF0ZV9tb25pdG9yKHN0cnVjdAo+IHVmc19o
YmEgKmhiYSwgY29uc3Qgc3RydWN0IHVmc2hjZF9scmIgKgo+IMKgICogQHRhc2tfdGFnOiBUYXNr
IHRhZyBvZiB0aGUgY29tbWFuZAo+IMKgICovCgpZb3UgZGlkbid0IGNoYW5nZSBwYXJhbWV0ZXIg
bmFtZSBpbiB0aGUgZnVuY3Rpb24gZGVzY3JpcHRpb24uCgo+IMKgc3RhdGljIGlubGluZQo+IC12
b2lkIHVmc2hjZF9zZW5kX2NvbW1hbmQoc3RydWN0IHVmc19oYmEgKmhiYSwgdW5zaWduZWQgaW50
IHRhc2tfdGFnKQo+ICt2b2lkIHVmc2hjZF9zZW5kX2NvbW1hbmQoc3RydWN0IHVmc19oYmEgKmhi
YSwgc3RydWN0IHVmc2hjZF9scmIKPiAqbHJicCkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgdWZzaGNkX2xyYiAqbHJicCA9ICZoYmEtPmxyYlt0YXNrX3RhZ107Cj4gK8KgwqDCoMKgwqDC
oMKgaW50IHRhc2tfdGFnID0gbHJicC0+dGFza190YWc7Cj4gwqDCoMKgwqDCoMKgwqDCoHVuc2ln
bmVkIGxvbmcgZmxhZ3M7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgbHJicC0+aXNzdWVfdGltZV9z
dGFtcCA9IGt0aW1lX2dldCgpOwo+IMKgwqDCoMKgwqDCoMKgwqBscmJwLT5jb21wbF90aW1lX3N0
YW1wID0ga3RpbWVfc2V0KDAsIDApOwo+IC3CoMKgwqDCoMKgwqDCoHVmc2hjZF9hZGRfY29tbWFu
ZF90cmFjZShoYmEsIHRhc2tfdGFnLCBVRlNfQ01EX1NFTkQpOwo+ICvCoMKgwqDCoMKgwqDCoHVm
c2hjZF9hZGRfY29tbWFuZF90cmFjZShoYmEsIGxyYnAsIFVGU19DTURfU0VORCk7Cj4gwqDCoMKg
wqDCoMKgwqDCoHVmc2hjZF9jbGtfc2NhbGluZ19zdGFydF9idXN5KGhiYSk7Cj4gwqDCoMKgwqDC
oMKgwqDCoGlmICh1bmxpa2VseSh1ZnNoY2Rfc2hvdWxkX2luZm9ybV9tb25pdG9yKGhiYSwgbHJi
cCkpKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWZzaGNkX3N0YXJ0X21vbml0
b3IoaGJhLCBscmJwKTsKPiBAQCAtMjU1Myw5ICsyNTU0LDEwIEBAIHZvaWQgdWZzaGNkX3ByZXBh
cmVfdXRwX3Njc2lfY21kX3VwaXUoc3RydWN0Cj4gdWZzaGNkX2xyYiAqbHJicCwgdTggdXBpdV9m
bGFncykKPiDCoMKgwqDCoMKgwqDCoMKgLyogY29tbWFuZCBkZXNjcmlwdG9yIGZpZWxkcyAqLwo+
IMKgwqDCoMKgwqDCoMKgwqB1Y2RfcmVxX3B0ci0+aGVhZGVyLmR3b3JkXzAgPSBVUElVX0hFQURF
Ul9EV09SRCgKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgVVBJVV9UUkFOU0FDVElPTl9DT01NQU5ELCB1cGl1X2ZsYWdzLAo+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGxyYnAtPmx1biwgbHJicC0+dGFza190YWcpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxyYnAtPmx1biwgbHJi
cC0+dGFza190YWcgJiAweGZmKTsKPiDCoMKgwqDCoMKgwqDCoMKgdWNkX3JlcV9wdHItPmhlYWRl
ci5kd29yZF8xID0gVVBJVV9IRUFERVJfRFdPUkQoCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgVVBJVV9DT01NQU5EX1NFVF9U
WVBFX1NDU0ksIDAsIDAsIDApOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFVQSVVfQ09NTUFORF9TRVRfVFlQRV9TQ1NJLCAw
LCAwLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoChscmJwLT50YXNrX3RhZyAmIDB4ZjAwKSA8PCA0KTsKPiDCoAoKQXJlIHlv
dSBzdXJlIGhlcmUgIihscmJwLT50YXNrX3RhZyAmIDB4ZjAwKSA8PCA0IiBpcyBjb3JyZWN0PyAK
Cgp0aGlzIHdpbGwgb3ZlcndyaXRlIG90aGVyIGZpZWxkcywgc2VlIFVQSVVfSEVBREVSX0RXT1JE
OgoKI2RlZmluZSBVUElVX0hFQURFUl9EV09SRChieXRlMywgYnl0ZTIsIGJ5dGUxLCBieXRlMClc
CiAgICAgICAgICAgICAgICAgICAgICAgIGNwdV90b19iZTMyKChieXRlMyA8PCAyNCkgfCAoYnl0
ZTIgPDwgMTYpIHxcCiAgICAgICAgICAgICAgICAgICAgICAgICAoYnl0ZTEgPDwgOCkgfCAoYnl0
ZTApKQoKCgo+IAo+IMKgCj4gLcKgwqDCoMKgwqDCoMKgdWZzaGNkX3NlbmRfY29tbWFuZChoYmEs
IHRhZyk7Cj4gK8KgwqDCoMKgwqDCoMKgdWZzaGNkX3NlbmRfY29tbWFuZChoYmEsIGxyYnApOwo+
IMKgwqDCoMKgwqDCoMKgwqBlcnIgPSB1ZnNoY2Rfd2FpdF9mb3JfZGV2X2NtZChoYmEsIGxyYnAs
IHRpbWVvdXQpOwo+IMKgwqDCoMKgwqDCoMKgwqB1ZnNoY2RfYWRkX3F1ZXJ5X3VwaXVfdHJhY2Uo
aGJhLCBlcnIgPyBVRlNfUVVFUllfRVJSIDoKPiBVRlNfUVVFUllfQ09NUCwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIChzdHJ1Y3QgdXRwX3VwaXVfcmVxICopbHJicC0KPiA+dWNkX3JzcF9wdHIpOwo+IEBAIC00
NTEzLDYgKzQ1MTUsNyBAQCBpbnQgdWZzaGNkX21ha2VfaGJhX29wZXJhdGlvbmFsKHN0cnVjdCB1
ZnNfaGJhCj4gKmhiYSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBSRUdfVVRQX1RSQU5TRkVSX1JFUV9MSVNUX0JBU0VfTCk7Cj4gwqDCoMKgwqDCoMKg
wqDCoHVmc2hjZF93cml0ZWwoaGJhLCB1cHBlcl8zMl9iaXRzKGhiYS0+dXRyZGxfZG1hX2FkZHIp
LAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFJFR19V
VFBfVFJBTlNGRVJfUkVRX0xJU1RfQkFTRV9IKTsKPiArCj4gwqDCoMKgwqDCoMKgwqDCoHVmc2hj
ZF93cml0ZWwoaGJhLCBsb3dlcl8zMl9iaXRzKGhiYS0+dXRtcmRsX2RtYV9hZGRyKSwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBSRUdfVVRQX1RBU0tf
UkVRX0xJU1RfQkFTRV9MKTsKPiDCoMKgwqDCoMKgwqDCoMKgdWZzaGNkX3dyaXRlbChoYmEsIHVw
cGVyXzMyX2JpdHMoaGJhLT51dG1yZGxfZG1hX2FkZHIpLAo+IEBAIC01MzIwLDYgKzUzMjMsMzIg
QEAgc3RhdGljIHZvaWQgdWZzaGNkX3JlbGVhc2Vfc2NzaV9jbWQoc3RydWN0Cj4gdWZzX2hiYSAq
aGJhLAo+IMKgwqDCoMKgwqDCoMKgwqB1ZnNoY2RfY2xrX3NjYWxpbmdfdXBkYXRlX2J1c3koaGJh
KTsKPiDCoH0KPiDCoAo+ICt2b2lkIHVmc2hjZF9jb21wbF9vbmVfY3FlKHN0cnVjdCB1ZnNfaGJh
ICpoYmEsIGludCB0YXNrX3RhZykKClRoaXMgZnVuY3Rpb24gZG9lcyBvbmx5IGNvbXBsZXRlIG9u
ZSB0YXNrLiBXaGF0IGRvZXMgY3FlIHN0YW5kIGZvcj8KCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgdWZzaGNkX2xyYiAqbHJicDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2NzaV9jbW5k
ICpjbWQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGxyYnAgPSAmaGJhLT5scmJbdGFza190YWddOwo+
ICvCoMKgwqDCoMKgwqDCoGxyYnAtPmNvbXBsX3RpbWVfc3RhbXAgPSBrdGltZV9nZXQoKTsKPiAr
wqDCoMKgwqDCoMKgwqBjbWQgPSBscmJwLT5jbWQ7Cj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNtZCkg
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAodW5saWtlbHkodWZzaGNkX3No
b3VsZF9pbmZvcm1fbW9uaXRvcihoYmEsCj4gbHJicCkpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWZzaGNkX3VwZGF0ZV9tb25pdG9yKGhiYSwgbHJi
cCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVmc2hjZF9hZGRfY29tbWFuZF90
cmFjZShoYmEsIGxyYnAsIFVGU19DTURfQ09NUCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGNtZC0+cmVzdWx0ID0gdWZzaGNkX3RyYW5zZmVyX3JzcF9zdGF0dXMoaGJhLCBscmJw
KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWZzaGNkX3JlbGVhc2Vfc2NzaV9j
bWQoaGJhLCBscmJwKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogRG8gbm90
IHRvdWNoIGxyYnAgYWZ0ZXIgc2NzaSBkb25lICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHNjc2lfZG9uZShjbWQpOwo+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAobHJicC0+
Y29tbWFuZF90eXBlID09IFVUUF9DTURfVFlQRV9ERVZfTUFOQUdFIHx8Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbHJicC0+Y29tbWFuZF90eXBlID09IFVUUF9DTURfVFlQ
RV9VRlNfU1RPUkFHRSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaGJh
LT5kZXZfY21kLmNvbXBsZXRlKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqB1ZnNoY2RfYWRkX2NvbW1hbmRfdHJhY2UoaGJhLCBscmJwLAo+IFVGU19E
RVZfQ09NUCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBjb21wbGV0ZShoYmEtPmRldl9jbWQuY29tcGxldGUpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWZzaGNkX2Nsa19zY2FsaW5nX3VwZGF0ZV9idXN5
KGhiYSk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKg
wqB9Cj4gK30KPiArCgoKS2luZCByZWdhcmRzLApCZWFuCgo=

