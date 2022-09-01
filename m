Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7315A96A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiIAMXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiIAMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:23:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA6A11E80F;
        Thu,  1 Sep 2022 05:23:27 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MJKqN5Ty9z1N7kk;
        Thu,  1 Sep 2022 20:19:44 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 20:23:25 +0800
Subject: Re: [PATCH -next 0/4] spi: Introduce BPF based SPI mockup controller
To:     Mark Brown <broonie@kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <Yw5gSElhbYwoXrfw@sirena.org.uk>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <b9ed9b35-2992-b9f4-2e9c-f69c13d9dce3@huawei.com>
Date:   Thu, 1 Sep 2022 20:23:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Yw5gSElhbYwoXrfw@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/31 3:08, Mark Brown wrote:
> On Fri, Aug 26, 2022 at 02:43:37PM +0000, Wei Yongjun wrote:
>> This series Introduce a BPF based SPI mockup controller, which can be
>> used for testing SPI drivers without real device.
>>
>> The testsuite for SPI drivers will be post in other series, with also
>> support for I2C and PCI bus device drivers.
> 
> I replied to some of the individual patches here with some more
> detailed issues but I do have some big picture reservations with
> this approach as well.  One big one is that this seems like it's
> only going to be able to handle emulation of devices that are
> purely synchronous - I don't see any sensible direction here for
> extending to devices that need an interrupt line as well.  That
> seems like a major limitation.  It's fine not to immediately


We can use gpio-sim as the interrupt controller which always exists
with some tiny fix, I had posted them and can be found from link:

https://www.spinics.net/lists/linux-gpio/msg74949.html


> implement everything but it should be fairly clear how that would
> be done when someone needs it and some of the BPF design goals I
> understood seem to conflict with that.
> 
> I'm also not clear what the BPF environment is like when it comes
> to extensible frameworks, as soon as you start thinking about the
> problem space there are some obvious extensions with things like
> more detailed register map descriptions and validating that the
> operations that the driver is doing to the device are actually in
> spec for the device or trying to stimulate race conditions or
> error paths in the driver.


The bpftool in kernel still need some works, I am still working on
fix comments from maintainers, which can be found at:

https://lore.kernel.org/bpf/b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com/

> 
> There's also the issue with getting the BPF userspace tooling
> that I mentioned in reply to one of the individual patches.
> 
> Basically while this does look very simple from a kernel point of
> view I worry that BPF might not be the right tool for the job and
> could be a bit of a blind alley, with people rapidly running into
> issues trying to do anything non-trivial.
> 

Base on BPF's map, we can using wrap for read/write registers as
the device's requirement. And it is possible to control each register
and runtime.

For example, simple write data to MTD device, and check whether
the data is write to registers:

def test_write_data(self):
    with self.device() as dev:
         self.device_write_bytes(dev, [1, 2, 3, 4]) <- write to /dev/mtd
         data = self.read_regs(0x00, 4)
         self.assertEqual(data, [1, 2, 3, 4])

I am working on a light weight framework which just 400 loc's python
code, and can do similar tests to roadtest.

Once I finished the bpftool, I will post a proposal.

> There was a series in the past year or so from someone
> implementing a similarish idea but rather than using BPF they
> provided a framework for writing device emulations in qemu with
> a simplified Python framework.  That seemed like a more obvious
> direction here.  They were initially focusing on I2C but it's a
> similar space.  Unfortunately I'm drawing a blank on who was
> working on it or the name of the framework so I can't give a
> useful reference here.  Their direction was towards having
> something that could also be used to validate what the driver was
> doing to the device from the device's perspective.  I do know it
> was written up on LWN.  Hopefully someone else will remember what
> I'm talking about from this vauge description.
> 

I saw your other mail, and know you mean roatest, which is based on
virtio as the backend.

The bpf backend can be easily integrate to roadtest.


Regards,
Wei Yongjun
