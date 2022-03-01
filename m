Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBFD4C914A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbiCARQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiCARQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:16:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D01ADAB;
        Tue,  1 Mar 2022 09:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646154957; x=1677690957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=X1c34HXtdEgIl+9aQPS9vy0y8L7rLHVZWQQB8shSRdw=;
  b=TmKxKRIXYBkWfOhw/s8XwNUNkneKBbcnvFcIIev66eT/WIK4WA0NtJwx
   43A1fn9UVYnfpucqnOEdZT19EePj4DnEKEqMTayITCnb1SGXKvaHdYlGb
   0vo952OZvBGlFPxYOcDcWLWm0sSNwV9AAK9nmJ2YQgRNjU6ColsCJW8MB
   5NWm0dinffde/mj+YfKLzUhm+WpuqHFbpCSz6AtnnlT+q/UgZvGKpqUdR
   sNsJmUOAkUrGpGL1wA1tjOfWgjs8wDmUhvmHFh/sMnXnsyllLJNliL03M
   drlHUdVwKW2C00b9Anyco/3GPU2NetfnjfMbLdd7XVEW4wFBICfS7ChK4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252016876"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252016876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 09:15:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="534981666"
Received: from zliu5x-mobl2.amr.corp.intel.com (HELO ldmartin-desk2) ([10.209.113.230])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 09:15:56 -0800
Date:   Tue, 1 Mar 2022 09:15:55 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v9 00/14] module: core code clean up
Message-ID: <20220301171555.tzrqrmhtv2tkxtaj@ldmartin-desk2>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
 <2e2860d7-23e8-63f3-f7d3-bce0aa57a3d0@csgroup.eu>
 <Yh5DU6n7oCRTfbtG@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh5DU6n7oCRTfbtG@bombadil.infradead.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:01:23AM -0800, Luis Chamberlain wrote:
>On Tue, Mar 01, 2022 at 07:44:26AM +0000, Christophe Leroy wrote:
>>
>>
>> Le 01/03/2022 à 01:21, Luis Chamberlain a écrit :
>> >
>> > We should run kmod tests as well.
>> >
>>
>> I tried to build kmod tests, but I get a crazy result:
>>
>>
>> $ ./configure --host=ppc-linux --prefix=/usr/local
>>
>> $ make
>>
>> $ cd testsuite
>>
>> $ make
>>
>> $ file test-list
>> test-list: ELF 32-bit MSB executable, PowerPC or cisco 4500, version 1
>> (SYSV), dynamically linked, interpreter /lib/ld.so.1, for GNU/Linux
>> 3.2.0, with debug_info, not stripped
>>
>> $ file module-playground/mod-loop-a.ko
>> module-playground/mod-loop-a.ko: ELF 64-bit LSB relocatable, x86-64,
>> version 1 (SYSV),
>> BuildID[sha1]=d46956a4fd36d8d3467806c31831c81217a573f5, with debug_info,
>> not stripped
>>
>>
>>
>> How do I get it to crossbuild proper PowerPC module ?

do I understand correctly that you want to crossbuild kmod + kernel
modules to do your test? why?

If you really need it, then beware we just chainload the kernel build
for the out-of-tree modules when compiling the test modules. Something
like this should work:

	make V=1 KDIR=$HOME/p/gfx-internal/linux-arm64/ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- check

But running the cross built binaries is probably not what you want?

Another thing is that unless you are patching kmod binaries or libkmod,
the testsuite won't test much. kmod's testsuite don't test anything on
the kernel side... the kernel part is mocked by the testsuite itself.
Adding proper integration with the kernel part is possible, but not
something ready.

Lucas De Marchi

>
>Lucas?
>
>  Luis
