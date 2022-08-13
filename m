Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FB5591C24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 19:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbiHMRYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 13:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiHMRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 13:24:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE11AEE14;
        Sat, 13 Aug 2022 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660411454; x=1691947454;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=drAJ73d8g21/UQBfJAYbb6kkFeqrg2he9yg5G3knW70=;
  b=l0MfYK/qpLAFr7txnSwWAVZ2h+RBhTHhMiFcAEjqZMYymIu5ckbzC7Y0
   ceUoLpZMpgU7wpbwdEr935yshhS9NXiuiHB/nYL/oqS+Lgd9bTt0MwMA4
   RI+Tb7xuJej2zeevvqSjWoMcnHFpdqGnRIw0WQT48LaPqvVvgdgkvV7a0
   HxwTRXv7FicpNTmK79NR+WkzPbHuc1E/1Thfxewn+vtItbb5wKjm+IRUF
   9BIFUMu03OLfBfqA76ydyaLhIZOhXkCERayihV5OvBM1lz1RPINaOwksZ
   xgpCb2DGQkn0lptgGWIEmrR2/JaKOW/xdjqqbo3M3lBIZ+3hGAC9uOBxy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="293036684"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="293036684"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:24:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="666184563"
Received: from zhenghwe-mobl.gar.corp.intel.com ([10.214.145.151])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 10:24:09 -0700
Message-ID: <a5d596ca81243ba446be012a0f6d3bc01582f01f.camel@intel.com>
Subject: Re: [PATCH 3/7] hwmon/coretemp: Handle large core id value
From:   Zhang Rui <rui.zhang@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        len.brown@intel.com
Date:   Sun, 14 Aug 2022 01:24:01 +0800
In-Reply-To: <20220812171600.GB2960077@roeck-us.net>
References: <20220812164144.30829-1-rui.zhang@intel.com>
         <20220812164144.30829-4-rui.zhang@intel.com>
         <20220812171600.GB2960077@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.1-0ubuntu1 
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

SGksIEd1ZW50ZXIsCgpPbiBGcmksIDIwMjItMDgtMTIgYXQgMTA6MTYgLTA3MDAsIEd1ZW50ZXIg
Um9lY2sgd3JvdGU6Cj4gCj4gPiAtwqDCoMKgwqDCoMKgwqAvKiBUaGUgY29yZSBpZCBpcyB0b28g
YmlnLCBqdXN0IHJldHVybiAqLwo+ID4gLcKgwqDCoMKgwqDCoMKgaW5keCA9IFRPX0FUVFJfTk8o
Y3B1KTsKPiA+IC3CoMKgwqDCoMKgwqDCoGlmIChpbmR4ID4gTUFYX0NPUkVfREFUQSAtIDEpCj4g
PiArwqDCoMKgwqDCoMKgwqBwZCA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOwo+ID4gKwo+
ID4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0gMDsgaSA8IE5VTV9SRUFMX0NPUkVTOyBpKyspIHsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocGQtPmNwdV9tYXBbaV0gPT0g
dG9wb2xvZ3lfY29yZV9pZChjcHUpKSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGluZHggPSBpICsgQkFTRV9TWVNGU19BVFRSX05POwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiAr
Cj4gPiArwqDCoMKgwqDCoMKgwqAvKiBUb28gbWFueSBjb3JlcyBhbmQgdGhpcyBjb3JlIGlzIG5v
dCBwdXBvbGF0ZWQsIGp1c3QKPiA+IHJldHVybiAqLwo+IAo+IHBvcHVsYXRlZAo+IAo+IE90aGVy
IHRoYW4gdGhhdCBsb29rcyBnb29kLgo+IAo+IEFja2VkLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51
eEByb2Vjay11cy5uZXQ+CgpUaGFua3MgZm9yIHJldmlld2luZywgd2lsbCBmaXggaW4gbmV4dCB2
ZXJzaW9uLgoKdGhhbmtzLApydWkK

