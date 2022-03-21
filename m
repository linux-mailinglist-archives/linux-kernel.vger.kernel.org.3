Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75A4E1F1B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiCUCox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbiCUCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:44:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB520B;
        Sun, 20 Mar 2022 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647830603; x=1679366603;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=I+HE8aeKfC1xV+LiM5SCNvJ9J2P8mDQI8RqPWqB1Ajg=;
  b=f/0VZVmUGN8sNofhWobe+POK2Wv1VrZZKLpwW110ZCSPwNF5eiV3wF0o
   Eog5OLj0V09BzwXJX+l9gFth2KcW9eIpHYQShp/QevRuIJ7zPl0zFnef0
   MQjOWDD/XXzP73/zQmFmkKHdLuOrZD0AmgNYm6SMxiraZRMM4wTWXgps8
   1tzUm2tGJeQADr9WQqN9Q+FyBb66nWYF3BvB052wMIE6IW9zHme2QK0pd
   AoJpgpz7qmC23HJIdlLVLiv9qNU1msvhRsX7yKgFx5cpy9IPC47ksASY2
   M9uSNiTTD0vuR1UpKkthDfqyBCd3xnStjepItyU7wR9/IMGcQE98Z/2F7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="320659506"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="320659506"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 19:43:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="500010768"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 19:43:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "myron.stowe@redhat.com" <myron.stowe@redhat.com>,
        "Brown, Len" <len.brown@intel.com>
Subject: Re: [BUG] kernel side can NOT trigger memory error with einj
References: <8c40a492-9461-2b43-6ec9-06bfc7a0e77f@linux.alibaba.com>
        <YjIeff7ESJB/amYA@agluck-desk3.sc.intel.com>
        <f93a5532-3e07-edf4-38ca-142a0f1d78d7@linux.alibaba.com>
        <1421c3ac3d3c4438a6ff18f193f8a41c@intel.com>
        <78cefd4c-f735-2ec4-0c09-35c8191280c5@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 10:43:16 +0800
In-Reply-To: <78cefd4c-f735-2ec4-0c09-35c8191280c5@linux.alibaba.com> (Shuai
        Xue's message of "Sun, 20 Mar 2022 21:11:58 +0800")
Message-ID: <87wngoc9ff.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuai Xue <xueshuai@linux.alibaba.com> writes:

> =E5=9C=A8 2022/3/18 AM12:57, Luck, Tony =E5=86=99=E9=81=93:
>>> -       rc =3D apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR);
>>> +       ptr =3D kmap(pfn_to_page(pfn));
>>> +       tmp =3D *(ptr + (param1 & ~ PAGE_MASK));
>>=20
>> That hack works when the trigger action is just trying to access the inj=
ected
>> location. But on Intel platforms the trigger "kicks" the patrol scrubber=
 in the
>> memory controller to access the address. So the error is triggered not by
>> an access from the core, but by internal memory controller access.
>>=20
>> This results in a different error signature (for an uncorrected error in=
jection
>> it will be a UCNA or SRAO in Intel acronym-speak).
>
> As far as I know, APEI only defines five injection instructions, ACPI_EIN=
J_READ_REGISTER,
> ACPI_EINJ_READ_REGISTER_VALUE, ACPI_EINJ_WRITE_REGISTER, ACPI_EINJ_WRITE_=
REGISTER_VALUE and
> ACPI_EINJ_NOOP. ACPI_EINJ_TRIGGER_ERROR action should run one of them, I =
don't see
> any of them will kick the patrol scrubber. For example, trigger with ACPI=
_EINJ_READ_REGISTER:
>
> apei_exec_run(&trigger_ctx, ACPI_EINJ_TRIGGER_ERROR)
>     __apei_exec_run	// ins=3D0
>         =3D> apei_exec_read_register
>             =3D> apei_read
>                 =3D> acpi_os_read_memory
>                     =3D> acpi_map_vaddr_lookup    /* lookup VA of PA from=
 acpi_ioremap */
>                     =3D> acpi_os_ioremap
> 		    =3D> acpi_os_read_iomem
> 			=3D> *(u32 *) value =3D readl(virt_addr);
>
> As we can see, the error is triggered by access from the core. However, t=
he physical
> address can NOT be mapped by acpi_os_ioremap.
>
> If I missed anything, please let me know. Thank you very much.

As the name suggested, ACPI_EINJ_READ/WRITE_REGISTER are used to
read/write device registers via iomem.  They aren't used to read/write
normal physical memory.  If that's needed, you can try some other method
I guess.

If you write a device register, the device can kick the patrol scrubber
for you.  This device behavior needs not to be defined in APEI spec.

Best Regards,
Huang, Ying

> Best Regards,
> Shuai
