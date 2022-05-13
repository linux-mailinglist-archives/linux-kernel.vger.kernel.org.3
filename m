Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C25261BD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380208AbiEMMWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380207AbiEMMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5DF926C4F9
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652444552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RajI7Fou3WV1UOrt4HTzXn7hYO+l7sBq1MPb5wyAvrw=;
        b=Bzw1/HrPbFs3FRELuVNlwlCMVmtOdMOw+H4ZeCCns8xpJC7mL9IT9sTljj/+EBhf6egM+q
        5guZg+QgKgBQ+e+abQwiyZhT9Wnth20R44RZp4BVo2FU++N4zBXLmD2zDba//u7xhZalNl
        Aq9WsogoWMHuWCXRpBboK8oyBnPNbWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-326-pyTELyo3Pv2X9JQZMlH0Pg-1; Fri, 13 May 2022 08:22:31 -0400
X-MC-Unique: pyTELyo3Pv2X9JQZMlH0Pg-1
Received: by mail-wm1-f71.google.com with SMTP id m186-20020a1c26c3000000b003943e12185dso2863010wmm.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=RajI7Fou3WV1UOrt4HTzXn7hYO+l7sBq1MPb5wyAvrw=;
        b=GsDLqzWmKNoKRWFrVPIR0BNIiP99s2eruLz8qKXI8vRtiRHY9GXDtZRe/EM6GKmnY5
         emYtaJgSbJVN4GsDHYib8V5PojM7Yk2RNt0dSrcCXc2F/bjZqL+9KFbVfI7a0IPZg+5h
         3inEoh/624vyiR0zs1Mi2QF9+J+dExxEpi2CyRFU6cjFf2ILDX5h87AMKGzBW8n2conp
         VgCKtXPH8FXTOQ8LgFG6cGlpNruFXIBNJBGCDp+kM5t2DFYi9NmY3rMAjDV/6xlN7xn3
         duIYfHoB2kblbJ8ixpJtH9ccrEK51psPNN18CZ1XZFy03R3SmY9TEFuC5uEayvAYPg2/
         VKEg==
X-Gm-Message-State: AOAM533TVNp16+DuxKsN9sS/Zw6tt3OwIaIV+2RodP5F6GarnoZC2zJr
        muD/sdUotB/PA9oglHDVjJ6kq8gC3A6xzSStV7ii7XEjAJZ+w+H00G98TR6w9XihmopiZTLesSF
        emnrIVZnh+ehH74g4A7IL5K9o
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr3766936wrf.111.1652444549771;
        Fri, 13 May 2022 05:22:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW53yPnd25RWajf+iwxFPVOI+jAZD0KtesejaHXywxeEg5ovDSWf/7aPX/2b/tRZ0V2Zun+Q==
X-Received: by 2002:a5d:584a:0:b0:20c:5a8b:cee7 with SMTP id i10-20020a5d584a000000b0020c5a8bcee7mr3766922wrf.111.1652444549579;
        Fri, 13 May 2022 05:22:29 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0? ([2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0])
        by smtp.gmail.com with ESMTPSA id k20-20020a7bc414000000b003942a244ee9sm2152115wmi.46.2022.05.13.05.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:22:29 -0700 (PDT)
Message-ID: <400f896ae17c66f9f68d9b5f248c13cd5ece6158.camel@redhat.com>
Subject: Re: [PATCH 5/6] mm/page_alloc: Protect PCP lists with a spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 13 May 2022 14:22:28 +0200
In-Reply-To: <20220512085043.5234-6-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
         <20220512085043.5234-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA1LTEyIGF0IDA5OjUwICswMTAwLCBNZWwgR29ybWFuIHdyb3RlOgo+IEN1
