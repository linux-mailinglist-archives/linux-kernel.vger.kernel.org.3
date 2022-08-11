Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C589158FDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiHKNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiHKNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:55:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76756EF04;
        Thu, 11 Aug 2022 06:55:09 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C5CC849C;
        Thu, 11 Aug 2022 15:55:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1660226107;
        bh=AtrBLll2eFcoFzuJIl6Q1JyFW8bQpIXJsYRVgMBcHH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cA322BuI+TIINDEFApyCmrmFVriiJRJLf0aS8NWXergBgIzvMf2yAOrJc98J/4/4k
         0B5lssJPasbHKMBQ3fv425lxihMABN91kgz7hkPYN1NKWB8xrmmFrXWYoi00WwGZ/a
         +Rqvi5oYloP2M2JcWc8EMe5FRqPwmIW7EHDVtAH0=
Date:   Thu, 11 Aug 2022 16:54:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Wang Yating <yating.wang@intel.com>,
        Christoph Jechlitschek <christoph.jechlitschek@intel.com>,
        Hao Yao <hao.yao@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        linux-media@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>,
        Dell.Client.Kernel@dell.com, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Whitcroft <apw@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Christian Schaller <cschalle@redhat.com>,
        Wouter Bolsterlee <wouter@bolsterl.ee>,
        Miguel Palhas <mpalhas@gmail.com>, it+linux-media@molgen.mpg.de
Subject: Re: Missing MIPI IPU6 camera driver for Intel Alder Lake laptops
Message-ID: <YvUKLbv/pOfbbeL+@pendragon.ideasonboard.com>
References: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52c87d91-422d-fca0-4dd5-bbaa559c81b6@molgen.mpg.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

(Adding myself on the CC list, to keep track of the discussion on behalf
of the libcamera project)

