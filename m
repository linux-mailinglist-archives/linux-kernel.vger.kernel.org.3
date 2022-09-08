Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6C05B24A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiIHRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiIHR3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 13:29:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F90FE4B0
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 10:28:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id g11-20020a17090a4b0b00b001fb5f1e195fso1548160pjh.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=fkUCN+klEeB0C8O4KTf6XwwX3lmq4AKlAYjSP+QKrWg=;
        b=TQP0e+gNeyZeZF4LhUOvDvMP0mvDKb9PD3gHlpQJCFU20Sg0jo4GfxAJgyHfmTQOhN
         5ujRYjXGsBEPsUyljReZRX6cwVwI+wahCmuC1X9Q7EE8pd7D3/1QOVXK6KtlzFh2kAzk
         LzZU5bTXBza2SIns090uig4wkKjA859GvrsyCxlgJtn1H0iM6WmhLQg0W0FO6h+PhAc7
         lhgkBwxpWJV8TuzeZwN7IL5VcJvzgMshC/H7J0WSpypVTqynQdgBl8p7HEK/p9AYzjJt
         Iit2tce6LLhV30OIozALlksZN0VNe1OwLI2V9Qyw1dvRyk9wr7P5ASRy3tagIK66A/7G
         l2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=fkUCN+klEeB0C8O4KTf6XwwX3lmq4AKlAYjSP+QKrWg=;
        b=ZM77RYl0wMoikQ9iKvkJl9bMorgGfna9JBUWu0VBGJRJPqQuM43J6dnVm44/QezB/v
         Y5PRWa1J0G6X5kkopunPoiybrV09fivyeETj81kLmRwq3xZtoUD1HMP+Pw0CF6zyY50B
         B55bZInbiOGu8LIW8zpAPK510P3nZzDhGTpFJGkzH0FujOhEBkV//diTtFDKHGB4XaId
         WR1A/eXad004yaVJ/POV7JLxPHaJ8nWRAJ2Hy6Zl5wrxFIHVaPrB0LC7/ggh6Owfx+by
         moiIF4Ijgrs4/tvv067Yfg9qAcPGcQbxq7Qifi163r9dUm6trY2UajysaTCWTe5sByt9
         iefQ==
X-Gm-Message-State: ACgBeo30/19GPoS9xjYvVRMHgaPi3Jf5Cl3sTK/NWJ2++RSxClzynj20
        bE0tozpRA2Q6l7NEYBOY9xVXAzg=
X-Google-Smtp-Source: AA6agR4aXwvj1xlc5Yx6YP52NxyfF60X5GXz6q+lQ0/3ZeN7+VTy5i0rgyCNPS4+rXReqOVAURvo0RY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:aa7:8008:0:b0:53b:af3e:2f with SMTP id
 j8-20020aa78008000000b0053baf3e002fmr9992766pfi.23.1662658087669; Thu, 08 Sep
 2022 10:28:07 -0700 (PDT)
Date:   Thu, 8 Sep 2022 10:28:06 -0700
In-Reply-To: <20220908145304.3436139-1-pulehui@huaweicloud.com>
Mime-Version: 1.0
References: <20220908145304.3436139-1-pulehui@huaweicloud.com>
Message-ID: <YxomJlABk3fzQ9bQ@google.com>
Subject: Re: [PATCH bpf-next v2 0/2] Fix cgroup attach flags being assigned to
 effective progs
