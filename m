Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A347757F745
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiGXVy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 17:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXVyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 17:54:55 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDABCE26;
        Sun, 24 Jul 2022 14:54:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so11853973edd.0;
        Sun, 24 Jul 2022 14:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=vMHWJT6Caga6Iqszblh0kSChJockxSLzcxtLj1yqRmQ=;
        b=fzyPDXo0XRV37BfmeMt20Jq2W+AvWrq66JJ/rLUHuFPr+t+N/HswC9UvrHZhtdrUy3
         mGfTbw31Kndh81FsuZrun4ojb5r39a5pjr26fxYStcHKnyU+Ba2oB7ocvo9tGHMnonGC
         HWfo0ExEUken17bEt8vrpYWhUENzb8N70MWlOTHDTRhyOSk/X4MZPI+IDtzxb+YAAXUx
         EEW9JFsunM3zQmWPViEYLqTQMm5ryPlzR0aAsGvo47WNBaUBe69oY40Zi3BvagqmrWAO
         t6dCIVJpJI9PdFXvWe+96Uz7b/PqSNDr3BGLcYjZC3hGOQSeq89VAc8YXInzI8g7M47T
         gflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=vMHWJT6Caga6Iqszblh0kSChJockxSLzcxtLj1yqRmQ=;
        b=diU9ZuaMBcShfjWGgMaqGWk97RRehW9lGLyK6/siWqVeZqAMrj+FO/CrmVXWqIumc/
         0MK8FMEUmbTc8QAyHlz7QoEstgOqWt8e8XgvgZI/E2DZApkL6MlWQfBGrUM5GZECHX0C
         Z5rw2E252koBe5tUMMIvgpoJ6f824KGsjL5cXzj6ZJO7yvtETXEHt/7JF6v350CmbTPk
         rte6VuE8FFCMATtbZwue+MwnhARXdtcOE+sTVziY1v2YiaNkGBGFG6Q+Ae9fRmnQnI4+
         cEMeMfhkB8Uk924DX9lcaagjkqnZ/dMTqXsdHm7AgFSc5TyKLNqIOPoHTe1U9QjPsfEE
         DV3g==
X-Gm-Message-State: AJIora/B+3rrIrBF+5kwb0FaTGr7Vv3n1Mq2XiYyIGSkK4htuIXSwpXN
        AK/IKZvBEsC/lhJ/mLa19eU=
X-Google-Smtp-Source: AGRyM1svqPm/Tk1BpVAsO4FM5uAU8WiY5NxJXWLkH3tra2kOyZzRjCjA2ePP8ryz4MmoPrqvmTwEdQ==
X-Received: by 2002:a05:6402:1772:b0:43b:b794:87f8 with SMTP id da18-20020a056402177200b0043bb79487f8mr10364443edb.237.1658699693084;
        Sun, 24 Jul 2022 14:54:53 -0700 (PDT)
Received: from [192.168.3.2] (p4fd59e5d.dip0.t-ipconnect.de. [79.213.158.93])
        by smtp.googlemail.com with ESMTPSA id a6-20020a056402168600b0043bdc47803csm3466372edv.30.2022.07.24.14.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 14:54:52 -0700 (PDT)
Message-ID: <9f4c233f8f6f9288b17859efab0cb22df2452777.camel@gmail.com>
Subject: Re: [PATCH 1/2] scsi: ufs: Add Multi-Circular Queue support
From:   Bean Huo <huobean@gmail.com>
To:     Can Guo <quic_cang@quicinc.com>, bvanassche@acm.org,
        stanley.chu@mediatek.com, adrian.hunter@intel.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, beanhuo@micron.com,
        quic_asutoshd@quicinc.com, quic_nguyenb@quicinc.com,
        quic_ziqichen@quicinc.com, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
Date:   Sun, 24 Jul 2022 23:54:51 +0200
In-Reply-To: <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
References: <1658214120-22772-1-git-send-email-quic_cang@quicinc.com>
         <1658214120-22772-2-git-send-email-quic_cang@quicinc.com>
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

