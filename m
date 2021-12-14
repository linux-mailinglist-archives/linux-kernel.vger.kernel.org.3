Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF5B473DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 08:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhLNHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 02:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhLNHsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 02:48:13 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F38AC061574;
        Mon, 13 Dec 2021 23:48:12 -0800 (PST)
Received: from [IPv6:2a00:c281:1276:dc00:2d23:3482:5e76:1917] (unknown [IPv6:2a00:c281:1276:dc00:2d23:3482:5e76:1917])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2FF1F1F44D4A;
        Tue, 14 Dec 2021 07:48:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639468090; bh=mzF7DDJC3cGDqz7hyNGX5SQVyrSCt20CyCZlVxgKA4g=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=agnkmvPM3CLrADMDtdtFz1mFpRmLY3tPoNXjoJAxFReez2AZ22CSP2B9ze6LV7XIA
         H12WnJhbdIph8vpc8WRlirat0OEXlNXZfS16/L4aFEELHmQCReKX1RPyiTneLfwsJk
         LenkSeo+HATLdR2Fge9zvPS9XgJjcgMdFuCX4chI/0M/A6PbIXAaBIItAMNCZYvQrj
         iYKU6sM2N2xlAgzabS61fqjYQk50+Y4iIBDoe5ry+v7JRxvNPUBHAPKPvsLpwfUih9
         p/b9aEcWVDc8SDSlMPiBhiFAgXgPma/5dr2RwoOKt6KwP61oAsswZhikTBowmhMnzt
         iV27upxdOQ5gQ==
Subject: Re: [PATCH v4 1/6] staging: media: wave5: Add vpuapi layer
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        Randy Dunlap <rdunlap@infradead.org>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
 <20211201175613.13710-2-dafna.hirschfeld@collabora.com>
 <CAFr9PX=6Pd1Rg=wJvpuX6WX63L=iAnwPA24e59An3Kac5f_vzA@mail.gmail.com>
 <cdd9b485-364f-c6bd-776f-a0ca2d260762@collabora.com>
Message-ID: <e9905774-a994-6311-7b53-b40588d4f6ec@collabora.com>
Date:   Tue, 14 Dec 2021 09:48:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cdd9b485-364f-c6bd-776f-a0ca2d260762@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.12.21 07:33, Dafna Hirschfeld wrote:
> 
> 
> On 04.12.21 15:43, Daniel Palmer wrote:
>> Hi Dafna,
>>
>> Sorry for the piecemeal emails..
>>
>> On Thu, 2 Dec 2021 at 02:56, Dafna Hirschfeld
>> <dafna.hirschfeld@collabora.com> wrote:
>>> diff --git a/drivers/staging/media/wave5/wave5-hw.c b/drivers/staging/media/wave5/wave5-hw.c
>>
>> ... snip ...
>>
>>> +static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
>>> +{
>>> +       u32 gdi_status_check_value = 0x3f;
>>> +       u32 data;
>>> +
>>> +       if (vpu_dev->product_code == WAVE521C_CODE ||
>>> +           vpu_dev->product_code == WAVE521_CODE ||
>>> +        vpu_dev->product_code == WAVE521E1_CODE)
>>> +               gdi_status_check_value = 0x00ff1f3f;
>>> +
>>> +       return read_poll_timeout(wave5_vdi_read_register, data, data == gdi_status_check_value,
>>> +                                0, timeout * 1000, false, vpu_dev, addr);
>>> +}
>>> +
>>
>> This looks like it should be s/wave5_vdi_read_register/wave5_read_register/.
>> For wave511 addr passed in here is 0x8e14 so well outside of what is
>> directly accessible.
> 
> Hi, I didn't understand this explanation. I see that
> wave5_read_register eventually calls 'wave5_vdi_read_register'.
> Could you please explain in more detail why you think
> calling wave5_vdi_read_register is wrong?

hi, I see know that those backbone address are indeed not read and written directly but
the address should be first written to a regsiter W5_VPU_FIO_CTRL_ADDR,
and then the content is returned from W5_VPU_FIO_DATA.

