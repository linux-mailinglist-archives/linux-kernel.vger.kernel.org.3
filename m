Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8645677FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbiGETsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiGETsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:48:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583671A835
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657050489; x=1688586489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=YcyaUw46qwZYJmbyw8c4O2pxaPI/Doz2nUpJKZcvnQc=;
  b=c7OQGQ3bgh7Fg4lTrj7xVs6QfNoZtzxl06UY+Qgfvt+afbE+gQW+YBZc
   jz99eTbOa9/Km8f5TUJqj6OKqk0BJkhMPMUNqSNe2fw+Xz8C1WX5CKXno
   GGSPY/QXlp4zZWHXap9mgugRrqpQ8XeoIhKKaIkf/QDAspaa1u7voxFon
   N24rj0uYbxo1bvxSLDeJVzVpAXhA2GeikmQxXEHn7euhmXdqOgNinj6LP
   SRGqMlXVIPbxEaSCWBpGBS2u+FY+DXw27fffL0mAUKq+qh3WrNsb+Vld9
   DHhbksISkFl9s4Bi8E7WZqdBa8ug+g9dGEwMtM/FLf0taTxtvtt+S3OmA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="263258510"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="263258510"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 12:48:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="839250395"
Received: from tdisanx-mobl.amr.corp.intel.com (HELO [10.209.16.32]) ([10.209.16.32])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 12:48:08 -0700
Content-Type: multipart/mixed; boundary="------------s14tG07WmhEwdC3tgylz9P4X"
Message-ID: <b19da294-ef38-9c78-8c5c-03e3d1cb555d@intel.com>
Date:   Tue, 5 Jul 2022 12:46:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/split_lock: Enable the split lock detect feature on
 Raptor Lake P and Alder Lake N CPUs
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Tony Luck <tony.luck@intel.com>
Cc:     x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <20220701131958.687066-1-fenghua.yu@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220701131958.687066-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------s14tG07WmhEwdC3tgylz9P4X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I have an alternative patch.

Let's just consider the MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT bit to be
architectural.  Are there *ACTUAL* implementations where this is wrong?
 If not, let's just make it part of the architecture.  Intel can then
keep it true forever.

Some documentation which says:

	All processors that enumerate support for MSR_IA32_CORE_CAPS and
	set MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT support split lock 	
	detection.

