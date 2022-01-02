Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AEB48291F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 05:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiABEy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 23:54:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:36204 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbiABEyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 23:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641099295; x=1672635295;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to;
  bh=ybr9h0Tjlfh98g0+tHbnAWtp1IJZwelyZh6ylaQ0k0w=;
  b=QpqK9AxCjaqSqFJw2g6XZTRDJ1WV0rfBVyTRJc6f3/t+3dB9jnm3m2Wj
   dV+THN8Zwf6BplXCaFRNrQRsqKOmteH5KxnEheEDSpylFrGT6mzj6V5ff
   KnGmPNU+esrzrSSbwLuhUzA77g7uIxBKNox8Vvo61Qr41JslcECOH0v+S
   3t+rcQrXOAKvlZJ3PTvIlC0VsPUn0SlN6+9iADav4CioQYjcBLf8C1C0a
   S76GOZGsZokVuF4FQ+0y4VUwQL8tkUHGxoQ0zbiMUIfNLspd52oKS9MLU
   6qT6Skog8pw9ulhKo3BHDKitwmp9AVHjXFWfcsjWU1i6xloreDy6ZZ+QT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10214"; a="241900492"
X-IronPort-AV: E=Sophos;i="5.88,255,1635231600"; 
   d="scan'208";a="241900492"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 20:54:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,255,1635231600"; 
   d="scan'208";a="759785140"
Received: from gkogo-mobl1.amr.corp.intel.com (HELO [10.209.55.50]) ([10.209.55.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2022 20:54:54 -0800
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org> <YbzhBrimHGGpddDM@archlinux-ax161>
 <YcuhhI2+k0XVuTb1@iki.fi>
From:   Dave Hansen <dave.hansen@intel.com>
Message-ID: <c857c964-89b9-d827-74ec-32cf874e8d8b@intel.com>
Date:   Sat, 1 Jan 2022 20:54:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YcuhhI2+k0XVuTb1@iki.fi>
Content-Type: multipart/mixed;
 boundary="------------A9E940C37A18674D71DEB08B"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A9E940C37A18674D71DEB08B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 12/28/21 3:45 PM, Jarkko Sakkinen wrote:
>> If I can provide any further information or testing, let me know!
> Dave, when is the fix going to be applied [*]?
> 
>> Cheers,
>> Nathan
> [*] https://lore.kernel.org/linux-sgx/YcGTePmWDMOQU1pn@iki.fi/T/#m831a01bdde347f9e0af2c973986fae0499718201

Greg preferred hiding the file as opposed to faking a number in there.
Any testing of the attached would be appreciated.

--------------A9E940C37A18674D71DEB08B
Content-Type: text/x-patch; charset=UTF-8;
 name="sgx-null-ptr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sgx-null-ptr.patch"


From: Dave Hansen <dave.hansen@linux.intel.com>

Nathan Chancellor reported an oops when aceessing the
'sgx_total_bytes' sysfs file:

	https://lore.kernel.org/all/YbzhBrimHGGpddDM@archlinux-ax161/

The sysfs output code accesses the sgx_numa_nodes[] array
unconditionally.  However, this array is allocated during SGX
initialization, which only occurs on systems where SGX is
supported.

If the sysfs file is accessed on systems without SGX support,
sgx_numa_nodes[] is NULL and an oops occurs.

To fix this, hide the entire nodeX/x86/ attribute group on
systems without SGX support using the ->is_visible attribute
group callback.

Fixes: 50468e431335 ("x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node")
Reported-by: Nathan Chancellor <nathan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/kernel/cpu/sgx/main.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff -puN arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr arch/x86/kernel/cpu/sgx/main.c
--- a/arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr	2021-12-20 07:56:38.309584807 -0800
+++ b/arch/x86/kernel/cpu/sgx/main.c	2021-12-20 08:17:28.997705149 -0800
@@ -910,6 +910,16 @@ static ssize_t sgx_total_bytes_show(stru
 }
 static DEVICE_ATTR_RO(sgx_total_bytes);
 
+static umode_t arch_node_attr_is_visible(struct kobject * kobj,
+		struct attribute * attr, int idx)
+{
+	/* Make all x86/ attributes invisible when SGX is not initialized: */
+	if (nodes_empty(sgx_numa_mask))
+		return 0;
+
+	return attr->mode;
+}
+
 static struct attribute *arch_node_dev_attrs[] = {
 	&dev_attr_sgx_total_bytes.attr,
 	NULL,
@@ -918,6 +928,7 @@ static struct attribute *arch_node_dev_a
 const struct attribute_group arch_node_dev_group = {
 	.name = "x86",
 	.attrs = arch_node_dev_attrs,
+	.is_visible = arch_node_attr_is_visible,
 };
 #endif /* CONFIG_NUMA */
 
_

--------------A9E940C37A18674D71DEB08B--