I'll fix it on v5

Thanks,
Dafna

> 
> Actually the name 'wave5_read_register' is a bad name for that
> func since it eventually return the value of the W5_VPU_FIO_DATA
> register upon success and not the address sent to it.
> 
> 
>>
>> Also it seems that this can either return 0 or -ETIMEDOUT...
>>
>> ... snip ...
>>
>>> +int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode)
>>> +{
>>> +       u32 val = 0;
>>> +       int ret = 0;
>>> +       struct vpu_device *vpu_dev = dev_get_drvdata(dev);
>>> +       struct vpu_attr *p_attr = &vpu_dev->attr;
>>> +       // VPU doesn't send response. force to set BUSY flag to 0.
>>> +       vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 0);
>>> +
>>> +       if (reset_mode == SW_RESET_SAFETY) {
>>> +               ret = wave5_vpu_sleep_wake(dev, true, NULL, 0);
>>> +               if (ret)
>>> +                       return ret;
>>> +       }
>>> +
>>> +       val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
>>> +       if ((val >> 16) & 0x1)
>>> +               p_attr->support_backbone = true;
>>> +       if ((val >> 22) & 0x1)
>>> +               p_attr->support_vcore_backbone = true;
>>> +       if ((val >> 28) & 0x1)
>>> +               p_attr->support_vcpu_backbone = true;
>>> +
>>> +       val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG1);
>>> +       if ((val >> 26) & 0x1)
>>> +               p_attr->support_dual_core = true;
>>> +
>>> +       // waiting for completion of bus transaction
>>> +       if (p_attr->support_backbone) {
>>> +               if (p_attr->support_dual_core) {
>>> +                       // check CORE0
>>> +                       wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
>>> +
>>> +                       ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
>>> +                                                 W5_BACKBONE_BUS_STATUS_VCORE0);
>>> +                       if (ret) {
>>> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
>>> +                               return ret;
>>> +                       }
>>> +
>>> +                       // check CORE1
>>> +                       wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x7);
>>> +
>>> +                       ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
>>> +                                                 W5_BACKBONE_BUS_STATUS_VCORE1);
>>> +                       if (ret) {
>>> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x00);
>>> +                               return ret;
>>> +                       }
>>> +
>>> +               } else if (p_attr->support_vcore_backbone) {
>>> +                       if (p_attr->support_vcpu_backbone) {
>>> +                               // step1 : disable request
>>> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU,
>>> +                                                    0xFF);
>>> +
>>> +                               // step2 : waiting for completion of bus transaction
>>> +                               ret = wave5_wait_vcpu_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
>>> +                                                              W5_BACKBONE_BUS_STATUS_VCPU);
>>> +                               if (ret) {
>>> +                                       wave5_write_register(vpu_dev,
>>> +                                                            W5_BACKBONE_BUS_CTRL_VCPU, 0x00);
>>> +                                       return ret;
>>> +                               }
>>> +                       }
>>> +                       // step1 : disable request
>>> +                       wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
>>> +
>>> +                       // step2 : waiting for completion of bus transaction
>>> +                       if (wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
>>> +                                               W5_BACKBONE_BUS_STATUS_VCORE0) == -1) {
>>> +                               wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
>>> +                               return -EBUSY;
>>> +                       }
>>
>> but this is looking for -1 on failure.
> 
> right, thanks for finding this, I see that wave5_read_register return -1 on failure so maybe
> this is the source of the confusion.
> 
> Thanks,
> Dafna
> 
>>
>>> +               } else {
>>> +                       // step1 : disable request
>>> +                       wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x7);
>>> +
>>> +                       // step2 : waiting for completion of bus transaction
>>> +                       if (wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
>>> +                                               W5_COMBINED_BACKBONE_BUS_STATUS) == -1) {
>>> +                               wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x00);
>>> +                               return -EBUSY;
>>> +                       }
>>> +               }
>>
>> Here too.
>>
>> Cheers,
>>
>> Daniel
>>
> 