would suffice, I think.  Just look at the diffstat.  What's not to love?
--------------s14tG07WmhEwdC3tgylz9P4X
Content-Type: text/x-patch; charset=UTF-8; name="split-lock-arch.patch"
Content-Disposition: attachment; filename="split-lock-arch.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L2tlcm5lbC9jcHUvaW50ZWwuYyB8ICAgNTUgKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTgg
aW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCgpkaWZmIC1wdU4gYXJjaC94ODYva2Vy
bmVsL2NwdS9pbnRlbC5jfnNwbGl0LWxvY2stYXJjaCBhcmNoL3g4Ni9rZXJuZWwvY3B1L2lu
dGVsLmMKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9pbnRlbC5jfnNwbGl0LWxvY2stYXJj
aAkyMDIyLTA3LTA1IDEyOjM3OjIxLjI5NDAzNDE4MiAtMDcwMAorKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2ludGVsLmMJMjAyMi0wNy0wNSAxMjo0Mzo0MC40ODM4NDI0NzggLTA3MDAK
QEAgLTEyNjUsMzEgKzEyNjUsMTQgQEAgdm9pZCBoYW5kbGVfYnVzX2xvY2soc3RydWN0IHB0
X3JlZ3MgKnJlZwogfQogCiAvKgotICogQml0cyBpbiB0aGUgSUEzMl9DT1JFX0NBUEFCSUxJ
VElFUyBhcmUgbm90IGFyY2hpdGVjdHVyYWwsIHNvIHRoZXkgc2hvdWxkCi0gKiBvbmx5IGJl
IHRydXN0ZWQgaWYgaXQgaXMgY29uZmlybWVkIHRoYXQgYSBDUFUgbW9kZWwgaW1wbGVtZW50
cyBhCi0gKiBzcGVjaWZpYyBmZWF0dXJlIGF0IGEgcGFydGljdWxhciBiaXQgcG9zaXRpb24u
Ci0gKgotICogVGhlIHBvc3NpYmxlIGRyaXZlciBkYXRhIGZpZWxkIHZhbHVlczoKLSAqCi0g
KiAtIDA6IENQVSBtb2RlbHMgdGhhdCBhcmUga25vd24gdG8gaGF2ZSB0aGUgcGVyLWNvcmUg
c3BsaXQtbG9jayBkZXRlY3Rpb24KLSAqCWZlYXR1cmUgZXZlbiB0aG91Z2ggdGhleSBkbyBu
b3QgZW51bWVyYXRlIElBMzJfQ09SRV9DQVBBQklMSVRJRVMuCi0gKgotICogLSAxOiBDUFUg
bW9kZWxzIHdoaWNoIG1heSBlbnVtZXJhdGUgSUEzMl9DT1JFX0NBUEFCSUxJVElFUyBhbmQg
aWYgc28gdXNlCi0gKiAgICAgIGJpdCA1IHRvIGVudW1lcmF0ZSB0aGUgcGVyLWNvcmUgc3Bs
aXQtbG9jayBkZXRlY3Rpb24gZmVhdHVyZS4KKyAqIE5vdCBhbGwgYml0cyBpbiBNU1JfSUEz
Ml9DT1JFX0NBUFMgYXJlIGFyY2hpdGVjdHVyYWwsIGJ1dAorICogTVNSX0lBMzJfQ09SRV9D
QVBTX1NQTElUX0xPQ0tfREVURUNUIGlzLiAgQWxsIENQVXMgdGhhdCBzZXQKKyAqIGl0IGhh
dmUgc3BsaXQgbG9jayBkZXRlY3Rpb24uCiAgKi8KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgeDg2
X2NwdV9pZCBzcGxpdF9sb2NrX2NwdV9pZHNbXSBfX2luaXRjb25zdCA9IHsKLQlYODZfTUFU
Q0hfSU5URUxfRkFNNl9NT0RFTChJQ0VMQUtFX1gsCQkwKSwKLQlYODZfTUFUQ0hfSU5URUxf
RkFNNl9NT0RFTChJQ0VMQUtFX0wsCQkwKSwKLQlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RF
TChJQ0VMQUtFX0QsCQkwKSwKLQlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChBVE9NX1RS
RU1PTlQsCTEpLAotCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKEFUT01fVFJFTU9OVF9E
LAkxKSwKLQlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChBVE9NX1RSRU1PTlRfTCwJMSks
Ci0JWDg2X01BVENIX0lOVEVMX0ZBTTZfTU9ERUwoVElHRVJMQUtFX0wsCQkxKSwKLQlYODZf
TUFUQ0hfSU5URUxfRkFNNl9NT0RFTChUSUdFUkxBS0UsCQkxKSwKLQlYODZfTUFUQ0hfSU5U
RUxfRkFNNl9NT0RFTChTQVBQSElSRVJBUElEU19YLAkxKSwKLQlYODZfTUFUQ0hfSU5URUxf
RkFNNl9NT0RFTChBTERFUkxBS0UsCQkxKSwKLQlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RF
TChBTERFUkxBS0VfTCwJCTEpLAotCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKFJBUFRP
UkxBS0UsCQkxKSwKKwlYODZfTUFUQ0hfSU5URUxfRkFNNl9NT0RFTChJQ0VMQUtFX1gsCTEp
LAorCVg4Nl9NQVRDSF9JTlRFTF9GQU02X01PREVMKElDRUxBS0VfTCwJMSksCisJWDg2X01B
VENIX0lOVEVMX0ZBTTZfTU9ERUwoSUNFTEFLRV9ELAkxKSwKIAl7fQogfTsKIApAQCAtMTMw
MSwyNCArMTI4NCwyMiBAQCBzdGF0aWMgdm9pZCBfX2luaXQgc3BsaXRfbG9ja19zZXR1cChz
dHJ1CiAJaWYgKGJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9IWVBFUlZJU09SKSkKIAkJcmV0
dXJuOwogCisJLyogQ2hlY2sgZm9yIENQVXMgdGhhdCBoYXZlIHN1cHBvcnQgYnV0IGRvIG5v
dCBlbnVtZXJhdGUgaXQ6ICovCiAJbSA9IHg4Nl9tYXRjaF9jcHUoc3BsaXRfbG9ja19jcHVf
aWRzKTsKLQlpZiAoIW0pCi0JCXJldHVybjsKKwlpZiAobSkKKwkJZ290byBzdXBwb3J0ZWQ7
CiAKLQlzd2l0Y2ggKG0tPmRyaXZlcl9kYXRhKSB7Ci0JY2FzZSAwOgotCQlicmVhazsKLQlj
YXNlIDE6Ci0JCWlmICghY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9DT1JFX0NBUEFCSUxJVElF
UykpCi0JCQlyZXR1cm47Ci0JCXJkbXNybChNU1JfSUEzMl9DT1JFX0NBUFMsIGlhMzJfY29y
ZV9jYXBzKTsKLQkJaWYgKCEoaWEzMl9jb3JlX2NhcHMgJiBNU1JfSUEzMl9DT1JFX0NBUFNf
U1BMSVRfTE9DS19ERVRFQ1QpKQotCQkJcmV0dXJuOwotCQlicmVhazsKLQlkZWZhdWx0Ogor
CWlmICghY3B1X2hhcyhjLCBYODZfRkVBVFVSRV9DT1JFX0NBUEFCSUxJVElFUykpCiAJCXJl
dHVybjsKLQl9CiAKKwlyZG1zcmwoTVNSX0lBMzJfQ09SRV9DQVBTLCBpYTMyX2NvcmVfY2Fw
cyk7CisJaWYgKGlhMzJfY29yZV9jYXBzICYgTVNSX0lBMzJfQ09SRV9DQVBTX1NQTElUX0xP
Q0tfREVURUNUKQorCQlnb3RvIHN1cHBvcnRlZDsKKworCS8qIENQVSBpcyBub3QgaW4gdGhl
IG1vZGVsIGxpc3QgYW5kIGRvZXMgbm90IGhhdmUgdGhlIE1TUiBiaXQ6ICovCisJcmV0dXJu
OworCitzdXBwb3J0ZWQ6CiAJY3B1X21vZGVsX3N1cHBvcnRzX3NsZCA9IHRydWU7CiAJX19z
cGxpdF9sb2NrX3NldHVwKCk7CiB9Cl8K

--------------s14tG07WmhEwdC3tgylz9P4X--