On Thu, Aug 11, 2022 at 10:23:26AM +0200, Paul Menzel wrote:
> [Cc: folks from IPU6 external driver, IPU3 maintainers, Dell, Lenovo, 
> Chromium, Canonical/Ubuntu, Red Hat]
> 
> Dear Greg,
> 
> 
> I am writing you, because I remember you – at least – were active 
> several years ago in getting good upstream driver support into the Linux 
> kernel.
> 
> It looks like the driver for the MIPI IPU6 camera of Intel Alder Lake 
> based laptops, for example, Lenovo ThinkPad X1 Carbon and Dell XPS 13 
> 9315/9320, is not in the upstream Linux kernel.
> 
> With Ubuntu’s OEM image pre-installed by Dell, and on Google Chromebooks 
> the camera is supposedly working [1]. There is a GitHub project with a 
> repository for the Linux kernel patches [2], but the patches – as 
> expected, and known from other external drivers, and Android drivers – 
> do not build against all Linux kernel versions [3]. A request to 
> upstream the drivers was opened at the end of March [4], and got the 
> reply below in July:
> 
> > Intel is not ready yet to provide technical support to various Linux
> > distro and all OEM devices at this moment with Intel IPU6 github.
> > 
> > Intel is supporting Dell laptop and their MIPI camera functionality
> > on Ubuntu with release/integration support from Canonical. If you are
> > using Dell devices, please refer to the devices listed in this link.
> > (https://wiki.ubuntu.com/Dell) You can learn the latest updates from
> > the installation guide.
> 
> The patches were integrated into ChromiumOS’ Linux kernel tree – for 
> specific version, like 5.15 [5], and the same for Ubuntu 22.04 with 
> Linux 5.15 – only in June [6]. A lot of that (redundant) work seems to 
> be done by the Intel developers involved also in the GitHub project.
> 
> In the last seven or so years Linux upstream driver support worked well 
> for me – especially with Intel hardware –, so I wanted to make you (and 
> others) aware of the situation, and hope, that you could do something 
> about the situation. With the current situation I can only recommend to 
> FLOSS users to *not* buy these devices.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS: The proprietary firmware is also not in the linux-firmware 
> repository [7], and the user space packages [8] are also not packaged 
> yet for some distributions like Debian.

A few more things to consider.

Support for the IPU6 on Ubuntu is very much of a stop-gap measure as far
as I can tell. As you correctly stated, the kernel drivers are not
upstream, and there is a long way to go before that can be fixed. The
drivers use a vendor-specific userspace API and are thus not fit for
upstream as-is. They will need to be rewritten to use either the V4L2
API (the only existing camera API upstream at this point), or a new
kernel API will need to be developed and upstreamed should V4L2 deemed
to be unsuitable. I can't comment on whether V4L2 would be a good
option, as I'm not aware of the detailed architecture of the device, but
I've heard it's significantly more complex than its predecessor, the
IPU3 found in selected Sky Lake and Kaby Lake SoCs (I'm pretending here
not to have heard of the IPU4).

On the userspace side, the stack is based on proprietary software, with
a userspace daemon and a V4L2 loopback driver to emulate the V4L2 API.
This complex architecture is due to the fact that this kind of device
requires complex imaging algorithms running in userspace, and a pure
V4L2 camera stack has no support for this. This isn't specific to the
IPU6, the IPU3 has similar requirements, and so do lots of embedded
SoCs. Given the direction the industry is taking, this situation will
become increasingly common in the future. With the notable exception of
Raspberry Pi who is leading the way in open-source camera support, no
SoC vendor is willing today to open their imaging algorithms. The issue
will thus not be solved simply by packaging the userspace software
provided by Intel for Ubuntu in other distributions, it will never make
it into pure FLOSS distributions, and is unmaintainable by the
community.

For a piece of good news, this is a problem we have been aware of for
years, which led to the creation of the libcamera project ([10]).
libcamera is an open-source userspace camera framework for Linux that
aims at supporting this exact type of hardware architecture. It already
supports the Intel IPU3, both on machines that have been designed for
Chrome OS and for Windows (sparing you the details, the latter describe
the camera hardware in their ACPI tables in a very different way than
the former, making them much more difficult to support). We have
integrated, as a proof of concept, the IPU3 closed-source imaging
libraries from Intel with libcamera ([11]), and have also developed a
fully open-source implementation ([12]). The open-source version is not
as feature-complete as the closed-source library, but it showcases how
both options are viable, and quite importantly, how multiple actors can
collaborate on open-source implementations of camera algorithms (the
auto-focus support for the IPU3 has been developed and contributed to
libcamera by Kate Hsuan from Red Hat for instance).

Now, the question is how we can get IPU6 support in libcamera. The first
problem to fix will be the availability of kernel drivers. Given the
issues listed above, this will require a large effort and a clear
commitment from vendors to happen. I wouldn't bet on a solution being
available before at least several years.

For the time being, I agree with your recommendation to not buy these
devices if you care about camera support.

[10] https://libcamera.org
[11] https://git.libcamera.org/libcamera/ipu3-ipa.git/
[12] https://git.libcamera.org/libcamera/libcamera.git/tree/src/ipa/ipu3

> PPS: VA-API support also does not work [9].
> 
> [1]: https://ubuntu.com/certified/202203-30070
> [2]: https://github.com/intel/ipu6-drivers
> [3]: https://github.com/intel/ipu6-drivers/issues/13
> [4]: https://github.com/intel/ipu6-drivers/issues/22
> [5]: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3034663
> [6]: https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/log/drivers/media/pci/intel
> [7]: https://bugs.launchpad.net/ubuntu/+source/linux-firmware/+bug/1955383
> [8]: https://launchpad.net/~oem-solutions-group/+archive/ubuntu/intel-ipu6/+packages
> [9]: https://github.com/intel/media-driver/issues/1371

> $ lspci -nn
> 00:00.0 Host bridge [0600]: Intel Corporation Device [8086:4602] (rev 06)
> 00:02.0 VGA compatible controller [0300]: Intel Corporation Alder Lake-UP4 GT2 [Iris Xe Graphics] [8086:46aa] (rev 0c)
> 00:04.0 Signal processing controller [1180]: Intel Corporation Alder Lake Innovation Platform Framework Processor Participant [8086:461d] (rev 06)
> 00:05.0 Multimedia controller [0480]: Intel Corporation Device [8086:465d] (rev 06)
> 00:06.0 PCI bridge [0604]: Intel Corporation 12th Gen Core Processor PCI Express x4 Controller #0 [8086:464d] (rev 06)
> 00:07.0 PCI bridge [0604]: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express Root Port #0 [8086:466e] (rev 06)
> 00:07.1 PCI bridge [0604]: Intel Corporation Alder Lake-P Thunderbolt 4 PCI Express Root Port #1 [8086:463f] (rev 06)
> 00:08.0 System peripheral [0880]: Intel Corporation 12th Gen Core Processor Gaussian & Neural Accelerator [8086:464f] (rev 06)
> 00:0d.0 USB controller [0c03]: Intel Corporation Alder Lake-P Thunderbolt 4 USB Controller [8086:461e] (rev 06)
> 00:0d.2 USB controller [0c03]: Intel Corporation Alder Lake-P Thunderbolt 4 NHI #0 [8086:463e] (rev 06)
> 00:12.0 Serial controller [0700]: Intel Corporation Device [8086:51fc] (rev 01)
> 00:14.0 USB controller [0c03]: Intel Corporation Alder Lake PCH USB 3.2 xHCI Host Controller [8086:51ed] (rev 01)
> 00:14.2 RAM memory [0500]: Intel Corporation Alder Lake PCH Shared SRAM [8086:51ef] (rev 01)
> 00:14.3 Network controller [0280]: Intel Corporation Alder Lake-P PCH CNVi WiFi [8086:51f0] (rev 01)
> 00:15.0 Serial bus controller [0c80]: Intel Corporation Alder Lake PCH Serial IO I2C Controller #0 [8086:51e8] (rev 01)
> 00:15.1 Serial bus controller [0c80]: Intel Corporation Alder Lake PCH Serial IO I2C Controller #1 [8086:51e9] (rev 01)
> 00:16.0 Communication controller [0780]: Intel Corporation Alder Lake PCH HECI Controller [8086:51e0] (rev 01)
> 00:1e.0 Communication controller [0780]: Intel Corporation Alder Lake PCH UART #0 [8086:51a8] (rev 01)
> 00:1e.2 Serial bus controller [0c80]: Intel Corporation Device [8086:51aa] (rev 01)
> 00:1e.3 Serial bus controller [0c80]: Intel Corporation Device [8086:51ab] (rev 01)
> 00:1f.0 ISA bridge [0601]: Intel Corporation Device [8086:5187] (rev 01)
> 00:1f.3 Multimedia audio controller [0401]: Intel Corporation Device [8086:51cc] (rev 01)
> 00:1f.4 SMBus [0c05]: Intel Corporation Alder Lake PCH-P SMBus Host Controller [8086:51a3] (rev 01)
> 00:1f.5 Serial bus controller [0c80]: Intel Corporation Alder Lake-P PCH SPI Controller [8086:51a4] (rev 01)
> 01:00.0 Non-Volatile memory controller [0108]: Phison Electronics Corporation Device [1987:5019] (rev 01)


-- 
Regards,

Laurent Pinchart
