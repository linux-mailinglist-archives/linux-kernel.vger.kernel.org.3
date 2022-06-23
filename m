Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40396557D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiFWNoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 09:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiFWNoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 09:44:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0A7AE4D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 06:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655991854; x=1687527854;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CA2GXdDU3D+RpZ84/aByoxvbAYl86vygoICUupBJQiw=;
  b=Rgrz45Ux7Kena5qZB7A5ZeLwk8j+DuHpc/Ftp6j2DvxFdMqtiI3owgTL
   qlQAb+NB5bei2N4+GuA9dtlExoQtTZNGrg5hTZTsdAK3n42iRhFzxNkJp
   Zy5YKvvxyvgamF7O3FHYOQaL2VemdFTKblV2CfYlbFmJV/Yajmkr5ijmL
   50QfuVltyZKp9aDw61Ry8Mq8fMVrkrcQvTGB0/FXF8+gMBDPaYQMETw54
   GNBvOTjkwRR/d1sIaGH0S8HlGthSQst+7CtdeuBUSiw51d1N4oabvFmfb
   b16q9mBvYsmz8XDuPKFj7ImBwcpPXB1f4Qf9VbqrROw6CnQ7zUl9r2MsQ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342404902"
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="342404902"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 06:44:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,216,1650956400"; 
   d="scan'208";a="615580537"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 23 Jun 2022 06:44:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 06:44:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 23 Jun 2022 06:44:12 -0700
Received: from fmsmsx612.amr.corp.intel.com ([10.18.126.92]) by
 fmsmsx612.amr.corp.intel.com ([10.18.126.92]) with mapi id 15.01.2308.027;
 Thu, 23 Jun 2022 06:44:12 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "hbh25y@gmail.com" <hbh25y@gmail.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: i915: fix a possible refcount leak in
 intel_dp_add_mst_connector()
Thread-Topic: [PATCH] drm: i915: fix a possible refcount leak in
 intel_dp_add_mst_connector()
Thread-Index: AQHYaPVOIovuOFJtuUiteEuitAUJL61dsg6A
Date:   Thu, 23 Jun 2022 13:44:12 +0000
Message-ID: <2a11c3b90166cbc4a615db24f8dae75cfe31b5ae.camel@intel.com>
References: <20220516071922.22955-1-hbh25y@gmail.com>
In-Reply-To: <20220516071922.22955-1-hbh25y@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCCB86996862164C97D32C755E08D79B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA1LTE2IGF0IDE1OjE5ICswODAwLCBIYW5neXUgSHVhIHdyb3RlOg0KPiBJ
ZiBkcm1fY29ubmVjdG9yX2luaXQgZmFpbHMsIGludGVsX2Nvbm5lY3Rvcl9mcmVlIHdpbGwgYmUg
Y2FsbGVkIHRvIHRha2UgDQo+IGNhcmUgb2YgcHJvcGVyIGZyZWUuIFNvIGl0IGlzIG5lY2Vzc2Fy
eSB0byBkcm9wIHRoZSByZWZjb3VudCBvZiBwb3J0IA0KPiBiZWZvcmUgaW50ZWxfY29ubmVjdG9y
X2ZyZWUuDQoNClJldmlld2VkLWJ5OiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXph
QGludGVsLmNvbT4NCg0KPiANCj4gRml4ZXM6IDA5MWE0ZjkxOTQyYSAoImRybS9pOTE1OiBIYW5k
bGUgZHJtLWxheWVyIGVycm9ycyBpbiBpbnRlbF9kcF9hZGRfbXN0X2Nvbm5lY3RvciIpDQo+IFNp
Z25lZC1vZmYtYnk6IEhhbmd5dSBIdWEgPGhiaDI1eUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9tc3QuYyB8IDEgKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9tc3QuYyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rp
c3BsYXkvaW50ZWxfZHBfbXN0LmMNCj4gaW5kZXggZTMwZTY5OGFhNjg0Li5mN2Q0NmVhM2FmYjkg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZHBfbXN0
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5MTUvZGlzcGxheS9pbnRlbF9kcF9tc3QuYw0K
PiBAQCAtODQxLDYgKzg0MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqaW50ZWxf
ZHBfYWRkX21zdF9jb25uZWN0b3Ioc3RydWN0IGRybV9kcF9tc3RfdG9wb2xvDQo+ICAJcmV0ID0g
ZHJtX2Nvbm5lY3Rvcl9pbml0KGRldiwgY29ubmVjdG9yLCAmaW50ZWxfZHBfbXN0X2Nvbm5lY3Rv
cl9mdW5jcywNCj4gIAkJCQkgRFJNX01PREVfQ09OTkVDVE9SX0Rpc3BsYXlQb3J0KTsNCj4gIAlp
ZiAocmV0KSB7DQo+ICsJCWRybV9kcF9tc3RfcHV0X3BvcnRfbWFsbG9jKHBvcnQpOw0KPiAgCQlp
bnRlbF9jb25uZWN0b3JfZnJlZShpbnRlbF9jb25uZWN0b3IpOw0KPiAgCQlyZXR1cm4gTlVMTDsN
Cj4gIAl9DQoNCg==