cnJlbnRseSB0aGUgUENQIGxpc3RzIGFyZSBwcm90ZWN0ZWQgYnkgdXNpbmcgbG9jYWxfbG9ja19p
cnFzYXZlIHRvCj4gcHJldmVudCBtaWdyYXRpb24gYW5kIElSUSByZWVudHJhbmN5IGJ1dCB0aGlz
IGlzIGluY29udmVuaWVudC4gUmVtb3RlCj4gZHJhaW5pbmcgb2YgdGhlIGxpc3RzIGlzIGltcG9z
c2libGUgYW5kIGEgd29ya3F1ZXVlIGlzIHJlcXVpcmVkIGFuZAo+IGV2ZXJ5IHRhc2sgYWxsb2Nh
dGlvbi9mcmVlIG11c3QgZGlzYWJsZSB0aGVuIGVuYWJsZSBpbnRlcnJ1cHRzIHdoaWNoCj4gaXMK
PiBleHBlbnNpdmUuCj4gCj4gQXMgcHJlcGFyYXRpb24gZm9yIGRlYWxpbmcgd2l0aCBib3RoIG9m
IHRob3NlIHByb2JsZW1zLCBwcm90ZWN0IHRoZQo+IGxpc3RzIHdpdGggYSBzcGlubG9jay4gVGhl
IElSUS11bnNhZmUgdmVyc2lvbiBvZiB0aGUgbG9jayBpcyB1c2VkCj4gYmVjYXVzZSBJUlFzIGFy
ZSBhbHJlYWR5IGRpc2FibGVkIGJ5IGxvY2FsX2xvY2tfaXJxc2F2ZS4gc3Bpbl90cnlsb2NrCj4g
aXMgdXNlZCBpbiBwcmVwYXJhdGlvbiBmb3IgYSB0aW1lIHdoZW4gbG9jYWxfbG9jayBjb3VsZCBi
ZSB1c2VkCj4gaW5zdGVhZAo+IG9mIGxvY2tfbG9ja19pcnFzYXZlLgo+IAo+IFRoZSBwZXJfY3B1
X3BhZ2VzIHN0aWxsIGZpdHMgd2l0aGluIHRoZSBzYW1lIG51bWJlciBvZiBjYWNoZSBsaW5lcwo+
IGFmdGVyCj4gdGhpcyBwYXRjaCByZWxhdGl2ZSB0byBiZWZvcmUgdGhlIHNlcmllcy4KPiAKPiBz
dHJ1Y3QgcGVyX2NwdV9wYWdlcyB7Cj4gwqDCoMKgwqDCoMKgwqAgc3BpbmxvY2tfdMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvY2s7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyrCoMKgwqDCoCAwwqDCoMKgwqAKPiA0ICovCj4gwqDCoMKgwqDCoMKgwqAgaW50wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb3VudDvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqDCoCA0wqDCoMKgwqAKPiA0ICovCj4gwqDC
oMKgwqDCoMKgwqAgaW50wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBoaWdoO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qwqDCoMKgwqAgOMKg
wqDCoMKgCj4gNCAqLwo+IMKgwqDCoMKgwqDCoMKgIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmF0Y2g7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qwqDCoMKgIDEywqDCoMKgwqAKPiA0ICovCj4gwqDCoMKgwqDCoMKgwqAgc2hvcnQgaW50
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmcmVlX2ZhY3RvcjvCoMKgwqDCoMKg
wqDCoMKgwqAgLyrCoMKgwqAgMTbCoMKgwqDCoAo+IDIgKi8KPiDCoMKgwqDCoMKgwqDCoCBzaG9y
dCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4cGlyZTvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qwqDCoMKgIDE4wqDCoMKgwqAKPiAyICovCj4gCj4gwqDCoMKg
wqDCoMKgwqAgLyogWFhYIDQgYnl0ZXMgaG9sZSwgdHJ5IHRvIHBhY2sgKi8KPiAKPiDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgbGlzdF9oZWFkwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdHNbMTNdO8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyrCoMKgwqAgMjTCoMKgCj4gMjA4ICovCj4gCj4gwqDCoMKg
wqDCoMKgwqAgLyogc2l6ZTogMjU2LCBjYWNoZWxpbmVzOiA0LCBtZW1iZXJzOiA3ICovCj4gwqDC
oMKgwqDCoMKgwqAgLyogc3VtIG1lbWJlcnM6IDIyOCwgaG9sZXM6IDEsIHN1bSBob2xlczogNCAq
Lwo+IMKgwqDCoMKgwqDCoMKgIC8qIHBhZGRpbmc6IDI0ICovCj4gfSBfX2F0dHJpYnV0ZV9fKChf
X2FsaWduZWRfXyg2NCkpKTsKPiAKPiBUaGVyZSBpcyBvdmVyaGVhZCBpbiB0aGUgZmFzdCBwYXRo
IGR1ZSB0byBhY3F1aXJpbmcgdGhlIHNwaW5sb2NrIGV2ZW4KPiB0aG91Z2ggdGhlIHNwaW5sb2Nr
IGlzIHBlci1jcHUgYW5kIHVuY29udGVuZGVkIGluIHRoZSBjb21tb24gY2FzZS4KPiBQYWdlCj4g
RmF1bHQgVGVzdCAoUEZUKSBydW5uaW5nIG9uIGEgMS1zb2NrZXQgcmVwb3J0ZWQgdGhlIGZvbGxv
d2luZyByZXN1bHRzCj4gb24KPiBhIDEgc29ja2V0IG1hY2hpbmUuCj4gCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDUuMTguMC1yYzHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDUuMTguMC0KPiByYzEK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdmFuaWxsYcKgwqDCoMKgwqDCoMKgwqAgbW0tcGNwZHJh
aW4tCj4gdjJyMQo+IEhtZWFuwqDCoMKgwqAgZmF1bHRzL3NlYy0xwqDCoCA4ODYzMzEuNTcxOCAo
wqDCoCAwLjAwJSnCoMKgIDg4NTQ2Mi43NDc5ICjCoCAtCj4gMC4xMCUpCj4gSG1lYW7CoMKgwqDC
oCBmYXVsdHMvc2VjLTPCoCAyMzM3NzA2LjE1ODMgKMKgwqAgMC4wMCUpwqAgMjMzMjEzMC40OTA5
ICrCoCAtCj4gMC4yNCUqCj4gSG1lYW7CoMKgwqDCoCBmYXVsdHMvc2VjLTXCoCAyODUxNTk0LjI4
OTcgKMKgwqAgMC4wMCUpwqAgMjg0NDEyMy45MzA3ICjCoCAtCj4gMC4yNiUpCj4gSG1lYW7CoMKg
wqDCoCBmYXVsdHMvc2VjLTfCoCAzNTQzMjUxLjU1MDcgKMKgwqAgMC4wMCUpwqAgMzUxNjg4OS4w
NDQyICrCoCAtCj4gMC43NCUqCj4gSG1lYW7CoMKgwqDCoCBmYXVsdHMvc2VjLTjCoCAzOTQ3MDk4
LjAwMjQgKMKgwqAgMC4wMCUpwqAgMzkxNjE2Mi44NDc2ICrCoCAtCj4gMC43OCUqCj4gU3RkZGV2
wqDCoMKgIGZhdWx0cy9zZWMtMcKgwqDCoMKgIDIzMDIuOTEwNSAowqDCoCAwLjAwJSnCoMKgwqDC
oCAyMDY1LjA4NDUgKMKgCj4gMTAuMzMlKQo+IFN0ZGRldsKgwqDCoCBmYXVsdHMvc2VjLTPCoMKg
wqDCoCA3Mjc1LjI0NDIgKMKgwqAgMC4wMCUpwqDCoMKgwqAgNjAzMy4yNjIwICjCoAo+IDE3LjA3
JSkKPiBTdGRkZXbCoMKgwqAgZmF1bHRzL3NlYy01wqDCoMKgIDI0NzI2LjAzMjggKMKgwqAgMC4w
MCUpwqDCoMKgIDEyNTI1LjEwMjYgKMKgCj4gNDkuMzQlKQo+IFN0ZGRldsKgwqDCoCBmYXVsdHMv
c2VjLTfCoMKgwqDCoCA5OTc0LjI1NDIgKMKgwqAgMC4wMCUpwqDCoMKgwqAgOTU0My45NjI3ICjC
oMKgCj4gNC4zMSUpCj4gU3RkZGV2wqDCoMKgIGZhdWx0cy9zZWMtOMKgwqDCoMKgIDk0NjguMDE5
MSAowqDCoCAwLjAwJSnCoMKgwqDCoCA3OTU4LjI2MDcgKMKgCj4gMTUuOTUlKQo+IENvZWZmVmFy
wqAgZmF1bHRzL3NlYy0xwqDCoMKgwqDCoMKgwqAgMC4yNTk4ICjCoMKgIDAuMDAlKcKgwqDCoMKg
wqDCoMKgIDAuMjMzMiAowqAKPiAxMC4yNCUpCj4gQ29lZmZWYXLCoCBmYXVsdHMvc2VjLTPCoMKg
wqDCoMKgwqDCoCAwLjMxMTIgKMKgwqAgMC4wMCUpwqDCoMKgwqDCoMKgwqAgMC4yNTg3ICjCoAo+
IDE2Ljg3JSkKPiBDb2VmZlZhcsKgIGZhdWx0cy9zZWMtNcKgwqDCoMKgwqDCoMKgIDAuODY3MCAo
wqDCoCAwLjAwJSnCoMKgwqDCoMKgwqDCoCAwLjQ0MDQgKMKgCj4gNDkuMjElKQo+IENvZWZmVmFy
wqAgZmF1bHRzL3NlYy03wqDCoMKgwqDCoMKgwqAgMC4yODE1ICjCoMKgIDAuMDAlKcKgwqDCoMKg
wqDCoMKgIDAuMjcxNCAowqDCoAo+IDMuNjAlKQo+IENvZWZmVmFywqAgZmF1bHRzL3NlYy04wqDC
oMKgwqDCoMKgwqAgMC4yMzk5ICjCoMKgIDAuMDAlKcKgwqDCoMKgwqDCoMKgIDAuMjAzMiAowqAK
PiAxNS4yOCUpCj4gCj4gVGhlcmUgaXMgYSBzbWFsbCBoaXQgaW4gdGhlIG51bWJlciBvZiBmYXVs
dHMgcGVyIHNlY29uZCBidXQgZ2l2ZW4KPiB0aGF0Cj4gdGhlIHJlc3VsdHMgYXJlIG1vcmUgc3Rh
YmxlLCBpdCdzIGJvcmRlcmxpbmUgbm9pc2UuCj4gCj4gU2lnbmVkLW9mZi1ieTogTWVsIEdvcm1h
biA8bWdvcm1hbkB0ZWNoc2luZ3VsYXJpdHkubmV0Pgo+IFRlc3RlZC1ieTogTWluY2hhbiBLaW0g
PG1pbmNoYW5Aa2VybmVsLm9yZz4KPiBBY2tlZC1ieTogTWluY2hhbiBLaW0gPG1pbmNoYW5Aa2Vy
bmVsLm9yZz4KPiAtLS0KClJldmlld2VkLWJ5OiBOaWNvbGFzIFNhZW56IEp1bGllbm5lIDxuc2Fl
bnpqdUByZWRoYXQuY29tPgoKVGhhbmtzLAoKLS0gCk5pY29sw6FzIFPDoWVuego=

