Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C02A4735DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbhLMU1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:27:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42510 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbhLMU1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:27:07 -0500
Received: from [IPv6:2a00:c281:1276:dc00:2d23:3482:5e76:1917] (unknown [IPv6:2a00:c281:1276:dc00:2d23:3482:5e76:1917])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 125EA1F4441D;
        Mon, 13 Dec 2021 20:27:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639427225; bh=wB80XAQrujm7o6G/mYQfgxxJ4rJXLU1g58F+Re9c0m0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WJ45my+s63TDKntL2k8ejSBu7AHluUCLHoOYsDdYYZkLUtsEnQuUHndPjMYO+AUcJ
         G0RGZ+VNJ6IuqRC1mLohcviWtpec9jbWHk5kxbJamw6fyA9mmld8XPrrc9HtXpG9HT
         lWBjueaggTvF05nbLUes68mKtkbFuSclLApD8R7MSh6d+nY16HBStFI2bMJZ7XkAs1
         trIlnjni+intxxLNArC6oPXuwON7t/fKF9ei0DG1KMlGHCITU1MZ1JPaIQnTuvobsZ
         YzVJOi1RW7TAeHPi2sZ+9TZ7pHiWobRRvh2v+xKh2twEhTW0KQ/N55k+2FeisWNbn9
         HU+1rbYXDHAWw==
Subject: Re: [PATCH v4 0/6] staging: media: wave5: add wave5 codec driver
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        Robert Beckett <bob.beckett@collabora.com>,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
 <CAFr9PXnvbqtx-SpxjyO2uvoBR3ueNBD9vSFnbqjbAHz_7Lh8VA@mail.gmail.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <02a9c780-49e0-7a61-4443-7825d6a1271e@collabora.com>
Date:   Mon, 13 Dec 2021 22:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAFr9PXnvbqtx-SpxjyO2uvoBR3ueNBD9vSFnbqjbAHz_7Lh8VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.12.21 12:11, Daniel Palmer wrote:
> Hi Dafna,
> 
> On Thu, 2 Dec 2021 at 02:56, Dafna Hirschfeld
> <dafna.hirschfeld@collabora.com> wrote:
>> Testing on BeagleV shows buffer corruption that is currently attributed to a
>> known silicon issue in the SoC that makes the cache coherent interconnect not
>> so coherent.
> 
> Maybe it's mentioned somewhere else and I missed it but would it be
> possible to tell me which version of the IP is in the BeagleV chip?
> The reason I ask is I'm trying to get this going on the SigmaStar
> SSD202D which seems to have the "Wave 511".
> I can see the firmware binary get uploaded and it seems to do
> something as the register that exposes the vcpu program counter is
> doing something (and the addresses look the same as the addresses seem
> when the working vendor kernel + binary .ko are running so I think
> it's not just running garbage).
> 
> I'm wondering if the BeagleV is a different version and the driver
> just won't work as is on mine or maybe the firmware I have has hacks
> for the vendors version of the driver which I don't have source for.

Hi, thank you for trying this out. The versions I see on the Beaglv are 511 for the
decoder and 521c for the encoder.
This driver is also based on a vendor driver from cnm: https://gitlab.collabora.com/chipsnmedia/wave5-driver
Also, a patch to add the firmware was also sent to linux-firmware ml https://lore.kernel.org/linux-firmware/20211126093014.1385752-1-nas.chung@chipsnmedia.com/T/

Thanks,
Dafna

> 
> Thanks,
> 
> Daniel
> 