CkhpIENhbi9Bc3V0b3NoCgpBIGZldyBxdWVzdGlvbnMgYWJvdXQgTUNRIGNvbmZpZ3VyYXRpb246
CgoKT24gVHVlLCAyMDIyLTA3LTE5IGF0IDAwOjAxIC0wNzAwLCBDYW4gR3VvIHdyb3RlOgo+IEZy
b206IEFzdXRvc2ggRGFzIDxxdWljX2FzdXRvc2hkQHF1aWNpbmMuY29tPgo+IAo+IEFkZHMgTUNR
IHN1cHBvcnQgdG8gVUZTIGRyaXZlci4KPiAKPiBDby1kZXZlbG9wZWQtYnk6IENhbiBHdW8gPHF1
aWNfY2FuZ0BxdWljaW5jLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBBc3V0b3NoIERhcyA8cXVpY19h
c3V0b3NoZEBxdWljaW5jLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBDYW4gR3VvIDxxdWljX2NhbmdA
cXVpY2luYy5jb20+Cj4gLS0tCj4gCj4gK3ZvaWQgdWZzaGNkX21jcV9jb25maWdfbWFjKHN0cnVj
dCB1ZnNfaGJhICpoYmEpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1MzIgdmFsID0gdWZzaGNkX3Jl
YWRsKGhiYSwgUkVHX1VGU19NQ1FfQ0ZHKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgdmFsICY9IH5N
Q1FfQ0ZHX01BQ19NQVNLOwo+ICvCoMKgwqDCoMKgwqDCoHZhbCB8PSBoYmEtPmRldl9pbmZvLmJx
dWV1ZWRlcHRoIDw8IE1DUV9DRkdfTUFDX09GRlNFVDsKPiArwqDCoMKgwqDCoMKgwqB1ZnNoY2Rf
d3JpdGVsKGhiYSwgdmFsLCBSRUdfVUZTX01DUV9DRkcpOwoKSGVyZSB5b3Ugc2V0IE1heEFjdGl2
ZUNvbW1hbmQgdG8gZGV2X2luZm8uYnF1ZXVlZGVwdGggKHRoaXMgbGltaXQgY29tZXMKZnJvbSBV
RlMgZGV2aWNlcykuIEkgc2VlIGluIHRoZSBxc2l6ZSBjb25maWd1cmF0aW9uIHRoYXQgeW91IHdh
bnQgdG8Kc2V0IHRoZSBxdWV1ZSBkZXB0aCBpbiBlYWNoIEhXIHF1ZXVlIHRvIGJlIGhiYS0+bnV0
cnMgKHRoaXMgbGltaXQgY29tZXMKZnJvbSBVRlNIQ0kpLCAgc2hvdWxkIG5vdCBpdCBiZSBtaW4o
ZGV2aWNlIGxpbWl0LCB1ZnNoY2kgbGltaXQpPwoKPiArfQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh1
ZnNoY2RfbWNxX2NvbmZpZ19tYWMpOwo+ICsKPiAKLi4uCj4gKwo+ICvCoMKgwqDCoMKgwqDCoGZv
cl9lYWNoX2h3X3F1ZXVlKGhiYSwgaSkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqBod3EgPSAmaGJhLT51aHFbaV07Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGh3
cS0+aWQgPSBpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBxc2l6ZSA9IGh3cS0+
bWF4X2VudHJpZXMgKiBNQ1FfRU5UUllfU0laRV9JTl9EV09SRCAtCj4gMTsKCnFzaXplIGlzIGhi
YS0+bnV0cnMsIDMyKjgtMSA9IDI1NSA9MjU2RFcsICBwZXIgZHJhZnQgc3BlYyAsIHNob3VsZCBu
b3QKYmUgOERXIGluIDQuMD8KCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAv
KiBTUUxCQSAqLwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1ZnNtY3Ffd3JpdGVs
KGhiYSwgbG93ZXJfMzJfYml0cyhod3EtPnNxZV9kbWFfYWRkciksCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1DUV9DRkdfbihSRUdf
U1FMQkEsIGkpKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLyogU1FVQkEgKi8K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdWZzbWNxX3dyaXRlbChoYmEsIHVwcGVy
XzMyX2JpdHMoaHdxLT5zcWVfZG1hX2FkZHIpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNQ1FfQ0ZHX24oUkVHX1NRVUJBLCBpKSk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIFNRREFPICovCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVmc21jcV93cml0ZWwoaGJhLCBNQ1FfUk9QX09GRlNFVF9u
KFJPUF9TUUQsIGkpLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBNQ1FfQ0ZHX24oUkVHX1NRREFPLCBpKSk7Cj4gCgouLi4KCj4gwqDC
oMKgwqDCoMKgwqB9Cj4gKwo+ICtvdXQ6Cj4gK8KgwqDCoMKgwqDCoMKgaGJhLT5tY3FfYmFzZSA9
IHJlcy0+YmFzZTsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArCj4gK291dF9lcnI6Cj4g
K8KgwqDCoMKgwqDCoMKgdWZzaGNkX21jcV9yZWxlYXNlX3Jlc291cmNlKGhiYSk7Cj4gK8KgwqDC
oMKgwqDCoMKgcmV0dXJuIHJldDsKPiArfQo+ICsKPiAraW50IHVmc2hjZF9tY3FfaW5pdChzdHJ1
Y3QgdWZzX2hiYSAqaGJhKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IFNjc2lfSG9zdCAq
aG9zdCA9IGhiYS0+aG9zdDsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgdWZzX2h3X3F1ZXVlICpo
d3E7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGksIHJldCA9IDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oGlmICghaXNfbWNxX3N1cHBvcnRlZChoYmEpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gMDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gdWZzaGNkX21jcV9jb25m
aWdfcmVzb3VyY2UoaGJhKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmV0KSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoaGJhLT5kZXYsICJGYWlsZWQgdG8gY29uZmln
IE1DUSByZXNvdXJjZVxuIik7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVy
biByZXQ7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXQgPSB1ZnNo
Y2Rfdm9wc19jb25maWdfbWNxX3JvcChoYmEpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGV2X2VycihoYmEtPmRldiwgIk1DUSBS
dW50aW1lIE9wZXJhdGlvbiBQb2ludGVycyBub3QKPiBjb25maWd1cmVkXG4iKTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBvdXRfZXJyOwo+ICvCoMKgwqDCoMKgwqDCoH0K
PiArCj4gK8KgwqDCoMKgwqDCoMKgaGJhLT5ucl9xdWV1ZXNbSENUWF9UWVBFX0RFRkFVTFRdID0g
bnVtX3Bvc3NpYmxlX2NwdXMoKTsKCjQuMCBzdXBwb3J0cyBtYXhpbXVtIG51bWJlciBvZiBxdWV1
ZXMgaXMgMzIuIGZvciBjcHVzIDwgMzIsIGNwdSB0bwpxdWV1ZSB3aWxsIGJlIDF4MSwgaG93IGFi
b3V0IGNwdXMgPiAzMj8KCj4gK8KgwqDCoMKgwqDCoMKgaGJhLT5ucl9xdWV1ZXNbSENUWF9UWVBF
X1JFQURdID0gMDsKPiArwqDCoMKgwqDCoMKgwqBoYmEtPm5yX3F1ZXVlc1tIQ1RYX1RZUEVfUE9M
TF0gPSAxOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgSENUWF9NQVhfVFlQ
RVM7IGkrKykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaG9zdC0+bnJfaHdfcXVl
dWVzICs9IGhiYS0+bnJfcXVldWVzW2ldOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBob3N0LT5jYW5f
cXVldWUgPSBoYmEtPm51dHJzOwoKQWxzbyBoZXJlLCBjYW5fcXVldWUgaXMgaW5saW5lZCB3aXRo
IHVmc2hjaSBsaW1pdGF0aW9uLCBub3QgdGhlIFVGUwpkZXZpY2UgbGltaXQuCgo+ICvCoMKgwqDC
oMKgwqDCoGhvc3QtPmNtZF9wZXJfbHVuID0gaGJhLT5udXRyczsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgLyogT25lIG1vcmUgcmVzZXJ2ZWQgZm9yIGRldl9jbWRfcXVldWUgKi8KPiArwqDCoMKgwqDC
oMKgwqBoYmEtPm5yX2h3X3F1ZXVlcyA9IGhvc3QtPm5yX2h3X3F1ZXVlcyArIDE7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoGhiYS0+dWhxID0gZGV2bV9rbWFsbG9jKGhiYS0+ZGV2LAouLi4KPiDCoAo+
IMKgwqDCoMKgwqDCoMKgwqB1ZnNoY2RfdHVuZV91bmlwcm9fcGFyYW1zKGhiYSk7Cj4gQEAgLTk2
NDEsNiArOTc3NSwxMCBAQCBpbnQgdWZzaGNkX2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSwgdm9p
ZAo+IF9faW9tZW0gKm1taW9fYmFzZSwgdW5zaWduZWQgaW50IGlycSkKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gb3V0X2Rpc2FibGU7Cj4gwqDCoMKgwqDCoMKgwqDCoH0K
PiDCoAo+ICvCoMKgwqDCoMKgwqDCoGVyciA9IHVmc2hjZF9tY3FfaW5pdChoYmEpOwoKVGhlIGRy
aXZlciB3aWxsIGZvcmNlIHRoZSBjdXN0b21lciB0byB1c2UgTUNRLCBob3cgYWJvdXQgYWRkaW5n
IGEKY29uZmlndXJhdGlvbiBvcHRpb24gZm9yIHRoZSBjdXN0b21lciB0byBjaG9vc2UgKGxpa2Ug
ZU1NQyBDTURRIGRvZXMpPwoKS2luZCByZWdhcmRzLApCZWFuCgoK