From:   sdf@google.com
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkvMDgsIFB1IExlaHVpIHdyb3RlOg0KPiBGcm9tOiBQdSBMZWh1aSA8cHVsZWh1aUBodWF3
ZWkuY29tPg0KDQo+IFdoZW4gcm9vdC1jZ3JvdXAgYXR0YWNoIG11bHRpIHByb2dzIGFuZCBzdWIt
Y2dyb3VwIGF0dGFjaCBhDQo+IG92ZXJyaWRlIHByb2csIGJwZnRvb2wgd2lsbCBkaXNwbGF5IGlu
Y29ycmVjdGx5IGZvciB0aGUgYXR0YWNoDQo+IGZsYWdzIG9mIHRoZSBzdWItY2dyb3Vw4oCZcyBl
ZmZlY3RpdmUgcHJvZ3M6DQoNCj4gJCBicGZ0b29sIGNncm91cCB0cmVlIC9zeXMvZnMvY2dyb3Vw
IGVmZmVjdGl2ZQ0KPiBDZ3JvdXBQYXRoDQo+IElEICAgICAgIEF0dGFjaFR5cGUgICAgICBBdHRh
Y2hGbGFncyAgICAgTmFtZQ0KPiAvc3lzL2ZzL2Nncm91cA0KPiA2ICAgICAgICBjZ3JvdXBfc3lz
Y3RsICAgbXVsdGkgICAgICAgICAgIHN5c2N0bF90Y3BfbWVtDQo+IDEzICAgICAgIGNncm91cF9z
eXNjdGwgICBtdWx0aSAgICAgICAgICAgc3lzY3RsX3RjcF9tZW0NCj4gL3N5cy9mcy9jZ3JvdXAv
Y2cxDQo+IDIwICAgICAgIGNncm91cF9zeXNjdGwgICBvdmVycmlkZSAgICAgICAgc3lzY3RsX3Rj
cF9tZW0NCj4gNiAgICAgICAgY2dyb3VwX3N5c2N0bCAgIG92ZXJyaWRlICAgICAgICBzeXNjdGxf
dGNwX21lbSA8LSB3cm9uZw0KPiAxMyAgICAgICBjZ3JvdXBfc3lzY3RsICAgb3ZlcnJpZGUgICAg
ICAgIHN5c2N0bF90Y3BfbWVtIDwtIHdyb25nDQo+IC9zeXMvZnMvY2dyb3VwL2NnMS9jZzINCj4g
MjAgICAgICAgY2dyb3VwX3N5c2N0bCAgICAgICAgICAgICAgICAgICBzeXNjdGxfdGNwX21lbQ0K
PiA2ICAgICAgICBjZ3JvdXBfc3lzY3RsICAgICAgICAgICAgICAgICAgIHN5c2N0bF90Y3BfbWVt
DQo+IDEzICAgICAgIGNncm91cF9zeXNjdGwgICAgICAgICAgICAgICAgICAgc3lzY3RsX3RjcF9t
ZW0NCg0KPiBGb3IgY2cxLCBvYnZpb3VzbHksIHRoZSBhdHRhY2ggZmxhZ3Mgb2YgcHJvZzYgYW5k
IHByb2cxMyBjYW4gbm90IGJlDQo+IE9WRVJSSURFLCBhbmQgdGhlIGF0dGFjaCBmbGFncyBvZiBw
cm9nNiBhbmQgcHJvZzEzIGlzIG1lYW5pbmdsZXNzIGZvcg0KPiBjZzEuIFdlIG9ubHkgbmVlZCB0
byBjYXJlIHRoZSBhdHRhY2ggZmxhZ3Mgb2YgcHJvZyB3aGljaCBhdHRhY2hlZCB0bw0KPiBjZzEs
IG90aGVyIHByb2dzIGF0dGFjaCBmbGFncyBzaG91bGQgYmUgb21pdC4gQWZ0ZXIgdGhlc2UgcGF0
Y2hlcywNCj4gdGhlIGFib3ZlIHNpdHVhdGlvbiB3aWxsIHNob3cgYXMgYmVsbG93Og0KDQo+ICQg
YnBmdG9vbCBjZ3JvdXAgdHJlZSAvc3lzL2ZzL2Nncm91cCBlZmZlY3RpdmUNCj4gQ2dyb3VwUGF0
aA0KPiBJRCAgICAgICBBdHRhY2hUeXBlICAgICAgQXR0YWNoRmxhZ3MgICAgIE5hbWUNCj4gL3N5
cy9mcy9jZ3JvdXANCj4gNiAgICAgICAgY2dyb3VwX3N5c2N0bCAgIG11bHRpICAgICAgICAgICBz
eXNjdGxfdGNwX21lbQ0KPiAxMyAgICAgICBjZ3JvdXBfc3lzY3RsICAgbXVsdGkgICAgICAgICAg
IHN5c2N0bF90Y3BfbWVtDQo+IC9zeXMvZnMvY2dyb3VwL2NnMQ0KPiAyMCAgICAgICBjZ3JvdXBf
c3lzY3RsICAgb3ZlcnJpZGUgICAgICAgIHN5c2N0bF90Y3BfbWVtDQo+IDYgICAgICAgIGNncm91
cF9zeXNjdGwgICAgICAgICAgICAgICAgICAgc3lzY3RsX3RjcF9tZW0NCj4gMTMgICAgICAgY2dy
b3VwX3N5c2N0bCAgICAgICAgICAgICAgICAgICBzeXNjdGxfdGNwX21lbQ0KPiAvc3lzL2ZzL2Nn
cm91cC9jZzEvY2cyDQo+IDIwICAgICAgIGNncm91cF9zeXNjdGwgICAgICAgICAgICAgICAgICAg
c3lzY3RsX3RjcF9tZW0NCj4gNiAgICAgICAgY2dyb3VwX3N5c2N0bCAgICAgICAgICAgICAgICAg
ICBzeXNjdGxfdGNwX21lbQ0KPiAxMyAgICAgICBjZ3JvdXBfc3lzY3RsICAgICAgICAgICAgICAg
ICAgIHN5c2N0bF90Y3BfbWVtDQoNCj4gdjI6DQo+IC0gTGltaXQgcHJvZ19jbnQgdG8gYXZvaWQg
b3ZlcmZsb3cuIChKb2huKQ0KPiAtIEFkZCBtb3JlIGRldGFpbCBtZXNzYWdlLg0KDQpKb2huIGFs
c28gcmFpc2VkIGEgZ29vZCBxdWVzdGlvbiBpbiB2MTogdGhlIGZsYWdzIGRvbid0IHNlZW0gdG8N
Cm1ha2Ugc2Vuc2Ugd2hlbiByZXF1ZXN0aW5nIGVmZmVjdGl2ZSBsaXN0LiBTbyBtYXliZSBub3Qg
ZXhwb3J0IHRoZW0NCmF0IGFsbD8NCg0KPiB2MToNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YnBmLzIwMjIwODIwMTIwMjM0LjIxMjEwNDQtMS1wdWxlaHVpQGh1YXdlaS5jb20NCg0KPiBQdSBM
ZWh1aSAoMik6DQo+ICAgIGJwZiwgY2dyb3VwOiBGaXggYXR0YWNoIGZsYWdzIGJlaW5nIGFzc2ln
bmVkIHRvIGVmZmVjdGl2ZSBwcm9ncw0KPiAgICBicGZ0b29sOiBGaXggY2dyb3VwIGF0dGFjaCBm
bGFncyBiZWluZyBhc3NpZ25lZCB0byBlZmZlY3RpdmUgcHJvZ3MNCg0KPiAgIGtlcm5lbC9icGYv
Y2dyb3VwLmMgICAgICAgIHwgNSArKysrLQ0KPiAgIHRvb2xzL2JwZi9icGZ0b29sL2Nncm91cC5j
IHwgOSArKystLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCg0KPiAtLQ0KPiAyLjI1LjENCg0K
