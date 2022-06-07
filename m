Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6401F53F309
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 02:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiFGAmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 20:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiFGAma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 20:42:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432212091
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654562547; x=1686098547;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m0+yNmbRCrj0YqAb+g4pMS//ee70PjjqC+xkF3LUVJ8=;
  b=g83x/zCzHS8OiNnkxT9jrrTMPIdaW1lrj3wcWNqsSb168aB8K0yIBcVj
   TX1AY3HHM/+mFIJaiuu2Rguuffz/Ok5balhDO0Nk/xWqFLwGfH6gXDybL
   IFpW0hS4k4T40LQmdxptPENSC6GednqGZsX6fn+ccOl75eGeapJsnVWy0
   OQ76zIvBDhZ3rN4E0OyQyLjajIUer4KblrnVHhfwdwa2UJvThthjoc9UX
   YuoXIaxF0rDbicX6KkKuIYXHWfjGvN8/m/vWUyhRpEJeiKRqn+t375ZEQ
   1vcQuzHcNgodivnnUsmFXzyXWTreJB0dlOVDn94APtKG0JPdvJkvMIp9m
   g==;
X-IronPort-AV: E=Sophos;i="5.91,282,1647273600"; 
   d="scan'208";a="314473091"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 08:42:26 +0800
IronPort-SDR: Z0cQldfI4hvPrS8jXVdeYzbuKe2MEoUBcfo7vWwtz69Oc2nbygsbgqnxaXJQaQqPm0cw09MGxx
 bkFVlHO98BT7OTpm4AleReB0RSeAJhEEPUcN3Rl5Idgbsw9BmuzSZYVWQqlSKVn6N0NiKdj/V+
 odEzfi2y3Q7mgm0Ia2uxbESnUOelXCxqg15aGSxPR6c/c88wGLE6mVvPDU+c2GN02D5xHN//Ef
 CZ5f1kgh/dB4RQi+Rq/G5Y9OC6ECgnMHgOLjyFdUckVAp5VtQ3AgO5RaWrgKIkFkRFrpEwIoOc
 VFXe1VX1tIdfdtt6cYSxdjda
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 17:01:22 -0700
IronPort-SDR: +HlS3DEebCCQFXhLTnXSHlPbs7NMqdgFg16LjREpf7ODNMniOJwrCPIaf7ZGBdgtfUQg0/ZoKf
 4+IrcRptwt76uIyfvmgZqJKfXXAHu8g3Fdlz4WW0DR5qFANmRYopICMz8u1j4sYUlBJQMU8u57
 0ysOm+XlCqSUUzIvjn5JhHsO5Lwvhf6fpDc37U9yU2zmWPVvGWYM2ycCQY+FdXsLNHScmduTCY
 796RPUHI8Yu9nwpklg3euwRDFl48bGm93ChfTi1ucqUmzxzs76gl6gctEtN/iBPkn63Znwyq/V
 jjk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2022 17:42:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LHBQT5Bqsz1SVny
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 17:42:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1654562545; x=1657154546; bh=m0+yNmbRCrj0YqAb+g4pMS//ee70PjjqC+x
        kF3LUVJ8=; b=P8bVub+2f7qdroJGi/5ooCZ30Z96wVX8F54pMY46jyJzN9aoZ58
        gNMlYONodwRr44zrD6O4NqelybGorqPmQeb233jvZDVSCPTLcFzYCf4RpmHyx+ih
        imnKOZudKBffoaFnUCsDpNGyPEWQtqKsiPqyuTx4AIgRi9njTMtCGR3LtHLjw4dy
        wCtQjQaO8NaIrfH9O2DkR4wyZ0g3luQsDZ3NWwdb16t8b1VRntXJEIixTmE1YqhE
        ed/n6uOQk9dL3c2y2aMVk8gAqJsVrbs84STSAjCG5wTkaIvUUdEt7enmGS0K889R
        nCGHFvJJ+dL6EWWivIIHVdZfgPuzWUGpmmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EMMogn6h60hW for <linux-kernel@vger.kernel.org>;
        Mon,  6 Jun 2022 17:42:25 -0700 (PDT)
Received: from [10.89.82.246] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.82.246])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LHBQQ2Gqcz1Rvlc;
        Mon,  6 Jun 2022 17:42:22 -0700 (PDT)
Message-ID: <84bb2d37-4097-5122-7e88-33bd9bc7ed61@opensource.wdc.com>
Date:   Tue, 7 Jun 2022 09:42:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH] scsi: ufs: sysfs: support writing boot_lun attr
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        "a5b6@riseup.net" <a5b6@riseup.net>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "~postmarketos/upstreaming@lists.sr.ht" 
        <~postmarketos/upstreaming@lists.sr.ht>,
        "phone-devel@vger.kernel.org" <phone-devel@vger.kernel.org>
References: <20220525164013.93748-1-a5b6@riseup.net>
 <DM6PR04MB65750969ACD36EEEB48374DFFCD69@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8d25171a-5d86-9acc-0f94-1a3c6efdb360@riseup.net>
 <DM6PR04MB65752422396C86EAD4591701FCD89@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a7f46ad1-6d9e-a38e-31cc-29fddfa2b496@linaro.org>
 <DM6PR04MB65751A3B1D0BA4467CADDA93FCDF9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <a4746c67-fa74-8af1-3f2d-7853e9fae8a6@acm.org>
 <3c400db6-d251-c4bd-b019-b9dc1d807212@opensource.wdc.com>
 <2677b02e-b2a3-7c79-2e62-acf1acbc8ff0@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <2677b02e-b2a3-7c79-2e62-acf1acbc8ff0@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/06/06 22:16, Bart Van Assche wrote:
> On 6/5/22 19:48, Damien Le Moal wrote:
>> On 6/5/22 12:55, Bart Van Assche wrote:
>>> On 6/1/22 10:05, Avri Altman wrote:
>>>> As a design rule, sysfs attribute files should not be used to make
>>>> persistent modifications to a device configuration. This rule applies
>>>> to all subsystems and ufs is no different.
>>>
>>> Hmm ... where does that rule come from? I can't find it in
>>> Documentation/admin-guide/sysfs-rules.rst. Did I perhaps overlook something?
>>
>> I am not aware of any writable sysfs attribute file that can be used to
>> make persistent device configuration changes, at least in storage area.
>> I know of plenty that do change a device setting, but without saving this
>> setting to maintain it across power cycles. Do you know of any such
>> attribute ? I was under the impression that sysfs should not be used to
>> persistently reconfigure a device...
> 
> I don't think the above is sufficient as an argument to reject a new 
> patch that introduces a sysfs attribute that changes the device 
> configuration.

It depends if we can guarantee that the write access to the sysfs file is done
with the same security checks as for a passthrough command issued from user
space. I have not checked.

I would also argue that this particular feature is related to the boot device
management, which is not something we do in the kernel. There is no sysfs
interface to set the bootable flag of a partition on a disk, right ? That is
very similar to me. The kernel should not bother about that kind of interface.
User application tools can deal with that.

> 
> Thanks,
> 
> Bart.
> 


-- 
Damien Le Moal
Western Digital Research
