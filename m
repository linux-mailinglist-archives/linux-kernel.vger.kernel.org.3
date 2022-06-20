Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4305512BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiFTI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238753AbiFTI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:28:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D02C30C;
        Mon, 20 Jun 2022 01:28:06 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRN5t0C0KzkWTG;
        Mon, 20 Jun 2022 16:26:26 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 16:27:51 +0800
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 16:27:51 +0800
Subject: Re: [PATCH -next] serial: 8250: fix return error code in
 serial8250_request_std_resource()
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, <andy.shevchenko@gmail.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220620072025.172088-1-yiyang13@huawei.com>
 <fe25cbe3-3cc3-45c3-d6d0-e867ee372b7@linux.intel.com>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <424102a6-1f2a-fc18-b1b4-89e00797db26@huawei.com>
Date:   Mon, 20 Jun 2022 16:27:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fe25cbe3-3cc3-45c3-d6d0-e867ee372b7@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/20 15:53, Ilpo Järvinen wrote:
> On Mon, 20 Jun 2022, Yi Yang wrote:
> 
>> If port->mapbase = NULL in serial8250_request_std_resource() , it need
>> return a error code instead of 0. If uart_set_info() fail to request new
>> regions by serial8250_request_std_resource() but the return value of
>> serial8250_request_std_resource() is 0, that The system will mistakenly
>> considers that port resources are successfully applied for. A null
>> pointer reference is triggered when the port resource is later invoked.
>>
>> The problem can also be triggered with the following simple program:
>> ----------
>>    #include <stdio.h>
>>    #include <sys/types.h>
>>    #include <sys/stat.h>
>>    #include <fcntl.h>
>>    #include <sys/ioctl.h>
>>    #include <unistd.h>
>>    #include <errno.h>
>>
>>    struct serial_struct {
>>        int type;
>>        int line;
>>        unsigned int    port;
>>        int irq;
>>        int flags;
>>        int xmit_fifo_size;
>>        int custom_divisor;
>>        int baud_base;
>>        unsigned short  close_delay;
>>        char    io_type;
>>        char    reserved_char[1];
>>        int hub6;
>>        unsigned short  closing_wait; /* time to wait before closing */
>>        unsigned short  closing_wait2; /* no longer used... */
>>        unsigned char   *iomem_base;
>>        unsigned short  iomem_reg_shift;
>>        unsigned int    port_high;
>>        unsigned long   iomap_base; /* cookie passed into ioremap */
>>    };
>>
>>    struct serial_struct str;
>>
>>    int main(void)
>>    {
>>        open("/dev/ttyS0", O_RDWR);
>>        ioctl(fd, TIOCGSERIAL, &str);
>>        str.iomem_base = 0;
>>        ioctl(fd, TIOCSSERIAL, str);
>>        return 0;
>>    }
> 
> With admin priviledges I guess?
> 
Yes, this program run on root.
>> ----------
>>
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>>   drivers/tty/serial/8250/8250_port.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
>> index 3e3d784aa628..e1cefa97bdeb 100644
>> --- a/drivers/tty/serial/8250/8250_port.c
>> +++ b/drivers/tty/serial/8250/8250_port.c
>> @@ -2961,8 +2961,10 @@ static int serial8250_request_std_resource(struct uart_8250_port *up)
>>   	case UPIO_MEM32BE:
>>   	case UPIO_MEM16:
>>   	case UPIO_MEM:
>> -		if (!port->mapbase)
>> +		if (!port->mapbase) {
>> +			ret = -EFAULT;
>>   			break;
>> +		}
>>   
>>   		if (!request_mem_region(port->mapbase, size, "serial")) {
>>   			ret = -EBUSY;
>>
> 
> I recall reading somewhere that somebody more knowledgeful than me noted
> that this interface has many ways to shoot oneself in the foot if one
> really wants to which is why some things are limited to admin only.
> I cannot seem to find that a reference to that now though.
> 
Maybe some inadvertent behavior can be avoided.

The following code exists in uart_set_info():

If we fail to request resources for the new port, try to restore the old 
settings. But uport->ops->release_port(uport) return value is 0.
----------
         /*
          * Free and release old regions
          */
         if (old_type != PORT_UNKNOWN && uport->ops->release_port)
             uport->ops->release_port(uport);

         uport->iobase = new_port;
         uport->type = new_info->type;
         uport->hub6 = new_info->hub6;
         uport->iotype = new_info->io_type;
         uport->regshift = new_info->iomem_reg_shift;
         uport->mapbase = (unsigned long)new_info->iomem_base;

         /*
          * Claim and map the new regions
          */
         if (uport->type != PORT_UNKNOWN && uport->ops->request_port) {
             retval = uport->ops->request_port(uport);
         } else {
             /* Always success - Jean II */
             retval = 0;
         }

         /*
          * If we fail to request resources for the
          * new port, try to restore the old settings.
          */
         if (retval) {
             uport->iobase = old_iobase;
             uport->type = old_type;
             uport->hub6 = old_hub6;
             uport->iotype = old_iotype;
             uport->regshift = old_shift;
             uport->mapbase = old_mapbase;

             if (old_type != PORT_UNKNOWN) {
                 retval = uport->ops->request_port(uport);
                 /*
                  * If we failed to restore the old settings,
                  * we fail like this.
                  */
                 if (retval)
                     uport->type = PORT_UNKNOWN;

                 /*
                  * We failed anyway.
                  */
                 retval = -EBUSY;
             }
----------

-- 
Yi
